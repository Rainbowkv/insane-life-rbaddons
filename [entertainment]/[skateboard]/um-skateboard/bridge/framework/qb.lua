if GetResourceState('qb-core') ~= 'started' or GetResourceState('qbx_core') == 'started' then return end

local config = require 'shared.config'

local QBCore = exports['qb-core']:GetCoreObject()

function AddItem(src, pProp)
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if pProp == config.prop then
        Player.Functions.AddItem(config.item, 1)
    elseif pProp == config.prop2 then
        Player.Functions.AddItem(config.item2, 1)
    end
end

function RemoveItem(src, pProp)
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if pProp == config.prop then
        Player.Functions.RemoveItem(config.item, 1)
    elseif pProp == config.prop2 then
        Player.Functions.RemoveItem(config.item2, 1)
    end
end

QBCore.Functions.CreateUseableItem(config.item, function(source)
    TriggerClientEvent("um-skateboard:spawn:skateboard", source, config.prop)
end)

QBCore.Functions.CreateUseableItem(config.item2, function(source)
    TriggerClientEvent("um-skateboard:spawn:skateboard", source, config.prop2)
end)