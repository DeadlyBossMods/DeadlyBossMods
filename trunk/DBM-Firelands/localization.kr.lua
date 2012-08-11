if GetLocale() ~= "koKR" then return end
local L

----------------
-- Beth'tilac --
----------------
L= DBM:GetModLocalization(192)

L:SetOptionLocalization({
	RangeFrame			= "거리 프레임 보기 (10m)"
})

L:SetMiscLocalization({
	EmoteSpiderlings 	= "새끼거미가 둥지에서 쏟아져나옵니다!"
})

-------------------
-- Lord Rhyolith --
-------------------
L= DBM:GetModLocalization(193)

---------------
-- Alysrazor --
---------------
L= DBM:GetModLocalization(194)

L:SetWarningLocalization({
	WarnPhase			= "%d 단계",
	WarnNewInitiate		= "타오르는 발톱 수습생 (%s)"
})

L:SetTimerLocalization({
	TimerPhaseChange	= "%d 단계",
	TimerHatchEggs		= "녹아내린 알 부화",
	timerNextInitiate	= "다음 수습생 (%s)",
	TimerCombatStart	= "전투 시작"
})

L:SetOptionLocalization({
	TimerCombatStart	= "전투 시작 바 표시",
	WarnPhase			= "단계 전환 알림 보기",
	WarnNewInitiate		= "타오르는 발톱 수습생 알림 보기",
	timerNextInitiate	= "다음 타오르는 발톱 수습생 등장 바 표시",
	TimerPhaseChange	= "단계 전환 바 표시",
	TimerHatchEggs		= "녹아내린 알 부화 바 표시",
	InfoFrame			= "$spell:98734 정보 프레임 보기"
})

L:SetMiscLocalization({
	YellPull		= "이제 난 새 주인님을 섬긴다. 필멸자여!",
	YellPhase2		= "이 하늘은 나의 것이다!",
	FullPower		= "spell:99925",--This is in the emote, shouldn't need localizing, just msg:find
	LavaWorms		= "불타는 용암 벌레가 땅에서 튀어나옵니다!",--Might use this one day if i feel it needs a warning for something. Or maybe pre warning for something else (like transition soon)
	East			= "오른쪽",
	West			= "왼쪽",
	Both			= "양쪽"
})

-------------
-- Shannox --
-------------
L= DBM:GetModLocalization(195)

L:SetOptionLocalization({
	SetIconOnFaceRage	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(99947),
	SetIconOnRage		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100415)
})

-------------
-- Baleroc --
-------------
L= DBM:GetModLocalization(196)

L:SetWarningLocalization({
	warnStrike	= "%s (%d)"
})

L:SetTimerLocalization({
	timerStrike			= "다음 %s",
	TimerBladeActive	= "%s",
	TimerBladeNext		= "다음 칼날 활성화"
})

L:SetOptionLocalization({
	ResetShardsinThrees	= "$spell:99259 시전 횟수 알림을 일정 단위마다 초기화 (10인: 2회, 25인: 3회)",
	warnStrike			= "지옥불/학살의 칼날에 피해를 입을 때 알림 보기",
	timerStrike			= "지옥불/학살의 칼날 공격 간격 바 표시",
	TimerBladeActive	= "활성화된 칼날 유지 시간 바 표시",
	TimerBladeNext		= "다음 지옥불/학살의 칼날 시전 바 표시",
	SetIconOnCountdown	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(99516),
	SetIconOnTorment	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(99256),
	ArrowOnCountdown	= "$spell:99516 주문의 영향을 받은 경우 DBM 화살표 보기",
	InfoFrame			= "$spell:99262 정보 프레임 보기",
	RangeFrame			= "$spell:99257 주문의 영향을 받은 경우 거리 프레임 보기 (5m)"
})

L:SetMiscLocalization({
	VitalSpark			= GetSpellInfo(99262)
})

--------------------------------
-- Majordomo Fandral Staghelm --
--------------------------------
L= DBM:GetModLocalization(197)

L:SetTimerLocalization({
	timerNextSpecial	= "다음 %s (%d)"
})

L:SetOptionLocalization({
	timerNextSpecial		= "다음 불꽃 낫/화염도약 시전 바 표시",
	RangeFrameSeeds			= "$spell:98450 주문의 영향을 받은 경우 거리 프레임 보기 (12m)",
	RangeFrameCat			= "$spell:98374 일때 거리 프레임 보기 (10m)",
	LeapArrow				= "$spell:98476 대상이 근처에 있을 경우 DBM 화살표 보기",
	IconOnLeapingFlames		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(98476)
})

--------------
-- Ragnaros --
--------------
L= DBM:GetModLocalization(198)

L:SetWarningLocalization({
	warnRageRagnarosSoon	= "5초 후 %s : %s",
	warnSplittingBlow		= "%s (%s)",
	warnEngulfingFlame		= "%s (%s)",
	warnEmpoweredSulf		= "5초 후 %s"
})

L:SetTimerLocalization({
	timerRageRagnaros		= "%s : %s",--Spellname on targetname
	TimerPhaseSons			= "다음 단계 전환"
})

L:SetOptionLocalization({
	warnRageRagnarosSoon		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.prewarn:format(101109, GetSpellInfo(101109)),
	warnSplittingBlow			= "$spell:98951 위치 알림 보기",
	warnEngulfingFlame			= "$spell:99171 위치 알림 보기 (일반)",
	warnEngulfingFlameHeroic	= "$spell:99171 위치 알림 보기 (영웅)",
	warnSeedsLand				= "$spell:98520 주문이 시전될 때가 아니라 착지되는 시간에 맞는 알림/바 보기",
	warnEmpoweredSulf			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast:format(100604, GetSpellInfo(100604)),
	timerRageRagnaros			= DBM_CORE_AUTO_TIMER_OPTIONS.cast:format(101109, GetSpellInfo(101109)),
	TimerPhaseSons				= "사잇단계 지속시간 바 표시",
	RangeFrame					= "거리 프레임이 필요하게 될 때 거리 프레임 보기",
	InfoHealthFrame				= "체력 정보 프레임 보기 (10만 미만)",
	MeteorFrame					= "$spell:99849 대상 정보 프레임 보기",
	AggroFrame					= "$journal:2647 에게 위협수준이 없는 대상에 대한 정보 프레임 보기",
	BlazingHeatIcons			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100460)
})

L:SetMiscLocalization({
	East				= "오른쪽",
	West				= "왼쪽",
	Middle				= "중앙",
	North				= "근접",
	South				= "뒤쪽",
	HealthInfo			= "체력 10만 미만",
	HasNoAggro			= "위협수준 없음",
	MeteorTargets		= "유성 조심!",--Keep rollin' rollin' rollin' rollin'.
	TransitionEnded1	= "여기까지! 이제 끝내주마.",--More reliable then adds method.
	TransitionEnded2	= "설퍼라스로 숨통을 끊어 주마.",
	TransitionEnded3	= "무릎 꿇어라, 필멸자여! 끝낼 시간이다.",
	Defeat				= "조금만!... 조금만 시간이 더 있었어도...",
	Phase4				= "너무 일러..."
})

-----------------------
--  Firelands Trash  --
-----------------------
L = DBM:GetModLocalization("FirelandsTrash")

L:SetGeneralLocalization({
	name = "불의 땅 일반몹"
})

----------------
--  Volcanus  --
----------------
L = DBM:GetModLocalization("Volcanus")

L:SetGeneralLocalization({
	name = "볼카누스"
})

L:SetTimerLocalization({
	timerStaffTransition	= "다음 단계 전환"
})

L:SetOptionLocalization({
	timerStaffTransition	= "다음 단계 전환 바 표시"
})

L:SetMiscLocalization({
	StaffEvent			= "(%S+)|1이;가; 놀드랏실의 가지를 건드리자 격렬하게 반응합니다!",
	StaffTrees			= "불타는 나무정령이 수호정령을 돕기 위해 땅에서 일어납니다!",--Might add a spec warning for this later.
	StaffTransition		= "고통받는 수호정령을 태우는 불이 사그라졌습니다!"
})

-----------------------
--  Nexus Legendary  --
-----------------------
L = DBM:GetModLocalization("NexusLegendary")

L:SetGeneralLocalization({
	name = "티리나르"
})
