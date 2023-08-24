fx_version 'cerulean'

game "gta5"

author "Project Sloth & OK1ez"
version '1.0.0'

lua54 'yes'

-- ui_page 'html/index.html'
ui_page 'http://localhost:5173/' --for dev

client_script {
  'client/**',
}

server_script {
  "server/**",
}

shared_script {
  "shared/**",
  '@ox_lib/init.lua',
}

files {
  'html/**',
}
