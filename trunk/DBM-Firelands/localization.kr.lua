if GetLocale() ~= "koKR" then return end
local L

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
	YellInitiate1	= "불의 군주시여, 힘을 주소서!",
	YellInitiate2	= "그분의 힘을 보아라!",
	YellInitiate3	= "믿지 않는 자, 불로 멸하리라!",
	YellInitiate4	= "화염의 장엄함을 지켜봐라!",
	YellPhase2		= "이 하늘은 나의 것이다!",
	FullPower		= "spell:99925",--This is in the emote, shouldn't need localizing, just msg:find
	LavaWorms		= "불타는 용암 벌레가 땅에서 튀어나옵니다!",--Might use this one day if i feel it needs a warning for something. Or maybe pre warning for something else (like transition soon)
	PowerLevel		= "타오르는 힘",
	East			= "동쪽",
	West			= "서쪽",
	Both			= "양쪽"
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
	timerShards			= "다음 %s (%d)",
	timerStrike			= "다음 %s",
	TimerBladeActive	= "%s",
	TimerBladeNext		= "다음 칼날 활성화"
})

L:SetOptionLocalization({
	warnStrike			= "지옥불/학살의 칼날에 피해를 입을 때 경고 보기",
	timerShards			= "다음 $spell:99259 타이머 보기",
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
})

L:SetOptionLocalization({
	RangeFrameSeeds				= "$spell:98450의 거리 프레임 보기(12 m)",
	RangeFrameCat				= "$spell:98374의 거리 프레임 보기(10 m)",
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
	WarnRemainingAdds		= "남은 자손: %d"
})

L:SetTimerLocalization({
	TimerPhaseSons		= "전환 단계"
})

L:SetOptionLocalization({
	warnSplittingBlow	= "$spell:100877 경고 보기",
	warnEngulfingFlame	= "$spell:99171 경고 보기",
	WarnRemainingAdds	= "전환 단계에서 쫄이 얼마나 남았는지에 대한 경고 보기",
	TimerPhaseSons		= "전환 단계 지속 타이머 보기",
	RangeFrame			= "거리 프레임이 필요하게 될 때 거리 프레임 보기",
	InfoFrame			= "$spell:99849 대상 정보 프레임 보기",
	BlazingHeatIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100983)
})

L:SetMiscLocalization({
	East				= "동쪽",
	West				= "서쪽",
	Middle				= "중앙",
	North				= "근접",
	South				= "뒤쪽",
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