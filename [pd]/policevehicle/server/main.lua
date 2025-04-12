local QBCore = exports['qb-core']:GetCoreObject()

local function generatePlate()
    local plate = 'Pd' .. QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(2)
    local result = MySQL.scalar.await('SELECT plate FROM player_vehicles WHERE plate = ?', { plate })
    if result then
        return generatePlate()
    else
        return plate:upper()  -- QBCore的车牌必须大写，不然会出很多问题
    end
end

function sendToDiscord(vehicle, price, playerName, steamName)
    local embed = {
        {
            ["color"] = 3447003,
            ["title"] = "Vehicle Purchase",
            ["description"] = "**A vehicle has been purchased!**",
            ["fields"] = {
                {["name"] = "Vehicle", ["value"] = vehicle or "Onbekend", ["inline"] = true},
                {["name"] = "Price", ["value"] = "$" .. (price or "0"), ["inline"] = true},
                {["name"] = "Player", ["value"] = playerName or "Onbekend", ["inline"] = false}
             --   {["name"] = "Steam", ["value"] = steamName or "Onbekend", ["inline"] = false}  --- Not working i will fix later 
            },
            ["footer"] = {
                ["text"] = "RobinGCS Police Cars Logs",
                ["icon_url"] = "https://imgur.com/xXbcnU7.png"
            },
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }
    }

    local payload = json.encode({
        username = "RobinGCS Police Cars",
        embeds = embed,
        avatar_url = "https://imgur.com/xXbcnU7.png"
    })

    PerformHttpRequest(Config.WebhookURL, function(err, text, headers)
        print("HTTP Response Code:", err)
        print("Response Text:", text)
    end, 'POST', payload, {['Content-Type'] = 'application/json'})
end

RegisterNetEvent('rs-policecars:buyVehicle', function(vehicleModel)
    local src = source
    -- rb_code, 首先检查玩家是否拥有该票
    local hasTicket = exports.ox_inventory:Search(src, 'count', 'specialcar_license')
    if hasTicket < 1 then
        TriggerClientEvent('QBCore:Notify', src, '你没有购买特殊车辆的许可票', 'error')
        return
    end
    --
    local Player = QBCore.Functions.GetPlayer(src)
    local grade = Player.PlayerData.job.grade.name
    local vehicles = Config.PoliceVehicles[grade]
    local query = 'SELECT * FROM player_vehicles WHERE citizenid = ? AND vehicle = ?'
    exports.oxmysql:fetch(query, {Player.PlayerData.citizenid, vehicleModel}, function(existingVehicles)
        if #existingVehicles > 0 then
            TriggerClientEvent('QBCore:Notify', src, '您已经拥有此车辆.', 'error')
        else
            exports.ox_inventory:RemoveItem(src, 'specialcar_license', 1)  -- 消耗警车票
            processVehiclePurchase(Player, vehicleModel, vehicles)
        end
    end)
end)

RegisterNetEvent('rs-policecars:buyVehicleConfirmed', function(vehicleModel)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local grade = Player.PlayerData.job.grade.name
    local vehicles = Config.PoliceVehicles[grade]

    local vehicleToBuy = nil
    for _, vehicle in pairs(vehicles) do
        if vehicle.model == vehicleModel then
            vehicleToBuy = vehicle
            break
        end
    end

    if vehicleToBuy then
        if Player.PlayerData.money.bank >= vehicleToBuy.price then
            Player.Functions.RemoveMoney('bank', vehicleToBuy.price, 'police-vehicle-purchase')

            local plate = generatePlate()

            local query = 'INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, garage, state, plate) VALUES (?, ?, ?, ?, ?, ?, ?, ?)'
            local parameters = {Player.PlayerData.license, Player.PlayerData.citizenid, vehicleModel, GetHashKey(vehicleModel), '{}', 'police', 0, plate}
            exports.oxmysql:insert(query, parameters, function(result)
                if result then
                    local spawnCoords = Config.VehicleSpawnLocation
                    TriggerClientEvent('rs-policecars:spawnVehicle', src, vehicleModel, spawnCoords, plate)
                    TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, '您买下' .. vehicle.label .. ', 花费 $' .. vehicle.price, 'success')
                else
                    TriggerClientEvent('QBCore:Notify', src, 'Something went wrong with the purchase.', 'error')
                end
            end)
        else
            TriggerClientEvent('QBCore:Notify', src, 'You do not have enough money.', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You cannot buy this vehicle.', 'error')
    end
end)

function processVehiclePurchase(Player, vehicleModel, vehicles)
    for _, vehicle in pairs(vehicles) do
        if vehicle.model == vehicleModel then
            if Player.PlayerData.money.bank >= vehicle.price then
                Player.Functions.RemoveMoney('bank', vehicle.price, 'police-vehicle-purchase')
                
                local plate = generatePlate()

                local query = 'INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, garage, state, plate) VALUES (?, ?, ?, ?, ?, ?, ?, ?)'
                local parameters = {Player.PlayerData.license, Player.PlayerData.citizenid, vehicleModel, GetHashKey(vehicleModel), '{}', 'police', 0, plate}
                exports.oxmysql:insert(query, parameters, function(result)
                    if result then
                        local spawnCoords = Config.VehicleSpawnLocation
                        TriggerClientEvent('rs-policecars:spawnVehicle', Player.PlayerData.source, vehicleModel, spawnCoords, plate)
                        TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, '您买下' .. vehicle.label .. ', 花费 $' .. vehicle.price, 'success')
                    else
                        TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, '遭遇问题.', 'error')
                    end
                end)
            else
                TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, '您的银行余额不足.', 'error')
            end
        end
    end
end

QBCore.Functions.CreateCallback('rs-policecars:getAvailableVehicles', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local grade = Player.PlayerData.job.grade.name
    cb(Config.PoliceVehicles[grade] or {})
end)

-- rb_code
RegisterNetEvent('policevehicle:server:SaveVehicleProps', function(vehicleProps)
    if IsVehicleOwned(vehicleProps.plate) then
        MySQL.update('UPDATE player_vehicles SET mods = ? WHERE plate = ?', { json.encode(vehicleProps), vehicleProps.plate })
    end
end)