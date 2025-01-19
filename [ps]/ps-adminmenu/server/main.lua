QBCore = exports['qb-core']:GetCoreObject()

function isAdmin(source)  -- 此资源全局函数
    local result = MySQL.query.await('SELECT COUNT(*) FROM ps_admin WHERE identifier = ?', { QBCore.Functions.GetPlayer(source).PlayerData.citizenid })
    return result[1]["COUNT(*)"] > 0
end

lib.addCommand('ad', {
    help = 'Open the admin menu',
    -- restricted = 'qbcore.mod'
}, function(source)
    if not isAdmin(source) then TriggerClientEvent('QBCore:Notify', source, '您没有管理员权限', 'error') return end
    TriggerClientEvent('ps-adminmenu:client:OpenUI', source)
end)
-- Callbacks

lib.addCommand('addAdmin', {
    help = 'Add a player as an admin',
    -- restricted = 'qbcore.mod',
    params = {{name = 'id', help = 'Player ID'}}
}, function(source, args)
    if not isAdmin(source) then 
        TriggerClientEvent('QBCore:Notify', source, '您没有管理员权限', 'error')
        return
    end
    
    local targetId = tonumber(args[1]) -- 获取目标玩家ID
    if not targetId then
        TriggerClientEvent('QBCore:Notify', source, '无效的玩家ID', 'error')
        return
    end

    local targetIdentifier = QBCore.Functions.GetPlayer(targetId).PlayerData.citizenid
    if not targetIdentifier then
        TriggerClientEvent('QBCore:Notify', source, '未找到该玩家', 'error')
        return
    end

    -- 插入数据库
    MySQL.query('INSERT INTO ps_admin (identifier) VALUES (?)', {targetIdentifier}, function(affectedRows)  -- 异步插入
        if affectedRows > 0 then
            TriggerClientEvent('QBCore:Notify', source, '玩家已成功添加为管理员', 'success')
        else
            TriggerClientEvent('QBCore:Notify', source, '添加管理员失败', 'error')
        end
    end)
end)

lib.addCommand('removeAdmin', {
    help = 'Remove a player from the admin list',
    -- restricted = 'qbcore.mod',
    params = {{name = 'id', help = 'Player ID'}}
}, function(source, args)
    if not isAdmin(source) then 
        TriggerClientEvent('QBCore:Notify', source, '您没有管理员权限', 'error')
        return
    end
    
    local targetId = tonumber(args[1]) -- 获取目标玩家ID
    if not targetId then
        TriggerClientEvent('QBCore:Notify', source, '无效的玩家ID', 'error')
        return
    end

    local targetIdentifier = QBCore.Functions.GetPlayer(targetId).PlayerData.citizenid
    if not targetIdentifier then
        TriggerClientEvent('QBCore:Notify', source, '未找到该玩家', 'error')
        return
    end

    -- 从数据库中删除该玩家的管理员记录
    MySQL.query.await('DELETE FROM ps_admin WHERE identifier = ?', {targetIdentifier})

    -- 检查是否删除成功
    local checkResult = MySQL.query.await('SELECT COUNT(*) FROM ps_admin WHERE identifier = ?', {targetIdentifier})
    if checkResult[1]["COUNT(*)"] == 0 then
        TriggerClientEvent('QBCore:Notify', source, '玩家已成功移除管理员权限', 'success')
    else
        TriggerClientEvent('QBCore:Notify', source, '移除管理员权限失败', 'error')
    end
end)
