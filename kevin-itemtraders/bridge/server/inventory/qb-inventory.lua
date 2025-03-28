if GetResourceState('ps-inventory') ~= 'started' then return end

local qbInventory = exports['ps-inventory']

function removeItem(source, item, amount, metadata)
    return qbInventory:RemoveItem(source, item, amount, metadata)
end

function getItemCount(source, item)
    return qbInventory:GetItemCount(source, item)
end

lib.callback.register('kevin-itemtraders:server:getItemCount', function(source, item)
    return getItemCount(source, item)
end)