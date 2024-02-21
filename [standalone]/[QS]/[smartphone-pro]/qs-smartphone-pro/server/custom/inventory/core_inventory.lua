if Config.Inventory ~= 'core_inventory' then
    return
end

CoreInventory = exports['core_inventory']

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
    local identifier = GetIdentifier(src)
    local inventory = 'content-' .. identifier:gsub(':', '')
    local items = CoreInventory:getInventory(inventory)
    if not items then return end
    local phone = MetaData[src].phoneNumber
    local itemToUpdate = nil
    for k, v in pairs(items) do
        local meta = v.info or v.metadata
        if meta.phoneNumber == phone and PhoneIsUseable(meta.uniqueId) then
            itemToUpdate = v
            break
        end
    end
    CoreInventory:updateMetadata(inventory, itemToUpdate.id, MetaData[src])
end

local usedPhone = {} -- This fix for the laggy phone

function RegisterItems()
    if Config.Framework == 'esx' then
        for k, v in pairs(Config.Phones) do
            RegisterUsableItem(k, function(source, item, itemData)
                local time = os.time()
                if usedPhone[source] and usedPhone[source] > time then return end
                usedPhone[source] = time + 2
                local player = GetPlayerFromId(source)
                local identifier = GetIdentifier(source)
                local inventory = 'content-' .. identifier:gsub(':', '')
                if not type(item) ~= 'table' and type(itemData) == 'table' then
                    item = itemData
                end
                item.info = item.metadata
                if not item.info or not item.info?.phoneNumber then
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
                    Debug('update metadata', inventory, item.id, info)
                    CoreInventory:updateMetadata(inventory, item.id, info)
                    Debug('Created phone meta')
                end
                Debug('loading with', item.info.phoneNumber)
                TriggerClientEvent('phone:openPhone', source, v, k, item.info)
            end)
        end
    elseif Config.Framework == 'qb' then
        for k, v in pairs(Config.Phones) do
            RegisterUsableItem(k, function(source, item)
                local time = os.time()
                if usedPhone[source] and usedPhone[source] > time then return end
                usedPhone[source] = time + 2
                local player = GetPlayerFromId(source)
                item.info = item.metadata
                if not item.info or not item.info?.phoneNumber then
                    local info = CreatePhoneMetaData({
                        firstname = player.PlayerData.charinfo.firstname,
                        lastname = player.PlayerData.charinfo.lastname,
                        identifier = player.PlayerData.citizenid
                    })

                    local inventory = 'content-' .. player.PlayerData.citizenid
                    item.info = info
                    Debug('update metadata', inventory, item.id, info)
                    CoreInventory:updateMetadata(inventory, item.id, info)
                    Debug('Created phone meta')
                end
                Debug('loading with', item.info.phoneNumber)
                TriggerClientEvent('phone:openPhone', source, v, k, item.info)
            end)
        end
    end
end
