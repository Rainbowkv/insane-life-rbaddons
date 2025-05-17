fx_version 'cerulean'
game 'gta5'
lua54 'yes'

description 'Donator Shop UI'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js',
    'html/images/*.png',
}

client_scripts {
    'client/*.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua',
}

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
}