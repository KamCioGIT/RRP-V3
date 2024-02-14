if Config.esxSettings.enabled then
    ESX = nil
    
    if Config.esxSettings.useNewESXExport then
        ESX = exports['es_extended']:getSharedObject()
    else
        Citizen.CreateThread(function()
            while ESX == nil do
                TriggerEvent('esx:getSharedObject', function(obj)
                    ESX = obj
                end)
                Citizen.Wait(0)
            end
        end)
    end
    
    function GetPlayerItems()
        while ESX == nil or ESX.GetPlayerData() == nil do
            Citizen.Wait(10)
        end
    
        local items = json.decode(json.encode(ESX.GetPlayerData().inventory))
        
        local parsedItems = {}
        
        Debug(json.encode(items))
        
        for k, item in pairs(items) do
            if ((item.count ~= nil and item.count >= 1) or (item.amount ~= nil and item.amount >= 1)) and (Config.items[item.name] ~= nil or Config.makeEverythingPlaceable.enabled) then
                table.insert(parsedItems, {
                    label = item.label,
                    name = item.name,
                    sizes = GetSizesOfItem(item.name, item.count or item.amount or 1)
                })
            end
        end
        
        return parsedItems
    end
end
