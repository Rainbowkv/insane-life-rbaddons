local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('rb-sessiontrace:server:getSessions', function()
    local src = source
    if IsPlayerAceAllowed(src, 'command.trace') then  -- 权限校验
        local query = [[
            SELECT * FROM player_sessions 
            ORDER BY login_time DESC LIMIT 3000
        ]]
        exports.oxmysql:execute(query, {}, function(result)
            TriggerClientEvent('rb-sessiontrace:client:showUI', src, result)
        end)
    else
        TriggerClientEvent('QBCore:Notify', src, "你没有权限查看此面板", "error")
    end
end)

local lastTraceUse = 0 -- ⏱️ 全服冷却时间戳
QBCore.Commands.Add('trace', '', {}, false, function(source, _)
    local now = os.time()
    if now - lastTraceUse < 3 then
        TriggerClientEvent('QBCore:Notify', source, '请稍等几秒后再使用此命令。', 'error')
        return
    end
    lastTraceUse = now
    
    TriggerClientEvent('rb-sessiontrace:client:open', source)
end, 'admin') -- 👈 只有 admin 权限才能使用