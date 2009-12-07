if GetLocale() ~= "koKR" then return end

local L

----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization{
	name = "군주 매로우가르"
}

L:SetTimerLocalization{
	achievementBoned	= "Time to free"
}

L:SetWarningLocalization{
	WarnImpale				= "꿰뚫기 : >%s<",
	SpecWarnWhirlwind		= "소용돌이 - 뛰세요!",
	SpecWarnColdflame		= "냉기화염 - 뛰세요!"
}

L:SetOptionLocalization{
	WarnImpale				= "꿰뚫기 대상 알리기",
	SpecWarnWhirlwind		= "소용돌이 특수 경고 보기",
	SpecWarnColdflame		= "냉기화염에 영향을 받을 경우 특수 경고 보기",
	PlaySoundOnWhirlwind	= "소용돌이 특수 경고 소리 듣기",
	achievementBoned		= "Show timer for Boned Achievement",
	SetIconOnImpale			= "Set icons on impaled targets"
}

-------------------------
--  Lady Deathwhisper  --
-------------------------
L = DBM:GetModLocalization("Deathwhisper")

L:SetGeneralLocalization{
	name = "여교주 데스위스퍼"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
	WarnReanimating					= "Add reviving",			-- Reanimating an adherent or fanatic
	WarnTouchInsignificance			= "%s on >%s< (%s)",		-- Touch of Insignificance on >args.destName< (args.amount)
	SpecWarnDeathDecay				= "Death and Decay - Move away",
	SpecWarnCurseTorpor				= "Curse of Torpor on you",
	SpecWarnTouchInsignificance		= "Touch of Insignificance (3)",
	WarnAddsSoon					= "New adds soon"
}

L:SetOptionLocalization{
	WarnAddsSoon					= "Show pre-warning for adds spawning",
	WarnTouchInsignificance			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(71204, GetSpellInfo(71204) or "unknown"),		-- Warning isnt default (it has a count number), option is default tho (no need for translation this way)
	WarnReanimating					= "Show warning when an add is getting revived",								-- Reanimated Adherent/Fanatic spawning
	SpecWarnTouchInsignificance		= "Show special warning when you have 3 stacks of Touch of Insignificance",
	SpecWarnDeathDecay				= "Show special warning when you are affected by Death and Decay",
	SpecWarnCurseTorpor				= "Show special warning when you are affected by Curse of Torpor"
}

L:SetMiscLocalization{
	YellPull						= "What is this disturbance? You dare trespass upon this hallowed ground? This shall be your final resting place!",
	YellReanimatedFanatic			= "Arise, and exult in your pure form!",
}

------------------------
--  The Deathbringer  --
------------------------
L = DBM:GetModLocalization("Deathbringer")

L:SetGeneralLocalization{
	name = "The Deathbringer"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}

----------------------
--  Gunship Battle  --
----------------------
L = DBM:GetModLocalization("GunshipBattle")

L:SetGeneralLocalization{
	name = "Gunship Battle"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}

-----------------
--  Festergut  --
-----------------
L = DBM:GetModLocalization("Festergut")

L:SetGeneralLocalization{
	name = "Festergut"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}

---------------
--  Rotface  --
---------------
L = DBM:GetModLocalization("Rotface")

L:SetGeneralLocalization{
	name = "Rotface"
}

L:SetWarningLocalization{
	SpecWarnStickyOoze			= "끈적이는 수액괴물 - 이동하세요!",
	SpecWarnRadiatingOoze		= "방사능 수액괴물",
	SpecWarnMutatedInfection 	= "당신에게 돌연변이 전염병!"
}

L:SetTimerLocalization{
	NextPoisonSlimePipes		= "Next Poison Slime Pipes"
}

L:SetOptionLocalization{
	SpecWarnStickyOoze			= "끈적이는 수액괴물 특수 경고 보기",
	SpecWarnRadiatingOoze		= "방사능 수액괴물 특수 경고 보기",
	NextPoisonSlimePipes		= "Show timer for next Poison Slime Pipes",
	SpecWarnMutatedInfection 	= "돌연변이 전염병에 영향을 받을 경우 특수 경고 보기",
	InfectionIcon				= "돌연변이 전염병 대상 공격대 아이콘 설정",
	WarnOozeSpawn				= "Show warning for Little Ooze spawning"
}

L:SetMiscLocalization{
	YellSlimePipes				= "Good news, everyone! I've fixed the poison slime pipes!"	-- Professor Putricide
}

---------------------------
--  Professor Putricide  --
---------------------------
L = DBM:GetModLocalization("Putricide")

L:SetGeneralLocalization{
	name = "교수 퓨트리사이드"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}

L:SetMiscLocalization{
	YellPull	= "Good news, everyone! I think I've perfected a plague that will destroy all life on Azeroth!"
}

----------------------------
--  Blood Prince Council  --
----------------------------
L = DBM:GetModLocalization("BPCouncil")

L:SetGeneralLocalization{
	name = "Blood Prince Council"
}

L:SetWarningLocalization{
	WarnTargetSwitch		= "Switch target to: %s",		-- Ugh, no nice spellname/id to use for general localization :(
	WarnTargetSwitchSoon	= "Target switch soon",			-- Spellname = Invocation of Blood   or   Spellname = Invocation of Blood (X) Move  (server side script where X indicates the first letter of the Prince name
	SpecWarnResonance		= "Shadow Resonance - Move"
}

L:SetTimerLocalization{
	TimerTargetSwitch		= "Possible target switch"
}

L:SetOptionLocalization{
	WarnTargetSwitch		= "Show warning to switch targets",								-- Warn when another Prince needs to be damaged
	WarnTargetSwitchSoon	= "Show pre-warning to switch targets",							-- Every ~31 secs, you have to dps a different Prince
	TimerTargetSwitch		= "Show timer for target switch cooldown",
	SpecWarnResonance		= "Show special warning when a Dark Nucleus is following you"	-- If it follows you, you have to move to the tank
}

L:SetMiscLocalization{
	Keleseth				= "Prince Keleseth",
	Taldaram				= "Prince Taldaram",
	Valanar					= "Prince Valanar"
}

-----------------------
--  Queen Lana'thel  --
-----------------------
L = DBM:GetModLocalization("Lanathel")

L:SetGeneralLocalization{
	name = "피의 여왕 라나텔"
}

L:SetWarningLocalization{
	SpecWarnPactDarkfallen	= "Pact of the Darkfallen on you"
}

L:SetOptionLocalization{
	SpecWarnPactDarkfallen	= "Show special warning when you are affected by Pact of the Darkfallen"
}

-----------------------------
--  Valithria Dreamwalker  --
-----------------------------
L = DBM:GetModLocalization("Valithria")

L:SetGeneralLocalization{
	name = "발리스리아 드림워커"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}

------------------
--  Sindragosa  --
------------------
L = DBM:GetModLocalization("Sindragosa")

L:SetGeneralLocalization{
	name = "신드라고사"
}

L:SetTimerLocalization{
	TimerNextAirphase		= "다음 공중 페이즈",
	TimerNextGroundphase	= "다음 지상 페이즈"
}

L:SetWarningLocalization{
	WarnAirphase			= "공중 페이즈",
	SpecWarnBlisteringCold	= "얼음 손아귀! 뛰세요!",
	SpecWarnFrostBeacon		= "당신에게 냉기 봉화",
	WarnGroundphaseSoon		= "곧 신드라고사 착륙",
	SpecWarnUnchainedMagic	= "당신에게 해방된 마법"
}

L:SetOptionLocalization{
	WarnAirphase			= "공중 페이즈 알리기",
	SpecWarnBlisteringCold	= "얼음 손아귀 특수 경고 보기",
	SpecWarnFrostBeacon		= "냉기 봉화에 영향을 받을 경우 특수 경고 보기",
	WarnGroundphaseSoon		= "지상 페이즈 사전 경고 보기",
	TimerNextAirphase		= "다음 공중 페이즈 타이머 보기",
	TimerNextGroundphase	= "다음 지상 페이즈 타이머 보기",
	SpecWarnUnchainedMagic	= "해방된 마법의 영향을 받을 경우 특수 경고 보기"
}

L:SetMiscLocalization{
	YellAirphase			= "Your incursion ends here! None shall survive!",
	YellPull				= "You are fools to have come to this place. The icy winds of Northrend will consume your souls!"
}

---------------------
--  The Lich King  --
---------------------
L = DBM:GetModLocalization("LichKing")

L:SetGeneralLocalization({
	name = "리치 왕"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})
