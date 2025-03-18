Config = Config or {}

Config.Fuel = "ps-fuel"        -- "ps-fuel", "LegacyFuel", "ox_fuel"
Config.ResourcePerms = 'admin' -- permission to control resource(start stop restart)
Config.ShowCommandsPerms = 'admin' -- permission to show all commands
Config.RenewedPhone = false    -- if you use qb-phone from renewed. (multijob)

-- Key Bindings
Config.Keybindings = true
Config.AdminKey = "PageDown"
Config.NoclipKey = "PageUp"

-- Give Car
Config.DefaultGarage = "Alta Garage"

Config.Actions = {
--     ["admin_car"] = {
--     label = "拥有当前车辆",
--     type = "client",
--     event = "ps-adminmenu:client:Admincar",
--     perms = "mod",
-- },

["ban_player"] = {
    label = "封禁玩家",
    perms = "mod",
    dropdown = {
        { label = "玩家", option = "dropdown", data = "players" },
        { label = "原因", option = "text" },
        {
            label = "时长",
            option = "dropdown",
            data = {
                { label = "永久",  value = "2147483647" },
                { label = "10分钟", value = "600" },
                { label = "30分钟", value = "1800" },
                { label = "1小时",     value = "3600" },
                { label = "6小时",    value = "21600" },
                { label = "12小时",   value = "43200" },
                { label = "1天",      value = "86400" },
                { label = "3天",     value = "259200" },
                { label = "1周",      value = "604800" },
                { label = "3周", value = "1814400" },
            },
        },
        { label = "确认", option = "button", type = "server", event = "ps-adminmenu:server:BanPlayer" },
    },
},

["bring_player"] = {
    label = "传送玩家",
    perms = "mod",
    dropdown = {
        { label = "玩家",  option = "dropdown", data = "players" },
        { label = "确认", option = "button",   type = "server", event = "ps-adminmenu:server:BringPlayer" },
    },
},

["change_weather"] = {
    label = "更改天气",
    perms = "mod",
    dropdown = {
        {
            label = "天气",
            option = "dropdown",
            data = {
                { label = "晴朗", value = "Extrasunny" },
                { label = "晴天",      value = "Clear" },
                { label = "中性",    value = "Neutral" },
                { label = "烟雾",       value = "Smog" },
                { label = "多雾",      value = "Foggy" },
                { label = "阴天",   value = "Overcast" },
                { label = "多云",     value = "Clouds" },
                { label = "放晴",   value = "Clearing" },
                { label = "下雨",       value = "Rain" },
                { label = "雷暴",    value = "Thunder" },
                { label = "下雪",       value = "Snow" },
                { label = "暴风雪",   value = "Blizzard" },
                { label = "小雪",  value = "Snowlight" },
                { label = "圣诞节",       value = "Xmas" },
                { label = "万圣节",  value = "Halloween" },
            },
        },
        { label = "确认", option = "button", type = "client", event = "ps-adminmenu:client:ChangeWeather" },
    },
},

["change_time"] = {
    label = "更改时间",
    perms = "mod",
    dropdown = {
        {
            label = "时间事件",
            option = "dropdown",
            data = {
                { label = "日出", value = "06" },
                { label = "上午", value = "09" },
                { label = "中午",    value = "12" },
                { label = "日落",  value = "21" },
                { label = "晚上", value = "22" },
                { label = "午夜",   value = "24" },
            },
        },
        { label = "确认", option = "button", type = "client", event = "ps-adminmenu:client:ChangeTime" },
    },
},

["change_plate"] = {
    label = "更改车牌",
    perms = "mod",
    dropdown = {
        { label = "车牌号",   option = "text" },
        { label = "确认", option = "button", type = "client", event = "ps-adminmenu:client:ChangePlate" },
    },
},

["clear_inventory"] = {
    label = "清空库存",
    perms = "mod",
    dropdown = {
        { label = "玩家",  option = "dropdown", data = "players" },
        { label = "确认", option = "button",   type = "server", event = "ps-adminmenu:server:ClearInventory" },
    },
},

["clear_inventory_offline"] = {
    label = "离线清空库存",
    perms = "mod",
    dropdown = {
        { label = "市民ID", option = "text",   data = "players" },
        { label = "确认",    option = "button", type = "server", event = "ps-adminmenu:server:ClearInventoryOffline" },
    },
},

["clothing_menu"] = {
    label = "提供服装菜单",
    perms = "mod",
    dropdown = {
        { label = "玩家",  option = "dropdown", data = "players" },
        { label = "确认", option = "button",   type = "server", event = "ps-adminmenu:server:ClothingMenu" },
    },
},

["set_ped"] = {
    label = "设置角色模型",
    perms = "mod",
    dropdown = {
        { label = "玩家",     option = "dropdown", data = "players" },
        { label = "角色模型列表", option = "dropdown", data = "pedlist" },
        { label = "确认",    option = "button",   type = "server", event = "ps-adminmenu:server:setPed" },
    },
},

["copy_coords"] = {
    label = "复制坐标",
    perms = "mod",
    dropdown = {
        {
            label = "复制坐标",
            option = "dropdown",
            data = {
                { label = "复制二维坐标", value = "vector2" },
                { label = "复制三维坐标", value = "vector3" },
                { label = "复制四维坐标",    value = "vector4" },
                { label = "复制朝向",  value = "heading" },
            },
        },
        { label = "复制到剪贴板", option = "button", type = "client", event = "ps-adminmenu:client:copyToClipboard"},
    },
},

["delete_vehicle"] = {
    label = "删除载具",
    type = "command",
    event = "dv",
    perms = "mod",
},

["freeze_player"] = {
    label = "冻结玩家",
    perms = "mod",
    dropdown = {
        { label = "玩家",  option = "dropdown", data = "players" },
        { label = "确认", option = "button",   type = "server", event = "ps-adminmenu:server:FreezePlayer" },
    },
},

["drunk_player"] = {
    label = "使玩家醉酒",
    perms = "mod",
    dropdown = {
        { label = "玩家",  option = "dropdown", data = "players" },
        { label = "确认", option = "button",   type = "server", event = "ps-adminmenu:server:DrunkPlayer" },
    },
},

["remove_stress"] = {
    label = "移除压力",
    perms = "mod",
    dropdown = {
        { label = "玩家（可选）", option = "dropdown", data = "players" },
        { label = "确认",           option = "button",   type = "server", event = "ps-adminmenu:server:RemoveStress" },
    },
},

["set_ammo"] = {
    label = "设置弹药",
    perms = "admin",
    dropdown = {
        { label = "弹药数量", option = "text" },
        { label = "确认",      option = "button", type = "client", event = "ps-adminmenu:client:SetAmmo" },
    },
},

    -- ["nui_focus"] = {
    --     label = "Give NUI Focus",
    --     perms = "mod",
    --     dropdown = {
    --         { label = "Player",  option = "dropdown", data = "players" },
    --         { label = "Confirm", option = "button",   type = "client", event = "" },
    --     },
    -- },

    -- ["god_mode"] = {
    --     label = "上帝模式",
    --     type = "client",
    --     event = "ps-adminmenu:client:ToggleGodmode",
    --     perms = "mod",
    -- },

    -- ["give_car"] = {
    --     label = "给予车辆",
    --     perms = "admin",
    --     dropdown = {
    --         { label = "车辆",           option = "dropdown", data = "vehicles" },
    --         { label = "玩家",           option = "dropdown", data = "players" },
    --         { label = "车牌 (可选)",     option = "text" },
    --         { label = "车库 (可选)",     option = "text" },
    --         { label = "确认",           option = "button",   type = "server",  event = "ps-adminmenu:server:givecar" },
    --     }
    -- },

    ["invisible"] = {
        label = "隐身",
        type = "client",
        event = "ps-adminmenu:client:ToggleInvisible",
        perms = "mod",
    },

    ["blackout"] = {
        label = "切换黑夜",
        type = "server",
        event = "ps-adminmenu:server:ToggleBlackout",
        perms = "mod",
    },

    ["toggle_duty"] = {
        label = "切换值班状态",
        type = "server",
        event = "QBCore:ToggleDuty",
        perms = "mod",
    },

    ["toggle_laser"] = {
        label = "切换激光",
        type = "client",
        event = "ps-adminmenu:client:ToggleLaser",
        perms = "mod",
    },

    -- ["set_perms"] = {
    --     label = "设置权限",
    --     perms = "admin",
    --     dropdown = {
    --         { label = "玩家",  option = "dropdown", data = "players" },
    --         {
    --             label = "权限等级",
    --             option = "dropdown",
    --             data = {
    --                 { label = "管理员", value = "mod" },
    --                 { label = "超级管理员", value = "admin" },
    --                 { label = "上帝",   value = "god" },
    --             },
    --         },
    --         { label = "确认", option = "button",   type = "server", event = "ps-adminmenu:server:SetPerms" },
    --     },
    -- },

    ["set_bucket"] = {
        label = "设置路由桶",
        perms = "mod",
        dropdown = {
            { label = "玩家",  option = "dropdown", data = "players" },
            { label = "桶号",  option = "text" },
            { label = "确认", option = "button",   type = "server", event = "ps-adminmenu:server:SetBucket" },
        },
    },

    ["get_bucket"] = {
        label = "获取路由桶",
        perms = "mod",
        dropdown = {
            { label = "玩家",  option = "dropdown", data = "players" },
            { label = "确认", option = "button",   type = "server", event = "ps-adminmenu:server:GetBucket" },
        },
    },

    ["mute_player"] = {
        label = "禁言玩家",
        perms = "mod",
        dropdown = {
            { label = "玩家",  option = "dropdown", data = "players" },
            { label = "确认", option = "button",   type = "client", event = "ps-adminmenu:client:MutePlayer" },
        },
    },

    ["noclip"] = {
        label = "穿墙模式",
        type = "client",
        event = "ps-adminmenu:client:ToggleNoClip",
        perms = "mod",
    },

    ["open_inventory"] = {
        label = "打开物品栏",
        perms = "mod",
        dropdown = {
            { label = "玩家",  option = "dropdown", data = "players" },
            { label = "确认", option = "button",   type = "client", event = "ps-adminmenu:client:openInventory" },
        },
    },

    ["open_stash"] = {
        label = "打开储物箱",
        perms = "mod",
        dropdown = {
            { label = "储物箱ID",   option = "text" },
            { label = "确认", option = "button", type = "client", event = "ps-adminmenu:client:openStash" },
        },
    },

    ["open_trunk"] = {
        label = "打开后备箱",
        perms = "mod",
        dropdown = {
            { label = "车牌号",   option = "text" },
            { label = "确认", option = "button", type = "client", event = "ps-adminmenu:client:openTrunk" },
        },
    },

    -- ["change_vehicle_state"] = {
    --     label = "设置车辆车库状态",
    --     perms = "mod",
    --     dropdown = {
    --         { label = "车牌号",   option = "text" },
    --         {
    --             label = "状态",
    --             option = "dropdown",
    --             data = {
    --                 { label = "入库",  value = "1" },
    --                 { label = "出库", value = "0" },
    --             },
    --         },
    --         { label = "确认", option = "button", type = "server", event = "ps-adminmenu:server:SetVehicleState" },
    --     },
    -- },

    ["revive_all"] = {
        label = "复活所有人",
        type = "server",
        event = "ps-adminmenu:server:ReviveAll",
        perms = "mod",
    },

    ["revive_player"] = {
        label = "复活玩家",
        perms = "mod",
        dropdown = {
            { label = "玩家",  option = "dropdown", data = "players" },
            { label = "确认", option = "button",   type = "server", event = "ps-adminmenu:server:Revive" },
        },
    },

    ["revive_radius"] = {
        label = "范围复活",
        type = "server",
        event = "ps-adminmenu:server:ReviveRadius",
        perms = "mod",
    },

    ["refuel_vehicle"] = {
        label = "为车辆加油",
        type = "client",
        event = "ps-adminmenu:client:RefuelVehicle",
        perms = "mod",
    },

    ["set_job"] = {
        label = "设置职业",
        perms = "mod",
        dropdown = {
            { label = "玩家",  option = "dropdown", data = "players" },
            { label = "职业",     option = "dropdown", data = "jobs" },
            { label = "等级",   option = "text",     data = "grades" },
            { label = "确认", option = "button",   type = "server", event = "ps-adminmenu:server:SetJob" },
        },
    },

    ["set_gang"] = {
        label = "设置帮派",
        perms = "mod",
        dropdown = {
            { label = "玩家",  option = "dropdown", data = "players" },
            { label = "帮派",    option = "dropdown", data = "gangs" },
            { label = "等级",   option = "text",     data = "grades" },
            { label = "确认", option = "button",   type = "server", event = "ps-adminmenu:server:SetGang" },
        },
    },

    -- ["give_money"] = {
    --     label = "给予金钱",
    --     perms = "admin",
    --     dropdown = {
    --         { label = "玩家", option = "dropdown", data = "players" },
    --         { label = "金额", option = "text" },
    --         {
    --             label = "类型",
    --             option = "dropdown",
    --             data = {
    --                 { label = "现金",   value = "cash" },
    --                 { label = "银行",   value = "bank" },
    --                 { label = "加密货币", value = "crypto" },
    --             },
    --         },
    --         { label = "确认", option = "button", type = "server", event = "ps-adminmenu:server:GiveMoney" },
    --     },
    -- },

    -- ["give_money_all"] = {
    --     label = "给予所有玩家金钱",
    --     perms = "admin",
    --     dropdown = {
    --         { label = "金额",  option = "text" },
    --         {
    --             label = "类型",
    --             option = "dropdown",
    --             data = {
    --                 { label = "现金",   value = "cash" },
    --                 { label = "银行",   value = "bank" },
    --                 { label = "加密货币", value = "crypto" },
    --             },
    --         },
    --         { label = "确认", option = "button", type = "server", event = "ps-adminmenu:server:GiveMoneyAll" },
    --     },
    -- },

    -- ["remove_money"] = {
    --     label = "移除金钱",
    --     perms = "admin",
    --     dropdown = {
    --         { label = "玩家", option = "dropdown", data = "players" },
    --         { label = "金额", option = "text" },
    --         {
    --             label = "类型",
    --             option = "dropdown",
    --             data = {
    --                 { label = "现金", value = "cash" },
    --                 { label = "银行", value = "bank" },
    --             },
    --         },
    --         { label = "确认", option = "button", type = "server", event = "ps-adminmenu:server:TakeMoney" },
    --     },
    -- },

    -- ["give_item"] = {
    --     label = "给予物品",
    --     perms = "mod",
    --     dropdown = {
    --         { label = "玩家",  option = "dropdown", data = "players" },
    --         { label = "物品",    option = "dropdown", data = "items" },
    --         { label = "数量",  option = "text" },
    --         { label = "确认", option = "button",   type = "server", event = "ps-adminmenu:server:GiveItem" },
    --     },
    -- },

    -- ["give_item_all"] = {
    --     label = "给予所有玩家物品",
    --     perms = "mod",
    --     dropdown = {
    --         { label = "物品",    option = "dropdown", data = "items" },
    --         { label = "数量",  option = "text" },
    --         { label = "确认", option = "button",   type = "server", event = "ps-adminmenu:server:GiveItemAll" },
    --     },
    -- },

    -- ["spawn_vehicle"] = {
    --     label = "生成载具",
    --     perms = "mod",
    --     dropdown = {
    --         { label = "载具", option = "dropdown", data = "vehicles" },
    --         { label = "确认", option = "button",   type = "client",  event = "ps-adminmenu:client:SpawnVehicle" },
    --     },
    -- },

    ["fix_vehicle"] = {
        label = "修复载具",
        type = "command",
        event = "fix",
        perms = "mod",
    },

    ["fix_vehicle_for"] = {
        label = "为玩家修复载具",
        perms = "mod",
        dropdown = {
            { label = "玩家",  option = "dropdown", data = "players" },
            { label = "确认", option = "button",   type = "server", event = "ps-adminmenu:server:FixVehFor" },
        },
    },

    ["spectate_player"] = {
        label = "观察玩家",
        perms = "mod",
        dropdown = {
            { label = "玩家",  option = "dropdown", data = "players" },
            { label = "确认", option = "button",   type = "server", event = "ps-adminmenu:server:SpectateTarget" },
        },
    },

    ["telport_to_player"] = {
        label = "传送到玩家",
        perms = "mod",
        dropdown = {
            { label = "选择玩家",  option = "dropdown", data = "players" },
            { label = "确认", option = "button",   type = "server", event = "ps-adminmenu:server:TeleportToPlayer" },
        },
    },

    ["telport_to_coords"] = {
        label = "传送到坐标",
        perms = "mod",
        dropdown = {
            { label = "输入坐标",  option = "text" },
            { label = "确认", option = "button", type = "client", event = "ps-adminmenu:client:TeleportToCoords" },
        },
    },

    ["teleport_to_location"] = {
        label = "传送到地点",
        perms = "mod",
        dropdown = {
            { label = "选择地点", option = "dropdown", data = "locations" },
            { label = "确认",  option = "button",   type = "client",   event = "ps-adminmenu:client:TeleportToLocation" },
        },
    },

    ["teleport_to_marker"] = {
        label = "传送到标记",
        type = "command",
        event = "tpm",
        perms = "mod",
    },

    ["teleport_back"] = {
        label = "传送回原地",
        type = "client",
        event = "ps-adminmenu:client:TeleportBack",
        perms = "mod",
    },

    ["vehicle_dev"] = {
        label = "载具开发菜单",
        type = "client",
        event = "ps-adminmenu:client:ToggleVehDevMenu",
        perms = "mod",
    },

    ["toggle_coords"] = {
        label = "切换坐标显示",
        type = "client",
        event = "ps-adminmenu:client:ToggleCoords",
        perms = "mod",
    },

    ["toggle_blips"] = {
        label = "切换小地图标记",
        type = "client",
        event = "ps-adminmenu:client:toggleBlips",
        perms = "mod",
    },

    ["toggle_names"] = {
        label = "切换玩家名字显示",
        type = "client",
        event = "ps-adminmenu:client:toggleNames",
        perms = "mod",
    },

    ["toggle_cuffs"] = {
        label = "切换手铐状态",
        perms = "mod",
        dropdown = {
            { label = "选择玩家",  option = "dropdown", data = "players" },
            { label = "确认", option = "button",   type = "server", event = "ps-adminmenu:server:CuffPlayer" },
        },
    },

    -- ["max_mods"] = {
    --     label = "最大载具改装",
    --     type = "client",
    --     event = "ps-adminmenu:client:maxmodVehicle",
    --     perms = "mod",
    -- },

    ["warn_player"] = {
        label = "警告玩家",
        perms = "mod",
        dropdown = {
            { label = "选择玩家",  option = "dropdown", data = "players" },
            { label = "原因",  option = "text" },
            { label = "确认", option = "button",   type = "server", event = "ps-adminmenu:server:WarnPlayer" },
        },
    },

    -- ["infinite_ammo"] = {
    --     label = "无限弹药",
    --     type = "client",
    --     event = "ps-adminmenu:client:setInfiniteAmmo",
    --     perms = "mod",
    -- },

    ["kick_player"] = {
        label = "踢出玩家",
        perms = "mod",
        dropdown = {
            { label = "选择玩家",  option = "dropdown", data = "players" },
            { label = "原因",  option = "text" },
            { label = "确认", option = "button",   type = "server", event = "ps-adminmenu:server:KickPlayer" },
        },
    },


    ["play_sound"] = {
        label = "播放声音",
        perms = "mod",
        dropdown = {
            { label = "选择玩家",     option = "dropdown", data = "players" },
            {
                label = "选择声音",
                option = "dropdown",
                data = {
                    { label = "警报声",      value = "alert" },
                    { label = "上铐声",       value = "cuff" },
                    { label = "气动扳手声", value = "airwrench" },
                },
            },
            { label = "播放声音", option = "button",   type = "client", event = "ps-adminmenu:client:PlaySound" },
        },
    },
}

Config.PlayerActions = {
    ["teleportToPlayer"] = {
        label = "传送到玩家",
        type = "server",
        event = "ps-adminmenu:server:TeleportToPlayer",
        perms = "mod",
    },
    ["bringPlayer"] = {
        label = "召唤玩家",
        type = "server",
        event = "ps-adminmenu:server:BringPlayer",
        perms = "mod",
    },
    ["revivePlayer"] = {
        label = "复活玩家",
        event = "ps-adminmenu:server:Revive",
        perms = "mod",
        type = "server"
    },
    ["spawnPersonalVehicle"] = {
        label = "生成个人载具",
        event = "ps-adminmenu:client:SpawnPersonalVehicle",
        perms = "mod",
        type = "client"
    },
    ["banPlayer"] = {
        label = "封禁玩家",
        event = "ps-adminmenu:server:BanPlayer",
        perms = "mod",
        type = "server"
    },
    ["kickPlayer"] = {
        label = "踢出玩家",
        event = "ps-adminmenu:server:KickPlayer",
        perms = "mod",
        type = "server"
    }
}

Config.OtherActions = {
    ["toggleDevmode"] = {
        type = "client",
        event = "ps-adminmenu:client:ToggleDev",
        perms = "admin",
        label = "切换为开发者模式"
    }
}

AddEventHandler("onResourceStart", function()
    Wait(100)
    if GetResourceState('ox_inventory') == 'started' then
        Config.Inventory = 'ox_inventory'
    elseif GetResourceState('ps-inventory') == 'started' then
        Config.Inventory = 'ps-inventory'
    elseif GetResourceState('lj-inventory') == 'started' then
        Config.Inventory = 'lj-inventory'
    elseif GetResourceState('qb-inventory') == 'started' then
        Config.Inventory = 'qb-inventory'
    end
end)
