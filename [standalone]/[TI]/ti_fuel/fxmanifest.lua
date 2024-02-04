description 'TebIT - Fuel'
version '1.0.0'

ui_page 'nui/index.html'

fx_version 'bodacious'
game 'gta5'

lua54 'yes'

util_modules {
  'players',
  'notifications',
  'streaming',
  'callbacks',
  'inventory',
  'blips',
  'points',
  'locales',
  'progressBars',
  'stateBags'
}

shared_scripts {
  '@ti_utils/init.lua',
  'data/*.lua',
  'labels.lua',
  'config.lua',
}

client_scripts {
  'client/main.lua',
  'client/legacyfuel.lua',
  'client/functions.lua',
}

server_scripts {
  'server/main.lua',
}

dependencies {
  'ti_utils'
}

provides {
  'LegacyFuel',
}

escrow_ignore {
  'config.lua',
  'labels.lua',
  'data/*.lua',
  'client/functions.lua',
}

files {
  'nui/index.html',
}
dependency '/assetpacks'