if Config.Inventory ~= 'qs-inventory' then
    return
end

QSInventory = exports['qs-inventory']
ItemList = exports['qs-inventory']:GetItemList()

function GetUserData(identifier)
    local str = ([[
        SELECT %s FROM %s WHERE %s = ?
    ]]):format(Config.Framework == 'esx' and 'firstname, lastname, phone_number' or 'charinfo', userColumn, identifierTable)
    local result = MySQL.Sync.fetchAll(str, {
        identifier
    })
    result = result[1]
    if not result then return false end
    local firstname, lastname, phone
    if Config.Framework == 'esx' then
        firstname = result.firstname
        lastname = result.lastname
        phone = result.phone_number
    elseif Config.Framework == 'qb' then
        local data = json.decode(result.charinfo)
        firstname = data.firstname
        lastname = data.lastname
        phone = data.phone
    end
    if not phone and Config.Framework == 'esx' then
        phone = Config.Prefix .. math.random(StartDigit, FinishDigit)
        MySQL.Sync.execute('UPDATE `users` SET `phone_number` = ? WHERE `identifier` = ?', {
            phone,
            identifier
        })
    end
    return firstname, lastname, phone
end

function SaveMetadataToInventory(src)
    local player = GetPlayerFromId(src)
    local items = GetItems(player)
    local slot = 0
    if not items then return Debug('Save metadata to inventory failed. items is nil', 'Player src:', src) end
    local phone = MetaData[src].phoneNumber
    for k, v in pairs(items) do
        local meta = v.info and v.info or v.metadata
        if meta.phoneNumber == phone and PhoneIsUseable(meta.uniqueId) then
            slot = v.slot
            break
        end
    end
    QSInventory:SetItemMetadata(src, slot, MetaData[src])
end

function RegisterItems()
    if Config.Framework == 'esx' then
        for k, v in pairs(Config.Phones) do
            RegisterUsableItem(k, function(source, item)
                local player = GetPlayerFromId(source)
                if not item?.info or not item?.info?.phoneNumber then
                    local result = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = ?', {
                        player.identifier
                    })
                    result = result[1]
                    local info = CreatePhoneMetaData({
                        firstname = result.firstname,
                        lastname = result.lastname,
                        identifier = player.identifier,
                    })
                    item.info = info
                    QSInventory:SetItemMetadata(source, item.slot, info)
                    Debug('Created phone meta')
                end
                TriggerClientEvent('phone:openPhone', source, v, k, item.info)
            end)
        end
    elseif Config.Framework == 'qb' then
        for k, v in pairs(Config.Phones) do
            RegisterUsableItem(k, function(source, item)
                local player = GetPlayerFromId(source)
                if not item?.info or not item?.info?.phoneNumber then
                    local info = CreatePhoneMetaData({
                        firstname = player.PlayerData.charinfo.firstname,
                        lastname = player.PlayerData.charinfo.lastname,
                        identifier = player.PlayerData.citizenid
                    })
                    player.PlayerData.items[item.slot].info.metadata = info.metadata
                    player.PlayerData.items[item.slot].info.charinfo = info.charinfo
                    player.PlayerData.items[item.slot].info.phoneNumber = info.phoneNumber
                    player.PlayerData.items[item.slot].info.owneridentifier = info.owneridentifier
                    player.Functions.SetInventory(player.PlayerData.items)
                    item.info = player.PlayerData.items[item.slot].info
                end
                TriggerClientEvent('phone:openPhone', source, v, k, item.info)
            end)
        end
    end
end

exports('handleDeleteItem', function(source, itemData)
    if itemData then
        local metaPhone = MetaData[source]?.phoneNumber
        local itemIsPhone = ItemIsPhone(itemData.name)
        if not itemIsPhone then return end
        local itemPhoneNumber = itemData.info.phoneNumber
        if metaPhone and itemPhoneNumber and itemPhoneNumber == metaPhone then
            MetaData[source] = nil
            TriggerClientEvent('phone:UpdatedMeta', source, nil)
            Debug('Cleared metadata. for: ' .. source)
        end
    else
        local metaPhone = MetaData[source]?.phoneNumber
        local existPhone = FindUserExistPhone(source, metaPhone)
        if not existPhone then
            MetaData[source] = nil
            TriggerClientEvent('phone:UpdatedMeta', source, nil)
            Debug('Cleared metadata. for: ' .. source)
        end
    end
end)
