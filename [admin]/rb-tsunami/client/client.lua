local countdown = 0
local showing = false

RegisterNetEvent("tsunami:client:StartCountdown", function(time)
    if showing then return end
    countdown = time
    showing = true
    SendNUIMessage({
        action = "show",
    })
    CreateThread(function()
        while countdown >= 0 do
            SendNUIMessage({
                action = "update",
                time = countdown,
            })
            Wait(1000)
            countdown = countdown - 1
        end
        SendNUIMessage({ action = "hide" })
        showing = false
    end)
end)