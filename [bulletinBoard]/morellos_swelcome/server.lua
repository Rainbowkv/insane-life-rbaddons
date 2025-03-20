-- Table to store players who have seen the welcome screen
local playersSeenWelcome = {}

-- Register server event to kick player
RegisterNetEvent('fivem_welcome:kickPlayer')
AddEventHandler('fivem_welcome:kickPlayer', function(reason)
    local src = source
    DropPlayer(src, reason)
end)

-- Register server event to check if player has seen welcome screen
RegisterNetEvent('fivem_welcome:checkPlayerSeen')
AddEventHandler('fivem_welcome:checkPlayerSeen', function()
    local src = source
    local identifier = GetPlayerIdentifier(src, 0) -- Get player's identifier
    
    if Config.ShowOnlyOnce and identifier then
        if not playersSeenWelcome[identifier] then
            -- Player hasn't seen welcome screen yet
            playersSeenWelcome[identifier] = true
            TriggerClientEvent('fivem_welcome:showWelcomeScreen', src)
        end
    else
        -- Always show if ShowOnlyOnce is disabled
        TriggerClientEvent('fivem_welcome:showWelcomeScreen', src)
    end
end)

-- Register server event to mark player as having seen welcome screen
RegisterNetEvent('fivem_welcome:playerAccepted')
AddEventHandler('fivem_welcome:playerAccepted', function()
    local src = source
    local identifier = GetPlayerIdentifier(src, 0)
    
    if identifier then
        playersSeenWelcome[identifier] = true
    end
end)

-- Print a message when the resource starts
AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    print('^2FiveM Welcome^7: Resource started successfully')
end)

-- Clear the table when the resource stops
AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    playersSeenWelcome = {}
end)
