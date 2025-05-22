Config = {
    Locations = { -- Locations for shops
        {
            label = '冷冻柜',
            name = 'butcher_shop',
            Items = {
                { label = '生汉堡肉饼', name = 'rawburgerpatty', price = 20 },
                { label = '生素食汉堡肉饼', name = 'veganburgerpatty', price = 10},
                { label = '生鸡块', name = 'nuggets', price = 10},
            },
            target = {
                coords = vector3(-1203.54, -896.05, 13.89),
                width = 1.0,
                lenght = 1.0,
                heading = 305,
                minZ = 10.56,
                maxZ = 13.56,
                icon = 'fa-solid fa-box',
                label = '冷冻柜',
                job = 'burgershot',
                action = function()
                    if Config.Inventory == 'ox' then
                        exports.ox_inventory:openInventory('shop', { type = 'butcher_shop'})
                    elseif Config.Inventory == 'qb' then
                        TriggerServerEvent('tj_burgershot:openShop', 'butcher_shop')
                    elseif Config.Inventory == 'qs' then
                        TriggerServerEvent('tj_burgershot:openShop', 'butcher_shop')
                    end
                end
            },
        },
        {
            label = '保鲜柜',
            name = 'veg_shop',
            Items = {
                { label = '土豆', name = 'potato', price = 2 },
                { label = '洋葱', name = 'onion', price = 1 },
                { label = '番茄', name = 'tomato', price = 3 },
                { label = '汉堡面包', name = 'burgerbun', price = 8 },
                { label = '切达奶酪', name = 'cheddar', price = 10 },
                { label = '生菜', name = 'lettuce', price = 4 },
            },
            target = {
                coords = vector3(-1202.41, -897.64, 13.89),
                width = 1.0,
                lenght = 1.0,
                heading = 305,
                minZ = 11.97,
                maxZ = 14.97,
                icon = 'fa-solid fa-box',
                label = '保鲜柜',
                job = 'burgershot',
                action = function()
                    if Config.Inventory == 'ox' then
                        exports.ox_inventory:openInventory('shop', { type = 'veg_shop'})
                    elseif Config.Inventory == 'qb' then
                        TriggerServerEvent('tj_burgershot:openShop', 'veg_shop')
                    elseif Config.Inventory == 'qs' then
                        TriggerServerEvent('tj_burgershot:openShop', 'butcher_shop')
                    end
                end
            },
        }
    },

    Resotrani = {
        {
            job = 'burgershot', -- job required to access burgershot
            stashovi = { -- stashes
                {
                    target = {
                        coords = vector3(-1203.54, -897.05, 13.89),
                        width = 1.2,
                        lenght = 3.4,
                        heading = 305,
                        minZ = 11.85,
                        maxZ = 14.05,
                        icon = 'fa-solid fa-box',
                        label = '食材柜',
                        action = function()
                            if Config.Inventory == 'ox' then
                                exports.ox_inventory:openInventory('stash', { id = 'Ingredients'})
                            elseif Config.Inventory == 'qb' then
                                TriggerServerEvent('tj_burgershot:openStash', 'Ingredients')
                            elseif Config.Inventory == 'qs' then
                                TriggerServerEvent('tj_burgershot:openStash', 'Ingredients')
                            end
                        end
                    },
                    label = '食材柜',
                    name = 'Ingredients',
                    weight = 500000,
                    slots = 50,
                },
                {
                    target = {
                        coords = vector3(-1195.24, -896.51, 13.89),
                        width = 1.0,
                        lenght = 1.4,
                        heading = 35,
                        minZ = 10.97,
                        maxZ = 13.97,
                        icon = 'fa-solid fa-box',
                        label = '熟食',
                        action = function()
                            if Config.Inventory == 'ox' then
                                exports.ox_inventory:openInventory('stash', { id = 'CookedFood'})
                            elseif Config.Inventory == 'qb' then
                                local namee = "burgershootCooked"
                                TriggerServerEvent('tj_burgershot:openStash', 'CookedFood')
                            elseif Config.Inventory == 'qs' then
                                TriggerServerEvent('tj_burgershot:openStash', 'CookedFood')
                            end
                        end
                    },
                    label = '熟食',
                    name = 'CookedFood',
                    weight = 50000,
                    slots = 50,
                },
                {
                    target = {
                        coords = vector3(-1196.82, -892.63, 13.89),
                        width = 1.2,
                        lenght = 3.4,
                        heading = 305,
                        minZ = 11.85,
                        maxZ = 14.05,
                        icon = 'fa-solid fa-box',
                        label = '制作好的食物',
                        action = function()
                            if Config.Inventory == 'ox' then
                                exports.ox_inventory:openInventory('stash', { id = 'ReadyFood'})
                            elseif Config.Inventory == 'qb' then
                                TriggerServerEvent('tj_burgershot:openStash', 'ReadyFood')
                            elseif Config.Inventory == 'qs' then
                                TriggerServerEvent('tj_burgershot:openStash', 'ReadyFood')
                            end
                        end
                    },
                    label = '制作好的食物',
                    name = 'ReadyFood',
                    weight = 50000,
                    slots = 50,
                },
            },
            menu = { -- menu options
                {
                    id = 'drinks',
                    label = '可制作饮品',
                    menuName = 'drinksMenu',
                    target = {
                        coords = vector3(-1191.16, -898.46, 13.89),
                        width = 1.0,
                        lenght = 2.2,
                        heading = 305,
                        minZ = 11.97,
                        maxZ = 14.97,
                        icon = 'fa-solid fa-box',
                        label = '制作饮品',
                        action = function()
                            NapraviMenije()
                            lib.showContext('drinksMenu')
                        end
                    },
                    Items = { -- items in menu
                        {
                            label = '可乐',
                            item = 'bscoke',
                            price = 50,
                            image = 'https://items.bit-scripts.com/images/drinks/burger-softdrink2.png',
                            description = '汉堡王的可乐，美味！',
                        },
                        {
                            label = '咖啡',
                            item = 'bscoffee',
                            price = 60,
                            image = 'https://items.bit-scripts.com/images/food/burger-coffee.png',
                            description = '汉堡王做的咖啡，还不错.',
                        },
                        {
                            label = '奶昔',
                            item = 'milkshake',
                            price = 55,
                            image = 'https://items.bit-scripts.com/images/food/burger-milkshake.png',
                            description = '汉堡王做的奶昔，冰冰腻腻~',
                        }
                    }
                },
                {
                    id = 'food',
                    label = '制作食物',
                    menuName = 'making_food',
                    target = {
                        coords = vector3(-1200.79, -895.0, 13.89),
                        width = 1.0,
                        lenght = 3.2,
                        heading = 35,
                        minZ = 10.97,
                        maxZ = 13.97,
                        icon = 'fa-solid fa-box',
                        label = '制作食物',
                        action = function()
                            NapraviMenije()
                            lib.showContext('making_food')
                        end
                    },
                    Items = {
                        {
                            label = '渗血汉堡',
                            item = 'bleeder',
                            price = 120,
                            image = 'https://items.bit-scripts.com/images/food/burger-bleeder.png',
                            description = '番茄酱罢了, 别吓唬到了',
                            recipe = { -- recipe for making items
                                {
                                    label = '汉堡面包',
                                    name = 'burgerbun',
                                    amount = 1,
                                },
                                {
                                    label = '熟汉堡肉饼',
                                    name = 'cookedburgerpatty',
                                    amount = 1,
                                },
                                {
                                    label = '切片生菜',
                                    name = 'cutlettuce',
                                    amount = 2,
                                },
                                {
                                    label = '切达奶酪',
                                    name = 'cheddar',
                                    amount = 2,
                                },
                                {
                                    label = '切片番茄',
                                    name = 'cuttomato',
                                    amount = 2,
                                }
                            }
                        },
                        {
                            label = '心脏杀手汉堡',
                            item = 'heartstopper',
                            price = 199,
                            image = 'https://items.bit-scripts.com/images/food/burger-heartstopper.png',
                            description = '爽到心跳加速的美味汉堡',
                            recipe = {
                                {
                                    label = '汉堡面包',
                                    name = 'burgerbun',
                                    amount = 1,
                                },
                                {
                                    label = '熟汉堡肉饼',
                                    name = 'cookedburgerpatty',
                                    amount = 4,
                                },
                                {
                                    label = '切片生菜',
                                    name = 'cutlettuce',
                                    amount = 3,
                                },
                                {
                                    label = '切达奶酪',
                                    name = 'cheddar',
                                    amount = 5,
                                },
                                {
                                    label = '切片番茄',
                                    name = 'cuttomato',
                                    amount = 3,
                                },
                            }
                        },
                        {
                            label = '素食汉堡',
                            item = 'meatfree',
                            price = 110,
                            image = 'https://items.bit-scripts.com/images/food/dbl_hornburger.png',
                            description = '素食主义者喜欢的汉堡',
                            recipe = {
                                {
                                    label = '汉堡面包',
                                    name = 'burgerbun',
                                    amount = 1,
                                },
                                {
                                    label = '熟素食汉堡肉饼',
                                    name = 'cookedveganburgerpatty',
                                    amount = 2,
                                },
                                {
                                    label = '切片生菜',
                                    name = 'cutlettuce',
                                    amount = 2,
                                },
                                {
                                    label = '切片番茄',
                                    name = 'cuttomato',
                                    amount = 1,
                                },
                            }
                        },
                        {
                            label = '鱼雷三明治',
                            item = 'torpedo',
                            price = 125,
                            image = 'https://items.bit-scripts.com/images/food/burger-torpedo.png',
                            description = '胃爽到炸飞',
                            recipe = {
                                {
                                    label = '汉堡面包',
                                    name = 'burgerbun',
                                    amount = 1,
                                },
                                {
                                    label = '熟汉堡肉饼',
                                    name = 'cookedburgerpatty',
                                    amount = 1,
                                },
                                {
                                    label = '切片番茄',
                                    name = 'cuttomato',
                                    amount = 2,
                                },
                                {
                                    label = '切片洋葱',
                                    name = 'cutonion',
                                    amount = 2,
                                },
                            }
                        },
                        {
                            label = '金钱射击汉堡',
                            item = 'moneyshot',
                            price = 160,
                            image = 'https://items.bit-scripts.com/images/food/burger-moneyshot.png',
                            description = '来财',
                            recipe = {
                                {
                                    label = '汉堡面包',
                                    name = 'burgerbun',
                                    amount = 1,
                                },
                                {
                                    label = '熟汉堡肉饼',
                                    name = 'cookedburgerpatty',
                                    amount = 2,
                                },
                                {
                                    label = '切片番茄',
                                    name = 'cuttomato',
                                    amount = 2,
                                },
                                {
                                    label = '切片洋葱',
                                    name = 'cutonion',
                                    amount = 2,
                                },
                                {
                                    label = '切片生菜',
                                    name = 'cutlettuce',
                                    amount = 2,
                                },
                                {
                                    label = '切达奶酪',
                                    name = 'cheddar',
                                    amount = 2,
                                },
                            },
                        },
                    },
                },
                {
                    id = 'cutting',
                    label = '切板',
                    menuName = 'cuttingBoard',
                    target = {
                        coords = vector3(-1195.34, -897.48, 13.97),
                        width = 1.0,
                        lenght = 3.2,
                        heading = 35,
                        minZ = 10.97,
                        maxZ = 13.97,
                        icon = 'fa-solid fa-box',
                        label = '切板',
                        action = function()
                            NapraviMenije()
                            lib.showContext('cuttingBoard')
                        end
                    },
                    Items = {
                        {
                            label = '切片土豆',
                            item = 'cutpotato',
                            recipe = {
                                {
                                    label = '土豆',
                                    name = 'potato',
                                    amount = 1,
                                }
                            }
                        },
                        {
                            label = '切片洋葱',
                            item = 'cutonion',
                            recipe = {
                                {
                                    label = '洋葱',
                                    name = 'onion',
                                    amount = 1,
                                }
                            }
                        },
                        {
                            label = '切片番茄',
                            item = 'cuttomato',
                            recipe = {
                                {
                                    label = '番茄',
                                    name = 'tomato',
                                    amount = 1,
                                }
                            }
                        },
                        {
                            label = '切片生菜',
                            item = 'cutlettuce',
                            recipe = {
                                {
                                    label = '生菜',
                                    name = 'lettuce',
                                    amount = 1,
                                }
                            }
                        },
                    },
                },
                {
                    id = 'cooking',
                    label = '烤制',
                    menuName = 'bbq',
                    target = {
                        coords = vector3(-1198.42, -899.2, 13.89),
                        width = 1.2,
                        lenght = 2.0,
                        heading = 35,
                        minZ = 10.97,
                        maxZ = 13.97,
                        icon = 'fa-solid fa-box',
                        label = '烤制',
                        action = function()
                            NapraviMenije()
                            lib.showContext('bbq')
                        end
                    },
                    Items = {
                        {
                            label = '熟汉堡肉饼',
                            item = 'cookedburgerpatty',
                            recipe = {
                                {
                                    label = '生汉堡肉饼',
                                    name = 'rawburgerpatty',
                                    amount = 1,
                                },
                            }
                        },
                        {
                            label = '熟素食汉堡肉饼',
                            item = 'cookedveganburgerpatty',
                            recipe = {
                                {
                                    label = '生素食汉堡肉饼',
                                    name = 'veganburgerpatty',
                                    amount = 1,
                                },
                            }
                        },
                    },
                },
                {
                    id = 'deepfryer',
                    label = '油炸锅',
                    menuName = 'deepFryer',
                    target = {
                        coords = vector3(-1196.06, -900, 13.89),
                        width = 1.0,
                        lenght = 2.0,
                        heading = 35,
                        minZ = 10.97,
                        maxZ = 13.97,
                        icon = 'fa-solid fa-box',
                        label = '油炸锅',
                        action = function()
                            NapraviMenije()
                            lib.showContext('deepFryer')
                        end
                    },
                    Items = {
                        {
                            label = '薯条',
                            item = 'fries',
                            price = 99,
                            image = 'https://items.bit-scripts.com/images/food/burger-fries.png',
                            description = '有机土豆做成的薯条',
                            recipe = {
                                {
                                    label = '切片土豆',
                                    name = 'cutpotato',
                                    amount = 1,
                                },
                            }
                        },
                        {
                            label = '鸡块',
                            item = 'cookednuggets',
                            price = 99,
                            image = 'https://items.bit-scripts.com/images/food/burger-shotnuggets.png',
                            description = '美味的鸡块',
                            recipe = {
                                {
                                    label = '生鸡块',
                                    name = 'nuggets',
                                    amount = 1,
                                },
                            }
                        },
                    },
                },
            }
        }
    }
}

Config.Framework = 'qb' -- 'esx' or 'qb'

Config.Inventory = 'ox' -- 'ox', 'qb' or 'qs' (qs is not teste so if you find and issue, contact us on discord: https://discord.gg/tbSF4N7eCb)

Config.Target = 'ox' -- 'qb' or 'ox'

Config.OrdersLoc = { -- locations for target for orders menu
    {
        coords = vector3(-1193.47, -893.73, 13.89),
        size = vec3(1.0, 1.0, 1.0),
        rotation = 345,
        job = "burgershot"
    },
}

Config.Ordering = { -- target location for ordering menu
    {
        coords = vector3(-1192.68, -893.8, 13.89),
        size = vec3(0.5, 0.5, 0.5),
        rotation = 300.0,
    },
}

Config.Locations2 = { -- duty locations
    Duty = {
        coords = vec3(-1198.45, -904.86, 13.89),
        size = {1.0, 1.0},
        heading = 305.0,
        minZ = 10.77834,
        maxZ = 13.87834,
        job = "burgershot"
    },
    WashingHands = { -- washing hands locations
        coords = vec3(-1201.12, -891.0, 13.89),
        size = {1.0, 1.2},
        heading = 35.0,
        minZ = 10.77834,
        maxZ = 13.37834,
        -- job = "burgershot"
    }
}

-- rb_code
Config.idToLabel = {
    rawburgerpatty = '生汉堡肉饼',
    cookedburgerpatty = '熟汉堡肉饼',
    veganburgerpatty = '素食汉堡肉饼',
    cookedveganburgerpatty = '熟素食汉堡肉饼',
    potato = '土豆',
    cutpotato = '切片土豆',
    onion = '洋葱',
    cutonion = '切片洋葱',
    tomato = '番茄',
    cuttomato = '切片番茄',
    burgerbun = '汉堡面包',
    cheddar = '切达奶酪',
    lettuce = '生菜',
    cutlettuce = '切片生菜',
    nuggets = '生鸡块',
    receipt = '收据',
    bleeder = '渗血汉堡',
    meatfree = '素食汉堡',
    torpedo = '鱼雷三明治',
    cookednuggets = '鸡块',
    heartstopper = '心脏杀手汉堡',
    moneyshot = '金钱射击汉堡',
    fries = '薯条',
    bscoke = '汉堡店可乐',
    bscoffee = '汉堡店咖啡',
    milkshake = '奶昔'
}

Config.defaultOutfits = {
    model = nil,  -- 动态获取
    components = {
        { component_id = 0, texture = 0, drawable = 0 },
        { component_id = 1, texture = 0, drawable = 144 },
        { component_id = 2, texture = 0, drawable = 69 },
        { component_id = 3, texture = 0, drawable = 74 },
        { component_id = 4, texture = 20, drawable = 89 },
        { component_id = 5, texture = 0, drawable = 0 },
        { component_id = 6, texture = 0, drawable = 0 },
        { component_id = 7, texture = 0, drawable = 32 },
        { component_id = 8, texture = 0, drawable = 1 },
        { component_id = 9, texture = 0, drawable = 0 },
        { component_id = 10, texture = 0, drawable = 0 },
        { component_id = 11, texture = 2, drawable = 16 }
    },
    props = {
        { prop_id = 0, texture = -1, drawable = -1 },
        { prop_id = 1, texture = -1, drawable = -1 },
        { prop_id = 2, texture = -1, drawable = -1 },
        { prop_id = 6, texture = -1, drawable = -1 },
        { prop_id = 7, texture = -1, drawable = -1 }
    }
}
--

-- Logs

Config.DiscordWebhook = 'https://discord.com/api/webhooks/1338146656771772426/jR4U88Iyvxy98AjXbt3VXRDt9b9M8DxoVjMgZ0AsvKcDkTKyUqmVSbpUjiWSMvrTV8DU' -- Paste your discord webhook here

Config.DiscordLogo = 'https://i.postimg.cc/y8hWKkBS/logoTJ.webp' -- Paste url for your logo

Config.LogColor = 2123412 -- Here you can change color of logs (https://gist.github.com/thomasbnt/b6f455e2c7d743b796917fa3c205f812)

