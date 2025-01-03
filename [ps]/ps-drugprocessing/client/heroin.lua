local QBCore = exports['qb-core']:GetCoreObject()
local isPickingUp, isProcessing = false, false

local function ProcessHeroin()
	isProcessing = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)
	QBCore.Functions.Progressbar("search_register", Lang:t("progressbar.processing"), 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
		TriggerServerEvent('ps-drugprocessing:processPoppyResin')

		local timeLeft = Config.Delays.HeroinProcessing / 1000
		while timeLeft > 0 do
			Wait(1000)
			timeLeft -= 1

			if #(GetEntityCoords(playerPed)-Config.CircleZones.HeroinProcessing.coords) > 4 then
				TriggerServerEvent('ps-drugprocessing:cancelProcessing')
				break
			end
		end
		ClearPedTasks(playerPed)
		isProcessing = false
	end, function()
		ClearPedTasks(playerPed)
		isProcessing = false
	end)
end

RegisterNetEvent('ps-drugprocessing:ProcessPoppy', function()
	local coords = GetEntityCoords(PlayerPedId(source))
	
	if #(coords-Config.CircleZones.HeroinProcessing.coords) < 5 then
		if not isProcessing then
			QBCore.Functions.TriggerCallback('ps-drugprocessing:validate_items', function(result)
				if result.ret then
					ProcessHeroin()
				else
					QBCore.Functions.Notify(Lang:t("error.no_item", {item = result.item}))
				end
			end, {poppyresin = Config.HeroinProcessing.Poppy})
		end
	end
end)

RegisterNetEvent("ps-drugprocessing:processHeroin",function()
	QBCore.Functions.TriggerCallback('ps-drugprocessing:validate_items', function(result)
		if result.ret then
			ProcessHeroin()
		else
			QBCore.Functions.Notify(Lang:t("error.no_item", {item = result.item}))
		end
	end, {poppyresin = Config.HeroinProcessing.Poppy})
end)

local function startPickHeroin(index)  -- 1
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
			TriggerServerEvent('ps-drugprocessing:pickedUpPoppy')  -- 2
			TriggerServerEvent('ps-drugprocessing:server:resetHeroinTimer', index)  -- 3
			isPickingUp = false
		end, function()
			ClearPedTasks(playerPed)
			TriggerServerEvent('ps-drugprocessing:server:retreatPickStateHeroin', index)  -- 撤销已被采集的状态  -- 3
			isPickingUp = false
		end)
	end
end

RegisterNetEvent("ps-drugprocessing:pickHeroin", function(targetEntity)  -- 1
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
	for id, location in ipairs(Info.ItemLocation.Heroin) do  -- 2
		if floorCoordX == location then
			nearbyID3 = id
		end
	end
	if not nearbyID3 then 
		QBCore.Functions.Notify("它是不可用的", "primary")
		return
	end
	QBCore.Functions.TriggerCallback("ps-drugprocessing:server:applyForPickHeroin", function()  -- 3
		startPickHeroin(nearbyID3)  -- 4
	end, nearbyID3)
end)