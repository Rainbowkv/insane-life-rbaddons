return {
    debug = false,             -- Set to true to enable debug messages
    prop = 'hp3d_skateboard1', -- prop model
    item = 'hp3d_skateboard1',       -- item name
    prop2 = 'v_res_skateboard', -- prop model
    item2 = 'v_res_skateboard',       -- item name
    baseVehicle = 'tribike3',  -- base vehicle (Attached)
    targetDistance = 2.5,      -- target distance
    ragdollSpeed = 90,         -- ragdoll speed
    fallSpeed = -15, -- 速度单位 m/s，约等于从 1.5 层楼自由落体
    jumpBoost = 6.0,           -- jump boost
    maxAwayDistance = 20.0,
    lang = {                   -- language
        enterSkateBoard = 'Drive',
        backoffSkateBoard = 'Back off',
        getOnSkateBoard = '上板',
        pickupSkateBoard = '收回',
        usageSkateBoard = "教程",
        showoff = "炫耀",
        holdBoard = "穿戴",
    },
    icons = { -- icons
        getOnSkateBoard = 'person-snowboarding',
        pickupSkateBoard = 'hand-back-fist',
        usageSkateBoard = 'info-circle'
    },
    coordZ = {
        ['hp3d_skateboard1'] = -0.5,
        ['v_res_skateboard'] = -0.6
    },
    holdBoard = {
        ['v_res_skateboard'] = {
            pos = vec3(0.27, -0.27, -0.1),      -- X, Y, Z 偏移
            rot = vec3(-100.0, 145.0, 0.0)      -- Pitch, Roll, Yaw
        },
        ['hp3d_skateboard1'] = {
            pos = vec3(0.27, -0.15, -0.1),      -- X, Y, Z 偏移
            rot = vec3(-100.0, 145.0, 0.0)      -- Pitch, Roll, Yaw
        }
    },
}
