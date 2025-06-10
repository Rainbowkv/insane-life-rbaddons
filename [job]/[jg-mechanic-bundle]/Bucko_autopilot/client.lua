local isAutopilotActive = false
local blip = nil
local STOP_DISTANCE = 20.0
local QBCore = exports['qb-core']:GetCoreObject()

local function showNotity(text, pType)
    TriggerEvent('ox_lib:notify', {
        title = '自动驾驶',
        description = text,
        type = pType -- 可选类型: success, error, info, warning
    })
end

local function StopAutopilot()
    isAutopilotActive = false  -- 先改标志，再清理，尽可能避免一些多线程冲突情况，不过这里发生了竞争后果也不严重
    blip = nil
    local playerPed = PlayerPedId()
    if IsPedInAnyVehicle(playerPed, false) then
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        ClearPedTasks(playerPed)
        SetVehicleBrake(vehicle, true)
        SetVehicleForwardSpeed(vehicle, 10.0)  -- 骤降到36km/h
        Wait(1500)
        SetEntityVelocity(vehicle, 0.0, 0.0, 0.0)
        Wait(100)
    else
        ClearPedTasks(playerPed)
    end
end

local function DriveToWaypoint(playerPed, vehicle, destination)
    CreateThread(function()  -- 判断抵达线程
        while isAutopilotActive do
            if not DoesBlipExist(blip) then  -- 通过blip消失与否，来判断是否抵达
                StopAutopilot()
                showNotity('已抵达目的地', 'success')
                break
            end

            Wait(100)
        end
    end)
    CreateThread(function()  -- 燃油监听线程
        while isAutopilotActive do
            if exports['LegacyFuel']:GetFuel(vehicle) < BuckoConfig.minFuel then  -- 
                StopAutopilot()
                showNotity('已退出，燃油过少', 'error')
                break
            end
            Wait(1000)
        end
    end)
    CreateThread(function()  -- 监听g键停止自动驾驶
        while isAutopilotActive do
            Wait(0)
            if IsControlJustReleased(0, 47) then
                showNotity('已退出，请接管', 'success')
                StopAutopilot()
                break
            end
        end
    end)
end

local function toggleAutoPilot(maxSpeed, data, slot)
    local playerPed = PlayerPedId()
    local dest = GetBlipInfoIdCoord(blip)

    if IsPedInAnyVehicle(playerPed, false) then
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        if GetPedInVehicleSeat(vehicle, -1) ~= playerPed then
            showNotity('请坐在主驾驶', 'error')
            isAutopilotActive = false
            return
        end
        if exports['LegacyFuel']:GetFuel(vehicle) < BuckoConfig.minFuel then
            showNotity('燃油过少, 开启失败', 'error')
            isAutopilotActive = false
            return
        end
        if maxSpeed > 160 then showNotity('检测最大速度设置过高，已进行调整', 'warning') end
        TriggerServerEvent('Bucko_autopilot:server:degradeItem', data.name, slot.slot, BuckoConfig.consume) -- 损耗耐久
        if data.name == BuckoConfig.normalChip then
            TaskVehicleDriveToCoordLongrange(playerPed, vehicle, dest.x, dest.y, dest.z, maxSpeed/3.6, 786603, STOP_DISTANCE)  -- 开启自动驾驶
        elseif data.name == BuckoConfig.illegalChip then
            TaskVehicleDriveToCoordLongrange(playerPed, vehicle, dest.x, dest.y, dest.z, maxSpeed/3.6, 786468 | 512, STOP_DISTANCE)  -- 开启自动驾驶
        end
        DriveToWaypoint(playerPed, vehicle, dest)  -- 监听自动驾驶是否到达的线程
        showNotity('已开启', 'success')
    else
        showNotity('您没有在载具中', 'error')
        isAutopilotActive = false
    end
end

RegisterNetEvent("Bucko_autopilot:client:autopilot", function(data, slot)
    if isAutopilotActive then
        StopAutopilot()
        showNotity('已退出, 请接管', 'success')
        return
    end
    blip = GetFirstBlipInfoId(8)
    if not DoesBlipExist(blip) then
        showNotity('请先设置导航点', 'error')
        return
    end
    local input = exports['qb-input']:ShowInput({
        header = "请输入最大巡航速度",
        submitText = "确认",
        inputs = {{
            text = "如:60 (单位 km/h)",
            name = "speed",
            type = "number",
            isRequired = true
        }}
    })
    if not input or not input.speed or tonumber(input.speed) == nil then
        showNotity("请输入一个有效的速度值", "error")
        return
    end
    if tonumber(input.speed) < 10 then
        showNotity("最大速度不能小于10km/h", "error")
        return 
    end
    local maxSpeed = tonumber(input.speed)
    -- 填补这里
    isAutopilotActive = true
    QBCore.Functions.Progressbar("open_exchange", "正在设置芯片...", 2500, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- 成功回调
        toggleAutoPilot(maxSpeed, data, slot)  -- km/h 转换为 m/s（GTA 内部单位）
    end, function() -- 失败回调
        -- 可选：玩家取消进度条后的操作
        isAutopilotActive = false
        showNotity('取消设置', 'error')
    end)
end)
