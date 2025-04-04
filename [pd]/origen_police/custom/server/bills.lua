RegisterServerEvent("origen_police:server:PayBill", function(args)
    local src = source
    local Player = FW_GetPlayer(src)
    if not Player then return end
    if(Player.PlayerData.money.bank < tonumber(args.price)) then
        TriggerClientEvent('origen_police:ShowNotification', src, "You don't have enough money")
        return
    end
    Player.Functions.RemoveMoney("bank", tonumber(args.price), "paid-bill")
    PayBill(args.id)
    local societyTarget = args.job
    for _, jobData in pairs(Config.JobCategory) do
        for _, job in pairs(jobData) do
            if job.name == args.job then
                societyTarget = job.society
            end
        end
    end
    AddMoneyToSociety(tonumber(args.price), societyTarget)
    CreateLog({
        type = 'Bills',
        embed = {
            title = Config.LogsTranslations.PayBill.title,
            description = Config.LogsTranslations.PayBill.message:format(args.price, args.id),
            color = 0x1B55BF,
        },
        source = src,
    })
end)