local defaultFuelTypes = {
    ["RON91"] = {
        stock = 1000.0,
        min = 0.0,
        max = 1000.00,

        sellPrice = 1.0,
        sellUntil = 0.0,
        buyPrice  = 0.5,
        buyUntil  = 1000.0,

        restockTime = 60,
        restockAmount = 5.0    
    },

    ["RON95"] = {
        stock = 500.0,
        min = 0.0,
        max = 500.00,
        
        sellPrice = 1.5,
        sellUntil = 0.0,
        buyPrice  = 0.75,
        buyUntil  = 500.0,

        restockTime = 60,
        restockAmount = 5.0                    
    },

    ["RON98"] = {
        stock = 250.0,
        min = 0.0,
        max = 250.00,
        
        sellPrice = 2.0,
        sellUntil = 0.0,
        buyPrice  = 1.0,
        buyUntil  = 250.0,

        restockTime = 60,
        restockAmount = 5.0                    
    },

    ["MET100"] = {
        stock = 100.0,
        min = 0.0,
        max = 100.00,
        
        sellPrice = 4.0,
        sellUntil = 0.0,
        buyPrice  = 8.0,
        buyUntil  = 100.0,

        restockTime = 60,
        restockAmount = 5.0                    
    },

    ["MET80/NIT20"] = {
        stock = 50.0,
        min = 0.0,
        max = 50.00,
        
        sellPrice = 5.0,
        sellUntil = 0.0,
        buyPrice  = 2.5,
        buyUntil  = 50.0,

        restockTime = 60,
        restockAmount = 5.0                    
    },

    ["Diesel"] = {
        stock = 1000.0,
        min = 0.0,
        max = 1000.00,

        sellPrice = 1.0,
        sellUntil = 0.0,
        buyPrice  = 0.5,
        buyUntil  = 1000.0,

        restockTime = 60,
        restockAmount = 5.0    
    },

    ["Electric"] = {
        stock = 100000.00,
        min = 0.0,
        max = 100000.00,
        
        sellPrice = 0.2,
        sellUntil = 0.0,
        buyPrice  = 0.1,
        buyUntil  = 100000.0,

        restockTime = 1,
        restockAmount = 100.0
    },    
}

local electricPumpFuels = {
    ["Electric"] = {
        stock = 100000.00,
        min = 0.0,
        max = 100000.00,
        
        sellPrice = 0.2,
        sellUntil = 0.0,
        buyPrice  = 0.1,
        buyUntil  = 100000.0,

        restockTime = 1,
        restockAmount = 100.0
    },    
}

local function copy(t)
    return json.decode( json.encode(t) )
end

local cid = 0

local function getId()
    cid = cid + 1
    return cid
end

stations = {
    {
        id = getId(),
        label = "LTD Gasoline",
        position = vec3(-55.062023, -1759.029541, 28.997717),
        
        menuPosition = vector3(-44.09,-1749.32,29.42),
        depositPosition = vector3(-67.59,-1748.44,29.46),

        pumpModel = `prop_gas_pump_1c`,
        pumpSpeed = 10.0,
        pumps = {
            vec3(-72.034302, -1765.105957, 28.528473),
            vec3(-69.454819, -1758.018799, 28.541801),
            vec3(-61.034252, -1760.850586, 28.300560),
            vec3(-80.172318, -1762.143799, 28.798901),
            vec3(-77.592751, -1755.056885, 28.807949),
            vec3(-63.613739, -1767.937744, 28.261608)
        },
        fuels = copy(defaultFuelTypes),
        addons = {
            {
                position = vector3(-50.68,-1767.26,29.27),
                heading = 47.74,
                model = `prop_gas_pump_1d`,
                fuels = copy(electricPumpFuels)
            }
        }
    },
    {
        id = getId(),
        label = "Xero Gas",
        position = vec3(280.581970, -1260.945313, 29.213697),
        pumpModel = `prop_gas_pump_1d`,
        pumps = {
            vec3(273.838593, -1261.298340, 28.286133),
            vec3(265.062714, -1261.298340, 28.292721),
            vec3(265.062714, -1268.639648, 28.291122),
            vec3(273.838593, -1268.639648, 28.290600),
            vec3(256.433380, -1261.298340, 28.291531),
            vec3(256.433380, -1268.639648, 28.291168),
            vec3(285.049988, -1271.630005, 28.282282),
            vec3(273.838593, -1253.461426, 28.291832),
            vec3(265.062714, -1253.461426, 28.289986),
            vec3(256.433380, -1253.461426, 28.286732),
            vec3(285.049988, -1271.630005, 28.282282)
        },
        fuels = copy(defaultFuelTypes),
        addons = {}
    },
    {
        id = getId(),
        label = "Ron Gas",
        position = vec3(1202.962158, -1407.677002, 35.224308),
        pumpModel = `prop_gas_pump_1a`,
        pumps =  {
            vec3(1212.937256, -1404.030029, 34.384960),
            vec3(1210.064697, -1406.903076, 34.384960),
            vec3(1204.195313, -1401.033691, 34.384960),
            vec3(1207.068115, -1398.160889, 34.384960),
            vec3(285.049988, -1271.630005, 28.282282)
        },
        fuels = copy(defaultFuelTypes),
        addons = {}
    },
    {
        id = getId(),
        label = "Ron Gas",
        position = vec3(820.571594, -1020.467346, 26.174856),
        pumpModel = `prop_gas_pump_1a`,
        pumps = {
            vec3(818.986084, -1026.247803, 25.435555),
            vec3(818.986084, -1030.941406, 25.435555),
            vec3(810.698975, -1030.941406, 25.435555),
            vec3(810.698975, -1026.247803, 25.435555),
            vec3(827.293335, -1026.247803, 25.635113),
            vec3(827.293335, -1030.941406, 25.635113)
        },
        fuels = copy(defaultFuelTypes),
        addons = {}
    },
    {
        id = getId(),
        label = "LTD Gasoline",
        position = vec3(1189.148315, -329.166748, 69.175362),
        pumpModel = `prop_gas_pump_1c`,
        pumps = {
            vec3(1178.963257, -339.543060, 68.365601),
            vec3(1177.459839, -331.014374, 68.318726),
            vec3(1186.390991, -338.233246, 68.356384),
            vec3(1184.887085, -329.704803, 68.309540),
            vec3(1183.129272, -320.996552, 68.350693),
            vec3(1175.701538, -322.306122, 68.358780)
        },
        fuels = copy(defaultFuelTypes),
        addons = {}
    },
    {
        id = getId(),
        label = "LTD Gasoline",
        position = vec3(1189.148315, -329.166748, 69.175362),
        pumpModel = `prop_gas_pump_1c`,
        pumps = {
            vec3(1178.963257, -339.543060, 68.365601),
            vec3(1177.459839, -331.014374, 68.318726),
            vec3(1186.390991, -338.233246, 68.356384),
            vec3(1184.887085, -329.704803, 68.309540),
            vec3(1183.129272, -320.996552, 68.350693),
            vec3(1175.701538, -322.306122, 68.358780)
        },
        fuels = copy(defaultFuelTypes),
        addons = {}
    },
    {
        id = getId(),
        label = "Globe Oil",
        position = vec3(621.737671, 278.638489, 103.089470),
        pumpModel = `prop_gas_pump_1b`,
        pumps = {
            vec3(629.634521, 263.835693, 102.269516),
            vec3(620.990112, 263.835938, 102.269516),
            vec3(629.630615, 273.969849, 102.269516),
            vec3(620.986084, 273.969788, 102.269516),
            vec3(612.421021, 273.957153, 102.269516),
            vec3(612.432251, 263.835754, 102.269516)
        },
        fuels = copy(defaultFuelTypes),
        addons = {}
    },
    {
        id = getId(),
        label = "Ron Gas",
        position = vec3(-1444.756470, -282.825562, 46.082443),
        pumpModel = `prop_gas_pump_1a`,
        pumps = {
            vec3(-1438.072021, -268.697815, 45.403587),
            vec3(-1435.507446, -284.686401, 45.402596),
            vec3(-1429.075928, -279.151855, 45.402596),
            vec3(-1444.503540, -274.232361, 45.403587)
        },
        fuels = copy(defaultFuelTypes),
        addons = {}
    },
    {
        id = getId(),
        label = "Ron Gas",
        position = vec3(-1444.756470, -282.825562, 46.082443),
        pumpModel = `prop_gas_pump_1a`,
        pumps = {
            vec3(-1438.072021, -268.697815, 45.403587),
            vec3(-1435.507446, -284.686401, 45.402596),
            vec3(-1429.075928, -279.151855, 45.402596),
            vec3(-1444.503540, -274.232361, 45.403587)
        },
        fuels = copy(defaultFuelTypes),
        addons = {}
    },
    {
        id = getId(),
        label = "Xero Gas",
        position = vec3(-2081.998535, -320.395416, 13.059210),
        pumpModel = `prop_gas_pump_1d`,
        pumps = {
            vec3(-2096.814453, -320.117889, 12.160918),
            vec3(-2105.396729, -319.215912, 12.160918),
            vec3(-2096.096436, -311.906891, 12.160918),
            vec3(-2088.086670, -321.035248, 12.160918),
            vec3(-2104.535156, -311.019836, 12.160918),
            vec3(-2106.065674, -325.579468, 12.160918),
            vec3(-2097.483398, -326.481506, 12.160918),
            vec3(-2088.755615, -327.398804, 12.160918),
            vec3(-2087.215332, -312.818481, 12.160918)
        },
        fuels = copy(defaultFuelTypes),
        addons = {}
    },
    {
        id = getId(),
        label = "LTD Gasoline",
        position = vec3(-1805.487427, 809.391479, 138.501953),
        pumpModel = `prop_gas_pump_1c`,
        pumps = {
            vec3(-1808.719116, 799.951416, 137.685410),
            vec3(-1797.223999, 800.552612, 137.654816),
            vec3(-1802.318970, 806.112915, 137.651703),
            vec3(-1803.623657, 794.390747, 137.689835),
            vec3(-1790.838745, 806.402954, 137.695129),
            vec3(-1795.934448, 811.963623, 137.690216)
        },
        fuels = copy(defaultFuelTypes),
        addons = {}
    },
    {
        id = getId(),
        label = "Xero Gas",
        position = vec3(-528.936279, -1220.438599, 18.454943),
        pumpModel = `prop_gas_pump_1d`,
        pumps = {
            vec3(-521.217285, -1208.234375, 17.325386),
            vec3(-524.926758, -1216.152100, 17.325386),
            vec3(-518.525635, -1209.504395, 17.325161),
            vec3(-522.234985, -1217.422119, 17.325161),
            vec3(-525.807617, -1206.044922, 17.325386),
            vec3(-528.575806, -1204.801270, 17.325386),
            vec3(-529.517090, -1213.962646, 17.325386),
            vec3(-532.285278, -1212.718750, 17.325386)
        },
        fuels = copy(defaultFuelTypes),
        addons = {}
    },
    {
        id = getId(),
        label = "Ron Gas",
        position = vec3(2580.865723, 373.754730, 108.472679),
        pumpModel = `prop_gas_pump_1a`,
        pumps = {
            vec3(2580.934082, 358.885071, 107.650780),
            vec3(2581.173584, 364.384735, 107.650009),
            vec3(2573.544678, 359.206970, 107.651154),
            vec3(2573.784180, 364.706665, 107.650566),
            vec3(2588.645752, 364.059204, 107.650497),
            vec3(2588.406006, 358.559570, 107.650833)
        },
        fuels = copy(defaultFuelTypes),
        addons = {}
    },
    {
        id = getId(),
        label = "Globe Oil",
        position = vec3(-324.699280, -1463.716309, 30.545633),
        pumpModel = `prop_gas_pump_1b`,
        pumps = {
            vec3(-317.262848, -1476.091797, 29.725029),
            vec3(-324.749115, -1480.414063, 29.728859),
            vec3(-329.819550, -1471.639648, 29.729012),
            vec3(-322.333221, -1467.317627, 29.720665),
            vec3(-309.851532, -1471.798340, 29.723412),
            vec3(-314.921967, -1463.038574, 29.726250)
        },
        fuels = copy(defaultFuelTypes),
        addons = {}
    },
    {
        id = getId(),
        label = "Ron Gas",
        position = vec3(182.873901, -1569.809448, 29.279873),
        pumpModel = `prop_gas_pump_1a`,
        pumps = {
            vec3(169.297256, -1562.266968, 28.329025),
            vec3(181.806717, -1561.969849, 28.329025),
            vec3(174.980148, -1568.444214, 28.329025),
            vec3(176.020767, -1555.911499, 28.328381)
        },
        fuels = copy(defaultFuelTypes),
        addons = {}
    },
    {
        id = getId(),
        label = "LTD Gasoline",
        position = vec3(-721.784363, -943.736145, 18.928698),
        pumpModel = `prop_gas_pump_1c`,
        pumps = {
            vec3(-724.007385, -932.516235, 18.211670),
            vec3(-732.645813, -932.516235, 18.211670),
            vec3(-715.437439, -939.321655, 18.211670),
            vec3(-715.437439, -932.516235, 18.211670),
            vec3(-724.007385, -939.321655, 18.211670),
            vec3(-732.645813, -939.321655, 18.211670)
        },
        fuels = copy(defaultFuelTypes),
        addons = {}
    },
    {
        id = getId(),
        label = "Ron Gas",
        position = vec3(-2544.380615, 2333.392334, 33.059910),
        pumpModel = `prop_gas_pump_1a`,
        pumps = {
            vec3(-2552.398438, 2341.891602, 32.216003),
            vec3(-2558.484619, 2334.133789, 32.255470),
            vec3(-2552.607178, 2334.467529, 32.254150),
            vec3(-2558.772461, 2341.487793, 32.225220),
            vec3(-2558.021484, 2326.704346, 32.256134), 
            vec3(-2551.396240, 2327.115479, 32.246918)
        },
        fuels = copy(defaultFuelTypes),
        addons = {
            {
                model = `prop_gas_pump_1d`,
                position = vector3(-2540.66,2346.95,33.06),
                heading = 274.10,
                fuels = copy(electricPumpFuels)
            }
        }
    },
    {
        id = getId(),
        label = "Gas Station",
        position = vec3(46.751637, 2773.812744, 57.878296),
        pumpModel = `prop_gas_pump_old2`,
        pumps = {
            vec3(50.305706, 2778.534668, 57.041401),
            vec3(48.913097, 2779.585449, 57.041401)
        },
        fuels = copy(defaultFuelTypes),
        addons = {}
    },
    {
        id = getId(),
        label = "Gas Station",
        position = vec3(263.242249, 2610.901367, 44.855785),
        pumpModel = `prop_vintage_pump`,
        pumps = {
            vec3(263.082581, 2606.794678, 43.983231),
            vec3(264.976318, 2607.177734, 43.983231)
        },
        fuels = copy(defaultFuelTypes),
        addons = {}
    },
    {
        id = getId(),
        label = "Gas Station",
        position = vec3(1212.460815, 2664.256104, 37.806637),
        pumpModel = `prop_vintage_pump`,
        pumps = {
            vec3(1209.581543, 2658.351563, 36.899551),
            vec3(1208.509766, 2659.427979, 36.898148),
            vec3(1205.899780, 2662.048584, 36.896744)
        },
        fuels = copy(defaultFuelTypes),
        addons = {}
    },
    {
        id = getId(),
        label = "Gas Station",
        position = vec3(2534.835205, 2593.299805, 37.944836),
        pumpModel = `prop_vintage_pump`,
        pumps = {
            vec3(2539.794434, 2594.807861, 36.955719)
        },
        fuels = copy(defaultFuelTypes),
        addons = {}
    },
    {
        id = getId(),
        label = "Gas Station",
        position = vec3(2686.094971, 3261.619141, 55.240559),
        pumpModel = `prop_gas_pump_old2`,
        pumps = {
            vec3(2678.512939, 3262.336914, 54.390862),
            vec3(2680.902344, 3266.407715, 54.390862)
        },
        fuels = copy(defaultFuelTypes),
        addons = {}
    },
    {
        id = getId(),
        label = "Gas Station",
        position = vec3(2007.785767, 3769.550537, 32.180828),
        pumpModel = `prop_gas_pump_old2`,
        pumps = {
            vec3(2006.205078, 3774.956543, 31.398464),
            vec3(2003.913818, 3773.476074, 31.398464),
            vec3(2001.546875, 3772.201660, 31.398464),
            vec3(2009.254395, 3776.773438, 31.398464)
        },
        fuels = copy(defaultFuelTypes),
        addons = {}
    },
    {
        id = getId(),
        label = "Gas Station",
        position = vec3(1691.083984, 4934.078613, 42.078094),
        pumpModel = `prop_gas_pump_old3`,
        pumps = {
            vec3(1690.094849, 4927.801758, 41.227695),
            vec3(1684.591187, 4931.655273, 41.227165)
        },
        fuels = copy(defaultFuelTypes),
        addons = {}
    },
    {
        id = getId(),
        label = "Gas Station",
        position = vec3(1039.257324, 2678.478760, 39.401550),
        pumpModel = `prop_vintage_pump`,
        pumps = {
            vec3(1043.219604, 2667.913818, 38.703453),
            vec3(1043.219360, 2674.445557, 38.703392),
            vec3(1035.442505, 2674.435791, 38.703194),
            vec3(1035.442383, 2667.904053, 38.703190) 
        },
        fuels = copy(defaultFuelTypes),
        addons = {}
    },
    {
        id = getId(),
        label = "Gas Station",
        position = vec3(1788.432739, 3332.496582, 41.202156),
        pumpModel = `prop_vintage_pump`,
        pumps = {
            vec3(1785.032471, 3331.476074, 40.343834),
            vec3(1786.079834, 3329.853516, 40.411945)
        },
        fuels = copy(defaultFuelTypes),
        addons = {}
    },
    {
        id = getId(),
        label = "Globe Oil",
        position = vec3(1699.829590, 6412.639648, 32.857891),
        pumpModel = `prop_gas_pump_1b`,
        pumps = {
            vec3(1697.756592, 6418.344238, 31.760010),
            vec3(1705.737061, 6414.600098, 31.760010),
            vec3(1701.724365, 6416.482910, 31.760010)
        },
        fuels = copy(defaultFuelTypes),
        addons = {}
    },
    {
        id = getId(),
        label = "Ron Gas",
        position = vec3(177.659027, 6613.473633, 31.829807),
        pumpModel = `prop_gas_pump_1a`,
        pumps = {
            vec3(186.970917, 6606.217773, 31.062500),
            vec3(154.462860, 6630.764648, 30.788544),
            vec3(156.143250, 6629.073242, 30.800079),
            vec3(179.674652, 6604.930664, 31.062500),
            vec3(172.333359, 6603.635742, 31.062500)
        },
        fuels = copy(defaultFuelTypes),
        addons = {}
    },
    {
        id = getId(),
        label = "Gas Station",
        position = vec3(-96.491173, 6421.608398, 31.472166),
        pumpModel = `prop_gas_pump_old2`,
        pumps = {
            vec3(-91.290451, 6422.537109, 30.643494),
            vec3(-97.060867, 6416.766602, 30.643494)
        },
        fuels = copy(defaultFuelTypes),
        addons = {}
    }
}

exports("getStations",function()
    return stations
end)

exports("getStation",function(k)
    return stations[k]
end)