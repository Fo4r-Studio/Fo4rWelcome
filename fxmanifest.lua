fx_version 'cerulean'
game 'gta5'

description 'Welcome Script'
author 'Fo4r Studios'

lua54 'yes'

client_scripts {
  'client.lua',
}

server_scripts {
  'server.lua',
}

shared_scripts {
  'cfg.lua'
}

ui_page {
  'ui/index.html',
}
files {
  'ui/*.css',
  'ui/*.html',
  'ui/*.js'
}

escrow_ignore {
  'config.lua',
}