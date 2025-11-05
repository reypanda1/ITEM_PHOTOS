# ITEM PHOTOS - Visualizador de Imágenes

Recurso de FiveM basado en QBCore que muestra imágenes en el centro de la pantalla cuando un jugador usa items específicos del inventario.

## 📋 Características

- ✅ Soporte para múltiples items con imágenes diferentes
- ✅ Soporte para todos los formatos de imagen (PNG, JPG, JPEG, WEBP, GIF, BMP, SVG)
- ✅ Interfaz NUI centrada y responsive
- ✅ Cierre con ESC o click en la imagen
- ✅ Prevención de múltiples instancias
- ✅ Timeout automático configurable
- ✅ Animaciones suaves de entrada/salida
- ✅ Optimizado para servidores con 500+ jugadores

## 🚀 Instalación

### Paso 1: Copiar el recurso

1. Copia la carpeta `ITEM_PHOTOS` a tu directorio de recursos:
   ```
   resources/ITEM_PHOTOS/
   ```

2. Asegúrate de que la estructura de carpetas sea:
   ```
   ITEM_PHOTOS/
   ├── fxmanifest.lua
   ├── config.lua
   ├── client/
   │   └── client.lua
   ├── server/
   │   └── server.lua
   ├── html/
   │   ├── index.html
   │   ├── style.css
   │   ├── script.js
   │   └── img/
   │       └── mapa.png
   └── README.md
   ```

### Paso 2: Añadir al server.cfg

Añade esta línea en tu `server.cfg`:

```cfg
ensure ITEM_PHOTOS
```

### Paso 3: Configurar items e imágenes

El recurso soporta múltiples items, cada uno con su propia imagen. Edita `config.lua`:

```lua
Config.Items = {
    ["map"] = "img/mapa.png",
    ["photo"] = "img/foto.png",
    ["document"] = "img/documento.jpg"
}
```

**Nota:** Los items deben existir en tu base de datos de QBCore. Funciona con items que tienen `useable = true` y `useable = false`.

### Paso 4: Agregar las imágenes

1. Coloca tus imágenes en `html/img/`
   - Formatos soportados: PNG, JPG, JPEG, WEBP, GIF, BMP, SVG
   - Tamaño recomendado: 1920x1080 o similar (se ajustará automáticamente)

2. Asegúrate de que las rutas en `Config.Items` coincidan con los nombres de tus archivos

### Paso 5: Reiniciar el servidor

1. Detén el servidor o usa `/refresh` y `/ensure ITEM_PHOTOS` en la consola del servidor
2. El recurso debería cargar correctamente

## ⚙️ Configuración Completa

Todas las opciones de configuración están en el archivo `config.lua`. A continuación se detalla cada opción:

### `Config.Items`

**Descripción:** Tabla que mapea nombres de items a sus rutas de imagen. Permite configurar múltiples items, cada uno con su propia imagen.

**Valor por defecto:**
```lua
Config.Items = {
    ["map"] = "img/mapa.png"
}
```

**Ejemplo:**
```lua
Config.Items = {
    ["map"] = "img/mapa.png",
    ["photo"] = "img/foto.jpg",
    ["document"] = "img/documento.png",
    ["mapa_especial"] = "img/mapa_especial.webp"
}
```

**Notas:**
- Las rutas son relativas a la carpeta `html/`
- Formatos soportados: PNG, JPG, JPEG, WEBP, GIF, BMP, SVG
- La imagen se ajustará automáticamente al tamaño de la pantalla
- Los items deben existir en tu base de datos de QBCore
- Funciona con items que tienen `useable = true` (automáticamente) y `useable = false` (en algunos casos debes exports o eventos)

---

### `Config.CloseOnClick`

**Descripción:** Permite o no cerrar la imagen haciendo click sobre ella.

**Valor por defecto:** `true`

**Valores posibles:**
- `true` - La imagen se cierra al hacer click sobre ella
- `false` - La imagen NO se cierra al hacer click (solo con ESC)

**Ejemplo:**
```lua
Config.CloseOnClick = true   -- Permite cerrar con click
Config.CloseOnClick = false  -- No permite cerrar con click
```

**Nota:** Independientemente de esta configuración, la imagen siempre se puede cerrar con la tecla ESC.

---

### `Config.AutoCloseTimeout`

**Descripción:** Tiempo en milisegundos antes de cerrar la imagen automáticamente.

**Valor por defecto:** `0` (desactivado)

**Ejemplo:**
```lua
Config.AutoCloseTimeout = 0        -- Desactivado (no se cierra automáticamente)
Config.AutoCloseTimeout = 5000     -- Se cierra después de 5 segundos
Config.AutoCloseTimeout = 10000    -- Se cierra después de 10 segundos
Config.AutoCloseTimeout = 30000    -- Se cierra después de 30 segundos
```

**Conversión de tiempo:**
- 1 segundo = 1000 milisegundos
- 5 segundos = 5000 milisegundos
- 10 segundos = 10000 milisegundos
- 30 segundos = 30000 milisegundos
- 1 minuto = 60000 milisegundos

**Uso común:**
- `0` - Para imágenes que el jugador debe cerrar manualmente
- `5000` - Para imágenes informativas que se muestran brevemente
- `30000` - Para documentos o mapas que se muestran durante un tiempo limitado

---

## 🎮 Uso

### Uso básico (items con useable=true)

1. El jugador debe tener un item configurado en `Config.Items` en su inventario
2. Al usar el item desde el inventario, se mostrará su imagen correspondiente centrada en pantalla
3. Para cerrar:
   - Presiona **ESC**
   - Haz **click** en la imagen (si `Config.CloseOnClick = true`)
   - Espera el timeout automático (si `Config.AutoCloseTimeout > 0`)

### Uso con items sin useable=true

Para items que no tienen `useable = true`, puedes usar el export o evento desde otro recurso:

**Opción 1: Export desde servidor (recomendado)**
```lua
-- En otro recurso (servidor)
exports['item_photos']:ShowItemImage(source, "map")
```

**Opción 2: Evento desde cliente**
```lua
-- En otro recurso (cliente)
TriggerServerEvent('item_photos:server:showItemImage', "map")
```

## 🎨 Ejemplos de Configuración

### Configuración básica (múltiples items)
```lua
Config = {}
Config.Items = {
    ["map"] = "img/mapa.png",
    ["photo"] = "img/foto.png"
}
Config.CloseOnClick = true
Config.AutoCloseTimeout = 0
```

### Configuración con timeout automático
```lua
Config = {}
Config.Items = {
    ["document"] = "img/documento.jpg",
    ["map"] = "img/mapa.png"
}
Config.CloseOnClick = true
Config.AutoCloseTimeout = 5000  -- Se cierra después de 5 segundos
```

### Configuración con diferentes formatos de imagen
```lua
Config = {}
Config.Items = {
    ["map"] = "img/mapa.png",        -- PNG
    ["photo"] = "img/foto.jpg",       -- JPG
    ["document"] = "img/doc.webp",    -- WEBP
    ["gif_item"] = "img/animation.gif" -- GIF
}
Config.CloseOnClick = true
Config.AutoCloseTimeout = 0
```

## 🔧 Solución de Problemas

### La imagen no se muestra

1. Verifica que la ruta de la imagen sea correcta en `Config.Items` para el item que estás usando
2. Asegúrate de que el archivo existe en `html/img/`
3. Revisa la consola F8 del cliente para errores de NUI
4. Verifica que el recurso esté iniciado: `/ensure ITEM_PHOTOS`
5. Confirma que el formato de imagen es compatible (PNG, JPG, JPEG, WEBP, GIF, BMP, SVG)

### El item no funciona

1. Verifica que el item existe en tu base de datos de QBCore
2. Confirma que el nombre del item en `Config.Items` coincide exactamente con el nombre del item en la base de datos
3. Si el item tiene `useable = true`, debería funcionar automáticamente
4. Si el item tiene `useable = false`, usa el export o evento desde otro recurso
5. Revisa los logs del servidor para errores

### La imagen no carga (formato no soportado)

1. Verifica que el formato de imagen es uno de los soportados: PNG, JPG, JPEG, WEBP, GIF, BMP, SVG
2. Asegúrate de que la ruta en `Config.Items` es correcta y relativa a `html/`
3. Verifica que el archivo existe físicamente en `html/img/`
4. Revisa la consola F8 del cliente para errores de carga de imagen

### La imagen no se cierra

1. Verifica que puedes presionar ESC
2. Si `Config.CloseOnClick = true`, verifica que puedes hacer click en la imagen
3. Intenta reiniciar el recurso: `/refresh` y `/ensure ITEM_PHOTOS`

### El timeout automático no funciona

1. Verifica que `Config.AutoCloseTimeout` sea mayor que 0
2. El valor debe estar en milisegundos (1000 = 1 segundo)
3. Ejemplo correcto: `Config.AutoCloseTimeout = 5000` (5 segundos)


## 📝 Requisitos

- **QBCore Framework** (versión compatible con `CreateUseableItem`)
- **FiveM Server** actualizado
- **fxmanifest** compatible (cerulean o superior)



