-- This file is dedicated in the ban functions related that are executed when the server detects a strange behavior from a player.
function BanPlayer(source, reason)
    -- Make sure to add the ban logic here
    print("Player " .. GetPlayerName(source).."("..source..") has been kicked. Reason: " .. reason)
    DropPlayer(source, "You have been kicked from the server. Reason: " .. reason)
end