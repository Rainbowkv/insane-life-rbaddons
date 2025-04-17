if not Lang then Lang = {} end
Lang['en'] = {
    ['markers'] = {
        ['open_refuel'] = "按 ~INPUT_CONTEXT~ 加油",
        ['open_recharge'] = "按 ~INPUT_CONTEXT~ 充电",
        ['interact_with_vehicle'] = "按 ~y~E~w~ 与车辆互动",
        ['return_nozzle'] = "按 ~INPUT_CONTEXT~ 归还加油枪",
    },
    ['target'] = {
        ['open_refuel'] = "打开加油菜单",
        ['open_recharge'] = "打开充电菜单",
        ['start_refuel'] = "开始加油",
        ['stop_refuel'] = "停止加油",
        ['return_nozzle'] = "归还加油枪",
    },
    ['blip_text'] = "加油站",
    ['not_enough_refuel'] = "您已经用完了支付的燃油。如需继续，请购买更多燃油。",
    ['invalid_value'] = "无效值",
    ['not_enough_money'] = "您没有足够的钱支付 $%s",
    ['not_enough_stock'] = "该加油站库存不足，无法完成此操作",
    ['refuel_paid'] = "已支付 $%s 用于加油",
    ['returned_fuel'] = "您退还了 %sL 燃油，并收到 $%s",
    ['returned_charge'] = "您退还了 %skWh 电量，并收到 $%s",
    ['jerry_can_paid'] = "已支付 $%s 购买油桶",
    ['too_far_away'] = "您离加油泵太远",
    ['vehicle_refueled'] = "您为车辆添加了 %sL 燃油",
    ['vehicle_recharged'] = "您为车辆充入了 %skWh 电量",
    ['vehicle_tank_full'] = "车辆油箱已满",
    ['vehicle_tank_emptied'] = "车辆油箱已空",
    ['vehicle_not_found'] = "未找到车辆",
    ['pump_not_found'] = "未找到加油泵",
    ['vehicle_wrong_fuel'] = "您使用了错误的燃油类型，导致车辆故障。",
    ['incompatible_fuel'] = "检测到不兼容的燃油类型。请选择适合您车辆的加油选项。",
    ['owned_gas_stations'] = {
        ['balance_jerry_can'] = "售出油桶 (%s 升)",
        ['balance_fuel'] = "售出燃油 (%s 升)",
        ['balance_electric'] = "售出电量 (%s 千瓦时)",
    }
}