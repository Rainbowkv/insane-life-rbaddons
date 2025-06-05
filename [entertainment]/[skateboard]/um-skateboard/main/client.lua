local skateboard = {}
local Dir = {}
local Attached = nil
local spawned = false

local config = require 'shared.config'
local controls = require 'shared.controls'

local function configureSkateboard(entity)
	local handling = require 'shared.handling'
	for k, v in pairs(handling) do
		SetVehicleHandlingFloat(entity, "CHandlingData", k, v)
	end
end

local function makeFakeSkateboard(ped, pProp, remove) -- The animation for picking up and placing the board
	if remove then
		-- 删除 Driver，客户端自己处理
		if DoesEntityExist(skateboard.Driver) then
			DeletePed(skateboard.Driver)
		end
		skateboard.Skate = NetworkGetNetworkIdFromEntity(skateboard.Skate)
		skateboard.Bike = NetworkGetNetworkIdFromEntity(skateboard.Bike)
		TriggerServerEvent('um-skateboard:server:pickupSkateboard', skateboard, pProp)
		ClearPedTasks(cache.ped)
	else
		local prop = CreateSkateProp({ prop = pProp, coords = vec4(0, 0, 0, 0), false, true })
		AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, 57005), 0.3, 0.08, 0.0, -86.0, -60.0, 50.0, true, true,
		false, false, 1, true)
		lib.playAnim(cache.ped, "pickup_object", "pickup_low")
		Wait(900)
		DestroyProp(prop)
	end
end

local function pickupSkateboard(entity)
	if not DoesEntityExist(skateboard.Bike) and not Attached then return end

	RemoveLocalEntityTarget(skateboard.Skate)
	RemoveLocalEntityTarget(skateboard.Driver)
	RemoveLocalEntityTarget(skateboard.Bike)
	Attached = false
	Wait(100)
	makeFakeSkateboard(cache.ped, GetEntityArchetypeName(skateboard.Skate), true) -- pick up animation
	skateboard = {}
	Dir = {}
end

local function enterSkateboard()
	if not spawned and not DoesEntityExist(skateboard.Skate) then return end

	AttachEntityToEntity(cache.ped, skateboard.Bike, 20, 0.0, 0.25, 0.01, 0.0, 0.0, -15.0, true, true, false, true, 1,
		true)
	SetEntityCollision(cache.ped, true, true)
	Attached = true

	lib.playAnim(cache.ped, "move_strafe@stealth", "idle", nil, -4.0, nil, 9)

	-- 添加伤害同步逻辑线程
	local lastHealth = GetEntityHealth(skateboard.Driver)

	CreateThread(function()
		while Attached and DoesEntityExist(skateboard.Driver) and not IsEntityDead(skateboard.Driver) do
			Wait(100)

			local currentHealth = GetEntityHealth(skateboard.Driver)

			if currentHealth < lastHealth then
				local lost = lastHealth - currentHealth
				ApplyDamageToPed(cache.ped, lost, false)
				lastHealth = currentHealth
			elseif currentHealth > lastHealth then
				lastHealth = currentHealth
			end
		end
	end)

	CreateThread(function()
		while Attached do
			StopCurrentPlayingAmbientSpeech(skateboard.Driver)
			local speed = math.ceil(GetEntitySpeed(skateboard.Bike) * 3.6)
			local zVelocity = GetEntityVelocity(skateboard.Bike).z
			-- 碰撞检测
			if HasEntityCollidedWithAnything(skateboard.Bike) or speed >= config.ragdollSpeed or zVelocity < config.fallSpeed then  -- 在这里加跌落检测
				print(HasEntityCollidedWithAnything(skateboard.Bike))
				print(speed)
				print(zVelocity)
				DetachEntity(cache.ped, false, false)
				TaskVehicleTempAction(skateboard.Driver, skateboard.Bike, 1, 1)
				Attached = false
				Dir = {}
				StopAnimTask(cache.ped, "move_strafe@stealth", "idle", 0.5)
				SetPedToRagdoll(cache.ped, 5000, 4000, 0, true, true, false)
			end

			if not DoesEntityExist(skateboard.Bike) or GetPedInVehicleSeat(skateboard.Bike, -1) ~= skateboard.Driver then
				RemoveLocalEntityTarget(skateboard.Skate)
				RemoveLocalEntityTarget(skateboard.Bike)
				RemoveLocalEntityTarget(skateboard.Driver)
				Attached = false
				Wait(100)
				makeFakeSkateboard(cache.ped, GetEntityArchetypeName(skateboard.Skate), true)
				skateboard = {}
				Dir = {}
			end

			if not IsEntityAttachedToEntity(cache.ped, skateboard.Bike) then
				DetachEntity(cache.ped, false, false)
				TaskVehicleTempAction(skateboard.Driver, skateboard.Bike, 6, 2000)
				Attached = false
				Dir = {}
				StopAnimTask(cache.ped, "move_strafe@stealth", "idle", 0.5)
			end
			Wait(1000)
		end
	end)
end

local function mergeControls()
	local result = {}
	for _, v in pairs(controls) do
		result[#result + 1] = string.format("%s: **%s**", v.name, v.key)
	end
	return table.concat(result, "  \n")
end

local function addTargetSkateEntity()
	local options = {
		{
			action = function() enterSkateboard() end,
			icon = string.format('fas fa-%s', config.icons.getOnSkateBoard),
			label = config.lang.getOnSkateBoard,
			board = skateboard.Skate
		},
		{
			action = function(data) pickupSkateboard(data.entity) end,
			icon = string.format('fas fa-%s', config.icons.pickupSkateBoard),
			label = config.lang.pickupSkateBoard,
			board = skateboard.Skate
		},
		{
			action = function()
				lib.alertDialog({
					header = config.lang.usageSkateBoard,
					content = mergeControls(),
					centered = true,
					cancel = false
				})
			end,
			icon = string.format('fas fa-%s', config.icons.usageSkateBoard),
			label = config.lang.usageSkateBoard,
		},
	}

	AddLocalCreateEntityTarget(skateboard.Skate, options, config.targetDistance)
	AddLocalCreateEntityTarget(skateboard.Driver, options, config.targetDistance)
	AddLocalCreateEntityTarget(skateboard.Bike, options, config.targetDistance)

end

RegisterNetEvent("um-skateboard:spawn:skateboard", function(pProp)
	if GetInvokingResource() ~= nil then return end

	local ped = cache.ped

	if IsPedSittingInAnyVehicle(ped) then return end

	TriggerServerEvent("um-skateboard:server:placeSkateboard", pProp)
	local pedCoords = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.5, -40.5)
	skateboard.Bike = CreateBike(config.baseVehicle, vec4(pedCoords.x, pedCoords.y, pedCoords.z, 0.0))
	skateboard.Skate = CreateSkateProp({ prop = pProp, coords = vec4(pedCoords.x, pedCoords.y, pedCoords.z, 0.0) },
		true,
		true)

	while not DoesEntityExist(skateboard.Bike) or not DoesEntityExist(skateboard.Skate) do Wait(5) end
	SetEntityNoCollisionEntity(skateboard.Bike, ped, false)
	SetEntityNoCollisionEntity(skateboard.Skate, ped, false)

	configureSkateboard(skateboard.Bike)

	-- SetEntityCompletelyDisableCollision(skateboard.Bike, true, true)
	-- SetEntityCompletelyDisableCollision(skateboard.Skate, true, true)

	SetEntityVisible(skateboard.Bike, config.debug, false)

	AttachEntityToEntity(skateboard.Skate, skateboard.Bike, GetPedBoneIndex(ped, 28422), 0.0, 0.0, config.coordZ[GetEntityArchetypeName(skateboard.Skate)], 0.0,  -- 骑行时滑板陷入地下的原因
		10.0, 90.0, false, true, true, true, 1, true)

	skateboard.Driver = ClonePed(ped, true, false, true)
	-- skateboard.Driver = CreateSkateDriver(ped)
	SetEntityCoords(skateboard.Driver, pedCoords.x, pedCoords.y, pedCoords.z, true, false, false, false)
	while not DoesEntityExist(skateboard.Driver) do Wait(0) end

	SetEntityNoCollisionEntity(skateboard.Driver, ped, false)
	-- SetEntityCompletelyDisableCollision(skateboard.Driver, true, true)

	SetEnableHandcuffs(skateboard.Driver, true)
	-- SetEntityInvincible(skateboard.Driver, true)
	FreezeEntityPosition(skateboard.Driver, true)

	while not IsPedSittingInAnyVehicle(skateboard.Driver) do
		SetEntityVisible(skateboard.Driver, config.debug, false)
		TaskWarpPedIntoVehicle(skateboard.Driver, skateboard.Bike, -1)
		Wait(10)
	end

	addTargetSkateEntity()
	makeFakeSkateboard(ped, pProp)
	DisableCamCollisionForEntity(skateboard.Bike)
	DisableCamCollisionForEntity(skateboard.Skate)
	DisableCamCollisionForEntity(skateboard.Driver)
	SetVehicleDoorsLocked(skateboard.Bike, 10)

	local offsetCoords = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.5, 1.5)
	SetEntityCoords(skateboard.Bike, offsetCoords.x, offsetCoords.y, offsetCoords.z, false, false, false, false)
	SetEntityHeading(skateboard.Bike, GetEntityHeading(cache.ped) + 90)


	Dir = {}
	spawned = true
end)


---? Key Mapping ---
RegisterKeyMapping('skategetoff', controls.exit.name, 'keyboard', controls.exit.key)
RegisterCommand('skategetoff', function()
	if not Attached or IsEntityInAir(skateboard.Bike) then return end
	DetachEntity(cache.ped, false, false)
	TaskVehicleTempAction(skateboard.Driver, skateboard.Bike, 1, 100)
	Attached = false
	Dir = {}
	ClearPedTasks(cache.ped)
end)

RegisterKeyMapping('+skateforward', controls.up.name, 'keyboard', controls.up.key)
RegisterCommand('+skateforward', function()
	if not Attached then return end

	if Dir.forward then return end

	CreateThread(function()
		Dir.forward = true
		while Dir.forward do
			local action = Dir.left and 7 or (Dir.right and 8 or 9)
			TaskVehicleTempAction(skateboard.Driver, skateboard.Bike, action, 0.1)
			Wait(50)
		end
	end)
end)

RegisterCommand('-skateforward', function()
	if not Attached then return end

	Dir.forward = nil
	TaskVehicleTempAction(skateboard.Driver, skateboard.Bike, 1, 1)
end)

RegisterKeyMapping('+skatebackward', controls.down.name, 'keyboard', controls.down.key)
RegisterCommand('+skatebackward', function()
	if not Attached then return end

	if Dir.backward then return end

	CreateThread(function()
		Dir.backward = true
		while Dir.backward do
			local action = Dir.left and 13 or (Dir.right and 14 or 22)
			TaskVehicleTempAction(skateboard.Driver, skateboard.Bike, action, 0.1)
			Wait(50)
		end
	end)
end)

RegisterCommand('-skatebackward', function()
	if not Attached then return end
	Dir.backward = nil
	TaskVehicleTempAction(skateboard.Driver, skateboard.Bike, 1, 1)
end)

RegisterKeyMapping('+skateleft', controls.left.name, 'keyboard', controls.left.key)
RegisterCommand('+skateleft', function()
	if not Attached then return end
	Dir.left = true
end)
RegisterCommand('-skateleft', function()
	if not Attached then return end

	Dir.left = nil
end)

RegisterKeyMapping('+skateright', controls.right.name, 'keyboard', controls.right.key)
RegisterCommand('+skateright', function()
	if not Attached then return end
	Dir.right = true
end)
RegisterCommand('-skateright', function()
	if not Attached then return end

	Dir.right = nil
end)

RegisterKeyMapping('skatejump', controls.jump.name, 'keyboard', controls.jump.key)
RegisterCommand('skatejump', function()
	if not Attached then return end
	if IsEntityInAir(skateboard.Bike) then return end

	local vel = GetEntityVelocity(skateboard.Bike)
	local duration = 0
	local boost = 0
	local defaultBoost = config.jumpBoost

	lib.playAnim(cache.ped, "move_crouch_proto", "idle_intro")

	while IsControlPressed(0, 22) do
		Wait(10)
		duration = duration + 10.0
	end

	boost = defaultBoost * duration / 250.0
	if boost > defaultBoost then boost = defaultBoost end

	SetEntityVelocity(skateboard.Bike, vel.x, vel.y, vel.z + boost)

	StopAnimTask(cache.ped, "move_crouch_proto", "idle_intro", 0.5)

	lib.playAnim(cache.ped, "move_strafe@stealth", "idle", nil, -4.0, nil, 9)
end)

AddEventHandler('onResourceStop', function(resource)
	if resource ~= cache.resource then return end

	if DoesEntityExist(skateboard.Driver) then
		ClearAll(skateboard)
	end
end)
