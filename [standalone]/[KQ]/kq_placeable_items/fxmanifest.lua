fx_version 'cerulean'
games      { 'gta5' }
lua54 'yes'

author 'KuzQuality | Kuzkay'
description 'Placeable items by KuzQuality'
version '1.4.1'


ui_page 'nui/index.html'

files {
    'nui/*.html',
    'nui/js/*.js',
}

--
-- Server
--

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
    'locale.lua',
    'server/server.lua',
    'server/persistence.lua',
    'server/editable/editable.lua',
    'server/editable/esx.lua',
    'server/editable/qb.lua',
}

--
-- Client
--

client_scripts {
    'config.lua',
    'locale.lua',
    'client/persistence.lua',
    'client/functions.lua',
    'client/cache.lua',
    'client/client.lua',
    'client/inputs.lua',
    'client/pickup.lua',
    'client/flip.lua',
    'client/editable/client.lua',
    'client/editable/esx.lua',
    'client/editable/qb.lua',
    'client/editable/target.lua',
}

escrow_ignore {
    'config.lua',
    'locale.lua',
    'client/editable/*.lua',
    'server/editable/*.lua',
}

dependency '/assetpacks'