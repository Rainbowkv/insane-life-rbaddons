local QBCore = exports['qb-core']:GetCoreObject()
local isPickingUp, isProcessing = false, false

local function LoadAnimationDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(1)
    end
end

local function OpenDoorAnimation()
    local ped = PlayerPedId()
    LoadAnimationDict("anim@heists@keycard@") 
    TaskPlayAnim(ped, "anim@heists@keycard@", "exit", 5.0, 1.0, -1, 16, 0, 0, 0, 0)
    Wait(400)
    ClearPedTasks(ped)
end

local function EnterCWarehouse()
    local ped = PlayerPedId()
    OpenDoorAnimation()
    CWarehouse = true
    Wait(500)
    DoScreenFadeOut(250)
    Wait(250)
    SetEntityCoords(ped, Config.CokeLab["exit"].coords.x, Config.CokeLab["exit"].coords.y, Config.CokeLab["exit"].coords.z - 0.98)
    SetEntityHeading(ped, Config.CokeLab["exit"].coords.w)
    Wait(1000)
    DoScreenFadeIn(250)
end

local function ExitCWarehouse()
    local ped = PlayerPedId()
    OpenDoorAnimation()
    CWarehouse = true
    Wait(500)
    DoScreenFadeOut(250)
    Wait(250)
    SetEntityCoords(ped, Config.CokeLab["enter"].coords.x, Config.CokeLab["enter"].coords.y, Config.CokeLab["enter"].coords.z - 0.98)
    SetEntityHeading(ped, Config.CokeLab["enter"].coords.w)
    Wait(1000)
    DoScreenFadeIn(250)
	CWarehouse = false
end

local function ProcessCoke()
	isProcessing = true
	local playerPed = PlayerPedId()
	
	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)

	QBCore.Functions.Progressbar("search_register", Lang:t("progressbar.processing"), 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
		TriggerServerEvent('ps-drugprocessing:processCocaLeaf')

		local timeLeft = Config.Delays.CokeProcessing / 1000
		while timeLeft > 0 do
			Wait(1000)
			timeLeft -= 1

			if #(GetEntityCoords(playerPed)-Config.CircleZones.CokeProcessing.coords) > 4 then
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

local function CutCokePowder()
	isProcessing = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)
	QBCore.Functions.Progressbar("search_register", Lang:t("progressbar.processing"), 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
		TriggerServerEvent('ps-drugprocessing:processCocaPowder')

		local timeLeft = Config.Delays.CokeProcessing / 1000
		while timeLeft > 0 do
			Wait(1000)
			timeLeft -= 1

			if #(GetEntityCoords(playerPed)-Config.CircleZones.CokeProcessing.coords) > 4 then
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

local function ProcessBricks()
	isProcessing = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)
	QBCore.Functions.Progressbar("search_register", Lang:t("progressbar.packing"), 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
		TriggerServerEvent('ps-drugprocessing:processCocaBrick')

		local timeLeft = Config.Delays.CokeProcessing / 1000
		while timeLeft > 0 do
			Wait(1000)
			timeLeft -= 1

			if #(GetEntityCoords(playerPed)-Config.CircleZones.CokeBrick.coords) > 4 then
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

RegisterNetEvent('ps-drugprocessing:ProcessCocaFarm', function()
	local coords = GetEntityCoords(PlayerPedId())

	if #(coords-Config.CircleZones.CokeProcessing.coords) < 5 then
		if not isProcessing then
			QBCore.Functions.TriggerCallback('ps-drugprocessing:validate_items', function(result)
				if result.ret then
					ProcessCoke()
				else
					QBCore.Functions.Notify(Lang:t("error.no_item", {item = result.item}))
				end
			end, {coca_leaf = Config.CokeProcessing.CokeLeaf, trimming_scissors = 1})
		end
	end
end)

RegisterNetEvent('ps-drugprocessing:ProcessCocaPowder', function()
	local coords = GetEntityCoords(PlayerPedId())
	local amount = 10
	local amount2 = 5
	
	if #(coords-Config.CircleZones.CokePowder.coords) < 5 then
		if not isProcessing then
			local check = {
				coke = Config.CokeProcessing.Coke,
				bakingsoda = Config.CokeProcessing.BakingSoda,
				finescale = 1
			}
			QBCore.Functions.TriggerCallback('ps-drugprocessing:validate_items', function(result)
				if result.ret then
					CutCokePowder()
				else
					QBCore.Functions.Notify(Lang:t("error.no_item", {item = result.item}))
				end
			end, check)
		else
			QBCore.Functions.Notify(Lang:t("error.already_processing"), 'error')
		end
	end
end)

RegisterNetEvent('ps-drugprocessing:ProcessBricks', function()
	local coords = GetEntityCoords(PlayerPedId(source))
	local amount = 4
	
	if #(coords-Config.CircleZones.CokeBrick.coords) < 5 then
		if not isProcessing then
			QBCore.Functions.TriggerCallback('ps-drugprocessing:validate_items', function(result)
				if result.ret then
					ProcessBricks()
				else
					QBCore.Functions.Notify(Lang:t("error.no_item", {item = result.item}))
				end
			end, {coke_small_brick = Config.CokeProcessing.SmallBrick, finescale = 1})
		else
			QBCore.Functions.Notify(Lang:t("error.already_processing"), 'error')
		end
	end
end)

RegisterNetEvent('ps-drugprocessing:EnterCWarehouse', function()
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)
    local dist = #(pos - vector3(Config.CokeLab["enter"].coords.x, Config.CokeLab["enter"].coords.y, Config.CokeLab["enter"].coords.z))
    if dist < 2 then
		if Config.KeyRequired then
			QBCore.Functions.TriggerCallback('ps-drugprocessing:validate_items', function(result)
				if result.ret then
					EnterCWarehouse()
				else
					QBCore.Functions.Notify(Lang:t("error.no_item", {item = result.item}))
				end
			end, { cocainekey = 1 } )
		else
			EnterCWarehouse()
		end
	end
end)

RegisterNetEvent('ps-drugprocessing:ExitCWarehouse', function()
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)
    local dist = #(pos - vector3(Config.CokeLab["exit"].coords.x, Config.CokeLab["exit"].coords.y, Config.CokeLab["exit"].coords.z))
    if dist < 2 then
		ExitCWarehouse()
	end
end)

RegisterCommand('propfix', function()
    for _, v in pairs(GetGamePool('CObject')) do
        if IsEntityAttachedToEntity(PlayerPedId(), v) then
            SetEntityAsMissionEntity(v, true, true)
            DeleteObject(v)
            DeleteEntity(v)
        end
    end
end)

local function startPickCocaLeaves(index)  -- 1
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
			TriggerServerEvent('ps-drugprocessing:pickedUpCocaLeaves')  -- 2
			TriggerServerEvent('ps-drugprocessing:server:resetCocaLeavesTimer', index)  -- 3
			isPickingUp = false
		end, function()
			ClearPedTasks(playerPed)
			TriggerServerEvent('ps-drugprocessing:server:retreatPickStateCocaLeaves', index)  -- 撤销已被采集的状态  -- 3
			isPickingUp = false
		end)
	end
end

RegisterNetEvent("ps-drugprocessing:pickCocaLeaves", function(targetEntity)
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
	for id, location in ipairs(Info.ItemLocation.CocaLeaves) do  -- 1
		if floorCoordX == location then
			nearbyID3 = id
		end
	end
	if not nearbyID3 then 
		QBCore.Functions.Notify("它是不可用的", "primary")
		return
	end
	QBCore.Functions.TriggerCallback("ps-drugprocessing:server:applyForPickCocaLeaves", function()  -- 2
		startPickCocaLeaves(nearbyID3)  -- 3
	end, nearbyID3)
end)