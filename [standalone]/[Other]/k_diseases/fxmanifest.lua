fx_version 'cerulean'
game 'gta5'

author 'Kypos'

discription 'Disease System for FiveM servers.'
version '1.0.2'


shared_scripts {
    'shared.lua',
    '@es_extended/imports.lua',
    'config.lua'
}

client_scripts {
    'client/client.lua',
    'client/functions.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/server.lua'
}

lua54 'yes'


exports {
    "CatchDisease", -- exports['k_diseases']:CatchDisease(type, chance, check)
    "ClearDisease", -- exports['k_diseases']:ClearDisease(type)
    "GetDiseases",-- exports['k_diseases']:GetDiseases() -- returns list of Diseases true or false and iterations Example: ( exports['k_diseases']:GetDiseases()["Common Cold"].hasDiseases )
    "ClearAllDisease" -- exports['k_diseases']:ClearAllDisease() -- Clears every sickness (could be used on player revive or something :P)
} 

escrow_ignore {
    'config.lua',
}
  
dependency '/assetpacks'