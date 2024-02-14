Config = {}

Config.debug = false

--- SETTINGS FOR ESX
Config.esxSettings = {
    enabled = false,
    -- Whether or not to use the new ESX export method
    useNewESXExport = true,

    oldEsx = false, -- use this when on a very old version of esx
}

--- SETTINGS FOR QBCORE
Config.qbSettings = {
    enabled = true,
    useNewQBExport = true, -- Make sure to uncomment the old export inside fxmanifest.lua if you're still using it
}


Config.sql = {
    driver = 'oxmysql', -- oxmysql or ghmattimysql or mysql
    -- If you're using an older version of oxmysql set this to false
    newOxMysql = true,
}


-- I DO NOT RECOMMEND USING TARGET AS SOME SMALLER PROPS MAY BE DIFFICULT TO PICKUP FROM THE TRUCK BED (USING CERTAIN TARGET SYSTEMS)
Config.target = {
    enabled = true,
    system = 'ox_target' -- 'qtarget' or 'qb-target' or 'ox_target'  (Other systems might work as well)
}

-- Saving placed items in the database
Config.objectPersistence = {
    -- Whether the script should save items placed on the ground in the database and load them back up after restart
    enabled = true,

    -- Whether to show warnings when items that somehow got duplicated by an client got picked up twice
    -- (The players wont receive the duplicated item regardless)
    showWarnings = true,

    -- Whether to display a little hint when placing an item which will be persistent
    showHint = true,
}

-- When not using target
-- '3d-text', 'top-left', 'help-text'
Config.inputType = '3d-text'

-- Font used for the 3d text
Config.textFont = 4

-- Scale used for the 3d text
Config.textScale = 1.0

-- Outline shown on props that the player can pickup
Config.outline = {
    enabled = true,
    color = {
        r = 126,
        g = 207,
        b = 147,
        a = 144,
    }
}

-- The opacity of the placement box color
Config.boxOpacity = 150

-- Command which will open the "place an item" menu
Config.menuCommand = {
    enabled = true,
    command = 'placeitem',
    
    aliasEnabled = true,
    aliasCommand = 'pi',
}

-- Whether or not to disable item stacking (placing items on top of other items)
-- This can rarely cause collision issues with some vehicles. Therefore its off by default
Config.disallowItemStacking = true

-- Whether or not to make all items placeable.
-- When disabled only the items defined below will be placeable
Config.makeEverythingPlaceable = {
    enabled = false,
    fallbackProp = 'hei_prop_heist_box',
}

-- Whether or not players will be allowed to place items on roofs of cars
Config.allowPlacingOnRoofs = true

-- All placeable items with the amounts and props defined
-- https://gta-objects.xyz/objects
Config.items = {
    
    ['phone'] = {
        [1] = 'prop_player_phone_01',
    },
    ['laptop'] = {
        [1] = 'prop_laptop_02_closed',
    },

    --weapons
    ['weapon_bat'] = {
        [1] = 'p_cs_bbbat_01',
    },
    ['weapon_crowbar'] = {
        [1] = 'prop_ing_crowbar',
    },
    ['weapon_pistol'] = {
        [1] = 'w_pi_pistol',
    },
    ['weapon_pistolxm3'] = {
        [1] = 'w_pi_heavypistol',
    },
    ['weapon_petrolcan'] = {
        [1] = 'w_am_jerrycan',
    },
    ['clip_attachment'] = {
        [1] = 'w_pi_pistol_mag1',
    },
    ['clip_attachment'] = {
        [1] = 'w_pi_pistol_mag1',
    },

    --ammo
    ['pistol_ammo'] = {
        [1] = 'prop_ld_ammo_pack_01',
    },

    --drink
    ['water_bottle'] = {
        [1] = 'apa_mp_h_acc_bottle_01',
    },
    ['coffee'] = {
        [1] = 'p_ing_coffeecup_01',
    },
    ['kurkakola'] = {
        [1] = 'prop_ecola_can',
    },
    ['beer'] = {
        [1] = 'prop_beer_am',
    },
    ['whiskey'] = {
        [1] = 'prop_whiskey_bottle',
    },
    ['vodka'] = {
        [1] = 'prop_vodka_bottle',
    },
    ['grape'] = {
        [1] = 'p_kitch_juicer_s',
    },
    ['wine'] = {
        [1] = 'prop_wine_rose',
    },
}

-- https://docs.fivem.net/docs/game-references/controls/
-- Use the input index for the "input" value
Config.keybinds = {
    openMenu = {
        enabled = true,
        key = 'F4',
    },
    pickup = {
        label = 'E',
        name = 'INPUT_PICKUP',
        input = 38,
        duration = 1000,
    },
    place = {
        label = 'E',
        name = 'INPUT_PICKUP',
        input = 38,
    },
    cancelPlacing = {
        label = 'Backspace',
        name = 'INPUT_CELLPHONE_CANCEL',
        input = 177,
    },
    exit = {
        label = 'Escape',
        name = 'INPUT_CELLPHONE_CANCEL',
        input = 177,
    },
    arrowUp = {
        label = 'Arrow up',
        name = 'INPUT_CELLPHONE_UP',
        input = 172,
    },
    arrowDown = {
        label = 'Arrow down',
        name = 'INPUT_CELLPHONE_DOWN',
        input = 173,
    },
    upAlternative = {
        label = 'Scroll up',
        name = 'INPUT_VEH_CINEMATIC_UP_ONLY',
        input = 96,
    },
    downAlternative = {
        label = 'Scroll down',
        name = 'INPUT_VEH_CINEMATIC_DOWN_ONLY',
        input = 97,
    },
    confirm = {
        label = 'Enter',
        name = 'INPUT_FRONTEND_ACCEPT',
        input = 201,
    },
}
