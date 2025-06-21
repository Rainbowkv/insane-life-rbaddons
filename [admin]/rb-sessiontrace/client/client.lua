RegisterNUICallback('close', function(_, cb)
    SetNuiFocus(false, false)
    cb({})
end)

RegisterNetEvent('rb-sessiontrace:client:showUI', function(data)
    SendNUIMessage({
        action = 'updateData',
        sessions = data
    })
end)

RegisterNetEvent('rb-sessiontrace:client:open', function()
    SetNuiFocus(true, true)
    SendNUIMessage({ action = 'show' })
    TriggerServerEvent('rb-sessiontrace:server:getSessions')
end)