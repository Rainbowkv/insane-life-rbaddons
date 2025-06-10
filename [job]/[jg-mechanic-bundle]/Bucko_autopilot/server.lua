local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('Bucko_autopilot:server:degradeItem', function(itemName, slot, amount)
    local src = source
    local item = exports.ox_inventory:GetSlot(src, slot)

    if not item or item.name ~= itemName then return end
    local current = item.metadata.durability
    local newDurability = math.max(current - amount, 0)

    -- 更新耐久度
    exports.ox_inventory:SetMetadata(src, slot, {
        durability = newDurability
    })
end)