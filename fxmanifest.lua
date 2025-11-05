fx_version 'cerulean'
game 'gta5'

author 'Rey_Panda'
description 'Recurso para mostrar mapas en pantalla al usar items del inventario'
version '1.0'

-- Dependencia de QBCore
dependency 'qb-core'

-- Archivos del servidor
server_scripts {
    'config.lua',
    'server/server.lua'
}

-- Archivos del cliente
client_scripts {
    'config.lua',
    'client/client.lua'
}

-- Recursos NUI (interfaz HTML/CSS/JS)
ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js',
    'html/img/**/*'
}

