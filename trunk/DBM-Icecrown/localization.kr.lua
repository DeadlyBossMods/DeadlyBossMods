if GetLocale() ~= "koKR" then return end

local L

----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization({
	name = "Lord Marrowgar"
})

L:SetWarningLocalization({
	WarnImpale				= "꿰뚫기 : >%s<",
	SpecWarnWhirlwind		= "소용돌이 - 뛰세요!",
	SpecWarnColdflame		= "냉기화염 - 뛰세요!"
})

L:SetOptionLocalization({
	WarnImpale				= "꿰뚫기 대상 알리기",
	SpecWarnWhirlwind		= "소용돌이 특수 경고 보기",
	SpecWarnColdflame		= "냉기화염에 영향을 받을 경우 특수 경고 보기",
	PlaySoundOnWhirlwind	= "소용돌이 특수 경고 소리 듣기"
})

-------------------------
--  Lady Deathwhisper  --
-------------------------
L = DBM:GetModLocalization("Deathwhisper")

L:SetGeneralLocalization({
	name = "Lady Deathwhisper"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

------------------------
--  The Deathbringer  --
------------------------
L = DBM:GetModLocalization("Deathbringer")

L:SetGeneralLocalization({
	name = "The Deathbringer"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

----------------------
--  Gunship Battle  --
----------------------
L = DBM:GetModLocalization("GunshipBattle")

L:SetGeneralLocalization({
	name = "Gunship Battle"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

-----------------
--  Festergut  --
-----------------
L = DBM:GetModLocalization("Festergut")

L:SetGeneralLocalization({
	name = "Festergut"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

---------------
--  Rotface  --
---------------
L = DBM:GetModLocalization("Rotface")

L:SetGeneralLocalization({
	name = "Rotface"
})

L:SetWarningLocalization({
	SpecWarnStickyOoze			= "끈적이는 수액괴물 - 이동하세요!",
	SpecWarnRadiatingOoze		= "방사능 수액괴물",
	SpecWarnMutatedInfection 	= "당신에게 돌연변이 전염병!"
})

L:SetTimerLocalization({
	NextPoisonSlimePipes		= "Next Poison Slime Pipes"
})

L:SetOptionLocalization({
	SpecWarnStickyOoze			= "끈적이는 수액괴물 특수 경고 보기",
	SpecWarnRadiatingOoze		= "방사능 수액괴물 특수 경고 보기",
	NextPoisonSlimePipes		= "Show timer for next Poison Slime Pipes",
	SpecWarnMutatedInfection 	= "돌연변이 전염병에 영향을 받을 경우 특수 경고 보기",
	InfectionIcon				= "돌연변이 전염병 대상 공격대 아이콘 설정",
	WarnOozeSpawn				= "Show warning for Little Ooze spawning"
})

L:SetMiscLocalization({
	YellSlimePipes				= "Good news, everyone! I've fixed the poison slime pipes!"	-- Professor Putricide
})

---------------------------
--  Professor Putricide  --
---------------------------
L = DBM:GetModLocalization("Putricide")

L:SetGeneralLocalization({
	name = "Professor Putricide"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

----------------------------
--  Blood Prince Council  --
----------------------------
L = DBM:GetModLocalization("BPCouncil")

L:SetGeneralLocalization({
	name = "Blood Prince Council"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

-----------------------
--  Queen Lana'thel  --
-----------------------
L = DBM:GetModLocalization("Lanathel")

L:SetGeneralLocalization({
	name = "Queen Lana'thel"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

-----------------------------
--  Valithria Dreamwalker  --
-----------------------------
L = DBM:GetModLocalization("Valithria")

L:SetGeneralLocalization({
	name = "Valithria Dreamwalker"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

------------------
--  Sindragosa  --
------------------
L = DBM:GetModLocalization("Sindragosa")

L:SetGeneralLocalization({
	name = "Sindragosa"
})

L:SetTimerLocalization({
	TimerNextAirphase		= "다음 공중 페이즈",
	TimerNextGroundphase	= "다음 지상 페이즈"
})

L:SetWarningLocalization({
	WarnAirphase			= "공중 페이즈",
	WarnBlisteringCold		= "얼음 손아귀!",
	SpecWarnBlisteringCold	= "얼음 손아귀! 뛰세요!",
	SpecWarnFrostBeacon		= "당신에게 냉기 봉화",
	WarnGroundphaseSoon		= "곧 신드라고사 착륙",
	SpecWarnUnchainedMagic	= "당신에게 해방된 마법"
})

L:SetOptionLocalization({
	WarnAirphase			= "공중 페이즈 알리기",
	WarnBlisteringCold		= "얼음 손아귀 경고 보기",
	SpecWarnBlisteringCold	= "얼음 손아귀 특수 경고 보기",
	SpecWarnFrostBeacon		= "냉기 봉화에 영향을 받을 경우 특수 경고 보기",
	WarnGroundphaseSoon		= "지상 페이즈 사전 경고 보기",
	TimerNextAirphase		= "다음 공중 페이즈 타이머 보기",
	TimerNextGroundphase	= "다음 지상 페이즈 타이머 보기",
	SpecWarnUnchainedMagic	= "해방된 마법의 영향을 받을 경우 특수 경고 보기"
})

L:SetMiscLocalization({
	YellAirphase			= "Your incursion ends here! None shall survive!",
	YellPull				= "You are fools to have come to this place. The icy winds of Northrend will consume your souls!"
})

---------------------
--  The Lich King  --
---------------------
L = DBM:GetModLocalization("LichKing")

L:SetGeneralLocalization({
	name = "The Lich King"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})
