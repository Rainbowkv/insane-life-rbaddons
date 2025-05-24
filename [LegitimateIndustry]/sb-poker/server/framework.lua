Poker = {}
Poker.FrameworkObject = nil -- Holds ESX or QBCore objects
Poker.FrameworkType = ''
Poker.ResourceFolderName = nil

Poker.PendingMoneyReturns = {
    -- ['char1:1234'] = {amount = 200, table = 'casino_01'},
}

local function fetchSharedObject(resourceName, exportName, eventName)
    Poker.ResourceFolderName = resourceName
    try(function()
        Poker.FrameworkObject = exports[resourceName][exportName]()
    end, function (err)
        print(err)
        TriggerEvent(eventName, function (Obj)
            Poker.FrameworkObject = Obj
        end)
        Citizen.CreateThread(function()
            Citizen.Wait(200)
            if not Poker.FrameworkObject then
                debugPrint('^8ERROR^7', -1, 'Framework loading failed. Given parameters:')
                debugPrint('^8ERROR^7', -1, ('Framework name: ^4%s^7, event name: ^4%s^7, export function name: ^4%s^7, used type: ^4%s^7'):format(Config.Framework, eventName, exportName, Poker.FrameworkType))
                debugPrint('NOTE', -1, 'If any of the parameters do not match your server settings please check your ^4*/framework.lua^7 files')
                Poker.FrameworkType = 'custom'
            end
        end)
    end)
end

local function parseResourceNameFromPath (path)
    local index = string.find(path, "/[^/]*$")
    return string.sub(path, index + 1)
end

Citizen.CreateThread(function()
    if Config.Framework == 'auto' then
        if GetResourceState('es_extended') == 'started' then
            Poker.FrameworkType = 'esx'
        elseif GetResourceState('qb-core') == 'started' then
            Poker.FrameworkType = 'qbcore'
        else
            Poker.FrameworkType = 'custom'
        end
    elseif Config.Framework == 'esx' then
        Poker.FrameworkType = 'esx'
    elseif Config.Framework == 'qbcore' then
        Poker.FrameworkType = 'qbcore'
    else
        Poker.FrameworkType = 'custom'
    end
    
    local evName = IsDuplicityVersion() and Config.FrameworkData.SharedObjectEventNameSV or Config.FrameworkData.SharedObjectEventNameCL
    if Poker.FrameworkType == 'esx' then
        fetchSharedObject(parseResourceNameFromPath(GetResourcePath('es_extended')), 'getSharedObject', evName or 'esx:getSharedObject')
    elseif Poker.FrameworkType == 'qbcore' then
        if GetResourceState('qbx_core') == 'started' then
            fetchSharedObject('qb-core', 'GetCoreObject', evName or 'QBCore:GetObject')
        else
            fetchSharedObject(parseResourceNameFromPath(GetResourcePath('qb-core')), 'GetCoreObject', evName or 'QBCore:GetObject')
        end
    elseif Poker.FrameworkType == 'custom' then
        -- Add code for your custom framework
        debugPrint('^8ERROR^7', -1, 'Framework loading failed. No code for custom framework provided, check your ^4*/framework.lua^7 files')
    end

    debugPrint('FRAMEWORK', -1, ('Framework name: ^4%s^7, event name: ^4%s^7, export function name: ^4%s^7, used type: ^4%s^7'):format(Config.Framework, eventName, exportName, Poker.FrameworkType))
end)

Poker.CheckPlayerEligible = function(source, tableName, buyIn)
    local tableData = getTableCfgByName(tableName)
    if Poker.FrameworkType == 'esx' then
        local currencryChecks = {
            ['cash'] = function(playerId, buyIn)
                local xPlayer = Poker.FrameworkObject.GetPlayerFromId(playerId)
                if xPlayer.getAccount('money').money >= buyIn then
                    return true
                end
            end,
            ['chips'] = function(playerId, buyIn)
                -- ------------------------------------------
                -- Example of item 'chips' implementation (using chips as inventory item):
                -- ------------------------------------------
                local xPlayer = Poker.FrameworkObject.GetPlayerFromId(playerId)
                if xPlayer.getInventoryItem(Config.ChipsItem).count >= buyIn and buyIn >= tableData.buyIn then
                    return true
                end
            end,
            ['custom'] = function(playerId, money)
                -- Add code for custom currency
            end
        }

        return currencryChecks[tableData.currency](source, buyIn)
    elseif Poker.FrameworkType == 'qbcore' then
        local currencryChecks = {
            ['cash'] = function(playerId, buyIn)
                local ply = Poker.FrameworkObject.Functions.GetPlayer(playerId)
                if type(ply.Functions.GetMoney("cash")) == 'number' then
                    return ply.Functions.GetMoney("cash") >= buyIn
                elseif type(ply.Functions.GetMoney("cash")) == 'table' then
                    return ply.Functions.GetMoney("cash")?.money >= buyIn
                else
                    debugPrint('ERROR', -1, 'Error in getting player money. Please check your framework.lua file Poker.CheckPlayerEligible function')
                    return false
                end
            end,
            ['chips'] = function(playerId, buyIn)
                -- ------------------------------------------
                -- Example of item 'chips' implementation (using chips as inventory item):
                -- ------------------------------------------
                local ply = Poker.FrameworkObject.Functions.GetPlayer(playerId)
                if ply.Functions.GetItemByName(Config.ChipsItem) and ply.Functions.GetItemByName(Config.ChipsItem).amount >= buyIn and buyIn >= tableData.buyIn then
                    return true
                end
            end,
            ['custom'] = function(playerId, money)
                -- Add code for custom currency
            end
        }
        return currencryChecks[tableData.currency](source, buyIn)
    end
    return false
end

Poker.RemoveCurrency = function(source, tableName, amount)
    if amount <= 0 then return end  -- '<0' -> '<=0'
    local tableData = getTableCfgByName(tableName)
    debugPrint('RemoveCurrency', 3, Poker.FrameworkType, source, tableName, amount)
    if Poker.FrameworkType == 'esx' then
        local currencryChecks = {
            ['cash'] = function(playerId, money)
                local xPlayer = Poker.FrameworkObject.GetPlayerFromId(playerId)
                xPlayer.removeAccountMoney('money', money)
            end,
            ['chips'] = function(playerId, money)
                -- ------------------------------------------
                -- Example of item 'chips' implementation (using chips as inventory item):
                -- ------------------------------------------
                local xPlayer = Poker.FrameworkObject.GetPlayerFromId(playerId)
                xPlayer.removeInventoryItem(Config.ChipsItem, money, {})
            end,
            ['custom'] = function(playerId, money)
                -- Add code for custom currency
            end
        }

        return currencryChecks[tableData.currency](source, amount)
    elseif Poker.FrameworkType == 'qbcore' then
        local currencryChecks = {
            ['cash'] = function(playerId, money)
                local ply = Poker.FrameworkObject.Functions.GetPlayer(playerId)
                ply.Functions.RemoveMoney('cash', money)
            end,
            ['chips'] = function(playerId, money)
                -- ------------------------------------------
                -- Example of item 'chips' implementation (using chips as inventory item):
                -- ------------------------------------------
                local ply = Poker.FrameworkObject.Functions.GetPlayer(playerId)
                ply.Functions.RemoveItem(Config.ChipsItem, money)
            end,
            ['custom'] = function(playerId, money)
                -- Add code for custom currency
            end
        }

        return currencryChecks[tableData.currency](source, amount)

    end
end

Poker.AddCurrency = function(source, tableName, amount)
    if amount <= 0 then return end  -- '<0' -> '<=0'
    local tableData = getTableCfgByName(tableName)
    debugPrint('AddCurrency', 3, Poker.FrameworkType, source, tableName, amount)
    if Poker.FrameworkType == 'esx' then
        local currencryChecks = {
            ['cash'] = function(playerId, money)
                local xPlayer = Poker.FrameworkObject.GetPlayerFromId(playerId)
                if xPlayer then
                    xPlayer.addAccountMoney('money', money)
                    return true
                else
                    return false
                end
            end,
            ['chips'] = function(playerId, money)
                -- ------------------------------------------
                -- Example of item 'chips' implementation (using chips as inventory item):
                -- ------------------------------------------
                local xPlayer = Poker.FrameworkObject.GetPlayerFromId(playerId)
                if xPlayer then 
                    xPlayer.addInventoryItem(Config.ChipsItem, money, {})
                    return true
                else
                    return false
                end
            end,
            ['custom'] = function(playerId, money)
                -- Add code for custom currency
                -- AFTER IMPLEMENTING RETURN TRUE
                return false
            end
        }

        return currencryChecks[tableData.currency](source, amount)
    elseif Poker.FrameworkType == 'qbcore' then

        local currencryChecks = {
            ['cash'] = function(playerId, money)
                local ply = Poker.FrameworkObject.Functions.GetPlayer(playerId)
                if ply then
                    ply.Functions.AddMoney('cash', money)
                    return true
                else
                    return false
                end
            end,
            ['chips'] = function(playerId, money)
                -- ------------------------------------------
                -- Example of item 'chips' implementation (using chips as inventory item):
                -- ------------------------------------------
                local ply = Poker.FrameworkObject.Functions.GetPlayer(playerId)
                if ply then
                    ply.Functions.AddItem(Config.ChipsItem, money)
                    return true
                else
                    return false
                end
            end,
            ['custom'] = function(playerId, money)
                -- Add code for custom currency
                -- AFTER IMPLEMENTING RETURN TRUE
                return false
            end
        }
        return currencryChecks[tableData.currency](source, amount)
    end
end

Poker.GetPlayerIdentifier = function (source)
    if Poker.FrameworkType == 'esx' then
        local xPlayer = Poker.FrameworkObject.GetPlayerFromId(source)
        return xPlayer?.identifier and xPlayer.identifier or GetPlayerIdentifiers(source)[1]
    elseif Poker.FrameworkType == 'qbcore' then
        local ply = Poker.FrameworkObject.Functions.GetPlayer(source)
        return ply.PlayerData.citizenid
    else
        return GetPlayerIdentifiers(source)[1]
    end
end

Poker.GetPlayerName = function (source)
    if Poker.FrameworkType == 'esx' then
        local xPlayer = Poker.FrameworkObject.GetPlayerFromId(source)
        return xPlayer?.getName and xPlayer.getName() or GetPlayerName(source)
    elseif Poker.FrameworkType == 'qbcore' then
        local ply = Poker.FrameworkObject.Functions.GetPlayer(source)
        if ply then
            if ply.PlayerData.charinfo?.firstname then
                return ply.PlayerData.charinfo.firstname
            else
                return ply.PlayerData.name
            end
        else
            return GetPlayerName(source) -- Fallback to default
        end
    else
        return GetPlayerName(source)
    end
end

Poker.SendNotificationFromServer = function (source, message, type)
    if Poker.FrameworkType == 'esx' then
        local xPlayer = Poker.FrameworkObject.GetPlayerFromId(source)
        xPlayer.showNotification(message, type)
    elseif Poker.FrameworkType == 'qbcore' then
        local ply = Poker.FrameworkObject.Functions.GetPlayer(source)
        ply.Functions.Notify(message, type)
    else
        -- Add code for your custom framework
    end
end

Poker.PlayerDropMoneyErrorHandler = function(err, playerId, playerIdentifier, stackSize, pokerTable)
    -- Add code to handle player drop money return errors
    -- This is ONLY needed if players when disconnecting from sevrer do not get their money back
    debugPrint('SAVING PENDING MONEY RETURN', 1, ('Player %s was dropped from server. Saving pending %s money return.'):format(playerIdentifier, stackSize))
    Poker.PendingMoneyReturns[playerIdentifier] = {
        amount = stackSize,
        table = pokerTable
    }

    debugPrint('ERROR', -1, 'Player money was not returned on player drop. Error: ', err)
end

---@class Card
---@field suit string
---@field rank string

---SendGameFinishLog
---@param players {payoutType: 'prize' | 'return', playerId: number, amount: number, cards: Card[]
Poker.SendGameFinishLog = function(players, totalPot)
    local embed = {}
    local message = ''
    for _, player in pairs(players) do
        local playerName = Poker.GetPlayerName(player.playerId) or player.playerId
        local cardsFormatted = ''
        for _, card in pairs(player.cards) do
            cardsFormatted = cardsFormatted..' rank: '..card.rank..' suit: '..card.suit..' |\n'
        end
        if player.payoutType == 'prize' then
            message = message..'<'..playerName..'> won '..player.amount..'$.\nCards:\n'..cardsFormatted..'\n'
        elseif player.payoutType == 'return' then
            message = message..'<'..playerName..'> had '..player.amount..'$.\nCards:\n'..cardsFormatted..' returned\n'
        end
    end

    message = message..'Total pot: '..totalPot..'\n'
    message = message..'<t:'..os.time()..':f>'

    embed = {
        {
            ["color"] = 14177041,
            ["title"] = 'Game Finished',
            ["description"] =  ""..message.."",
            -- ["footer"] ={
            --     ["text"] = "<t:"..os.time()..":f> (Server Time).",
            -- },
        }
    }
    PerformHttpRequest(Config.LogsWebhook,
        function(err, text, headers)end, 
        'POST',
        json.encode({
            username = 'SB-POKER',
            embeds = embed
        }), 
        { 
            ['Content-Type']= 'application/json' 
        }
    )
end

---Called on player drop
---@param playerId string Player identifier used in poker
---@param pokerTable 
---@param debug any
function Poker.OnPlayerDropped(playerId, playerIdentifier, pokerTable, debug)
    debugPrint('PLAYER REMOVED', 1, 'Player was dropped from server. Removing from table.')
end

onServerCB(SVCB.FETCH_FRAMEWORK_RESOURCE_NAME, function (_, cb)
    cb(Poker.ResourceFolderName)
end)

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer, isNew)
    local identifier = Poker.GetPlayerIdentifier(playerId)

    if identifier then
        if Poker.PendingMoneyReturns[identifier] then
            local amount = Poker.PendingMoneyReturns[identifier].amount
            local table = Poker.PendingMoneyReturns[identifier].table
            Poker.AddCurrency(playerId, table, amount)
            Poker.PendingMoneyReturns[identifier] = nil
            debugPrint('RETURNING PENDING MONEY', 1, ('Player %s was loaded. Returning pending money.'):format(identifier))
        end
    end
end)

AddEventHandler('QBCore:Server:PlayerLoaded', function(Player)
    Wait(1000) -- 1 second should be enough to do the preloading in other resources
    local identifier = Poker.GetPlayerIdentifier(Player.PlayerData.source)

    if identifier then
        if Poker.PendingMoneyReturns[identifier] then
            local amount = Poker.PendingMoneyReturns[identifier].amount
            local table = Poker.PendingMoneyReturns[identifier].table
            Poker.AddCurrency(Player.PlayerData.source, table, amount)
            Poker.PendingMoneyReturns[identifier] = nil
            debugPrint('RETURNING PENDING MONEY', 1, ('Player %s was loaded. Returning pending money.'):format(identifier))
        end
    end
end)

-- rb_code
local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('sb-poker:server:exchangeChips', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    amount = tonumber(amount)

    if not amount or amount <= 0 or amount > Config.maxValue then return end

    local price = amount
    if Player.Functions.RemoveMoney('cash', price, '现金兑换筹码') then
        exports.ox_inventory:AddItem(src, Config.ChipsItem, amount)
    else
        TriggerClientEvent('ox_lib:notify', src, {
            type = 'error',
            description = '你没有足够的现金'
        })
    end
end)

RegisterNetEvent('sb-poker:server:cashoutChips', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    amount = tonumber(amount)
    if not amount or amount <= 0 or amount > Config.maxValue then return end

    local inv = exports.ox_inventory:Search(src, 'count', Config.ChipsItem)

    if inv < amount then
        TriggerClientEvent('ox_lib:notify', src, {
            type = 'error',
            description = '你没有足够的筹码, 若背包多叠筹码请将它们堆叠在一起'
        })
        return
    end

    local fee = math.ceil(amount * Config.CashoutFeeRatio)
    local finalCash = amount - fee

    exports.ox_inventory:RemoveItem(src, Config.ChipsItem, amount)
    Player.Functions.AddMoney('cash', finalCash, '筹码兑换现金')
    exports['qb-banking']:AddMoney(Config.casinoAccount, fee, "筹码兑换手续费")  

    TriggerClientEvent('ox_lib:notify', src, {
        type = 'success',
        description = ('消耗 %s 个筹码，收到 $%s 现金（扣除手续费 $%s）'):format(amount, finalCash, fee),
        duration = 5000
    })
end)