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
            TriggerClientEvent("x99-pdbadge:open", -1, source, coords, item.info)
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