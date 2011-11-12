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
})

L:SetOptionLocalization({
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
	TimerCombatStart	= "戰鬥開始時顯示計時器"
})

L:SetMiscLocalization({
	Pull				= "I sense a great disturbance in the balance approaching. The chaos of it burns my mind!"
})

-------------------------
-- Warmaster Blackhorn --
-------------------------
L= DBM:GetModLocalization(332)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

-------------------------
-- Spine of Deathwing  --
-------------------------
L= DBM:GetModLocalization(318)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

---------------------------
-- Madness of Deathwing  -- 
---------------------------
L= DBM:GetModLocalization(333)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})
