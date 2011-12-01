if GetLocale() ~= "zhTW"  then return end
local L

-------------
-- Morchok --
-------------
L= DBM:GetModLocalization(311)

L:SetWarningLocalization({
	SpecwarnVortexAfter	= "快躲到柱子後!"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SpecwarnVortexAfter	= "當$spell:110047結束時顯示特別警告"
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
	RangeFrame	= "為$spell:104601顯示距離框(10碼)\n(英雄模式)"
})

L:SetMiscLocalization({
})

-----------------------------
-- Yor'sahj the Unsleeping --
-----------------------------
L= DBM:GetModLocalization(325)

L:SetWarningLocalization({
	warnOozes		= "軟泥即將來臨!: %s",
	specWarnOozes	= "軟泥來臨!",
	specWarnManaVoid= "潰法力場 - 更換目標"
})

L:SetTimerLocalization({
	timerOozesCD	= "下一次軟泥"
})

L:SetOptionLocalization({
	warnOozes			= "當軟泥重生時顯示警告",
	specWarnOozes		= "當軟泥重生時顯示特別警告",
	specWarnManaVoid	= "為$spell:105530出現時顯示特別警告",
	timerOozesCD		= "為下一次軟泥重生顯示計時器"
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
	TimerSpecial			= "第一次階段轉換"
})

L:SetOptionLocalization({
	TimerSpecial			= "為第一次特別技能施放顯示計時器",
	RangeFrame				= "為$spell:105269顯示距離框(3碼)",
	AnnounceFrostTombIcons	= "為$spell:104451的目標發佈圖示至團隊頻道\n(需要團隊隊長)",
	warnFrostTombCast		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast:format(104448, GetSpellInfo(104448)),
	SetIconOnFrostTomb		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(104451)
})

L:SetMiscLocalization({
	TombIconSet				= "寒冰之墓標記{rt%d}設置於 %s"
})

---------------
-- Ultraxion --
---------------
L= DBM:GetModLocalization(331)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	TimerCombatStart	= "戰鬥開始"
})

L:SetOptionLocalization({
	TimerCombatStart	= "為戰鬥開始時間顯示計時器"
})

L:SetMiscLocalization({
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
	TimerSapper			= "下一次暮光工兵"
})

L:SetOptionLocalization({
	TimerCombatStart	= "為戰鬥開始時間顯示計時器",
	TimerSapper			= "為下一次暮光工兵重生顯示計時器"--npc=56923
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
	SpecWarnTendril			= "Get Secured!"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SpecWarnTendril			= "Show special warning when you are missing $spell:109454 debuff",--http://ptr.wowhead.com/npc=56188
	InfoFrame				= "Show info frame for players without $spell:109454",
	SetIconOnGrip			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(109459)
})

L:SetMiscLocalization({
	NoDebuff	= "No %s",
	DRoll		= "about to roll"--Not a single transcriptor log for this fight from anyone, just bad chat logs that have more looting then actual boss encounters. This emote needs to be confirmed/fixed if it's wrong.
})

---------------------------
-- Madness of Deathwing  -- 
---------------------------
L= DBM:GetModLocalization(333)

L:SetWarningLocalization({
	SpecWarnTentacle	= "Blistering Tentacles - Switch"--Msg too long? maybe just "Blistering Tentacles!"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SpecWarnTentacle	= "Show special warning when Blistering Tentacles spawn (and Alexstrasza is not active)"--http://ptr.wowhead.com/npc=56188
})

L:SetMiscLocalization({
	Pull				= "You have done NOTHING. I will tear your world APART."
})

