local Translations = {
    info = {
        insurance = '[E] 保险赔付',
        deliver_e = '~g~E~w~ - 交付产品',
        deliver = '交付产品',
    },
    error = {
        missing_license = '缺少 %s 许可证，无法购买某些产品',
        no_deposit = '需要 $%{value} 押金',
        cancelled = '已取消',
        vehicle_not_correct = '这不是一辆商业车辆！',
        no_driver = '你必须是驾驶员才能执行此操作..',
        no_work_done = "你还没有完成任何工作..",
        backdoors_not_open = "车辆的后门没有打开",
        get_out_vehicle = '你需要下车才能执行此操作',
        too_far_from_trunk = '你需要从车后备厢取箱子',
        too_far_from_delivery = '你需要靠近交付点',
    },
    success = {
        dealer_verify = '经销商已验证你的许可证',
        paid_with_cash = '$%{value} 押金已用现金支付',
        paid_with_bank = '$%{value} 押金已从银行支付',
        refund_to_cash = '$%{value} 押金已退款至现金',
        you_earned = '你赚了 $%{value}',
        payslip_time = '你访问了所有商店，时间到发放薪水单了！',
    },
    mission = {
        store_reached = '已到达商店，按 [E] 从车后备厢取箱子并交付到标记点',
        take_box = '取一个产品箱',
        deliver_box = '交付产品箱',
        another_box = '获取另一个产品箱',
        goto_next_point = '你已交付所有产品，前往下一个点',
        return_to_station = '你已交付所有产品，返回站点',
        job_completed = '你已完成任务',
    },
    menu = {
        insurance_menu_header = '选择您需要赔付车辆的车牌',
        close_menu = '取消赔付'
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
