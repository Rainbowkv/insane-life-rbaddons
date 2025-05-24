Config = {}

Config.Framework = 'qbcore' -- 'auto' | 'esx' | 'qbcore' | 'custom' (make sure to configure */famework.lua files if you set the custom framework)
Config.FrameworkData = { -- ONLY change these if you have custom names set on your framework
    SharedObjectEventNameCL = nil, -- Framework shared object event name for client side
    SharedObjectEventNameSV = nil, -- Framework shared object event name for server side
}
Config.Notifications = 'framework'

Config.Locale = 'zh'

-- If table currency is set to 'chips' this item will be used.
Config.ChipsItem = 'casinochips'
Config.casinoAccount = 'casino'

-- 兑换 NPC 模型及坐标
Config.ExchangeNPC = {
    model = 's_m_m_highsec_01',
    coords = vector4(-1190.31, -888.01, 13.89, 219.89)
}

-- 兑换筹码为现金时的手续费（百分比）
Config.CashoutFeeRatio = 0.09 -- 9% 手续费，筹码兑换为现金时
Config.maxValue = 1000000  -- 输入框接受的最大值

Config.TurnTimeout = 60 -- in seconds

Config.Controls = {
    SitAtTable = {0, 38}, -- Control used to sit at the table
    CameraSwitch = {0, 22}, -- Control used to sit at the table
}

Config.ChairInteractDist = 2.0

Config.Tables = {
    ---------------------------------------------------
    -- Example with each chair having specific coords:
    ---------------------------------------------------
    -- {
    --     name = 'casino_01', -- MUST BE UNIQUE
    --     buyIn = 100, -- Minimum buy in amount
    --     bigBlind = 10, -- Big blind amount, small is bigBlind/2
    --     currency = 'chips', -- chips | cash | custom. Can be customized / added more currency methods in server/framework.lua
    --     tableModel = 'dzp_sd_prop_casino_poker_table_01',
    --     chairModel = 'dzp_sd_prop_casino_poker_chair_01',
    --     -- tableCoords = vec(1029.0602, 56.2705, 71.4303, 103.0339),
    --     tableCoords = vec(-287.86, -992.56, 34.23, 342.85), -- vector4(vector4(, 35.23, 73.43))
    --     dealerOffset = vec(-1.1, 0.0, 0.03, 90.0),
    --     printOffsets = true, -- Will print offsets of chairs in console
    --     cards = {
    --         offsets = {
    --             {-0.555, -0.263, 0.943},
    --             {-0.555, -0.13, 0.943},
    --             {-0.555, -0.003, 0.943},
    --             {-0.555, 0.132, 0.943},
    --             {-0.555, 0.267, 0.943},
    --         },
    --         objects = {},
    --     },
    --     chairs = { -- Max table players is equal to amount of chairs
    --         {
    --             coords = vec(1028.1563, 54.8245, 71.4762, 344.0085 - 90)
    --         },
    --         {
    --             coords = vec(1027.3790, 55.2773, 71.4762, 312.6748 - 90)
    --         },
    --         {
    --             coords = vec(1027.0741, 56.4626, 71.4762, 255.1437 - 90)
    --         },
    --         {
    --             coords = vec(1027.5634, 57.2135, 71.4762, 220.3610 - 90)
    --         },
    --         {
    --             coords = vec(1028.4296, 57.4593, 71.4762, 192.9161 - 90)
    --         },
    --         {
    --             coords = vec(1029.1787, 57.6244, 71.4763, 193.4302 - 90)
    --         },
    --         {
    --             coords = vec(1030.1465, 57.6492, 71.4762, 160.9222 - 90)
    --         },
    --         {
    --             coords = vec(1030.7915, 57.1363, 71.4762, 120.1953 - 90)
    --         },
    --         {
    --             coords = vec(1030.9965, 56.1221, 71.4762, 78.2211 - 90)
    --         },

    --         {
    --             coords = vec(1030.4567, 55.2625, 71.4762, 36.1610 - 90)
    --         },
    --     }
    -- },
    {
        name = 'xinshougongyu', -- MUST BE UNIQUE
        buyIn = 100, -- Minimum buy in amount
        bigBlind = 10, -- Big blind amount, small is bigBlind/2
        currency = 'chips', -- chips | cash | custom. Can be customized / added more currency methods in server/framework.lua (CheckPlayerEligible, RemoveCurrency, AddCurrency)
        tableModel = 'dzp_sd_prop_casino_poker_table_01',
        chairModel = 'dzp_sd_prop_casino_poker_chair_01',
        -- tableCoords = vec(994.8425, 54.8804, 68.4329, 192.9074),
        tableCoords = vec(-1194.44, -889.44, 12.89, 305.69), -- vector4()
        topCamHeight = 2.7, -- Height above table of static above view camera
        dealerOffset = vec(-1.15, 0.0, 0.03, 90.0),
        dealerPedData = DEALER_PEDS_CASINO,
        deckOffset = vec(-0.720, 0.292, 0.94),
        sitOffsets = vec(-0.13, 0.0, -0.6, 180.0),
        tableSceneOffset = vec(-0.42, 0.0, 0.0),
        playerCardsOffsets = {
            vec(0.01, 0.5, 0.0),
            vec(-0.03, 0.0, 0.0),
        },
        cards = {
            offsets = {
                {-0.555, -0.263, 0.943},
                {-0.555, -0.13, 0.943},
                {-0.555, -0.003, 0.943},
                {-0.555, 0.132, 0.943},
                {-0.555, 0.267, 0.943},
            },
            objects = {},
        },
        chairs = {
            {offset = vec(-1.205, 1.207, 0.04, 150.975)},
            {offset = vec(-0.588, 1.862, 0.04, 119.641)},
            {offset = vec(0.635, 1.892, 0.04, 62.110)},
            {offset = vec(1.256, 1.246, 0.04, 27.327)},
            {offset = vec(1.300, 0.346, 0.04, -0.118)},
            {offset = vec(1.292, -0.421, 0.04, 0.396)},
            {offset = vec(1.098, -1.369, 0.04, -32.112)},
            {offset = vec(0.453, -1.882, 0.04, -72.839)},
            {offset = vec(-0.581, -1.853, 0.04, -114.813)},
            {offset = vec(-1.297, -1.133, 0.04, -156.873)},
        }
    },
    -- {
    --     name = 'casino_03', -- MUST BE UNIQUE
    --     buyIn = 1000, -- Minimum buy in amount
    --     bigBlind = 100, -- Big blind amount, small is bigBlind/2
    --     currency = 'chips', -- chips | cash | custom. Can be customized / added more currency methods in server/framework.lua
    --     tableModel = 'dzp_sd_prop_casino_poker_table_01',
    --     chairModel = 'dzp_sd_prop_casino_poker_chair_01',
    --     tableCoords = vec(1000.1622, 56.0508, 68.4329, 192.0431),
    --     topCamHeight = 2.7, -- Height above table of static above view camera
    --     dealerOffset = vec(-1.15, 0.0, 0.03, 90.0),
    --     cards = {
    --         offsets = {
    --             {-0.555, -0.263, 0.943},
    --             {-0.555, -0.13, 0.943},
    --             {-0.555, -0.003, 0.943},
    --             {-0.555, 0.132, 0.943},
    --             {-0.555, 0.267, 0.943},
    --         },
    --         objects = {},
    --     },
    --     chairs = {
    --         {offset = vec(-1.205, 1.207, 0.04, 150.975)},
    --         {offset = vec(-0.588, 1.862, 0.04, 119.641)},
    --         {offset = vec(0.635, 1.892, 0.04, 62.110)},
    --         {offset = vec(1.256, 1.246, 0.04, 27.327)},
    --         {offset = vec(1.300, 0.346, 0.04, -0.118)},
    --         {offset = vec(1.292, -0.421, 0.04, 0.396)},
    --         {offset = vec(1.098, -1.369, 0.04, -32.112)},
    --         {offset = vec(0.453, -1.882, 0.04, -72.839)},
    --         {offset = vec(-0.581, -1.853, 0.04, -114.813)},
    --         {offset = vec(-1.297, -1.133, 0.04, -156.873)},
    --     }
    -- },
}

Config.LogsWebhook = ''

Strings = {
    ['en'] = {
        ['notification_sit_at_table'] = '[E] - Start playing',
        ['header_label_winners'] = 'Winners: %s',
        ['header_label_idle'] = 'Waiting...',
        ['header_label_waiting_new_game'] = 'Waiting for new game...',
        ['subheader_label_turn'] = 'Is current actor',
        ['subheader_label_not_enough_players'] = 'Not enough players',
        ['alert_not_actor'] = 'You are not the current actor',
        ['alert_action_not_legal'] = 'This action is not currently legal',
        ['alert_amount_invalid'] = 'The bet amount is not valid',
        ['alert_seat_taken'] = 'This seat is already taken, please choose another one',
        ['alert_switch_cam_button'] = 'You can change camera back to static using [Space] button',
        ['error_not_enough_money'] = 'You do not have enough money to do this action',
        ['table_full'] = 'No available seats at the table',
        ['small_buy_in'] = 'Buy in is too small',
        ['already_seated_wait_for_next_hand'] = 'You are already seated, please wait for this game to end',
        ['already_seated'] = 'You are already seated',
        ['illegal_action'] = 'Illegal action',
        ['action_out_of_turn'] = 'Action out of turn',
        ['amount_not_valid'] = 'Amount was not a valid number',
        ['bet_too_small_big_blind'] = 'A bet must be at least as much as the big blind',
        ['cannot_bet_more_than_bank'] = 'You cannot bet more than you brought to the table',
    },
    ['lt'] = {
        ['notification_sit_at_table'] = '[E] - Pradėti žaisti',
        ['header_label_winners'] = 'Laimėjo: %s',
        ['header_label_idle'] = 'Laukiama žaidėjų...',
        ['header_label_waiting_new_game'] = 'Laukiama naujo žaidimo pradžios...',
        ['subheader_label_turn'] = 'Eilė',
        ['subheader_label_not_enough_players'] = 'Not enough players',
        ['alert_not_actor'] = 'You are not the current actor',
        ['alert_action_not_legal'] = 'This action is not currently legal',
        ['alert_amount_invalid'] = 'The bet amount is not valid',
        ['alert_seat_taken'] = 'This seat is already taken, please choose another one',
        ['alert_switch_cam_button'] = 'You can change camera back to static using [Space] button',
        ['error_not_enough_money'] = 'You do not have enough money to do this action',
    },
    ['zh'] = {
        ['notification_sit_at_table'] = '[E] - 开始游戏',
        ['header_label_winners'] = '获胜者: %s',
        ['header_label_idle'] = '等待中...',
        ['header_label_waiting_new_game'] = '等待新游戏...',
        ['subheader_label_turn'] = '是当前行动者',
        ['subheader_label_not_enough_players'] = '玩家不足',
        ['alert_not_actor'] = '您不是当前的行动者',
        ['alert_action_not_legal'] = '此操作目前不合法',
        ['alert_amount_invalid'] = '下注金额无效',
        ['alert_seat_taken'] = '此座位已被占用，请选择另一个',
        ['alert_switch_cam_button'] = '您可以使用 [空格] 键将摄像头切换回静态',
        ['error_not_enough_money'] = '您的筹码不足以执行此操作',
        ['table_full'] = '桌子没有可用座位',
        ['small_buy_in'] = '买入金额太小',
        ['already_seated_wait_for_next_hand'] = '您已经就座，请等待本局游戏结束',
        ['already_seated'] = '您已经就座',
        ['illegal_action'] = '非法操作',
        ['action_out_of_turn'] = '轮次外的操作',
        ['amount_not_valid'] = '金额不是一个有效的数字',
        ['bet_too_small_big_blind'] = '下注必须至少等于大盲注',
        ['cannot_bet_more_than_bank'] = '您不能下注超过您带到桌上的金额',
    },
}

-- Higher the number more prints will come on console
Config.DebugLevel = 0
