

Loc = {}

Config = {
	Debug = false, -- enable debug mode
	img = "qb-inventory/html/images", --Set this to the image directory of your inventory script or "nil" if using newer qb-menu

	Lan = "en", -- Pick your language here

	JimShops = false, 		-- Set this to true if using jim-shops

	Inv = "qb",				--"qb" or "ox"
	Menu = "qb",			--"qb" or "ox"
	ProgressBar = "ox",		--"qb" or "ox"
	Notify = "ox",			--"qb" or "ox"

	DrillSound = true,		-- disable drill sounds

	MultiCraft = true,		-- Enable multicraft
	MultiCraftAmounts = { [1], [5], [10] },

	K4MB1Prop = false, -- Enable this to make use of K4MB1's ore props provided with their Mining Cave MLO

	Timings = { -- Time it takes to do things
		["Cracking"] = math.random(5000, 10000),
		["Washing"] = math.random(10000, 12000),
		["Panning"] = math.random(35000, 50000),
		["Pickaxe"] = math.random(15000, 18000),
		["Mining"] = math.random(10000, 15000),
		["Laser"] = math.random(7000, 10000),
		["OreRespawn"] = math.random(55000, 75000),
		["Crafting"] = 5000,
	},

	CrackPool = { -- Rewards from cracking stone
		"carbon",
		"copperore",
		"ironore",
		"metalscrap",
	},

	WashPool = {	-- Rewards from washing stone
		"goldore",
		"uncut_ruby",
		"uncut_emerald",
		"uncut_diamond",
		"uncut_sapphire",
		"goldore",
	},

	PanPool = {		-- Rewards from panning
		"goldore",
		"can",
		"goldore",
		"can",
		"can",
		"bottle",
		"goldore",
	},

------------------------------------------------------------
	OreSell = { -- List of ores you can sell to the buyer npc
		"goldingot",
		"silveringot",
		"copperore",
		"ironore",
		"goldore",
		"silverore",
		"carbon",
	},

	SellingPrices = { -- Selling Prices
		['copperore'] = 50,
		['goldore'] = 70,
		['silverore'] = 60,
		['ironore'] = 50,
		['carbon'] = 60,

		['goldingot'] = 75,
		['silveringot'] = 65,

		['uncut_emerald'] = 90,
		['uncut_ruby'] = 90,
		['uncut_diamond'] = 90,
		['uncut_sapphire'] = 90,

		['emerald'] = 120,
		['ruby'] = 120,
		['diamond'] = 120,
		['sapphire'] = 120,

		['diamond_ring'] = 200,
		['emerald_ring'] = 200,
		['ruby_ring'] = 200,
		['sapphire_ring'] = 200,
		['diamond_ring_silver'] = 170,
		['emerald_ring_silver'] = 170,
		['ruby_ring_silver'] = 170,
		['sapphire_ring_silver'] = 170,

		['diamond_necklace'] = 250,
		['emerald_necklace'] = 250,
		['ruby_necklace'] = 250,
		['sapphire_necklace'] = 250,
		['diamond_necklace_silver'] = 220,
		['emerald_necklace_silver'] = 220,
		['ruby_necklace_silver'] = 220,
		['sapphire_necklace_silver'] = 220,

		['diamond_earring'] = 300,
		['emerald_earring'] = 300,
		['ruby_earring'] = 300,
		['sapphire_earring'] = 300,
		['diamond_earring_silver'] = 275,
		['emerald_earring_silver'] = 275,
		['ruby_earring_silver'] = 275,
		['sapphire_earring_silver'] = 275,

		['gold_ring'] = 100,
		['goldchain'] = 125,
		['goldearring'] = 150,
		['silver_ring'] = 120,
		['silverchain'] = 130,
		['silverearring'] = 140,

	},
------------------------------------------------------------
--Mining Store Items
	Items = {
		label = "Mining Store",  slots = 8,
		items = {
			{ name = "water_bottle", price = 2, amount = 100, info = {}, type = "item", slot = 1, },
			{ name = "sandwich", price = 2, amount = 250, info = {}, type = "item", slot = 2, },
			{ name = "bandage", price = 5, amount = 100, info = {}, type = "item", slot = 3, },
			{ name = "goldpan", price = 50, amount = 100, info = {}, type = "item", slot = 4, },
			{ name = "pickaxe",	price = 150, amount = 100, info = {}, type = "item", slot = 5, },
			{ name = "miningdrill",	price = 3200, amount = 50, info = {}, type = "item", slot = 6, },
			{ name = "mininglaser",	price = 15000, amount = 5, info = {}, type = "item", slot = 7, },
			{ name = "drillbit", price = 5, amount = 100, info = {}, type = "item", slot = 8, },
		},
	},
}
Crafting = {
	SmeltMenu = {
		{ ["copper"] = { ["copperore"] = 1 }, ['amount'] = 4 },
		{ ["goldingot"] = { ["goldore"] = 1 } },
		{ ["goldingot"] = { ["goldchain"] = 3 } },
		{ ["goldingot"] = { ["gold_ring"] = 4 } },
		{ ["silveringot"] = { ["silverore"] = 1 } },
		{ ["silveringot"] = { ["silverchain"] = 3 } },
		{ ["silveringot"] = { ["silver_ring"] = 4 } },
		{ ["iron"] = { ["ironore"] = 1 } },
		{ ["steel"] = { ["ironore"] = 1, ["carbon"] = 1 } },
		{ ["aluminum"] = { ["can"] = 2, }, ['amount'] = 3 },
		{ ["glass"] = { ["bottle"] = 2, }, ['amount'] = 2 },
	},
	GemCut = {
		{ ["emerald"] = { ["uncut_emerald"] = 1, } },
		{ ["diamond"] = { ["uncut_diamond"] = 1}, },
		{ ["ruby"] = { ["uncut_ruby"] = 1 }, },
		{ ["sapphire"] = { ["uncut_sapphire"] = 1 }, },
	},
	RingCut = {
		{ ["gold_ring"] = { ["goldingot"] = 1 }, ['amount'] = 3 },
		{ ["silver_ring"] = { ["silveringot"] = 1 }, ['amount'] = 3 },
		{ ["diamond_ring"] = { ["gold_ring"] = 1, ["diamond"] = 1 }, },
		{ ["emerald_ring"] = { ["gold_ring"] = 1, ["emerald"] = 1 }, },
		{ ["ruby_ring"] = { ["gold_ring"] = 1, ["ruby"] = 1 }, },
		{ ["sapphire_ring"] = { ["gold_ring"] = 1, ["sapphire"] = 1 }, },

		{ ["diamond_ring_silver"] = { ["silver_ring"] = 1, ["diamond"] = 1 }, },
		{ ["emerald_ring_silver"] = { ["silver_ring"] = 1, ["emerald"] = 1 }, },
		{ ["ruby_ring_silver"] = { ["silver_ring"] = 1, ["ruby"] = 1 }, },
		{ ["sapphire_ring_silver"] = { ["silver_ring"] = 1, ["sapphire"] = 1 }, },
	},
	NeckCut = {
		{ ["goldchain"] = { ["goldingot"] = 1 }, ['amount'] = 3  },
		{ ["silverchain"] = { ["silveringot"] = 1 }, ['amount'] = 3  },
		{ ["diamond_necklace"] = { ["goldchain"] = 1, ["diamond"] = 1 }, },
		{ ["ruby_necklace"] = { ["goldchain"] = 1, ["ruby"] = 1 }, },
		{ ["sapphire_necklace"] = { ["goldchain"] = 1, ["sapphire"] = 1 }, },
		{ ["emerald_necklace"] = { ["goldchain"] = 1, ["emerald"] = 1 }, },

		{ ["diamond_necklace_silver"] = { ["silverchain"] = 1, ["diamond"] = 1 }, },
		{ ["ruby_necklace_silver"] = { ["silverchain"] = 1, ["ruby"] = 1 }, },
		{ ["sapphire_necklace_silver"] = { ["silverchain"] = 1, ["sapphire"] = 1 }, },
		{ ["emerald_necklace_silver"] = { ["silverchain"] = 1, ["emerald"] = 1 }, },
	},
	EarCut = {
		{ ["goldearring"] = { ["goldingot"] = 1 }, ['amount'] = 3  },
		{ ["silverearring"] = { ["silveringot"] = 1 }, ['amount'] = 3  },
		{ ["diamond_earring"] = { ["goldearring"] = 1, ["diamond"] = 1 }, },
		{ ["ruby_earring"] = { ["goldearring"] = 1, ["ruby"] = 1 }, },
		{ ["sapphire_earring"] = { ["goldearring"] = 1, ["sapphire"] = 1 }, },
		{ ["emerald_earring"] = { ["goldearring"] = 1, ["emerald"] = 1 }, },

		{ ["diamond_earring_silver"] = { ["silverearring"] = 1, ["diamond"] = 1 }, },
		{ ["ruby_earring_silver"] = { ["silverearring"] = 1, ["ruby"] = 1 }, },
		{ ["sapphire_earring_silver"] = { ["silverearring"] = 1, ["sapphire"] = 1 }, },
		{ ["emerald_earring_silver"] = { ["silverearring"] = 1, ["emerald"] = 1 }, },
	},
}
