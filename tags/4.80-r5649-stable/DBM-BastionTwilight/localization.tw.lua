if GetLocale() ~= "zhTW" then return end

local L

--------------------------
--  Halfus Wyrmbreaker  --
--------------------------
L = DBM:GetModLocalization("HalfusWyrmbreaker")

L:SetGeneralLocalization({
	name 			= "哈福斯•破龍者"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	ShowDrakeHealth		= "顯示已被釋放的小龍血量\n(需要先開啟首領血量)"
})

L:SetMiscLocalization({
})

---------------------------
--  Valiona & Theralion  --
---------------------------
L = DBM:GetModLocalization("ValionaTheralion")

L:SetGeneralLocalization({
	name 			= "瓦莉歐娜和瑟拉里恩"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	TBwarnWhileBlackout	= "當$spell:86788生效時顯示$spell:92898警告",
	TwilightBlastArrow	= "當你附近的人中了$spell:92898時顯示DBM箭頭",
	RangeFrame		= "顯示距離框 (10碼)",
	BlackoutShieldFrame	= "為$spell:92878顯示首領血量及血量條",
	BlackoutIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92878),
	EngulfingIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(86622)
})

L:SetMiscLocalization({
	Trigger1		= "深呼吸",
	BlackoutTarget		= "昏天暗地: %s"
})

----------------------------------
--  Twilight Ascendant Council  --
----------------------------------
L = DBM:GetModLocalization("AscendantCouncil")

L:SetGeneralLocalization({
	name 			= "暮光卓越者議會"
})

L:SetWarningLocalization({
	specWarnBossLow		= "%s血量低於30%% - 即將進入下一階段!",
	SpecWarnGrounded	= "拿取禁錮增益",
	SpecWarnSearingWinds	= "拿取旋風增益"
})

L:SetTimerLocalization({
	timerTransition		= "階段轉換"
})

L:SetOptionLocalization({
	specWarnBossLow		= "當首領血量低於30%時顯示特別警告",
	SpecWarnGrounded	= "當你缺少$spell:83581時顯示特別警告\n(大約施放前10秒內)",
	SpecWarnSearingWinds	= "當你缺少$spell:83500時顯示特別警告\n(大約施放前10秒內)",
	timerTransition		= "顯示階段轉換計時器",
	RangeFrame		= "當需要時自動顯示距離框",
	HeartIceIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82665),
	BurningBloodIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82660),
	LightningRodIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(83099),
	GravityCrushIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(84948),
	FrostBeaconIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92307),
	StaticOverloadIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92067),
	GravityCoreIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92075)
})

L:SetMiscLocalization({
	Quake			= "你腳下的地面開始不祥地震動起來....",
	Thundershock		= "四周的空氣爆出能量霹啪作響聲音....",
	Switch			= "我們會解決他們!",
	Phase3			= "見證你的滅亡!",
	Ignacious		= "伊格納修斯",
	Feludius		= "費魯迪厄斯",
	Arion			= "艾理奧",
	Terrastra		= "特拉斯特拉",
	Monstrosity		= "卓越者議會",
	Kill			= "不可能..."
})

----------------
--  Cho'gall  --
----------------
L = DBM:GetModLocalization("Chogall")

L:SetGeneralLocalization({
	name 			= "丘加利"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	CorruptingCrashArrow	= "當你附近的人中了$spell:93178時顯示DBM箭頭",
	InfoFrame		= "為$spell:81701顯示資訊框架",
	RangeFrame		= "為$spell:82235顯示距離框 (5碼)",
	SetIconOnWorship	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(91317),
	SetIconOnCreature	= "設定標記到暗色觸鬚"
})

L:SetMiscLocalization({
	Bloodlevel		= "腐化"
})

----------------
--  Sinestra  --
----------------
L = DBM:GetModLocalization("Sinestra")

L:SetGeneralLocalization({
	name 			= "賽絲特拉"
})

L:SetWarningLocalization({
	WarnDragon			= "Twilight Whelp Spawned",
	WarnOrbsSoon		= "Twilight Orbs in %d sec!",
	WarnEggWeaken		= "Twilight Carapace dissipated on Egg",
	SpecWarnOrbs		= "Twilight Orbs soon!",
	warnWrackJump		= "%s jumped to >%s<",
	WarnWrackCount5s	= "%d sec elapsed since last Wrack",
	SpecWarnDispel		= "%d sec elapsed since last Wrack - Dispel Now!",
	SpecWarnEggWeaken	= "Twilight Carapace dissipated - Dps EGG Now!",
	SpecWarnEggShield	= "Twilight Capapace Regenerated!"
})

L:SetTimerLocalization({
	TimerDragon			= "Next Twilight Whelps",
	TimerEggWeakening	= "Twilight Carapace dissipates",
	TimerEggWeaken		= "Twilight Capapace Regeneration"
})	

L:SetOptionLocalization({
	WarnDragon			= "Show warning when Twilight Whelp Spawns",
	WarnOrbsSoon		= "Show pre-warning for $spell:92954 (Before 5s, Every 1s)\n(Expected warning. may not be accurate. Can be spammy.)",
	WarnEggWeaken		= "Show pre-warning for when $spell:87654 dissipates",
	warnWrackJump		= "Announce $spell:92955 jump targets",
	WarnWrackCount5s	= "Announce $spell:92955 elapsed player duration at 10, 15, 20 seconds",
	SpecWarnOrbs		= "Show special warning for $spell:92954\n(Expected warning. may not be accurate)",
	SpecWarnDispel		= "Show special warning to dispel $spell:92955\n(after certain time elapsed from casted/jumped)",
	SpecWarnEggWeaken	= "Show special warning when $spell:87654 dissipates",
	SpecWarnEggShield	= "Show special warning when $spell:87654 regenerated",
	TimerDragon			= "Show timer for new Twilight Whelp",
	TimerEggWeakening	= "Show timer for when $spell:87654 dissipates",
	TimerEggWeaken		= "Show timer for $spell:87654 regeneration",
	SetIconOnOrbs		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92954)
})

L:SetMiscLocalization({
	YellDragon			= "Feed, children!  Take your fill from their meaty husks!",
	YellEgg				= "You mistake this for weakness?  Fool!"
})

--------------------------
--  The Bastion of Twilight Trash  --
--------------------------
L = DBM:GetModLocalization("BoTrash")

L:SetGeneralLocalization({
	name =	"暮光堡壘小怪"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})