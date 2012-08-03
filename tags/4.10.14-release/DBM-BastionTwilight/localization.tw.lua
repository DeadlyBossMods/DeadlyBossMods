if GetLocale() ~= "zhTW" then return end

local L

--------------------------
--  Halfus Wyrmbreaker  --
--------------------------
L= DBM:GetModLocalization(156)

L:SetOptionLocalization({
	ShowDrakeHealth		= "顯示已被釋放的小龍血量\n(需要先開啟首領血量)"
})

---------------------------
--  Valiona & Theralion  --
---------------------------
L= DBM:GetModLocalization(157)

L:SetOptionLocalization({
	TBwarnWhileBlackout	= "當$spell:86788生效時顯示$spell:92898警告",
	TwilightBlastArrow	= "當你附近的人中了$spell:92898時顯示DBM箭頭",
	RangeFrame			= "顯示距離框(10碼)",
	BlackoutShieldFrame	= "為$spell:92878顯示首領血量條",
	BlackoutIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92878),
	EngulfingIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(86622)
})

L:SetMiscLocalization({
	Trigger1			= "深呼吸",
	BlackoutTarget		= "昏天暗地:%s"
})

----------------------------------
--  Twilight Ascendant Council  --
----------------------------------
L= DBM:GetModLocalization(158)

L:SetWarningLocalization({
	specWarnBossLow			= "%s血量低於30%% - 即將進入下一階段!",
	SpecWarnGrounded		= "拿取禁錮增益",
	SpecWarnSearingWinds	= "拿取旋風增益"
})

L:SetTimerLocalization({
	timerTransition			= "階段轉換"
})

L:SetOptionLocalization({
	specWarnBossLow			= "當首領血量低於30%時顯示特別警告",
	SpecWarnGrounded		= "當你缺少$spell:83581時顯示特別警告\n(大約施放前10秒內)",
	SpecWarnSearingWinds	= "當你缺少$spell:83500時顯示特別警告\n(大約施放前10秒內)",
	timerTransition			= "顯示階段轉換計時器",
	RangeFrame	 			= "當需要時自動顯示距離框",
	yellScrewed				= "當你同時有$spell:83099和$spell:92307時大喊",
	InfoFrame				= "顯示沒有$spell:83581或$spell:83500的玩家",
	HeartIceIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82665),
	BurningBloodIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82660),
	LightningRodIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(83099),
	GravityCrushIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(84948),
	FrostBeaconIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92307),
	StaticOverloadIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92067),
	GravityCoreIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92075)
})

L:SetMiscLocalization({
	Quake			= "你腳下的地面開始不祥地震動起來....",
	Thundershock	= "四周的空氣爆出能量霹啪作響聲音....",
	Switch			= "我們會解決他們!",
	Phase3			= "見證你的滅亡!",
	Kill			= "不可能...",
	blizzHatesMe	= "我中了冰凍寶珠和聚雷針!清出一條路來!",
	WrongDebuff	    = "無%s"
})

----------------
--  Cho'gall  --
----------------
L= DBM:GetModLocalization(167)

L:SetOptionLocalization({
	CorruptingCrashArrow	= "當你附近的人中了$spell:93178時顯示DBM箭頭",
	InfoFrame				= "為$journal:3165顯示資訊框架",
	RangeFrame				= "為$spell:82235顯示距離框(5碼)",
	SetIconOnWorship		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(91317),
	SetIconOnCreature		= "設定標記到暗色觸鬚"
})

----------------
--  Sinestra  --
----------------
L= DBM:GetModLocalization(168)

L:SetWarningLocalization({
	WarnOrbSoon			= "暗影寶珠在%d秒!",
	WarnEggWeaken		= "暮光殼甲從幕光蛋上消散!",
	SpecWarnOrbs		= "暗影寶珠!小心!",
	warnWrackJump		= "%s跳到>%s<",
	warnAggro			= ">%s<為暗影寶珠的目標(可能的目標)",
	SpecWarnAggroOnYou	= "小心暗影寶珠!"
})

L:SetTimerLocalization({
	TimerEggWeakening	= "暮光殼甲消散",
	TimerEggWeaken		= "暮光殼甲重生",
	TimerOrbs			= "下一次暗影寶珠"
})

L:SetOptionLocalization({
	WarnOrbSoon			= "提前警告暗影寶珠(5秒前, 每1秒)\n(猜測的時間，可能不準確)",
	WarnEggWeaken		= "提前警告當$spell:87654消散",
	warnWrackJump		= "提示$spell:92955的目標",
	warnAggro			= "提示玩家暗影寶珠的目標(可能的目標)",
	SpecWarnAggroOnYou	= "顯示特別警告當你是暗影寶珠的目標時\n(可能的目標)",
	SpecWarnOrbs		= "顯示特別警告暗影寶珠施放(猜測的警告)",
	TimerEggWeakening	= "顯示$spell:87654消散的計時器",
	TimerEggWeaken		= "顯示$spell:87654重生的計時器",
	TimerOrbs			= "顯示下一個暗影寶珠的計時器(猜測的時間，可能不準確)",
	SetIconOnOrbs		= "標記圖示給暗影寶珠的目標(可能的目標)",
	OrbsCountdown		= "為暗影寶珠播放倒數音效",
	InfoFrame			= "為有仇恨的玩家顯示訊息框"
})

L:SetMiscLocalization({
	YellDragon			= "吃吧，孩子們!好好享用他們肥嫩的軀殼吧!",
	YellEgg				= "你以為這樣就佔了上風?愚蠢!",
	HasAggro			= "有仇恨"
})

-------------------------------------
--  The Bastion of Twilight Trash  --
-------------------------------------
L = DBM:GetModLocalization("BoTrash")

L:SetGeneralLocalization({
	name =	"暮光堡壘小怪"
})
