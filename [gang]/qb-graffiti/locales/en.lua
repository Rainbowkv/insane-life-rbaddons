local Translations = {
    error = {
        not_information = '该物品没有信息。从商店购买涂鸦！',
        not_found = '未找到涂鸦。',
        gang_only = '此涂鸦仅限购买其的帮派使用。',
        exist_graffiti = '附近已经有人放置了涂鸦。',
        blacklist_location = '您不能在此处放置涂鸦。',
        not_have_money = '您的钱不够。还需要更多 (%{value}$)。'
    },

    success = {
        buy_spraycan = '您以 %{value}$ 的价格购买了一罐名为 %{value2} 的涂鸦喷雾。'
    },

    blip = {
        graffiti_shop = '帮派涂鸦'
    },

    target = {
        graffiti_shop = '帮派涂鸦'
    },

    menu = {
        graffiti_shop = '帮派涂鸦'
    },

    progressbar = {
        spraying_on_wall = '正在墙上喷涂',
        washing_the_wall = '正在清洗墙壁'
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})