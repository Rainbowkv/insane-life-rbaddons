fx_version 'cerulean'

games { 'gta5' }

lua54 'yes'

description 'QB Drug Trafficing by Project Sloth'

version '1.4.1'

shared_scripts {
	'@PolyZone/client.lua',
    '@PolyZone/CircleZone.lua',
	'@qb-core/shared/locale.lua',
	'config.lua',
	'locales/en.lua'
}

server_scripts {
	'server/*.lua'
}

client_scripts {
	'client/*.lua'
}

