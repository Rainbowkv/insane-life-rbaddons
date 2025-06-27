local QBCore = exports['qb-core']:GetCoreObject()

local placedMusicbox = false
local ownedMusicBoxNetID = nil
local ownedMusicBoxCoords = nil
local ActiveMusicBoxes = {}
local currentPlayingBox = nil

local function addOptions(entity)
    exports.ox_target:addLocalEntity(entity, {
        {
            icon = 'fa-solid fa-music',
            label = '播放音乐',
            onSelect = function(data)
                local entity = data.entity
                local netId = NetworkGetNetworkIdFromEntity(entity)

                -- 输入URL
                local input = exports['qb-input']:ShowInput({
                    header = "输入音乐 URL",
                    submitText = "播放",
                    inputs = {
                        {
                        text = "请输入音频链接 (支持 .mp3)",
                        name = "url",
                        type = "text",
                        isRequired = true
                        },
                        {
                            text = "音量 (1 - 10)",
                            name = "volume",
                            type = "number",
                            isRequired = true
                        }
                    }
                })

                if not input or not input.url or not input.volume or input.url == "" then
                    QBCore.Functions.Notify("请输入有效的音乐链接", "error")
                    return
                end

                local pvolume = tonumber(input.volume)
                if not pvolume or pvolume < 1 or pvolume > 10 then
                    QBCore.Functions.Notify("请输入 1 到 10 之间的音量值", "error")
                    return
                end
                local volume = pvolume / 10

                local url = input.url
                local netId = NetworkGetNetworkIdFromEntity(data.entity)
                if ActiveMusicBoxes[tostring(netId)] then
                    TriggerServerEvent("rb-musicbox:server:StopMusic", netId)
                    Wait(500)
                end
                TriggerServerEvent("rb-musicbox:server:PlayMusic", netId, url, volume)
            end
        },
        {
            icon = 'fa-solid fa-stop',
            label = '停止音乐',
            onSelect = function(data)
                local netId = NetworkGetNetworkIdFromEntity(data.entity)
                TriggerServerEvent("rb-musicbox:server:StopMusic", netId)
            end
        },
        {
            icon = 'fa-solid fa-box',
            label = '收回音乐盒',
            onSelect = function(data)
                local entity = data.entity
                local netId = NetworkGetNetworkIdFromEntity(entity)
                TriggerServerEvent("rb-musicbox:server:RemoveBox", netId)
            end
        }
    })
end

RegisterNetEvent('rb-musicbox:client:UseMusicBox', function()
    if placedMusicbox then return end
    placedMusicbox = true
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local model = Config.MusicBoxModel

    QBCore.Functions.LoadModel(model)
    local obj = CreateObject(model, coords.x, coords.y, coords.z - 1, true, true, true)
    ownedMusicBoxCoords = GetEntityCoords(obj)
    PlaceObjectOnGroundProperly(obj)
    SetEntityAsMissionEntity(obj, true, true)
    FreezeEntityPosition(obj, true)
    addOptions(obj)

    -- 将物品与实体关联
    local netId = NetworkGetNetworkIdFromEntity(obj)
    ownedMusicBoxNetID = netId
    TriggerServerEvent("rb-musicbox:server:RegisterBox", netId)
end)

RegisterNetEvent("rb-musicbox:client:PlayMusic", function(netId, url, coords, startTime, volume)
    ActiveMusicBoxes[tostring(netId)] = {
        url = url,
        coords = vector3(coords.x, coords.y, coords.z),
        startTime = startTime,
        volume = volume
    }
end)

RegisterNetEvent("rb-musicbox:client:StopMusic", function(netId)
    ActiveMusicBoxes[tostring(netId)] = nil
    if currentPlayingBox == netId then
        SendNUIMessage({ action = "stop" })
        currentPlayingBox = nil
    end
end)

RegisterNetEvent("rb-musicbox:client:RemoveBox", function(netId)
    TriggerEvent("rb-musicbox:client:StopMusic", netId)
    local entity = NetworkGetEntityFromNetworkId(netId)
    DeleteEntity(entity)
    if ownedMusicBoxNetID and netId == ownedMusicBoxNetID then
        placedMusicbox = false
        ownedMusicBoxNetID = nil
        ownedMusicBoxCoords = nil
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.TriggerCallback('rb-musicbox:server:GetAllActiveBoxes', function(data)
        for netId, info in pairs(data) do
            ActiveMusicBoxes[tostring(netId)] = {
                url = info.url,
                coords = vector3(info.coords.x, info.coords.y, info.coords.z),
                startTime = info.startTime,
                volume = info.volume
            }
        end
    end)
end)

CreateThread(function()
    while true do
        Wait(500) -- 检测间隔
        local ped = PlayerPedId()
        local myCoords = GetEntityCoords(ped)

        local closestBox = nil
        local closestDistance = nil

        for netId, data in pairs(ActiveMusicBoxes) do
            local distance = #(data.coords - myCoords)
            if distance <= Config.MusicBoxRange then
                if not closestDistance or distance < closestDistance then
                    closestDistance = distance
                    closestBox = { netId = netId, url = data.url, startTime = data.startTime, volume = data.volume }
                end
            end
        end

        -- 在音乐盒范围内
        if closestBox then
            if currentPlayingBox ~= closestBox.netId then
                -- 播放新音乐
                currentPlayingBox = closestBox.netId
                QBCore.Functions.TriggerCallback('rb-musicbox:server:getTime', function(serverTime)
                    local offset = serverTime - closestBox.startTime
                    SendNUIMessage({
                        action = "play",
                        url = closestBox.url,
                        offset = offset,
                        volume = 0  -- 由后面更新音量
                    })
                end)
            end
        else
            -- 离开所有音乐盒
            if currentPlayingBox then
                SendNUIMessage({ action = "stop" })
                currentPlayingBox = nil
            end
        end

        -- 根据距离不断设置音量以达到距离衰减的效果
        if currentPlayingBox then
            local boxData = ActiveMusicBoxes[currentPlayingBox]
            if boxData then
                local distance = #(boxData.coords - myCoords)
                local distanceRatio = math.max(0.0, 1.0 - (distance / Config.MusicBoxRange))
                local finalVolume = boxData.volume * distanceRatio

                -- 向 NUI 发送音量更新
                SendNUIMessage({
                    action = "setVolume",
                    volume = finalVolume
                })
            end
        end

        -- 自动回收自己的音乐盒
        if placedMusicbox then
            if ownedMusicBoxCoords and #(ownedMusicBoxCoords - myCoords) > Config.maxDis then
                if ownedMusicBoxNetID then
                    TriggerServerEvent("rb-musicbox:server:RemoveBox", ownedMusicBoxNetID)
                    QBCore.Functions.Notify("距离过远，音乐盒已自动回收", "error")
                end
            end
        end
    end
end)