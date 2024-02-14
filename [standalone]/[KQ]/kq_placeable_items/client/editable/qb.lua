if Config.qbSettings.enabled then
    if Config.qbSettings.useNewQBExport then
        QBCore = exports['qb-core']:GetCoreObject()
    end
    
    if QBCore.Functions.GetPlayerData() and QBCore.Functions.GetPlayerData().job then
        PLAYER_JOB = QBCore.Functions.GetPlayerData().job.name
    end
    
    RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
    AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
        PLAYER_JOB = QBCore.Functions.GetPlayerData().job.name
    end)
    
    
    RegisterNetEvent('QBCore:Client:OnJobUpdate')
    AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
        PLAYER_JOB = JobInfo.name
    end)
    
    function GetPlayerItems()
        while QBCore == nil or QBCore.Functions.GetPlayerData().items == nil do
            Citizen.Wait(10)
        end
        
        local items = QBCore.Functions.GetPlayerData().items
        
        local parsedItems = {}
    
        Debug(json.encode(items))
        
        for k, item in pairs(items) do
            if ((item.amount ~= nil and item.amount >= 1) or (item.count ~= nil and item.count >= 1)) and (Config.items[item.name] ~= nil or Config.makeEverythingPlaceable.enabled) then
                table.insert(parsedItems, {
                    label = item.label,
                    name = item.name,
                    sizes = GetSizesOfItem(item.name, item.amount or item.count or 1)
                })
            end
        end
        
        return parsedItems
    end
end
