--[[

engine stands provide a place for people to build an engine.

--]]

local liftModel = `imp_prop_transmission_lift_01a`
local engineModel = `prop_car_engine_01`

engineStands = {
    exotics = {
        
        jobRestrictions = {
            exotics = 2,
        },

        position = vector3(-205.0,-1319.0,29.9),

        props = {
            stand = {
                position = vector3(564.47, -195.77, 49.31),
                heading = 150.0,
                model = liftModel,
            },
            engine = {
                position = vector3(564.47, -195.77, 50.31),
                heading = 150.0,
                model = engineModel,
            },      
        }
    },

    redline = {

        jobRestrictions = {
            redline = 2,
        },

        position = vector3(-205.0,-1322.0,29.9),

        props = {
            stand = {
                position = vector3(-205.0,-1322.0,29.9),
                heading = 90.0,
                model = liftModel,
            },
            engine = {
                position = vector3(-205.0,-1322.0,31.0),
                heading = 90.0,
                model = engineModel,
            },      
        }
    },
}