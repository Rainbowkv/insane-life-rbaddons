Config = {}

-- General Settings
Config.UseTarget = true -- Use target system (true) or DrawText (false)
Config.TargetSystem = 'ox' -- Options: 'qb' for qb-target, 'ox' for ox_target

-- Application Management System
Config.ApplicationSystem = 'internal' -- Options: 'internal' for built-in system, 'dw-bossmenu' for external dw-bossmenu
Config.ReviewLocations = {
    police = {
        pos = vector3(443.04, -979.62, 30.69),
        label = "查看警察应聘信息"
    },
    ambulance = {
        pos = vector3(310.5, -593, 43.28),
        label = "查看医护应聘信息"
    },
    -- lawyer = {
    --     pos = vector3(237.52, -413.1, 48.11),
    --     label = "Review Legal Applications"
    -- }
    -- mechanic = {
    --     pos = vector3(310.1, -599.43, 43.29),
    --     label = "查看技工应聘信息"
    -- },
}

-- Job Center Location
Config.JobCenterLocation = vector4(236.32, -409.39, 47.92, 338.72) -- Location of the job center
Config.JobCenterPed = `a_m_y_business_03` -- Ped model hash (consistent across restarts)

-- Blip Settings
Config.UseBlip = true
Config.Blip = {
    sprite = 407, -- Blip sprite (icon)
    color = 27, -- Blip color
    scale = 0.7, -- Blip size
    label = "Ravens招聘中心" -- Blip name on map
}

-- Job Order - This is the order jobs will appear in the menu
Config.JobOrder = {
    "police",
    "ambulance", 
    -- "lawyer",
    "mechanic",
    "taxi",
    "delivery"
}

-- Job Settings
Config.Jobs = {
    -- Whitelisted Jobs
    police = {
        label = "市区警察",
        department = "LSPD",
        salary = "$50,000/周",
        location = "密申罗警局",
        description = "保卫和服务洛圣都公民，维护Ravens秩序和执行法律。",
        requirements = {"近2周无案底", "身体强健，思维敏捷", "不争抢好胜，有正义感"},
        schedule = "24小时待命，可灵活轮班",
        benefits = {"医保：免费医疗", "餐补：各餐饮产业的折扣", "补贴：警车购买、加油和修车"},
        type = "申请制",
        questions = {
            "1个词（最多2个）形容你最突出的性格特点。",
            "为什么您想成为LSPD的一员？您如何理解LSPD的职责",
            "您经常与人产生冲突吗？如果与人冲突，您一般如何解决？",
            "您如何看待有案底的人员？如何看待帮派分子？",
            "您如何评价自己在ravens的这段生活，符合您预期吗？您期望什么样的生活？",
            "您是一位有耐心的人吗？",
            "IC号码和OOC联系方式:"
        },
        icon = "👮",
        grade = 0, -- Starting grade when accepted
        minReviewGrade = 4 -- Minimum grade required to review applications
    },
    ambulance = {
        label = "市区医护",
        department = "医疗急救",
        salary = "$35,000/周",
        location = "市医院",
        description = "为Ravens市的居民提供紧急医疗服务和日常健康保障，维护市民的生命安全。",
        requirements = {"近2周无案底", "身体强壮，善良包容", "具备团队合作精神，有责任心"},
        schedule = "24小时待命，可灵活轮班",
        benefits = {"医保：免费医疗", "餐补：各餐饮产业的折扣", "补贴：医疗设备购买、药品采购补贴"},
        type = "申请制",
        questions = {
            "1个词（最多2个）形容你最突出的性格特点。",
            "为什么您想成为Ravens医疗急救的一员？您如何理解急救人员的职责",
            "您如何处理高压环境下的突发情况？",
            "您有过急救经验吗？如何评价自己的急救技能？",
            "您如何看待患者的不同需求？如何确保为每位患者提供最佳的护理？",
            "您认为团队合作在医疗急救中有多重要？如何与团队成员有效协作？",
            "IC号码和OOC联系方式:"
        },
        icon = "🚑",
        grade = 0,
        minReviewGrade = 4
    },
    -- lawyer = {
    --     label = "Lawyer",
    --     department = "Legal Services",
    --     salary = "$6,000/week",
    --     location = "Los Santos Courthouse",
    --     description = "Provide legal representation and advice to citizens of Los Santos.",
    --     requirements = {"Legal knowledge", "Professional appearance"},
    --     schedule = "10:00 AM - 6:00 PM",
    --     benefits = {"Private office", "Professional network"},
    --     type = "whitelisted",
    --     icon = "⚖️",
    --     questions = {
    --         "Why did you choose to pursue a career in law?",
    --         "What areas of law are you most interested in?",
    --         "How would you handle an ethically challenging case?",
    --         "Describe your experience with legal documentation.",
    --         "How would you explain complex legal concepts to clients?"
    --     },
    --     grade = 0,
    --     minReviewGrade = 4
    -- },
    mechanic = {
        label = "车辆技工",
        department = "车辆维修",
        salary = "$20,000/周",
        location = "修车厂",
        description = "为Ravens市的居民和企业提供专业的车辆维修、保养与修复服务，确保市民的交通安全。",
        requirements = {"近2周无案底", "身体健康，具备一定的体力和耐力", "有良好的机械维修知识和技能，能独立完成各类车辆维修工作"},
        schedule = "24小时待命，可灵活轮班",
        benefits = {"车险：免费修车", "补贴：工具购买、维修设备补贴", "老板每周发额外福利"},
        type = "申请制",
        questions = {
            "1个词（最多2个）形容你最突出的性格特点。",
            "为什么您想成为Ravens市技工的一员？您如何理解技工的职责",
            "您有过哪些车辆维修经验？能否分享一项最具挑战性的维修案例？",
            "您如何确保车辆维修质量和效率？",
            "您认为与客户的沟通在工作中有多重要？如何处理客户的不同需求和问题？",
            "您如何看待技术进步和新工具的应用？您是否愿意不断学习新技能？",
            "IC号码和OOC联系方式:"
        },
        icon = "🔧",
        grade = 0,
        minReviewGrade = 4
    },

    -- Civilian Jobs
    taxi = {
        label = "出租司机",
        -- department = "Downtown Cab Co.",
        department = "出租车服务",
        salary = "多劳多得",
        location = "Ravens市各大区域",
        description = "为Ravens市的居民和游客提供便捷的交通服务，确保安全和舒适的出行体验。",
        requirements = {"对Ravens市路线熟悉，具备良好的服务态度"},
        schedule = "灵活工作时间，自由接单",
        benefits = {"零成本租车"},
        type = "兼职",
        icon = "🚕",
        grade = 0
    },
    delivery = {
        label = "邮政快递",
        -- department = "GoPostal",
        department = "邮政服务",
        salary = "多劳多得",
        location = "Ravens市各大区域",
        description = "为Ravens市的居民和企业提供及时的邮政和快递服务，确保邮件和包裹的安全和准时送达。",
        requirements = {"具备良好的身体素质，能承受搬运工作", "有较强的责任心，能有效管理时间"},
        schedule = "灵活工作时间，按需分配任务",
        benefits = {"零成本租车"},
        type = "兼职",
        icon = "📦",
        grade = 0
    }
}

Config.NotificationTypes = {
    ['success'] = 'success',
    ['error'] = 'error',
    ['info'] = 'primary'
}