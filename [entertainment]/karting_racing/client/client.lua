local QBCore = exports['qb-core']:GetCoreObject()
local hasKart = false
local currentKart = nil
local garagePed = nil
local raceVeh = nil

local function updateKartPedTarget(ped)
    exports.ox_target:removeLocalEntity(ped) -- 清除旧交互

    local options = {}

    if hasKart then
        options[#options + 1] = {
            label = '归还卡丁车',
            icon = 'fas fa-undo',
            event = 'karting:client:returnKart',
            distance = 1.5
        }
    else
        options[#options + 1] = {
            label = '取出卡丁车',
            icon = 'fas fa-flag-checkered',
            event = 'karting:client:selectPracticeKart',
            distance = 1.5
        }
        options[#options + 1] = {
            label = '参加比赛',
            icon = 'fas fa-flag-checkered',
            event = 'karting:client:selectRacingKart',
            distance = 1.5
        }
        options[#options + 1] = {
            label = '圈速排行榜',
            icon = 'fas fa-flag-checkered',
            event = 'karting:client:getLeaderboard',
            distance = 1.5
        }
    end

    exports.ox_target:addLocalEntity(ped, options)
end

local function DrawText(text)
    SetTextFont(0)
    SetTextScale(1.0, 1.0)
    SetTextColour(255, 255, 255, 255)
    SetTextCentre(true)
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(0.5, 0.4)
end

local disableControls = false
local function DisableKartingControls(enable)
    disableControls = enable
    if disableControls then
        CreateThread(function()
            while disableControls do
                Wait(0)
                -- 禁止下车
                DisableControlAction(0, 75, true)  -- EXIT VEHICLE
                DisableControlAction(27, 75, true)

                -- 禁止开枪/切枪/瞄准
                DisablePlayerFiring(PlayerId(), true)
                DisableControlAction(0, 24, true)  -- ATTACK
                DisableControlAction(0, 25, true)  -- AIM
                DisableControlAction(0, 37, true)  -- SELECT WEAPON
                DisableControlAction(0, 45, true)  -- RELOAD
            end
        end)
    end
end

-- 跑圈追踪
local currentCheckpoint = 1
local currentLap = 1
local totalCheckpoints = #Config.checkPoints
local lapStartTime = 0
local raceActive = false
local rank = 1
local total = 1
local BestLapTime = nil  -- 本次回国最快单圈

function ShowLapCompleted(lap, time)
    TriggerEvent('ox_lib:notify', {
        title = '圈数完成',
        description = '第 ' .. lap .. ' 圈完成，用时：' .. time .. ' 秒',
        type = 'inform'
    })
end

function FinishRace(bestLapTime)
    CreateThread(function()
        local displayTime = 5000 -- 显示 5 秒
        local startTime = GetGameTimer()
        while GetGameTimer() - startTime < displayTime do
            Wait(0)
            DrawText('你已完成所有圈数，感谢参赛！🏁')
        end
        -- 更新最快圈
        if BestLapTime  == nil then
            -- 从数据库查询最短成绩并缓存至BestLapTime
            lib.callback('karting:server:getBestLapTime', false, function(dbBestLapTime)
                if dbBestLapTime == nil or bestLapTime < dbBestLapTime then
                    -- 客户端缓存
                    BestLapTime = bestLapTime
                    -- 更新数据库
                    TriggerServerEvent('karting:server:updateBestLapTime', BestLapTime)
                else
                    BestLapTime = dbBestLapTime -- 缓存已有数据
                end
            end)
        elseif bestLapTime < BestLapTime then
            BestLapTime = bestLapTime
            -- 更新数据库
            TriggerServerEvent('karting:server:updateBestLapTime', BestLapTime)
        end
        -- 删除比赛车辆
        if raceVeh and DoesEntityExist(raceVeh) then
            DeleteVehicle(raceVeh)
            raceVeh = nil
        end
        DisableKartingControls(false)
        TriggerServerEvent('karting:server:updateFinishedPlayer')  -- 通知服务器自己已完成
    end)
end

function DrawRaceHUD(currentLap, totalLaps, currentLapTime, pRank, pTotal, bestLapTime)
    local text = string.format(
        "圈数: %d / %d    |    当前圈用时: %.3fs    |    排名: %d / %d    |    最快圈速: %.3fs",
        currentLap, totalLaps, currentLapTime, pRank, pTotal, bestLapTime
    )

    SetTextFont(0)
    SetTextScale(0.5, 0.5)
    SetTextCentre(true)
    SetTextOutline()
    SetTextColour(255, 255, 255, 255)
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(0.5, 0.95) -- 中下方位置（x=0.5, y=0.95）
end

function StartLapTracking()
    currentCheckpoint = 1
    currentLap = 1
    lapStartTime = GetGameTimer()
    currentLapTime = 0.0
    local bestLapTime = nil  -- 本次比赛最快单圈
    raceActive = true

    -- HUD 绘制线程
    CreateThread(function()
        while raceActive do
            Wait(0)
            local now = GetGameTimer()
            currentLapTime = (now - lapStartTime) / 1000.0

            DrawRaceHUD(currentLap, Config.totalLaps, currentLapTime, rank, total, bestLapTime or 0.0)
        end
        local displayTime = 5000 -- 多显示 5 秒
        local startTime = GetGameTimer()
        while GetGameTimer() - startTime < displayTime do
            Wait(0)
            DrawRaceHUD(currentLap, Config.totalLaps, currentLapTime, rank, total, bestLapTime or 0.0)
        end
    end)

    -- 检查点追踪线程
    CreateThread(function()
        while raceActive do
            Wait(0)

            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            local nextCheckpoint = Config.checkPoints[currentCheckpoint]
            local dist = #(playerCoords - nextCheckpoint)

            -- 如果玩家接近当前目标点
            if dist < Config.checkPointRadius then
                currentCheckpoint += 1
                TriggerServerEvent('karting:server:updateCheckpoint', lap, checkpoint)
                -- 如果已到最后一个检查点
                if currentCheckpoint > totalCheckpoints then
                    currentCheckpoint = 1
                    local finishedLapTime = (GetGameTimer() - lapStartTime) / 1000.0
                    lapStartTime = GetGameTimer()

                    -- 更新最佳圈速
                    if not bestLapTime or finishedLapTime < bestLapTime then
                        bestLapTime = finishedLapTime
                    end

                    -- ✅ 通知客户端当前圈完成
                    ShowLapCompleted(currentLap, finishedLapTime)
                    currentLap += 1

                    -- ✅ 若完成所有圈，结束比赛
                    if currentLap > Config.totalLaps then
                        raceActive = false
                        FinishRace(bestLapTime)
                        break
                    end
                end
            end

            -- ✅ 可视化下一个检查点（可选）
            DrawMarker(1, nextCheckpoint.x, nextCheckpoint.y, nextCheckpoint.z - 1.0,
                0, 0, 0, 0, 0, 0, 4.0, 4.0, 1.5, 0, 120, 255, 120, false, false, 2, false, nil, nil, false)
        end
    end)
end
-- 

RegisterNetEvent('karting:client:spawnKart', function(data)
    local model = data.model
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local heading = GetEntityHeading(playerPed)
    local hash = GetHashKey(model)

    RequestModel(hash)
    while not HasModelLoaded(hash) do Wait(50) end

    local vehicle = CreateVehicle(hash, coords.x, -2131.15, coords.z, heading, true, false)
    TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
    DisableKartingControls(true)  -- 禁用武器 + 禁止下车
    SetVehicleNumberPlateText(vehicle, "KART")

    hasKart = true
    currentKart = vehicle
    updateKartPedTarget(garagePed) -- 👈 更新交互
end)

RegisterNetEvent('karting:client:returnKart', function()
    if currentKart and DoesEntityExist(currentKart) then
        DeleteVehicle(currentKart)
    end
    DisableKartingControls(false)
    hasKart = false
    currentKart = nil
    updateKartPedTarget(garagePed) -- 👈 更新交互
    lib.notify({ type = 'success', description = '已归还卡丁车' })
end)

RegisterNetEvent('karting:client:selectPracticeKart', function()
    lib.callback('karting:server:checkLicense', false, function(result)
        if not result.basic and not result.advanced then
            lib.notify({ type = 'error', description = '你没有赛车驾照' })
            return
        end

        local options = {
            {
                title = '基础卡丁车',
                description = '适合练习的车辆',
                icon = 'car',
                event = 'karting:client:spawnKart',
                args = { model = Config.basicKartingCar },
            },
            {
                title = '竞速卡丁车',
                description = '更快的卡丁车',
                icon = 'car-side',
                event = 'karting:client:spawnKart',
                args = { model = Config.advancedKartingCar },
                disabled = not result.advanced
            }
        }

        lib.registerContext({
            id = 'kart_select_menu',
            title = '选择卡丁车',
            options = options,
        })

        lib.showContext('kart_select_menu')
    end)
end)

RegisterNetEvent('karting:client:selectRacingKart', function()
    lib.callback('karting:server:checkLicense', false, function(result)
        if not result.basic and not result.advanced then
            lib.notify({ type = 'error', description = '你没有赛车驾照' })
            return
        end

        local options = {
            {
                title = '基础卡丁车',
                description = '适合练习的车辆',
                icon = 'car',
                event = 'karting:client:joinRace',
                args = { model = Config.basicKartingCar },
            },
            {
                title = '竞速卡丁车',
                description = '更快的卡丁车',
                icon = 'car-side',
                event = 'karting:client:joinRace',
                args = { model = Config.advancedKartingCar },
                disabled = not result.advanced
            }
        }

        lib.registerContext({
            id = 'kart_select_menu',
            title = '选择参赛卡丁车',
            options = options,
        })

        lib.showContext('kart_select_menu')
    end)
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    if currentKart and DoesEntityExist(currentKart) then
            DeleteVehicle(currentKart)
    end
    if raceVeh and DoesEntityExist(raceVeh) then
            DeleteVehicle(raceVeh)
    end
end)

RegisterNetEvent('karting:client:joinRace', function(data)
    TriggerServerEvent('karting:server:joinQueue', data.model)
end)

RegisterNetEvent('karting:client:preparePlayerForRace', function(vehMod, startVec, remainingCountdownTime)
    RequestModel(vehMod)
    while not HasModelLoaded(vehMod) do Wait(0) end

    local coords = vector3(startVec.x, startVec.y, startVec.z)
    local heading = startVec.w

    raceVeh = CreateVehicle(vehMod, coords, heading, true, false)
    SetEntityHeading(raceVeh, heading)
    TaskWarpPedIntoVehicle(PlayerPedId(), raceVeh, -1)

    FreezeEntityPosition(raceVeh, true) -- 冻结赛车
    DisableKartingControls(true)  -- 禁用武器 + 禁止下车
    TriggerEvent('ox_lib:notify', { description = '你已就位，请等待比赛开始...', type = 'inform' })
    TriggerEvent('karting:client:startCountdown', '等待其它市民加入', remainingCountdownTime)
end)

RegisterNetEvent('karting:client:startCountdown', function(text, remainingCountdownTime)
    -- 启动倒计时显示
    local timeLeft = remainingCountdownTime
    if timeLeft > 0 then
        countdownActive = true
        CreateThread(function()
            while timeLeft > 0 do
                Wait(1000)
                timeLeft -= 1
            end
            countdownActive = false
        end)

        CreateThread(function()
            while countdownActive do
                Wait(0)
                DrawText(text .. ": ~b~" .. timeLeft .. "~s~ 秒")
            end
        end)
    end
end)

RegisterNetEvent('karting:client:beginRace', function()
    local ped = PlayerPedId()
    if not IsPedInAnyVehicle(ped, false) then return end

    local veh = GetVehiclePedIsIn(ped, false)
    FreezeEntityPosition(veh, false) -- 解冻车辆，允许操作
    SetVehicleEngineOn(veh, true, true, false)
    CreateThread(function()
        local displayTime = 2000 -- 显示 2 秒
        local startTime = GetGameTimer()
        while GetGameTimer() - startTime < displayTime do
            Wait(0)
            DrawText('比赛开始！冲鸭！！🏁') -- 你自定义的绘制函数
        end
    end)
    -- ✅ 初始化客户端比赛状态
    StartLapTracking()
end)

RegisterNetEvent('karting:client:updateRank', function(pRank, pTotal)
    rank = pRank
    total = pTotal
end)

RegisterNetEvent('karting:client:showLeaderboard', function(data)
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = 'showLeaderboard',
        data = data
    })
end)

RegisterNUICallback('karting_racing:closeLeaderboard', function(_, cb)
    SetNuiFocus(false, false)
    cb({})
end)

RegisterNetEvent('karting:client:getLeaderboard', function(pRank, pTotal)
    QBCore.Functions.Progressbar("open_exchange", "正在打开排行榜...", 2000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- 成功回调
        TriggerServerEvent('karting:server:getLeaderboard')
    end, function() -- 失败回调
        -- 可选：玩家取消进度条后的操作
        TriggerEvent('QBCore:Notify', '操作已取消', 'error')
    end)
end)

RegisterNetEvent('karting:client:updateBestLapTime', function(pBestLapTime)
    BestLapTime = pBestLapTime
end)

CreateThread(function()
    RequestModel(Config.garagePed.model)
    while not HasModelLoaded(Config.garagePed.model) do
        Wait(50)
    end
    local ped = CreatePed(0, Config.garagePed.model, Config.garagePed.coords.x, Config.garagePed.coords.y, Config.garagePed.coords.z - 1.0, Config.garagePed.coords.w, false, true)
    garagePed = ped
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)

    updateKartPedTarget(garagePed) -- 👈 更新交互
end)