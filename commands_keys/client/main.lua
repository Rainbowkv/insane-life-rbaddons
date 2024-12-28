-- local QBCore = exports['qb-core']:GetCoreObject()

-- QBCore.Functions.TriggerCallback('test:getplayers', function(players)
--     for _, v in pairs(players) do
--         menu4:AddButton({
--             label = Lang:t('info.id') .. v['id'] .. ' | ' .. v['name'],
--             value = v,
--             description = Lang:t('info.player_name'),
--             select = function(btn)
--                 local select = btn.Value -- get all the values from v!
--                 OpenPlayerMenus(select)  -- only pass what i select nothing else
--             end
--         })                               -- WORKS
--     end
-- end)
print("xixi")
local ped = PlayerPedId()
local currentHealth = GetEntityHealth(ped)
print(currentHealth)