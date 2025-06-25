Config = {}

Config.ped = {
    model = 'a_m_m_business_01',
    coords = vector3(-258.83, -966.16, 30.23),
    handing = 112.4
}

Config.Leaderboards = {
    forbes = {
        label = "福布斯",
        needSignUp = true,
        columns = {
            { name = "rank", label = "排名" },
            { name = "name", label = "姓名" },
            { name = "dollar", label = "即时资本" }
        },
        getData = function()
            return CachedLeaderboards.forbes and CachedLeaderboards.forbes.data or {}
        end
    },

    fishing = { 
        label = "海钓佬", 
        needSignUp = false,
        columns = {
            { name = "rank", label = "排名" },
            { name = "name", label = "姓名" },
            { name = "level", label = "级别" }
        }, 
        getData = function()  
            return CachedLeaderboards.fishing and CachedLeaderboards.fishing.data or {}
        end 
    },

    playtime = { 
        label = "国内时长", 
        needSignUp = false,
        columns = {
            { name = "rank", label = "排名" },
            { name = "name", label = "姓名" },
            { name = "duration", label = "分钟" }
        }, 
        getData = function()  
            return CachedLeaderboards.playtime and CachedLeaderboards.playtime.data or {}
        end 
    },
    -- 你可以继续添加更多排行榜，例如：
    -- kills = { 
    --     label = "杀敌排行榜", 
    --     columns = {
    --         { name = "name", label = "姓名" },
    --         { name = "KDA", label = "K/D" }
    --     }, 
    --     getData = function()  
    --         return {
    --             {name = '12', KDA = 40},
    --             {name = '32', KDA = 30},
    --             {name = '42', KDA = 20},
    --             {name = '52', KDA = 10}
    --         }
    --     end 
    -- },
}