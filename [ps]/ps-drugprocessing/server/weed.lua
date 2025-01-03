local QBCore = exports['qb-core']:GetCoreObject()
local can_pick = {true, true, true, true, true}

RegisterServerEvent('ps-drugprocessing:pickedUpCannabis', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.AddItem("cannabis", 1) then
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["cannabis"], "add")
		TriggerClientEvent('QBCore:Notify', src, Lang:t("success.cannabis"), "success")
	end
end)

RegisterServerEvent('ps-drugprocessing:processCannabis', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.RemoveItem('cannabis', 1) then
		if Player.Functions.AddItem('marijuana', 1) then
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['cannabis'], "remove")
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['marijuana'], "add")
			TriggerClientEvent('QBCore:Notify', src, Lang:t("success.marijuana"), "success")
		else
			Player.Functions.AddItem('cannabis', 1)
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_cannabis"), "error")
	end
end)

RegisterServerEvent('ps-drugprocessing:rollJoint', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.RemoveItem('marijuana', 1) then
		if Player.Functions.RemoveItem('rolling_paper', 1) then
			if Player.Functions.AddItem('joint', 1) then
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['marijuana'], "remove")
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['rolling_paper'], "remove")
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['joint'], "add")
				TriggerClientEvent('QBCore:Notify', src, Lang:t("success.joint"), "success")
			else
				Player.Functions.AddItem('marijuana', 1)
				Player.Functions.AddItem('rolling_paper', 1)
			end
		else
			Player.Functions.AddItem('marijuana', 1)
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_marijuhana"), "error")
	end
end)

QBCore.Functions.CreateUseableItem("rolling_paper", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('ps-drugprocessing:client:rollJoint', source, 'marijuana', item)
end)

RegisterServerEvent('ps-drugprocessing:bagskunk', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.RemoveItem('marijuana', 1) then
		if Player.Functions.RemoveItem('empty_weed_bag', 1) then
			if Player.Functions.AddItem('weed_skunk', 1) then
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['marijuana'], "remove")
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['empty_weed_bag'], "remove")
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['weed_skunk'], "add")
				TriggerClientEvent('QBCore:Notify', src, Lang:t("success.baggy"), "success")
			else
				Player.Functions.AddItem('marijuana', 1)
				Player.Functions.AddItem('empty_weed_bag', 1)
			end
		else
			Player.Functions.AddItem('marijuana', 1)
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_marijuhana"), "error")
	end
end)

QBCore.Functions.CreateUseableItem("empty_weed_bag", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('ps-drugprocessing:client:bagskunk', source, 'marijuana', item)
end)

-- rb_code
RegisterServerEvent('ps-drugprocessing:server:retreatPickStateWeed', function(index)  -- 采集失败重置为可采集状态  -- 1
	can_pick[index] = true
end)

RegisterServerEvent('ps-drugprocessing:server:resetWeedTimer', function(index)  -- 注册事件source自动传入，不能在参数列表写
	local src = source  -- SetTimeout的定时任务需要用source，则必须显式保留传入参数，因为服务器注册的事件不能写source形参，因此显式保留source；由于参数列表有index，因此index已经显式保留了
	-- 下面的用法叫闭包，但必须是函数内部显式声明的参数，SetTimeout中的定时任务才可以用
	SetTimeout(60000 * Info.Interval.Weed, function()  -- 1分钟  -- 2
		can_pick[index] = true
	end)
end)

QBCore.Functions.CreateCallback('ps-drugprocessing:server:applyForPickWeed', function(source, cb, index)  -- 2
	if can_pick[index] then
		can_pick[index] = false
		cb()
	else
        TriggerClientEvent('QBCore:Notify', source, "该大麻还需等待一段时间", "primary")
	end
end)
-- 