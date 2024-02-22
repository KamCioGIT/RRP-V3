if Config.Framework ~= 'qb' then
    return
end

QBCore = exports['qb-core']:GetCoreObject()

userTable = 'players'
identifierColumn = 'citizenid'
garageTable = 'player_vehicles'
garageIdentifierColumn = 'citizenid'
garagePropsColumn = 'mods'

AddEventHandler('QBCore:Server:PlayerLoaded', function(Player)
    local id = Player.PlayerData.source
    savePlayer(id)
    TriggerClientEvent('advancedgarages:SetGaragesData', id, Config.Garages)
end)

RegisterNetEvent('QBCore:Server:OnPlayerLoaded', function()
    local src = source
    Wait(1250)
    local Player = GetPlayerFromId(src)
    local identifier = Player.PlayerData.citizenid
    TriggerClientEvent('advancedgarages:SetShellData', src, shellPlayers)
    local str = [[
        SELECT shell_garage FROM players WHERE citizenid = ?
    ]]
    local result = MySQL.Sync.fetchAll(str, { identifier })
    if not result[1] or not result[1].shell_garage then return end
    local data = json.decode(result[1].shell_garage)
    if not data then return end
    TriggerClientEvent('advancedgarages:enterShellGarage', src, data.garage, data.defaultCoords, data.customGarageId)
end)

function RegisterServerCallback(name, cb)
    QBCore.Functions.CreateCallback(name, cb)
end

function RegisterUsableItem(name, cb)
    QBCore.Functions.CreateUseableItem(name, cb)
end

function GetPlayerFromId(source)
    return QBCore.Functions.GetPlayer(source)
end

function GetPlayerFromIdentifier(identifier)
    return QBCore.Functions.GetPlayerByCitizenId(identifier)
end

function GetPlayerIdentifier(source)
    local player = GetPlayerFromId(source)
    return player?.PlayerData?.citizenid
end

function GetJobName(source)
    local player = GetPlayerFromId(source)
    return player.PlayerData.job.name
end

function GetPlayerSource(player)
    return player?.PlayerData?.source
end

function GetAccountMoney(source, account)
    local player = GetPlayerFromId(source)
    if account == 'money' then account = 'cash' end
    return player.PlayerData.money[account]
end

function RemoveAccountMoney(source, account, amount)
    local player = GetPlayerFromId(source)
    if account == 'money' then account = 'cash' end
    player.Functions.RemoveMoney(account, amount)
end

function AddAccountMoney(source, account, amount)
    local player = GetPlayerFromId(source)
    if account == 'money' then account = 'cash' end
    player.Functions.AddMoney(account, amount)
end

function RemoveItem(source, item, count)
    local player = GetPlayerFromId(source, true)
    player.Functions.RemoveItem(item, count)
end

function PlayerIsAdmin(source)
    if source == 0 then
        return true
    end
    return QBCore.Functions.HasPermission(source, 'god') or IsPlayerAceAllowed(source, 'command') or QBCore.Functions.HasPermission(source, 'admin')
end

RegisterServerEvent('advancedgarages:server:setVehicle')
AddEventHandler('advancedgarages:server:setVehicle', function(vehicleProps, model, playerID, vehicleType, addcommand)
    local src = source
    local Player = GetPlayerFromId(src)
    local playerID = tonumber(playerID)

    if Player ~= nil and playerID ~= nil then
        local Target = QBCore.Functions.GetPlayer(playerID)
        local plate = vehicleProps.plate

        local garage = GetImpoundOfType(vehicleType, vehicleProps.coords)
        if not garage then
            TriggerClientEvent('advancedgarages:sendTextMessage', src, Lang('GARAGES_NOTIFICATION_GIVE_MISSING_TYPE') .. ' ' .. vehicleType, 'error')
            return
        end

        MySQL.Async.execute('INSERT INTO ' .. garageTable .. ' (license, ' .. garageIdentifierColumn .. ', vehicle, hash, plate, ' .. garagePropsColumn .. ', garage, type) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', {
            Target.PlayerData.license,
            Target.PlayerData.citizenid,
            model,
            vehicleProps.model,
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
