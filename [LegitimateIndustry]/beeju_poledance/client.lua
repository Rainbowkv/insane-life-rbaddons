local danceConfig = DanceConfig

local isDancing = false

local function startPoleDance(coord, animations)
    local playerPed = PlayerPedId()

    SetEntityCoords(playerPed, coord.x, coord.y, coord.z, false, false, false, true)

    local foundGround, zPos = GetGroundZFor_3dCoord(coord.x, coord.y, coord.z)
    if foundGround then
        SetEntityCoords(playerPed, coord.x, coord.y, zPos, false, false, false, true)
    end

    SetEntityHeading(playerPed, 0.0)

    local randomIndex = math.random(1, #animations)
    local selectedAnimation = animations[randomIndex]

    RequestAnimDict(selectedAnimation.dict)
    while not HasAnimDictLoaded(selectedAnimation.dict) do
        Citizen.Wait(0)
    end

    isDancing = true
    Citizen.CreateThread(function()
        while isDancing do
            if not IsEntityPlayingAnim(playerPed, selectedAnimation.dict, selectedAnimation.anim, 3) then
                TaskPlayAnim(playerPed, selectedAnimation.dict, selectedAnimation.anim, 8.0, -8.0, -1, 524288, 0, false, false, false)
            end
            Citizen.Wait(0)
        end
    end)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if isDancing then

            if IsControlJustReleased(0, danceConfig.StopKey) then
                isDancing = false
                ClearPedTasksImmediately(PlayerPedId())
            end
        else
            local playerCoords = GetEntityCoords(PlayerPedId())

            for _, poleData in ipairs(danceConfig.PoleData) do
                local poleCoord = poleData.coordinates
                local distance = #(playerCoords - poleCoord)

                if distance < 1.5 then
                    DrawText3D(poleCoord.x, poleCoord.y, poleCoord.z + 1.0, "按 [E] 跳舞!")
                    if IsControlJustReleased(0, danceConfig.StartKey) then
                        startPoleDance(poleCoord, poleData.animations)
                    end
                end
            end
        end
    end
end)

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 370
    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 68)
end