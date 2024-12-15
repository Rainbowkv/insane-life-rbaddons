-- server.lua
local QBCore = exports['qb-core']:GetCoreObject()

-- 添加金钱命令
RegisterCommand('addMoney', function(source, args, rawCommand)
    -- 检查是否有足够的权限执行此命令
    if not IsPlayerAceAllowed(source, 'command.addmoney') then
        TriggerClientEvent('QBCore:Notify', source, '你没有权限使用该命令!', 'error')
        return
    end

    local targetId = tonumber(args[1])
    local amount = tonumber(args[2])

    if not targetId or not amount or amount <= 0 then
        TriggerClientEvent('QBCore:Notify', source, '请使用正确的格式 /addMoney [玩家ID] [金额]', 'error')
        return
    end

    local TargetPlayer = QBCore.Functions.GetPlayer(targetId)
    if TargetPlayer then
        TargetPlayer.Functions.AddMoney('cash', amount) -- 'bank' 可以替换为 'cash' 或其他货币类型
        TriggerClientEvent('QBCore:Notify', source, '你给玩家 ' .. targetId .. ' 增加了 $' .. amount .. ' 现金!', 'success')
        TriggerClientEvent('QBCore:Notify', targetId, '你获得了 $' .. amount .. ' 现金!', 'success')
    else
        TriggerClientEvent('QBCore:Notify', source, '找不到指定的玩家ID!', 'error')
    end
end, false)

-- 减少金钱命令
RegisterCommand('subMoney', function(source, args, rawCommand)
    -- 检查是否有足够的权限执行此命令
    if not IsPlayerAceAllowed(source, 'command.submoney') then
        TriggerClientEvent('QBCore:Notify', source, '你没有权限使用该命令!', 'error')
        return
    end

    local targetId = tonumber(args[1])
    local amount = tonumber(args[2])

    if not targetId or not amount or amount <= 0 then
        TriggerClientEvent('QBCore:Notify', source, '请使用正确的格式 /subMoney [玩家ID] [金额]', 'error')
        return
    end

    local TargetPlayer = QBCore.Functions.GetPlayer(targetId)
    if TargetPlayer then
        if TargetPlayer.PlayerData.money.cash >= amount then
            TargetPlayer.Functions.RemoveMoney('cash', amount) -- 'bank' 可以替换为 'cash' 或其他货币类型
            TriggerClientEvent('QBCore:Notify', source, '你从玩家 ' .. targetId .. ' 扣除了 $' .. amount .. ' 现金!', 'success')
            TriggerClientEvent('QBCore:Notify', targetId, '你失去了 $' .. amount .. ' 现金!', 'error')
        else
            TriggerClientEvent('QBCore:Notify', source, '目标玩家的现金不足以扣款!', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', source, '找不到指定的玩家ID!', 'error')
    end
end, false)