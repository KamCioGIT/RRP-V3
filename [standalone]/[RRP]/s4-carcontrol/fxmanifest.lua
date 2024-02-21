fx_version 'adamant'
game 'gta5'

ui_page "web/index.html"

client_scripts { 'config.lua',  'client/temp.lua', 'client/client.lua' }

server_scripts { 'config.lua', '@mysql-async/lib/MySQL.lua', 'server/server.lua' }
 
files {
    "web/index.html",
    "web/*.js",
    "assets/*.png",
    "assets/weather/*.png",
    "web/style.css",
	'assets/*.ttf',
    'assets/*.woff',
    'assets/*.woff2',
 
}
 
lua54 "yes"

escrow_ignore {
	'config.lua',
    'client/temp.lua',
    'client/client.lua',
    'server/server.lua'
}

dependencies { 'baseevents' }
 
dependency '/assetpacks'