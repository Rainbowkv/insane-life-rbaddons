Config = {}
Config.Graffitis = {}
QBCore = exports['qb-core']:GetCoreObject()

Config.BlacklistedZones = {
    {coords = vector3(455.81, -997.04, 43.69), radius = 200.0}, -- Police
    {coords = vector3(324.76, -585.72, 59.15), radius = 300.0}, -- Hospital
    {coords = vector3(-376.73, -119.47, 40.73), radius = 400.0}, -- Mechanic
}

-- .0不能去，否则导致圆绘制异常
Config.GraffitiRenderDistance = 200.0         -- 玩家靠近多近才加载实体
Config.GraffitiBlipRadius = 300.0             -- 地图上圆圈的半径
Config.Inteval = 700.0                        -- 两个涂鸦的最小间隔，需要大于上面那个的两倍
Config.RemoveDis = 3.0                        -- 擦除涂鸦的最大距离
Config.AllowPaintGrade = 2                     -- 允许的最小帮派成员等级
Config.AllowRemoveGrade = 1                     -- 允许的最小帮派成员等级
Config.PedLocation = vector3(249.21, -2012.84, 17.86)
Config.PedBlip = false

Config.Sprays = {
    [GetHashKey('sprays_lost')] = {
        -- name = 'Spray Lost',
        name = '摩托帮领地',
        price = 30000,
        blip = true,
        blipcolor = 76,
        gang = 'lostmc'
    },
    
    [GetHashKey('sprays_ballas')] = {
        -- name = 'Spray Ballas',
        name = '巴勒斯领地',
        price = 30000,
        blip = true,
        blipcolor = 27,
        gang = 'ballas'
    },

    [GetHashKey('sprays_vagos')] = {
        -- name = 'Spray Vagos',
        name = '维格斯领地',
        price = 30000,
        blip = true,
        blipcolor = 46,
        gang = 'vagos'
    },

    -- [GetHashKey('sprays_angels')] = {
    --     name = 'Spray Angels',
    --     price = 5000,
    --     blip = false,
    --     blipcolor = 1,
    --     gang = nil
    -- },

    -- [GetHashKey('sprays_bbmc')] = {
    --     name = 'Spray BBMC',
    --     price = 5000,
    --     blip = false,
    --     blipcolor = 1,
    --     gang = nil
    -- },

    -- [GetHashKey('sprays_bcf')] = {
    --     name = 'Spray BCF',
    --     price = 5000,
    --     blip = false,
    --     blipcolor = 1,
    --     gang = nil
    -- },

    -- [GetHashKey('sprays_bsk')] = {
    --     name = 'Spray BSK',
    --     price = 5000,
    --     blip = false,
    --     blipcolor = 1,
    --     gang = nil
    -- },

    -- [GetHashKey('sprays_cerberus')] = {
    --     name = 'Spray Cerberus',
    --     price = 5000,
    --     blip = false,
    --     blipcolor = 1,
    --     gang = nil
    -- },

    -- [GetHashKey('sprays_cg')] = {
    --     name = 'Spray CG',
    --     price = 5000,
    --     blip = false,
    --     blipcolor = 1,
    --     gang = nil
    -- },

    -- [GetHashKey('sprays_gg')] = {
    --     name = 'Spray GG',
    --     price = 5000,
    --     blip = false,
    --     blipcolor = 1,
    --     gang = nil
    -- },

    -- [GetHashKey('sprays_gsf')] = {
    --     name = 'Spray GSF',
    --     price = 5000,
    --     blip = false,
    --     blipcolor = 1,
    --     gang = nil
    -- },

    -- [GetHashKey('sprays_guild')] = {
    --     name = 'Spray Guild',
    --     price = 5000,
    --     blip = false,
    --     blipcolor = 1,
    --     gang = nil
    -- },

    -- [GetHashKey('sprays_hoa')] = {
    --     name = 'Spray Hoa',
    --     price = 5000,
    --     blip = false,
    --     blipcolor = 1,
    --     gang = nil
    -- },

    -- [GetHashKey('sprays_hydra')] = {
    --     name = 'Spray Hydra',
    --     price = 5000,
    --     blip = false,
    --     blipcolor = 1,
    --     gang = nil
    -- },

    -- [GetHashKey('sprays_kingz')] = {
    --     name = 'Spray Kingz',
    --     price = 5000,
    --     blip = false,
    --     blipcolor = 1,
    --     gang = nil
    -- },



    -- [GetHashKey('sprays_mandem')] = {
    --     name = 'Spray Mandem',
    --     price = 5000,
    --     blip = false,
    --     blipcolor = 1,
    --     gang = nil
    -- },

    -- [GetHashKey('sprays_mayhem')] = {
    --     name = 'Spray Mayhem',
    --     price = 5000,
    --     blip = false,
    --     blipcolor = 1,
    --     gang = nil
    -- },

    -- [GetHashKey('sprays_nbc')] = {
    --     name = 'Spray NBC',
    --     price = 5000,
    --     blip = false,
    --     blipcolor = 1,
    --     gang = nil
    -- },

    -- [GetHashKey('sprays_ramee')] = {
    --     name = 'Spray Ramee',
    --     price = 5000,
    --     blip = false,
    --     blipcolor = 1,
    --     gang = nil
    -- },

    -- [GetHashKey('sprays_ron')] = {
    --     name = 'Spray Ron',
    --     price = 5000,
    --     blip = false,
    --     blipcolor = 1,
    --     gang = nil
    -- },

    -- [GetHashKey('sprays_rust')] = {
    --     name = 'Spray Rust',
    --     price = 5000,
    --     blip = false,
    --     blipcolor = 1,
    --     gang = nil
    -- },

    -- [GetHashKey('sprays_scu')] = {
    --     name = 'Spray SCU',
    --     price = 5000,
    --     blip = false,
    --     blipcolor = 1,
    --     gang = nil
    -- },

    -- [GetHashKey('sprays_seaside')] = {
    --     name = 'Spray Seaside',
    --     price = 5000,
    --     blip = false,
    --     blipcolor = 1,
    --     gang = nil
    -- },

    -- [GetHashKey('sprays_st')] = {
    --     name = 'Spray ST',
    --     price = 5000,
    --     blip = false,
    --     blipcolor = 1,
    --     gang = nil
    -- },
}