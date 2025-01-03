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

local function EnterWWarehouse()
    local ped = PlayerPedId()
    OpenDoorAnimation()
    WWarehouse = true
    Wait(500)
    DoScreenFadeOut(250)
    Wait(250)
    SetEntityCoords(ped, Config.WeedLab["exit"].coords.x, Config.WeedLab["exit"].coords.y, Config.WeedLab["exit"].coords.z - 0.98)
    SetEntityHeading(ped, Config.WeedLab["exit"].coords.w)
    Wait(1000)
    DoScreenFadeIn(250)
end

local function ExitWWarehouse()
    local ped = PlayerPedId()
    OpenDoorAnimation()
    WWarehouse = true
    Wait(500)
    DoScreenFadeOut(250)
    Wait(250)
    SetEntityCoords(ped, Config.WeedLab["enter"].coords.x, Config.WeedLab["enter"].coords.y, Config.WeedLab["enter"].coords.z - 0.98)
    SetEntityHeading(ped, Config.WeedLab["enter"].coords.w)
    Wait(1000)
    DoScreenFadeIn(250)
	WWarehouse = false
end

local function RollJoint()
	isProcessing = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)
	QBCore.Functions.Progressbar("search_register", Lang:t("progressbar.rolling_joint"), 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
		TriggerServerEvent('ps-drugprocessing:rollJoint')
		local timeLeft = Config.Delays.WeedProcessing / 1000
		while timeLeft > 0 do
			Wait(1000)
			timeLeft -= 1
		end
		ClearPedTasks(PlayerPedId())
		isProcessing = false
	end, function()
		ClearPedTasks(PlayerPedId())
		isProcessing = false
	end)
end

local function BagSkunk()
	isProcessing = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)
	QBCore.Functions.Progressbar("search_register", Lang:t("progressbar.bagging_skunk"), 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
		TriggerServerEvent('ps-drugprocessing:bagskunk')
		local timeLeft = Config.Delays.WeedProcessing / 1000
		while timeLeft > 0 do
			Wait(1000)
			timeLeft -= 1
		end
		ClearPedTasks(PlayerPedId())
		isProcessing = false
	end, function()
		ClearPedTasks(PlayerPedId())
		isProcessing = false
	end)
end

local function ProcessWeed()
	isProcessing = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)
	QBCore.Functions.Progressbar("search_register", Lang:t("progressbar.processing"), 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
		TriggerServerEvent('ps-drugprocessing:processCannabis')
		local timeLeft = Config.Delays.WeedProcessing / 1000
		while timeLeft > 0 do
			Wait(1000)
			timeLeft -= 1
			if #(GetEntityCoords(playerPed)-Config.CircleZones.WeedProcessing.coords) > 4 then
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

RegisterNetEvent("ps-drugprocessing:processWeed",function()
	QBCore.Functions.TriggerCallback('ps-drugprocessing:validate_items', function(result)
		if result.ret then
			ProcessWeed()
		else
			QBCore.Functions.Notify(Lang:t("error.no_item", {item = result.item}))
		end
	end,{cannabis = 1})
end)

RegisterNetEvent('ps-drugprocessing:EnterWWarehouse', function()
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)
    local dist = #(pos - vector3(Config.WeedLab["enter"].coords.x, Config.WeedLab["enter"].coords.y, Config.WeedLab["enter"].coords.z))
    if dist < 2 then
		if Config.KeyRequired then
			QBCore.Functions.TriggerCallback('ps-drugprocessing:validate_items', function(result)
				if result.ret then
					EnterWWarehouse()
				else
					QBCore.Functions.Notify(Lang:t("error.no_item", {item = result.item}))
				end
			end, {weedkey=1})
		else
			EnterWWarehouse()
		end
	end
end)

RegisterNetEvent('ps-drugprocessing:ExitWWarehouse', function()
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)
    local dist = #(pos - vector3(Config.WeedLab["exit"].coords.x, Config.WeedLab["exit"].coords.y, Config.WeedLab["exit"].coords.z))
    if dist < 2 then
		ExitWWarehouse()
	end
end)

RegisterNetEvent('ps-drugprocessing:client:rollJoint', function()
    QBCore.Functions.TriggerCallback('ps-drugprocessing:validate_items', function(result)
		if result.ret then
			RollJoint()
		else
			QBCore.Functions.Notify(Lang:t("error.no_item", {item = result.item}))
		end
	end, {marijuana = 1})
end)

RegisterNetEvent('ps-drugprocessing:client:bagskunk', function()
    QBCore.Functions.TriggerCallback('ps-drugprocessing:validate_items', function(result)
		if result.ret then
			BagSkunk()
		else
			QBCore.Functions.Notify(Lang:t("error.no_item", {item = result.item}))
		end
	end, {marijuana = 1})
end)

local function startPickWeed(index)  -- 1
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
			TriggerServerEvent('ps-drugprocessing:pickedUpCannabis')  -- 2
			TriggerServerEvent('ps-drugprocessing:server:resetWeedTimer', index)  -- 3
			isPickingUp = false
		end, function()
			ClearPedTasks(playerPed)
			TriggerServerEvent('ps-drugprocessing:server:retreatPickStateWeed', index)  -- 撤销已被采集的状态  -- 4
			isPickingUp = false
		end)
	end
end

RegisterNetEvent("ps-drugprocessing:pickWeed", function(targetEntity)  -- 1
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
	for id, location in ipairs(Info.ItemLocation.Weed) do  -- 2
		if floorCoordX == location then
			nearbyID3 = id
		end
	end
	if not nearbyID3 then 
		QBCore.Functions.Notify("混淆警方的假大麻，重新在附近找找", "primary")
		return
	end
	QBCore.Functions.TriggerCallback("ps-drugprocessing:server:applyForPickWeed", function()  -- 3
		startPickWeed(nearbyID3)  -- 4
	end, nearbyID3)
end)