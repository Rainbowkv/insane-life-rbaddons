Config = {}


Config.WebhookURL = "Url"
Config.WebhookAvatar = "https://imgur.com/xXbcnU7.png" 
Config.ScriptName = "RobinGCS Police Cars"
Config.ScriptAuthor = "RobinGCS"


Config.NPC = {
    model = "s_m_y_cop_01", 
    coords = vector4(470.43, -981.85, 26.27, 87.43), 
    targetName = "police_car_dealer", 
    label = "警用车辆购买处"
}

Config.VehicleSpawnLocation = vector4(444.52, -1017.97, 28.64, 80.29)


Config.PoliceVehicles = {
    ["初级警员"] = {
        {model = "2vd_bstx", label = "警用CTX", price = 90000},
        {model = "2vd_vscout", label = "警用探险者", price = 90000}
    },
    ["警长"] = {
        {model = "2vd_bstx", label = "警用CTX", price = 90000},
        {model = "2vd_vscout", label = "警用探险者", price = 90000}
    },
    ["警督"] = {
        {model = "2vd_bstx", label = "警用CTX", price = 90000},
        {model = "2vd_vscout", label = "警用探险者", price = 90000}
    },
    ["警察局长"] = {
        {model = "2vd_bstx", label = "警用CTX", price = 90000},
        {model = "2vd_vscout", label = "警用探险者", price = 90000}
    },
}
