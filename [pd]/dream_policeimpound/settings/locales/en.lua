--[[
    Thank you for using our script. We are happy to have you here. If you need help, you can join our Discord server.
    https://discord.gg/zppUXj4JRm
]]

DreamLocales['en'] = {
    ['NotifyHeader'] = '警察扣押',

    ['GlobalVehicle'] = {
        ['ImpoundTarget'] = {
            ['Name'] = '扣押车辆',
            ['Dialog'] = {
                ['Title'] = '🚓 车辆扣押',
                ['Model'] = '型号',
                ['Plate'] = '车牌',
                ['Officer'] = '警官',
                ['Duration'] = '扣押时长',
                ['Offence'] = '违规行为',
                ['OffencePlaceholder'] = '选择违规行为',
                ['Fine'] = '罚款',
                ['Note'] = '附加说明',
                ['NeedUnlock'] = '需先通过警察解锁，才能取回扣押车辆',
            },
            ['Notify'] = {
                ['ImpoundSuccess'] = '车辆 %s 已成功扣押。',
                ['ImpoundInfo'] = '您的车辆 %s 已被警方扣押。',
                ['ImpoundFail'] = {
                    ['WrongIdentifer'] = '无法扣押车辆 %s。',
                    ['NoOwner'] = '车辆 %s 没有车主。',
                }
            }
        }
    },
    ['LocalEntity'] = {
        ['ImpoundStation'] = {
            ['Name'] = '警察扣押站',
            ['Menu'] = {
                ['Title'] = '🚓 警察扣押站',
                ['PoliceVehicleDesc'] = '车主必须取回车辆',
                ['PoliceVehicleUnlockDesc'] = '点击解锁车辆',
                ['VehicleDesc'] = '点击取出车辆',
                ['VehicleUnlockDesc'] = '需要警官解锁车辆',
            },
            ['VehicleMetadata'] = {
                ['Status'] = '🚨 状态',
                ['Owner'] = '🤵 车主',
                ['Officer'] = '👮 警官',
                ['Modell'] = '🚗 型号',
                ['Plate'] = '🔢 车牌',
                ['Offence'] = '⚖️ 违规行为',
                ['Fine'] = '💰 罚款',
                ['Duration'] = '⏳ 扣押时长',
                ['Note'] = '📝 备注',
            },
            ['Notify'] = {
                ['NoImpoundVehicles'] = '扣押站中没有车辆',
                ['PoliceVehicleUnlockSuccess'] = '车辆已成功解锁',
                ['ImpoundVehicleInvalid'] = '扣押的车辆无效',
                ['ImpoundVehicleUnlockInfo'] = '您的车辆 %s 已被警方解锁',
                ['ImpoundVehicleDuration'] = '您需要等到 %s 才能取出车辆',
                ['ImpoundNotEnoughMoney'] = '您没有足够的钱取出车辆',
                ['ImpoundVehicleParkOut'] = '车辆已取出',
            }
        }
    }
}
