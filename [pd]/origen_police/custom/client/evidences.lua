function GetSelfBloodType() -- Get the blood type of the player
    local Player = FW_GetPlayerData(true)
    return Player.metadata.bloodtype
end