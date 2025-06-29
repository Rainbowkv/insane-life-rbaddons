-----------------------------------------------------------------
--TakeHostage by Robbster, do not redistrbute without permission--
------------------------------------------------------------------
local QBCore = exports['qb-core']:GetCoreObject()

local takeHostage = {
	allowedWeapons = {
		`WEAPON_PISTOL`,
		`WEAPON_VINTAGEPISTOL`,
		`WEAPON_CERAMICPISTOL`
		--etc add guns you want
	},
	InProgress = false,
	type = "",
	targetSrc = -1,
	agressor = {
		animDict = "anim@gangops@hostage@",
		anim = "perp_idle",
		flag = 49,
	},
	hostage = {
		animDict = "anim@gangops@hostage@",
		anim = "victim_idle",
		attachX = -0.24,
		attachY = 0.11,
		attachZ = 0.0,
		flag = 49,
	}
}

local function drawNativeNotification(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

local function ensureAnimDict(animDict)
    if not HasAnimDictLoaded(animDict) then
        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do
            Wait(0)
        end        
    end
    return animDict
end

local function drawNativeText(str)
	SetTextEntry_2("STRING")
	AddTextComponentString(str)
	EndTextCommandPrint(1000, 1)
end

function callTakeHostage(targetPed)
	if takeHostage.type ~= '' then return end
	ClearPedSecondaryTask(PlayerPedId())
	DetachEntity(PlayerPedId(), true, false)

	local canTakeHostage = false
	for i=1, #takeHostage.allowedWeapons do
		if HasPedGotWeapon(PlayerPedId(), takeHostage.allowedWeapons[i], false) then
			if GetAmmoInPedWeapon(PlayerPedId(), takeHostage.allowedWeapons[i]) > 0 then
				canTakeHostage = true 
				foundWeapon = takeHostage.allowedWeapons[i]
				break
			end 					
		end
	end

	if not canTakeHostage then 
		drawNativeNotification("你需要一把合适的枪才能挟持人质")
	end

	if not takeHostage.InProgress and canTakeHostage then
        local targetSrc = GetPlayerServerId(NetworkGetPlayerIndexFromPed(targetPed))
        if targetSrc and targetSrc ~= -1 then
            -- SetCurrentPedWeapon(PlayerPedId(), foundWeapon, true)
            -- takeHostage.InProgress = true
            -- takeHostage.targetSrc = targetSrc
            -- TriggerServerEvent("TakeHostage:sync", targetSrc)
            -- ensureAnimDict(takeHostage.agressor.animDict)
            -- takeHostage.type = "agressor"
			TriggerServerEvent("TakeHostage:checkTargetStatus", targetSrc)  -- rb_code,请求服务端检查目标是否已被挟持
        else
            drawNativeNotification("~r~目标玩家无效")
        end
    end
end 

-- rb_code

local function searchPlayer(targetPed)
	local targetSrc = GetPlayerServerId(NetworkGetPlayerIndexFromPed(targetPed))
	TriggerServerEvent('TakeHostage:server:searchPlayer', targetSrc)
end

RegisterNetEvent("TakeHostage:client:beSearched", function(searchPlayerSrc)
	if exports['qb-smallresources']:getHandsup() or exports['ars_ambulancejob']:isDead() or exports['origen_police']:isHandcuffed() then
		TriggerServerEvent('TakeHostage:server:beSearched', searchPlayerSrc, true)
	else
		TriggerServerEvent('TakeHostage:server:beSearched', searchPlayerSrc, false)
	end
end)

RegisterNetEvent("TakeHostage:targetAvailable", function(targetSrc)
	local canTakeHostage = false
	local weapon = nil
	for i=1, #takeHostage.allowedWeapons do
		if HasPedGotWeapon(PlayerPedId(), takeHostage.allowedWeapons[i], false) then
			if GetAmmoInPedWeapon(PlayerPedId(), takeHostage.allowedWeapons[i]) > 0 then
				canTakeHostage = true 
				weapon = takeHostage.allowedWeapons[i]
				break
			end 					
		end
	end
	if not canTakeHostage then 
		drawNativeNotification("你需要一把合适的枪才能挟持人质")
	end
	SetCurrentPedWeapon(PlayerPedId(), weapon, true)
	takeHostage.InProgress = true
	takeHostage.targetSrc = targetSrc
	TriggerServerEvent("TakeHostage:sync", targetSrc)
	ensureAnimDict(takeHostage.agressor.animDict)
	takeHostage.type = "agressor"
end)

RegisterNetEvent("TakeHostage:targetUnavailable", function()
	drawNativeNotification("~r~目标已经被他人控制，无法进行挟持")
end)
-- rb_code

RegisterNetEvent("TakeHostage:syncTarget")
AddEventHandler("TakeHostage:syncTarget", function(target)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
	takeHostage.InProgress = true
	ensureAnimDict(takeHostage.hostage.animDict)
	AttachEntityToEntity(PlayerPedId(), targetPed, 0, takeHostage.hostage.attachX, takeHostage.hostage.attachY, takeHostage.hostage.attachZ, 0.5, 0.5, 0.0, false, false, false, false, 2, false)
	takeHostage.type = "hostage" 
end)

RegisterNetEvent("TakeHostage:releaseHostage")
AddEventHandler("TakeHostage:releaseHostage", function()
	takeHostage.InProgress = false 
	takeHostage.type = ""
	DetachEntity(PlayerPedId(), true, false)
	ensureAnimDict("reaction@shove")
	TaskPlayAnim(PlayerPedId(), "reaction@shove", "shoved_back", 8.0, -8.0, -1, 0, 0, false, false, false)
	Wait(250)
	ClearPedSecondaryTask(PlayerPedId())
end)

RegisterNetEvent("TakeHostage:killHostage")
AddEventHandler("TakeHostage:killHostage", function()
	takeHostage.InProgress = false 
	takeHostage.type = ""
	SetEntityHealth(PlayerPedId(),0)
	DetachEntity(PlayerPedId(), true, false)
	ensureAnimDict("anim@gangops@hostage@")
	TaskPlayAnim(PlayerPedId(), "anim@gangops@hostage@", "victim_fail", 8.0, -8.0, -1, 168, 0, false, false, false)
end)

RegisterNetEvent("TakeHostage:cl_stop")
AddEventHandler("TakeHostage:cl_stop", function()
	takeHostage.InProgress = false
	takeHostage.type = "" 
	ClearPedSecondaryTask(PlayerPedId())
	DetachEntity(PlayerPedId(), true, false)
end)

Citizen.CreateThread(function()
	while true do
		if takeHostage.type == "agressor" then
			if not IsEntityPlayingAnim(PlayerPedId(), takeHostage.agressor.animDict, takeHostage.agressor.anim, 3) then
				TaskPlayAnim(PlayerPedId(), takeHostage.agressor.animDict, takeHostage.agressor.anim, 8.0, -8.0, 100000, takeHostage.agressor.flag, 0, false, false, false)
			end
		elseif takeHostage.type == "hostage" then
			if not IsEntityPlayingAnim(PlayerPedId(), takeHostage.hostage.animDict, takeHostage.hostage.anim, 3) then
				TaskPlayAnim(PlayerPedId(), takeHostage.hostage.animDict, takeHostage.hostage.anim, 8.0, -8.0, 100000, takeHostage.hostage.flag, 0, false, false, false)
			end
		end
		Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do 
		if takeHostage.type == "agressor" then
			DisableControlAction(0,24,true) -- disable attack
			DisableControlAction(0,25,true) -- disable aim
			DisableControlAction(0,47,true) -- disable weapon
			DisableControlAction(0,58,true) -- disable weapon
			DisableControlAction(0,21,true) -- disable sprint
			DisablePlayerFiring(PlayerPedId(),true)
			drawNativeText("按 [G] 释放, [H] 杀掉")

			if IsEntityDead(PlayerPedId()) then	
				takeHostage.type = ""
				takeHostage.InProgress = false
				ensureAnimDict("reaction@shove")
				TaskPlayAnim(PlayerPedId(), "reaction@shove", "shove_var_a", 8.0, -8.0, -1, 168, 0, false, false, false)
				TriggerServerEvent("TakeHostage:releaseHostage", takeHostage.targetSrc)
			end 

			if IsDisabledControlJustPressed(0,47) then --release	
				takeHostage.type = ""
				takeHostage.InProgress = false 
				ensureAnimDict("reaction@shove")
				TaskPlayAnim(PlayerPedId(), "reaction@shove", "shove_var_a", 8.0, -8.0, -1, 168, 0, false, false, false)
				TriggerServerEvent("TakeHostage:releaseHostage", takeHostage.targetSrc)
			elseif IsDisabledControlJustPressed(0,74) then --kill 			
				takeHostage.type = ""
				takeHostage.InProgress = false 		
				ensureAnimDict("anim@gangops@hostage@")
				TaskPlayAnim(PlayerPedId(), "anim@gangops@hostage@", "perp_fail", 8.0, -8.0, -1, 168, 0, false, false, false)
				TriggerServerEvent("TakeHostage:killHostage", takeHostage.targetSrc)
				TriggerServerEvent("TakeHostage:stop",takeHostage.targetSrc)
				Wait(100)
				SetPedShootsAtCoord(PlayerPedId(), 0.0, 0.0, 0.0, 0)
			end
		elseif takeHostage.type == "hostage" then 
			DisableControlAction(0,21,true) -- disable sprint
			DisableControlAction(0,24,true) -- disable attack
			DisableControlAction(0,25,true) -- disable aim
			DisableControlAction(0,47,true) -- disable weapon
			DisableControlAction(0,58,true) -- disable weapon
			DisableControlAction(0,263,true) -- disable melee
			DisableControlAction(0,264,true) -- disable melee
			DisableControlAction(0,257,true) -- disable melee
			DisableControlAction(0,140,true) -- disable melee
			DisableControlAction(0,141,true) -- disable melee
			DisableControlAction(0,142,true) -- disable melee
			DisableControlAction(0,143,true) -- disable melee
			DisableControlAction(0,75,true) -- disable exit vehicle
			DisableControlAction(27,75,true) -- disable exit vehicle  
			DisableControlAction(0,22,true) -- disable jump
			DisableControlAction(0,32,true) -- disable move up
			DisableControlAction(0,268,true)
			DisableControlAction(0,33,true) -- disable move down
			DisableControlAction(0,269,true)
			DisableControlAction(0,34,true) -- disable move left
			DisableControlAction(0,270,true)
			DisableControlAction(0,35,true) -- disable move right
			DisableControlAction(0,271,true)
		end
		Wait(0)
	end
end)

exports.ox_target:addGlobalPlayer({
    {
        name = 'takehostage',
        icon = 'fas fa-user-lock', -- 可换成你喜欢的 FontAwesome 图标
        label = '挟持',
		distance = 0.7, -- ox_target 内部控制交互距离
		canInteract = function(entity, coords, name)
            return not (exports['ars_ambulancejob']:isDead() or exports['origen_police']:isHandcuffed() or exports['ars_ambulancejob']:isEscorted())
        end,
        onSelect = function(data)
            callTakeHostage(data.entity)
        end
    },
	{
        name = 'searchplayer',
        icon = 'fas fa-user-lock', -- 可换成你喜欢的 FontAwesome 图标
        label = '搜身',
		distance = 1.0, -- ox_target 内部控制交互距离
		canInteract = function(entity, coords, name)
            return not (exports['ars_ambulancejob']:isDead() or exports['origen_police']:isHandcuffed() or exports['ars_ambulancejob']:isEscorted())
        end,
        onSelect = function(data)
			QBCore.Functions.Progressbar("search_player", "准备搜身...", 3000, false, true, {
				disableMovement = false,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = true,
			}, {
				animDict = "anim@gangops@facility@servers@bodysearch@",
				anim = "player_search",
				flags = 49,
			}, {}, {}, function()
				StopAnimTask(ped, "anim@gangops@facility@servers@bodysearch@", "player_search", 1.0)
            	searchPlayer(data.entity)
			end)
        end
    }
})