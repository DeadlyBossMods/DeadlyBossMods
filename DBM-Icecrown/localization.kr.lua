if GetLocale() ~= "koKR" then return end

local L

---------------------------
--  Trash - Lower Spire  --
---------------------------
L = DBM:GetModLocalization("LowerSpireTrash")

L:SetGeneralLocalization{
	name = "성채 하층부 일반몹"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
	SetIconOnDarkReckoning		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69483)
}

---------------------------
--  Trash - Plagueworks  --
---------------------------
L = DBM:GetModLocalization("PlagueworksTrash")

L:SetGeneralLocalization{
	name = "역병작업장 일반몹"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}

----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization{
	name = "군주 매로우가르"
}

L:SetTimerLocalization{
	achievementBoned	= "탈출 시간"
}

L:SetWarningLocalization{
	WarnImpale				= "꿰뚫기 : >%s<"
}

L:SetOptionLocalization{
	WarnImpale				= "$spell:69062 대상 알리기",
	achievementBoned		= "뼈도 못 추릴라 업적 타이머 보기",	
	SetIconOnImpale			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69062)
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
	WarnReanimating					= "이교도 부활",			-- Reanimating an adherent or fanatic
	WarnTouchInsignificance			= "%s : >%s< (%s)",		-- Touch of Insignificance on >args.destName< (args.amount)
	WarnAddsSoon					= "곧 새로운 이교도 추가"
}

L:SetOptionLocalization{
	WarnAddsSoon					= "이교도 추가 사전 경고 보기",
	WarnReanimating					= "이교도를 부활 할 경우 경고 보기",								-- Reanimated Adherent/Fanatic spawning
	TimerAdds						= "새로운 이교도 추가 타이머 보기",
	ShieldHealthFrame				= "$spell:70842의 방어막 바와 보스 체력바를 함께 보기",	
	WarnTouchInsignificance			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(71204, GetSpellInfo(71204) or "unknown"),	-- Warning isnt default (it has a count number), option is default tho (no need for translation this way)
	SetIconOnDominateMind			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71289),
	SetIconOnDeformedFanatic		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70900),
	SetIconOnEmpoweredAdherent		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70901)
}

L:SetMiscLocalization{
	YellPull						= "이게 무슨 소란이지? 감히 이 신성한 땅을 지나가려 해? 여기가 마지막 숨을 거둘 곳이 되리라!",
	YellReanimatedFanatic			= "일어나라, 순수한 모습을 기뻐하라!",
	ShieldPercent					= "마나 방벽"
}

----------------------
--  Gunship Battle  --
----------------------
L = DBM:GetModLocalization("GunshipBattle")

L:SetGeneralLocalization{
	name = "얼음왕관 비행선 전투"
}

L:SetWarningLocalization{
	WarnBattleFury		= "%s (%d)",
	WarnAddsSoon		= "곧 추가 몹"
}

L:SetOptionLocalization{
	WarnBattleFury		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(69638, GetSpellInfo(69638) or "전투 격노"),
	TimerCombatStart	= "전투 시작 타이머 보기",
	WarnAddsSoon		= "몹 생성 사전 경고 보기",
	TimerAdds			= "추가 몹 타이머 보기"
}

L:SetTimerLocalization{
	TimerCombatStart	= "전투 시작",
	TimerAdds			= "추가 몹"
}

L:SetMiscLocalization{
	PullAlliance		= "Fire up the engines! We got a meetin' with destiny, lads!",
	KillAlliance		= "Don't say I didn't warn ya, scoundrels! Onward, brothers and sisters!",
	PullHorde			= "호드의 아들딸이여, 일어나라! 오늘 우리는 증오하던 적과 전투를 벌이리라! 록타르 오가르!",
	KillHorde			= "얼라이언스는 기가 꺾였다. 리치 왕을 향해 전진하라!"
}

------------------------
--  The Deathbringer  --
------------------------
L = DBM:GetModLocalization("Deathbringer")

L:SetGeneralLocalization{
	name = "죽음의 인도자 사울팽"
}

L:SetWarningLocalization{
	warnFrenzySoon			= "곧 광기"
}

L:SetOptionLocalization{
	warnFrenzySoon			= "광기 사전 경고 보기 (33% 이하)",
	SetIconOnBoilingBlood	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72441),
	RangeFrame				= "거리 프레임 보기 (11 미터)",
	RunePowerFrame			= "보스 체력 바와 함께 $spell:72371 바 보기"	
}

L:SetMiscLocalization{
	RunePower	= "피 마력"
}

-----------------
--  Festergut  --
-----------------
L = DBM:GetModLocalization("Festergut")

L:SetGeneralLocalization{
	name = "구린속"
}

L:SetWarningLocalization{
	InhaledBlight		= "Inhaled Blight >%d<"
}

L:SetOptionLocalization{
	InhaledBlight		= "$spell:71912 경고 보기",
	SetIconOnGasSpore	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69279)
}

---------------
--  Rotface  --
---------------
L = DBM:GetModLocalization("Rotface")

L:SetGeneralLocalization{
	name = "썩은얼굴"
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
	name = "피의 공작 의회"
}

L:SetWarningLocalization{
	WarnTargetSwitch		= "Switch target to: %s",		-- Ugh, no nice spellname/id to use for general localization :(
	WarnTargetSwitchSoon	= "곧 대상 전환",			-- Spellname = Invocation of Blood   or   Spellname = Invocation of Blood (X) Move  (server side script where X indicates the first letter of the Prince name
	SpecWarnResonance		= "Shadow Resonance - Move"
}

L:SetTimerLocalization{
	TimerTargetSwitch		= "Possible target switch"
}

L:SetOptionLocalization{
	WarnTargetSwitch		= "대상 전환 경고 보기",								-- Warn when another Prince needs to be damaged
	WarnTargetSwitchSoon	= "대상 전환 사전 경고 보기",							-- Every ~31 secs, you have to dps a different Prince
	TimerTargetSwitch		= "대상 전환 쿨다운 타이머 보기wn",
	SpecWarnResonance		= "Show special warning when a Dark Nucleus is following you"	-- If it follows you, you have to move to the tank
}

L:SetMiscLocalization{
	Keleseth				= "공작 켈레세스",
	Taldaram				= "공작 탈다람",
	Valanar					= "공작 발라나르"
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
