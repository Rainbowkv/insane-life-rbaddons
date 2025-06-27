local QBCore = exports['qb-core']:GetCoreObject()

local MusicBoxes = {}
local srctoMusicBoxes = {}

RegisterNetEvent("rb-musicbox:server:RegisterBox", function(netId)
    local src = source
    local coords = GetEntityCoords(NetworkGetEntityFromNetworkId(netId))
    MusicBoxes[netId] = {}
    MusicBoxes[netId].owner = src
    MusicBoxes[netId].coords = coords
    srctoMusicBoxes[src] = netId
end)

RegisterNetEvent("rb-musicbox:server:PlayMusic", function(netId, url, volume)
    local startTime = os.time()
    MusicBoxes[netId].url = url
    MusicBoxes[netId].startTime = startTime
    MusicBoxes[netId].volume = volume
    TriggerClientEvent("rb-musicbox:client:PlayMusic", -1, netId, url, MusicBoxes[netId].coords, startTime, volume)
end)

RegisterNetEvent("rb-musicbox:server:StopMusic", function(netId)
    TriggerClientEvent("rb-musicbox:client:StopMusic", -1, netId)
end)

RegisterNetEvent("rb-musicbox:server:RemoveBox", function(netId)
    TriggerClientEvent("rb-musicbox:client:RemoveBox", -1, netId)
    MusicBoxes[netId] = nil
end)

AddEventHandler('playerDropped', function(reason)
    local src = source
    TriggerClientEvent("rb-musicbox:client:RemoveBox", -1, srctoMusicBoxes[src])
    MusicBoxes[srctoMusicBoxes[src]] = nil
    srctoMusicBoxes[src] = nil
end)

QBCore.Functions.CreateCallback('rb-musicbox:server:GetAllActiveBoxes', function(_, cb)
    local data = {}
    for netId, v in pairs(MusicBoxes) do
        if v.url and v.coords and v.startTime then
            data[netId] = { url = v.url, coords = v.coords, startTime = v.startTime, volume = v.volume }
        end
    end
    cb(data)
end)

QBCore.Functions.CreateCallback('rb-musicbox:server:getTime', function(source, cb)
    cb(os.time())
end)
