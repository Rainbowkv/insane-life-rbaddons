RegisterServerEvent("origen_police:server:rpol", function(job, message)
    if Config.Framework ~= "qbcore" and Config.Framework ~= "esx" then return print("Can't find supported framework: ", Config.Framework) end
    local jobCategory = CanOpenTablet(source)[2]
    local Players = Config.Framework == "qbcore" and Framework.Functions.GetPlayersOnDuty(job) or GetPlayersInDuty(jobCategory)
    local CentralSuscribers = exports["origen_police"]:GetCentralSuscribeds()
    for _, v in pairs(Players) do
        if CentralSuscribers[v] then
            TriggerClientEvent('origen_police:client:rpol', v, message)
        end
        TriggerClientEvent('chat:addMessage', v, { args = {message}})
    end
end)

-- rb_code
local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('police:server:SetHandcuffStatus', function(isHandcuffed)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        Player.Functions.SetMetaData('ishandcuffed', isHandcuffed)
    end
end)

RegisterNetEvent('police:server:CuffPlayer', function(playerId, isSoftcuff)
    local src = source
    local playerPed = GetPlayerPed(src)
    local targetPed = GetPlayerPed(playerId)
    local playerCoords = GetEntityCoords(playerPed)
    local targetCoords = GetEntityCoords(targetPed)
    if #(playerCoords - targetCoords) > 2.5 then return end

    local Player = QBCore.Functions.GetPlayer(src)
    local CuffedPlayer = QBCore.Functions.GetPlayer(playerId)
    if not Player or not CuffedPlayer or Player.PlayerData.job.name ~= 'police' then return end

    TriggerClientEvent('police:client:GetCuffed', CuffedPlayer.PlayerData.source, Player.PlayerData.source, isSoftcuff)
end)