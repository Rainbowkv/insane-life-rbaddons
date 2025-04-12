local QBCore = exports['qb-core']:GetCoreObject()
local lib = exports.ox_lib  


CreateThread(function()
    local npc = Config.NPC
    RequestModel(npc.model)
    while not HasModelLoaded(npc.model) do
        Wait(10)
    end

    local ped = CreatePed(4, npc.model, npc.coords.x, npc.coords.y, npc.coords.z - 1, npc.coords.w, false, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)

    exports.ox_target:addLocalEntity(ped, {
        {
            name = npc.targetName,
            label = npc.label,
            icon = "fa-solid fa-car",
            onSelect = function()
                QBCore.Functions.TriggerCallback('rs-policecars:getAvailableVehicles', function(vehicles)
                    TriggerEvent('rs-policecars:openMenu', vehicles)
                end)
            end
        }
    })
end)

RegisterNetEvent('rs-policecars:confirmBuy', function(vehicleModel)
    exports.ox_lib:registerContext({
        id = "vehicle_purchase_confirm",
        title = "Confirm Purchase",
        options = {
            {
                title = "Yes, buy the vehicle again",
                description = "You already have this vehicle, are you sure?",
                event = "rs-policecars:buyVehicleConfirmed",
                args = vehicleModel
            },
            {
                title = "No, cancel",
                description = "You already have this vehicle.",
                event = "rs-policecars:cancelPurchase"
            }
        }
    })

    exports.ox_lib:showContext("vehicle_purchase_confirm")
end)

RegisterNetEvent('rs-policecars:buyVehicleConfirmed', function(vehicleModel)
    TriggerServerEvent('rs-policecars:buyVehicleConfirmed', vehicleModel)
end)

RegisterNetEvent('rs-policecars:cancelPurchase', function()
    TriggerEvent('QBCore:Notify', 'Purchase canceled.', 'error')
end)


RegisterNetEvent('rs-policecars:buyVehicle', function(vehicleModel)
    if vehicleModel then
        TriggerServerEvent('rs-policecars:buyVehicle', vehicleModel)
    else
        print("No vehicle model provided!")
    end
end)

RegisterNetEvent('rs-policecars:spawnVehicle', function(vehicleModel, spawnCoords, plate)
    local playerPed = PlayerPedId()
    RequestModel(vehicleModel)
    while not HasModelLoaded(vehicleModel) do
        Wait(500)
    end
    local vehicle = CreateVehicle(vehicleModel, spawnCoords.x, spawnCoords.y, spawnCoords.z, spawnCoords.w, true, false)
    if vehicle and DoesEntityExist(vehicle) then
        exports['LegacyFuel']:SetFuel(vehicle, 100.0)
        -- 设置车辆干净状态
        SetVehicleDirtLevel(vehicle, 0.0)
        WashDecalsFromVehicle(vehicle, 1.0)
        SetVehicleEngineHealth(vehicle, 1000.0)
        SetVehicleBodyHealth(vehicle, 1000.0)
        -- SetVehicleFixed(vehicle)
        --
        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
        SetVehicleNumberPlateText(vehicle, plate)
        TriggerEvent('vehiclekeys:client:SetOwner', QBCore.Functions.GetPlate(vehicle))
        TriggerServerEvent('qb-mechanicjob:server:SaveVehicleProps', QBCore.Functions.GetVehicleProperties(vehicle))
    else
        print("Something went wrong when spawning the vehicle!")
    end
end)

RegisterNetEvent('rs-policecars:openMenu', function(vehicles)
    local options = {}

    for _, vehicle in pairs(vehicles) do
        table.insert(options, {
            title = vehicle.label,
            description = "价格: $" .. vehicle.price,
            event = "rs-policecars:buyVehicle",
            args = vehicle.model
        })
    end

    if #options > 0 then
        exports.ox_lib:registerContext({
            id = "police_vehicle_menu",
            title = "警用车辆购买",
            options = options
        })

        exports.ox_lib:showContext("police_vehicle_menu")
    else
        TriggerEvent('QBCore:Notify', '您现在的职级没有可供购买的警车', 'error')
    end
end)