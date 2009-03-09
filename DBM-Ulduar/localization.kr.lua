if GetLocale() ~= "koKR" then return end

local L

--------------
--  토림  --
--------------
L = DBM:GetModLocalization("Thorim")

L:SetGeneralLocalization({
	name = "토림"
})

L:SetWarningLocalization({
	WarningStormhammer	= "Stormhammer on %s",
})

L:SetTimerLocalization({
	TimerStormhammer	= "Next Stormhammer",  -- applys AE Silience on the target
})

L:SetOptionLocalization({
	TimerStormhammer	= "Show Stormhammer Cooldown",
	WarningStormhammer	= "Announce Stormhammer Target",
})

--L:SetMiscLocalization({ })

-------------------
--  철의 의회  --
-------------------
L = DBM:GetModLocalization("IronCouncil")

L:SetGeneralLocalization({
	name = "철의 의회"
})

L:SetWarningLocalization({
	WarningSupercharge	= "과충전 시전",
})

L:SetTimerLocalization({
	TimerSupercharge	= "과충전",  -- gives the other bosses more power
})

L:SetOptionLocalization({
	TimerSupercharge	= "과충전 타이머 보기",
	WarningSupercharge	= "과충전 시전 경보 보기",
})

L:SetMiscLocalization({
	Steelbreaker		= "강철파괴자",
	RunemasterMolgeim 	= "룬마스터 몰게임",
	StormcallerBrundir 	= "폭풍소환사 브룬디르",
})


-------------
--  호디르  --
-------------
L = DBM:GetModLocalization("Hodir")

L:SetGeneralLocalization({
	name = "호디르"
})

L:SetWarningLocalization({
	WarningFlashFreeze	= "급속 결빙",
	WarningBitingCold	= "매서운 추위 - 움직이세요!"
})

L:SetTimerLocalization({
	TimerFlashFreeze	= "급속 결빙 시전",  -- all ppl have to move on the rock patches
})

L:SetOptionLocalization({
	TimerFlashFreeze	= "급속 결빙 시전 타이머 보기",
	WarningFlashFreeze	= "급속 결빙 경보 보기",
})

L:SetMiscLocalization({
	PlaySoundOnFlashFreeze	= "급속 결빙 시전 사운드 듣기",
})







