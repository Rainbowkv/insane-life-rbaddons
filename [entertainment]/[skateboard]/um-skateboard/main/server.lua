local config = require 'shared.config'

local function isEntityValid(netId, model)
    if not netId or netId == 0 then return end
    local entity = NetworkGetEntityFromNetworkId(netId)
    if not DoesEntityExist(entity) or (model and GetEntityModel(entity) ~= joaat(model)) then return end
    return entity
end

RegisterNetEvent('um-skateboard:server:placeSkateboard', function(pProp)
    local source = source
    RemoveItem(source, pProp)
end)


RegisterNetEvent('um-skateboard:server:pickupSkateboard', function(netIds, pProp)
    local source = source
    local sourcePed = GetPlayerPed(source)
    local sourceCoords = GetEntityCoords(sourcePed)


    local skate = isEntityValid(netIds.Skate, pProp)
    if not skate then return end

    local skateCoords = GetEntityCoords(skate)
    local dist = #(sourceCoords - skateCoords)

    if dist > 20 then
        return
    end
    DeleteEntity(skate)

    AddItem(source, pProp)
    local bike = isEntityValid(netIds.Bike, 'triBike3')
    if not bike then return end

    DeleteEntity(bike)
end)
