if Config.Inventory ~= 'codem-inventory' then
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

function UpdatePhoneMetadata(src, key, value, isCharinfo)
    if not MetaData[src] then return end
    if key then
        if isCharinfo then
            MetaData[src].charinfo[key] = value
        else
            MetaData[src].metadata[key] = value
        end
    end
    if not Config.UniquePhone then
        local identifier = GetIdentifier(src)
        MySQL.Sync.execute('UPDATE phone_metadata SET metadata = ? WHERE identifier = ?', {
            json.encode(MetaData[src]),
            identifier,
        })
        TriggerClientEvent('phone:UpdatedMeta', src, MetaData[src])
        return
    end
    local player = GetPlayerFromId(src)
    local items = GetItems(player)
    local slot = 0
    if not items then return end
    local phone = key and MetaData[src].phoneNumber or value
    for k, v in pairs(items) do
        local meta = v.info
        if meta[1].phoneNumber == phone and PhoneIsUseable(meta[1].uniqueId) then
            slot = v.slot
            if v.info[1] then
                v.info[1] = MetaData[src]
            end
            break
        end
    end
    player.Functions.SetInventory(items)
    TriggerClientEvent('phone:UpdatedMeta', src, MetaData[src])
end

local usedPhone = {} -- This fix for the laggy phone
function RegisterItems()
    for k, v in pairs(Config.Phones) do
        RegisterUsableItem(k, function(source, item)
            local time = os.time()
            if usedPhone[source] and usedPhone[source] > time then return end
            usedPhone[source] = time + 2
            local player = GetPlayerFromId(source)
            if not item.info or not item.info[1].phoneNumber then
                local info = CreatePhoneMetaData({
                    firstname = player.PlayerData.charinfo.firstname,
                    lastname = player.PlayerData.charinfo.lastname,
                    identifier = player.PlayerData.citizenid
                })
                player.PlayerData.items[tostring(item.slot)].info[1].metadata = info.metadata
                player.PlayerData.items[tostring(item.slot)].info[1].charinfo = info.charinfo
                player.PlayerData.items[tostring(item.slot)].info[1].phoneNumber = info.phoneNumber
                player.PlayerData.items[tostring(item.slot)].info[1].owneridentifier = info.owneridentifier
                player.Functions.SetInventory(player.PlayerData.items)
                item.info[1] = player.PlayerData.items[tostring(item.slot)].info[1]
            end

            TriggerClientEvent('phone:openPhone', source, v, k, item.info[1])
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
