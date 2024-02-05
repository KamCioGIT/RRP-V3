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
                position = vector3(553.33, -191.16, 50.31, 89.75),
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

        position =  vector3(841.94232177734, -822.28851318359, 26.332572937012),

        props = {
            {
                position = vector3(841.94232177734, -822.28851318359, 26.332572937012),
                heading = 90.06,
                model = binModel,
            },
        }
    },
}