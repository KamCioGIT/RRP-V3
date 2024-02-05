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
        
        jobRestrictions = {
            exotics = 2,
        },

        position = vector3(559.94, -186.67, 50.31),

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
                position = vector3(-559.94, -186.67, 50.31),
                heading = 180.0,
                model = cncModel,
            },  
        }       
    },
    testMachine2 = {
        
        jobRestrictions = {
            redline = 2,
        },

        position = vector3(-220.35,-1331.48,30.89),

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
                position = vector3(-220.35,-1331.48,29.89),
                heading = 111.43,
                model = cncModel,
            },  
        }       
    },
}