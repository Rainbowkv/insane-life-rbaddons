local debugStatus = require('shared.config').debug

function CreateSkateProp(data, freeze, synced)
    lib.requestModel(data.prop)
    local prop = CreateObject(data.prop, data.coords.x, data.coords.y, data.coords.z - 1.03, synced or false,
        synced or false, false)
    SetEntityHeading(prop, data.coords.w + 180.0)
    FreezeEntityPosition(prop, freeze or 0)
    SetModelAsNoLongerNeeded(data.prop)
    return prop
end

function DestroyProp(entity)
    if not entity then return end
    if IsEntityAttachedToEntity(entity, cache.ped) then
        SetEntityAsMissionEntity(entity)
        DetachEntity(entity, true, true)
    end
    DeleteObject(entity)
end

function CreateBike(model, coords)
    lib.requestModel(model)
    local veh = CreateVehicle(model, coords.x, coords.y, coords.z, coords.w, true, false)
    SetVehicleHasBeenOwnedByPlayer(veh, true)
    SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(veh), true)
    Wait(100)
    SetVehicleNeedsToBeHotwired(veh, false)
    SetVehRadioStation(veh, 'OFF')
    SetVehicleFuelLevel(veh, 100.0)
    SetVehicleModKit(veh, 0)
    SetVehicleOnGroundProperly(veh)
    SetModelAsNoLongerNeeded(model)
    return veh
end

function ClearAll(skateboard)
    if not next(skateboard) then return end

    DeleteVehicle(skateboard.Bike)
    DestroyProp(skateboard.Skate)
    DeletePed(skateboard.Driver)
    ClearPedTasks(cache.ped)

end

function CreateSkateDriver(ped)  -- rb_code
    local model = GetEntityModel(ped)
    lib.requestModel(model)

    local coords = GetEntityCoords(ped)
    local heading = GetEntityHeading(ped)

    local driver = CreatePed(4, model, coords.x, coords.y, coords.z, heading, true, true)
    SetEntityAsMissionEntity(driver, true, true)
    SetPedCanBeTargetted(driver, false)
    SetEntityInvincible(driver, true)
    FreezeEntityPosition(driver, true)

    return driver
end
