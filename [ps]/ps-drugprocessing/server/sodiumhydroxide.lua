-- 3个事件，1个配置参数
local QBCore = exports['qb-core']:GetCoreObject()
local can_pick = {true, true, true, true, true}

RegisterServerEvent('ps-drugprocessing:server:retreatPickStateSodium', function(index)  -- 如果采集过程中取消了采集
	can_pick[index] = true
end)

RegisterServerEvent('ps-drugprocessing:server:resetSodiumTimer', function(index)  -- 注册事件source自动传入，不能在参数列表写
	local src = source  -- SetTimeout的定时任务需要用source，则必须显式保留传入参数，因为服务器注册的事件不能写source形参，因此显式保留source；由于参数列表有index，因此index已经显式保留了
	-- 下面的用法叫闭包，但必须是函数内部显式声明的参数，SetTimeout中的定时任务才可以用
	SetTimeout(60000 * Info.Interval.Sodium, function()  -- 1分钟  -- 2
		can_pick[index] = true
	end)
end)

QBCore.Functions.CreateCallback('ps-drugprocessing:server:applyForPickSodium', function(source, cb, index)  -- 这里应该还是有没解决的线程安全问题
    if can_pick[index] then
        can_pick[index] = false
        cb()
    else
        TriggerClientEvent('QBCore:Notify', source, "该氢氧化钠桶还需等待一段时间", "primary")
    end
end)