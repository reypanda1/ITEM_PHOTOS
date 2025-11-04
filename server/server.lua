local QBCore = exports['qb-core']:GetCoreObject()

local function OnItemUse(source, item, imagePath)
    local Player = QBCore.Functions.GetPlayer(source)
    
    if not Player then
        return
    end
    
    TriggerClientEvent('RAB_maps:showImage', source, imagePath)
end

if Config.Items and next(Config.Items) then
    local itemCount = 0
    for itemName, imagePath in pairs(Config.Items) do
        QBCore.Functions.CreateUseableItem(itemName, function(source, item)
            OnItemUse(source, item, imagePath)
        end)
        itemCount = itemCount + 1
    end
    print(string.format("^2[RAB_MAPS]^7 %d item(s) registrado(s) correctamente", itemCount))
end

