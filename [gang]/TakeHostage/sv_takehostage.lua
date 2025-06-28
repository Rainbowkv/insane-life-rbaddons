local takingHostage = {}
--takingHostage[source] = targetSource, source is takingHostage targetSource
local takenHostage = {}
--takenHostage[targetSource] = source, targetSource is being takenHostage by source

-- rb_code
local QBCore = exports['qb-core']:GetCoreObject()
RegisterServerEvent("TakeHostage:checkTargetStatus")
AddEventHandler("TakeHostage:checkTargetStatus", function(targetSrc)
	local src = source
	local playerData = QBCore.Functions.GetPlayer(targetSrc).PlayerData
	if playerData.metadata['isdead'] or playerData.metadata['ishandcuffed'] then
		TriggerClientEvent('QBCore:Notify', src, 'id为'..targetSrc..'的市民已经死亡或者被铐', 'error')
		return
	end
	-- 检查目标是否已经在被挟持或正在挟持他人
	if takenHostage[targetSrc] or takingHostage[targetSrc] then
		TriggerClientEvent("TakeHostage:targetUnavailable", src)
	else
		TriggerClientEvent("TakeHostage:targetAvailable", src, targetSrc)
	end
end)

RegisterServerEvent("TakeHostage:server:searchPlayer", function(targetSrc)
	TriggerClientEvent('TakeHostage:client:beSearched', targetSrc, source)
end)

RegisterServerEvent("TakeHostage:server:beSearched", function(searchPlayerSrc, canBeSearched)
	local src = source
	if not canBeSearched then 
		TriggerClientEvent('ox_lib:notify', searchPlayerSrc, {
			title = '搜身失败',
			description = '对面未处于投降或虚弱状态',
			type = 'error'
		})
        return 
	end
	local searchPlayerPed = GetPlayerPed(searchPlayerSrc)
    local targetPed = GetPlayerPed(src)
    local searchPlayerCoords = GetEntityCoords(searchPlayerPed)
    local targetCoords = GetEntityCoords(targetPed)
	if #(searchPlayerCoords - targetCoords) > 1.5 then 
		TriggerClientEvent('ox_lib:notify', searchPlayerSrc, {
			title = '搜身失败',
			description = '距离太远了',
			type = 'error'
		})
        return 
    end
	TriggerClientEvent('ox_lib:notify', src, {
		title = '警告',
		description = '您正在被搜身',
		type = 'error'
	})
	exports['qb-inventory']:OpenInventoryById(searchPlayerSrc, src)
end)
--

RegisterServerEvent("TakeHostage:sync")
AddEventHandler("TakeHostage:sync", function(targetSrc)
	local source = source

	TriggerClientEvent("TakeHostage:syncTarget", targetSrc, source)
	takingHostage[source] = targetSrc
	takenHostage[targetSrc] = source
end)

RegisterServerEvent("TakeHostage:releaseHostage")
AddEventHandler("TakeHostage:releaseHostage", function(targetSrc)
	local source = source
	if takenHostage[targetSrc] then 
		TriggerClientEvent("TakeHostage:releaseHostage", targetSrc, source)
		takingHostage[source] = nil
		takenHostage[targetSrc] = nil
	end
end)

RegisterServerEvent("TakeHostage:killHostage")
AddEventHandler("TakeHostage:killHostage", function(targetSrc)
	local source = source
	if takenHostage[targetSrc] then 
		TriggerClientEvent("TakeHostage:killHostage", targetSrc, source)
		takingHostage[source] = nil
		takenHostage[targetSrc] = nil
	end
end)

RegisterServerEvent("TakeHostage:stop")
AddEventHandler("TakeHostage:stop", function(targetSrc)
	local source = source

	if takingHostage[source] then
		TriggerClientEvent("TakeHostage:cl_stop", targetSrc)
		takingHostage[source] = nil
		takenHostage[targetSrc] = nil
	elseif takenHostage[source] then
		TriggerClientEvent("TakeHostage:cl_stop", targetSrc)
		takenHostage[source] = nil
		takingHostage[targetSrc] = nil
	end
end)

AddEventHandler('playerDropped', function(reason)
	local source = source
	
	if takingHostage[source] then
		TriggerClientEvent("TakeHostage:cl_stop", takingHostage[source])
		takenHostage[takingHostage[source]] = nil
		takingHostage[source] = nil
	end

	if takenHostage[source] then
		TriggerClientEvent("TakeHostage:cl_stop", takenHostage[source])
		takingHostage[takenHostage[source]] = nil
		takenHostage[source] = nil
	end
end)
