local QBCore = exports['qb-core']:GetCoreObject()
local can_pick = {true, true, true, true, true}

RegisterServerEvent('ps-drugprocessing:pickedUpCocaLeaves', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.AddItem("coca_leaf", 1) then 
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["coca_leaf"], "add")
		TriggerClientEvent('QBCore:Notify', src, Lang:t("success.coca_leaf"), "success")
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_coca_leaf"), "error")
	end
end)

RegisterServerEvent('ps-drugprocessing:processCocaLeaf', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.RemoveItem('coca_leaf', Config.CokeProcessing.CokeLeaf) then
		if Player.Functions.AddItem('coke', Config.CokeProcessing.ProcessCokeLeaf) then
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['coca_leaf'], "remove", Config.CokeProcessing.CokeLeaf)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['coke'], "add", Config.CokeProcessing.ProcessCokeLeaf)
			TriggerClientEvent('QBCore:Notify', src, Lang:t("success.coke"), "success")
		else
			Player.Functions.AddItem('coca_leaf', Config.CokeProcessing.CokeLeaf)
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_coca_leaf"), "error")
	end
end)

RegisterServerEvent('ps-drugprocessing:processCocaPowder', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.RemoveItem('coke', Config.CokeProcessing.Coke) then
		if Player.Functions.RemoveItem('bakingsoda', Config.CokeProcessing.BakingSoda) then
			if Player.Functions.AddItem('coke_small_brick', Config.CokeProcessing.SmallCokeBrick) then
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['coke'], "remove", Config.CokeProcessing.Coke)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['bakingsoda'], "remove", Config.CokeProcessing.BakingSoda)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['coke_small_brick'], "add", Config.CokeProcessing.SmallCokeBrick)
				TriggerClientEvent('QBCore:Notify', src, Lang:t("success.coke_small_brick"), "success")
			else
				Player.Functions.AddItem('coke', Config.CokeProcessing.Coke)
				Player.Functions.AddItem('bakingsoda', Config.CokeProcessing.BakingSoda)
			end
		else
			Player.Functions.AddItem('coke', Config.CokeProcessing.Coke)
			TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_bakingsoda"), "error")
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_cokain"), "error")
	end
end)

RegisterServerEvent('ps-drugprocessing:processCocaBrick', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.RemoveItem('coke_small_brick', Config.CokeProcessing.SmallBrick) then
		if Player.Functions.AddItem('coke_brick', Config.CokeProcessing.LargeBrick) then
			TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['coke_small_brick'], "remove", Config.CokeProcessing.SmallBrick)
			TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['coke_brick'], "add", Config.CokeProcessing.LargeBrick)
			TriggerClientEvent('QBCore:Notify', src, Lang:t("success.coke_brick"), "success")
		else
			Player.Functions.AddItem('coke_small_brick', Config.CokeProcessing.SmallBrick)
		end
	end
end)

-- rb_code
RegisterServerEvent('ps-drugprocessing:server:retreatPickStateCocaLeaves', function(index)  -- 如果采集过程中取消了采集  -- 1
	can_pick[index] = true
end)

RegisterServerEvent('ps-drugprocessing:server:resetCocaLeavesTimer', function(index)  -- 注册事件source自动传入，不能在参数列表写
	local src = source  -- SetTimeout的定时任务需要用source，则必须显式保留传入参数，因为服务器注册的事件不能写source形参，因此显式保留source；由于参数列表有index，因此index已经显式保留了
	-- 下面的用法叫闭包，但必须是函数内部显式声明的参数，SetTimeout中的定时任务才可以用
	SetTimeout(60000 * Info.Interval.CocaLeaves, function()  -- 1分钟  -- 2
		can_pick[index] = true
	end)
end)

QBCore.Functions.CreateCallback('ps-drugprocessing:server:applyForPickCocaLeaves', function(source, cb, index)  -- 2
	if can_pick[index] then
		can_pick[index] = false
		cb()
	else
        TriggerClientEvent('QBCore:Notify', source, "该古柯叶还需等待一段时间", "primary")
	end
end)
-- 