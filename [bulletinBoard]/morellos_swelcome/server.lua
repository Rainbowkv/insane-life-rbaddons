-- Table to store players who have seen the welcome screen
local playersSeenWelcome = {}

local function insertSessionLog(citizenid, name, src, loginTime, dropTime)
    MySQL.Async.execute('INSERT INTO player_sessions (citizenid, name, src, login_time, drop_time) VALUES (?, ?, ?, ?, ?)', {
        citizenid, name, src, os.date("%Y-%m-%d %H:%M:%S", loginTime), os.date("%Y-%m-%d %H:%M:%S", dropTime)
    })
end

-- Register server event to kick player
RegisterNetEvent('fivem_welcome:kickPlayer')
AddEventHandler('fivem_welcome:kickPlayer', function(reason)
    local src = source
    DropPlayer(src, reason)
end)

-- Register server event to check if player has seen welcome screen
RegisterNetEvent('fivem_welcome:checkPlayerSeen')
AddEventHandler('fivem_welcome:checkPlayerSeen', function()
    local src = source
    local identifier = GetPlayerIdentifier(src, 0) -- Get player's identifier
    
    if Config.ShowOnlyOnce and identifier then
        if not playersSeenWelcome[identifier] then
            -- Player hasn't seen welcome screen yet
            playersSeenWelcome[identifier] = true
            TriggerClientEvent('fivem_welcome:showWelcomeScreen', src)
        end
    else
        -- Always show if ShowOnlyOnce is disabled
        TriggerClientEvent('fivem_welcome:showWelcomeScreen', src)
    end
end)

-- Register server event to mark player as having seen welcome screen
RegisterNetEvent('fivem_welcome:playerAccepted')
AddEventHandler('fivem_welcome:playerAccepted', function()
    local src = source
    local identifier = GetPlayerIdentifier(src, 0)
    
    if identifier then
        playersSeenWelcome[identifier] = true
    end
end)

-- Print a message when the resource starts
AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    print('^2FiveM Welcome^7: Resource started successfully')
end)

-- Clear the table when the resource stops
AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    playersSeenWelcome = {}
end)

-- rb_code 统计玩家在线时间
local QBCore = exports['qb-core']:GetCoreObject()
local onlineTimes = {}
local sessionInfo = {}

-- 玩家上线：记录登录时间戳
-- AddEventHandler('QBCore:Server:PlayerLoaded', function(player)
AddEventHandler('QBCore:Server:PlayerLoaded', function(player)
    if Player then
        local citizenid = player.PlayerData.citizenid
        onlineTimes[citizenid] = os.time()  -- for在线时长
        local src = player.PlayerData.source
        sessionInfo[citizenid] = {  -- for管理员查某个时间段某个id是哪个玩家
            login_time = os.time(),
        }
    end
end)

-- 玩家下线：计算在线时间并更新数据库
AddEventHandler('playerDropped', function(reason)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        local citizenid = Player.PlayerData.citizenid
        local name = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
        local loginTime = onlineTimes[citizenid]
        if loginTime then
            local sessionTime = os.time() - loginTime
            updatePlayTime(citizenid, name, math.ceil(sessionTime / 60))  -- 分钟为单位
            onlineTimes[citizenid] = nil
            -- 插入 session 记录
            local info = sessionInfo[citizenid]
            if info then
                insertSessionLog(citizenid, name, src, info.login_time, os.time())
                sessionInfo[citizenid] = nil
            end
        end
    end
end)

-- 更新或插入数据库记录
function updatePlayTime(citizenid, name, sessionTime)
    MySQL.Async.fetchScalar('SELECT play_time FROM player_statistics WHERE citizenid = ?', {
        citizenid
    }, function(existingTime)
        if existingTime then
            -- 已有记录，更新时长
            MySQL.Async.execute('UPDATE player_statistics SET play_time = play_time + ? WHERE citizenid = ?', {
                sessionTime, citizenid
            })
        else
            -- 没有记录，插入新行
            MySQL.Async.execute('INSERT INTO player_statistics (citizenid, name, play_time) VALUES (?, ?, ?)', {
                citizenid, name, sessionTime
            })
        end
    end)
end