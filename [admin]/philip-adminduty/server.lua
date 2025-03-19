local QBCore = exports['qb-core']:GetCoreObject()
local adminMarker = {}


QBCore.Commands.Add('atag', 'Admin Tag', {}, false, function(source, args)
    local src = source

    if adminMarker[src] then
        adminMarker[src] = nil
    else
        adminMarker[src] = true
    end
    TriggerClientEvent('philip-adminduty:AdminTag', -1, adminMarker)
end, 'admin')

QBCore.Commands.Add('duty', 'Adminduty', {}, false, function(source, args)
    local src = source
    TriggerClientEvent('philip-adminduty:AdminDuty', src)
    -- QBCore.Functions.ToggleOptin(src)
    -- if QBCore.Functions.IsOptin(src) then
    --     TriggerClientEvent('chat:addMessage', -1, { args = { 'SYSTEM', (GetPlayerName(source) .. Lang[Config.Lang].dutyOffGlobal) }, color = { 147, 196, 109 } })
    -- else
    --     TriggerClientEvent('chat:addMessage', -1, { args = { 'SYSTEM', (GetPlayerName(source) .. Lang[Config.Lang].dutyOnGlobal) }, color = { 147, 196, 109 } })
    -- end
end, 'admin')

RegisterNetEvent("philip-adminduty:server:dutyInfo")
AddEventHandler("philip-adminduty:server:dutyInfo", function(state, name)
    local src = source -- 获取触发该事件的玩家 ID
    local dutyStatus = state and Lang[Config.Lang].dutyOnGlobal or Lang[Config.Lang].dutyOffGlobal -- 根据状态转换文本
    local message = "联邦员：" .. name .. dutyStatus

    -- 发送消息到所有玩家的聊天框
    TriggerClientEvent('chat:addMessage', -1, {
        args = { "ADMIN SYSTEM", message },
        color = { 255, 0, 0 } -- 红色高亮
    })

    -- 记录日志（可选）
    -- print("[AdminDuty] " .. message)

    -- 你可以将管理员状态存储到数据库，以便后续查询（如果需要）
end)

AddEventHandler('playerDropped', function()
    local src = source
    if adminMarker[src] then
        adminMarker[src] = nil
    end
    TriggerClientEvent('philip-adminduty:AdminTag', -1, adminMarker)
end)

QBCore.Functions.CreateCallback('philip-adminduty:onPlayerLoad', function(source, cb)
    cb(adminMarker)
end)