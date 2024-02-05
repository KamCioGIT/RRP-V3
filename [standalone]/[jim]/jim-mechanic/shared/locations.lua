Config.Locations = Config.Locations or {}

Config.Locations[#Config.Locations+1] = { --[[ GABZ ALTA STREET BENNYS ]]--
	Enabled = true,
	job = "exotics",
	zones = {
		vec2(537.36, -223.10),
		vec2(529.83, -148.50),
		vec2(559.43, -151.04),
		vec2(563.25, -212.77)
	},
	autoClock = { enter = true, exit = true, },
	stash = {
		{ coords = vec4(560.13, -181.09, 54.51, 264.45), w = 3.6, d = 0.8, },
	},
	store = {
		{ coords = vec4(-228.64, -1314.19, 3.3, 90.0), w = 3.60, d = 0.8 },
	},
	crafting = {
		{ coords = vec4(555.68, -185.91, 54.51, 175.58), w = 2.8, d = 1.5 },
	},
	clockin = {
		{ coords = vec4(-195.55, -1316.46, 3.2, 181.72), prop = false },
	},
	manualRepair = {
		{ coords = vec4(-200.28, -1311.62, 31.3, 0.0), prop = true, },
	},
	carLift = {
        { coords = vec4(553.79, -175.37, 54.51, 89.18), useMLOLift = false },
    },
	garage = {
		spawn = vec4(-182.74, -1317.61, 0.63, 357.23),
		out = vec4(-190.62, -1311.57, 3.3, 0.0),
		list = { "towtruck", "panto", "slamtruck", "cheburek", "utillitruck3" },
		prop = true
	},
	payments = {
		img = "https://static.wikia.nocookie.net/gtawiki/images/b/be/BennysOriginalMotorWorks-GTAO-Logo.png",
		{ coords = vec4(-192.21, -1316.34, 31.10, 285.83), prop = true },
	},
	Restrictions = {
		Vehicle = { "Compacts", "Sedans", "SUVs", "Coupes", "Muscle", "Sports Classics", "Sports", "Super", "Motorcycles", "Off-road", "Industrial", "Utility", "Vans", "Cycles", "Service", "Emergency", "Commercial", },
		Allow = { "tools", "cosmetics", "repairs", "nos", "perform" },
	},
	blip = {
		coords = vec3(550.73, -184.60, 54.51),
		label = "Auto Exotics",
		color = 3,
		sprite = 446,
		disp = 6,
		scale = 0.7,
		cat = nil,
	},
	discord = {
		link = "",
		color = 16711680,
	}
}

Config.Locations[#Config.Locations+1] = { --[[ LS CUSTOMS IN CITY ]]--
	Enabled = true,
	job = "redline",
	zones = {
		vec2(-554.50, -910.27),
		vec2(-557.22, -940.79),
		vec2(-596.35, -941.59),
		vec2(-595.89, -906.43)
	},
	autoClock = { enter = true, exit = true, },
	stash = {
		{ coords = vec4(-586.60, -932.56, 23.89, 87.12), w = 4.0, d = 1.0, },
	},
	store = {
		{ coords = vec4(-347.9, -133.19, 3.01, 340.0), w = 1.2, d = 0.25, },
	},
	crafting = {
		{ coords = vec4(-584.02, -938.89, 23.89, 179.95), w = 3.2, d = 1.0, },
	},
	clockin = {
		{ coords = vec4(-344.85, -140.35, 3.05, 157.0), prop = true },
	},
	manualRepair = {
		{ coords = vec4(-554.61, -914.88, 23.88, 267.58), prop = true, },
	},
	garage = {
		spawn = vec4(-361.48, -123.14, 3.03, 158.96),
		out = vec4(-356.2, -126.55, 3.43, 253.49),
		list = { "towtruck", "panto", "slamtruck", "cheburek", "utillitruck3" },
		prop = true
	},
	payments = {
		img = "https://static.wikia.nocookie.net/gtawiki/images/f/f2/GTAV-LSCustoms-Logo.png",
		{ coords = vec4(-343.75, -140.86, 3.02, 180.0), prop = true, },
	},
	Restrictions = {
		Vehicle = { "Compacts", "Sedans", "SUVs", "Coupes", "Muscle", "Sports Classics", "Sports", "Super", "Motorcycles", "Off-road", "Industrial", "Utility", "Vans", "Cycles", "Service", "Emergency", "Commercial", },
		Allow = { "tools", "cosmetics", "repairs", "nos", "perform" },
	},
	blip = {
		coords = vec3(-573.40, -929.70, 23.47),
		label = "Redline Performance",
		color = 2,
		sprite = 446,
		disp = 6,
		scale = 0.7,
		cat = nil,
	},
	discord = {
		link = "",
		color = 2571775,
	}
}