local QBCore = exports['qb-core']:GetCoreObject()

lib.callback.register('exchange:getListings', function(source)
    local result = MySQL.query.await('SELECT id, citizenid, amount, price FROM coins_exchanger')
    return result
end)

RegisterNetEvent("exchange:trySell", function(pAmount, pPrice)
    local src = source
    local amount = tonumber(pAmount)
    local price = tonumber(pPrice)
    if not amount or not price or amount <= 0 or price <= 0 then
        TriggerClientEvent("QBCore:Notify", src, "输入的赞助点或价格不合理", 'error')
        return
    end
    if amount > Config.maxCoinsValue then
        TriggerClientEvent("QBCore:Notify", src, "单次售卖的赞助点数量不能超过"..Config.maxCoinsValue, 'error')
        return 
    end
    if price > Config.maxDollarValue then
        TriggerClientEvent("QBCore:Notify", src, "单次售价不能超过 $ "..Config.maxDollarValue, 'error')
        return 
    end
    if amount % 1 ~= 0 or price % 1 ~= 0 then
        -- TriggerClientEvent("QBCore:Notify", src, "服务端检测到赞助点或美金为小数", 'error')
        exports['external_bansystem']:SystemBanPlayer(src, "您作弊：检测到传入的赞助点或美金为小数", nil)
        return
    end

    -- 检查该用户赞助点余额
    local license = GetPlayerIdentifierByType(src, 'license')
    local coins = exports['rb-donator']:GetCoins(license)
    if amount > coins then
        TriggerClientEvent("QBCore:Notify", src, "赞助点不足，余额: " .. coins, 'error')
        return
    end  
    -- 扣除该用户的赞助点
    local result, newCoins = exports['rb-donator']:RemoveCoins(license, amount)  -- 单线程环境这里必然成功，前面已经验证了
    -- 新售卖插入交易所
    if result then
        TriggerClientEvent("rb-donator:updateCoins", src, newCoins)  -- 更新客户端缓存的赞助点
        local cid = QBCore.Functions.GetPlayer(src).PlayerData.citizenid
        exports.oxmysql:insert([[
            INSERT INTO coins_exchanger (citizenid, amount, price)
            VALUES (?, ?, ?)
        ]], { cid, amount, price }, function(id)
            if id then
                TriggerClientEvent("QBCore:Notify", src, ("市民 %s 成功上架 %d 点赞助点，售价 $%d"):format(cid, amount, price))
            else
                TriggerClientEvent("QBCore:Notify", src, ("市民 %s 上架失败"):format(cid).."，原因: 数据库插入失败", 'error')
            end
        end)
    else
        TriggerClientEvent("QBCore:Notify", src, "扣除赞助点失败", 'error')
    end
end)

RegisterNetEvent("exchange:tryBuy", function(pCitizenid, pAmount, pPrice)
    local src = source
    local cid = pCitizenid
    local amount = tonumber(pAmount)
    local price = tonumber(pPrice)
    local buyer = QBCore.Functions.GetPlayer(src)
    -- 数据库操作
    local result = MySQL.query.await([[
        SELECT id FROM coins_exchanger
        WHERE citizenid = ? AND amount = ? AND price = ?
        ORDER BY created_at ASC
        LIMIT 1
    ]], {cid, amount, price})

    if result and result[1] then
        -- 检查买方银行余额是否足够
        if buyer.PlayerData.money.bank < price then
            TriggerClientEvent("QBCore:Notify", src, "您的银行余额不足", "error")
            return
        end
        -- 删除数据库对应记录
        local deleteCount = MySQL.update.await("DELETE FROM coins_exchanger WHERE id = ?", {result[1].id})  -- id唯一，仅会删除一条
        if deleteCount and deleteCount > 0 then
            -- 删除成功
            -- 扣除买方美金
            local removeSuccess = buyer.Functions.RemoveMoney('bank', price, '买入赞助点: '..amount)
            if removeSuccess then
                -- 增加卖方美金
                local seller = QBCore.Functions.GetPlayerByCitizenId(cid)
                if seller then
                    seller.Functions.AddMoney("bank", price, "卖出赞助点: "..amount)
                else
                    -- 如果卖家不在线，更新数据库
                    local playerRow = MySQL.single.await("SELECT money FROM players WHERE citizenid = ?", { cid })
                    if playerRow then
                        local money = json.decode(playerRow.money)
                        money.bank = (money.bank or 0) + price
                        MySQL.update.await("UPDATE players SET money = ? WHERE citizenid = ?", {
                            json.encode(money), cid
                        })
                    end
                end
                -- 增加买方赞助点
                local license = GetPlayerIdentifierByType(src, 'license')
                local newCoins = exports['rb-donator']:AddCoins(license, amount)
                TriggerClientEvent("rb-donator:updateCoins", src, newCoins)  -- 更新客户端缓存的赞助点
                -- 给买家发通知
                TriggerClientEvent("QBCore:Notify", src, "您获得赞助点: " .. amount .. ", 现在拥有: " .. newCoins)
                -- 给卖家发邮件
                local phoneNumber = exports["lb-phone"]:GetEquippedPhoneNumber(cid)
                local emailAddress = exports["lb-phone"]:GetEmailAddress(phoneNumber)
                local mailData = {
                    to = emailAddress,
                    sender = Config.exchangerName,
                    subject = "您的赞助点已卖出",
                    message = "卖出赞助点: "..amount..", 银行账户收入$ "..price
                }
                exports["lb-phone"]:SendMail(mailData)
            else
                -- 恢复数据库记录
                MySQL.insert.await([[
                    INSERT INTO coins_exchanger (citizenid, amount, price)
                    VALUES (?, ?, ?)
                ]], {cid, amount, price})
            end
        else
            -- 删除失败（理论上不太可能到这一步，但保险）
            TriggerClientEvent("QBCore:Notify", src, "手慢了！该赞助点已经被人买走", "error")
        end
    end
end)