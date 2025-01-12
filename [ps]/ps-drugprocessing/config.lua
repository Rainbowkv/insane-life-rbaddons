Config = {}
Info = {}

Info.ItemLocation = {  -- 这是不可配置的，静态资源。
	Sodium = {
		1251, -- {1251.48987, -2563.09351, 42.1963539},
		1253, -- {1253.29565, -2568.77661, 42.1966438},
		1256, -- {1256.77563, -2569.82642, 42.1993866},
		1258, -- {1258.78833, -2558.68115, 42.1979},
		1260  -- {1260.32825, -2555.68628, 42.1944962}
	},
	Chemicals = {
		2703, -- 2703.49072, 1434.66931, 31.91478        1
		2701, -- 2701.49072, 1434.66931, 31.91478        2
		2709, -- 2709.49072, 1434.66931, 31.9219837      3
		2707, -- 2707.24585, 1415.35608, 31.9219837      4
		2700  -- 2700.356, 1420.29907, 31.79312          5
	},
	CocaLeaves = {
		2775, -- 2775.96265, 2852.49146, 34.6796646      1
		2773, -- 2773.19116, 2849.5603, 34.7315521       2
		2771, -- 2771.28564, 2853.61328, 34.4794731      3
		2777, -- 2777.739, 2857.45264, 34.5396652        4
		2779  -- 2779.01074, 2853.323, 34.74015          5
	},
	Heroin = {  -- 向下取整，负数绝对值变大
		-3076, -- -3075.00146, 3388.96484, 5.295536       1
		-3079, -- -3078.494, 3386.77661, 4.97007656       2
		-3082, -- -3081.04858, 3389.20239, 4.764866       3
		-3089, -- -3088.264, 3383.331, 4.123703           4
		-3091, -- -3090.61719, 3390.70215, 3.89072752     5
		-3095 -- -3094.779, 3392.77734, 3.41797876       6
	},
	HydrochloricAcid = {
		2358, -- 2358.78442, 3138.57446, 47.2095337   1
		2360, -- 2360.793, 3124.997, 47.2112579            2
		2348, -- 2348.76538, 3128.58667, 47.2075577   3
		2342, -- 2342.095, 3143.53662, 47.21349            4
		2345  -- 2345.85132, 3142.8562, 47.2097778     5
	},
	Sulfuric = {
		-1151, -- -1150.9425, 4938.0835, 220.0459          1
		-1154, -- -1153.39563, 4907.399, 219.120422      2
		-1116, -- -1115.43835, 4934.376, 217.758743      3
		-1118, -- -1117.46948, 4913.21631, 217.148148 4
		-1083  -- -1082.81836, 4897.341, 213.67572        5
	},
	Weed = {
		2240, -- 2240.14014, 5596.859, 53.01744          1
		2231, -- 2231.81421, 5603.968, 53.6791077        2
		2208, -- 2208.38, 5586.88574, 52.90408           3
		2213, -- 2213.57422, 5617.1875, 53.3913269       4
		2268  -- 2268.86353, 5585.93457, 51.393383       5
	}
}

Info.Interval = {  -- min
	Sodium = 30, Chemicals = 30, CocaLeaves = 30, Heroin = 30, HydrochloricAcid = 30, Sulfuric = 30, Weed = 30
}

Config.KeyRequired = false  -- 是否校验钥匙

Config.Delays = {
	WeedProcessing = 1000 * 10,
	MethProcessing = 1000 * 10,
	CokeProcessing = 1000 * 10,
	lsdProcessing = 1000 * 10,
	HeroinProcessing = 1000 * 10,
	thionylchlorideProcessing = 1000 * 10,
}

Config.CircleZones = {
	WeedField = {coords = vector3(2224.64, 5577.03, 53.85), name = ('Weed Farm'), radius = 100.0},
	WeedProcessing = {coords = vector3(1038.33, -3204.44, -38.17), name = ('Weed Process'), radius = 100.0},
	
	MethProcessing = {coords = vector3(978.17, -147.98, -48.53), name = ('Meth Process'), radius = 20.0},
	MethTemp = {coords = vector3(982.56, -145.59, -49.0), name = ('Meth Temperature'), radius = 20.0},
	MethBag = {coords = vector3(987.81, -140.43, -49.0), name = ('Meth Bagging'), radius = 20.0},
	HydrochloricAcidFarm = {coords = vector3(-1069.25, 4945.57, 212.18), name = ('Hydrochloric Acid'), radius = 100.0},

	SulfuricAcidFarm = {coords = vector3(-3026.89, 3334.91, 10.04), name = ('Sulfuric Acid'), radius = 100.0},
	SodiumHydroxideFarm = {coords = vector3(-389.35, -1874.85, 20.53), name = ('Sodium Hydroxide'), radius = 100.0},
	
	ChemicalsField = {coords = vector3(1264.97, 1803.96, 82.94), name = ('Chemicals'), radius = 100.0},
	ChemicalsConvertionMenu = {coords = vector3(3536.71, 3662.63, 28.12), name = ('Chemicals Process'), radius = 100.0},

	CokeField = {coords = vector3(2806.5, 4774.46, 46.98), name = ('Coke'), radius = 100.0},
	CokeProcessing = {coords = vector3(1087.14, -3195.31, -38.99), name = ('Coke Process'), radius = 20.0}, 
	CokePowder = {coords = vector3(1092.9, -3196.65, -38.99), name = ('Powder Cutting'), radius = 20.0},--vector3(1092.9, -3196.65, -38.99)
	CokeBrick = {coords = vector3(1099.57, -3194.35, -38.99), name = ('Brick Up Packages'), radius = 20.0},--vector3(1099.57, -3194.35, -38.99)
	
	HeroinField = {coords = vector3(-2339.15, -54.32, 95.05), name = ('Heroin'), radius = 100.0},
	HeroinProcessing = {coords = vector3(1413.37, -2041.74, 52.0), name = ('Heroin Process'), radius = 100.0},

	lsdProcessing = {coords = vector3(2503.84, -428.11, 92.99), name = ('LSD process'), radius = 100.0},

	thionylchlorideProcessing = {coords = vector3(-679.59, 5800.46, 17.33), name = ('Thi Clo Process'), radius = 100.0},
}


Config.MethLab = {
	["enter"] = {
        coords = vector4(-1187.17, -446.24, 43.91, 306.59),
    },
    ["exit"] = {
        coords = vector4(969.57, -147.07, -46.4, 267.52),  --vector3(969.57, -147.07, -46.4)
    },
}

Config.CokeLab = {
	["enter"] = {
        coords = vector4(813.21, -2398.69, 23.66, 171.51), --vector3(813.21, -2398.69, 23.66)
    },
    ["exit"] = {
        coords = vector4(1088.68, -3187.68, -38.99, 176.04), -- GTA DLC Biker Cocaine Lab -- vector3(1088.68, -3187.68, -38.99)
    },
}

Config.WeedLab = {
	["enter"] = {
		coords = vector4(102.07, 175.09, 104.59, 165.63), 
    },
    ["exit"] = {
        coords = vector4(1066.01, -3183.38, -39.16, 93.01), -- GTA DLC Weed Lab -- 
    },
}


--------------------------------
-- DRUG CONFIG AMOUNTS --
--------------------------------

--------------------------------
-- COKE PROCESSING AMOUNTS --
--------------------------------

Config.CokeProcessing = {
	CokeLeaf = 1, -- Amount of Leaf Needed to Process
	ProcessCokeLeaf = math.random(2,7), -- Amount of Coke Received
	-- Processing Small Bricks --
	Coke = 10, -- Amount of Coke Needed for Small Brick
	BakingSoda = 5, -- Amount of Baking Soda Needed for Small Brick
	SmallCokeBrick = math.random(2,7),
	-- Process Small Bricks Into Large Brick --
	SmallBrick = 4, -- Amount of Small Bricks Required
	LargeBrick = 1, -- Large Bricks Received
}

--------------------------------
-- METH PROCESSING AMOUNTS --
--------------------------------
Config.MethProcessing = {
	-- Chemical Processing --
	SulfAcid = 1, -- Amount of Sulfuric Acid Needed for Liquid Mix
	HydAcid = 1, -- Amount of Hydrochloric Acid Needed for Liquid Mix
	SodHyd = 1, -- Amount of Sodium Hydroxide Needed for Liquid Mix
	Meth = math.random(5,12), -- Amount of Meth Recevied From 1 Tray
}

--------------------------------
-- HEROIN PROCESSING AMOUNTS --
--------------------------------
Config.HeroinProcessing = {
	Poppy = 2 -- Amount of Poppy Required for 1 Heroin
}
