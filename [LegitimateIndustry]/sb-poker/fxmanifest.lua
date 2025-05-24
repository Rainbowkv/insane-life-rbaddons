fx_version "cerulean"
game "gta5"

version 'v1.0.12'

shared_scripts {
    'configs/peds.lua',
    'configs/config.lua',
    'shared/*.lua',
}

client_script {
    'dist/client.js',
    'client/*.lua',
}

server_scripts {
    'dist/server.js',
    'server/*.lua',
} 

ui_page 'ui/build/index.html'

files {
    'ui/build/index.html',
    'ui/build/configs/*.js',
    'ui/build/audio/*.wav',
    'ui/build/**/*',
}

escrow_ignore {
    'configs/*.lua',
    'server/framework.lua',
    'client/framework.lua',
    'client/functions_customize.lua',
}

dependency 'sb-poker-assets'

lua54 'yes'
use_fxv2_oal 'yes'
dependency '/assetpacks'