if Config.qbSettings.enabled then

    if Config.qbSettings.useNewQBExport then
        QBCore = exports['qb-core']:GetCoreObject()
    end
    
    function GetItemLabel(player, item)
        local xPlayer = QBCore.Functions.GetPlayer(player)
        
        return xPlayer.Functions.GetItemByName(item).label or item
    end
    
    function DoesPlayerHaveItem(player, item, amount, extra)
        local xPlayer = QBCore.Functions.GetPlayer(player)
        
        return xPlayer.Functions.GetItemByName(item) and xPlayer.Functions.GetItemByName(item).amount >= (amount or 1)
    end
    
    function GetPlayerItemAmount(player, item)
        local xPlayer = QBCore.Functions.GetPlayer(player)
        
        return xPlayer.Functions.GetItemByName(item).amount
    end

    function RemovePlayerItem(player, item, amount, extra)
        local xPlayer = QBCore.Functions.GetPlayer(tonumber(player))
        local qbItem = xPlayer.Functions.GetItemByName(item)
        xPlayer.Functions.RemoveItem(item, amount or 1)
        
        TriggerClientEvent('inventory:client:ItemBox', player, QBCore.Shared.Items[item], 'remove', amount or 1)
        
        -- Return the metadata
        return qbItem.info
    end

    function AddPlayerItem(player, item, amount, meta)
        local xPlayer = QBCore.Functions.GetPlayer(tonumber(player))
        TriggerClientEvent('inventory:client:ItemBox', player, QBCore.Shared.Items[item], 'add', amount or 1)
        return xPlayer.Functions.AddItem(item, amount or 1, false, meta or nil)
    end
end
