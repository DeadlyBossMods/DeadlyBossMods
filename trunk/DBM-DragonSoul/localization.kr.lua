if GetLocale() ~= "koKR" then return end
local L

-------------
-- Morchok --
-------------
L= DBM:GetModLocalization(311)

L:SetWarningLocalization({
	SpecwarnVortexAfter	= "기둥 뒤에 숨으세요!"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SpecwarnVortexAfter	= "$spell:110047 종료시 특수 경고 보기"
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
	RangeFrame	= "$spell:104601 주문의 영향을 받을 경우 거리 프레임 보기(10m)\n(영웅 난이도)"
})

L:SetMiscLocalization({
})

-----------------------------
-- Yor'sahj the Unsleeping --
-----------------------------
L= DBM:GetModLocalization(325)

L:SetWarningLocalization({
	warnOozes		= "핏방울: %s",
	specWarnOozes	= "핏방울 등장!",
	specWarnManaVoid= "마나 공허 생성 - 대상 전환!"
})

L:SetTimerLocalization({
	timerOozesCD	= "다음 핏방울"
})

L:SetOptionLocalization({
	warnOozes			= "핏방울 등장 알림 보기",
	specWarnOozes		= "핏방울 등장 특수 경고 보기",
	specWarnManaVoid	= "$spell:105530 생성 특수 경고 보기",
	timerOozesCD		= "다음 핏방울 바 표시"
})

L:SetMiscLocalization({
	Black			= "|cFF424242검정|r",
	Purple			= "|cFF9932CD보라|r",
	Red				= "|cFFFF0404빨강|r",
	Green			= "|cFF088A08초록|r",
	Blue			= "|cFF0080FF파랑|r",
	Yellow			= "|cFFFFA901노랑|r"
})

-----------------------
-- Hagara the Binder --
-----------------------
L= DBM:GetModLocalization(317)

L:SetWarningLocalization({
	warnFrostTombCast		= "8초 후 %s"
})

L:SetTimerLocalization({
	TimerSpecial			= "첫번째 특수 공격"
})

L:SetOptionLocalization({
	TimerSpecial			= "첫번째 특수 공격 시전까지 남은 시간 바 표시",
	RangeFrame				= "$spell:105269 주문의 영향을 받을 경우 거리 프레임 보기(3m)",
	AnnounceFrostTombIcons	= "$spell:104451 대상을 공격대 대화로 알리기\n(승급 권한 필요)",
	warnFrostTombCast		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast:format(104448, GetSpellInfo(104448)),
	SetIconOnFrostTomb		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(104451)
})

L:SetMiscLocalization({
	TombIconSet				= "냉기 봉화 징표 : {rt%d} %s"
})

---------------
-- Ultraxion --
---------------
L= DBM:GetModLocalization(331)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	TimerCombatStart	= "전투 시작"
})

L:SetOptionLocalization({
	TimerCombatStart	= "전투 시작 바 표시"
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
	TimerCombatStart	= "전투 시작",
	TimerSapper			= "다음 황혼의 폭파병"
})

L:SetOptionLocalization({
	TimerCombatStart	= "전투 시작 바 표시",
	TimerSapper			= "다음 황혼의 폭파병 등장 바 표시"--npc=56923
})

L:SetMiscLocalization({
	SapperEmote			= "황혼의 폭파병",
	Broadside			= "spell:110153",
	DeckFire			= "spell:110095"
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
