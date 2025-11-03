# RAB_MAPS - Visualizador de Imágenes

Recurso de FiveM basado en QBCore que muestra imágenes en el centro de la pantalla cuando un jugador usa items específicos del inventario.

## 📋 Características

- ✅ Item usable registrado con QBCore
- ✅ Interfaz NUI centrada y responsive
- ✅ Cierre con ESC o click en la imagen
- ✅ Prevención de múltiples instancias
- ✅ Timeout automático configurable
- ✅ Animaciones suaves de entrada/salida
- ✅ Optimizado para servidores con 500+ jugadores

## 🚀 Instalación

### Paso 1: Copiar el recurso

1. Copia la carpeta `RAB_maps` a tu directorio de recursos:
   ```
   resources/RAB_maps/
   ```

2. Asegúrate de que la estructura de carpetas sea:
   ```
   RAB_maps/
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
ensure RAB_maps
```

### Paso 3: Registrar el item en QBCore

El recurso está configurado para usar el item `map` por defecto. Si necesitas crear este item en tu base de datos:

1. **Opción A: Usar el item existente** - Si ya tienes un item llamado `map`, el recurso funcionará inmediatamente.

2. **Opción B: Crear un nuevo item** - Edita `config.lua` y cambia `Config.ItemName` por el nombre de tu item.
   - Asegúrate de que el item existe en tu base de datos de QBCore (`qb-core/shared/items.lua` o base de datos).

   **Ejemplo para qb-core/shared/items.lua:**
   ```lua
   map = { name = 'map', label = 'Mapa', weight = 100, type = 'item', image = 'mapa.png', unique = false, useable = true, shouldClose = true, description = 'Es un mapa de la ciudad' },
   ```

### Paso 4: Agregar la imagen

1. Coloca tu imagen en `html/img/`
   - La imagen debe estar en formato PNG, JPG, etc. (compatibles con navegadores)
   - Tamaño recomendado: 1920x1080 o similar (se ajustará automáticamente)

2. **Alternativa:** Puedes cambiar la ruta en `config.lua`:
   ```lua
   Config.DefaultImage = "img/tu_imagen.png"
   ```

### Paso 5: Reiniciar el servidor

1. Detén el servidor o usa `/refresh` y `/ensure RAB_maps` en la consola del servidor
2. El recurso debería cargar correctamente

## ⚙️ Configuración Completa

Todas las opciones de configuración están en el archivo `config.lua`. A continuación se detalla cada opción:

### `Config.ItemName`

**Descripción:** Nombre del item usable en QBCore que activará la visualización de la imagen.

**Valor por defecto:** `"map"`

**Ejemplo:**
```lua
Config.ItemName = "map"
Config.ItemName = "photo_item"
Config.ItemName = "document"
```

**Importante:** El item debe existir en tu base de datos de QBCore y tener `useable = true`.

---

### `Config.DefaultImage`

**Descripción:** Ruta de la imagen que se mostrará por defecto cuando un jugador use el item.

**Valor por defecto:** `"img/mapa.png"`

**Ejemplo:**
```lua
Config.DefaultImage = "img/mapa.png"
Config.DefaultImage = "img/foto1.png"
Config.DefaultImage = "img/documento.jpg"
```

**Notas:**
- La ruta es relativa a la carpeta `html/`
- Formatos soportados: PNG, JPG, JPEG, WEBP (cualquier formato compatible con navegadores)
- La imagen se ajustará automáticamente al tamaño de la pantalla

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

1. El jugador debe tener el item configurado (`Config.ItemName`) en su inventario
2. Al usar el item desde el inventario, se mostrará la imagen centrada en pantalla
3. Para cerrar:
   - Presiona **ESC**
   - Haz **click** en la imagen (si `Config.CloseOnClick = true`)
   - Espera el timeout automático (si `Config.AutoCloseTimeout > 0`)

## 🎨 Ejemplos de Configuración

### Configuración básica
```lua
Config = {}
Config.ItemName = "map"
Config.DefaultImage = "img/mapa.png"
Config.CloseOnClick = true
Config.AutoCloseTimeout = 0
```

### Configuración con timeout automático
```lua
Config = {}
Config.ItemName = "photo"
Config.DefaultImage = "img/foto.png"
Config.CloseOnClick = true
Config.AutoCloseTimeout = 5000  -- Se cierra después de 5 segundos
```

## 🔧 Solución de Problemas

### La imagen no se muestra

1. Verifica que la ruta de la imagen sea correcta en `Config.DefaultImage`
2. Asegúrate de que el archivo existe en `html/img/`
3. Revisa la consola F8 del cliente para errores de NUI
4. Verifica que el recurso esté iniciado: `/ensure RAB_maps`

### El item no funciona

1. Verifica que el item existe en tu base de datos de QBCore
2. Confirma que el nombre en `Config.ItemName` coincide exactamente con el nombre del item
3. Asegúrate de que el item tiene `useable = true` en la base de datos
4. Revisa los logs del servidor para errores

### La imagen no se cierra

1. Verifica que puedes presionar ESC
2. Si `Config.CloseOnClick = true`, verifica que puedes hacer click en la imagen
3. Intenta reiniciar el recurso: `/refresh` y `/ensure RAB_maps`

### El timeout automático no funciona

1. Verifica que `Config.AutoCloseTimeout` sea mayor que 0
2. El valor debe estar en milisegundos (1000 = 1 segundo)
3. Ejemplo correcto: `Config.AutoCloseTimeout = 5000` (5 segundos)

## 📝 Requisitos

- **QBCore Framework** (versión compatible con `CreateUseableItem`)
- **FiveM Server** actualizado
- **fxmanifest** compatible (cerulean o superior)

