
fx_version "adamant"
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
games {"rdr3"}

version '2.0.1'

author 'BLN Studio - RedM'

lua54 'yes'

ui_page 'ui/index.html'

client_scripts {
    'client/*.lua'
}

files {
    'ui/index.html',
    'ui/**/**/*.png',
    'ui/**/**/*.ttf',
    'ui/**/**/*.css',
    'ui/**/**/*.js'
}

shared_scripts {
    'config.lua',
}

server_scripts {
    'server/*.lua'
}

