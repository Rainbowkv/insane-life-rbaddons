fx_version 'cerulean'
game 'gta5'

author 'S4int'
name 'morellos_swelcome'
description 'Simple yet efficient welcome message. '
version '1.0.0'

ui_page 'html/index.html'

shared_script 'config.lua'
client_script 'client.lua'
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua',
}

files {
    'html/index.html',
    'html/style.css',
    'html/script.js',
    'html/img/*.jpg',
    'html/all.min.css',
    'html/jquery-3.6.0.min.js',
}

lua54 'yes'
