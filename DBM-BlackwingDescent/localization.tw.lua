if GetLocale() ~= "zhTW" then return end

local L

--------------
--  Magmaw  --
--------------
L = DBM:GetModLocalization("Magmaw")

L:SetGeneralLocalization({
	name = "熔喉"
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
	name = "全能魔像防禦系統"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
	Magmatron	= "Magmatron",
	Electron	= "Electron",
	Toxitron	= "Toxitron",
	Arcanotron	= "Arcanotron",
	SayBomb		= "我中了化學炸彈!"
})

L:SetOptionLocalization({
	SayBombTarget	= "當你是$spell:80157的目標時大喊"
})

----------------
--  Maloriak  --
----------------
L = DBM:GetModLocalization("Maloriak")

L:SetGeneralLocalization({
	name = "瑪洛里亞克"
})

L:SetWarningLocalization({
	WarnPhase		= "%s階段",
	WarnRemainingAdds	= "剩餘%d畸變"
})

L:SetTimerLocalization({
	TimerPhase		= "下一階段"
})

L:SetMiscLocalization({
	YellRed			= "Mix and stir, apply heat...",
	YellBlue		= "How well does the mortal shell handle extreme temperature change? Must find out! For science!",
	YellGreen		= "This one's a little unstable, but what's progress without failure?",
	YellDark		= "Your mixtures are weak, Maloriak! They need a bit more... kick!",
	Red			= "紅色",
	Blue			= "藍色",
	Green			= "綠色",
	Dark			= "黑色"
})

L:SetOptionLocalization({
	WarnPhase		= "為那個階段即將到來顯示警告",
	WarnRemainingAdds	= "顯示剩餘多少畸變的警告",
	TimerPhase		= "為下一階段顯示計時器"
})

-----------------
--  Chimaeron  --
-----------------
L = DBM:GetModLocalization("Chimaeron")

L:SetGeneralLocalization({
	name = "奇瑪隆"
})

L:SetWarningLocalization({
	WarnPhase2Soon	= "第2階段 即將到來",
	WarnBreak	= "%s: >%s< (%d)"
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
	WarnPhase2Soon	= "為第2階段顯示預先警告",
	WarnBreak	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(82881, GetSpellInfo(82881) or "unknown")
})

-----------------
--  Atramedes  --
-----------------
L = DBM:GetModLocalization("Atramedes")

L:SetGeneralLocalization({
	name = "亞特拉米德"
})

L:SetWarningLocalization({
	WarnAirphase		= "空中階段",
	WarnGroundphase		= "地上階段",
	WarnShieldsLeft		= "使用了Ancient Dwarven Shield - 剩餘%d"
})

L:SetTimerLocalization({
	TimerAirphase		= "空中階段",
	TimerGroundphase	= "地上階段"
})

L:SetMiscLocalization({
	AncientDwarvenShield	= "Ancient Dwarven Shield",
	Airphase		= "Yes, run! With every step your heart quickens. The beating, loud and thunderous... Almost deafening. You cannot escape!"
})

L:SetOptionLocalization({
	WarnAirphase		= "當亞特拉米德升空時顯示警告",
	WarnGroundphase		= "當亞特拉米德降落時顯示警告",
	WarnShieldsLeft		= "當Ancient Dwarven Shield使用後顯示警告",
	TimerAirphase		= "為下一次 空中階段顯示計時器",
	TimerGroundphase	= "為下一次 地上階段顯示計時器"
})

----------------
--  Nefarian  --
----------------
L = DBM:GetModLocalization("Nefarian-BD")	-- No conflict with BWL version :)

L:SetGeneralLocalization({
	name = "奈法利安"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
	YellPhase2		= "Curse you, mortals! Such a callous disregard for one's possessions must be met with extreme force!",
	ChromaticPrototype	= "Chromatic Prototype"
})

L:SetOptionLocalization({
})
