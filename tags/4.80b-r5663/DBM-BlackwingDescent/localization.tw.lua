if GetLocale() ~= "zhTW" then return end

local L

--------------
--  Magmaw  --
--------------
L = DBM:GetModLocalization("Magmaw")

L:SetGeneralLocalization({
	name 				= "熔喉"
})

L:SetWarningLocalization({
	SpecWarnInferno			= "熾熱的煉獄 即將到來 (~4秒)"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SpecWarnInferno			= "為$spell:92190顯示預先特別警告 (~4秒)",
	RangeFrame			= "第2階段時顯示距離框 (5碼)"
})

L:SetMiscLocalization({
	Slump				= "%s往前撲倒，露出他的鉗子!",
	HeadExposed			= "%s被釘在尖刺上，露出了他的頭!",
	YellPhase2			= "真難想像!看來你真有機會打敗我的蟲子!也許我可幫忙...扭轉戰局。"
})

-------------------------------
--  Dark Iron Golem Council  --
-------------------------------
L = DBM:GetModLocalization("DarkIronGolemCouncil")

L:SetGeneralLocalization({
	name 				= "全能魔像防禦系統"
})

L:SetWarningLocalization({
	SpecWarnActivated		= "轉換目標到 %s!",
	specWarnGenerator		= "發電機 - 拉開%s!",
	timerArcaneLockout		= "秘法殲滅者鎖定"
})

L:SetTimerLocalization({
	timerArcaneBlowbackCast		= "秘法逆爆",
	timerShadowConductorCast	= "眾影體",
	timerNefAblity			= "技能增益冷卻"
})

L:SetOptionLocalization({
	timerShadowConductorCast	= "為$spell:92048的施放顯示計時器",
	timerArcaneBlowbackCast		= "為$spell:91879的施放顯示計時器",
	timerArcaneLockout		= "為$spell:91542法術鎖定顯示計時器",
	timerNefAblity			= "為困難技能增益冷卻顯示計時器",
	SpecWarnActivated		= "當新首領啟動時顯示特別警告",
	specWarnGenerator		= "當首領獲得$spell:91557時顯示特別警告",
	AcquiringTargetIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79501),
	ConductorIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79888),
	BombTargetIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(80094),
	ShadowConductorIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92053)
})

L:SetMiscLocalization({
	Magmatron			= "熔岩號",
	Electron			= "雷電號",
	Toxitron			= "烈毒號",
	Arcanotron			= "秘法號",
	YellTargetLock			= "覆體之影! 遠離我!"
})

----------------
--  Maloriak  --
----------------
L = DBM:GetModLocalization("Maloriak")

L:SetGeneralLocalization({
	name 				= "瑪洛里亞克"
})

L:SetWarningLocalization({
	WarnPhase			= "%s階段",
	WarnRemainingAdds		= "剩餘%d畸變"
})

L:SetTimerLocalization({
	TimerPhase			= "下一階段"
})

L:SetOptionLocalization({
	WarnPhase			= "為那個階段即將到來顯示警告",
	WarnRemainingAdds		= "顯示剩餘多少畸變的警告",
	TimerPhase			= "為下一階段顯示計時器",
	RangeFrame			= "藍色階段時顯示距離框 (6碼)",
	SetTextures			= "自動在黑暗階段停用投影材質\n(離開黑暗階段後回到啟用)",
	FlashFreezeIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92979),
	BitingChillIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77760),
	ConsumingFlamesIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77786)
})

L:SetMiscLocalization({

	YellRed				= "紅色|r瓶子到鍋子裡!",
	YellBlue			= "藍色|r瓶子到鍋子裡!",
	YellGreen			= "綠色|r瓶子到鍋子裡!",
	YellDark			= "黑暗|r魔法到鍋子裡!",
	Red				= "紅色",
	Blue				= "藍色",
	Green				= "綠色",
	Dark				= "黑暗"
})

-----------------
--  Chimaeron  --
-----------------
L = DBM:GetModLocalization("Chimaeron")

L:SetGeneralLocalization({
	name 				= "奇瑪隆"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	RangeFrame			= "顯示距離框 (6碼)",
	SetIconOnSlime			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82935),
	InfoFrame			= "為血量(低於1萬血)顯示資訊框架"
})

L:SetMiscLocalization({
	HealthInfo			= "血量資訊"
})

-----------------
--  Atramedes  --
-----------------
L = DBM:GetModLocalization("Atramedes")

L:SetGeneralLocalization({
	name 				= "亞特拉米德"
})

L:SetWarningLocalization({
	WarnAirphase			= "空中階段",
	WarnGroundphase			= "地上階段",
	WarnShieldsLeft			= "使用了古代矮人盾牌 - 剩餘%d次",
	warnAddSoon			= "討人厭的惡魔已被召喚了",
	specWarnAddTargetable		= "%s可以點擊了"
})

L:SetTimerLocalization({
	TimerAirphase			= "下一次 空中階段",
	TimerGroundphase		= "下一次 地上階段"
})

L:SetOptionLocalization({
	WarnAirphase			= "當亞特拉米德升空時顯示警告",
	WarnGroundphase			= "當亞特拉米德降落時顯示警告",
	WarnShieldsLeft			= "當古代矮人盾牌使用後顯示警告",
	warnAddSoon			= "當奈法利安召喚小怪時顯示警告",
	specWarnAddTargetable		= "當小怪可以點擊時顯示特別警告",
	TimerAirphase			= "為下一次 空中階段顯示計時器",
	TimerGroundphase		= "為下一次 地上階段顯示計時器",
	InfoFrame			= "為音波值顯示資訊框架",
	TrackingIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(78092)
})

L:SetMiscLocalization({
	AncientDwarvenShield		= "古代矮人盾牌",
	Soundlevel			= "聲音值",
	YellPestered			= "討人厭的惡魔在我這裡!",--npc 49740
	NefAdd				= "亞特拉米德，英雄們就在那!",
	Airphase			= "沒錯，逃吧!每一步都會讓你的心跳加速。跳得轟隆作響...震耳欲聾。你逃不掉的!"
})

----------------
--  Nefarian  --
----------------
L = DBM:GetModLocalization("Nefarian-BD")	-- No conflict with BWL version :)

L:SetGeneralLocalization({
	name 				= "奈法利安的末日"
})

L:SetWarningLocalization({
	OnyTailSwipe			= "尾部鞭擊 (奧妮克希亞)",
	NefTailSwipe			= "尾部鞭擊 (奈法利安)",
	OnyBreath			= "暗影焰息 (奧妮克希亞)",
	NefBreath			= "暗影焰息 (奈法利安)",
	specWarnShadowblazeSoon		= "暗影炎 即將到來 (~5秒)"
})

L:SetTimerLocalization({
	OnySwipeTimer			= "尾部鞭擊冷卻 (奧妮)",
	NefSwipeTimer			= "尾部鞭擊冷卻 (奈法)",
	OnyBreathTimer			= "暗影焰息冷卻 (奧妮)",
	NefBreathTimer			= "暗影焰息冷卻 (奈法)"
})

L:SetOptionLocalization({
	OnyTailSwipe			= "為奧妮克希亞的$spell:77827顯示警告",
	NefTailSwipe			= "為奈法利安的$spell:77827顯示警告",
	OnyBreath			= "為奧妮克希亞的$spell:94124顯示警告",
	NefBreath			= "為奈法利安的$spell:94124顯示警告",
	specWarnShadowblazeSoon		= "為$spell:94085顯示預先特別警告 (~5秒)",
	OnySwipeTimer			= "為奧妮克希亞的$spell:77827的冷卻時間顯示計時器",
	NefSwipeTimer			= "為奈法利安的$spell:77827的冷卻時間顯示計時器",
	OnyBreathTimer			= "為奧妮克希亞的$spell:94124的冷卻時間顯示計時器",
	NefBreathTimer			= "為奈法利安的$spell:94124的冷卻時間顯示計時器",
	InfoFrame			= "為奧妮克希亞的電流充能顯示資訊框架",
	SetWater			= "進入戰鬥後自動停用水體細節\n(離開戰鬥後回到啟用)",
	TankArrow			= "為風箏復生的白骨戰士的人顯示DBM箭頭\n(設計為只有一個風箏坦)",--npc 41918
	SetIconOnCinder			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79339),
	RangeFrame			= "為$spell:79339顯示距離框 (10碼)\n(當你中減益時顯示所有人, 否則只顯示中的人)"
})

L:SetMiscLocalization({
	NefAoe				= "響起了電流霹啪作響的聲音!",
	YellPhase2 			= "詛咒你們，凡人!如此冷酷地漠視他人的所有物必須受到嚴厲的懲罰!",
	YellPhase3			= "我本來只想略盡地主之誼，但是你們就是不肯痛快的受死!是時候拋下一切的虛偽...殺光你們就好!",
	Nefarian			= "奈法利安",
	Onyxia				= "奧妮克希亞",
	Charge				= "電流充能"
})

--------------
--  Blackwing Descent Trash  --
--------------
L = DBM:GetModLocalization("BWDTrash")

L:SetGeneralLocalization({
	name = "黑翼陷窟小怪"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})