if Config.Framework ~= 'esx' then
    return
end

ESX = exports['es_extended']:getSharedObject()

userTable = 'users'
identifierColumn = 'identifier'
garageTable = 'owned_vehicles'
garageIdentifierColumn = 'owner'
garagePropsColumn = 'vehicle'

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(id)
    savePlayer(id)
    TriggerClientEvent('advancedgarages:SetGaragesData', id, Config.Garages)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(id, xPlayer)
    TriggerClientEvent('advancedgarages:SetShellData', id, shellPlayers)
    local str = [[
        SELECT shell_garage FROM users WHERE identifier = ?
    ]]
    local result = MySQL.Sync.fetchAll(str, { xPlayer.identifier })
    if not result[1] or not result[1].shell_garage then return end
    local data = json.decode(result[1].shell_garage)
    if not data then return end
    TriggerClientEvent('advancedgarages:enterShellGarage', id, data.garage, data.defaultCoords, data.customGarageId)
end)

function RegisterServerCallback(name, cb)
    ESX.RegisterServerCallback(name, cb)
end

function RegisterUsableItem(name, cb)
    ESX.RegisterUsableItem(name, cb)
end

function GetPlayerFromId(source)
    return ESX.GetPlayerFromId(source)
end

function GetPlayerFromIdentifier(identifier)
    return ESX.GetPlayerFromIdentifier(identifier)
end

function GetPlayerIdentifier(source)
    local player = GetPlayerFromId(source)
    return player?.identifier
end

function GetJobName(source)
    local player = GetPlayerFromId(source)
    return player.getJob().name
end

function GetPlayerSource(player)
    return player?.source
end

function GetAccountMoney(source, account)
    local player = GetPlayerFromId(source)
    return player.getAccount(account).money
end

function RemoveAccountMoney(source, account, amount)
    local player = GetPlayerFromId(source)
    player.removeAccountMoney(account, amount)
end

function AddAccountMoney(source, account, amount)
    local player = GetPlayerFromId(source)
    player.addAccountMoney(account, amount)
end

function RemoveItem(source, item, count)
    local player = GetPlayerFromId(source)
    player.removeInventoryItem(item, count)
end

function PlayerIsAdmin(source)
    local player = GetPlayerFromId(source)
    return player.getGroup() == 'admin' or player.getGroup() == 'superadmin'
end

RegisterServerEvent('advancedgarages:server:setVehicle')
AddEventHandler('advancedgarages:server:setVehicle', function(vehicleProps, model, playerID, vehicleType, addcommand)
    local src = source
    local Player = GetPlayerFromId(src)
    local plate = vehicleProps.plate
    local garage
    if Player ~= nil then
        if addcommand then
            garage = 'OUT'
        else
            garage = GetImpoundOfType(vehicleType, vehicleProps.coords)
            if not garage then
                TriggerClientEvent('advancedgarages:sendTextMessage', src, Lang('GARAGES_NOTIFICATION_GIVE_MISSING_TYPE') .. ' ' .. vehicleType, 'error')
                return
            end
        end

        MySQL.Async.execute('INSERT INTO ' .. garageTable .. ' (' .. garageIdentifierColumn .. ', plate, ' .. garagePropsColumn .. ', garage, type) VALUES (?, ?, ?, ?, ?)', {
            GetPlayerIdentifier(playerID),
            plate,
            json.encode(vehicleProps),
            garage,
            vehicleType
        }, function(rowsAffected)
            if rowsAffected > 0 then
                TriggerClientEvent('advancedgarages:sendTextMessage', playerID, Lang('GARAGES_NOTIFICATION_GIVE_INFO_PLAYER_PLATE') .. ' ' .. string.upper(plate) .. ' ' .. Lang('GARAGES_NOTIFICATION_GIVE_INFO_PLAYER_LOCATION') .. ' ' .. garage, 'success')
            end
        end)
    end
end)
