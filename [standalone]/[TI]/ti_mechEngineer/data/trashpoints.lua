local binModel = `prop_bin_13a`

trashPoints = {    
    trashPoint1 = {
        characterRestrictions = {
            'ABC:123',
        },

        jobRestrictions = {
            exotcs = 2,
        },

        groupRestrictions = {
            exotcs = 2,
        },

        position =  vector3(553.33, -191.16, 50.31),

        props = {
            {
                position = vector3(553.33, -191.16, 49.31),
                heading = 270.0,
                model = binModel,
            },
        }

    },
    
    trashPoint2 = {
        characterRestrictions = {
            'ABC:123',
        },

        jobRestrictions = {
            police = 2,
        },

        groupRestrictions = {
            police = 2,
        },

        position =  vector3(-569.11, -911.67, 23.89),

        props = {
            {
                position = vector3(-569.11, -911.67, 22.89),
                heading = 0.06,
                model = binModel,
            },
        }
    },
}