--[[

locations for engine cranes/lifts.

--]]

local craneModel = `imp_prop_engine_hoist_02a`

engineLifts = {
    testLift1 = {
        characterRestrictions = {
            'ABC:123',
        },
        
        jobRestrictions = {
            exotics = 2,
        },
        
        groupRestrictions = {
            exotics = 2,
        },

        position = vector3(553.78, -187.84, 50.31),

        props = {
            {
                position = vector3(553.78, -187.84, 49.31),
                heading = 50.58,
                model = craneModel
            }
        }
    },
    
    testLift2 = {        
        jobRestrictions = {
            redline = 2,
        },

        position = vector3(-576.16, -912.83, 23.89),

        props = {
            {
                position = vector3(-210.54,-1318.62,2.89),
                heading = 340.58,
                model = craneModel
            }
        }
    }
}