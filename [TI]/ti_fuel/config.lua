config = {
    -- Should the vehicle be emptied of all passengers before refueling process begins?
    -- Setting this to true will ensure no loss of fuel if the driver is changed during the refueling process.
    forceEmptyVehicleToRefuel = true,

    defaultPetrolFuel = "RON91",
    defaultElectricFuel = "Electric",
    defaultDieselFuel = "Diesel",

    controlA = 38,
    controlB = 47,

    -- Minimum fuel amount.
    -- 0.0 = default behaviour, vehicle backfires and stutters with low fuel.
    -- 5.0 = vehicle stutters and backfires, never stalls completely/moves backwards.
    -- 10.0 = vehicle stutters slightly, never backfires
    minFuel = 10.0,

    -- Default fuel level that vehicles start with.
    defaultFuelLevel = 50.0,

    -- Interact distance for players. Vehicle interact distance is 2x this.
    interactDist = 2.5,

    -- Hose distance, aka maximum distance for the nozzle to reach.
    hoseDist = 5.0,

    -- Minimum distance to stations to consider any actions.
    renderDist = 50.0,

    -- Size (litres) of a jerry can (or battery, for EVs).
    jerryCanSize = 10.0,

    -- How long it takes to refuel using a jerrycan (or battery).
    jerryCanTime = 5000,

    -- On refueling (nozzle attached to vehicle, actively pumping fuel), when player drives away with nozzle attached.
    allowRefuelingExplosions = true, 

    -- Keep nozzle attached after explosion? May help police figure out who caused a petrol bowser explosion in the area.
    keepNozzleAttached = true, 

    -- Controls how blips are displayed.
    -- 0 = off
    -- 1 = all on
    -- 2 = display only closest
    blipDisplay = 2,

    -- Blip data.
    blip = {
        label = "Fuel Station",
        sprite = 361,
        color = 1,
        alpha = 150,
        scale = 0.5,
        display = 2,
        highDetail = true,
        shortRange = true
    },

    -- How much fuel is drained per fuelDrainRate.
    fuelDrainRate = 0.5,

    -- How fast to drain fuel.
    -- NOTE: With 1.0 fuelDrainRate, and 1000 fuelDrainTime, the drain rate for any vehicle (other modifiers not considered)
    --       would equate to exactly 1% of your fuel being drained every 1000ms (1 second).
    fuelDrainTime = 10 * 1000,

    -- Base refuel rate.
    -- Can be supplemented further with individual station pump speeds.
    refuelAddRate = 5.0, 

    -- Fuel economy based on vehicle class
    -- Lower = less fuel used
    classEconomy = {
        [0] = 0.5,
        [1] = 0.8,
        [2] = 1.0,
        [3] = 0.7,
        [4] = 1.0,
        [5] = 1.0,
        [6] = 0.9,
        [7] = 1.0,
        [8] = 0.2,
        [9] = 1.5,
        [10] = 1.5,
        [11] = 0.6,
        [12] = 0.0,
        [13] = 0.0,
        [14] = 0.0,
        [15] = 0.0,
        [16] = 0.1,
        [17] = 0.1,
        [18] = 1.0,
        [19] = 1.0,
        [20] = 1.0,
        [21] = 0.0,
    },

    -- Fuel tank size based on vehicle class
    -- Lower value = less time to burn max fuel reserve,
    --               also less time to refuel vehicle at station.
    classTank = {
        [0] = 0.6,
        [1] = 1.0,
        [2] = 1.5,
        [3] = 0.8,
        [4] = 1.0,
        [5] = 1.0,
        [6] = 0.9,
        [7] = 0.8,
        [8] = 0.3,
        [9] = 0.7,
        [10] = 10.0,
        [11] = 2.0,
        [12] = 2.0,
        [13] = 1.0,
        [14] = 1.0,
        [15] = 100.0,
        [16] = 100.0,
        [17] = 5.0,
        [18] = 5.0,
        [19] = 5.0,
        [20] = 1.0,
        [21] = 1.0,
    },

    -- How much fuel is used at given RPM
    rpmUsage = {
        [1.0] = 1.00,
        [0.9] = 0.90,
        [0.8] = 0.80,
        [0.7] = 0.70,
        [0.6] = 0.60,
        [0.5] = 0.50,
        [0.4] = 0.40,
        [0.3] = 0.30,
        [0.2] = 0.20,
        [0.1] = 0.10,
        [0.0] = 0.00,
    },   

    electricVehicles = {
        `Imorgon`,
        `Neon`,
        `Raiden`,
        `Cyclone`,
        `Voltic`,
        `Voltic2`,
        `Tezeract`,
        `Dilettante`,
        `Dilettante2`,
        `Airtug`,
        `Caddy`,
        `Caddy2`,
        `Caddy3`,
        `Surge`,
        `Khamelion`,
        `RCBandito`,
        `teslax`,
    },

    dieselVehicles = {
        `Hauler`,
        `Phantom`
    },

    -- Fuel won't drain with these vehicles.
    blacklist = {
        `rca350`,
        `rcbandito`,
        `rcbandito2`,
        `grc86gt`,
        `rc599xx`,
        `rcmonster`,
        `rcruiner`,
        `rcsultanrs`,
        `minitank`,
        `rca350`,
        `rcbuzzard2`,
        `rcbesra`,
        `rcdinghy2`
    }
}

exports("getConfig",function(k)
    if k then
        return config[k]
    end

    return config
end)