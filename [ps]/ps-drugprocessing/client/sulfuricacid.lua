local QBCore = exports['qb-core']:GetCoreObject()
local isPickingUp = false

local function startPickSulfuric(index)  -- 1
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
			TriggerServerEvent('ps-drugprocessing:pickedUpSulfuricAcid')  -- 2
			TriggerServerEvent('ps-drugprocessing:server:resetSulfuricTimer', index)  -- 3
			isPickingUp = false
		end, function()
			ClearPedTasks(playerPed)
			TriggerServerEvent('ps-drugprocessing:server:retreatPickStateSulfuric', index)  -- 撤销已被采集的状态  -- 3
			isPickingUp = false
		end)
	end
end

RegisterNetEvent("ps-drugprocessing:pickSulfuric", function(targetEntity)  -- 1
	if isPickingUp then 
		QBCore.Functions.Notify("警告：不要尝试寻找漏洞???", "warning")
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
	for id, location in ipairs(Info.ItemLocation.Sulfuric) do  -- 2
		if floorCoordX == location then
			nearbyID3 = id
		end
	end
	if not nearbyID3 then 
		QBCore.Functions.Notify("它是不可用的", "primary")
		return
	end
	QBCore.Functions.TriggerCallback("ps-drugprocessing:server:applyForPickSulfuric", function()  -- 3
		startPickSulfuric(nearbyID3)  -- 4
	end, nearbyID3)
end)