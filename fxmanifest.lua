fx_version 'cerulean'

games {"gta5", "rdr3"}

author "OK1ez"
version '1.0.0'

lua54 'yes'

ui_page 'web/build/index.html'
-- ui_page 'http://localhost:5173/'

client_script "client/**/*"
server_scripts{
  '@oxmysql/lib/MySQL.lua',
  'server/**/*',
}

files {
  'web/build/index.html',
  'web/build/**/*'
}
