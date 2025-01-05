fx_version 'adamant'
game 'gta5'

description 'ds-mdt'
version '1.0.0'

shared_scripts {
    'config.lua',
}


client_scripts {
    "client/client.lua",
    "client/GetAPI.lua",
    "client/PostAPI.lua",
}

server_scripts {
    "server/server.lua",
    "server/functions.lua",
    "server/queries.lua",
    "server/GetAPI.lua",
    "server/PostAPI.lua",
}


ui_page 'dist/index.html'


files {
   'dist/index.html',
   'dist/bundle.js',
   'dist/config.js',
   'dist/styles.css',
   'stream/prop_cs_tablet_psmdt.ytyp',
}

data_file 'DLC_ITYP_REQUEST' 'stream/prop_cs_tablet_psmdt.ytyp'  -- 加入平板物体

escrow_ignore {
    'config.lua',
}

lua54 'yes'