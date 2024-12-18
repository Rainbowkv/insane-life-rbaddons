Config = {}

Config.Locations = {
    -- 24/7 Locations
    ['insurer'] = {
        ['label'] = '保险公司',
        ['coords'] = vector4(388.06, -78.38, 68.18, 155.54),  -- npc位置
        ['ped'] = 'IG_BESTMEN',  -- 人物模型
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',  -- 人物动作
        ['radius'] = 2.5,
        ['targetIcon'] = 'fas fa-shopping-basket',  -- 地图显示的图标
        ['targetLabel'] = '保险赔付',  -- 提示
        -- ['products'] = Config.Products['normal'],  -- 包含货物
        ['showblip'] = true,
        ['blipsprite'] = 434,  -- blip的图标
        ['blipscale'] = 0.7,
        ['blipcolor'] = 0,
        ['veh_spawn_point'] = vector4(26.45, -1315.51, 29.62, 0.07),  -- 生成车辆的位置
        ['useStock'] = true
    },
}

Config.VehicleClass = {
    all = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22 },
    car = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 12, 13, 18, 22 },
    air = { 15, 16 },
    sea = { 14 },
    rig = { 10, 11, 17, 19, 20 }
}


Config.Garages = {
    motelgarage = {
        label = '汽车旅馆停车场',
        takeVehicle = vector3(274.29, -334.15, 44.92),
        spawnPoint = {
            vector4(265.96, -332.3, 44.51, 250.68)
        },
        showBlip = true,
        blipName = '汽车旅馆停车场',
        blipNumber = 357,
        blipColor = 3,
        type = 'public', -- public, gang, job, depot
        category = Config.VehicleClass['car']
    },
    casinogarage = {
        label = '赌场停车场',
        takeVehicle = vector3(883.96, -4.71, 78.76),
        spawnPoint = {
            vector4(895.39, -4.75, 78.35, 146.85)
        },
        showBlip = true,
        blipName = '赌场停车场',
        blipNumber = 357,
        blipColor = 3,
        type = 'public',
        category = Config.VehicleClass['car']
    },
    -- sapcounsel = {
    --     label = 'San Andreas Parking',
    --     takeVehicle = vector3(-330.01, -780.33, 33.96),
    --     spawnPoint = {
    --         vector4(-341.57, -767.45, 33.56, 92.61)
    --     },
    --     showBlip = true,
    --     blipName = '公共停车场',
    --     blipNumber = 357,
    --     blipColor = 3,
    --     type = 'public',
    --     category = Config.VehicleClass['car']
    -- },
    -- spanishave = {
    --     label = 'Spanish Ave Parking',
    --     takeVehicle = vector3(-1160.86, -741.41, 19.63),
    --     spawnPoint = {
    --         vector4(-1145.2, -745.42, 19.26, 108.22)
    --     },
    --     showBlip = true,
    --     blipName = '公共停车场',
    --     blipNumber = 357,
    --     blipColor = 3,
    --     type = 'public',
    --     category = Config.VehicleClass['car']
    -- },
    -- caears24 = {
    --     label = 'Caears 24 Parking',
    --     takeVehicle = vector3(69.84, 12.6, 68.96),
    --     spawnPoint = {
    --         vector4(60.8, 17.54, 68.82, 339.7)
    --     },
    --     showBlip = true,
    --     blipName = '公共停车场',
    --     blipNumber = 357,
    --     blipColor = 3,
    --     type = 'public',
    --     category = Config.VehicleClass['car']
    -- },
    -- caears242 = {
    --     label = 'Caears 24 Parking',
    --     takeVehicle = vector3(-453.7, -786.78, 30.56),
    --     spawnPoint = {
    --         vector4(-472.39, -787.71, 30.14, 180.52)
    --     },
    --     showBlip = true,
    --     blipName = '公共停车场',
    --     blipNumber = 357,
    --     blipColor = 3,
    --     type = 'public',
    --     category = Config.VehicleClass['car']
    -- },
    -- lagunapi = {
    --     label = 'Laguna Parking',
    --     takeVehicle = vector3(364.37, 297.83, 103.49),
    --     spawnPoint = {
    --         vector4(375.09, 294.66, 102.86, 164.04)
    --     },
    --     showBlip = true,
    --     blipName = '公共停车场',
    --     blipNumber = 357,
    --     blipColor = 3,
    --     type = 'public',
    --     category = Config.VehicleClass['car']
    -- },
    -- airportp = {
    --     label = 'Airport Parking',
    --     takeVehicle = vector3(-773.12, -2033.04, 8.88),
    --     spawnPoint = {
    --         vector4(-779.77, -2040.18, 8.47, 315.34)
    --     },
    --     showBlip = true,
    --     blipName = '公共停车场',
    --     blipNumber = 357,
    --     blipColor = 3,
    --     type = 'public',
    --     category = Config.VehicleClass['car']
    -- },
    -- beachp = {
    --     label = 'Beach Parking',
    --     takeVehicle = vector3(-1185.32, -1500.64, 4.38),
    --     spawnPoint = {
    --         vector4(-1188.14, -1487.95, 3.97, 124.06)
    --     },
    --     showBlip = true,
    --     blipName = '公共停车场',
    --     blipNumber = 357,
    --     blipColor = 3,
    --     type = 'public',
    --     category = Config.VehicleClass['car']
    -- },
    -- themotorhotel = {
    --     label = 'The Motor Hotel Parking',
    --     takeVehicle = vector3(1137.77, 2663.54, 37.9),
    --     spawnPoint = {
    --         vector4(1127.7, 2647.84, 37.58, 1.41)
    --     },
    --     showBlip = true,
    --     blipName = '公共停车场',
    --     blipNumber = 357,
    --     blipColor = 3,
    --     type = 'public',
    --     category = Config.VehicleClass['car']
    -- },
    -- liqourparking = {
    --     label = 'Liqour Parking',
    --     takeVehicle = vector3(883.99, 3649.67, 32.87),
    --     spawnPoint = {
    --         vector4(898.38, 3649.41, 32.36, 90.75)
    --     },
    --     showBlip = true,
    --     blipName = '公共停车场',
    --     blipNumber = 357,
    --     blipColor = 3,
    --     type = 'public',
    --     category = Config.VehicleClass['car']
    -- },
    -- shoreparking = {
    --     label = 'Shore Parking',
    --     takeVehicle = vector3(1737.03, 3718.88, 34.05),
    --     spawnPoint = {
    --         vector4(1725.4, 3716.78, 34.15, 20.54)
    --     },
    --     showBlip = true,
    --     blipName = '公共停车场',
    --     blipNumber = 357,
    --     blipColor = 3,
    --     type = 'public',
    --     category = Config.VehicleClass['car']
    -- },
    -- haanparking = {
    --     label = 'Bell Farms Parking',
    --     takeVehicle = vector3(76.88, 6397.3, 31.23),
    --     spawnPoint = {
    --         vector4(62.15, 6403.41, 30.81, 211.38)
    --     },
    --     showBlip = true,
    --     blipName = '公共停车场',
    --     blipNumber = 357,
    --     blipColor = 3,
    --     type = 'public',
    --     category = Config.VehicleClass['car']
    -- },
    -- dumbogarage = {
    --     label = 'Dumbo Private Parking',
    --     takeVehicle = vector3(165.75, -3227.2, 5.89),
    --     spawnPoint = {
    --         vector4(168.34, -3236.1, 5.43, 272.05)
    --     },
    --     showBlip = true,
    --     blipName = '公共停车场',
    --     blipNumber = 357,
    --     blipColor = 3,
    --     type = 'public',
    --     category = Config.VehicleClass['car']
    -- },
    pillboxgarage = {
        label = '公共避难所停车场',
        takeVehicle = vector3(213.2, -796.05, 30.86),
        spawnPoint = {
            vector4(222.02, -804.19, 30.26, 248.19),
            vector4(223.93, -799.11, 30.25, 248.53),
            vector4(226.46, -794.33, 30.24, 248.29),
            vector4(232.33, -807.97, 30.02, 69.17),
            vector4(234.42, -802.76, 30.04, 67.2)
        },
        showBlip = true,
        blipName = '公共避难所停车场',
        blipNumber = 357,
        blipColor = 3,
        type = 'public',
        category = Config.VehicleClass['car']
    },
    -- grapeseedgarage = {
    --     label = 'Grapeseed Parking',
    --     takeVehicle = vector3(2552.68, 4671.8, 33.95),
    --     spawnPoint = {
    --         vector4(2550.17, 4681.96, 33.81, 17.05)
    --     },
    --     showBlip = true,
    --     blipName = '公共停车场',
    --     blipNumber = 357,
    --     blipColor = 3,
    --     type = 'public',
    --     category = Config.VehicleClass['car']
    -- },
    depotLot = {
        label = '戴维斯扣押场',
        takeVehicle = vector3(401.76, -1632.57, 29.29),
        spawnPoint = {
            vector4(396.55, -1643.93, 28.88, 321.91)
        },
        showBlip = true,
        blipName = '戴维斯扣押场',
        blipNumber = 68,
        blipColor = 3,
        type = 'depot',
        category = Config.VehicleClass['car']
    },
    ballas = {
        label = '巴勒斯帮派车库',
        takeVehicle = vector3(87.51, -1969.1, 20.75),
        spawnPoint = {
            vector4(93.78, -1961.73, 20.34, 319.11)
        },
        showBlip = true,
        blipName = '巴勒斯帮派车库（私有）',
        blipNumber = 357,
        blipColor = 3,
        type = 'gang',
        category = Config.VehicleClass['car'], --car, air, sea, rig
        job = 'ballas',
        jobType = 'ballas'
    },
    families = {
        label = '伐木累帮派车库',
        takeVehicle = vector3(-23.89, -1436.03, 30.65),
        spawnPoint = {
            vector4(-25.47, -1445.76, 30.24, 178.5)
        },
        showBlip = true,
        blipName = '伐木累帮派车库（私有）',
        blipNumber = 357,
        blipColor = 3,
        type = 'gang',
        category = Config.VehicleClass['car'], --car, air, sea, rig
        job = 'families',
        jobType = 'families'
    },
    lostmc = {
        label = '失落摩托帮派车库',
        takeVehicle = vector3(985.83, -138.14, 73.09),
        spawnPoint = {
            vector4(977.65, -133.02, 73.34, 59.39)
        },
        showBlip = true,
        blipName = '失落摩托帮派车库（私有）',
        blipNumber = 357,
        blipColor = 3,
        type = 'gang',
        category = Config.VehicleClass['car'], --car, air, sea, rig
        job = 'lostmc',
        jobType = 'lostmc'
    },
    cartel = {
        label = '卡特尔帮派车库',
        takeVehicle = vector3(1411.67, 1117.8, 114.84),
        spawnPoint = {
            vector4(1403.01, 1118.25, 114.84, 88.69)
        },
        showBlip = true,
        blipName = '卡特尔帮派车库（私有）',
        blipNumber = 357,
        blipColor = 3,
        type = 'gang',
        category = Config.VehicleClass['car'],
        job = 'cartel',
        jobType = 'cartel'
    },
    police = {
        label = '密申罗警局',
        takeVehicle = vector3(462.83, -1019.52, 28.1),
        spawnPoint = {
            vector4(446.16, -1025.79, 28.23, 6.59)
        },
        showBlip = true,
        blipName = '密申罗警局车库（私有）',
        blipNumber = 357,
        blipColor = 3,
        type = 'job',
        category = Config.VehicleClass['car'], --car, air, sea, rig
        job = 'police',
        jobType = 'leo'
    },
    intairport = {
        label = '飞机场公共机库',
        takeVehicle = vector3(-979.06, -2995.48, 13.95),
        spawnPoint = {
            vector4(-998.37, -2985.01, 13.95, 61.09)
        },
        showBlip = true,
        blipName = '飞机场公共机库',
        blipNumber = 360,
        blipColor = 3,
        type = 'public',
        category = Config.VehicleClass['air']
    },
    higginsheli = {
        label = '希金斯机库',
        takeVehicle = vector3(-722.15, -1472.79, 5.0),
        spawnPoint = {
            vector4(-745.22, -1468.72, 5.39, 319.84),
            vector4(-724.36, -1443.61, 5.39, 135.78)
        },
        showBlip = true,
        blipName = '希金斯机库（即将私有）',
        blipNumber = 360,
        blipColor = 3,
        type = 'public',
        category = Config.VehicleClass['air']
    },
    airsshores = {
        label = '桑迪海岸公共机库',
        takeVehicle = vector3(1737.89, 3288.13, 41.14),
        spawnPoint = {
            vector4(1742.83, 3266.83, 41.24, 102.64)
        },
        showBlip = true,
        blipName = '桑迪海岸公共机库',
        blipNumber = 360,
        blipColor = 3,
        type = 'public',
        category = Config.VehicleClass['air']
    },
    airzancudo = {
        label = '赞库多堡机库',
        takeVehicle = vector3(-1828.25, 2975.44, 32.81),
        spawnPoint = {
            vector4(-1828.25, 2975.44, 32.81, 57.24)
        },
        showBlip = true,
        blipName = '赞库多堡机库（即将私有）',
        blipNumber = 360,
        blipColor = 3,
        type = 'public',
        category = Config.VehicleClass['air']
    },
    airdepot = {
        label = '航空仓库',
        takeVehicle = vector3(-1270.01, -3377.53, 14.33),
        spawnPoint = {
            vector4(-1270.01, -3377.53, 14.33, 329.25)
        },
        showBlip = true,
        blipName = '航空仓库（即将私有）',
        blipNumber = 359,
        blipColor = 3,
        type = 'depot',
        category = Config.VehicleClass['air']
    },
    lsymc = {
        label = '洛圣都游艇俱乐部-船屋',
        takeVehicle = vector3(-785.95, -1497.84, -0.09),
        spawnPoint = {
            vector4(-796.64, -1502.6, -0.09, 111.49)
        },
        showBlip = true,
        blipName = '洛圣都游艇俱乐部-船屋（即将私有）',
        blipNumber = 356,
        blipColor = 3,
        type = 'public',
        category = Config.VehicleClass['sea']
    },
    paleto = {
        label = '帕莱托船屋',
        takeVehicle = vector3(-278.21, 6638.13, 7.55),
        spawnPoint = {
            vector4(-289.2, 6637.96, 1.01, 45.5)
        },
        showBlip = true,
        blipName = '帕莱托船屋（不引人注目~）',
        blipNumber = 356,
        blipColor = 3,
        type = 'public',
        category = Config.VehicleClass['sea']
    },
    millars = {
        label = '米勒船屋',
        takeVehicle = vector3(1298.56, 4212.42, 33.25),
        spawnPoint = {
            vector4(1297.82, 4209.61, 30.12, 253.5)
        },
        showBlip = true,
        blipName = '米勒船屋（地中海段）',
        blipNumber = 356,
        blipColor = 3,
        type = 'public',
        category = Config.VehicleClass['sea']
    },
    seadepot = {
        label = '洛圣都游艇俱乐部-仓库',
        takeVehicle = vector3(-742.95, -1407.58, 5.5),
        spawnPoint = {
            vector4(-729.77, -1355.49, 1.19, 142.5)
        },
        showBlip = true,
        blipName = '洛圣都游艇俱乐部-仓库（即将私有）',
        blipNumber = 356,
        blipColor = 3,
        type = 'depot',
        category = Config.VehicleClass['sea']
    },
    rigdepot = {
        label = '重型载具基地',
        takeVehicle = vector3(2334.42, 3118.62, 48.2),
        spawnPoint = {
            vector4(2324.57, 3117.79, 48.21, 4.05)
        },
        showBlip = true,
        blipName = '重型载具基地（即将私有）',
        blipNumber = 68,
        blipColor = 2,
        type = 'depot',
        category = Config.VehicleClass['rig']
    },
    dumborigparking = {
        label = '笨重载具停放区',
        takeVehicle = vector3(161.23, -3188.73, 5.97),
        spawnPoint = {
            vector4(167.0, -3203.89, 5.94, 271.27)
        },
        showBlip = true,
        blipName = '笨重载具停放区（即将私有）',
        blipNumber = 357,
        blipColor = 2,
        type = 'public',
        category = Config.VehicleClass['rig']
    },
    popsrigparking = {
        label = '笨重载具停放区（即将私有）',
        -- label = 'Pop\'s Big Rig Parking',
        takeVehicle = vector3(137.67, 6632.99, 31.67),
        spawnPoint = {
            vector4(127.69, 6605.84, 31.93, 223.67)
        },
        showBlip = true,
        blipName = '笨重载具停放区（即将私有）',
        blipNumber = 357,
        blipColor = 2,
        type = 'public',
        category = Config.VehicleClass['rig']
    },
    ronsrigparking = {
        label = '笨重载具停放区',
        -- label = 'Ron\'s Big Rig Parking',
        takeVehicle = vector3(-2529.37, 2342.67, 33.06),
        spawnPoint = {
            vector4(-2521.61, 2326.45, 33.13, 88.7)
        },
        showBlip = true,
        blipName = '笨重载具停放区（即将私有）',
        blipNumber = 357,
        blipColor = 2,
        type = 'public',
        category = Config.VehicleClass['rig']
    },
    ronsrigparking2 = {
        label = '笨重载具停放区',
        -- label = 'Ron\'s Big Rig Parking',
        takeVehicle = vector3(2561.67, 476.68, 108.49),
        spawnPoint = {
            vector4(2561.67, 476.68, 108.49, 177.86)
        },
        showBlip = true,
        blipName = '笨重载具停放区（即将私有）',
        blipNumber = 357,
        blipColor = 2,
        type = 'public',
        category = Config.VehicleClass['rig']
    },
    ronsrigparking3 = {
        label = '笨重载具停放区',
        -- label = 'Ron\'s Big Rig Parking',
        takeVehicle = vector3(-41.24, -2550.63, 6.01),
        spawnPoint = {
            vector4(-39.39, -2527.81, 6.08, 326.18)
        },
        showBlip = true,
        blipName = '笨重载具停放区（即将私有）',
        blipNumber = 357,
        blipColor = 2,
        type = 'public',
        category = Config.VehicleClass['rig']
    },
}