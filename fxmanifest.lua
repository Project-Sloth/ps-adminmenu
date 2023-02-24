fx_version 'cerulean'

game "gta5"

author "OK1ez"
version '1.0.0'

lua54 'yes'


-- ui_page 'html/index.html'
ui_page 'http://localhost:3000/' --for dev

client_script {
  'client/**',
}
server_script {
  "@oxmysql/lib/MySQL.lua",
  "server/**",
  }
shared_script {
  "shared/**",
  }

files {
  'html/**',
}
