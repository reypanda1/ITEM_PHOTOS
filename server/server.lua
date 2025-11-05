local QBCore = exports['qb-core']:GetCoreObject()

local function OnItemUse(source, imagePath)
    local Player = QBCore.Functions.GetPlayer(source)
    
    if not Player then
        return
    end
    
    TriggerClientEvent('item_photos:showImage', source, imagePath)
end

if Config.Items and next(Config.Items) then
    local itemCount = 0
    
    -- Registrar items con CreateUseableItem (funciona con useable=true)
    for itemName, imagePath in pairs(Config.Items) do
        QBCore.Functions.CreateUseableItem(itemName, function(source, item)
            OnItemUse(source, imagePath)
        end)
        itemCount = itemCount + 1
    end
    
    -- Export para mostrar imagen desde otros recursos (útil para items sin useable=true)
    exports('ShowItemImage', function(source, itemName)
        local imagePath = Config.Items[itemName]
        if imagePath then
            OnItemUse(source, imagePath)
            return true
        end
        return false
    end)
    
    -- Evento para mostrar imagen manualmente desde el cliente
    RegisterServerEvent('item_photos:server:showItemImage', function(itemName)
        local src = source
        local imagePath = Config.Items[itemName]
        if imagePath then
            OnItemUse(src, imagePath)
        end
    end)
    
    -- Escuchar eventos del inventario (soporte para diferentes versiones de QBCore)
    RegisterServerEvent('inventory:server:UseItemSlot', function(slot)
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        
        if not Player or not Player.PlayerData.items then return end
        
        local item = Player.PlayerData.items[slot]
        if not item or not item.name then return end
        
        local imagePath = Config.Items[item.name]
        if imagePath then
            OnItemUse(src, imagePath)
        end
    end)
    
    RegisterServerEvent('QBCore:Server:UseItem', function(item)
        local src = source
        if item and item.name then
            local imagePath = Config.Items[item.name]
            if imagePath then
                OnItemUse(src, imagePath)
            end
        end
    end)
    
    print(string.format("^2[Item Photos]^7 %d item(s) registrado(s) correctamente", itemCount))
    print("^3[Item Photos]^7 Nota: Items con useable=true funcionan automáticamente")
    print("^3[Item Photos]^7 Para items sin useable=true, usa el export o evento desde otro recurso")
end

