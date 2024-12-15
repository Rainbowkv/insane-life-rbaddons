fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'rainbow'
description '...'
version '0.0.1'

shared_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    '@qb-core/shared/locale.lua',
    'locale/en.lua',
    'locale/*.lua',
    'config.lua'
}

client_scripts {
    'client/main.lua'
}

server_script {
    'server/main.lua'
}

dependencies {
    'qb-core',
    'qb-garages'
}