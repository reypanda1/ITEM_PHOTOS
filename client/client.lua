local QBCore = exports['qb-core']:GetCoreObject()

local DefaultImage = Config.DefaultImage
local AutoCloseTimeout = Config.AutoCloseTimeout
local CloseOnClick = Config.CloseOnClick

local imageOpen = false

local function OpenImage(imagePath)
    if imageOpen then
        return
    end
    
    imageOpen = true
    local finalImagePath = imagePath or DefaultImage
    
    SendNUIMessage({
        action = "open",
        img = finalImagePath,
        timeout = AutoCloseTimeout,
        closeOnClick = CloseOnClick
    })
    
    SetNuiFocus(true, true)
end

function CloseImage()
    if not imageOpen then
        return
    end
    
    imageOpen = false
    
    SendNUIMessage({
        action = "close"
    })
    
    SetNuiFocus(false, false)
end

RegisterNetEvent('item_photos:showImage', function(imagePath)
    if QBCore then
        OpenImage(imagePath)
    end
end)

RegisterNUICallback('close', function(data, cb)
    CloseImage()
    cb('ok')
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName and imageOpen then
        CloseImage()
    end
end)

