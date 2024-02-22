-- Placing checks

local nearbyObjects = {}
Citizen.CreateThread(function()
    while true do
        local sleep = 3000
        
        if IS_PLACING then
            sleep = 1500
            local newTable = {}
            
            local allObjects = GetGamePool('CObject')
            local coords = GetEntityCoords(PlayerPedId())
            
            for _, obj in pairs(allObjects) do
                if GetDistanceBetweenCoords(coords, GetEntityCoords(obj), 1) < 10.0 then
                    table.insert(newTable, obj)
                end
            end
            
            nearbyObjects = newTable
        end
        
        Citizen.Wait(sleep)
    end
end)

function IsIntersecting(object, vehicle)
    return UseCache('isIntersecting', function()
        if vehicle then
            if IsEntityTouchingEntity(object, vehicle) then
                return true
            end
        end
        
        for _, near in pairs(nearbyObjects) do
            if IsEntityTouchingEntity(object, near) and object ~= near then
                return true
            end
        end
        
        return false
    end, 50)
end

function IsASupportiveEntity(object, entity)
    local objMin, objMax = GetModelDimensions(GetEntityModel(object))
    local entMin, entMax = GetModelDimensions(GetEntityModel(entity))
    
    local objSize = (objMax.x - objMin.x) * (objMax.y - objMin.y)
    local entSize = (entMax.x - entMin.x) * (entMax.y - entMin.y)
    
    if not IsEntityAVehicle(entity) and Config.disallowItemStacking then
        return false
    end
    
    return objSize < entSize
end

function IsSupported(object)
    return UseCache('isSupported', function()
        local coords = GetEntityCoords(object)
        local min, max = GetModelDimensions(GetEntityModel(object))
        
        local checks = {
            coords + vector3(0.0, 0.0, min.z + 0.01),
            coords + vector3(min.x, 0.0, min.z + 0.01),
            coords + vector3(max.x, 0.0, min.z + 0.01),
            coords + vector3(0.0, min.x, min.z + 0.01),
            coords + vector3(0.0, max.x, min.z + 0.01),
        }
        
        local supports = 0
        for _, check in pairs(checks) do
            local ray = StartShapeTestSweptSphere(check, check + vector3(0.0, 0.0, -0.1), 0.03, 4294967295, object, 1)
            local result, hit, endCoords, normal, entity = GetShapeTestResult(ray)
            if hit == 1 then
                supports = supports + 1
            end
        end
        
        return supports >= (#checks - 1)
    end, 50)
end

-- This function is responsible for drawing all the 3d texts ('Press [E] to take off the wheel' e.g)
function Draw3DText(coords, textInput, scaleX)
    scaleX = scaleX * Config.textScale
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, coords, true)
    local scale = (1 / dist) * 20
    local fov = (1 / GetGameplayCamFov()) * 100
    scale = scale * fov
    
    SetTextScale(scaleX * scale, scaleX * scale)
    SetTextFont(Config.textFont or 4)
    SetTextProportional(1)
    SetTextDropshadow(1, 1, 1, 1, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(coords, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end


function IsPlayerUnreachable()
    local playerPed = PlayerPedId()
    return IsPedInAnyVehicle(playerPed) or IsPedRagdoll(playerPed) or IsEntityDead(playerPed)
end

function DisableInputs()
    -- https://docs.fivem.net/docs/game-references/controls/#controls
    local inputs = {14, 15, 16, 17, 21, 23, 24, 25, 44, 45, 140, 141, 142, 143, 261, 262, 263, 264}
    
    for k, input in pairs(inputs) do
        DisableControlAction(0, input, true)
    end
end

-- If this function returns `true`, the pickup animation will be skipped.
function SkipPickupAnimation()
    return false
end

function PlayAnim(dict, anim, flag, duration)
    Citizen.CreateThread(function()
        RequestAnimDict(dict)
        local timeout = 0
        while not HasAnimDictLoaded(dict) do
            Citizen.Wait(50)
            timeout = timeout + 1
            if timeout > 100 then
                return
            end
        end
        TaskPlayAnim(PlayerPedId(), dict, anim, 1.5, 1.0, duration or -1, flag or 1, 0, false, false, false)
        RemoveAnimDict(dict)
    end)
end

RegisterNetEvent('kq_materialize:client:notify')
AddEventHandler('kq_materialize:client:notify', function(message)
    Notify(message)
end)

function KeybindTip(message)
    SetTextComponentFormat("STRING")
    AddTextComponentString(message)
    EndTextCommandDisplayHelp(0, 0, 0, 200)
end

function Notify(message)
    SetTextComponentFormat("STRING")
    AddTextComponentString(message)
    EndTextCommandDisplayHelp(0, 0, 0, 2000)
end

-- Keybinds display
buttons = nil
keybinds = {}

function AddKeybindDisplay(key, label)
    buttons = nil
    
    table.insert(keybinds, {
        key = '~' .. key .. '~',
        label = label,
    })
    
    buttons = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS")
    while not HasScaleformMovieLoaded(buttons) do
        Wait(0)
    end
    
    BeginScaleformMovieMethod(buttons, "CLEAR_ALL")
    EndScaleformMovieMethod()
    
    for k, keybind in pairs(keybinds) do
        BeginScaleformMovieMethod(buttons, "SET_DATA_SLOT")
        ScaleformMovieMethodAddParamInt(k - 1)
        ScaleformMovieMethodAddParamPlayerNameString(keybind.key)
        PushScaleformMovieMethodParameterString(keybind.label)
        EndScaleformMovieMethod()
    end
    
    BeginScaleformMovieMethod(buttons, "DRAW_INSTRUCTIONAL_BUTTONS")
    EndScaleformMovieMethod()
end

function ClearKeybinds()
    buttons = nil
    keybinds = {}
end



Citizen.CreateThread(function()
    while true do
        local sleep = 500
        if alertActive then
            sleep = 1
            local scaleform = RequestScaleformMovie('mp_big_message_freemode')
            while not HasScaleformMovieLoaded(scaleform) do
                Citizen.Wait(1)
            end
            PushScaleformMovieFunction(scaleform, 'SHOW_SHARD_WASTED_MP_MESSAGE')
            PushScaleformMovieFunctionParameterString(alertTitle)
            PushScaleformMovieFunctionParameterString(alertMessage)
            PopScaleformMovieFunctionVoid()
            DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
        end
        
        if buttons ~= nil then
            sleep = 1
            DrawScaleformMovieFullscreen(buttons, 255, 255, 255, 255, 0)
        end
        Citizen.Wait(sleep)
    end
end)




RegisterNetEvent('kq_materialize:client:hookPlaceItem')
AddEventHandler('kq_materialize:client:hookPlaceItem', function(itemName, size)
    HookPlaceItem(itemName, size or 1)
end)


RegisterNUICallback('HookPlaceItem', function(data, cb)
    HookPlaceItem(data.item, data.size or 1)
    cb(true)
end)

function HookPlaceItem(itemName, size)
    if IsPedInAnyVehicle(PlayerPedId()) then
        Notify(L('~r~You may not place items while in a vehicle'))
    end
    if IS_PLACING or IsPlayerUnreachable() or UI_OPEN then
        return
    end
    
    if not Config.makeEverythingPlaceable.enabled and (not Config.items[itemName]) then
        Notify(L('~r~This item can not be placed'))
        return
    end
    
    local model = Config.makeEverythingPlaceable.fallbackProp
    if Config.items[itemName] ~= nil then
        model = Config.items[itemName][size or 1]
    end
    
    if model == nil or not IsModelValid(model) then
        if Config.items[itemName] then
            local newSize, newModel, forceSize = FindNearestSize(itemName, size)
            model = newModel
            if forceSize then
                size = newSize
            end
        else
            model = 'hei_prop_heist_box'
        end
    end

    -- The 4th argument can be used to pass anything you wish to the server.
    -- It's been added with the "slot" in mind for inventories which use slots
    MakePlaceableObject(model, itemName, size or 1)
end

function FindNearestSize(itemName, size)
    local biggestSize = nil
    local biggestModel = nil
    
    for itemSize, model in pairs(Config.items[itemName]) do
        if itemSize >= size then
            return itemSize, model, false
        end
        biggestSize = itemSize
        biggestModel = model
    end
    
    return biggestSize, biggestModel, true
end

if Config.debug then
    RegisterCommand('trunk', function(source, args)
        local playerPed = PlayerPedId()
        if not IsPedInAnyVehicle(playerPed, false) then
            return
        end
        
        local veh = GetVehiclePedIsIn(playerPed, false)
        local door = 5
        if GetVehicleDoorAngleRatio(veh, door) > 0.4 then
            SetVehicleDoorShut(veh, door, false)
        else
            SetVehicleDoorOpen(veh, door, false, false)
        end
    end)

    RegisterCommand('kqplace', function(source, args)
        MakePlaceableObject(args[1] or 'hei_prop_heist_box')
    end)
    
    RegisterCommand('kqplacehook', function(source, args)
        HookPlaceItem(args[1], tonumber(args[2] or 1))
    end)
end


RegisterNetEvent('kq_materialize:client:continuePlacing')
AddEventHandler('kq_materialize:client:continuePlacing', function(item, size)
    local model = Config.makeEverythingPlaceable.fallbackProp
    if Config.items[item] ~= nil then
        model = Config.items[item][size or 1]
    end
    
    if model == nil or not IsModelValid(model) then
        model = 'hei_prop_heist_box'
    end
    
    MakePlaceableObject(model, item, size)
end)
