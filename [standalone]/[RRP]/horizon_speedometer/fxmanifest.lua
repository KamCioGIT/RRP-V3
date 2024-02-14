fx_version "bodacious"
games {"gta5"}
lua54 'yes'
version "1.2"

escrow_ignore {
    "client.lua",
	"server.lua",
	"config.lua"
}

client_scripts {
	"client.lua",
	"config.lua"
}

server_scripts {
	"server.lua"
}

ui_page "ui/index.html"

files {
	"ui/index.html",
	"ui/script.js",
	"ui/debounce.min.js",
	"ui/style.css",
	"ui/*",
	"ui/imgs/*"
}
dependency '/assetpacks'
dependency '/assetpacks'