function reqModel(model)
    local modelHash = GetHashKey(model)
    if not IsModelInCdimage(modelHash) then
        debugPrint('WARNING', 1, ('Object model [^6%s^7] is invalid. Spawning skipped.'):format(model))
        return false
    end
    if not HasModelLoaded(modelHash) then
        RequestModel(modelHash)
        while not HasModelLoaded(modelHash) do
            Wait(0)
        end
    end
    return true
end

function spawnObj(model, coords, network)
    local modelHash = GetHashKey(model)
    if not reqModel(model) then
        return
    end
    local obj = CreateObject(modelHash, coords.xyz, network, false, true)
    SetEntityHeading(obj, coords.w)
    FreezeEntityPosition(obj, true)
    table.insert(spawnedObjects, obj)
    return obj
end

function spawnPed(model, coords, network)
    if not reqModel(model) then
        return
    end
    local dealerEntity = CreatePed(26, model, coords, network, true)
    table.insert(spawnedObjects, dealerEntity)
    SetModelAsNoLongerNeeded(dealerModel)     
    SetEntityCanBeDamaged(dealerEntity, false)
    SetPedAsEnemy(dealerEntity, 0)   
    SetBlockingOfNonTemporaryEvents(dealerEntity, true)
    SetPedResetFlag(dealerEntity, 249, 1)
    SetPedConfigFlag(dealerEntity, 185, true)
    SetPedConfigFlag(dealerEntity, 108, true)
    SetPedCanEvasiveDive(dealerEntity, 0)
    SetPedCanRagdollFromPlayerImpact(dealerEntity, false)
    SetPedConfigFlag(dealerEntity, 208, true)
    SetEntityVisible(dealerEntity, false, false)
    FreezeEntityPosition(dealerEntity, true)
    NetworkSetEntityInvisibleToNetwork(dealerEntity, false)
    
    Citizen.CreateThread(function()
        Citizen.Wait(500)
        SetEntityVisible(dealerEntity, true, true)
    end)
    return dealerEntity
end

local QBCore = exports['qb-core']:GetCoreObject()

-- rb_code
-- 创建目标
CreateThread(function()
    local model = Config.ExchangeNPC.model
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(0) end

    local ped = CreatePed(0, model, Config.ExchangeNPC.coords.x, Config.ExchangeNPC.coords.y, Config.ExchangeNPC.coords.z - 1.0, Config.ExchangeNPC.coords.w, false, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)

    exports.ox_target:addLocalEntity(ped, {
        {
            icon = 'fa-solid fa-coins',
            label = '兑换筹码',
            onSelect = function()
                openChipExchangeInput()
            end
        },
        {
            icon = 'fa-solid fa-money-bill-wave',
            label = '兑换现金',
            onSelect = function()
                openChipCashoutInput()
            end
        },
    })
end)

-- 打开输入对话框
function openChipExchangeInput()
    local input = exports['qb-input']:ShowInput({
        header = "兑换筹码",
        submitText = "兑换",
        inputs = {
            {
                type = 'number',
                name = 'amount',
                text = '请输入要兑换的筹码数量',
                isRequired = true
            }
        }
    })

    if not input then
        return
    end

    local amount = tonumber(input.amount)
    if not amount or amount <= 0 then
        QBCore.Functions.Notify('请输入有效的筹码数量', 'error')
        return
    end
    if amount > Config.maxValue then
        QBCore.Functions.Notify('单次兑换筹码不能超过' .. Config.maxValue, 'error')
        return
    end

    TriggerServerEvent('sb-poker:server:exchangeChips', amount)
end

function openChipCashoutInput()
    local input = exports['qb-input']:ShowInput({
        header = "兑换现金",
        submitText = "兑换",
        inputs = {
            {
                type = 'number',
                name = 'amount',
                text = '请输入要兑换的现金数量, 手续费'.. math.ceil(Config.CashoutFeeRatio*100) ..'%',
                isRequired = true
            }
        }
    })

    if not input then return end

    local amount = tonumber(input.amount)
    if not amount or amount <= 0 then
        QBCore.Functions.Notify('请输入有效的筹码数量', 'error')
        return
    end
    if amount > Config.maxValue then
        QBCore.Functions.Notify('单次兑换筹码不能超过' .. Config.maxValue, 'error')
        return
    end

    TriggerServerEvent('sb-poker:server:cashoutChips', amount)
end