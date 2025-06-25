local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('rb-ranking:client:openLeaderboard', function()
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = "showLeaderboard",
        tab = tab or "forbes"
    })
end)

RegisterNUICallback('rb-ranking:nui:closeLeaderboard', function(_, cb)
    SetNuiFocus(false, false)
    cb({})
end)

RegisterNUICallback('rb-ranking:nui:getAllLeaderboards', function(_, cb)
    local tabs = {}

    for id, board in pairs(Config.Leaderboards) do
        tabs[id] = {
            label = board.label
        }
    end

    cb(tabs)
end)

RegisterNUICallback('rb-ranking:nui:getLeaderboardData', function(data, cb)
    local boardId = data.id or "forbes"
    QBCore.Functions.TriggerCallback('rb-ranking:server:getData', function(result)
        cb(result)
    end, boardId)
end)

CreateThread(function()
    local model = Config.ped.model
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(100)
    end
    local ped = CreatePed(4, model, Config.ped.coords, Config.ped.handing, false, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CLIPBOARD", 0, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)

    exports.ox_target:addLocalEntity(ped, {
        {
            name = 'open_forbes',
            icon = 'fa-solid fa-chart-line',
            label = '名人榜',
            onSelect = function(data)
                TriggerEvent('rb-ranking:client:openLeaderboard', data.entity)
            end
        },
        {
            name = 'opt_in_ranking',
            icon = 'fa-solid fa-pen-to-square',
            label = '我要上榜',
            onSelect = function()
                local options = {}

                for id, board in pairs(Config.Leaderboards) do
                    table.insert(options, {
                        title = board.label,
                        description = "报名该排行榜",
                        icon = "fa-trophy",
                        onSelect = function()
                            TriggerServerEvent("rb-ranking:server:optInLeaderboard", id)
                        end
                    })
                end

                lib.registerContext({
                    id = 'leaderboard_opt_in',
                    title = '选择你要报名的排行榜',
                    options = options
                })

                lib.showContext('leaderboard_opt_in')
            end
        }
    })
end)