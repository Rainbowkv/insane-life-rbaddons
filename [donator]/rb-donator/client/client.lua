local showing = false
local coins = nil

function sendVehPhoneMsg(VehName)
	exports["lb-phone"]:SendNotification({
        title = "瑞文斯运营团队感谢您对社区的赞助",
        content = VehName.." 已送至新手公寓停车场",
    })
end

function clientCheckCoins(itemName, className)
    local cost = nil
    if className == 'vehicle' then
        cost = Config.vehicle_price[itemName]
    end
    if cost == nil then
        return false, "购买的物品种类不存在呀"
    end

    if coins < cost then
        return false, "赞助点不足呀"
    end
    return true, "客户端验证过关"
end

RegisterNetEvent("rb-donator:updateCoins", function(newCoins)
    coins = newCoins
end)

RegisterCommand("togglesponsor", function()
    if coins == nil then
        coins = lib.callback.await('rb-donator:GetCoins', false) or 0
    end
    showing = not showing
    SetNuiFocus(showing, showing)
    SendNUIMessage({
        type = "toggleUI",
        show = showing
    })

    if showing then
        SendNUIMessage({
            type = "updateProducts",
            products = {
                vehicles = Config.donator_vehicles,
                -- items = {
                --     { name = "超级急救包", image = "https://via.placeholder.com/300x150", points = 50 },
                --     { name = "高效能护甲", image = "https://via.placeholder.com/300x150", points = 75 },
                -- },
                -- others = {
                --     { name = "VIP 尊享一周", image = "https://via.placeholder.com/300x150", points = 500 },
                -- }
            }
        })
        -- 发送赞助点余额
        SendNUIMessage({
            type = "balanceUpdate",
            amount = coins
        })
    end
end, false)

RegisterKeyMapping("togglesponsor", "赞助界面", "keyboard", Config.keyBind)

RegisterNUICallback("rb-donator:focus", function(data, cb)
    SetNuiFocus(data.focus, data.focus)
    if not data.focus then
        showing = false
    end
    cb({})
end)

RegisterNUICallback("rb-donator:purchaseProduct", function(data, cb)
    local itemName = data.name
    local className = data.className
    -- 客户端先检查赞助点是否足够
    local clientResult, clientMsg = clientCheckCoins(itemName, className)
    if not clientResult then
        PlaySoundFrontend(-1, "ERROR", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
        lib.notify({ description = clientMsg, type = 'error', position = 'top', icon = 'fas fa-store' })
        -- 返回失败给前端
        cb({ success = false, message = clientMsg })
        return
    end

    -- 服务端再检查赞助点是否足够
    local result, msg = lib.callback.await("rb-donator:purchaseItem", false, itemName, className)
    if result then
        if className == 'vehicle' then
            sendVehPhoneMsg(itemName)
        end
        lib.notify({ description = msg, type = 'success', position = 'top', icon = 'fas fa-store' })
    else
        PlaySoundFrontend(-1, "ERROR", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
        lib.notify({ description = msg, type = 'error', position = 'top', icon = 'fas fa-store' })
    end
    -- 返回成功或失败给前端
    cb({ success = result, message = msg })
end)
