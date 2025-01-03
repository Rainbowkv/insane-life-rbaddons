local QBCore = exports['qb-core']:GetCoreObject()
local isPickingUp = false

-- Chemical Menu Trigger & Menu Button Triggers --
local function createChemicalMenu()
    local chemMenu = {
        {
            isHeader = true,
            header = Lang:t("menu.chemMenuHeader")
        },
        {
            header = Lang:t("items.hydrochloric_acid"),
            txt = Lang:t("menu.chemicals"),
			params = {
                event = "ps-drugprocessing:hydrochloric_acid",
            }
        },
        {
            header = Lang:t("items.sodium_hydroxide"),
            txt = Lang:t("menu.chemicals"),
			params = {
                event = "ps-drugprocessing:sodium_hydroxide",
            }
        },
        {
            header = Lang:t("items.sulfuric_acid"),
            txt = Lang:t("menu.chemicals"),
			params = {
                event = "ps-drugprocessing:sulfuric_acid",
            }
        },
        {
			header = Lang:t("items.lsa"),
            txt = Lang:t("menu.chemicals"),
			params = {
                event = "ps-drugprocessing:lsa",
            }
        },
        {
            header = Lang:t("menu.close"),
			txt = Lang:t("menu.closetxt"),
			params = {
                event = exports['qb-menu']:closeMenu(),
            }
        },
    }
    exports['qb-menu']:openMenu(chemMenu)
end
RegisterNetEvent('ps-drugprocessing:chemicalmenu', createChemicalMenu)

--------------------------------------------------------------------
local function process_hydrochloric_acid()
	isProcessing = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)

	QBCore.Functions.Progressbar("search_register", Lang:t("progressbar.processing"), 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
		TriggerServerEvent('ps-drugprocessing:processHydrochloric_acid')

		local timeLeft = Config.Delays.thionylchlorideProcessing / 1000
		while timeLeft > 0 do
			Wait(1000)
			timeLeft -= 1
			if #(GetEntityCoords(playerPed)-Config.CircleZones.ChemicalsConvertionMenu.coords) > 4 then
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

local function process_lsa()
	isProcessing = true
	local playerPed = PlayerPedId()
	
	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)
	QBCore.Functions.Progressbar("search_register", Lang:t("progressbar.processing"), 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
		TriggerServerEvent('ps-drugprocessing:process_lsa')

		local timeLeft = Config.Delays.thionylchlorideProcessing / 1000
		while timeLeft > 0 do
			Wait(1000)
			timeLeft -= 1
			if #(GetEntityCoords(playerPed)-Config.CircleZones.ChemicalsConvertionMenu.coords) > 4 then
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

local function process_sulfuric_acid()
	isProcessing = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)
	QBCore.Functions.Progressbar("search_register", Lang:t("progressbar.processing"), 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
		TriggerServerEvent('ps-drugprocessing:processprocess_sulfuric_acid')

		local timeLeft = Config.Delays.thionylchlorideProcessing / 1000
		while timeLeft > 0 do
			Wait(1000)
			timeLeft -= 1
			if #(GetEntityCoords(playerPed)-Config.CircleZones.ChemicalsConvertionMenu.coords) > 4 then
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

local function process_sodium_hydroxide()
	isProcessing = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)
	QBCore.Functions.Progressbar("search_register", Lang:t("progressbar.processing"), 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
		TriggerServerEvent('ps-drugprocessing:processsodium_hydroxide')

		local timeLeft = Config.Delays.thionylchlorideProcessing / 1000
		while timeLeft > 0 do
			Wait(1000)
			timeLeft -= 1
			if #(GetEntityCoords(playerPed)-Config.CircleZones.ChemicalsConvertionMenu.coords) > 4 then
				TriggerServerEvent('ps-drugprocessing:cancelProcessing')
				break
			end
		end
		ClearPedTasks(PlayerPedId())
		isProcessing = false
	end, function()
		ClearPedTasks(PlayerPedId())
		isProcessing = false
	end)
end

RegisterNetEvent("ps-drugprocessing:hydrochloric_acid", function()
    QBCore.Functions.TriggerCallback('ps-drugprocessing:validate_items', function(result)
		if result then
			process_hydrochloric_acid()
		else
			QBCore.Functions.Notify(Lang:t("error.no_chemicals"), 'error')
		end
	end, {chemicals = 1})
end)

RegisterNetEvent("ps-drugprocessing:lsa", function()
    QBCore.Functions.TriggerCallback('ps-drugprocessing:validate_items', function(result)
		if result then
			process_lsa()
		else
			QBCore.Functions.Notify(Lang:t("error.no_chemicals"), 'error')
		end
	end, {chemicals = 1})
end)

RegisterNetEvent("ps-drugprocessing:sulfuric_acid", function()
    QBCore.Functions.TriggerCallback('ps-drugprocessing:validate_items', function(result)
		if result then
			process_sulfuric_acid()
		else
			QBCore.Functions.Notify(Lang:t("error.no_chemicals"), 'error')
		end
	end, {chemicals = 1})
end)

RegisterNetEvent("ps-drugprocessing:sodium_hydroxide", function()
    QBCore.Functions.TriggerCallback('ps-drugprocessing:validate_items', function(result)
		if result then
			process_sodium_hydroxide()
		else
			QBCore.Functions.Notify(Lang:t("error.no_chemicals"), 'error')
		end
	end, {chemicals=1})
end)

local function startPickChemicals(index)
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
			TriggerServerEvent('ps-drugprocessing:pickedUpChemicals')
			TriggerServerEvent('ps-drugprocessing:server:resetChemicalsTimer', index)  -- 3
			isPickingUp = false
		end, function()
			ClearPedTasks(playerPed)
			TriggerServerEvent('ps-drugprocessing:server:retreatPickStateChemicals', index)  -- 撤销已被采集的状态
			isPickingUp = false
		end)
	end
end

RegisterNetEvent("ps-drugprocessing:pickChemicals", function(targetEntity)
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
	for id, location in ipairs(Info.ItemLocation.Chemicals) do
		if floorCoordX == location then
			nearbyID3 = id
		end
	end
	if not nearbyID3 then 
		QBCore.Functions.Notify("它是不可用的", "primary")
		return
	end
	QBCore.Functions.TriggerCallback("ps-drugprocessing:server:applyForPickChemicals", function()
		startPickChemicals(nearbyID3)
	end, nearbyID3)
end)