CachedLeaderboards = {}

local QBCore = exports['qb-core']:GetCoreObject()

local function RefreshForbesRanking()
    local results = MySQL.query.await([[
        SELECT p.charinfo, p.money
        FROM players p
        INNER JOIN rb_ranking_optin o ON o.citizenid = p.citizenid
        WHERE o.leaderboard = 'forbes'
    ]])
    local parsed = {}

    for _, row in pairs(results) do
        local charinfo = json.decode(row.charinfo)
        local name = charinfo.firstname .. ' ' .. charinfo.lastname
        local money = json.decode(row.money)
        local dollar = (money.cash or 0) + (money.bank or 0)
        table.insert(parsed, { name = name, dollar = dollar })
    end

    table.sort(parsed, function(a, b) return a.dollar > b.dollar end)

    local topTen = {}
    for i = 1, math.min(10, #parsed) do
        parsed[i].rank = i
        table.insert(topTen, parsed[i])
    end

    CachedLeaderboards.forbes = {
        data = topTen
    }

    print("[排行榜] 福布斯排行榜已刷新")
end

local function RefreshAllRanking()
    RefreshForbesRanking()
end

local function refreshAndScheduleNext()
    RefreshAllRanking()  -- 执行刷新

    -- 计算下次刷新距离现在还有多少毫秒（到第二天1点）
    local now = os.date("*t")
    local nextRefresh = os.time({
        year = now.year,
        month = now.month,
        day = now.day + 1,
        hour = 1, min = 0, sec = 0
    })
    local delay = (nextRefresh - os.time()) * 1000

    print(("[排行榜] 下一次刷新将在 %d 秒后"):format(delay / 1000))

    -- 延时调用自身实现循环
    Citizen.SetTimeout(delay, refreshAndScheduleNext)
end

local function updateForbesRankingWhenNewAdd(src, Player)
    local charinfo = Player.PlayerData.charinfo
    local name = (charinfo.firstname or "") .. " " .. (charinfo.lastname or "")
    local money = Player.PlayerData.money
    local dollar = (money.cash or 0) + (money.bank or 0)

    local leaderboard = CachedLeaderboards.forbes and CachedLeaderboards.forbes.data or {}
    
    -- 如果还没满10个，直接插入合适位置
    local inserted = false
    for i = 1, #leaderboard do
        if dollar > leaderboard[i].dollar then
            table.insert(leaderboard, i, { name = name, dollar = dollar })
            inserted = true
            break
        end
    end

    -- 如果没有插入说明比现有所有人都少，可能加在最后
    if not inserted and #leaderboard < 10 then
        table.insert(leaderboard, { name = name, dollar = dollar })
        inserted = true
    end

    -- 如果已插入且超出10人，去掉最后一个
    if inserted and #leaderboard > 10 then
        table.remove(leaderboard, 11)
    end

    -- 重设排名
    for i = 1, #leaderboard do
        leaderboard[i].rank = i
    end

    CachedLeaderboards.forbes = {
        data = leaderboard
    }

    if inserted then
        TriggerClientEvent("ox_lib:notify", -1, {
            type = "success",
            title = "Ravens福布斯榜",
            description = ("%s 大佬以 $ %d 即时资本成功进入福布斯榜第 %d 名"):format(name, dollar, leaderboard[#leaderboard].rank)
        })
    else
        TriggerClientEvent("ox_lib:notify", src, {
            type = "info",
            title = "Ravens福布斯榜",
            description = '您暂未能进入福布斯榜，期待明日榜单有您~'
        })
    end
end

-- 资源启动时调用一次，启动循环
AddEventHandler('onResourceStart', function(resource)
    if GetCurrentResourceName() ~= resource then return end

    refreshAndScheduleNext()
end)

QBCore.Functions.CreateCallback('rb-ranking:server:getData', function(src, cb, boardId)
    local board = Config.Leaderboards[boardId]
    if not board then return cb(nil) end

    local data = board.getData()
    cb({
        label = board.label,
        columns = board.columns,
        data = data
    })
end)

RegisterNetEvent("rb-ranking:server:optInLeaderboard", function(boardId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local citizenid = Player.PlayerData.citizenid
    if not Config.Leaderboards[boardId] then return end

    -- ✅ 查询是否已报名过
    local exists = MySQL.scalar.await([[
        SELECT 1 FROM rb_ranking_optin
        WHERE citizenid = ? AND leaderboard = ?
        LIMIT 1
    ]], { citizenid, boardId })

    if exists then
        -- ❌ 已经报名，提示用户
        TriggerClientEvent("ox_lib:notify", src, {
            type = "info",
            title = "重复报名",
            description = "你已报名该排行榜，无需重复操作"
        })
        return
    end

    MySQL.query.await([[
        INSERT IGNORE INTO rb_ranking_optin (citizenid, leaderboard)
        VALUES (?, ?)
    ]], { citizenid, boardId })

    TriggerClientEvent("ox_lib:notify", src, {
        type = "success",
        title = "报名成功",
        description = "你已成功报名 " .. Config.Leaderboards[boardId].label
    })
    if boardId == "forbes" then
        updateForbesRankingWhenNewAdd(src, Player)
    end
end)