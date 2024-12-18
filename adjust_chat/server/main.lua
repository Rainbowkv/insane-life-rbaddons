-- server.lua
local QBCore = exports['qb-core']:GetCoreObject()

-- 当玩家发送聊天消息时，此事件为fivem提供
AddEventHandler('chatMessage', function(source, name, message)
    local player = QBCore.Functions.GetPlayer(source)
    local citizen_name = (player.PlayerData.charinfo.firstname or '') .. ' ' .. (player.PlayerData.charinfo.lastname or '')  -- 获取市民姓名
    local currentTime = os.date("%H:%M:%S")  -- 获取当前时间（时:分:秒）
    local formattedMessage = string.format("(%s) [%s]%s: %s", currentTime, source, citizen_name, message)
    
    CancelEvent()  -- 取消原有的聊天消息发送，fivem接口

    -- 使用新的格式发送消息
    TriggerClientEvent('chat:addMessage', -1, {
        args = { formattedMessage }
    })
end)