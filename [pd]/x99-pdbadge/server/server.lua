local QBCore = nil

Citizen.CreateThread(function()
    while QBCore == nil do
        QBCore = exports[config.coreData.scriptName]:GetCoreObject()
        Citizen.Wait(200)
    end
    QBCore.Functions.CreateUseableItem("pdbadge", function(source, item)
        local Player = QBCore.Functions.GetPlayer(source)
        local coords = GetEntityCoords(GetPlayerPed(source))
        if Player.Functions.GetItemBySlot(item.slot) ~= nil then
            TriggerClientEvent("x99-pdbadge:open", -1, source, coords, item.metadata)
        end
    end)
end)

RegisterServerEvent("x99-badge:item:create")
AddEventHandler("x99-badge:item:create", function(name, callsign, rank, photo, badgeType)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local info = {}
    info.name = name
    info.callsign = callsign
    info.rank = rank
    info.photo = photo
    info.type = badgeType  
    Player.Functions.AddItem("pdbadge", 1, false, info)
end)

RegisterServerEvent("x99-badge:SaveMetaData")
AddEventHandler("x99-badge:SaveMetaData", function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local result = MySQL.query.await('SELECT metadata FROM players WHERE citizenid = ?', {Player.PlayerData.citizenid})
    local MetaData = json.decode(result[1].metadata)
    MetaData.phonedata.profilepicture = data
    Player.Functions.SetMetaData("phonedata", MetaData.phonedata)
end)

-- rb_code
RegisterServerEvent('x99_badge:checkAndCreate')
AddEventHandler('x99_badge:checkAndCreate', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local cost = 1000 -- 花费金额

    -- 检查玩家是否有足够的现金
    if Player.Functions.GetMoney("cash") >= cost then
        -- 检查玩家是否为警察
        if Player.PlayerData.job.name == "police" then
            -- 获取玩家的callsign
            local callsign = Player.PlayerData.metadata["callsign"]

            -- 检查callsign是否存在且为三位整数
            if callsign and callsign:match("^%d%d%d$") then
                -- 扣除1000现金
                Player.Functions.RemoveMoney("cash", cost)

                -- 执行操作
                TriggerClientEvent("x99_badge:create", src)

                -- 通知玩家操作成功
                TriggerClientEvent('QBCore:Notify', src, "您成功打印了一张警徽，并支付了 1000 元", 'success')
            else
                -- 如果callsign无效（不是三位数的整数）
                TriggerClientEvent('QBCore:Notify', src, "您的呼号无效，必须是三位数字", 'error')
            end
        else
            -- 如果玩家不是警察
            TriggerClientEvent('QBCore:Notify', src, "您必须是警察才能打印警徽", 'error')
        end
    else
        -- 如果现金不足，通知玩家
        TriggerClientEvent('QBCore:Notify', src, "您的现金不足以打印警徽", 'error')
    end
end)

RegisterNetEvent("x99-badge:CheckAndChangeURL", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player then
        local cash = Player.Functions.GetMoney("cash")

        if cash >= 500 then
            -- 扣除 500 现金
            Player.Functions.RemoveMoney("cash", 500, "修改证件照 URL")

            -- 继续执行原来的逻辑
            TriggerClientEvent("QBCore:Notify", src, "已扣除 $500 现金", "success")
            TriggerClientEvent("x99_badge:changeurl", src, url)
        else
            TriggerClientEvent("QBCore:Notify", src, "现金不足，无法修改证件照 URL", "error")
        end
    end
end)

-- commands
-- rb_code
local QBCore = exports['qb-core']:GetCoreObject()
QBCore.Commands.Add('callsign', '分配警号', { 
    { name = 'playerId', '市民id' },
    { name = 'callsign', '三位整数警号' }
}, false, function(source, args)
    local targetId = tonumber(args[1]) -- 获取玩家 ID
    -- local callsign = table.concat(args, ' ', 2) -- 获取呼号内容
    local callsign = args[2] -- 获取呼号内容

    if not targetId or not callsign then
        TriggerClientEvent('QBCore:Notify', source, "命令输入不正确，请检查", 'error')
        return
    end
    if not callsign:match("^%d%d%d$") then
        TriggerClientEvent('QBCore:Notify', source, "呼号必须是三位整数，例如 101", 'error')
        return
    end
    
    local Player = QBCore.Functions.GetPlayer(source)
    if Player then
        local job = Player.PlayerData.job
        if job.name ~= 'police' or job.grade.level < 3 then
            TriggerClientEvent('QBCore:Notify', source, "您不是警察或者职级不够", 'error')
            return
        end
        QBCore.Functions.GetPlayer(targetId).Functions.SetMetaData('callsign', callsign)
        TriggerClientEvent('QBCore:Notify', source, "id: " .. targetId .. "的警员现在警号为: " .. callsign, 'success')
        TriggerClientEvent('QBCore:Notify', targetId, "您的警号被更新为: " .. callsign, 'primary')
    else
        TriggerClientEvent('QBCore:Notify', source, "没有id: " .. targetId .. "的玩家", 'error')
    end
end)

QBCore.Commands.Add('grantlicense', "授予武器许可", { { name = 'id', help = '市民ID' }, { name = 'license', 'weapon/driver 许可证' } }, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.type == 'leo' and Player.PlayerData.job.grade.level >= 3 then
        if args[2] == 'driver' or args[2] == 'weapon' then
            local SearchedPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
            if not SearchedPlayer then return end
            local licenseTable = SearchedPlayer.PlayerData.metadata['licences']
            if licenseTable[args[2]] then
                TriggerClientEvent('QBCore:Notify', src, '市民已有该许可', 'error')
                return
            end
            licenseTable[args[2]] = true
            SearchedPlayer.Functions.SetMetaData('licences', licenseTable)
            TriggerClientEvent('QBCore:Notify', SearchedPlayer.PlayerData.source, '您被授予'..args[2]..'许可', 'success')
            TriggerClientEvent('QBCore:Notify', src, '成功授予'..args[2]..'许可', 'success')
        else
            TriggerClientEvent('QBCore:Notify', src, '许可证参数输入有误', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, '您无此权限', 'error')
    end
end)

QBCore.Commands.Add('revokelicense', '吊销许可证', { { name = 'id', help = '市民ID' }, { name = 'license', help = 'weapon/driver 许可证' } }, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.type == 'leo' and Player.PlayerData.job.grade.level >= 3 then
        if args[2] == 'driver' or args[2] == 'weapon' then
            local SearchedPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
            if not SearchedPlayer then return end
            local licenseTable = SearchedPlayer.PlayerData.metadata['licences']
            if not licenseTable[args[2]] then
                TriggerClientEvent('QBCore:Notify', src, '错误的许可参数', 'error')
                return
            end
            licenseTable[args[2]] = false
            SearchedPlayer.Functions.SetMetaData('licences', licenseTable)
            TriggerClientEvent('QBCore:Notify', SearchedPlayer.PlayerData.source, '被吊销许可'..' '..args[2], 'error')
            TriggerClientEvent('QBCore:Notify', src, '成功吊销许可'..' '..args[2], 'success')
        else
            TriggerClientEvent('QBCore:Notify', src, '错误的许可参数', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, '您无此权限', 'error')
    end
end)