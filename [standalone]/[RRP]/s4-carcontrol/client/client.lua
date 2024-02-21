if Config.Framework == "ESX" then 
    ESX = exports["es_extended"]:getSharedObject()
else 
    QBCore = exports["qb-core"]:GetCoreObject()
end


tdi = 2.0
Open = false
Pm = false
alldoors = false
updatestate = "open"
settings = {
    ["sportmode"] = false, ["ambient"] = false, ["neon"] = false 
}

RegisterKeyMapping('carcontrol', 'CarControl', 'keyboard', Config.OpenKey)
RegisterKeyMapping('ccmini', 'CarControlMini', 'keyboard', Config.OpenKeyMini)
RegisterKeyMapping('carcontrol-', 'CarControl', 'keyboard', "Escape")

RegisterCommand('ccmini', function()
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsUsing(ped)
 
    if GetVehiclePedIsIn(ped, false) ~= 0 then    
        if NetworkGetNetworkIdFromEntity(GetPedInVehicleSeat(veh, -1)) ==  NetworkGetNetworkIdFromEntity(ped) then 
            SetNuiFocus(1, 1)
            SetNuiFocusKeepInput(true)
            SetCursorLocation(0.5, 0.5)
            SendNUIMessage({ action = "openmini", data = GetInfo() }) 
            updatestate = "openmini"
            Open = true
            Pm = true
            CheckUpdate()
            Controls()
        end
    end
end, false)

RegisterCommand('carcontrol', function()
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsUsing(ped)
 
    if GetVehiclePedIsIn(ped, false) ~= 0 then    
        if NetworkGetNetworkIdFromEntity(GetPedInVehicleSeat(veh, -1)) ==  NetworkGetNetworkIdFromEntity(ped) then 
            SetNuiFocus(1, 1)
            SetNuiFocusKeepInput(true)
            SetCursorLocation(0.5, 0.5)
            SendNUIMessage({ action = "open", data = GetInfo() }) 
            updatestate = "open"
            Open = true
            Pm = true
            CheckUpdate()
            Controls()
        end
    end
end, false)

RegisterCommand('carcontrol-', function()
    Open = false
    CheckUpdate()
    SendNUIMessage({ action = "close" }) 
    SetNuiFocus(0, 0)
    SetNuiFocusKeepInput(false)
    Wait(100)
    Pm = false 
    Controls()
end, false)

RegisterNUICallback("close", function(data, cb)
    Open = false
    CheckUpdate()
    SendNUIMessage({ action = "close" }) 
    SetNuiFocus(0, 0)
    SetNuiFocusKeepInput(false)
    Wait(100)
    Pm = false 
    Controls()
end)

RegisterNUICallback("catchSearch", function(data, cb)
    SendNUIMessage({ action = "spotify", data = data }) 
end)

RegisterNUICallback("createAlbum", function(data, cb)
    notify(Config.Langs[Config.Lang]["albumcreate"])
    TriggerServerEvent("s4-carcontrol:createAlbum", data.name)
end)

RegisterNUICallback("copyAlbum", function(data, cb)
    notify(Config.Langs[Config.Lang]["albumlist"])
    TriggerServerEvent("s4-carcontrol:copyAlbum", data.unik)
end)

RegisterNUICallback("addNewTrackToAlbum", function(data, cb)
    notify(Config.Langs[Config.Lang]["addnewtrack"])
    TriggerServerEvent("s4-carcontrol:addNewTrackToAlbum", data)
end)

RegisterNUICallback("delAlbum", function(data, cb)
    notify(Config.Langs[Config.Lang]["delAlbum"])
    TriggerServerEvent("s4-carcontrol:delAlbum", data)
end)

RegisterNUICallback("updateAlbumList", function(data, cb)
    TriggerServerEvent("s4-carcontrol:updateAlbumList", data)
end)

RegisterNUICallback("getSpotifyAlbums", function(data, cb)
    if Config.Framework == "ESX" then
        ESX.TriggerServerCallback("s4-carcontrol:getSpotifyAlbums", function(x)
            return cb(x)
        end)
    else
        QBCore.Functions.TriggerCallback("s4-carcontrol:getSpotifyAlbums", function(x)
            return cb(x)
        end)
    end
end)

CheckUpdate = function()
    Citizen.CreateThread(function()
        while Open do 
            local ped = GetPlayerPed(-1)
            if not IsPedInAnyVehicle(ped, true) then
                Open = false
                CheckUpdate()
                SendNUIMessage({ action = "close" }) 
            
                SetNuiFocus(0, 0)
                SetNuiFocusKeepInput(false)
                Wait(100)
                Pm = false 
                Controls()
                break
            end
            SendNUIMessage({ action = updatestate, data = GetInfo() }) 
            Citizen.Wait(1000)
        end
    end)
end

Citizen.CreateThread(function()
    while true do 
        local ped = GetPlayerPed(-1)
        local veh = GetVehiclePedIsUsing(ped)
        if not IsPedInAnyVehicle(ped, true) then
            SendNUIMessage({ action = "pause" }) 
        end
        Citizen.Wait(1000)
    end
end)

RegisterNetEvent("s4-carcontrol:pause")
AddEventHandler("s4-carcontrol:pause", function(data)
    SendNUIMessage({ action = "pause" }) 
end)

RegisterNetEvent("s4-carcontrol:play")
AddEventHandler("s4-carcontrol:play", function(data)
    SendNUIMessage({ action = "play", id = data }) 
end)

RegisterNetEvent("s4-carcontrol:seekPlayer")
AddEventHandler("s4-carcontrol:seekPlayer", function(data, track)
    SendNUIMessage({ action = "seek", seek = data, track = track }) 
end)
 
RegisterNetEvent("s4-carcontrol:getPlayerTime")
AddEventHandler("s4-carcontrol:getPlayerTime", function(reqSrc, ostime)
    SendNUIMessage({ action = "getPlayerTime", src = reqSrc,  ostime = ostime }) 
end)

RegisterNetEvent("s4-carcontrol:playerSync")
AddEventHandler("s4-carcontrol:playerSync", function(action)
    SendNUIMessage({ action = "playerSync", sync = action  }) 
end)
 
RegisterNUICallback("playerSync", function(data, cb)
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsUsing(ped)
    local netId = VehToNet(veh)
    TriggerServerEvent("s4-carcontrol:playerSync", data.action, netId)
end) 

RegisterNUICallback("currentTime", function(data, cb)
   TriggerServerEvent("s4-carcontrol:timeSync", data.time, data.src, data.track, data.ostime)
end)

RegisterNUICallback("streamAudio", function(data, cb)
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsUsing(ped)
    local netId = VehToNet(veh)
    playerList = {}
   
    -- for i= -1, GetVehicleMaxNumberOfPassengers(veh) do
    --     s = GetPedInVehicleSeat(veh, i)
    --     if s ~= 0 then 
    --         if NetworkGetNetworkIdFromEntity(GetPedInVehicleSeat(veh, -1)) ~=  NetworkGetNetworkIdFromEntity(s) then 
    --             table.insert(playerList, NetworkGetNetworkIdFromEntity(s))
    --         end
    --     end
    -- end
    TriggerServerEvent("s4-carcontrol:streamAudio", data, playerList, netId)
end)


RegisterNetEvent("s4-carcontrol:enteredVehicle")
AddEventHandler("s4-carcontrol:enteredVehicle", function(veh, seat, name)
    -- print(veh, seat, name)
end)


Controls = function()
    Citizen.CreateThread(function()
        while Pm do 
            DisableControlAction(1, 199)
            DisableControlAction(1, 200)
            SetPauseMenuActive(false)
            Citizen.Wait(0)
        end
    end)
end

flip = true
RegisterNUICallback("uiflip", function(data, cb)
    flip = not flip
    SetNuiFocusKeepInput(flip)
end)

RegisterNUICallback("ui", function(data, cb)
    SetNuiFocusKeepInput(data)
end)

RegisterNUICallback("setDoor", function(data, cb)
    veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)

    if GetInfo().door[data.w] == true then 
        notify(Config.Langs[Config.Lang]["door_close"])
        SetVehicleDoorShut(veh, data.w, false)
    else
        notify(Config.Langs[Config.Lang]["door_open"])
        SetVehicleDoorOpen(veh, data.w, false, false)
    end
end)

RegisterNUICallback("setSeat", function(data, cb)
    veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
    if IsVehicleSeatFree(veh, data.w) then 
        notify(Config.Langs[Config.Lang]["seatchange"])
        SetPedIntoVehicle(GetPlayerPed(-1), veh, data.w)
    end
end)

RegisterNUICallback("setWindow", function(data, cb)
    veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
    if GetInfo().windows[data.w] == false then 
        notify(Config.Langs[Config.Lang]["window_close"])
        RollUpWindow(veh, data.w)
    else
        notify(Config.Langs[Config.Lang]["window_open"])
        RollDownWindow(veh, data.w)
    end
end)

RegisterNUICallback("getCoors", function(data, cb)
    c = GetEntityCoords(GetPlayerPed(-1))
    return cb({ x = c.x, y = c.y })
end)

RegisterNUICallback("setEngine", function(data, cb)
    veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
    SetVehicleEngineOn(veh, false, false, true)
end)

RegisterNUICallback("setIndicator", function(data, cb)
    veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
    if GetInfo().warning == 0 then 
        SetVehicleIndicatorLights(veh, 1, true)
        SetVehicleIndicatorLights(veh, 0, true)
    else 
        SetVehicleIndicatorLights(veh, 1, false)
        SetVehicleIndicatorLights(veh, 0, false)
    end
end)

RegisterNUICallback("setAllDoors", function(data, cb)
    veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
    if GetInfo().alldoors == false then 
        for i = 0, 7 do
            SetVehicleDoorOpen(veh, i, false, false) 
        end
        alldoors = true
    else 
        for i = 0, 7 do
            SetVehicleDoorShut(veh, i, false)
        end
        alldoors = false
    end
end)

RegisterNUICallback("setLights", function(data, cb)
    veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
    if GetInfo().light == 0 then 
        SetVehicleLights(veh, 2)
    else
        SetVehicleLights(veh, 0)
    end
end)


GetInfo = function() 
    player = GetPlayerPed(-1)
    pCoord = GetEntityCoords(player)
    streetName, crossingRoad = GetStreetNameAtCoord(pCoord.x, pCoord.y, pCoord.z)
    veh = GetVehiclePedIsIn(player, false)
    lstate, lights, beams = GetVehicleLightsState(veh)
  
    temp = getTemp()
    gear = "N"
    if veh then 
        speed = GetEntitySpeed(veh)
        if Config.SpeedType == "kmh" then 
            speed = (speed * 3.6)
        end
        if GetVehicleCurrentGear(veh) == 0 then 
            gear = "R"
        end
        if GetVehicleCurrentGear(veh) > 1 then 
            gear = "D"
        end
    end
    if Config.TemperatureType == "C" then 
        temp = (temp - 32) * 5 / 9
    end
  
    return {
        streetName = GetStreetNameFromHashKey(streetName),
        crossingRoad = GetStreetNameFromHashKey(crossingRoad),
        speed = math.floor(speed or 0),
        temp = math.floor(temp),
        weather = getWeatherStringFromHash(Citizen.InvokeNative(0x564B884A05EC45A3)),
        gear = gear,
        lock = GetVehicleDoorLockStatus(veh),
        doors = IsVehicleDoorFullyOpen(veh, 1),
        coords = GetEntityCoords(veh),
        light = lights,
        warning = GetVehicleIndicatorLights(veh),
        alldoors = alldoors,
        engine = GetIsVehicleEngineRunning(veh),
        windows = { [0] = IsVehicleWindowIntact(veh, 0),IsVehicleWindowIntact(veh, 1),IsVehicleWindowIntact(veh, 2),IsVehicleWindowIntact(veh, 3)  },
        door = { 
            [0] = (GetVehicleDoorAngleRatio(veh, 0) > 0.0),
            (GetVehicleDoorAngleRatio(veh, 1) > 0.0),
            (GetVehicleDoorAngleRatio(veh, 2) > 0.0),
            (GetVehicleDoorAngleRatio(veh, 3) > 0.0),
            (GetVehicleDoorAngleRatio(veh, 4) > 0.0),
            (GetVehicleDoorAngleRatio(veh, 5) > 0.0)
        },
        seat = {
            IsVehicleSeatFree(veh, -1), IsVehicleSeatFree(veh, 0),
            IsVehicleSeatFree(veh, 1), IsVehicleSeatFree(veh, 2)
        },
        settings = settings,
        handbrake = GetVehicleHandbrake(veh)
    }
end

RegisterNUICallback("setLight", function(data, cb)
    if data.state == "setNeonLight" then 
        veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
        SetVehicleNeonLightsColour(veh, data.rgb.r, data.rgb.g, data.rgb.b)
    end
end)

RegisterNUICallback("setSettings", function(data, cb)
    veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
    settings[data.s] = not settings[data.s]
    if data.s == "sportmode" then 
        SportMode()
    end
    if data.s == "neon" then 
        if Config.ForceAddNeonModKit == true then
            
            SetVehicleModKit(veh, 0)
            ToggleVehicleMod(veh, 22, true)
        end
        for i=0, 3 do
            SetVehicleNeonLightEnabled(veh, i, settings[data.s])
        end
        SetVehicleNeonLightsColour(veh, 222, 222, 255)
    end

    if settings[data.s] == true then 
        notify(Config.Langs[Config.Lang][data.s.."_on"])
    else 
        notify(Config.Langs[Config.Lang][data.s.."_off"])
    end

    return cb(settings[data.s])
end)


notify = function(text)
    if Config.EnableNotifications == false then
        return 
    end
    SendNUIMessage({ action = "notif", text = text }) 
    PlaySoundFrontend(1, "SELECT", "HUD_FRONTEND_MP_SOUNDSET")
end

SportMode = function() 
    veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)

    Citizen.CreateThread(function() 
         while settings["sportmode"] == true do 
            SetVehicleCheatPowerIncrease(veh, Config.SportModeMultiplier)
            Citizen.Wait(0)
         end
    end)
end

 
RegisterNUICallback("getBlips", function(data, cb)
    blips = getAllBlips()
    c = GetEntityCoords(GetPlayerPed(-1))
    return cb({
        me = { x = c.x, y = c.y },
        friends = blips,
        icon = Config.Icon
    })
end)

function getAllBlips()
    local blips = {}
    local blip = GetFirstBlipInfoId(Config.RadarBlip)
 
    table.insert(blips, { x = GetBlipCoords(blip).x, y = GetBlipCoords(blip).y })
    
    while true do
        local blip = GetNextBlipInfoId(Config.RadarBlip)
        if DoesBlipExist(blip) then
            table.insert(blips,  { x = GetBlipCoords(blip).x, y = GetBlipCoords(blip).y })
        else
            break
        end
    end
   
    return blips
end

if Config.DisableDefaultGameSeatSwitchSystem == true then 
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) == GetPlayerPed(-1) then
                    if GetIsTaskActive(GetPlayerPed(-1), 165) then
                        SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
                    end
                end
            end
        end
    end)
end

if Config.DisableDefaultGameRadioSystem == true then 
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1000)
                if IsPedInAnyVehicle(PlayerPedId()) then
                SetUserRadioControlEnabled(false)
                if GetPlayerRadioStationName() ~= nil then
                    SetVehRadioStation(GetVehiclePedIsIn(PlayerPedId()),"OFF")
                end
            end
        end
    end)
end


DrawText3D = function (x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    ClearDrawOrigin()
end
 

LoadConfig = function()
    if Config.Framework == "ESX" then 
        while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
        end
        PlayerData = ESX.GetPlayerData()
    else 
        while QBCore.Functions.GetPlayerData().job == nil do
        Citizen.Wait(10)
        end
        PlayerData = QBCore.Functions.GetPlayerData()
    end
    Wait(1000)
    SendNUIMessage({ action = "config", data = Config }) 
end


Citizen.CreateThread(function()
    while 4>0 do
       Citizen.Wait(1)	 
       if NetworkIsPlayerActive(PlayerId()) then
          LoadConfig()
          break
       end
    end
end)

if Config.EnableVolumeControl == true then 
    RegisterKeyMapping('cc_vol_up', 'CarControl Vol Up', 'keyboard', Config.VolumeUpKey)
    RegisterKeyMapping('cc_vol_down', 'CarControl Vol Down', 'keyboard', Config.VolumeDownKey)
    RegisterCommand('cc_vol_up', function()
        SendNUIMessage({ action = "vol", data = "up" }) 

    end, false)
    RegisterCommand('cc_vol_down', function()
        SendNUIMessage({ action = "vol", data = "down" }) 
    end, false)
end
















if GetResourceState('baseevents') ~= 'missing' then
    local isInVehicle = false
    local isEnteringVehicle = false
    local currentVehicle = 0
    local currentSeat = 0
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
    
            local ped = PlayerPedId()
    
            if not isInVehicle and not IsPlayerDead(PlayerId()) then
                if DoesEntityExist(GetVehiclePedIsTryingToEnter(ped)) and not isEnteringVehicle then
                    local vehicle = GetVehiclePedIsTryingToEnter(ped)
                    local seat = GetSeatPedIsTryingToEnter(ped)
                    local netId = VehToNet(vehicle)
                    isEnteringVehicle = true
                    TriggerServerEvent('baseevents:enteringVehicle', vehicle, seat, GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)), netId)
                elseif not DoesEntityExist(GetVehiclePedIsTryingToEnter(ped)) and not IsPedInAnyVehicle(ped, true) and isEnteringVehicle then
                    TriggerServerEvent('baseevents:enteringAborted')
                    isEnteringVehicle = false
                elseif IsPedInAnyVehicle(ped, false) then
                    isEnteringVehicle = false
                    isInVehicle = true
                    currentVehicle = GetVehiclePedIsUsing(ped)
                    currentSeat = GetPedVehicleSeat(ped)
                    local model = GetEntityModel(currentVehicle)
                    local name = GetDisplayNameFromVehicleModel()
                    local netId = VehToNet(currentVehicle)
                    TriggerServerEvent('baseevents:enteredVehicle', currentVehicle, currentSeat, GetDisplayNameFromVehicleModel(GetEntityModel(currentVehicle)), netId)
                end
            elseif isInVehicle then
                if not IsPedInAnyVehicle(ped, false) or IsPlayerDead(PlayerId()) then
                    -- bye, vehicle
                    local model = GetEntityModel(currentVehicle)
                    local name = GetDisplayNameFromVehicleModel()
                    local netId = VehToNet(currentVehicle)
                    TriggerServerEvent('baseevents:leftVehicle', currentVehicle, currentSeat, GetDisplayNameFromVehicleModel(GetEntityModel(currentVehicle)), netId)
                    isInVehicle = false
                    currentVehicle = 0
                    currentSeat = 0
                end
            end
            Citizen.Wait(50)
        end
    end)
    
    function GetPedVehicleSeat(ped)
        local vehicle = GetVehiclePedIsIn(ped, false)
        for i=-2,GetVehicleMaxNumberOfPassengers(vehicle) do
            if(GetPedInVehicleSeat(vehicle, i) == ped) then return i end
        end
        return -2
    end

end