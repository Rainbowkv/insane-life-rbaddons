local QBCore = exports['qb-core']:GetCoreObject()
local can_pick = {true, true, true, true, true, true}

RegisterServerEvent('ps-drugprocessing:pickedUpPoppy', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.AddItem("poppyresin", 1) then
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["poppyresin"], "add")
		TriggerClientEvent('QBCore:Notify', src, Lang:t("success.poppyresin"), "success")
	end
end)

RegisterServerEvent('ps-drugprocessing:processPoppyResin', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.RemoveItem('poppyresin', Config.HeroinProcessing.Poppy) then
		if Player.Functions.AddItem('heroin', 1) then
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['poppyresin'], "remove", Config.HeroinProcessing.Poppy)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroin'], "add")
			TriggerClientEvent('QBCore:Notify', src, Lang:t("success.heroin"), "success")
		else
			Player.Functions.AddItem('poppyresin', 1)
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_poppy_resin"), "error")
	end
end)

-- rb_code
RegisterServerEvent('ps-drugprocessing:server:retreatPickStateHeroin', function(index)  -- 如果采集过程中取消了采集  -- 1
	can_pick[index] = true
end)

RegisterServerEvent('ps-drugprocessing:server:resetHeroinTimer', function(index)  -- 注册事件source自动传入，不能在参数列表写
	local src = source  -- SetTimeout的定时任务需要用source，则必须显式保留传入参数，因为服务器注册的事件不能写source形参，因此显式保留source；由于参数列表有index，因此index已经显式保留了
	-- 下面的用法叫闭包，但必须是函数内部显式声明的参数，SetTimeout中的定时任务才可以用
	SetTimeout(60000 * Info.Interval.Heroin, function()  -- 1分钟  -- 2
		can_pick[index] = true
	end)
end)

QBCore.Functions.CreateCallback('ps-drugprocessing:server:applyForPickHeroin', function(source, cb, index)  -- 2
	if can_pick[index] then
		can_pick[index] = false
		cb()
	else
        TriggerClientEvent('QBCore:Notify', source, "该罂粟树脂还需等待一段时间", "primary")
	end
end)
-- 