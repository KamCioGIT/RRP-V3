--[[

locations for engine cranes/lifts.

--]]

local craneModel = `imp_prop_engine_hoist_02a`

engineLifts = {
    exotics = {
        jobRestrictions = {
            exotics = 2,
        },

        position = vector3(553.80, -187.87, 49.31),

        props = {
            {
                position = vector3(553.80, -187.87, 50.31),
                heading = 220.58,
                model = craneModel
            }
        }
    },
    
    redline = {        
        jobRestrictions = {
            redline = 2,
        },

        position = vector3(-210.54,-1318.62,29.89),

        props = {
            {
                position = vector3(-210.54,-1318.62,29.89),
                heading = 340.58,
                model = craneModel
            }
        }
    }
}