fx_version 'cerulean'
game 'gta5'

author 'RobinGCS'
description 'policevehicle Dealership'
version '1.0.0'

shared_script 'config.lua'
server_script {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua',
}
client_script 'client/main.lua'

dependency 'qb-core'
dependency 'ox_lib'
dependency 'ox_target'
