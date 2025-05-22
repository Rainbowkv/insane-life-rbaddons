local QBCore = exports['qb-core']:GetCoreObject()

local function GeneratePlate()
    local plate = QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(2)
    local result = MySQL.scalar.await('SELECT plate FROM player_vehicles WHERE plate = ?', { plate })
    if result then
        return GeneratePlate()
    else
        return plate:upper()
    end
end

local function GetCoins(license)
    local coins = MySQL.Sync.fetchScalar('SELECT coins FROM donator WHERE license = ?', { license })
    if coins ~= nil then
        return coins
    else
        MySQL.Async.insert('INSERT INTO donator (license, coins) VALUES (?, 0)', { license })
        return 0
    end
end

local function SetCoins(license, amount)
    local affectedRows = MySQL.update.await('UPDATE donator SET coins = ? WHERE license = ?', { amount, license })
    if affectedRows then
        lib.logger(-1, 'set_coins', string.format("Set %s coins to %s", license, amount))
    else
        MySQL.Async.insert('INSERT INTO donator (license, coins) VALUES (?, ?)', { license, amount })
        lib.logger(-1, 'set_coins', string.format("Set %s coins to %s", license, amount))
    end
end

local function RemoveCoins(license, amount)
    local coins = GetCoins(license)
    local total = (coins - amount)
    if total < 0 then
        return false, nil
    else
        SetCoins(license, total)
        return true, total
    end
end

local function AddCoins(license, amount)
    local coins = GetCoins(license)
    coins = coins + amount

    local affectedRows = MySQL.update.await('UPDATE donator SET coins = ? WHERE license = ?', { coins, license })
    if affectedRows then
        lib.logger(-1, 'add_coins', string.format("Added %s to %s", coins, license))
    else
        MySQL.Async.insert('INSERT INTO donator (license, coins) VALUES (?, ?)', { license, coins })
        lib.logger(-1, 'add_coins', string.format("Added %s to %s", coins, license))
    end
    return coins
end

lib.callback.register('rb-donator:GetCoins', function(source)
    local license = GetPlayerIdentifierByType(source, 'license')
    local coins = GetCoins(license)
    return coins
end)

lib.callback.register('rb-donator:purchaseItem', function(source, itemName, className)
    local license = GetPlayerIdentifierByType(source, 'license')
    local coins = GetCoins(license)
    local cost = nil
    if className == 'vehicle' then
        cost = Config.vehicle_price[itemName]
    end
    if cost == nil then
        return false, "购买的物品种类不存在"
    end

    if coins >= cost then
        local result, newCoins = RemoveCoins(license, cost)  -- 这里必然成功，前面已经验证了
        TriggerClientEvent("rb-donator:updateCoins", source, newCoins)  -- 更新客户端缓存的赞助点
        local player = QBCore.Functions.GetPlayer(source)
        local cid = player.PlayerData.citizenid
        local charinfo = player.PlayerData.charinfo
        -- 日志
        MySQL.Async.insert('INSERT INTO donator_transactions (license, player_name, description, amount, operator, timestamp) VALUES (?, ?, ?, ?, ?, ?)', {
            license,
            charinfo.firstname .. " " .. charinfo.lastname,
            '购买: '..itemName,
            -cost,
            '系统',
            os.date("%Y-%m-%d %H:%M:%S", os.time())
        })
        --
        if className == 'vehicle' then
            local vehMod = Config.vehicle_mod[itemName]
            MySQL.Async.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, state, garage) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', {
                license,
                cid,
                vehMod,
                GetHashKey(vehMod),
                Config.vehicle_defaultmods[itemName] or '{}',
                GeneratePlate(),
                1,
                Config.defaultGarage,
            })
        end
        return true, "购买成功"
    else
        return false, "赞助点不足"
    end
end)

lib.addCommand('addcoins', {
    help = 'Give Player Coins (Admin Only)',
    params = {
        {
            name = 'target',
            type = 'playerId',  -- 这里lib.addCommand会去检查，下面的function其实不用检查了
            help = 'Target player\'s server id',
        },
        {
            name = 'amount',
            type = 'number',  -- 这里lib.addCommand会去检查
            help = 'Number of the coins to give, or blank to give 1',
        },
    },
    restricted = 'group.admin'
}, function(source, args, raw)
    local license = GetPlayerIdentifierByType(args.target, 'license')
    if license then
        local newCoins = AddCoins(license, tonumber(args.amount) or 1)
        -- 日志
        local charinfo = QBCore.Functions.GetPlayer(args.target).PlayerData.charinfo
        MySQL.Async.insert('INSERT INTO donator_transactions (license, player_name, description, amount, operator, timestamp) VALUES (?, ?, ?, ?, ?, ?)', {
            license,
            charinfo.firstname .. " " .. charinfo.lastname,
            'addcoins命令',
            tonumber(args.amount),
            GetPlayerName(source),
            os.date("%Y-%m-%d %H:%M:%S", os.time())
        })
        -- 管理员
        TriggerClientEvent("ox_lib:notify", source, {
            title = "赞助管理",
            description = "您给ID:"..args.target.."的市民增加了 "..args.amount.." 赞助点",
            type = "success",
            duration = 7000,  -- 显示 7 秒（单位：毫秒）
        })
        -- 赞助者
        TriggerClientEvent("ox_lib:notify", args.target, {
            title = "感谢赞助",
            description = "您获得了"..args.amount.." 赞助点",
            type = "success",
            duration = 7000,  -- 显示 7 秒（单位：毫秒）
        })
        TriggerClientEvent("rb-donator:updateCoins", args.target, newCoins)  -- 更新客户端缓存的赞助点
    end
end)

local function isDonatorVeh(vehModName)  
    for _, donatorModel in pairs(Config.vehicle_mod) do
        if vehModName == donatorModel then
            return true
        end
    end
    return false
end

exports('IsDonatorVeh', isDonatorVeh)

local function isCustomVeh(vehModName)
    for _, customModel in pairs(Config.custom_vehicle_mod) do
        if vehModName == customModel then
            return true
        end
    end
    return false
end

exports('IsCustomVeh', isCustomVeh)