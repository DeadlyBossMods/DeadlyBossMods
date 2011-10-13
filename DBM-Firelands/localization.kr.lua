if GetLocale() ~= "koKR" then return end
local L

----------------
-- Beth'tilac --
----------------
L= DBM:GetModLocalization(192)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	TimerSpinners 		= "다음 실거미",
	TimerSpiderlings	= "다음 새끼거미",
	TimerDrone			= "다음 수거미"
})

L:SetOptionLocalization({
	TimerSpinners		= "다음 $journal:2770 타이머 보기",
	TimerSpiderlings	= "다음 $journal:2778 타이머 보기",
	TimerDrone			= "다음 $journal:2773 타이머 보기",
	RangeFrame			= "거리 프레임 보기(10 m)"
})

L:SetMiscLocalization({
	EmoteSpiderlings 	= "새끼거미가 둥지에서 쏟아져나옵니다!"
})

-------------------
-- Lord Rhyolith --
-------------------
L= DBM:GetModLocalization(193)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	yellPhase2			= "긴 세월 내 잠을 방해한 이가 없었건만... 그래... 이 살덩어리들아. 네놈들을 불태워 주마!"
})

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
	TimerCombatStart	= "전투 시작 타이머 보기",
	WarnPhase			= "단계 전환 경고 보기",
	WarnNewInitiate		= "타오르는 발톱 수습생 등장 경고 보기",
	timerNextInitiate	= "다음 타오르는 발톱 수습생 타이머 보기",
	TimerPhaseChange	= "단계 전환 타이머 보기",
	TimerHatchEggs		= "녹아내린 알 부화 타이머 보기",
	InfoFrame			= "타오르는 힘 정보 프레임 보기"
})

L:SetMiscLocalization({
	YellPull		= "이제 난 새 주인님을 섬긴다. 필멸자여!",
	Initiate		= "타오르는 발톱 수습생",--http://www.wowhead.com/npc=53896
	YellPhase2		= "이 하늘은 나의 것이다!",
	FullPower		= "spell:99925",--This is in the emote, shouldn't need localizing, just msg:find
	LavaWorms		= "불타는 용암 벌레가 땅에서 튀어나옵니다!",--Might use this one day if i feel it needs a warning for something. Or maybe pre warning for something else (like transition soon)
	PowerLevel		= "타오르는 힘",
	East			= "동쪽",
	West			= "서쪽",
	Both			= "양쪽"
})

-------------
-- Shannox --
-------------
L= DBM:GetModLocalization(195)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SetIconOnFaceRage	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(99945),
	SetIconOnRage		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100415)
})

L:SetMiscLocalization({
	Riplimb		= "칼로베",
	Rageface	= "성난얼굴"
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
	ResetShardsinThrees	= "$spell:99259 경고 카운트를 일정 횟수마다 재시작(10인/2회,25인/3회)",
	warnStrike			= "지옥불/학살의 칼날에 피해를 입을 때 경고 보기",
	timerStrike			= "지옥불/학살의 칼날 공격 간격 타이머 보기",
	TimerBladeActive	= "활성화된 칼날 유지 타이머 보기",
	TimerBladeNext		= "다음 지옥불/학살의 칼날 활성화 타이머 보기",
	SetIconOnCountdown	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(99516),
	SetIconOnTorment	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100232),
	ArrowOnCountdown	= "$spell:99516의 영향을 받은 경우 DBM 화살표 보기",
	InfoFrame			= "생기의 불꽃 중첩 정보 프레임 보기",
	RangeFrame			= "$spell:99404의 거리 프레임 보기(5 m)"
})

L:SetMiscLocalization({
	VitalSpark			= GetSpellInfo(99262).." 중첩"
})

--------------------------------
-- Majordomo Fandral Staghelm --
--------------------------------
L= DBM:GetModLocalization(197)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	timerNextSpecial	= "다음 %s (%d)"
})

L:SetOptionLocalization({
	timerNextSpecial			= "다음 특수 능력 타이머 보기",
	RangeFrameSeeds				= "$spell:98450의 거리 프레임 보기(12 m)",
	RangeFrameCat				= "$spell:98374의 거리 프레임 보기(10 m)",
	LeapArrow					= "$spell:98476이 주변에 시전될 때 DBM 화살표 보기",
	IconOnLeapingFlames			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100208)
})

L:SetMiscLocalization({
})

--------------
-- Ragnaros --
--------------
L= DBM:GetModLocalization(198)

L:SetWarningLocalization({
	warnSplittingBlow		= "%s (%s)",--Spellname in Location
	warnEngulfingFlame		= "%s (%s)",--Spellname in Location
	WarnRemainingAdds		= "남은 피조물: %d",
	warnAggro				= "녹아내린 정령으로부터 위협수준 획득함!!!",
	warnNoAggro				= "녹아내린 정령에게서 안전함:)"
})

L:SetTimerLocalization({
	TimerPhaseSons		= "다음 단계 전환"
})

L:SetOptionLocalization({
	warnSplittingBlow			= "$spell:100877 경고 보기",
	warnEngulfingFlame			= "$spell:99171 경고 보기",
	WarnEngulfingFlameHeroic	= "영웅 모드에 맞는 $spell:99171 위치 경고 보기",
	WarnRemainingAdds			= "사잇단계에서 피조물이 얼마나 남았는지에 대한 경고 보기",
	warnSeedsLand				= "$spell:98520이 시전될때가 아니라 폭발할때 경고 보기",
	ElementalAggroWarn			= "녹아내린 정령으로부터 위협수준 획득 유무에 대한 경고 보기",
	TimerPhaseSons				= "전환 단계 지속 타이머 보기",
	RangeFrame					= "거리 프레임이 필요하게 될 때 거리 프레임 보기",
	P4IconRangeFilter			= "영웅모드 4단계에서 거리 프레임에 전술 목표 아이콘만 보이도록 하기\n(거리 프레임이 켜져 있어야만 함)",
	InfoHealthFrame				= "체력 정보 프레임 보기 (10만 미만)",
	MeteorFrame					= "$spell:99849 대상 정보 프레임 보기",
	AggroFrame					= "녹아내린 정령으로 부터 위협수준을 획득하지 않은 대상에 대한 정보 프레임 보기",
	BlazingHeatIcons			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100983)
})

L:SetMiscLocalization({
	East				= "동쪽",
	West				= "서쪽",
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

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	TrashRangeFrame			= "$spell:100012의 거리프레임 보기(10 m)"
})

L:SetMiscLocalization({
})

----------------
--  Volcanus  --
----------------
L = DBM:GetModLocalization("Volcanus")

L:SetGeneralLocalization({
	name = "볼카누스"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	timerStaffTransition	= "전환 단계"
})

L:SetOptionLocalization({
	timerStaffTransition	= "전환 단계 지속 타이머 보기"
})

L:SetMiscLocalization({
	StaffEvent			= "(%S+)|1이;가; 놀드랏실의 가지를 건드리자 격렬하게 반응합니다!",
	StaffTrees			= "불타는 나무정령이 수호정령을 돕기 위해 땅에서 일어납니다!",--Might add a spec warning for this later.
	StaffTransition		= "고통받는 수호정령을 태우는 불이 사그라졌습니다!"
})