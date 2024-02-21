--[[ FX Information ]]

fx_version "cerulean"
game "gta5"
lua54 "yes"

--[[ Resource Information ]]
name "0r-towtruck"
author "aliko. <Discord> | 0Resmon"
version "1.2.0"
description "0Resmon:TowTruck | aliko & Kaves."

--[[ Manifest ]]
shared_scripts {
    "@ox_lib/init.lua",
    "shared/**/*"
}

client_script "client/**/*"

server_script "server/**/*"

ui_page "ui/build/index.html"

files {
    "ui/build/index.html",
    "ui/build/**/*"
}

escrow_ignore {
    "shared/**/*",
    "client/**/*",
    "server/**/*",
    "ui/**/*",
}

dependency "/assetpacks"

dependency '/assetpacks'