local isWelcomeScreenOpen = false
local welcomeShown = false

-- Function to open welcome screen
local function OpenWelcomeScreen()
    if isWelcomeScreenOpen then return end
    while not NetworkIsSessionStarted() do  -- 延迟到会话开始，才打开欢迎屏幕
		Wait(0)
	end
    isWelcomeScreenOpen = true
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "openWelcomeScreen",
        config = Config
    })
end

-- Function to close welcome screen
function CloseWelcomeScreen()
    if not isWelcomeScreenOpen then return end
    
    isWelcomeScreenOpen = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = "closeWelcomeScreen"
    })
end

-- Event handler for when the player spawns (QBCore compatibility)
RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    -- Wait for the player to be fully loaded and spawned
    Citizen.Wait(Config.WaitAfterSpawn)
    
    if Config.Enabled and not welcomeShown then
        if Config.ShowOnlyOnce then
            TriggerServerEvent('fivem_welcome:checkPlayerSeen')
        else
            OpenWelcomeScreen()
        end
        welcomeShown = true
    end
end)

-- Standalone event for player spawn
AddEventHandler('playerSpawned', function()
    -- This event is triggered when the player spawns in the world
    -- Wait a bit to ensure the player is fully loaded
    Citizen.Wait(Config.WaitAfterSpawn)
    
    if Config.Enabled and not welcomeShown then
        if Config.ShowOnlyOnce then
            TriggerServerEvent('fivem_welcome:checkPlayerSeen')
        else
            OpenWelcomeScreen()
        end
        welcomeShown = true
    end
end)

-- Event handler for server-triggered welcome screen
RegisterNetEvent('fivem_welcome:showWelcomeScreen')
AddEventHandler('fivem_welcome:showWelcomeScreen', function()
    if Config.Enabled and not isWelcomeScreenOpen then
        OpenWelcomeScreen()
    end
end)

-- NUI Callbacks
RegisterNUICallback('acceptWelcomeScreen', function(data, cb)
    -- Handle accept actions
    if Config.OnAccept.notification then
        -- Check if ox_lib is available for notifications
        if GetResourceState('ox_lib') == 'started' then
            exports.ox_lib:notify({
                title = 'Welcome',
                description = Config.OnAccept.notificationText,
                type = Config.OnAccept.notificationType
            })
        else
            -- Fallback to basic notification
            BeginTextCommandThefeedPost("STRING")
            AddTextComponentSubstringPlayerName(Config.OnAccept.notificationText)
            EndTextCommandThefeedPostTicker(false, true)
        end
    end
    
    -- Notify server that player has accepted
    if Config.ShowOnlyOnce then
        TriggerServerEvent('fivem_welcome:playerAccepted')
    end
    
    CloseWelcomeScreen()

    -- 帮助qb-multicharacter触发相应事件
	TriggerEvent('qb-multicharacter:client:chooseChar')
    cb('ok')
end)

RegisterNUICallback('declineWelcomeScreen', function(data, cb)
    -- If decline is clicked, trigger server event to kick player
    TriggerServerEvent('fivem_welcome:kickPlayer', Config.OnDecline.kickReason)
    
    CloseWelcomeScreen()
    cb('ok')
end)
