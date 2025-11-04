//Este código es un reflejo del caos compuesto gracias a la pasión de Cristo y el poder inestable de mis dos huebotes.
//Nació bajo la influencia conjunta de una cerveza, un habana club, una monster y la compañía dudosa de dos chicas bajo el escritorio.
//Quien intente refactorizarlo se arriesga a lidiar con bugs erráticos y diarreas mentales impredecibles.
//Cualquier intento de entenderlo suele terminar en parpadeos raros del monitor y migrañas fuera de lógica.
//Modifícalo bajo tu propio riesgo.


/*
     _____________________________________________________________________________________________________
    /                                                                                                     \
   |   ___           _         _                  _                 _           _         _               |
   |  |_ _|_ __  ___| |_ ___  | |    ___  __ _  __| | ___  _ __     / \   _ __ (_)_ __   | |_ ___         |
   |   | || '_ \/ __| __/ _ \ | |   / _ \/ _` |/ _` |/ _ \| '_ \   / _ \ | '_ \| | '_ \  | __/ _ \        |
   |   | || | | \__ \ ||  __/ | |__|  __/ (_| | (_| | (_) | | | | / ___ \| |_) | | | | | | || (_) |       |
   |  |___|_| |_|___/\__\___| |_____\___|\__,_|\__,_|\___/|_| |_|/_/   \_\ .__/|_|_| |_|  \__\___/        |
   |                                                                    |_|                              |
   |                                                                                                     |
   |   ***************************************************************************************          |
   |      ¡IMPORTANTE!                                                                                  |
   |      LEA LOS COMENTARIOS DE ARRIBA ANTES DE MODIFICAR O USAR ESTE CÓDIGO                           |
   |      ADVERTENCIA: SU SALUD MENTAL Y SU MONITOR PODRÍAN CORRER PELIGRO                              |
   |   ***************************************************************************************          |
   |                                                                                                     |
    \___________________________________________________________________________________________________/
*/



const imageContainer = document.getElementById('imageContainer');
const displayImage = document.getElementById('displayImage');
let autoCloseTimeout = null;
let isImageVisible = false;

function openImage(imagePath, timeout, closeOnClick) {
    imageContainer.classList.add('hidden');
    displayImage.src = imagePath;
    
    if (closeOnClick) {
        displayImage.style.cursor = 'pointer';
        displayImage.addEventListener('click', closeImageOnClick);
    } else {
        displayImage.style.cursor = 'default';
        displayImage.removeEventListener('click', closeImageOnClick);
    }
    
    setTimeout(() => {
        imageContainer.classList.remove('hidden');
        isImageVisible = true;
    }, 10);
    
    if (autoCloseTimeout) {
        clearTimeout(autoCloseTimeout);
        autoCloseTimeout = null;
    }
    
    if (timeout && timeout > 0) {
        autoCloseTimeout = setTimeout(() => {
            closeImage();
        }, timeout);
    }
}

function closeImage() {
    imageContainer.classList.add('hidden');
    isImageVisible = false;
    
    if (autoCloseTimeout) {
        clearTimeout(autoCloseTimeout);
        autoCloseTimeout = null;
    }
    
    displayImage.src = '';
    displayImage.removeEventListener('click', closeImageOnClick);
    notifyClose();
}

function closeImageOnClick() {
    closeImage();
}

function notifyClose() {
    const resourceName = GetParentResourceName ? GetParentResourceName() : 'RAB_maps';
    
    fetch(`https://${resourceName}/close`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({})
    }).catch(err => {});
}

window.addEventListener('message', function(event) {
    const data = event.data;
    
    switch(data.action) {
        case 'open':
            openImage(
                data.img || 'img/center_image.png',
                data.timeout || 0,
                data.closeOnClick !== false
            );
            break;
            
        case 'close':
            closeImage();
            break;
    }
});

document.addEventListener('keydown', function(event) {
    if (!isImageVisible) return;
    
    const key = event.key;
    const keyCode = event.keyCode;
    
    if (key === 'Escape' || keyCode === 27) {
        event.preventDefault();
        closeImage();
    }
});

