--------------------------------------------------------------------------------
-- Build Date: Mon, 15 Jan 2024 20:09:40 GMT --
-- https://discord.gg/g84MXVrrdU --
-- https://PlatinumScripts.dev/ --
-- https://PlatinumScripts.tebex.io/ --
--------------------------------------------------------------------------------
--	  _____  _       _   _                          _____           _       _       
--	 |  __ \| |     | | (_)                        / ____|         (_)     | |      
--	 | |__) | | __ _| |_ _ _ __  _   _ _ __ ___   | (___   ___ _ __ _ _ __ | |_ ___ 
--	 |  ___/| |/ _` | __| | '_ \| | | | '_ ` _ \   \___ \ / __| '__| | '_ \| __/ __|
--	 | |    | | (_| | |_| | | | | |_| | | | | | |  ____) | (__| |  | | |_) | |_\__ \
--	 |_|    |_|\__,_|\__|_|_| |_|\__,_|_| |_| |_| |_____/ \___|_|  |_| .__/ \__|___/
--	                                                                 | |            
--	                                                                 |_|            
--------------------------------------------------------------------------------

fx_version "cerulean"
game "gta5"

files {
	"index.html",
	"static/js/**/*",
	"static/media/**/*",
	"vcf/*.xml"
}

ui_page "index.html"

shared_scripts {
	"config.lua",
	"patterns.lua",
	"shared.lua"
}

server_scripts {
	"server/utils.lua",
	"server/main.lua",
	"server/nonels.lua"
}

client_scripts {
	"client/utils.lua",
	"client/state.lua",
	"client/ui.lua",
	"client/main.lua",
	"client/controls.lua",
	"client/sirens.lua",
	"client/indicator.lua",
	"client/nonels.lua"
}

lua54 "yes"
escrow_ignore "config.lua"
escrow_ignore "patterns.lua"
escrow_ignore "client/sirens.lua"
dependency '/assetpacks'