DP = {}

DP.Expressions = {
    ["愤怒"] = {"Expression", "mood_angry_1"},
    ["醉酒"] = {"Expression", "mood_drunk_1"},
    ["呆滞"] = {"Expression", "pose_injured_1"},
    ["触电"] = {"Expression", "electrocuted_1"},
    ["脾气暴躁"] = {"Expression", "effort_1"},
    ["脾气暴躁2"] = {"Expression", "mood_drivefast_1"},
    ["脾气暴躁3"] = {"Expression", "pose_angry_1"},
    ["快乐"] = {"Expression", "mood_happy_1"},
    ["受伤"] = {"Expression", "mood_injured_1"},
    ["愉悦"] = {"Expression", "mood_dancing_low_1"},
    ["张嘴呼吸"] = {"Expression", "smoking_hold_1"},
    ["从不眨眼"] = {"Expression", "pose_normal_1"},
    ["一只眼"] = {"Expression", "pose_aiming_1"},
    ["震惊"] = {"Expression", "shocked_1"},
    ["震惊2"] = {"Expression", "shocked_2"},
    ["睡觉"] = {"Expression", "mood_sleeping_1"},
    ["睡觉2"] = {"Expression", "dead_1"},
    ["睡觉3"] = {"Expression", "dead_2"},
    ["得意"] = {"Expression", "mood_smug_1"},
    ["沉思"] = {"Expression", "mood_aiming_1"},
    ["压力大"] = {"Expression", "mood_stressed_1"},
    ["生气"] = {"Expression", "mood_sulk_1"},
    ["奇怪"] = {"Expression", "effort_2"},
    ["奇怪2"] = {"Expression", "effort_3"},
}

DP.Walks = {
    ["外星人"] = {"move_m@alien"},
    ["装甲"] = {"anim_group_move_ballistic"},
    ["傲慢"] = {"move_f@arrogant@a"},
    ["勇敢"] = {"move_m@brave"},
    ["休闲"] = {"move_m@casual@a"},
    ["休闲2"] = {"move_m@casual@b"},
    ["休闲3"] = {"move_m@casual@c"},
    ["休闲4"] = {"move_m@casual@d"},
    ["休闲5"] = {"move_m@casual@e"},
    ["休闲6"] = {"move_m@casual@f"},
    ["奇奇"] = {"move_f@chichi"},
    ["自信"] = {"move_m@confident"},
    ["警察"] = {"move_m@business@a"},
    ["警察2"] = {"move_m@business@b"},
    ["警察3"] = {"move_m@business@c"},
    ["默认女性"] = {"move_f@multiplayer"},
    ["默认男性"] = {"move_m@multiplayer"},
    ["醉酒"] = {"move_m@drunk@a"},
    ["微醉"] = {"move_m@drunk@slightlydrunk"},
    ["醉酒2"] = {"move_m@buzzed"},
    ["大醉"] = {"move_m@drunk@verydrunk"},
    ["妩媚"] = {"move_f@femme@"},
    ["火焰1"] = {"move_characters@franklin@fire"},
    ["火焰2"] = {"move_characters@michael@fire"},
    ["火焰3"] = {"move_m@fire"},
    ["逃跑"] = {"move_f@flee@a"},
    ["富兰克林"] = {"move_p_m_one"},
    ["黑帮"] = {"move_m@gangster@generic"},
    ["黑帮2"] = {"move_m@gangster@ng"},
    ["黑帮3"] = {"move_m@gangster@var_e"},
    ["黑帮4"] = {"move_m@gangster@var_f"},
    ["黑帮5"] = {"move_m@gangster@var_i"},
    ["摇摆"] = {"anim@move_m@grooving@"},
    ["守卫"] = {"move_m@prison_gaurd"},
    ["手铐"] = {"move_m@prisoner_cuffed"},
    ["高跟鞋"] = {"move_f@heels@c"},
    ["高跟鞋2"] = {"move_f@heels@d"},
    ["徒步"] = {"move_m@hiking"},
    ["嬉皮"] = {"move_m@hipster@a"},
    ["流浪汉"] = {"move_m@hobo@a"},
    ["匆忙"] = {"move_f@hurry@a"},
    ["清洁工"] = {"move_p_m_zero_janitor"},
    ["清洁工2"] = {"move_p_m_zero_slow"},
    ["慢跑"] = {"move_m@jog@"},
    ["莱马"] = {"anim_group_move_lemar_alley"},
    ["莱斯特"] = {"move_heist_lester"},
    ["莱斯特2"] = {"move_lester_caneup"},
    ["猎艳高手"] = {"move_f@maneater"},
    ["迈克尔"] = {"move_ped_bucket"},
    ["金钱"] = {"move_m@money"},
    ["肌肉男"] = {"move_m@muscle@a"},
    ["优雅"] = {"move_m@posh@"},
    ["优雅2"] = {"move_f@posh@"},
    ["快速"] = {"move_m@quick"},
    ["跑步者"] = {"female_fast_runner"},
    ["悲伤"] = {"move_m@sad@a"},
    ["泼辣"] = {"move_m@sassy"},
    ["泼辣2"] = {"move_f@sassy"},
    ["害怕"] = {"move_f@scared"},
    ["性感"] = {"move_f@sexy@a"},
    ["可疑"] = {"move_m@shadyped@a"},
    ["缓慢"] = {"move_characters@jimmy@slow@"},
    ["炫耀"] = {"move_m@swagger"},
    ["硬汉"] = {"move_m@tough_guy@"},
    ["硬汉2"] = {"move_f@tough_guy@"},
    ["垃圾"] = {"clipset@move@trash_fast_turn"},
    ["垃圾2"] = {"missfbi4prepp1_garbageman"},
    ["特雷弗"] = {"move_p_m_two"},
    ["宽步"] = {"move_m@bag"},
    -- 这些似乎不起作用，如果有人知道解决办法请告知
    --["谨慎"] = {"move_m@caution"},
    --["胖胖"] = {"anim@move_m@chubby@a"},
    --["疯狂"] = {"move_m@crazy"},
    --["欢乐"] = {"move_m@joy@a"},
    --["力量"] = {"move_m@power"},
    --["悲伤2"] = {"anim@move_m@depression@a"},
    --["悲伤3"] = {"move_m@depression@b"},
    --["悲伤4"] = {"move_m@depression@d"},
    --["涉水"] = {"move_m@wading"},
}

DP.Shared = {
    --[emotename] = {dictionary, animation, displayname, targetemotename, additionalanimationoptions}
    -- you dont have to specify targetemoteanem, if you do dont it will just play the same animation on both.
    -- targetemote is used for animations that have a corresponding animation to the other player.
    ["handshake"] = {"mp_ped_interaction", "handshake_guy_a", "握手", "handshake2", AnimationOptions =
    {
        EmoteMoving = true,
        EmoteDuration = 3000,
        SyncOffsetFront = 0.9
    }},
    ["handshake2"] = {"mp_ped_interaction", "handshake_guy_b", "握手 2", "handshake", AnimationOptions =
    {
        EmoteMoving = true,
        EmoteDuration = 3000
    }},
    ["hug"] = {"mp_ped_interaction", "kisses_guy_a", "拥抱", "hug2", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteDuration = 5000,
        SyncOffsetFront = 1.05,
    }},
    ["hug2"] = {"mp_ped_interaction", "kisses_guy_b", "拥抱 2", "hug", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteDuration = 5000,
        SyncOffsetFront = 1.13
    }},
    ["bro"] = {"mp_ped_interaction", "hugs_guy_a", "兄弟", "bro2", AnimationOptions =
    {
         SyncOffsetFront = 1.14
    }},
    ["bro2"] = {"mp_ped_interaction", "hugs_guy_b", "兄弟 2", "bro", AnimationOptions =
    {
         SyncOffsetFront = 1.14
    }},
    ["give"] = {"mp_common", "givetake1_a", "给予", "give2", AnimationOptions =
    {
        EmoteMoving = true,
        EmoteDuration = 2000
    }},
    ["give2"] = {"mp_common", "givetake1_b", "给予 2", "give", AnimationOptions =
    {
        EmoteMoving = true,
        EmoteDuration = 2000
    }},
    ["baseball"] = {"anim@arena@celeb@flat@paired@no_props@", "baseball_a_player_a", "棒球挥杆", "baseballthrow"},
    ["baseballthrow"] = {"anim@arena@celeb@flat@paired@no_props@", "baseball_a_player_b", "投掷棒球", "baseball"},
    ["stickup"] = {"random@countryside_gang_fight", "biker_02_stickup_loop", "抢劫", "stickupscared", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["stickupscared"] = {"missminuteman_1ig_2", "handsup_base", "被抢害怕", "stickup", AnimationOptions =
    {
       EmoteMoving = true,
       EmoteLoop = true,
    }},
    ["punch"] = {"melee@unarmed@streamed_variations", "plyr_takedown_rear_lefthook", "拳击", "punched"},
    ["punched"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_cross_r", "被打", "punch"},
    ["headbutt"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_headbutt", "顶头", "headbutted"},
    ["headbutted"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_headbutt", "被顶头", "headbutt"},
    ["slap2"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_backslap", "拍打 2", "slapped2", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
        EmoteDuration = 2000,
    }},
    ["slap"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_slap", "拍打", "slapped", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
        EmoteDuration = 2000,
    }},
    ["slapped"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_slap", "被打", "slap"},
    ["slapped2"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_backslap", "被打 2", "slap2"},
}

DP.Dances = {
    ["dancef"] = {"anim@amb@nightclub@dancers@solomun_entourage@", "mi_dance_facedj_17_v1_female^1", "舞蹈F", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dancef2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "high_center", "舞蹈F2", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dancef3"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "high_center_up", "舞蹈F3", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dancef4"] = {"anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", "hi_dance_facedj_09_v2_female^1", "舞蹈F4", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dancef5"] = {"anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", "hi_dance_facedj_09_v2_female^3", "舞蹈F5", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dancef6"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "high_center_up", "舞蹈F6", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["danceslow2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "low_center", "慢舞2", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["danceslow3"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "low_center_down", "慢舞3", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["danceslow4"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "low_center", "慢舞4", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dance"] = {"anim@amb@nightclub@dancers@podium_dancers@", "hi_dance_facedj_17_v2_male^5", "舞蹈", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dance2"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", "high_center_down", "舞蹈2", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dance3"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", "high_center", "舞蹈3", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dance4"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", "high_center_up", "舞蹈4", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["danceupper"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "high_center", "上半身舞动", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["danceupper2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "high_center_up", "上半身舞动2", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["danceshy"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", "low_center", "害羞舞", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["danceshy2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "low_center_down", "害羞舞2", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["danceslow"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", "low_center", "慢舞", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dancesilly9"] = {"rcmnigel1bnmt_1b", "dance_loop_tyler", "傻舞9", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dance6"] = {"misschinese2_crystalmazemcs1_cs", "dance_loop_tao", "舞蹈6", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dance7"] = {"misschinese2_crystalmazemcs1_ig", "dance_loop_tao", "舞蹈7", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dance8"] = {"missfbi3_sniping", "dance_m_default", "舞蹈8", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dancesilly"] = {"special_ped@mountain_dancer@monologue_3@monologue_3a", "mnt_dnc_buttwag", "傻舞", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dancesilly2"] = {"move_clown@p_m_zero_idles@", "fidget_short_dance", "傻舞2", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dancesilly3"] = {"move_clown@p_m_two_idles@", "fidget_short_dance", "傻舞3", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dancesilly4"] = {"anim@amb@nightclub@lazlow@hi_podium@", "danceidle_hi_11_buttwiggle_b_laz", "傻舞4", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dancesilly5"] = {"timetable@tracy@ig_5@idle_a", "idle_a", "傻舞5", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dancesilly6"] = {"timetable@tracy@ig_8@idle_b", "idle_d", "傻舞6", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dance9"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "med_center_up", "舞蹈9", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dancesilly8"] = {"anim@mp_player_intcelebrationfemale@the_woogie", "the_woogie", "傻舞8", AnimationOptions =
    {
        EmoteLoop = true
    }},
    ["dancesilly7"] = {"anim@amb@casino@mini@dance@dance_solo@female@var_b@", "high_center", "傻舞7", AnimationOptions =
    {
        EmoteLoop = true
    }},
    ["dance5"] = {"anim@amb@casino@mini@dance@dance_solo@female@var_a@", "med_center", "舞蹈5", AnimationOptions =
    {
        EmoteLoop = true
    }},
    ["danceglowstick"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_13_mi_hi_sexualgriding_laz", "荧光棒舞", AnimationOptions =
    {
        Prop = 'ba_prop_battle_glowstick_01',
        PropBone = 28422,
        PropPlacement = {0.0700,0.1400,0.0,-80.0,20.0},
        SecondProp = 'ba_prop_battle_glowstick_01',
        SecondPropBone = 60309,
        SecondPropPlacement = {0.0700,0.0900,0.0,-120.0,-20.0},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["danceglowstick2"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_12_mi_hi_bootyshake_laz", "荧光棒舞2", AnimationOptions =
    {
        Prop = 'ba_prop_battle_glowstick_01',
        PropBone = 28422,
        PropPlacement = {0.0700,0.1400,0.0,-80.0,20.0},
        SecondProp = 'ba_prop_battle_glowstick_01',
        SecondPropBone = 60309,
        SecondPropPlacement = {0.0700,0.0900,0.0,-120.0,-20.0},
        EmoteLoop = true,
    }},
    ["danceglowstick3"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_09_mi_hi_bellydancer_laz", "荧光棒舞3", AnimationOptions =
    {
        Prop = 'ba_prop_battle_glowstick_01',
        PropBone = 28422,
        PropPlacement = {0.0700,0.1400,0.0,-80.0,20.0},
        SecondProp = 'ba_prop_battle_glowstick_01',
        SecondPropBone = 60309,
        SecondPropPlacement = {0.0700,0.0900,0.0,-120.0,-20.0},
        EmoteLoop = true,
    }},
    ["dancehorse"] = {"anim@amb@nightclub@lazlow@hi_dancefloor@", "dancecrowd_li_15_handup_laz", "木马舞", AnimationOptions =
    {
        Prop = "ba_prop_battle_hobby_horse",
        PropBone = 28422,
        PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["dancehorse2"] = {"anim@amb@nightclub@lazlow@hi_dancefloor@", "crowddance_hi_11_handup_laz", "木马舞2", AnimationOptions =
    {
        Prop = "ba_prop_battle_hobby_horse",
        PropBone = 28422,
        PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        EmoteLoop = true,
    }},
    ["dancehorse3"] = {"anim@amb@nightclub@lazlow@hi_dancefloor@", "dancecrowd_li_11_hu_shimmy_laz", "木马舞3", AnimationOptions =
    {
        Prop = "ba_prop_battle_hobby_horse",
        PropBone = 28422,
        PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        EmoteLoop = true,
    }},
}

DP.Emotes = {
    ["drink"] = {"mp_player_inteat@pnq", "loop", "喝水", AnimationOptions =
    {
        EmoteMoving = true,
        EmoteDuration = 2500,
    }},
    ["beast"] = {"anim@mp_fm_event@intro", "beast_transform", "野兽变身", AnimationOptions =
        {
            EmoteMoving = true,
            EmoteDuration = 5000,
        }},
    ["chill"] = {"switch@trevor@scares_tramp", "trev_scares_tramp_idle_tramp", "放松", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["cloudgaze"] = {"switch@trevor@annoys_sunbathers", "trev_annoys_sunbathers_loop_girl", "看云", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["cloudgaze2"] = {"switch@trevor@annoys_sunbathers", "trev_annoys_sunbathers_loop_guy", "看云2", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["prone"] = {"missfbi3_sniping", "prone_dave", "俯卧", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["pullover"] = {"misscarsteal3pullover", "pull_over_right", "拉过", AnimationOptions =
        {
            EmoteMoving = true,
            EmoteDuration = 1300,
        }},
    ["idle"] = {"anim@heists@heist_corona@team_idles@male_a", "idle", "空闲", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["idle8"] = {"amb@world_human_hang_out_street@male_b@idle_a", "idle_b", "空闲8"},
    ["idle9"] = {"friends@fra@ig_1", "base_idle", "空闲9", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["idle10"] = {"mp_move@prostitute@m@french", "idle", "空闲10", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["idle11"] = {"random@countrysiderobbery", "idle_a", "空闲11", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["idle2"] = {"anim@heists@heist_corona@team_idles@female_a", "idle", "空闲2", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["idle3"] = {"anim@heists@humane_labs@finale@strip_club", "ped_b_celebrate_loop", "空闲3", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["idle4"] = {"anim@mp_celebration@idles@female", "celebration_idle_f_a", "空闲4", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["idle5"] = {"anim@mp_corona_idles@female_b@idle_a", "idle_a", "空闲5", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["idle6"] = {"anim@mp_corona_idles@male_c@idle_a", "idle_a", "空闲6", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["idle7"] = {"anim@mp_corona_idles@male_d@idle_a", "idle_a", "空闲7", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["wait3"] = {"amb@world_human_hang_out_street@female_hold_arm@idle_a", "idle_a", "等待3", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["idledrunk"] = {"random@drunk_driver_1", "drunk_driver_stand_loop_dd1", "醉汉空闲", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["idledrunk2"] = {"random@drunk_driver_1", "drunk_driver_stand_loop_dd2", "醉汉空闲2", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["idledrunk3"] = {"missarmenian2", "standing_idle_loop_drunk", "醉汉空闲3", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["airguitar"] = {"anim@mp_player_intcelebrationfemale@air_guitar", "air_guitar", "空气吉他"},
    ["airsynth"] = {"anim@mp_player_intcelebrationfemale@air_synth", "air_synth", "空气合成器"},
    ["argue"] = {"misscarsteal4@actor", "actor_berating_loop", "争论", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["argue2"] = {"oddjobs@assassinate@vice@hooker", "argue_a", "争论2", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["bartender"] = {"anim@amb@clubhouse@bar@drink@idle_a", "idle_a_bartender", "酒保", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["blowkiss"] = {"anim@mp_player_intcelebrationfemale@blow_kiss", "blow_kiss", "飞吻"},
    ["blowkiss2"] = {"anim@mp_player_intselfieblow_kiss", "exit", "飞吻2", AnimationOptions =
        {
            EmoteMoving = true,
            EmoteDuration = 2000

        }},
    ["curtsy"] = {"anim@mp_player_intcelebrationpaired@f_f_sarcastic", "sarcastic_left", "屈膝礼"},
    ["bringiton"] = {"misscommon@response", "bring_it_on", "来吧", AnimationOptions =
        {
            EmoteMoving = true,
            EmoteDuration = 3000
        }},
    ["comeatmebro"] = {"mini@triathlon", "want_some_of_this", "来打我啊", AnimationOptions =
        {
            EmoteMoving = true,
            EmoteDuration = 2000
        }},
    ["cop2"] = {"anim@amb@nightclub@peds@", "rcmme_amanda1_stand_loop_cop", "警察2", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["cop3"] = {"amb@code_human_police_investigate@idle_a", "idle_b", "警察3", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["crossarms"] = {"amb@world_human_hang_out_street@female_arms_crossed@idle_a", "idle_a", "抱臂", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["crossarms2"] = {"amb@world_human_hang_out_street@male_c@idle_a", "idle_b", "抱臂2", AnimationOptions =
        {
            EmoteMoving = true,
        }},
    ["crossarms3"] = {"anim@heists@heist_corona@single_team", "single_team_loop_boss", "抱臂3", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["crossarms4"] = {"random@street_race", "_car_b_lookout", "抱臂4", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["crossarms5"] = {"anim@amb@nightclub@peds@", "rcmme_amanda1_stand_loop_cop", "抱臂5", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["foldarms2"] = {"anim@amb@nightclub@peds@", "rcmme_amanda1_stand_loop_cop", "叠手2", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["crossarms6"] = {"random@shop_gunstore", "_idle", "抱臂6", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["foldarms"] = {"anim@amb@business@bgen@bgen_no_work@", "stand_phone_phoneputdown_idle_nowork", "叠手", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["crossarmsside"] = {"rcmnigel1a_band_groupies", "base_m2", "侧抱臂", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["damn"] = {"gestures@m@standing@casual", "gesture_damn", "该死", AnimationOptions =
        {
            EmoteMoving = true,
            EmoteDuration = 1000
        }},
    ["damn2"] = {"anim@am_hold_up@male", "shoplift_mid", "该死2", AnimationOptions =
        {
            EmoteMoving = true,
            EmoteDuration = 1000
        }},
    ["pointdown"] = {"gestures@f@standing@casual", "gesture_hand_down", "指下", AnimationOptions =
        {
            EmoteMoving = true,
            EmoteDuration = 1000
        }},
    ["surrender"] = {"random@arrests@busted", "idle_a", "投降", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["facepalm2"] = {"anim@mp_player_intcelebrationfemale@face_palm", "face_palm", "拍脸2", AnimationOptions =
        {
            EmoteMoving = true,
            EmoteDuration = 8000
        }},
    ["facepalm"] = {"random@car_thief@agitated@idle_a", "agitated_idle_a", "拍脸", AnimationOptions =
        {
            EmoteMoving = true,
            EmoteDuration = 8000
        }},
    ["facepalm3"] = {"missminuteman_1ig_2", "tasered_2", "拍脸3", AnimationOptions =
        {
            EmoteMoving = true,
            EmoteDuration = 8000
        }},
    ["facepalm4"] = {"anim@mp_player_intupperface_palm", "idle_a", "拍脸4", AnimationOptions =
        {
            EmoteMoving = true,
            EmoteLoop = true,
        }},
    ["fallover"] = {"random@drunk_driver_1", "drunk_fall_over", "摔倒"},
    ["fallover2"] = {"mp_suicide", "pistol", "摔倒2"},
    ["fallover3"] = {"mp_suicide", "pill", "摔倒3"},
    ["fallover4"] = {"friends@frf@ig_2", "knockout_plyr", "摔倒4"},
    ["fallover5"] = {"anim@gangops@hostage@", "victim_fail", "摔倒5"},
    ["fallasleep"] = {"mp_sleep", "sleep_loop", "睡着", AnimationOptions =
        {
            EmoteMoving = true,
            EmoteLoop = true,
        }},
    ["fightme"] = {"anim@deathmatch_intros@unarmed", "intro_male_unarmed_c", "和我打"},
    ["fightme2"] = {"anim@deathmatch_intros@unarmed", "intro_male_unarmed_e", "和我打2"},
    ["finger"] = {"anim@mp_player_intselfiethe_bird", "idle_a", "竖中指", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["finger2"] = {"anim@mp_player_intupperfinger", "idle_a_fp", "竖中指2", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["handshake"] = {"mp_ped_interaction", "handshake_guy_a", "握手", AnimationOptions =
        {
            EmoteMoving = true,
            EmoteDuration = 3000
        }},
    ["handshake2"] = {"mp_ped_interaction", "handshake_guy_b", "握手2", AnimationOptions =
        {
            EmoteMoving = true,
            EmoteDuration = 3000
        }},
    ["wait4"] = {"amb@world_human_hang_out_street@Female_arm_side@idle_a", "idle_a", "等待 4", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["wait5"] = {"missclothing", "idle_storeclerk", "等待 5", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["wait6"] = {"timetable@amanda@ig_2", "ig_2_base_amanda", "等待 6", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["wait7"] = {"rcmnigel1cnmt_1c", "base", "等待 7", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["wait8"] = {"rcmjosh1", "idle", "等待 8", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["wait9"] = {"rcmjosh2", "josh_2_intp1_base", "等待 9", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["wait10"] = {"timetable@amanda@ig_3", "ig_3_base_tracy", "等待 10", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["wait11"] = {"misshair_shop@hair_dressers", "keeper_base", "等待 11", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["hiking"] = {"move_m@hiking", "idle", "远足", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["hug"] = {"mp_ped_interaction", "kisses_guy_a", "拥抱"},
    ["hug2"] = {"mp_ped_interaction", "kisses_guy_b", "拥抱 2"},
    ["hug3"] = {"mp_ped_interaction", "hugs_guy_a", "拥抱 3"},
    ["inspect"] = {"random@train_tracks", "idle_e", "检查"},
    ["jazzhands"] = {"anim@mp_player_intcelebrationfemale@jazz_hands", "jazz_hands", "爵士手", AnimationOptions =
    {
        EmoteMoving = true,
        EmoteDuration = 6000,
    }},
    ["jog2"] = {"amb@world_human_jog_standing@male@idle_a", "idle_a", "慢跑 2", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["jog3"] = {"amb@world_human_jog_standing@female@idle_a", "idle_a", "慢跑 3", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["jog4"] = {"amb@world_human_power_walker@female@idle_a", "idle_a", "慢跑 4", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["jog5"] = {"move_m@joy@a", "walk", "慢跑 5", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["jumpingjacks"] = {"timetable@reunited@ig_2", "jimmy_getknocked", "开合跳", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["kneel2"] = {"rcmextreme3", "idle", "跪下 2", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["kneel3"] = {"amb@world_human_bum_wash@male@low@idle_a", "idle_a", "跪下 3", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["knock"] = {"timetable@jimmy@doorknock@", "knockdoor_idle", "敲门", AnimationOptions =
    {
        EmoteMoving = true,
        EmoteLoop = true,
    }},
    ["knock2"] = {"missheistfbi3b_ig7", "lift_fibagent_loop", "敲门 2", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["knucklecrunch"] = {"anim@mp_player_intcelebrationfemale@knuckle_crunch", "knuckle_crunch", "指关节响", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["lapdance"] = {"mp_safehouse", "lap_dance_girl", "大腿舞"},
    ["lean2"] = {"amb@world_human_leaning@female@wall@back@hand_up@idle_a", "idle_a", "倚靠 2", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["lean3"] = {"amb@world_human_leaning@female@wall@back@holding_elbow@idle_a", "idle_a", "倚靠 3", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["lean4"] = {"amb@world_human_leaning@male@wall@back@foot_up@idle_a", "idle_a", "倚靠 4", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["lean5"] = {"amb@world_human_leaning@male@wall@back@hands_together@idle_b", "idle_b", "倚靠 5", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["leanflirt"] = {"random@street_race", "_car_a_flirt_girl", "调情倚靠", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["leanbar2"] = {"amb@prop_human_bum_shopping_cart@male@idle_a", "idle_c", "酒吧倚靠 2", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["leanbar3"] = {"anim@amb@nightclub@lazlow@ig1_vip@", "clubvip_base_laz", "酒吧倚靠 3", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["leanbar4"] = {"anim@heists@prison_heist", "ped_b_loop_a", "酒吧倚靠 4", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["leanhigh"] = {"anim@mp_ferris_wheel", "idle_a_player_one", "高处倚靠", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["leanhigh2"] = {"anim@mp_ferris_wheel", "idle_a_player_two", "高处倚靠 2", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["leanside"] = {"timetable@mime@01_gc", "idle_a", "侧边倚靠", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["leanside2"] = {"misscarstealfinale", "packer_idle_1_trevor", "侧边倚靠 2", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["leanside3"] = {"misscarstealfinalecar_5_ig_1", "waitloop_lamar", "侧边倚靠 3", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["leanside4"] = {"misscarstealfinalecar_5_ig_1", "waitloop_lamar", "侧边倚靠 4", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["leanside5"] = {"rcmjosh2", "josh_2_intp1_base", "侧边倚靠 5", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["me"] = {"gestures@f@standing@casual", "gesture_me_hard", "我", AnimationOptions =
    {
        EmoteMoving = true,
        EmoteDuration = 1000
    }},
    ["mechanic"] = {"mini@repair", "fixing_a_ped", "机械师", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["mechanic2"] = {"amb@world_human_vehicle_mechanic@male@base", "idle_a", "机械师 2", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["mechanic3"] = {"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", "机械师 3", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["mechanic4"] = {"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", "机械师 4", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["medic2"] = {"amb@medic@standing@tendtodead@base", "base", "医生 2", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["meditate"] = {"rcmcollect_paperleadinout@", "meditiate_idle", "冥想", AnimationOptions = -- CHANGE ME
    {
        EmoteLoop = true,
    }},
    ["meditate2"] = {"rcmepsilonism3", "ep_3_rcm_marnie_meditating", "冥想 2", AnimationOptions = -- CHANGE ME
    {
        EmoteLoop = true,
    }},
    ["meditate3"] = {"rcmepsilonism3", "base_loop", "冥想 3", AnimationOptions = -- CHANGE ME
    {
        EmoteLoop = true,
    }},
    ["metal"] = {"anim@mp_player_intincarrockstd@ps@", "idle_a", "金属", AnimationOptions = -- CHANGE ME
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["no"] = {"anim@heists@ornate_bank@chat_manager", "fail", "不", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["no2"] = {"mp_player_int_upper_nod", "mp_player_int_nod_no", "不 2", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["nosepick"] = {"anim@mp_player_intcelebrationfemale@nose_pick", "nose_pick", "掏鼻子", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["noway"] = {"gestures@m@standing@casual", "gesture_no_way", "不可能", AnimationOptions =
    {
        EmoteDuration = 1500,
        EmoteMoving = true,
    }},
    ["ok"] = {"anim@mp_player_intselfiedock", "idle_a", "好", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["outofbreath"] = {"re@construction", "out_of_breath", "气喘吁吁", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["pickup"] = {"random@domestic", "pickup_low", "捡起"},
    ["push"] = {"missfinale_c2ig_11", "pushcar_offcliff_f", "推", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["push2"] = {"missfinale_c2ig_11", "pushcar_offcliff_m", "推 2", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["point"] = {"gestures@f@standing@casual", "gesture_point", "指向", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["pushup"] = {"amb@world_human_push_ups@male@idle_a", "idle_d", "俯卧撑", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["countdown"] = {"random@street_race", "grid_girl_race_start", "倒计时", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["pointright"] = {"mp_gun_shop_tut", "indicate_right", "指向右边", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["salute"] = {"anim@mp_player_intincarsalutestd@ds@", "idle_a", "敬礼", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["salute2"] = {"anim@mp_player_intincarsalutestd@ps@", "idle_a", "敬礼 2", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["salute3"] = {"anim@mp_player_intuppersalute", "idle_a", "敬礼 3", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["scared"] = {"random@domestic", "f_distressed_loop", "害怕", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["scared2"] = {"random@homelandsecurity", "knees_loop_girl", "害怕 2", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["screwyou"] = {"misscommon@response", "screw_you", "去你的", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["shakeoff"] = {"move_m@_idles@shake_off", "shakeoff_1", "甩掉", AnimationOptions =
    {
        EmoteMoving = true,
        EmoteDuration = 3500,
    }},
    ["shot"] = {"random@dealgonewrong", "idle_a", "被射", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["sleep"] = {"timetable@tracy@sleep@", "idle_c", "睡觉", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["shrug"] = {"gestures@f@standing@casual", "gesture_shrug_hard", "耸肩", AnimationOptions =
    {
        EmoteMoving = true,
        EmoteDuration = 1000,
    }},
    ["shrug2"] = {"gestures@m@standing@casual", "gesture_shrug_hard", "耸肩 2", AnimationOptions =
    {
        EmoteMoving = true,
        EmoteDuration = 1000,
    }},
    ["sit"] = {"anim@amb@business@bgen@bgen_no_work@", "sit_phone_phoneputdown_idle_nowork", "坐下", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["sit2"] = {"rcm_barry3", "barry_3_sit_loop", "坐下 2", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["sit3"] = {"amb@world_human_picnic@male@idle_a", "idle_a", "坐下 3", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["sit4"] = {"amb@world_human_picnic@female@idle_a", "idle_a", "坐下 4", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["sit5"] = {"anim@heists@fleeca_bank@ig_7_jetski_owner", "owner_idle", "坐下 5", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["sit6"] = {"timetable@jimmy@mics3_ig_15@", "idle_a_jimmy", "坐下 6", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["sit7"] = {"anim@amb@nightclub@lazlow@lo_alone@", "lowalone_base_laz", "坐下 7", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["sit8"] = {"timetable@jimmy@mics3_ig_15@", "mics3_15_base_jimmy", "坐下 8", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["sit9"] = {"amb@world_human_stupor@male@idle_a", "idle_a", "坐下 9", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["sitlean"] = {"timetable@tracy@ig_14@", "ig_14_base_tracy", "倚靠坐着", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["sitsad"] = {"anim@amb@business@bgen@bgen_no_work@", "sit_phone_phoneputdown_sleeping-noworkfemale", "悲伤地坐", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["sitscared"] = {"anim@heists@ornate_bank@hostages@hit", "hit_loop_ped_b", "害怕地坐", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["sitscared2"] = {"anim@heists@ornate_bank@hostages@ped_c@", "flinch_loop", "害怕地坐 2", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["sitscared3"] = {"anim@heists@ornate_bank@hostages@ped_e@", "flinch_loop", "害怕地坐 3", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["sitdrunk"] = {"timetable@amanda@drunk@base", "base", "醉酒地坐", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["sitchair2"] = {"timetable@ron@ig_5_p3", "ig_5_p3_base", "椅子上坐 2", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["sitchair3"] = {"timetable@reunited@ig_10", "base_amanda", "椅子上坐 3", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["sitchair4"] = {"timetable@ron@ig_3_couch", "base", "椅子上坐 4", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["sitchair5"] = {"timetable@jimmy@mics3_ig_15@", "mics3_15_base_tracy", "椅子上坐 5", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["sitchair6"] = {"timetable@maid@couch@", "base", "椅子上坐 6", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["sitchairside"] = {"timetable@ron@ron_ig_2_alt1", "ig_2_alt1_base", "侧边椅子上坐", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["situp"] = {"amb@world_human_sit_ups@male@idle_a", "idle_a", "仰卧起坐", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["clapangry"] = {"anim@arena@celeb@flat@solo@no_props@", "angry_clap_a_player_a", "愤怒鼓掌", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["slowclap3"] = {"anim@mp_player_intupperslow_clap", "idle_a", "慢拍手 3", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["clap"] = {"amb@world_human_cheering@male_a", "base", "鼓掌", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["slowclap"] = {"anim@mp_player_intcelebrationfemale@slow_clap", "slow_clap", "慢拍手", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["slowclap2"] = {"anim@mp_player_intcelebrationmale@slow_clap", "slow_clap", "慢拍手 2", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["smell"] = {"move_p_m_two_idles@generic", "fidget_sniff_fingers", "闻", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["stickup"] = {"random@countryside_gang_fight", "biker_02_stickup_loop", "持械抢劫", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["stumble"] = {"misscarsteal4@actor", "stumble", "绊倒", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["stunned"] = {"stungun@standing", "damage", "震惊", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["sunbathe"] = {"amb@world_human_sunbathe@male@back@base", "base", "晒太阳", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["sunbathe2"] = {"amb@world_human_sunbathe@female@back@base", "base", "晒太阳 2", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["t"] = {"missfam5_yoga", "a2_pose", "T姿势", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["t2"] = {"mp_sleep", "bind_pose_180", "T姿势 2", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["think5"] = {"mp_cp_welcome_tutthink", "b_think", "思考 5", AnimationOptions =
    {
        EmoteMoving = true,
        EmoteDuration = 2000,
    }},
    ["think"] = {"misscarsteal4@aliens", "rehearsal_base_idle_director", "思考", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["think3"] = {"timetable@tracy@ig_8@base", "base", "思考 3", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},

    ["think2"] = {"missheist_jewelleadinout", "jh_int_outro_loop_a", "思考 2", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["thumbsup3"] = {"anim@mp_player_intincarthumbs_uplow@ds@", "enter", "竖大拇指 3", AnimationOptions =
    {
        EmoteMoving = true,
        EmoteDuration = 3000,
    }},
    ["thumbsup2"] = {"anim@mp_player_intselfiethumbs_up", "idle_a", "竖大拇指 2", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["thumbsup"] = {"anim@mp_player_intupperthumbs_up", "idle_a", "竖大拇指", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["type"] = {"anim@heists@prison_heiststation@cop_reactions", "cop_b_idle", "打字", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["type2"] = {"anim@heists@prison_heistig1_p1_guard_checks_bus", "loop", "打字 2", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["type3"] = {"mp_prison_break", "hack_loop", "打字 3", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["type4"] = {"mp_fbi_heist", "loop", "打字 4", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["warmth"] = {"amb@world_human_stand_fire@male@idle_a", "idle_a", "取暖", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["wave4"] = {"random@mugging5", "001445_01_gangintimidation_1_female_idle_b", "挥手 4", AnimationOptions =
    {
        EmoteMoving = true,
        EmoteDuration = 3000,
    }},
    ["wave2"] = {"anim@mp_player_intcelebrationfemale@wave", "wave", "挥手 2", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["wave3"] = {"friends@fra@ig_1", "over_here_idle_a", "挥手 3", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["wave"] = {"friends@frj@ig_1", "wave_a", "挥手", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["wave5"] = {"friends@frj@ig_1", "wave_b", "挥手 5", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["wave6"] = {"friends@frj@ig_1", "wave_c", "挥手 6", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["wave7"] = {"friends@frj@ig_1", "wave_d", "挥手 7", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["wave8"] = {"friends@frj@ig_1", "wave_e", "挥手 8", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["wave9"] = {"gestures@m@standing@casual", "gesture_hello", "挥手 9", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["whistle"] = {"taxi_hail", "hail_taxi", "招手打车", AnimationOptions =
        {
            EmoteMoving = true,
            EmoteDuration = 1300,
        }},
    ["whistle2"] = {"rcmnigel1c", "hailing_whistle_waive_a", "吹口哨2", AnimationOptions =
        {
            EmoteMoving = true,
            EmoteDuration = 2000,
        }},
    ["yeah"] = {"anim@mp_player_intupperair_shagging", "idle_a", "是的", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["lift"] = {"random@hitch_lift", "idle_f", "搭便车", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["lol"] = {"anim@arena@celeb@flat@paired@no_props@", "laugh_a_player_b", "哈哈大笑", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["lol2"] = {"anim@arena@celeb@flat@solo@no_props@", "giggle_a_player_b", "哈哈大笑2", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["statue2"] = {"fra_0_int-1", "cs_lamardavis_dual-1", "雕像2", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["statue3"] = {"club_intro2-0", "csb_englishdave_dual-0", "雕像3", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["gangsign"] = {"mp_player_int_uppergang_sign_a", "mp_player_int_gang_sign_a", "帮派手势", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["gangsign2"] = {"mp_player_int_uppergang_sign_b", "mp_player_int_gang_sign_b", "帮派手势2", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["passout"] = {"missarmenian2", "drunk_loop", "昏倒", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["passout2"] = {"missarmenian2", "corpse_search_exit_ped", "昏倒2", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["passout3"] = {"anim@gangops@morgue@table@", "body_search", "昏倒3", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["passout4"] = {"mini@cpr@char_b@cpr_def", "cpr_pumpchest_idle", "昏倒4", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["passout5"] = {"random@mugging4", "flee_backward_loop_shopkeeper", "昏倒5", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["petting"] = {"creatures@rottweiler@tricks@", "petting_franklin", "抚摸", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["crawl"] = {"move_injured_ground", "front_loop", "爬行", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["flip2"] = {"anim@arena@celeb@flat@solo@no_props@", "cap_a_player_a", "空翻2"},
    ["flip"] = {"anim@arena@celeb@flat@solo@no_props@", "flip_a_player_a", "空翻"},
    ["slide"] = {"anim@arena@celeb@flat@solo@no_props@", "slide_a_player_a", "滑动"},
    ["slide2"] = {"anim@arena@celeb@flat@solo@no_props@", "slide_b_player_a", "滑动2"},
    ["slide3"] = {"anim@arena@celeb@flat@solo@no_props@", "slide_c_player_a", "滑动3"},
    ["slugger"] = {"anim@arena@celeb@flat@solo@no_props@", "slugger_a_player_a", "挥拳"},
    ["flipoff"] = {"anim@arena@celeb@podium@no_prop@", "flip_off_a_1st", "竖中指", AnimationOptions =
        {
            EmoteMoving = true,
        }},
    ["flipoff2"] = {"anim@arena@celeb@podium@no_prop@", "flip_off_c_1st", "竖中指2", AnimationOptions =
        {
            EmoteMoving = true,
        }},
    ["bow"] = {"anim@arena@celeb@podium@no_prop@", "regal_c_1st", "鞠躬", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["bow2"] = {"anim@arena@celeb@podium@no_prop@", "regal_a_1st", "鞠躬2", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["keyfob"] = {"anim@mp_player_intmenu@key_fob@", "fob_click", "钥匙扣", AnimationOptions =
        {
            EmoteLoop = false,
            EmoteMoving = true,
            EmoteDuration = 1000,
        }},
    ["golfswing"] = {"rcmnigel1d", "swing_a_mark", "挥杆高尔夫"},
    ["eat"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "吃东西", AnimationOptions =
        {
            EmoteMoving = true,
            EmoteDuration = 3000,
        }},
    ["reaching"] = {"move_m@intimidation@cop@unarmed", "idle", "伸手", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["wait"] = {"random@shop_tattoo", "_idle_a", "等待", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["wait2"] = {"missbigscore2aig_3", "wait_for_van_c", "等待2", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["wait12"] = {"rcmjosh1", "idle", "等待12", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["wait13"] = {"rcmnigel1a", "base", "等待13", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["lapdance2"] = {"mini@strip_club@private_dance@idle", "priv_dance_idle", "大腿舞2", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["lapdance3"] = {"mini@strip_club@private_dance@part2", "priv_dance_p2", "大腿舞3", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["twerk"] = {"switch@trevor@mocks_lapdance", "001443_01_trvs_28_idle_stripper", "扭臀舞", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["slap"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_slap", "拍打", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
            EmoteDuration = 2000,
        }},
    ["headbutt"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_headbutt", "头槌"},
    ["fishdance"] = {"anim@mp_player_intupperfind_the_fish", "idle_a", "找鱼舞", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["peace"] = {"mp_player_int_upperpeace_sign", "mp_player_int_peace_sign", "和平手势", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["peace2"] = {"anim@mp_player_intupperpeace", "idle_a", "和平手势2", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["cpr"] = {"mini@cpr@char_a@cpr_str", "cpr_pumpchest", "心肺复苏", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["cpr2"] = {"mini@cpr@char_a@cpr_str", "cpr_pumpchest", "心肺复苏2", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["ledge"] = {"missfbi1", "ledge_loop", "窗台", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["airplane"] = {"missfbi1", "ledge_loop", "飞机", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["peek"] = {"random@paparazzi@peek", "left_peek_a", "偷看", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["cough"] = {"timetable@gardener@smoking_joint", "idle_cough", "咳嗽", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["stretch"] = {"mini@triathlon", "idle_e", "伸展", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["stretch2"] = {"mini@triathlon", "idle_f", "伸展2", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["stretch3"] = {"mini@triathlon", "idle_d", "伸展3", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["stretch4"] = {"rcmfanatic1maryann_stretchidle_b", "idle_e", "伸展4", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["celebrate"] = {"rcmfanatic1celebrate", "celebrate", "庆祝", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["punching"] = {"rcmextreme2", "loop_punching", "连续出拳", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["superhero"] = {"rcmbarry", "base", "超级英雄", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["superhero2"] = {"rcmbarry", "base", "超级英雄2", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["mindcontrol"] = {"rcmbarry", "mind_control_b_loop", "心灵控制", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["mindcontrol2"] = {"rcmbarry", "bar_1_attack_idle_aln", "心灵控制2", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["clown"] = {"rcm_barry2", "clown_idle_0", "小丑", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["clown2"] = {"rcm_barry2", "clown_idle_1", "小丑2", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["clown3"] = {"rcm_barry2", "clown_idle_2", "小丑3", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["clown4"] = {"rcm_barry2", "clown_idle_3", "小丑4", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["clown5"] = {"rcm_barry2", "clown_idle_6", "小丑5", AnimationOptions =
        {
            EmoteLoop = true,
        }},
        ["tryclothes"] = {"mp_clothing@female@trousers", "try_trousers_neutral_a", "试穿衣服", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["tryclothes2"] = {"mp_clothing@female@shirt", "try_shirt_positive_a", "试穿衣服 2", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["tryclothes3"] = {"mp_clothing@female@shoes", "try_shoes_positive_a", "试穿衣服 3", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["nervous2"] = {"mp_missheist_countrybank@nervous", "nervous_idle", "紧张 2", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["nervous"] = {"amb@world_human_bum_standing@twitchy@idle_a", "idle_c", "紧张", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["nervous3"] = {"rcmme_tracey1", "nervous_loop", "紧张 3", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["uncuff"] = {"mp_arresting", "a_uncuff", "解开手铐", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["namaste"] = {"timetable@amanda@ig_4", "ig_4_base", "合十礼", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["dj"] = {"anim@amb@nightclub@djs@dixon@", "dixn_dance_cntr_open_dix", "DJ打碟", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["threaten"] = {"random@atmrobberygen", "b_atm_mugging", "威胁", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["radio"] = {"random@arrests", "generic_radio_chatter", "无线电", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["pull"] = {"random@mugging4", "struggle_loop_b_thief", "拉扯", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["bird"] = {"random@peyote@bird", "wakeup", "鸟"},
    ["chicken"] = {"random@peyote@chicken", "wakeup", "鸡", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["bark"] = {"random@peyote@dog", "wakeup", "狗叫"},
    ["rabbit"] = {"random@peyote@rabbit", "wakeup", "兔子"},
    ["spiderman"] = {"missexile3", "ex03_train_roof_idle", "蜘蛛侠", AnimationOptions =
        {
            EmoteLoop = true,
        }},
    ["boi"] = {"special_ped@jane@monologue_5@monologue_5c", "brotheradrianhasshown_2", "BOI", AnimationOptions =
        {
            EmoteMoving = true,
            EmoteDuration = 3000,
        }},
    ["adjust"] = {"missmic4", "michael_tux_fidget", "调整", AnimationOptions =
        {
            EmoteMoving = true,
            EmoteDuration = 4000,
        }},
    ["handsup"] = {"missminuteman_1ig_2", "handsup_base", "举手", AnimationOptions =
        {
            EmoteMoving = true,
            EmoteLoop = true,
        }},
    ["pee"] = {"misscarsteal2peeing", "peeing_loop", "小便", AnimationOptions =
        {
            EmoteStuck = true,
            PtfxAsset = "scr_amb_chop",
            PtfxName = "ent_anim_dog_peeing",
            PtfxNoProp = true,
            PtfxPlacement = {-0.05, 0.3, 0.0, 0.0, 90.0, 90.0, 1.0},
            PtfxInfo = Config.Languages[Config.MenuLanguage]['pee'],
            PtfxWait = 3000,
        }},
    
    -----------------------------------------------------------------------------------------------------------
    ------ 这些是情景，其中一些女性角色无法使用，或者存在其他问题，但仍然值得拥有。
    -----------------------------------------------------------------------------------------------------------
    
    ["atm"] = {"Scenario", "PROP_HUMAN_ATM", "ATM"},
    ["bbq"] = {"MaleScenario", "PROP_HUMAN_BBQ", "烧烤"},
    ["bumbin"] = {"Scenario", "PROP_HUMAN_BUM_BIN", "垃圾桶流浪汉"},
    ["bumsleep"] = {"Scenario", "WORLD_HUMAN_BUM_SLUMPED", "流浪汉睡觉"},
    ["cheer"] = {"Scenario", "WORLD_HUMAN_CHEERING", "欢呼"},
    ["chinup"] = {"Scenario", "PROP_HUMAN_MUSCLE_CHIN_UPS", "引体向上"},
    ["clipboard2"] = {"MaleScenario", "WORLD_HUMAN_CLIPBOARD", "剪贴板 2"},
    ["cop"] = {"Scenario", "WORLD_HUMAN_COP_IDLES", "警察"},
    ["copbeacon"] = {"MaleScenario", "WORLD_HUMAN_CAR_PARK_ATTENDANT", "警察信标"},
    ["filmshocking"] = {"Scenario", "WORLD_HUMAN_MOBILE_FILM_SHOCKING", "拍摄惊悚"},
    ["flex"] = {"Scenario", "WORLD_HUMAN_MUSCLE_FLEX", "展示肌肉"},
    ["guard"] = {"Scenario", "WORLD_HUMAN_GUARD_STAND", "守卫"},
    ["hammer"] = {"Scenario", "WORLD_HUMAN_HAMMERING", "锤击"},
    ["hangout"] = {"Scenario", "WORLD_HUMAN_HANG_OUT_STREET", "闲逛"},
    ["impatient"] = {"Scenario", "WORLD_HUMAN_STAND_IMPATIENT", "不耐烦"},
    ["janitor"] = {"Scenario", "WORLD_HUMAN_JANITOR", "清洁工"},
    ["jog"] = {"Scenario", "WORLD_HUMAN_JOG_STANDING", "慢跑"},
    ["kneel"] = {"Scenario", "CODE_HUMAN_MEDIC_KNEEL", "跪下"},
    ["leafblower"] = {"MaleScenario", "WORLD_HUMAN_GARDENER_LEAF_BLOWER", "吹叶机"},
    ["lean"] = {"Scenario", "WORLD_HUMAN_LEANING", "倚靠"},
    ["leanbar"] = {"Scenario", "PROP_HUMAN_BUM_SHOPPING_CART", "倚靠栏杆"},
    ["lookout"] = {"Scenario", "CODE_HUMAN_CROSS_ROAD_WAIT", "瞭望"},
    ["maid"] = {"Scenario", "WORLD_HUMAN_MAID_CLEAN", "女仆"},
    ["medic"] = {"Scenario", "CODE_HUMAN_MEDIC_TEND_TO_DEAD", "医生"},
    ["musician"] = {"MaleScenario", "WORLD_HUMAN_MUSICIAN", "音乐家"},
    ["notepad2"] = {"Scenario", "CODE_HUMAN_MEDIC_TIME_OF_DEATH", "记事本 2"},
    ["parkingmeter"] = {"Scenario", "PROP_HUMAN_PARKING_METER", "停车计时器"},
    ["party"] = {"Scenario", "WORLD_HUMAN_PARTYING", "派对"},
    ["texting"] = {"Scenario", "WORLD_HUMAN_STAND_MOBILE", "发短信"},
    ["prosthigh"] = {"Scenario", "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS", "高级妓女"},
    ["prostlow"] = {"Scenario", "WORLD_HUMAN_PROSTITUTE_LOW_CLASS", "低级妓女"},
    ["puddle"] = {"Scenario", "WORLD_HUMAN_BUM_WASH", "水坑"},
    ["record"] = {"Scenario", "WORLD_HUMAN_MOBILE_FILM_SHOCKING", "记录"},
    -- Sitchair比较特别，因为您希望玩家能够正确地就座。
    -- 所以我们将其设置为"ScenarioObject"并使用TaskStartScenarioAtPosition()而不是"AtPlace"
    ["sitchair"] = {"ScenarioObject", "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER", "坐椅子"},
    ["smoke"] = {"Scenario", "WORLD_HUMAN_SMOKING", "吸烟"},
    ["smokeweed"] = {"MaleScenario", "WORLD_HUMAN_DRUG_DEALER", "吸大麻"},
    ["statue"] = {"Scenario", "WORLD_HUMAN_HUMAN_STATUE", "雕像"},
    ["sunbathe3"] = {"Scenario", "WORLD_HUMAN_SUNBATHE", "日光浴 3"},
    ["sunbatheback"] = {"Scenario", "WORLD_HUMAN_SUNBATHE_BACK", "背部日光浴"},
    ["weld"] = {"Scenario", "WORLD_HUMAN_WELDING", "焊接"},
    ["windowshop"] = {"Scenario", "WORLD_HUMAN_WINDOW_SHOP_BROWSE", "橱窗购物"},
    ["yoga"] = {"Scenario", "WORLD_HUMAN_YOGA", "瑜伽"},
    -- CASINO DLC EMOTES (STREAMED)
    ["karate"] = {"anim@mp_player_intcelebrationfemale@karate_chops", "karate_chops", "空手道"},
    ["karate2"] = {"anim@mp_player_intcelebrationmale@karate_chops", "karate_chops", "空手道 2"},
    ["cutthroat"] = {"anim@mp_player_intcelebrationmale@cut_throat", "cut_throat", "割喉"},
    ["cutthroat2"] = {"anim@mp_player_intcelebrationfemale@cut_throat", "cut_throat", "割喉 2"},
    ["mindblown"] = {"anim@mp_player_intcelebrationmale@mind_blown", "mind_blown", "震惊", AnimationOptions =
        {
            EmoteMoving = true,
            EmoteDuration = 4000
        }},
    ["mindblown2"] = {"anim@mp_player_intcelebrationfemale@mind_blown", "mind_blown", "震惊 2", AnimationOptions =
        {
            EmoteMoving = true,
            EmoteDuration = 4000
        }},
    ["boxing"] = {"anim@mp_player_intcelebrationmale@shadow_boxing", "shadow_boxing", "拳击", AnimationOptions =
        {
            EmoteMoving = true,
            EmoteDuration = 4000
        }},
    ["boxing2"] = {"anim@mp_player_intcelebrationfemale@shadow_boxing", "shadow_boxing", "拳击 2", AnimationOptions =
        {
            EmoteMoving = true,
            EmoteDuration = 4000
        }},
    ["stink"] = {"anim@mp_player_intcelebrationfemale@stinker", "stinker", "臭", AnimationOptions =
        {
            EmoteMoving = true,
            EmoteLoop = true
        }},
    ["think4"] = {"anim@amb@casino@hangout@ped_male@stand@02b@idles", "idle_a", "思考 4", AnimationOptions =
        {
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["adjusttie"] = {"clothingtie", "try_tie_positive_a", "调整领带", AnimationOptions =
        {
            EmoteMoving = true,
            EmoteDuration = 5000
        }},
}

DP.PropEmotes = {
    ["umbrella"] = {"amb@world_human_drinking@coffee@male@base", "base", "雨伞", AnimationOptions =
    {
        Prop = "p_amb_brolly_01",
        PropBone = 57005,
        PropPlacement = {0.15, 0.005, 0.0, 87.0, -20.0, 180.0},
        --
        EmoteLoop = true,
        EmoteMoving = true,
    }},

    -----------------------------------------------------------------------------------------------------
    ------ This is an example of an emote with 2 props, pretty simple! ----------------------------------
    -----------------------------------------------------------------------------------------------------

    ["notepad"] = {"missheistdockssetup1clipboard@base", "base", "记事本", AnimationOptions =
    {
        Prop = 'prop_notepad_01',
        PropBone = 18905,
        PropPlacement = {0.1, 0.02, 0.05, 10.0, 0.0, 0.0},
        SecondProp = 'prop_pencil_01',
        SecondPropBone = 58866,
        SecondPropPlacement = {0.11, -0.02, 0.001, -120.0, 0.0, 0.0},
        -- EmoteLoop is used for emotes that should loop, its as simple as that.
        -- Then EmoteMoving is used for emotes that should only play on the upperbody.
        -- The code then checks both values and sets the MovementType to the correct one
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["box"] = {"anim@heists@box_carry@", "idle", "盒子", AnimationOptions =
    {
        Prop = "hei_prop_heist_box",
        PropBone = 60309,
        PropPlacement = {0.025, 0.08, 0.255, -145.0, 290.0, 0.0},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["rose"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "玫瑰", AnimationOptions =
    {
        Prop = "prop_single_rose",
        PropBone = 18905,
        PropPlacement = {0.13, 0.15, 0.0, -100.0, 0.0, -20.0},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["smoke2"] = {"amb@world_human_aa_smoke@male@idle_a", "idle_c", "吸烟2", AnimationOptions =
    {
        Prop = 'prop_cs_ciggy_01',
        PropBone = 28422,
        PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["smoke3"] = {"amb@world_human_aa_smoke@male@idle_a", "idle_b", "吸烟3", AnimationOptions =
    {
        Prop = 'prop_cs_ciggy_01',
        PropBone = 28422,
        PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["smoke4"] = {"amb@world_human_smoking@female@idle_a", "idle_b", "吸烟4", AnimationOptions =
    {
        Prop = 'prop_cs_ciggy_01',
        PropBone = 28422,
        PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["bong"] = {"anim@safehouse@bong", "bong_stage3", "水烟管", AnimationOptions =
    {
        Prop = 'hei_heist_sh_bong_01',
        PropBone = 18905,
        PropPlacement = {0.10,-0.25,0.0,95.0,190.0,180.0},
    }},
    ["suitcase"] = {"missheistdocksprep1hold_cellphone", "static", "手提箱", AnimationOptions =
    {
        Prop = "prop_ld_suitcase_01",
        PropBone = 57005,
        PropPlacement = {0.39, 0.0, 0.0, 0.0, 266.0, 60.0},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["suitcase2"] = {"missheistdocksprep1hold_cellphone", "static", "手提箱2", AnimationOptions =
    {
        Prop = "prop_security_case_01",
        PropBone = 57005,
        PropPlacement = {0.10, 0.0, 0.0, 0.0, 280.0, 53.0},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["mugshot"] = {"mp_character_creation@customise@male_a", "loop", "大头照", AnimationOptions =
    {
        Prop = 'prop_police_id_board',
        PropBone = 58868,
        PropPlacement = {0.12, 0.24, 0.0, 5.0, 0.0, 70.0},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["coffee"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "咖啡", AnimationOptions =
    {
        Prop = 'p_amb_coffeecup_01',
        PropBone = 28422,
        PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["whiskey"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "威士忌", AnimationOptions =
    {
        Prop = 'prop_drink_whisky',
        PropBone = 28422,
        PropPlacement = {0.01, -0.01, -0.06, 0.0, 0.0, 0.0},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["beer"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "啤酒", AnimationOptions =
    {
        Prop = 'prop_amb_beer_bottle',
        PropBone = 28422,
        PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["cup"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "杯子", AnimationOptions =
    {
        Prop = 'prop_plastic_cup_02',
        PropBone = 28422,
        PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["donut"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "甜甜圈", AnimationOptions =
    {
        Prop = 'prop_amb_donut',
        PropBone = 18905,
        PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0},
        EmoteMoving = true,
    }},
    ["burger"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "汉堡", AnimationOptions =
    {
        Prop = 'prop_cs_burger_01',
        PropBone = 18905,
        PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0},
        EmoteMoving = true,
    }},
    ["sandwich"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "三明治", AnimationOptions =
    {
        Prop = 'prop_sandwich_01',
        PropBone = 18905,
        PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0},
        EmoteMoving = true,
    }},
    ["soda"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "苏打", AnimationOptions =
    {
        Prop = 'prop_ecola_can',
        PropBone = 28422,
        PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 130.0},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["egobar"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "巧克力棒", AnimationOptions =
    {
        Prop = 'prop_choc_ego',
        PropBone = 60309,
        PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        EmoteMoving = true,
    }},
    ["wine"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "红酒", AnimationOptions =
    {
        Prop = 'prop_drink_redwine',
        PropBone = 18905,
        PropPlacement = {0.10, -0.03, 0.03, -100.0, 0.0, -10.0},
        EmoteMoving = true,
        EmoteLoop = true
    }},
    ["flute"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "长笛", AnimationOptions =
    {
        Prop = 'prop_champ_flute',
        PropBone = 18905,
        PropPlacement = {0.10, -0.03, 0.03, -100.0, 0.0, -10.0},
        EmoteMoving = true,
        EmoteLoop = true
    }},
    ["champagne"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "香槟", AnimationOptions =
    {
        Prop = 'prop_drink_champ',
        PropBone = 18905,
        PropPlacement = {0.10, -0.03, 0.03, -100.0, 0.0, -10.0},
        EmoteMoving = true,
        EmoteLoop = true
    }},
    ["cigar"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "雪茄", AnimationOptions =
    {
        Prop = 'prop_cigar_02',
        PropBone = 47419,
        PropPlacement = {0.010, 0.0, 0.0, 50.0, 0.0, -80.0},
        EmoteMoving = true,
        EmoteDuration = 2600
    }},
    ["cigar2"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "雪茄2", AnimationOptions =
    {
        Prop = 'prop_cigar_01',
        PropBone = 47419,
        PropPlacement = {0.010, 0.0, 0.0, 50.0, 0.0, -80.0},
        EmoteMoving = true,
        EmoteDuration = 2600
    }},
    ["guitar"] = {"amb@world_human_musician@guitar@male@idle_a", "idle_b", "吉他", AnimationOptions =
    {
        Prop = 'prop_acc_guitar_01',
        PropBone = 24818,
        PropPlacement = {-0.1, 0.31, 0.1, 0.0, 20.0, 150.0},
        EmoteMoving = true,
        EmoteLoop = true
    }},
    ["guitar2"] = {"switch@trevor@guitar_beatdown", "001370_02_trvs_8_guitar_beatdown_idle_busker", "吉他2", AnimationOptions =
    {
        Prop = 'prop_acc_guitar_01',
        PropBone = 24818,
        PropPlacement = {-0.05, 0.31, 0.1, 0.0, 20.0, 150.0},
        EmoteMoving = true,
        EmoteLoop = true
    }},
    ["guitarelectric"] = {"amb@world_human_musician@guitar@male@idle_a", "idle_b", "电吉他", AnimationOptions =
    {
        Prop = 'prop_el_guitar_01',
        PropBone = 24818,
        PropPlacement = {-0.1, 0.31, 0.1, 0.0, 20.0, 150.0},
        EmoteMoving = true,
        EmoteLoop = true
    }},
    ["guitarelectric2"] = {"amb@world_human_musician@guitar@male@idle_a", "idle_b", "电吉他2", AnimationOptions =
    {
        Prop = 'prop_el_guitar_03',
        PropBone = 24818,
        PropPlacement = {-0.1, 0.31, 0.1, 0.0, 20.0, 150.0},
        EmoteMoving = true,
        EmoteLoop = true
    }},
    ["book"] = {"cellphone@", "cellphone_text_read_base", "书", AnimationOptions =
    {
        Prop = 'prop_novel_01',
        PropBone = 6286,
        PropPlacement = {0.15, 0.03, -0.065, 0.0, 180.0, 90.0}, -- This positioning isnt too great, was to much of a hassle
        EmoteMoving = true,
        EmoteLoop = true
    }},
    ["bouquet"] = {"impexp_int-0", "mp_m_waremech_01_dual-0", "花束", AnimationOptions =
    {
        Prop = 'prop_snow_flower_02',
        PropBone = 24817,
        PropPlacement = {-0.29, 0.40, -0.02, -90.0, -90.0, 0.0},
        EmoteMoving = true,
        EmoteLoop = true
    }},
    ["teddy"] = {"impexp_int-0", "mp_m_waremech_01_dual-0", "泰迪", AnimationOptions =
    {
        Prop = 'v_ilev_mr_rasberryclean',
        PropBone = 24817,
        PropPlacement = {-0.20, 0.46, -0.016, -180.0, -90.0, 0.0},
        EmoteMoving = true,
        EmoteLoop = true
    }},
    ["backpack"] = {"move_p_m_zero_rucksack", "idle", "背包", AnimationOptions =
        {
            Prop = 'p_michael_backpack_s',
            PropBone = 24818,
            PropPlacement = {0.07, -0.11, -0.05, 0.0, 90.0, 175.0},
            EmoteMoving = true,
            EmoteLoop = true
        }},
    ["clipboard"] = {"missfam4", "base", "剪贴板", AnimationOptions =
        {
            Prop = 'p_amb_clipboard_01',
            PropBone = 36029,
            PropPlacement = {0.16, 0.08, 0.1, -130.0, -50.0, 0.0},
            EmoteMoving = true,
            EmoteLoop = true
        }},
    ["map"] = {"amb@world_human_tourist_map@male@base", "base", "地图", AnimationOptions =
        {
            Prop = 'prop_tourist_map_01',
            PropBone = 28422,
            PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
            EmoteMoving = true,
            EmoteLoop = true
        }},
    ["beg"] = {"amb@world_human_bum_freeway@male@base", "base", "乞讨", AnimationOptions =
        {
            Prop = 'prop_beggers_sign_03',
            PropBone = 58868,
            PropPlacement = {0.19, 0.18, 0.0, 5.0, 0.0, 40.0},
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["makeitrain"] = {"anim@mp_player_intupperraining_cash", "idle_a", "撒钱", AnimationOptions =
        {
            Prop = 'prop_anim_cash_pile_01',
            PropBone = 60309,
            PropPlacement = {0.0, 0.0, 0.0, 180.0, 0.0, 70.0},
            EmoteMoving = true,
            EmoteLoop = true,
            PtfxAsset = "scr_xs_celebration",
            PtfxName = "scr_xs_money_rain",
            PtfxPlacement = {0.0, 0.0, -0.09, -80.0, 0.0, 0.0, 1.0},
            PtfxInfo = Config.Languages[Config.MenuLanguage]['makeitrain'],
            PtfxWait = 500,
        }},
    ["camera"] = {"amb@world_human_paparazzi@male@base", "base", "相机", AnimationOptions =
        {
            Prop = 'prop_pap_camera_01',
            PropBone = 28422,
            PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
            EmoteLoop = true,
            EmoteMoving = true,
            PtfxAsset = "scr_bike_business",
            PtfxName = "scr_bike_cfid_camera_flash",
            PtfxPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0},
            PtfxInfo = Config.Languages[Config.MenuLanguage]['camera'],
            PtfxWait = 200,
        }},
    ["champagnespray"] = {"anim@mp_player_intupperspray_champagne", "idle_a", "香槟喷洒", AnimationOptions =
        {
            Prop = 'ba_prop_battle_champ_open',
            PropBone = 28422,
            PropPlacement = {0.0,0.0,0.0,0.0,0.0,0.0},
            EmoteMoving = true,
            EmoteLoop = true,
            PtfxAsset = "scr_ba_club",
            PtfxName = "scr_ba_club_champagne_spray",
            PtfxPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
            PtfxInfo = Config.Languages[Config.MenuLanguage]['spraychamp'],
            PtfxWait = 500,
        }},
    ["joint"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "大麻烟", AnimationOptions =
        {
            Prop = 'p_cs_joint_02',
            PropBone = 47419,
            PropPlacement = {0.015, -0.009, 0.003, 55.0, 0.0, 110.0},
            EmoteMoving = true,
            EmoteDuration = 2600
        }},
    ["cig"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "香烟", AnimationOptions =
        {
            Prop = 'prop_amb_ciggy_01',
            PropBone = 47419,
            PropPlacement = {0.015, -0.009, 0.003, 55.0, 0.0, 110.0},
            EmoteMoving = true,
            EmoteDuration = 2600
        }},
    ["brief3"] = {"missheistdocksprep1hold_cellphone", "static", "简报3", AnimationOptions =
        {
            Prop = "prop_ld_case_01",
            PropBone = 57005,
            PropPlacement = {0.10, 0.0, 0.0, 0.0, 280.0, 53.0},
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["tablet"] = {"amb@world_human_tourist_map@male@base", "base", "平板电脑", AnimationOptions =
        {
            Prop = "prop_cs_tablet",
            PropBone = 28422,
            PropPlacement = {0.0, -0.03, 0.0, 20.0, -90.0, 0.0},
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["tablet2"] = {"amb@code_human_in_bus_passenger_idles@female@tablet@idle_a", "idle_a", "平板电脑2", AnimationOptions =
        {
            Prop = "prop_cs_tablet",
            PropBone = 28422,
            PropPlacement = {-0.05, 0.0, 0.0, 0.0, 0.0, 0.0},
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["phonecall"] = {"cellphone@", "cellphone_call_listen_base", "电话通话", AnimationOptions =
        {
            Prop = "prop_npc_phone_02",
            PropBone = 28422,
            PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["phone"] = {"cellphone@", "cellphone_text_read_base", "手机", AnimationOptions =
        {
            Prop = "prop_npc_phone_02",
            PropBone = 28422,
            PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["clean"] = {"timetable@floyd@clean_kitchen@base", "base", "清洁", AnimationOptions =
        {
            Prop = "prop_sponge_01",
            PropBone = 28422,
            PropPlacement = {0.0, 0.0, -0.01, 90.0, 0.0, 0.0},
            EmoteLoop = true,
            EmoteMoving = true,
        }},
    ["clean2"] = {"amb@world_human_maid_clean@", "base", "清洁2", AnimationOptions =
        {
            Prop = "prop_sponge_01",
            PropBone = 28422,
            PropPlacement = {0.0, 0.0, -0.01, 90.0, 0.0, 0.0},
            EmoteLoop = true,
            EmoteMoving = true,
        }},
}