function ConfiscateVeh()
    local vehicle = GetVehicleInCamera()

    if vehicle ~= 0 and #(GetEntityCoords(vehicle) - GetEntityCoords(PlayerPedId())) < 5 then
        if IsEntityPositionFrozen(vehicle) then
            ShowNotification("Invalid vehicle to confiscate")
            return
        end
        if GetResourceState("origen_parking") == "started" then
            exports['origen_parking']:confiscateVehicle(vehicle)
        end
        local attempt = 0

        while not NetworkHasControlOfEntity(vehicle) and attempt < 100 and DoesEntityExist(vehicle) do
            Citizen.Wait(100)
            NetworkRequestControlOfEntity(vehicle)
            attempt = attempt + 1
        end

        if DoesEntityExist(vehicle) and NetworkHasControlOfEntity(vehicle) then
            local billPrice = 0
            if Config.Framework == "qbcore" then
                local number = exports['qb-input']:ShowInput({
                    -- header = "Bill price",
                    header = "扣押车辆",
                    submitText = "Send",
                    inputs = {
                        {
                            -- text = "price",
                            text = "罚金",
                            name = "number",
                            type = "number",
                            isRequired = true
                        }
                    }
                })
                if number and number.number then
                    billPrice = tonumber(number.number)
                    local plate = GetVehiclePlate(vehicle)
                    TriggerServerEvent("origen_police:server:Impound", plate, billPrice)
                    for i = 100, 0, -1 do
                        SetEntityAlpha(vehicle, i, false)
                        Citizen.Wait(15)
                    end
                    SetEntityAsMissionEntity(vehicle, 1, 1)
                    DeleteVehicle(vehicle)
                    ShowNotification(Config.Translations.VehicleConfiscated)
                end
            elseif Config.Framework == "esx" then
                OpenMenu('dialog', GetCurrentResourceName(), 'radarmaxspeed', {
                    title = "Bill price"
                }, function(data, menu)
                    if data and data.value and tonumber(data.value) then
                        billPrice = tonumber(data.value)
                        local plate = GetVehiclePlate(vehicle)
                        TriggerServerEvent("origen_police:server:Impound", plate, billPrice)
                        for i = 100, 0, -1 do
                            SetEntityAlpha(vehicle, i, false)
                            Citizen.Wait(15)
                        end
                        SetEntityAsMissionEntity(vehicle, 1, 1)
                        DeleteVehicle(vehicle)
                        ShowNotification(Config.Translations.VehicleConfiscated)
                        menu.close()
                    else
                        ShowNotification(Config.Translations.MustEnterNumber)
                    end
                end, function(data, menu)
                    menu.close()
                end)
            end
        end
    else
        ShowNotification(Config.Translations.MustLook)
    end
end

function AddVehicleExtras(vtype, vehicle, model)
    -- @vtype: vehicle type (car, boat, helicopter)
    -- @vehicle: vehicle entity id
    -- @model: vehicle model name
    
    -- if vtype == 'car' then
    --     SetVehicleMod(vehicle, 11, 2, false) -- Engine
    --     SetVehicleMod(vehicle, 12, 2, false) -- Brakes
    -- elseif vtype == 'boat' then

    -- elseif vtype == 'helicopter' then

    -- end
end

function GetVehiclePlate(vehicle)
    return GetVehicleNumberPlateText(vehicle)
end

function GiveKeys(vtype, vehicle)
    -- @vtype: vehicle type (car, boat, helicopter)
    -- @vehicle: vehicle entity id
end

function RemoveKeys(vehicle)
    -- @vehicle: vehicle entity id
end