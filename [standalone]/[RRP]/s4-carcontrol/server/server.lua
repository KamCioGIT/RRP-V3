if Config.Framework == "ESX" then 
    ESX = exports["es_extended"]:getSharedObject()
else 
    QBCore = exports["qb-core"]:GetCoreObject()
end

CacheVehicleSeats = {}

 
RegisterNetEvent("s4-carcontrol:createAlbum")
AddEventHandler("s4-carcontrol:createAlbum", function(name)
    local source = source
    local unik = math.random(111111, 999999)

    while GetFromUnik(unik, true) == true do
        unik = math.random(111111, 999999)
        Citizen.Wait(0)
    end

    if Config.Framework == "ESX" then 
        local xPlayer = ESX.GetPlayerFromId(source)
        MySQL.Async.execute("INSERT INTO `s4-carplay-album` (name, unik, owner) VALUES ('"..name.."', '"..unik.."', '"..xPlayer.identifier.."')");
    else 
        local xPlayer = QBCore.Functions.GetPlayer(source)
        MySQL.Async.execute("INSERT INTO `s4-carplay-album` (name, unik, owner) VALUES ('"..name.."', '"..unik.."', '"..xPlayer.PlayerData.citizenid.."')");
    end

end)


RegisterNetEvent("s4-carcontrol:addNewTrackToAlbum")
AddEventHandler("s4-carcontrol:addNewTrackToAlbum", function(data)
    local source = source
    local album = {}
    album = GetFromUnik(data.unik)
    if album ~= false then 
        album.list = json.decode(album.list)
        table.insert(album.list, data.track)
        if Config.Framework == "ESX" then 
            local xPlayer = ESX.GetPlayerFromId(source)
            MySQL.Async.execute("UPDATE `s4-carplay-album` SET list='"..json.encode(album.list).."' WHERE owner='"..xPlayer.identifier.."' AND unik='"..album.unik.."'");
        else
            local xPlayer = QBCore.Functions.GetPlayer(source)
            MySQL.Async.execute("UPDATE `s4-carplay-album` SET list='"..json.encode(album.list).."' WHERE owner='"..xPlayer.PlayerData.citizenid.."' AND unik='"..album.unik.."'");

        end
    end
end)

RegisterNetEvent("s4-carcontrol:streamAudio")
AddEventHandler("s4-carcontrol:streamAudio", function(data, playerList, veh)
    local source = source
 
    if not CacheVehicleSeats[veh] then 
        CacheVehicleSeats[veh] = {}
    end

    for k,v in pairs(CacheVehicleSeats[veh]) do
        if v ~= source then 
            TriggerClientEvent("s4-carcontrol:play", v, data)
        end
    end

end)

RegisterNetEvent("s4-carcontrol:timeSync")
AddEventHandler("s4-carcontrol:timeSync", function(time, sw, track, ostime)
    local osram = os.time()
    n = math.abs(os.difftime(ostime, osram)) + Config.LatencyToleranceForSeek
    TriggerClientEvent("s4-carcontrol:seekPlayer", tonumber(sw), (time + n), track)
end)

RegisterNetEvent("s4-carcontrol:delAlbum")
AddEventHandler("s4-carcontrol:delAlbum", function(data)
    local source = source
    local album = {}
    album = GetFromUnik(data)
    if album ~= false then
        if Config.Framework == "ESX" then  
            local xPlayer = ESX.GetPlayerFromId(source)
            MySQL.Async.execute("DELETE FROM `s4-carplay-album`  WHERE owner='"..xPlayer.identifier.."' AND unik='"..data.."'");
        else 
            local xPlayer = QBCore.Functions.GetPlayer(source)
            MySQL.Async.execute("DELETE FROM `s4-carplay-album`  WHERE owner='"..xPlayer.PlayerData.citizenid.."' AND unik='"..data.."'");
        end
    end
end)

RegisterNetEvent("s4-carcontrol:updateAlbumList")
AddEventHandler("s4-carcontrol:updateAlbumList", function(data)
    local source = source
    local album = {}
    album = GetFromUnik(data.unik)
    if album ~= false then 
        if Config.Framework == "ESX" then  
            local xPlayer = ESX.GetPlayerFromId(source)
            MySQL.Async.execute("UPDATE `s4-carplay-album` SET list='"..json.encode(data.list).."' WHERE owner='"..xPlayer.identifier.."' AND unik='"..album.unik.."'");
        else 
            local xPlayer = QBCore.Functions.GetPlayer(source)
            MySQL.Async.execute("UPDATE `s4-carplay-album` SET list='"..json.encode(data.list).."' WHERE owner='"..xPlayer.PlayerData.citizenid.."' AND unik='"..album.unik.."'");
        end
    end
end)
 


RegisterNetEvent("baseevents:enteredVehicle")
AddEventHandler("baseevents:enteredVehicle", function(veh, seat, name, nid)
    local source = source

    if Config.UsePlateNumberForMusicPlayer == true then 
        nid = GetVehicleNumberPlateText(NetworkGetEntityFromNetworkId(nid)) 
    end
 
    if not CacheVehicleSeats[nid] then 
        CacheVehicleSeats[nid] = {}
    end
 
    if GetCacheHaveIn(nid, source) == false then 
        table.insert(CacheVehicleSeats[nid], source)
    end

    if seat ~= -1 then 
        local ostime = os.time()
        TriggerClientEvent("s4-carcontrol:getPlayerTime", CacheVehicleSeats[nid][1], source, ostime)
    end
    
end)

GetCacheHaveIn = function(veh, src) 
    for k,v in pairs(CacheVehicleSeats[veh]) do
        if v == src then 
            return true
        end 
    end
    return false
end

RegisterNetEvent("s4-carcontrol:playerSync")
AddEventHandler("s4-carcontrol:playerSync", function(action, nid)
    local source = source
    if Config.UsePlateNumberForMusicPlayer == true then 
        nid = GetVehicleNumberPlateText(NetworkGetEntityFromNetworkId(nid)) 
    end
    if not CacheVehicleSeats[nid] then 
        CacheVehicleSeats[nid] = {}
    end
    for k,v in pairs(CacheVehicleSeats[nid]) do
        if v ~= source then 
            TriggerClientEvent("s4-carcontrol:playerSync", v, action)
        end
    end
end)
 
RegisterNetEvent("baseevents:leftVehicle")
AddEventHandler("baseevents:leftVehicle", function(veh, seat, name, nid)
    local source = source

    if Config.UsePlateNumberForMusicPlayer == true then 
        nid = GetVehicleNumberPlateText(NetworkGetEntityFromNetworkId(nid)) 
    end
    
    if not CacheVehicleSeats[nid] then 
        CacheVehicleSeats[nid] = {}
    end

    if GetCacheHaveIn(nid, source) == false then 
        return
    end
    
    for k,v in pairs(CacheVehicleSeats[nid]) do
        if v == source then 
            table.remove(CacheVehicleSeats[nid], k)
            break
        end
    end

    if seat == -1 then 
        for k,v in pairs(CacheVehicleSeats[nid]) do
            TriggerClientEvent("s4-carcontrol:pause", v)
        end
    end
  
end)
 
RegisterNetEvent("s4-carcontrol:copyAlbum")
AddEventHandler("s4-carcontrol:copyAlbum", function(unik)
    local unik = unik
    local source = source
    local album = {}
    album = GetFromUnik(unik)
    if album ~= false then 

        while GetFromUnik(unik, true) == true do
            unik = math.random(111111, 999999)
            Citizen.Wait(0)
        end

        if Config.Framework == "ESX" then 
            local xPlayer = ESX.GetPlayerFromId(source)
            MySQL.Async.execute("INSERT INTO `s4-carplay-album` (name, unik, owner, list) VALUES ('"..album.name.."', '"..unik.."', '"..xPlayer.identifier.."', '"..album.list.."')");
        else 
            local xPlayer = QBCore.Functions.GetPlayer(source)
            MySQL.Async.execute("INSERT INTO `s4-carplay-album` (name, unik, owner, list) VALUES ('"..album.name.."', '"..unik.."', '"..xPlayer.PlayerData.citizenid.."', '"..album.list.."')");
        end
    end

end)


if Config.Framework == "ESX" then 
    ESX.RegisterServerCallback("s4-carcontrol:getSpotifyAlbums", function(source, cb, data)
        local xPlayer = ESX.GetPlayerFromId(source)
        result = {}
        result = MySQL.Sync.fetchAll("SELECT * FROM `s4-carplay-album` WHERE owner = '"..xPlayer.identifier.."' ")
        return cb(result)
    end)
else 
    QBCore.Functions.CreateCallback("s4-carcontrol:getSpotifyAlbums", function(source, cb, data)
        local xPlayer = QBCore.Functions.GetPlayer(source)
        result = {}
        result = MySQL.Sync.fetchAll("SELECT * FROM `s4-carplay-album` WHERE owner = '"..xPlayer.PlayerData.citizenid.."' ")
        return cb(result)
    end)
end



GetFromUnik = function(unik, x) 
    result = {}
    result = MySQL.Sync.fetchAll("SELECT * FROM `s4-carplay-album` WHERE unik = '"..unik.."' ")
    if result[1] then 
        if x then
            return true
        else 
            return result[1]
        end
    else
        return false
    end
end