--[[

define machines to craft recipes

--]]

local cncModel = `gr_prop_gr_cnc_01c`

local recipes

if not config.autoGenerateRecipes then
    recipes = {
        'customAspiration',
        'customBlock',
        'customConrods',
        'customCrankshaft',
        'customExhaust',
        'customFuel',
        'customHeaders',
        'customHeads',
        'customIntake',
        'customIntercooler',
        'customPistons',
        'customValves',
        'customNitrous',
    }
else
    recipes = {}

    for k,v in pairs(EngineItems) do
        table.insert(recipes, k)
    end
end

productionMachines = {
    testMachine1 = {
        characterRestrictions = {
            'ABC:123',
        },
        
        jobRestrictions = {
            police = 2,
        },
        
        groupRestrictions = {
            police = 2,
        },

        position = vector3(560.98, -186.78, 50.31),

        animation = {
            ad = "pickup_object",
            anim = "putdown_low",
            blendIn = 5.0,
            blendOut = 1.5,
            duration = 1.0,
            flag = 48,
            playbackRate = 0.0,
            lockX = false,
            lockY = false,
            lockZ = false
        },

        recipes = recipes,

        props = {
            {
                position = vector3(560.98, -186.78, 49.31),
                heading = 0.0,
                model = cncModel,
            },  
        }       
    },
    testMachine2 = {
        characterRestrictions = {
            'ABC:123',
        },
        
        jobRestrictions = {
            redline = 2,
        },
        
        groupRestrictions = {
            redline = 2,
        },

        position = vector3(-567.33, -920.61, 23.89),

        animation = {
            ad = "pickup_object",
            anim = "putdown_low",
            blendIn = 5.0,
            blendOut = 1.5,
            duration = 1.0,
            flag = 48,
            playbackRate = 0.0,
            lockX = false,
            lockY = false,
            lockZ = false
        },

        recipes = recipes,

        props = {
            {
                position = vector3(-567.33, -920.61, 23.89),
                heading = 270.43,
                model = cncModel,
            },  
        }       
    },
}