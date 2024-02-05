Config = {}

Config.lightSpeed = 30.0 -- This controls how fast the lights change. (the lower the number the faster they change, the higher the number the slower they change!)

Config.envLightBrightness = 1.0 -- How bright should the environment lights be? (0.0 - 3.0)
Config.experimentalEnv = {
    enabled = true,
    -- if you have any suggestions on how to improve this, please let me know.
    defaultEnv = 3, -- Different modes for different results. (1, 2, 3)
    --[[
        Mode #1: 0.02-0.04ms
        Mode #2: 0.03-0.07ms
        Mode #3: 0.06-0.09ms
    ]]
    intensity = 1, -- if intensity is over 9000 then the lights will be more of an experience.
    distance = 75.0, -- How far should the environment lights be? (float)
    brightness = 1.0, -- How bright should the environment lights be? (float)
    hardness = 0.25, -- How hard should the environment lights be? (float)
    radius = 65.0, -- How big should the environment lights be? (float)
    falloff = 16.0 -- How fast should the environment lights fade? not the best way to describe it, just google it. (float)
}

Config.headlightFlashers = {
    enabled = false,
    distance = 65.0,
    brightness = 1.2,
    hardness = 0.0,
    radius = 30.0,
    falloff = 10.0
} -- Should the headlights flash when the lights are on? (true/false) | This is CLIENT SIDE ONLY! (This is a visual effect only, other players will not see your headlights flashing.)

Config.elsResize = {
    -- The way this works is you just drag the UI to where you want it to go.
    -- And then you can click the +/- buttons to change the size of the UI.
    -- You can also use arrow key up/down to change the size.
    -- You can also use -/+ on your keyboard to change the size.
    -- You must have the UI open to change the size though.

    enabled = true, -- Gives the option to open the ELS Resizer with the command below. (true/false)
    command = "els" -- The command to open the ELS Resizer UI. (string)
}

Config.elsPanel = {
    -- This is the command to turn off/on the ELS UI Panel. Some people don't like it so you can turn it off if you want.
    enabled = true, -- Gives the option to disable/enable the ELS Panel with the command below. (true/false)
    command = "elsPanel" -- The command to open the ELS Panel. (string)
}

-- Use easier to configure custom sirens -- Located in ps-els/client/sirens.lua
Config.customSirens = false

-- Allow front seat passenger to control sirens --
Config.passengerControls = true

-- Allow indicator controls for vehicles using this script --
Config.indicatorControls = false
Config.indicatorSounds = false -- Should the indicators make a sound? (true/false)

-- Dual Siren Mode --
Config.dualSiren = true -- Should the script allow dual siren mode? (true/false)

-- Mute Siren on Exit --
Config.muteSirenOnExit = true -- Should the siren mute when exiting the vehicle? (true/false)

-- UI/Action Sounds --
Config.UISounds = true -- Should the script play UI sounds suuch as the click and beep? (true/false)

-- Non-ELS Compatibility Mode --
Config.nonELS = {
    enabled = true, -- Should the script allow non-ELS vehicles to use the script? (true/false)
    hornInterrupt = true, -- Should the horn interrupt the siren? (true/false)
    UI = true -- Should the UI be enabled for non-ELS vehicles? (true/false)
}

-- Debug Mode --
Config.debug = false -- (true/false)

-- Keybinds --
-- keyboardInput: https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
-- controllerInput: https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/pad_digitalbutton/
Config.Keybinds = {
    Horn = {
        enabled = true,
        name = "Horn",
        keyboardInput = "E",
        controllerInput = "L3_INDEX"
    },
    EmergencyLights = {
        enabled = true,
        name = "Change Emergency Lights Code",
        keyboardInput = "Q",
        controllerInput = "LLEFT_INDEX",
        straightToCodeThree = false, -- Should the lights go straight to code 3? (true/false) [This kinda defeats the purpose of the script but some people want it so here it is.]
    },
    SirenOne = {
        enabled = true,
        name = "Switch to Siren Tone 1",
        keyboardInput = "1"
    },
    SirenTwo = {
        enabled = true,
        name = "Switch to Siren Tone 2",
        keyboardInput = "2"
    },
    SirenThree = {
        enabled = true,
        name = "Switch to Siren Tone 3",
        keyboardInput = "3"
    },
    SirenFour = {
        enabled = true,
        name = "Switch to Siren Tone 4",
        keyboardInput = "4"
    },
    SirenFive = {
        enabled = true,
        name = "Switch to Siren Tone 5",
        keyboardInput = "5"
    },
    SirenSix = {
        enabled = true,
        name = "Switch to Siren Tone 6",
        keyboardInput = "6"
    },
    ToggleSiren = {
        enabled = true,
        name = "Toggle Siren",
        keyboardInput = "LMENU",
        controllerInput = "LRIGHT_INDEX"
    },
    CycleSirenTone = {
        enabled = true,
        name = "Cycle Siren Tone",
        keyboardInput = "R",
        controllerInput = "RRIGHT_INDEX"
    },
    ToggleDualSiren = {
        enabled = true,
        name = "Toggle Dual Siren",
        keyboardInput = "UP"
    },
    ToggleADVLights = {
        enabled = true,
        name = "Toggle ADV Lights",
        keyboardInput = "7"
    },
    ToggleWRNLights = {
        enabled = true,
        name = "Toggle WRN Lights",
        keyboardInput = "8"
    },
    TogglePRIMLights = {
        enabled = true,
        name = "Toggle PRIM Lights",
        keyboardInput = "9"
    },
    ToggleTKDLights = {
        enabled = true,
        name = "Toggle TKD Lights",
        keyboardInput = "0",
        controllerInput = "LUP_INDEX"
    },
    NextPattern = {
        enabled = true,
        name = "Change to the next Light Pattern",
        keyboardInput = "EQUALS",
        controllerInput = "LDOWN_INDEX"
    },
    PreviousPattern = {
        enabled = true,
        name = "Change to the Previous Light Pattern",
        keyboardInput = "MINUS"
    },
}

-- This code is designed to allow your server to use both ELS and non-ELS vehicles.
-- The purpose of this code is to provide a way to implement non-ELS vehicle scripts
-- without activating them in ELS cars, ensuring compatibility between the two types
-- of vehicles. It's recommended not to modify this code unless you are confident
-- with your understanding.

if not IsDuplicityVersion() then
    local hashList = {}
    local started = false
    Citizen.CreateThread(
        function()
            repeat
                Citizen.Wait(0)
            until NetworkIsSessionActive()

            -- Get a list of all vehicle models
            local allVehicleModels = GetAllVehicleModels()

            -- Create a hash list of vehicle models
            for k, v in pairs(allVehicleModels) do
                hashList[GetHashKey(v)] = v
            end
            started = true
        end
    )

    -- Returns the lower case code for the specified vehicle
    function getCode(veh)
        return hashList[GetEntityModel(veh)]:lower()
    end

    local iVE = {}
    -- Exports a function to check if a vehicle is ELS

    local function checkELS(veh)
        if iVE[veh] ~= nil then
            return iVE[veh]
        end

        if Config.Vehicles == nil then
            return false
        end

        -- Check if the vehicle is in the ELS configuration
        local model = GetEntityModel(veh)
        for k, v in pairs(Config.Vehicles) do
            local thisHash = v.__hash__ or GetHashKey(v.name:lower())
            if thisHash == model then
                iVE[veh] = true
                return true
            end
        end

        return iVE[veh] or false
    end

    exports(
        "isVehicleELS",
        function(veh)
            local ELS = checkELS(veh)
            return ELS
        end
    )
end
