local QBCore = exports['qb-core']:GetCoreObject()

RegisterCommand("tsunami", function(source, args, rawCommand)
    if not IsPlayerAceAllowed(source, 'command.tsunami') then
        TriggerClientEvent('QBCore:Notify', source, '你没有权限使用该命令!', 'error')
        return
    end

    local time = tonumber(args[1])
    if not time or time <= 0 then
        print("使用方法: /tsunami <秒数>")
        return
    end

    TriggerClientEvent("tsunami:client:StartCountdown", -1, time)
    -- 服务器端定时器，倒计时后执行踢人
    CreateThread(function()
        Wait(time * 1000)
        for _, playerId in pairs(QBCore.Functions.GetPlayers()) do
            DropPlayer(playerId, "海啸来临，请重新乘飞机回国。")
        end
    end)
end, false)