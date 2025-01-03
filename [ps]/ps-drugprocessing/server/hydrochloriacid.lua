local QBCore = exports['qb-core']:GetCoreObject()
local can_pick = {true, true, true, true, true, true}

-- rb_code
RegisterServerEvent('ps-drugprocessing:server:retreatPickStateHydrochloricAcid', function(index)  -- 如果采集过程中取消了采集  -- 1
	can_pick[index] = true
end)

RegisterServerEvent('ps-drugprocessing:server:resetHydrochloricAcidTimer', function(index)  -- 注册事件source自动传入，不能在参数列表写
	local src = source  -- SetTimeout的定时任务需要用source，则必须显式保留传入参数，因为服务器注册的事件不能写source形参，因此显式保留source；由于参数列表有index，因此index已经显式保留了
	-- 下面的用法叫闭包，但必须是函数内部显式声明的参数，SetTimeout中的定时任务才可以用
	SetTimeout(60000 * Info.Interval.HydrochloricAcid, function()  -- 1分钟  -- 2
		can_pick[index] = true
	end)
end)

QBCore.Functions.CreateCallback('ps-drugprocessing:server:applyForPickHydrochloricAcid', function(source, cb, index)  -- 2
	if can_pick[index] then
		can_pick[index] = false
		cb()
	else
        TriggerClientEvent('QBCore:Notify', source, "该盐酸桶还需等待一段时间", "primary")
	end
end)
-- 