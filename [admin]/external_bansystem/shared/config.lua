return {
    Debug = false,
    AdminOnly = true,  -- 仅有管理员能打开该面板
    AdminGroups = { "godz" },
    -- AdminGroups = { "admin" },
    Keybind = "F10",

    IdentifierPriority = {
        "license",
        "steam",
        "discord",
        "ip"
    },

    Commands = {
        ban = "ban",
        unban = "unban",
    },

    Webhook = {
        botName = "External Ban System",
        avatarUrl = "https://i.imgur.com/xxxxxxxxx.png",
        footerText = "External Ban System • Powered by your_server_name",
        footerIcon = "https://i.imgur.com/xxxxxxxxx.png",
        color = {
            ban = 16711680,
            unban = 65280,
            edit = 16776960
        }
    },

    Messages = {
        banUsage = "用法: /ban [玩家ID] [时长 (可选)] [原因]",
        unbanUsage = "用法: /unban [封禁ID]",
        playerNotFound = "未找到该玩家。",
        identifierError = "无法找到该玩家的有效标识符。",
        banned = "您已被封禁。\n封禁ID: %s\n原因: %s\n封禁者: %s\n封禁日期: %s\n封禁时长: %s",
        unbanSuccess = "%s 已被解封。",
        banEditSuccess = "%s 的封禁记录已更新。",
        notBanned = "此标识符未被封禁或已被解封。",
    },

    UI = {
        appealInfo = {
            enabled = false,
            discordLink = "https://discord.gg/yourserver",
            showAppealButton = true,
            message = "如果您认为此封禁是错误的，您可以在我们的 kook 服务器上申诉。"
        },

        durations = {
            { label = "永久", value = "5475d" },
            { label = "1 小时",    value = "1h" },
            { label = "6 小时",   value = "6h" },
            { label = "12 小时",  value = "12h" },
            { label = "1 天",     value = "1d" },
            { label = "3 天",    value = "3d" },
            { label = "7 天",    value = "7d" },
            { label = "14 天",   value = "14d" },
            { label = "30 天",   value = "30d" },
            { label = "60 天",   value = "60d" },
            { label = "90 天",   value = "90d" },
            { label = "6 月",  value = "180d" },
            { label = "1 年",    value = "365d" }
        }
    },

    -- I recommend not changing these
    RateLimits = {
        hasPermission = { maxRequests = 3, timeWindow = 3 },
        getAllPlayers = { maxRequests = 1, timeWindow = 5 },
        getServerPlayers = { maxRequests = 1, timeWindow = 5 },
        getPlayerIdentifiers = { maxRequests = 2, timeWindow = 5 },
        getBanList = { maxRequests = 1, timeWindow = 5 },
        getInactiveBans = { maxRequests = 1, timeWindow = 5 },
        getPlayerBanHistory = { maxRequests = 1, timeWindow = 5 }
    },

    AbusePenalties = {
        dropThreshold = 2,
        banThreshold = 3,
        banDuration = "1h"
    },

    CleanupConfig = {
        inactivityPeriod = 24, --in hours
        runInterval = 1,       --in hours
    }
}
