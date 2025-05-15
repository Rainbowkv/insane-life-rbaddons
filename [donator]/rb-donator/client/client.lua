local showing = false

RegisterCommand("togglesponsor", function()
    showing = not showing
    SetNuiFocus(showing, showing)
    SendNUIMessage({
        type = "toggleUI",
        show = showing
    })

    if showing then
        -- 可选：更新赞助车辆列表
        -- SendNUIMessage({
        --     type = "updateVehicles",
        --     vehicles = Config.donator_vehicles
        -- })
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
    end
end, false)

RegisterKeyMapping("togglesponsor", "赞助界面", "keyboard", Config.keyBind)

RegisterNUICallback("focus", function(data, cb)
    SetNuiFocus(data.focus, data.focus)
    if not data.focus then
        showing = false
    end
    cb({})
end)
