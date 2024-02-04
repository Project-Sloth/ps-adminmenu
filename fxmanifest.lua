fx_version 'cerulean'

game "gta5"

author "Project Sloth & OK1ez"
version '1.1.5'
description 'Admin Menu'
repository 'https://github.com/Project-Sloth/ps-adminmenu'

lua54 'yes'

ui_page 'html/index.html'
-- ui_page 'http://localhost:5173/' --for dev

client_script {
  'client/**',
}

server_script {
  "server/**",
  "@oxmysql/lib/MySQL.lua",
}

shared_script {
  '@ox_lib/init.lua',
  "shared/**",
}

files {
  'html/**',
  'data/ped.lua',
  'data/object.lua',
  'locales/*.json',
}

ox_lib 'locale' -- v3.8.0 or above
