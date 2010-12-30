if GetLocale() ~= "zhTW" then return end

local L

--------------
--  Magmaw  --
--------------
L = DBM:GetModLocalization("Magmaw")

L:SetGeneralLocalization({
	name 			= "熔喉"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
})

-------------------------------
--  Dark Iron Golem Council  --
-------------------------------
L = DBM:GetModLocalization("DarkIronGolemCouncil")

L:SetGeneralLocalization({
	name 			= "全能魔像防禦系統"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
	Magmatron		= "熔岩號",
	Electron		= "雷電號",
	Toxitron		= "烈毒號",
	Arcanotron		= "秘法號",
	SayBomb			= "我中了化學炸彈!"
})

L:SetOptionLocalization({
	SayBombTarget		= "當你是$spell:80157的目標時大喊",
	AcquiringTargetIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79501),
	ConductorIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79888),
	BombTargetIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(80094),
	ShadowInfusionIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92048)
})

----------------
--  Maloriak  --
----------------
L = DBM:GetModLocalization("Maloriak")

L:SetGeneralLocalization({
	name 			= "瑪洛里亞克"
})

L:SetWarningLocalization({
	WarnPhase		= "%s階段",
	WarnRemainingAdds	= "剩餘%d畸變"
})

L:SetTimerLocalization({
	TimerPhase		= "下一階段"
})

L:SetMiscLocalization({

	YellRed			= "紅色|r瓶子到鍋子裡!",--Partial matchs, no need for full strings unless you really want em, mod checks for both.
	YellBlue		= "藍色|r瓶子到鍋子裡!",
	YellGreen		= "綠色|r瓶子到鍋子裡!",
	YellDark		= "黑色|r瓶子到鍋子裡!",--guesswork, this isn't confirmed but if it's consistent with other strings is probably right.
	Red			= "紅色",
	Blue			= "藍色",
	Green			= "綠色",
	Dark			= "黑色"
})

L:SetOptionLocalization({
	WarnPhase		= "為那個階段即將到來顯示警告",
	WarnRemainingAdds	= "顯示剩餘多少畸變的警告",
	TimerPhase		= "為下一階段顯示計時器",
	RangeFrame		= "藍色階段時顯示距離框 (6碼)",
	FlashFreezeIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92979),
	BitingChillIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77760),
	ConsumingFlamesIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77786)
})

-----------------
--  Chimaeron  --
-----------------
L = DBM:GetModLocalization("Chimaeron")

L:SetGeneralLocalization({
	name 			= "奇瑪隆"
})

L:SetWarningLocalization({
	WarnPhase2Soon		= "第2階段 即將到來",
	WarnBreak		= "%s: >%s< (%d)"
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
	WarnPhase2Soon		= "為第2階段顯示預先警告",
	WarnBreak		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(82881, GetSpellInfo(82881) or "unknown"),
	RangeFrame		= "顯示距離框 (6碼)"
})

-----------------
--  Atramedes  --
-----------------
L = DBM:GetModLocalization("Atramedes")

L:SetGeneralLocalization({
	name 			= "亞特拉米德"
})

L:SetWarningLocalization({
	WarnAirphase		= "空中階段",
	WarnGroundphase		= "地上階段",
	WarnShieldsLeft		= "使用了古代矮人盾牌 - 剩餘%d次"
})

L:SetTimerLocalization({
	TimerAirphase		= "空中階段",
	TimerGroundphase	= "地上階段"
})

L:SetMiscLocalization({
	AncientDwarvenShield	= "古代矮人盾牌",
	Airphase		= "沒錯，逃吧!每一步都會讓你的心跳加速。跳得轟隆作響...震耳欲聾。你逃不掉的!"
})

L:SetOptionLocalization({
	WarnAirphase		= "當亞特拉米德升空時顯示警告",
	WarnGroundphase		= "當亞特拉米德降落時顯示警告",
	WarnShieldsLeft		= "當古代矮人盾牌使用後顯示警告",
	TimerAirphase		= "為下一次 空中階段顯示計時器",
	TimerGroundphase	= "為下一次 地上階段顯示計時器",
	TrackingIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(78092)
})

----------------
--  Nefarian  --
----------------
L = DBM:GetModLocalization("Nefarian-BD")	-- No conflict with BWL version :)

L:SetGeneralLocalization({
	name 			= "奈法利安"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
	YellPhase2		= "Curse you, mortals! Such a callous disregard for one's possessions must be met with extreme force!",
	ShadowblazeCast		= "Flesh turns to ash!",
	ChromaticPrototype	= "Chromatic Prototype"
})

L:SetOptionLocalization({
})
