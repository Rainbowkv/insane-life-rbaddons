Config = {
-- Change the language of the menu here!.
-- Note fr and de are google translated, if you would like to help out with translation / just fix it for your server check below and change translations yourself
-- try en, fr, de or sv.
	MenuLanguage = 'en',	
-- Set this to true to enable some extra prints
	DebugDisplay = false,
-- Set this to false if you have something else on X, and then just use /e c to cancel emotes.
	EnableXtoCancel = true,
    CancelKeybind = 177,
-- Set this to true if you want to disarm the player when they play an emote.
	DisarmPlayer= true,
-- Set this if you really wanna disable emotes in cars, as of 1.7.2 they only play the upper body part if in vehicle
    AllowedInCars = true,
-- You can disable the (F3) menu here / change the keybind.
	MenuKeybindEnabled = true,
	MenuKeybind = 170, -- Get the button number here https://docs.fivem.net/game-references/controls/
-- You can disable the Favorite emote keybinding here.
	FavKeybindEnabled = true,
	FavKeybind = 171, -- Get the button number here https://docs.fivem.net/game-references/controls/
-- You can change the header image for the f3 menu here
-- Use a 512 x 128 image!
-- NOte this might cause an issue of the image getting stuck on peoples screens
	CustomMenuEnabled = false,
	MenuImage = "C:\\Users\\rainbow\\Desktop\rp-server\\txData\\QBCoreFramework_5297D5.base\\resources\\[rb_addons]\\dpemotes\\MenuImage.png",
-- You can change the menu position here
	MenuPosition = "right", -- (left, right)
-- You can disable the Ragdoll keybinding here.
	RagdollEnabled = true,
	RagdollKeybind = 303, -- Get the button number here https://docs.fivem.net/game-references/controls/
-- You can disable the Facial Expressions menu here.
	ExpressionsEnabled = true,
-- You can disable the Walking Styles menu here.
	WalkingStylesEnabled = true,	
-- You can disable the Shared Emotes here.
    SharedEmotesEnabled = true,
    CheckForUpdates = true,
-- If you have the SQL imported enable this to turn on keybinding.
    SqlKeybinding = false,
}

Config.KeybindKeys = {
    ['num4'] = 108,
    ['num5'] = 110,
    ['num6'] = 109,
    ['num7'] = 117,
    ['num8'] = 111,
    ['num9'] = 118
}

Config.Languages = {
  ['en'] = {
    ['emotes'] = '表情/动作',
    ['danceemotes'] = "🕺 舞蹈动作",
    ['propemotes'] = "📦 小道具",
    ['favoriteemotes'] = "🌟 私人收藏",
    ['favoriteinfo'] = "选择动作设置成最爱",
    ['rfavorite'] = "重设最爱",
    ['prop2info'] = "❓ 道具动作可以位于末尾",
    ['set'] = "设置 (",
    ['setboundemote'] = ") 成为您的专属表情?",
    ['newsetemote'] = "~w~ 现在是您的专属表情, 按 ~g~CapsLock~w~ 使用.",
    ['cancelemote'] = "取消表情",
    ['cancelemoteinfo'] = "~r~X~w~ 取消当前正在播放的表情",
    ['walkingstyles'] = "走路风格",
    ['resetdef'] = "重置为默认",
    ['normalreset'] = "正常 (重置)",
    ['moods'] = "情绪",
    ['infoupdate'] = "信息",
    ['infoupdateav'] = "信息 (更新可用)",
    ['infoupdateavtext'] = "有可用更新，获取最新版本请访问 ~y~https://github.com/andristum/dpemotes~w~",
    ['suggestions'] = "建议?",
    ['suggestionsinfo'] = "在瑞文斯kook社区上提交功能/表情建议! ✉️",
    ['notvaliddance'] = "不是有效的舞蹈。",
    ['notvalidemote'] = "不是有效的表情。",
    ['nocancel'] = "没有表情可取消。",
    ['maleonly'] = "此表情仅限男性，抱歉！",
    ['emotemenucmd'] = "输入 /emotemenu 打开菜单。",
    ['shareemotes'] = "👫 共享表情",
    ['shareemotesinfo'] = "邀请附近的人一起表演",
    ['sharedanceemotes'] = "🕺 共享舞蹈",
    ['notvalidsharedemote'] = "不是有效的共享表情。",
    ['sentrequestto'] = "已发送请求给 ~y~",
    ['nobodyclose'] = "附近没有人 ~r~足够~w~接近。",
    ['doyouwanna'] = "~y~Y~w~ 接受，~r~L~w~ 拒绝 (~g~",
    ['refuseemote'] = "表情被拒绝。",
    ['makenearby'] = "让附近的玩家表演",
    ['camera'] = "按 ~y~G~w~ 使用相机闪光灯。",
    ['makeitrain'] = "按 ~y~G~w~ 让它下雨。",
    ['pee'] = "长按 ~y~G~w~ 小便。",
    ['spraychamp'] = "长按 ~y~G~w~ 喷洒香槟。",
    ['bound'] = "绑定 ",
    ['to'] = "到",
    ['currentlyboundemotes'] = " 当前绑定的表情:",
    ['notvalidkey'] = "不是有效的按键。",
    ['keybinds'] = "🔢 按键绑定",
    ['keybindsinfo'] = "使用"
  }
}