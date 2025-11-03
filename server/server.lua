local QBCore = exports['qb-core']:GetCoreObject()

local function OnItemUse(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    
    if not Player then
        return
    end
    
    TriggerClientEvent('RAB_maps:showImage', source, nil)
end

QBCore.Functions.CreateUseableItem(Config.ItemName, OnItemUse)

print(string.format("^2[RAB_MAPS]^7 Item '%s' registrado correctamente", Config.ItemName))

