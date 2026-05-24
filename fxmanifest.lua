fx_version 'cerulean'
game 'gta5'

author 'Majedf115'
description 'QBCore Factory System with Eye Tracking Interactions'
version '1.0.0'

shared_scripts {
    '@qb-core/shared/locale.lua',
    'config.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}

client_scripts {
    'client.lua'
}

dependencies {
    'qb-core',
    'ox_target',
    'oxmysql'
}

optional_dependencies {
    'qb-target'
}

escrow_ignore {
    'config.lua',
    'client.lua',
    'server.lua'
}