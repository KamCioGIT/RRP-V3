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
            police = 2,
        },
        
        groupRestrictions = {
            police = 2,
        },

        position = vector3(-210.54,-1318.62,29.89),

        props = {
            {
                position = vector3(-210.54,-1318.62,29.89),
                heading = 340.58,
                model = craneModel
            }
        }
    },
    
    testLift2 = {        
        jobRestrictions = {
            mechanic = 2,
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