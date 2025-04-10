local QBCore = exports['qb-core']:GetCoreObject()
local oxmysql = exports['oxmysql']

QBCore.Functions.CreateCallback('insurer:server:GetPlayerVehicles', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local Vehicles = {}

    oxmysql:query('SELECT * FROM player_vehicles WHERE citizenid = ? AND state = 0', {Player.PlayerData.citizenid}, function(result)  -- 只保留在外面的车，停在车库的1和被扣押的2都过滤掉
        if result[1] then
            for _, v in pairs(result) do
                local VehicleData = QBCore.Shared.Vehicles[v.vehicle]
    
                local VehicleGarage = '无'
                if v.garage ~= nil then
                    if Config.Garages[v.garage] ~= nil then
                        VehicleGarage = Config.Garages[v.garage].label
                    else
                        VehicleGarage = "房屋车库"
                    end
                end
    
                local stateTranslation
                if v.state == 0 then
                    stateTranslation = '外面'
                elseif v.state == 1 then
                    stateTranslation = '已存放'
                elseif v.state == 2 then
                    stateTranslation = '已被警察扣押'
                end
    
                local fullname
                if VehicleData and VehicleData['brand'] then
                    fullname = VehicleData['brand'] .. ' ' .. VehicleData['name']
                else
                    fullname = VehicleData and VehicleData['name'] or 'Unknown Vehicle'
                end
    
                Vehicles[#Vehicles + 1] = {
                    -- name = v.vehicle,
                    -- fullname = fullname,
                    -- brand = VehicleData and VehicleData['brand'] or '',
                    -- model = VehicleData and VehicleData['name'] or '',
                    plate = v.plate,
                    -- garage = VehicleGarage,
                    -- state = stateTranslation,
                    -- fuel = v.fuel,
                    -- engine = v.engine,
                    -- body = v.body
                }
            end
            cb(Vehicles)
        else
            cb(nil)
        end
    end)
    
end)