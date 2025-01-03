local QBCore = exports['qb-core']:GetCoreObject()
local isPickingUp = false

local function startPickSodium(index)  -- 1
	local playerPed = PlayerPedId()
	if not isPickingUp then
		isPickingUp = true
		TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)
		QBCore.Functions.Progressbar("search_register", Lang:t("progressbar.collecting"), 10000, false, true, {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		}, {}, {}, {}, function() -- Done
			ClearPedTasks(playerPed)
			TriggerServerEvent('ps-drugprocessing:pickedUpSodiumHydroxide')  -- 2
			TriggerServerEvent('ps-drugprocessing:server:resetSodiumTimer', index)  -- 3
			QBCore.Functions.Notify("成功得到氢氧化钠", "success")
			isPickingUp = false
		end, function()
			ClearPedTasks(playerPed)
			TriggerServerEvent('ps-drugprocessing:server:retreatPickStateSodium', index)  -- 撤销已被采集的状态  -- 3
			isPickingUp = false
		end)
	end
end

RegisterNetEvent("ps-drugprocessing:pickSodium", function(targetEntity)  -- 4
	if isPickingUp then 
		QBCore.Functions.Notify("警告：不要尝试寻找漏洞", "warning")
		return
	end
	local playerPe3 = PlayerPedId()
	local playerCoords = GetEntityCoords(playerPe3)
	local coords = GetEntityCoords(targetEntity)
	if #(playerCoords-coords) > 1.5 then
		QBCore.Functions.Notify("您离的太远了", "primary")
		return
	end
	local floorCoordX = math.floor(coords.x)
	local nearbyObject3, nearbyID3
	for id, location in ipairs(Info.ItemLocation.Sodium) do  -- 5
		if floorCoordX == location then
			nearbyID3 = id
		end
	end
	if not nearbyID3 then 
		QBCore.Functions.Notify("它是不可用的", "primary")
		return
	end
	QBCore.Functions.TriggerCallback("ps-drugprocessing:server:applyForPickSodium", function()  -- 6
		startPickSodium(nearbyID3)
	end, nearbyID3)
end)
