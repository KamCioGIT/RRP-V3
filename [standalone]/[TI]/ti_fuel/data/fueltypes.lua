fuelTypes = {  
    ["Diesel"] = {
        ["isDiesel"]        = true,
        ["knock"]           = 1.0,
        ["inefficiency"]    = 1.0,
        ["power"]           = 1.0,
    },

    ["Electric"] = {
        ["isElectric"]      = true, -- Is this fuel used for electric vehicles only?
        ["knock"]           = 0.0,  -- Knock Rating: Facilitates higher peak torque value with engine builder/tuning. Lower value is better.
        ["inefficiency"]    = 1.0,  -- Inefficiency  Rating: How fast this fuel will burn. Directly effects both engine efficiency and fuel drain rate. Lower is better.
        ["power"]           = 1.0,  -- Power Rating: Peak power output modifier for tuning and engine builder. Naturally aspirated engines will need access to high power fuels.
    },                              --               This will be the only defining factor in whether naturally aspirated engines can remain competitive against boosted variants.

    ["RON91"] = {
        ["knock"]           = 1.4,
        ["inefficiency"]    = 1.4,
        ["power"]           = 0.6,
    },
    
    ["RON95"] = {
        ["knock"]           = 1.2,
        ["inefficiency"]    = 1.2,
        ["power"]           = 0.8,
    },
    
    ["RON98"] = {
        ["knock"]           = 1.0,
        ["inefficiency"]    = 1.0,
        ["power"]           = 1.0,
    },
    
    ["MET100"] = {
        ["knock"]           = 0.8,
        ["inefficiency"]    = 1.5,
        ["power"]           = 1.25,
    },
    
    ["MET80/NIT20"] = {
        ["knock"]           = 0.6,
        ["inefficiency"]    = 2.0,
        ["power"]           = 1.5,
    },
    
    ["MET60/NIT40"] = {
        ["knock"]           = 0.4,
        ["inefficiency"]    = 3.0,
        ["power"]           = 2.0,
    },
}

exports("getFuelTypes",function()
    return fuelTypes
end)