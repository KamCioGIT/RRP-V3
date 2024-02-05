Config = {}

Config.debug = false

--- If you're testing the script and editing the values DO NOT simply restart the script. As this script is using custom models (dynos)
--- it will crash if you just restart it. Instead use the `/kq_dyno_restart` command. It will safely restart the script without causing you to crash


--- SETTINGS FOR ESX
Config.esxSettings = {
    enabled = false,
    -- Whether or not to use the new ESX export method
    useNewESXExport = true,
}

--- SETTINGS FOR QBCORE
Config.qbSettings = {
    enabled = true,
}


--- BASIC

-- Torque units | 'nm' or 'lb-ft'
Config.torqueUnits = 'lb-ft'


--- Horsepower and torque calculation formula
-- If you're not using vanilla or vanilla-like handling:
-- Try out different formulas and see what works best for your server.

-- 'vanilla' = Perfect setup for vanilla handling as well as handling files obeying the principles of vanilla GTA

-- 'highperformance1' = Good for servers using handling files which result in faster vehicles
-- 'highperformance2' = Good for servers using handling files which result in faster vehicles (extra)
-- 'highperformance3' = Good for servers using handling files which result in faster vehicles (extra)
---------------------------------------------
Config.dynoFormula = 'highperformance1'



--- FRAMEWORK OPTIONS (MAKE SURE TO ENABLE YOUR FRAMEWORK IF USING ONE) <!>
Config.jobWhitelist = {
    enabled = true,
    jobs = {
        'redline',
        'exotics',
    }
}

-- Discord webhook options
Config.webhook = {
    enabled = true, -- Whether to send the dyno sheets to the discord webhook

    -- To get the Discord webhook link, right click on a channel > Edit channel > Integrations > Webhooks > View webhooks > New webhook
    url = 'https://discord.com/api/webhooks/1204109148518748191/gg_wgFrFQtzch0sUet32cmSyBcd4oi9cKayK8Qzx5r0PSkO3mLJls2ENkWDCwCTaqsib',

    -- Replace this with the name of your server or a title you want on your dyno sheets
    title = 'RealRoleplay - Dyno',

    -- Whether to include certain parts of the users info in the webhook messages
    includeUserName = true,
    includeSteamId = false,
}

-- Time it takes for the screens to turn off after a dyno run (in seconds)
Config.screenTimeout = 30

-- Whether to display the dyno sheet on the screen as UI
Config.displaySheetOnScreen = true

-- Determines the location of the dyno sheet
Config.screenSheetOffset = {
    x = 0.84,
    y = 0.833,
}

-- Dynos setup
-- coords = vector3 of the dyno location
-- heading = heading of the dyno
-- model = model defined in Config.dynoModels (By leaving this out, you will create a dyno without a model. Useful for MLOs with built-in dynos)
-- displays = table of displays
--      displayCoords = vector3 of the display location
--      displayTilt = angle of the display tilt,
--      displayHeading = heading of the display
--      displayType = display defined in Config.displayTypes
-- jobs = Table of jobs which are allowed to use the dyno (false or nil to allow everyone to use it)
Config.dynos = {
    ['exotics'] = {
        coords = vector3(556.34, -198.79, 54.13),
        heading = 90.0,
        
        displays = {
            {
                displayCoords = vector3(560.62, -197.79, 55.38),
                displayHeading = 90.0,
                displayTilt = 3.0,
                displayType = 'wall_tv',
            },
            {
                displayCoords = vector3(552.77, -196.43, 54.51),
                displayHeading = 235.0,
                displayType = 'stand',
            }
        },
        
        jobs = nil,
    },
    ['redline'] = {
        coords = vector3(-573.01, -937.18, 23.57),
        heading = 0.0,

        displays = {
            {
                displayCoords = vector3(-570.24, -934.29, 23.89),
                displayHeading = 320.0,
                displayType = 'stand',
            },
        },
        
        jobs = nil,
    },  
}


-- This is just used to fill the default dynos with their rollers
Config.baseRollers = {
    {
        prop = 'kq_dyno_roller',
        rotation = vector3(0.0, 90.0, 0.0),
        offset = vector3(0.18, 0.6, -0.08),
        direction = -1,
        side = 1,
    },
    {
        prop = 'kq_dyno_roller',
        rotation = vector3(0.0, 90.0, 0.0),
        offset = vector3(-0.18, 0.6, -0.08),
        direction = -1,
        side = 1,
    },

    {
        prop = 'kq_dyno_roller',
        rotation = vector3(0.0, 90.0, 0.0),
        offset = vector3(0.18, -1.18, -0.08),
        direction = -1,
        side = 2,
    },
    {
        prop = 'kq_dyno_roller',
        rotation = vector3(0.0, 90.0, 0.0),
        offset = vector3(-0.18, -1.18, -0.08),
        direction = -1,
        side = 2,
    },
}

-- Dyno models
Config.dynoModels = {
    ['default_yellow'] = {
        base = 'kq_dyno2_yellow',
        textureVariation = 0,
        heading = -90.0,
        offset = vector3(0.0, 0.0, -0.04),
        rollers = Config.baseRollers,
    },
    ['default_red'] = {
        base = 'kq_dyno2_red',
        textureVariation = 0,
        heading = -90.0,
        offset = vector3(0.0, 0.0, -0.04),
        rollers = Config.baseRollers,
    },
    ['default_purple'] = {
        base = 'kq_dyno2_purple',
        textureVariation = 0,
        heading = -90.0,
        offset = vector3(0.0, 0.0, -0.04),
        rollers = Config.baseRollers,
    },
    ['default_green'] = {
        base = 'kq_dyno2_green',
        textureVariation = 0,
        heading = -90.0,
        offset = vector3(0.0, 0.0, -0.04),
        rollers = Config.baseRollers,
    },
    ['default_gray'] = {
        base = 'kq_dyno2_gray',
        textureVariation = 0,
        heading = -90.0,
        offset = vector3(0.0, 0.0, -0.04),
        rollers = Config.baseRollers,
    },
    ['default_blue'] = {
        base = 'kq_dyno2_blue',
        textureVariation = 0,
        heading = -90.0,
        offset = vector3(0.0, 0.0, -0.04),
        rollers = Config.baseRollers,
    },
    ['basic'] = {
        base = 'kq_dyno',
        textureVariation = 0,
        heading = -90.0,
        offset = vector3(0.0, 0.0, 0.0),
        rollers = {
            {
                prop = 'kq_dyno_roller',
                rotation = vector3(0.0, 90.0, 0.0),
                offset = vector3(0.18, 0.9, -0.08),
                direction = -1,
                side = 1,
            },
            {
                prop = 'kq_dyno_roller',
                rotation = vector3(0.0, 90.0, 0.0),
                offset = vector3(-0.18, 0.9, -0.08),
                direction = -1,
                side = 1,
            },

            {
                prop = 'kq_dyno_roller',
                rotation = vector3(0.0, 90.0, 0.0),
                offset = vector3(0.18, -0.9, -0.08),
                direction = -1,
                side = 2,
            },
            {
                prop = 'kq_dyno_roller',
                rotation = vector3(0.0, 90.0, 0.0),
                offset = vector3(-0.18, -0.9, -0.08),
                direction = -1,
                side = 2,
            },
        }
    },
}

-- Display types
-- prop = prop of the display
-- offset = offset of the display (texture, not the prop)
-- heading = heading of the display (texture, not the prop)
-- size = size of the display
Config.displayTypes = {
    ['stand'] = {
        prop = 'prop_cs_tv_stand',
        offset = vector3(0.529, -0.08, 1.01),
        heading = 180.0,
        size = vector2(1.098, 0.54),
    },
    ['monitor'] = {
        prop = 'prop_tv_flat_03',
        offset = vector3(0.35, -0.01, 0.025),
        heading = 180.0,
        size = vector2(0.7, 0.4),
    },
    ['wall_tv'] = {
        prop = 'prop_tv_flat_01',
        offset = vector3(1.07, -0.06, -0.12),
        heading = 180.0,
        size = vector2(2.14, 1.2),
    },
    ['wall_tv_2'] = {
        prop = 'xm_prop_x17_tv_flat_01',
        offset = vector3(0.798, -0.046, 0.152),
        heading = 180.0,
        size = vector2(1.5, 0.832),
    },
}

-- https://docs.fivem.net/docs/game-references/controls/
-- Use the input index for the "input" value
Config.keybinds = {
    start = {
        label = 'E',
        name = 'INPUT_PICKUP',
        input = 38,
    },
}
