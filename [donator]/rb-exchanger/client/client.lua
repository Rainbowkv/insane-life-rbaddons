local pedModel = `a_m_m_business_01`
local pedCoords = vector4(-286.2, -1058.24, 27.21, 245.83)
local QBCore = exports['qb-core']:GetCoreObject()

-- local function openExchanger()
--     lib.callback('exchange:getListings', false, function(data)
--         SetNuiFocus(true, true)
--         SendNUIMessage({
--             action = 'open',
--             items = data
--         })
--     end)
-- end

local function openExchanger()
    QBCore.Functions.Progressbar("open_exchange", "正在打开交易所...", 2000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- 成功回调
        lib.callback('exchange:getListings', false, function(data)
            SetNuiFocus(true, true)
            SendNUIMessage({
                action = 'open',
                items = data
            })
        end)
    end, function() -- 失败回调
        -- 可选：玩家取消进度条后的操作
        TriggerEvent('QBCore:Notify', '操作已取消', 'error')
    end)
end

RegisterNUICallback('closeUI', function(_, cb)
    SetNuiFocus(false, false)
    cb({})
end)

RegisterNUICallback("submitSell", function(data, cb)
    local amount = tonumber(data.amount)
    local price = tonumber(data.price)
    -- 校验是否为正整数
    if not amount or not price or amount <= 0 or price <= 0 or amount % 1 ~= 0 or price % 1 ~= 0 then
        QBCore.Functions.Notify("赞助点和美金都必须为正整数", 'error')
    else
        TriggerServerEvent("exchange:trySell", data.amount, data.price)
    end
    SetNuiFocus(false, false)
    cb(false)  -- 直接无条件关闭前端页面
end)

RegisterNUICallback("submitBuy", function(data, cb)
    TriggerServerEvent("exchange:tryBuy", data.citizenid, data.amount, data.price)
    SetNuiFocus(false, false)
    cb(false)  -- 直接无条件关闭前端页面
end)

CreateThread(function()
    RequestModel(pedModel)
    while not HasModelLoaded(pedModel) do Wait(0) end

    local ped = CreatePed(0, pedModel, pedCoords.x, pedCoords.y, pedCoords.z - 1.0, pedCoords.w, false, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)

    exports.ox_target:addLocalEntity(ped, {
        {
            name = 'player_exchange',
            icon = 'fa-solid fa-handshake',
            label = '玩家交易所',
            onSelect = function()
                openExchanger()
            end,
	    distance = 1.5
        }
    })
end)
