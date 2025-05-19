Config = {}

Config.keyBind = "F6"

Config.defaultGarage = 'XinShouGongYu'

Config.donator_vehicles = {
    { name = "760 宝马", price = 218, image = "images/bmw760.png" },
    { name = "SU7 max 小米", price = 258, image = "images/su7max.png" },
    { name = "model s 特斯拉", price = 268, image = "images/models.png" },
    { name = "卫士 路虎", price = 298, image = "images/defender.png" },
    { name = "RS7 奥迪", price = 298, image = "images/rs7.png" },
    { name = "揽胜 路虎", price = 338, image = "images/rangerover.png" },
    { name = "凯雷德 凯迪拉克", price = 338, image = "images/escalade.png" },
    { name = "GTR 尼桑", price = 358, image = "images/gtr.png" },
    { name = "M4 gts 宝马", price = 358, image = "images/m4.png" },
    { name = "AMG gt63 奔驰", price = 378, image = "images/AMGgt63.png" },
    { name = "992 gt3 保时捷", price = 498, image = "images/gt3.png" },
    { name = "SU7 Ultra 原型 小米", price = 538, image = "images/su7ultra.png" },
    { name = "S680 奔驰", price = 568, image = "images/s680.png" },
    { name = "欧陆GT 宾利", price = 578, image = "images/ContinentalGT.png" },
    { name = "G63 4x4 奔驰", price = 698, image = "images/g63.png" },
    { name = "曜影 宽体敞篷 劳斯莱斯", price = 898, image = "images/rrdawncabrio2020wb.png" },
    { name = "M4 gt3 宝马", price = 1098, image = "images/m4gt3.png" },
    { name = "SVJ 兰博基尼", price = 1198, image = "images/svj.png" },
    { name = "Victor 阿斯顿马丁", price = 1198, image = "images/victor.png" },
    { name = "SF90 法拉利", price = 1198, image = "images/sf90.png" },
    { name = "幻影Ⅷ 劳斯莱斯", price = 1198, image = "images/phantom8.png" },
}

Config.vehicle_price = {
    ["760 宝马"] = 218,
    ["SU7 max 小米"] = 258,
    ["model s 特斯拉"] = 268,
    ["卫士 路虎"] = 298,
    ["RS7 奥迪"] = 298,
    ["揽胜 路虎"] = 338,
    ["凯雷德 凯迪拉克"] = 338,
    ["GTR 尼桑"] = 358,
    ["M4 gts 宝马"] = 358,
    ["AMG gt63 奔驰"] = 378,
    ["992 gt3 保时捷"] = 498,
    ["SU7 Ultra 原型 小米"] = 538,
    ["S680 奔驰"] = 568,
    ["欧陆GT 宾利"] = 578,
    ["G63 4x4 奔驰"] = 698,
    ["曜影 宽体敞篷 劳斯莱斯"] = 898,
    ["M4 gt3 宝马"] = 1098,
    ["SVJ 兰博基尼"] = 1198,         
    ["Victor 阿斯顿马丁"] = 1198,
    ["SF90 法拉利"] = 1198,
    ["幻影Ⅷ 劳斯莱斯"] = 1198,
}

Config.vehicle_mod = {
    ["760 宝马"] = "m76023",
    ["SU7 max 小米"] = "dpcsu7max",
    ["model s 特斯拉"] = "models",
    ["卫士 路虎"] = "oycdefender",
    ["RS7 奥迪"] = "rs721",
    ["揽胜 路虎"] = "rsvr16",
    ["凯雷德 凯迪拉克"] = "gmt900escalade",
    ["GTR 尼桑"] = "gtr",
    ["M4 gts 宝马"] = "rmodm4gts",
    ["AMG gt63 奔驰"] = "rmodgt63",
    ["992 gt3 保时捷"] = "992gt3",
    ["SU7 Ultra 原型 小米"] = "su7ultra",
    ["S680 奔驰"] = "22s680m",
    ["欧陆GT 宾利"] = "ikx3gtone",
    ["G63 4x4 奔驰"] = "4444",
    ["曜影 宽体敞篷 劳斯莱斯"] = "rrdawncabrio2020wb",
    ["M4 gt3 宝马"] = "m4gt3",
    ["SVJ 兰博基尼"] = "cffsvj",        
    ["Victor 阿斯顿马丁"] = "Victor",
    ["SF90 法拉利"] = "ikx3sf90custom",
    ["幻影Ⅷ 劳斯莱斯"] = "p8tempus",
}

-- 仅包含需要特殊处理的车
Config.vehicle_defaultmods = {
    ["760 宝马"] = '{"modTrimB":-1,"modLivery":-1,"modFrontBumper":-1,"modSuspension":-1,"modGrille":-1,"modTrimA":-1,"modAerials":-1,"modTank":-1,"modRightFender":-1,"neonColor":[255,0,255],"windowStatus":{"1":true,"2":true,"3":true,"4":false,"5":false,"6":true,"7":true,"0":true},"paintType2":7,"modRoofLivery":-1,"modFrame":-1,"bulletProofTyres":false,"interiorColor":0,"modHydraulics":false,"plateIndex":3,"modAirFilter":-1,"modExhaust":-1,"modDoorSpeaker":-1,"modHorns":-1,"tankHealth":999.0,"modDoorR":-1,"modHydrolic":-1,"modBrakes":-1,"modArmor":-1,"pearlescentColor":0,"modRearBumper":-1,"wheelSize":1.0,"engineHealth":992.0,"doorStatus":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"wheelWidth":1.0,"modBackWheels":-1,"modSteeringWheel":-1,"modTurbo":false,"dashboardColor":0,"modEngine":-1,"modAPlate":-1,"modSideSkirt":-1,"modFrontWheels":-1,"modSeats":-1,"modSpoilers":-1,"color2":0,"modSubwoofer":-1,"modNitrous":-1,"modXenon":false,"modDashboard":-1,"modCustomTiresF":false,"tireBurstCompletely":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modSmokeEnabled":false,"wheels":0,"modPlateHolder":-1,"xenonCustomColorEnabled":false,"modEngineBlock":-1,"neonEnabled":[false,false,false,false],"xenonColor":255,"modHood":-1,"modTransmission":-1,"modDial":-1,"xenonCustomColor":[],"extras":{"1":false,"3":false,"2":false},"model":1166764952,"modWindows":-1,"bodyHealth":995.0,"modStruts":-1,"driftTyres":false,"modTrunk":-1,"modFender":0,"tireHealth":{"1":1000.0,"2":1000.0,"3":1000.0,"0":1000.0},"modShifterLeavers":-1,"dirtLevel":0.0,"modOrnaments":-1,"color1":0,"wheelColor":156,"fuelLevel":93.0,"modSpeakers":-1,"tireBurstState":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"windowTint":0,"tyreSmokeColor":[255,255,255],"paintType1":7,"modVanityPlate":-1,"modRoof":-1,"oilLevel":5.0,"modArchCover":-1,"modLightbar":-1,"modCustomTiresR":false}',
    ["SU7 max 小米"] = '{"modTrimB":-1,"modLivery":0,"modFrontBumper":-1,"modSuspension":-1,"modGrille":-1,"modTrimA":1,"modAerials":-1,"modTank":-1,"modRightFender":-1,"neonColor":[255,0,255],"windowStatus":{"1":true,"2":true,"3":true,"4":false,"5":false,"6":true,"7":false,"0":true},"paintType2":7,"modRoofLivery":-1,"modFrame":-1,"bulletProofTyres":false,"interiorColor":69,"modHydraulics":false,"plateIndex":3,"modAirFilter":-1,"modExhaust":-1,"modDoorSpeaker":-1,"modHorns":-1,"tankHealth":994.0,"modDoorR":-1,"modHydrolic":-1,"modBrakes":-1,"modArmor":-1,"pearlescentColor":0,"modRearBumper":-1,"wheelSize":1.0,"engineHealth":997.0,"doorStatus":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"wheelWidth":1.0,"modBackWheels":-1,"modSteeringWheel":-1,"modTurbo":false,"dashboardColor":69,"modEngine":-1,"modAPlate":-1,"modSideSkirt":0,"modFrontWheels":-1,"modSeats":-1,"modSpoilers":-1,"color2":3,"modSubwoofer":-1,"modNitrous":-1,"modXenon":false,"modDashboard":-1,"modCustomTiresF":false,"tireBurstCompletely":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modSmokeEnabled":false,"wheels":0,"modPlateHolder":-1,"xenonCustomColorEnabled":false,"modEngineBlock":-1,"neonEnabled":[false,false,false,false],"xenonColor":255,"modHood":-1,"modTransmission":-1,"modDial":-1,"xenonCustomColor":[],"extras":{"8":false},"model":680958279,"modWindows":-1,"bodyHealth":981.0,"modStruts":-1,"driftTyres":false,"modTrunk":-1,"modFender":-1,"tireHealth":{"1":997.9778442382813,"2":1000.0,"3":1000.0,"0":1000.0},"modShifterLeavers":-1,"dirtLevel":0.0,"modOrnaments":-1,"color1":24,"wheelColor":46,"fuelLevel":97.0,"modSpeakers":-1,"tireBurstState":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"windowTint":0,"tyreSmokeColor":[255,255,255],"paintType1":7,"modVanityPlate":-1,"modRoof":-1,"oilLevel":8.0,"modArchCover":-1,"modLightbar":-1,"modCustomTiresR":false}',
    ["S680 奔驰"] = '{"tireBurstState":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modBackWheels":-1,"modTank":-1,"tankHealth":1000.0,"modCustomTiresR":false,"oilLevel":5.0,"modDoorR":-1,"modVanityPlate":-1,"modDashboard":-1,"model":1600033037,"modRearBumper":-1,"pearlescentColor":0,"modLightbar":-1,"modFrame":-1,"modBrakes":-1,"modWindows":-1,"modOrnaments":-1,"modTrimA":-1,"modFrontBumper":-1,"modLivery":-1,"xenonColor":255,"modRoofLivery":-1,"neonEnabled":[false,false,false,false],"modSpeakers":-1,"color2":29,"interiorColor":111,"modTransmission":-1,"dashboardColor":111,"tireHealth":{"1":1000.0,"2":1000.0,"3":1000.0,"0":1000.0},"modPlateHolder":-1,"modHydrolic":-1,"modDial":-1,"modTurbo":false,"windowStatus":{"1":true,"2":true,"3":true,"4":false,"5":false,"6":true,"7":true,"0":true},"engineHealth":1000.0,"modExhaust":-1,"modSideSkirt":-1,"bodyHealth":1000.0,"tyreSmokeColor":[255,255,255],"fuelLevel":23.0,"modFrontWheels":-1,"extras":{"3":true,"2":false},"tireBurstCompletely":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modFender":0,"modHydraulics":false,"windowTint":0,"wheels":0,"modRightFender":-1,"driftTyres":false,"dirtLevel":0.0,"paintType1":7,"bulletProofTyres":false,"doorStatus":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modGrille":-1,"modTrunk":-1,"modSpoilers":-1,"modAPlate":-1,"modAirFilter":-1,"modStruts":-1,"wheelColor":156,"modSubwoofer":-1,"modXenon":false,"wheelSize":1.0,"modSmokeEnabled":false,"modHorns":-1,"modDoorSpeaker":-1,"xenonCustomColor":[],"paintType2":7,"modEngineBlock":-1,"modHood":-1,"modRoof":-1,"modNitrous":-1,"modAerials":-1,"modCustomTiresF":false,"modEngine":-1,"wheelWidth":1.0,"neonColor":[255,0,255],"modArmor":-1,"color1":0,"modShifterLeavers":-1,"modSuspension":-1,"xenonCustomColorEnabled":false,"modArchCover":-1,"modSteeringWheel":-1,"modTrimB":-1,"modSeats":-1,"plateIndex":0}',
    ["幻影Ⅷ 劳斯莱斯"] = '{"bodyHealth":1000.0592475178704,"modTrunk":-1,"modHood":-1,"modFrontWheels":-1,"modHorns":-1,"modKit49":-1,"color2":0,"windowStatus":{"1":true,"2":true,"3":true,"4":false,"5":false,"6":true,"7":true,"0":true},"modXenon":false,"modShifterLeavers":-1,"fuelLevel":64.3405870126668,"modCustomTiresR":false,"modKit21":-1,"extras":{"4":true,"5":false,"6":true,"7":true,"8":true,"1":false,"2":false,"3":true},"interiorColor":0,"pearlescentColor":4,"modSmokeEnabled":false,"modAerials":-1,"modPlateHolder":-1,"engineHealth":1000.0592475178704,"modAirFilter":-1,"modVanityPlate":-1,"oilLevel":4.76596940834568,"windowTint":0,"wheels":0,"modTank":-1,"modRightFender":-1,"modEngine":-1,"modBackWheels":-1,"modCustomTiresF":false,"tireBurstCompletely":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modTrimA":-1,"dirtLevel":0.0,"modSpeakers":-1,"modArmor":-1,"modLivery":-1,"modSteeringWheel":-1,"modHydrolic":-1,"modSuspension":-1,"wheelColor":156,"neonEnabled":[false,false,false,false],"modRoof":-1,"neonColor":[255,0,255],"wheelSize":1.0,"xenonColor":255,"doorStatus":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"modFrontBumper":-1,"dashboardColor":0,"modDial":-1,"modKit17":-1,"color1":147,"modSideSkirt":-1,"modFender":0,"modSpoilers":-1,"modExhaust":-1,"liveryRoof":-1,"tankHealth":1000.0592475178704,"tireBurstState":{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false},"tyreSmokeColor":[255,255,255],"modStruts":-1,"modGrille":-1,"model":-89063262,"modWindows":-1,"plateIndex":3,"modOrnaments":-1,"modTrimB":-1,"modDashboard":-1,"modDoorSpeaker":-1,"modKit47":-1,"modAPlate":-1,"modEngineBlock":-1,"modFrame":-1,"modBrakes":-1,"modSeats":-1,"wheelWidth":1.0,"modTransmission":-1,"modArchCover":-1,"modKit19":-1,"modTurbo":false,"tireHealth":{"1":1000.0,"2":1000.0,"3":1000.0,"0":1000.0},"modRearBumper":-1}',
}