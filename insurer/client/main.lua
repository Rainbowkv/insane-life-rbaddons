local QBCore = exports['qb-core']:GetCoreObject()
local currentInsure, playerData
local pedSpawned = false
local listen = false
local insurePed = {}
local NewZones = {}
local playerAllVehicles = {}

local function createBlips()
    if pedSpawned then return end

    for insurer in pairs(Config.Locations) do
        if Config.Locations[insurer]['showblip'] then
            local StoreBlip = AddBlipForCoord(Config.Locations[insurer]['coords']['x'], Config.Locations[insurer]['coords']['y'], Config.Locations[insurer]['coords']['z'])
            SetBlipSprite(StoreBlip, Config.Locations[insurer]['blipsprite'])
            SetBlipScale(StoreBlip, Config.Locations[insurer]['blipscale'])
            SetBlipDisplay(StoreBlip, 4)
            SetBlipColour(StoreBlip, Config.Locations[insurer]['blipcolor'])
            SetBlipAsShortRange(StoreBlip, true)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(Config.Locations[insurer]['label'])
            EndTextCommandSetBlipName(StoreBlip)
        end
    end
end

local function createPeds()
    if pedSpawned then return end
    local defaultTargetIcon = 'fas fa-shopping-cart'
    local defaultTargetLabel = 'Open Shop'

    for k, v in pairs(Config.Locations) do
        if not v.ped then
            exports['qb-target']:AddCircleZone(k, vector3(v.coords.x, v.coords.y, v.coords.z), 1.5, {
                name = k,
                debugPoly = false,
                useZ = true
            }, {
                options = {
                    {
                        label = v.targetLabel or defaultTargetLabel,
                        icon = v.targetIcon or defaultTargetIcon,
                        item = v.requiredItem,
                        type = 'server',
                        event = 'insurer:server:insurance',  -- 注册事件
                        shop = k,
                        job = v.requiredJob,
                        gang = v.requiredGang
                    }
                },
                distance = 2.0
            })
        else
            local current = type(v['ped']) == 'number' and v['ped'] or joaat(v['ped'])
            RequestModel(current)
            while not HasModelLoaded(current) do Wait(0) end
            insurePed[k] = CreatePed(0, current, v['coords'].x, v['coords'].y, v['coords'].z - 1, v['coords'].w, false, false)
            TaskStartScenarioInPlace(insurePed[k], v['scenario'], 0, true)
            FreezeEntityPosition(insurePed[k], true)
            SetEntityInvincible(insurePed[k], true)
            SetBlockingOfNonTemporaryEvents(insurePed[k], true)
            if Config.UseTarget then
                exports['qb-target']:AddTargetEntity(insurePed[k], {
                    options = {
                        {
                            label = v.targetLabel or defaultTargetLabel,
                            icon = v.targetIcon or defaultTargetIcon,
                            item = v.requiredItem,
                            type = 'server',
                            event = 'insurer:server:insurance',    -- 注册事件
                            shop = k,
                            job = v.requiredJob,
                            gang = v.requiredGang
                        }
                    },
                    distance = 2.0
                })
            end
        end
    end
    pedSpawned = true
end

local function deletePeds()
    if not pedSpawned then return end
    for _, v in pairs(insurePed) do
        DeletePed(v)
    end
    pedSpawned = false
end

local function listenForControl()  -- 在区域内时，监听E按键。与下面的线程同时执行，如果出了区域，下面的线程会隐藏文本，从而不可以交互
    if listen then return end
    CreateThread(function()
        listen = true
        while listen do
            if IsControlJustPressed(0, 38) then -- E
                exports['qb-core']:KeyPressed()
                TriggerEvent('insurer:client:openInsurance', {})
                listen = false
                break
            end
            Wait(0)
        end
    end)
end

local function accessCheck(inputValue, requiredValue)
    local playerJob = inputValue.job.name
    local playerJobGrade = inputValue.job.grade.level
    local playerGang = inputValue.gang.name
    local playerGangGrade = inputValue.gang.grade.level
    local shopData = Config.Locations[requiredValue]

    local jobCheck = false
    local gangCheck = false
    local itemCheck = false

    if shopData.requiredJob then
        if type(shopData.requiredJob) == 'table' then
            for job, grade in pairs(shopData.requiredJob) do
                if playerJob == job and playerJobGrade >= grade then
                    jobCheck = true
                    break
                end
            end
        elseif playerJob == shopData.requiredJob then
            jobCheck = true
        end
    else
        jobCheck = true
    end

    if shopData.requiredGang then
        if type(shopData.requiredGang) == 'table' then
            for gang, grade in pairs(shopData.requiredGang) do
                if playerGang == gang and playerGangGrade >= grade then
                    gangCheck = true
                    break
                end
            end
        elseif playerGang == shopData.requiredGang then
            gangCheck = true
        end
    else
        gangCheck = true
    end

    if shopData.requiredItem then
        itemCheck = exports['qb-inventory']:HasItem(shopData.requiredItem)
    else
        itemCheck = true
    end

    return jobCheck and gangCheck and itemCheck
end

local function CheckPlayers(vehicle)  -- 这里删除的载具
    for i = -1, 5, 1 do
        local seat = GetPedInVehicleSeat(vehicle, i)
        if seat then
            TaskLeaveVehicle(seat, vehicle, 0)
        end
    end
    Wait(1500)
    QBCore.Functions.DeleteVehicle(vehicle)
end

-- qb-menu
function InsuranceMenu(vehicles)
    -- 检查 vehicles 是否为 nil 或为空
    if not vehicles or #vehicles == 0 then
        local insuranceMenu = {
            {
                header = Lang:t('menu.insurance_menu_header'),
                isMenuHeader = true
            },
            {
                header = Lang:t('menu.close_menu'),
                txt = '',
                params = {
                    event = 'qb-menu:client:closeMenu'
                }
            }
        }
        exports['qb-menu']:openMenu(insuranceMenu)
        return
    end

    local insuranceMenu = {
        {
            header = Lang:t('menu.insurance_menu_header'),
            isMenuHeader = true
        }
    }
    for _, v in pairs(vehicles) do
        insuranceMenu[#insuranceMenu + 1] = {
            -- header = v.name.." "..v.plate,
            header = v.plate,
            params = {
                event = 'qb-garages:client:compensateEntityFromPlate',
                args = {
                    plate = v.plate
                }
            }
        }
    end

    insuranceMenu[#insuranceMenu + 1] = {
        header = Lang:t('menu.close_menu'),
        txt = '',
        params = {
            event = 'qb-menu:client:closeMenu'
        }
    }
    exports['qb-menu']:openMenu(insuranceMenu)
end

-- Events

RegisterNetEvent('insurer:client:openInsurance', function()
    QBCore.Functions.TriggerCallback('insurer:server:GetPlayerVehicles', function(vehicles)
        InsuranceMenu(vehicles)
    end)
end)

RegisterNetEvent("qb-garages:client:compensateEntityFromPlate", function(data)
    TriggerServerEvent("qb-garages:server:compensateEntityFromPlate", data.plate)
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    playerData = QBCore.Functions.GetPlayerData()
    createBlips()
    createPeds()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    playerData = {}
    deletePeds()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(jobInfo)
    playerData.job = jobInfo
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    playerData = QBCore.Functions.GetPlayerData()
    createBlips()
    createPeds()
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    deletePeds()
end)

if not Config.UseTarget then  -- 监听是否在任意一个区域中，combo:onPlayerInOut是死循环不断检测
    CreateThread(function()
        for shop in pairs(Config.Locations) do
            NewZones[#NewZones + 1] = CircleZone:Create(vector3(Config.Locations[shop]['coords']['x'], Config.Locations[shop]['coords']['y'], Config.Locations[shop]['coords']['z']), Config.Locations[shop]['radius'] or 1.5, {
                useZ = true,
                debugPoly = false,
                name = shop,
            })
        end

        local combo = ComboZone:Create(NewZones, { name = 'RandomZOneName', debugPoly = false })
        combo:onPlayerInOut(function(isPointInside, _, zone)  -- 这个函数调用就是死循环，不断检测
            if isPointInside then
                if accessCheck(playerData, zone.name) then
                    currentInsure = zone.name
                    exports['qb-core']:DrawText('[E] 保险赔付')
                    listenForControl()
                end
            else
                exports['qb-core']:HideText()
                listen = false
            end
        end)
    end)
end