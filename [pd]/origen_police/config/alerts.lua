Config.MinAlertCooldown = 20 -- Seconds player have to wait to send another alert
Config.RecieveAlwaysAlerts = true -- if it is false, the alert first will be send to the dispatch if it's open, if it's closed the alert will be send to the mini dispatch, if it's true the alert will be send to the dispatch and mini dispatch at the same time
Config.DispatchRedirect = false -- If it's true the alerts first will be send to the dispatch, then the dispatch manager will redirect the alert to other units, if it's false the alerts will be send directly to all the units
Config.ShootAlert = true -- Enable shoot alert
Config.DisplayPlateOnVehicleAlerts = true -- To enable or disable the display of the plate in the vehicle alerts
Config.HeatMapAlerts = true -- Enable or disable the heat map alerts in the dispatch
Config.WeaponSilencierBlockShootAlert = true -- If the weapon has a silencier, it will not trigger the shoot alert
Config.BlackListedShootAlertWeapons = { -- The list of weapons that will not trigger the shoot alert
    --"WEAPON_STUNGUN",
    --"WEAPON_FLAREGUN",
    --"WEAPON_FIREEXTINGUISHER",
}

Config.ShootAlertCooldown = 120000 -- Cooldown between each shoot alert

Config.DebugRestrictZones = false -- If true, the restricted zones will be showed in the map
Config.RestrictedAlertZones = { -- This only will restrict automatic alerts(shoot alert), manual alerts like /911 will still work
    {
        {431.03, -981.66},
        {431.33, -971.71},
        {425.23, -979.31}
    }
}

Config.BlackListedWords = { -- Add the words you want to block in the alerts
    "dani"
}

-- DONT TOUCH BELOW
function IsWeaponBlacklisted(weaponName)
    for i = 1, #Config.BlackListedShootAlertWeapons do
        if Config.BlackListedShootAlertWeapons[i]:lower() == weaponName:lower() then
            return true
        end
    end
    return false
end

function IsWeaponBlacklistedForProfile(weaponName)
    for i = 1, #Config.BlackListedUsersWeapons do
        if Config.BlackListedUsersWeapons[i]:lower() == weaponName:lower() then
            return true
        end
    end
    return false
end