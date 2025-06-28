Config = {}

-- General settings
Config.Enabled = true -- Enable/disable the welcome screen

-- Spawn settings
Config.WaitAfterSpawn = 2000 -- Time in ms to wait after spawn before showing welcome screen (increase this value if the welcome screen appears during character creation)
Config.ShowOnlyOnce = false -- If true, will only show once per player (uses player identifier)

-- Content settings
Config.Title = "欢迎参与Ravens内测" -- Title of the welcome screen
Config.Logo = "" -- URL to your server logo (leave empty for no logo)
Config.BackgroundImage = "https://wallpapercave.com/wp/wp4421387.jpg" -- URL to background image (leave empty for default background)
Config.BackgroundColor = "#0f0f0f" -- Background color (only used if no background image)
Config.TextColor = "#ffffff" -- Text color

-- Button settings
Config.AcceptButtonText = "知晓" -- Text for the accept button
Config.DeclineButtonText = "不同意" -- Text for the decline button
Config.AcceptButtonColor = "#4CAF50" -- Color for the accept button
Config.DeclineButtonColor = "#f44336" -- Color for the decline button

-- Content sections (add as many as you want)
Config.Sections = {
    -- {
    --     title = "新玩家福利",
    --     content = [[
    --         <p>1. 内测新玩家注册奖励10万美金作为启动资金；</p>
    --         <p>2. 公测新玩家注册7天累计在线市场达35小时后奖励4万美金；</p>
    --         <p>3. 女性玩家认证注册奖励美金基础上额外奖励4万美金，给予2次捏脸机会；</p>
    --         <p>4. 新玩家5人及以上组队注册可以奖励产业一个月经营权，启动资金300万（后续根据当月在线时长可追加美金奖励，在线时长当月少于120小时则收回产业）；</p>
    --     ]]
    -- },
    {
        title = "新玩家福利",
        content = [[
            <p>新人进服（过白名单），根据新人在线时长：</p>
            <p>1. 新人在线时长>  2小时，奖励 16688美金；</p>
            <p>2. 新人在线时长>  6小时，奖励 26888美金；</p>
            <p>3. 新人在线时长> 35小时，奖励 46888美金；</p>
            <p>4. 新人在线时长>120小时，奖励 66888美金。</p>
        ]]
    },
    {
        title = "Ravens社区",
        content = [[
            <p>QQ群: <a href="972144535" target="_blank">972144535</a></p>
            <p>KOOK邀请码: <a href="https://kook.vip/N72G32" target="_blank">https://kook.vip/N72G32</a></p>
            <p>服务器扮演规则: <a href="https://www.yuque.com/ravens914/chw7yb/lqqeovwmhcpktbt9?singleDoc#" target="_blank">https://www.yuque.com/ravens914/chw7yb/lqqeovwmhcpktbt9?singleDoc#</a></p>
        ]]
    }
}

-- Actions when buttons are clicked
Config.OnAccept = {
    notification = true, -- Show notification when accepted
    notificationText = "Bienvenido a Amadeus. ¡Disfruta tu estancia!", -- Text for the notification
    notificationType = "success" -- Type of notification (success, info, error)
}

Config.OnDecline = {
    kickReason = "拒绝了新人福利" -- Reason for kicking
}
