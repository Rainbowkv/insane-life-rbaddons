local QBCore = exports['qb-core']:GetCoreObject()
local can_pick = {true, true, true, true, true}

RegisterServerEvent('ps-drugprocessing:pickedUpChemicals', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.AddItem("chemicals", 1) then
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["chemicals"], "add")
		TriggerClientEvent('QBCore:Notify', src, Lang:t("success.chemicals"), "success")
	end
end)

RegisterServerEvent('ps-drugprocessing:processHydrochloric_acid', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.RemoveItem('chemicals', 1) then
		if Player.Functions.AddItem('hydrochloric_acid', 1) then
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['chemicals'], "remove")
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['hydrochloric_acid'], "add")
			TriggerClientEvent('QBCore:Notify', src, Lang:t("success.hydrochloric_acid"), "success")
		else
			Player.Functions.AddItem('chemicals', 1)
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_chemicals"), "error")
	end
end)

RegisterServerEvent('ps-drugprocessing:processsodium_hydroxide', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.RemoveItem('chemicals', 1) then
		if Player.Functions.AddItem('sodium_hydroxide', 1) then
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['chemicals'], "remove")
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['sodium_hydroxide'], "add")
			TriggerClientEvent('QBCore:Notify', src, Lang:t("success.sodium_hydroxide"), "success")
		else
			Player.Functions.AddItem('chemicals', 1)
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_chemicals"), "error")
	end
end)

RegisterServerEvent('ps-drugprocessing:processprocess_sulfuric_acid', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.RemoveItem('chemicals', 1) then
		if Player.Functions.AddItem('sulfuric_acid', 1) then
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['chemicals'], "remove")
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['sulfuric_acid'], "add")
			TriggerClientEvent('QBCore:Notify', src, Lang:t("success.sulfuric_acid"), "success")
		else
			Player.Functions.AddItem('chemicals', 1)
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_chemicals"), "error")
	end
end)

RegisterServerEvent('ps-drugprocessing:process_lsa', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.RemoveItem('chemicals', 1) then
		if Player.Functions.AddItem('lsa', 1) then 
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['chemicals'], "remove")
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['lsa'], "add")
			TriggerClientEvent('QBCore:Notify', src, Lang:t("success.lsa"), "success")
		else
			Player.Functions.AddItem('chemicals', 1)
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_chemicals"), "error")
	end
end)

-- rb_code
RegisterServerEvent('ps-drugprocessing:server:retreatPickStateChemicals', function(index)  -- 如果采集过程中取消了采集
	can_pick[index] = true
end)

RegisterServerEvent('ps-drugprocessing:server:resetChemicalsTimer', function(index)  -- 注册事件source自动传入，不能在参数列表写
	local src = source  -- SetTimeout的定时任务需要用source，则必须显式保留传入参数，因为服务器注册的事件不能写source形参，因此显式保留source；由于参数列表有index，因此index已经显式保留了
	-- 下面的用法叫闭包，但必须是函数内部显式声明的参数，SetTimeout中的定时任务才可以用
	SetTimeout(60000 * Info.Interval.Chemicals, function()  -- 1分钟  -- 2
		can_pick[index] = true
	end)
end)

QBCore.Functions.CreateCallback('ps-drugprocessing:server:applyForPickChemicals', function(source, cb, index)
	if can_pick[index] then
		can_pick[index] = false
		cb()
	else
        TriggerClientEvent('QBCore:Notify', source, "该化学品桶还需等待一段时间", "primary")
	end
end)
-- 

QBCore.Functions.CreateCallback('ps-drugprocessing:validate_items', function(source, cb, data)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end

	local hasItems = {
		ret = true,
		items = {}
	}
	for name,amount in pairs(data) do
		local item = Player.Functions.GetItemByName(name)
		if not item or item and item.amount < amount then
			hasItems.ret = false
			hasItems.items[#hasItems.items+1] = QBCore.Shared.Items[name].label
		end
		if not hasItems then break end
	end
	hasItems.item = table.concat(hasItems.items, ", ")
	cb(hasItems)
end)