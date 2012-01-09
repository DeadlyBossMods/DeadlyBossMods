if GetLocale() ~= "zhTW"  then return end
local L

-------------
-- Morchok --
-------------
L= DBM:GetModLocalization(311)

L:SetWarningLocalization({
	KohcromWarning	= "%s:%s"
})

L:SetTimerLocalization({
	KohcromCD		= "寇魔的%s",
})

L:SetOptionLocalization({
	KohcromWarning	= "為寇魔的技能顯示警告。",
	KohcromCD		= "為寇魔下一次的技能顯示計時器。",
	RangeFrame		= "為成就顯示距離框(5碼)。"
})

L:SetMiscLocalization({
})

---------------------
-- Warlord Zon'ozz --
---------------------
L= DBM:GetModLocalization(324)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	ShadowYell			= "當你中了$spell:104600時大喊(英雄模式專用)",
	CustomRangeFrame	= "距離框選項(英雄模式專用)",
	Never				= "禁用",
	Normal				= "普通距離框架",
	DynamicPhase2		= "過濾第二階段減益",
	DynamicAlways		= "總是過濾減益"
})

L:SetMiscLocalization({
	voidYell			= "Gul'kafh an'qov N'Zoth."
})

-----------------------------
-- Yor'sahj the Unsleeping --
-----------------------------
L= DBM:GetModLocalization(325)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	timerOozesActive	= "軟泥可被攻擊"
})

L:SetOptionLocalization({
	timerOozesActive	= "為軟泥重生後可被攻擊顯示計時器",
	RangeFrame			= "為$spell:104898顯示距離框(4碼)(普通以上的難度)"
})

L:SetMiscLocalization({
	Black			= "|cFF424242黑|r",
	Purple			= "|cFF9932CD紫|r",
	Red				= "|cFFFF0404紅|r",
	Green			= "|cFF088A08綠|r",
	Blue			= "|cFF0080FF藍|r",
	Yellow			= "|cFFFFA901黃|r"
})

-----------------------
-- Hagara the Binder --
-----------------------
L= DBM:GetModLocalization(317)

L:SetWarningLocalization({
	warnFrostTombCast		= "%s 在八秒後"
})

L:SetTimerLocalization({
	TimerSpecial			= "第一次特別技能"
})

L:SetOptionLocalization({
	TimerSpecial			= "為第一次特別技能$spell:105256或$spell:105465施放顯示計時器\n(第一次施放根據首領手中的武器的附魔)",
	RangeFrame				= "為$spell:105269(3碼),$journal:4327(10碼)顯示距離框",
	AnnounceFrostTombIcons	= "為$spell:104451的目標發佈圖示至團隊頻道\n(需要團隊隊長)",
	warnFrostTombCast		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast:format(104448, GetSpellInfo(104448)),
	SetIconOnFrostTomb		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(104451),
	SetIconOnFrostflake		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(109325)
})

L:SetMiscLocalization({
	TombIconSet				= "寒冰之墓{rt%d}標記於%s"
})

---------------
-- Ultraxion --
---------------
L= DBM:GetModLocalization(331)

L:SetWarningLocalization({
	specWarnHourofTwilightN		= "%s (%d)在5秒後"--spellname Count
})

L:SetTimerLocalization({
	TimerDrakes			= "%s",
	TimerCombatStart	= "戰鬥開始",
	timerRaidCDs		= "%s冷卻:%s"
})

L:SetOptionLocalization({
	TimerDrakes			= "為暮光猛擊者$spell:109904顯示計時器",
	TimerCombatStart	= "為戰鬥開始時間顯示計時器",
	ResetHoTCounter		= "重置暮光之時計數",--$spell doesn't work in this function apparently so use typed spellname for now.
	Never				= "不使用",
	Reset3				= "每三次/兩次重置計數(英雄/普通)",
	Reset3Always		= "總是每三次重置計數",
	SpecWarnHoTN		= "前五秒特別警告所設定的暮光之時計數(只適用在每三次重置)",
	One					= "1(即為第1 4 7次)",
	Two					= "2(即為第2 5次)",
	Three				= "3(即為第3 6次)",
	ShowRaidCDs			= "為團隊冷卻顯示計時器",
	ShowRaidCDsSelf		= "只顯示你的團隊冷卻計時器\n(需要開啟團隊冷卻)"
})

L:SetMiscLocalization({
	Trash				= "很高興又見到你，雅立史卓莎。我離開這段時間忙得很。",
	Pull				= "我感到平衡被一股強大的波動干擾。如此混沌在燃燒我的心靈!"
})

-------------------------
-- Warmaster Blackhorn --
-------------------------
L= DBM:GetModLocalization(332)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	TimerCombatStart	= "戰鬥開始",
	TimerAdd			= "下一次精英暮光"
})

L:SetOptionLocalization({
	TimerCombatStart	= "為戰鬥開始時間顯示計時器",
	TimerAdd			= "為下一次精英暮光顯示計時器"
})

L:SetMiscLocalization({
	SapperEmote			= "一頭龍急速飛來，載送一名暮光工兵降落到甲板上!",
	Broadside			= "spell:110153",
	DeckFire			= "spell:110095"
})

-------------------------
-- Spine of Deathwing  --
-------------------------
L= DBM:GetModLocalization(318)

L:SetWarningLocalization({
	SpecWarnTendril			= "已被安全抓住!"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SpecWarnTendril			= "當你身上沒有$spell:109454減益時顯示特別警告",
	InfoFrame				= "為沒有$spell:109454的玩家顯示訊息框",
	SetIconOnGrip			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(109459),
	ShowShieldInfo			= "為$spell:105479顯示生命條"
})

L:SetMiscLocalization({
	Pull			= "他的護甲!他正在崩壞!破壞他的護甲，我們就有機會打贏他了!",
	NoDebuff		= "無%s",
	PlasmaTarget	= "燃燒血漿: %s",
	DRoll			= "他準備往",
	DLevels			= "回復平衡"
})

---------------------------
-- Madness of Deathwing  -- 
---------------------------
L= DBM:GetModLocalization(333)

L:SetWarningLocalization({
	SpecWarnTentacle	= "快攻擊極熾觸手!",
	SpecWarnCongealing	= "快攻擊凝結之血!"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SpecWarnTentacle	= "為極熾觸手生長顯示特別警告(當雅立史卓莎不在場時)",
	SpecWarnCongealing	= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format(109089),
	RangeFrame			= "根據玩家減益顯示動態的距離框以對應英雄模式的$spell:108649",
	SetIconOnParasite	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(108649)
})

L:SetMiscLocalization({
	Pull				= "你們都徒勞無功。我會撕裂你們的世界。"
})
