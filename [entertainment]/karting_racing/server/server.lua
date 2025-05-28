local QBCore = exports['qb-core']:GetCoreObject()
local waitingPlayers = {}
local raceStarted = false
local RaceStatus = {}
local racingPlayerCnt = 0

local startPointStatus = {} -- true = 占用, false = 可用
local countdownActive = false
local countdownDuration = Config.raceWaitTime

function initStartPointStatus()
    for i = 1, #Config.startPoints do
        startPointStatus[i] = false
    end
end

function allocateStartPoint()
    for i, occupied in ipairs(startPointStatus) do
        if not occupied then
            startPointStatus[i] = true -- 占用
            return Config.startPoints[i]
        end
    end
    return nil
end

function UpdateAndBroadcastRankings()
    local players = {}

    for playerId, status in pairs(RaceStatus) do
        table.insert(players, {
            id = playerId,
            lap = status.lap or 0,
            checkpoint = status.checkpoint or 0,
            lastCheckpointTime = status.lastCheckpointTime or 0
        })
    end

    table.sort(players, function(a, b)
        if a.lap ~= b.lap then return a.lap > b.lap end
        if a.checkpoint ~= b.checkpoint then return a.checkpoint > b.checkpoint end
        return a.lastCheckpointTime < b.lastCheckpointTime
    end)

    for rank, player in ipairs(players) do
        TriggerClientEvent('karting:client:updateRank', player.id, rank, #players)
    end
end

local function GetRemainingCountdownTime()
    if not countdownActive then return Config.raceWaitTime end
    local elapsed = os.time() - countdownStartedAt
    local remaining = countdownDuration - elapsed
    return math.max(0, remaining)
end

local function StartCountdown()
    countdownActive = true
    countdownStartedAt = os.time()

    SetTimeout(countdownDuration * 1000, function()
        countdownActive = false  -- 比赛结束后才应该重置
        StartRace()
    end)
end

function StartRace()
    raceStarted = true
    RaceStatus = {}
    local players = GetPlayersFromTable(waitingPlayers)
    Wait(1000)  -- 这里因为客户端ui绘制的多线程问题，多等一秒
    for _, playerId in ipairs(players) do
        TriggerClientEvent('karting:client:startCountdown', playerId, '出发倒计时', 5)  -- 5s倒计时
    end
    Wait(5000)
    for _, playerId in ipairs(players) do
        TriggerClientEvent('karting:client:beginRace', playerId)  -- 通知客户端比赛开始
    end
    waitingPlayers = {}
end

function FinishRace()
    waitingPlayers = {}
    raceStarted = false
    RaceStatus = {}
end

function CountTable(t)
    local c = 0
    for _ in pairs(t) do c += 1 end
    return c
end

function GetPlayersFromTable(t)
    local players = {}
    for k in pairs(t) do table.insert(players, k) end
    return players
end

RegisterNetEvent('karting:server:updateCheckpoint', function(lap, checkpoint)
    local src = source
    if not raceStarted then return end

    local time = GetGameTimer()
    RaceStatus[src] = RaceStatus[src] or {}
    RaceStatus[src].lap = lap
    RaceStatus[src].checkpoint = checkpoint
    RaceStatus[src].lastCheckpointTime = time

    UpdateAndBroadcastRankings()
end)

RegisterNetEvent('karting:server:joinQueue', function()
    local src = source
    if raceStarted or (countdownActive and GetRemainingCountdownTime() < Config.deadlineSeconds) then
        TriggerClientEvent('ox_lib:notify', src, { description = '比赛已开始或即将开始, 已无法报名！', type = 'error' })
        return
    end

    if CountTable(waitingPlayers) == 0 then 
        initStartPointStatus() 
        StartCountdown()
    end

    if not waitingPlayers[src] then
        local startPos = allocateStartPoint()
        if startPos == nil then 
            TriggerClientEvent('ox_lib:notify', src, { description = '当前比赛已经满员', type = 'error' })
            return
        end
        waitingPlayers[src] = true
        racingPlayerCnt = racingPlayerCnt + 1
        TriggerClientEvent('karting:client:preparePlayerForRace', src, startPos, GetRemainingCountdownTime())  -- 分配起点和准备载具
        TriggerClientEvent('ox_lib:notify', src, { description = '已成功报名比赛！', type = 'success' })
    else
        TriggerClientEvent('ox_lib:notify', src, { description = '你当前正在比赛中...', type = 'error' })
        return
    end
end)

RegisterNetEvent('karting:server:updateFinishedPlayer', function()
    if racingPlayerCnt < 1 then return end
    racingPlayerCnt = racingPlayerCnt - 1
    if racingPlayerCnt == 0 then
        FinishRace()
    end
end) 

RegisterNetEvent('karting:server:getLeaderboard', function()
    local src = source

    MySQL.Async.fetchAll([[
        SELECT name, MIN(lap_time) AS best_time
        FROM karting_racing
        GROUP BY citizenid
        ORDER BY best_time ASC
        LIMIT 10
    ]], {}, function(allTime)

        MySQL.Async.fetchAll([[
            SELECT name, MIN(lap_time) AS best_time
            FROM karting_racing
            WHERE timestamp >= DATE_SUB(NOW(), INTERVAL 7 DAY)
            GROUP BY citizenid
            ORDER BY best_time ASC
            LIMIT 10
        ]], {}, function(weekly)

            TriggerClientEvent('karting:client:showLeaderboard', src, {
                allTime = allTime,
                weekly = weekly
            })

        end)
    end)
end)

lib.callback.register('karting:server:getBestLapTime', function(source)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    if not player then return nil end

    local citizenid = player.PlayerData.citizenid
    local result = MySQL.single.await('SELECT lap_time FROM karting_racing WHERE citizenid = ?', {citizenid})
    if result then
        print("查询到已有记录")
        return result.lap_time
    else
        print("没有记录")
        return nil
    end
end)

RegisterNetEvent('karting:server:updateBestLapTime', function(newBestLapTime)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    if not player then return end
    local citizenid = player.PlayerData.citizenid

    -- 假设表名 karting_racing，字段 lap_time
    MySQL.query('SELECT lap_time FROM karting_racing WHERE citizenid = ?', {citizenid}, function(result)
        if result[1] then
            if newBestLapTime < result[1].lap_time then
                print("更新已有记录")
                MySQL.update('UPDATE karting_racing SET lap_time = ? WHERE citizenid = ?', {newBestLapTime, citizenid})
            end
        else
            print("插入新记录")
            local name = player.PlayerData.charinfo.firstname .. ' ' .. player.PlayerData.charinfo.lastname
            MySQL.insert('INSERT INTO karting_racing (citizenid, name, lap_time) VALUES (?, ?, ?)', {citizenid, name, newBestLapTime})
        end
    end)
end)

lib.callback.register('karting:server:checkLicense', function(source)
    local src = source
    return {
        basic = exports.ox_inventory:Search(src, 'count', Config.karting_license) > 0,
        advanced = exports.ox_inventory:Search(src, 'count', Config.advanced_karting_license) > 0
    }
end)