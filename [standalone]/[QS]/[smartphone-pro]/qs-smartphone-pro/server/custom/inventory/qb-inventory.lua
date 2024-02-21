if Config.Inventory ~= 'qb-inventory' then
    return
end

function GetUserData(identifier)
    local str = ([[
        SELECT charinfo FROM players WHERE citizenid = ?
    ]])
    local result = MySQL.Sync.fetchAll(str, {
        identifier
    })
    if not result[1] then return false end
    local charinfo = json.decode(result[1].charinfo)
    return charinfo.firstname, charinfo.lastname, charinfo.phone
end

function SaveMetadataToInventory(src)
    local player = GetPlayerFromId(src)
    local items = GetItems(player)
    if not items then return end
    local phone = MetaData[src].phoneNumber
    for k, v in pairs(items) do
        local meta = v.info and v.info or v.metadata
        if meta.phoneNumber == phone and PhoneIsUseable(meta.uniqueId) then
            if v.info then
                v.info = MetaData[src]
            else
                v.metadata = MetaData[src]
            end
            break
        end
    end
    player.Functions.SetInventory(items)
end

local usedPhone = {} -- This fix for the laggy phone
function RegisterItems()
    for k, v in pairs(Config.Phones) do
        RegisterUsableItem(k, function(source, item)
            local time = os.time()
            if usedPhone[source] and usedPhone[source] > time then return end
            usedPhone[source] = time + 2
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
