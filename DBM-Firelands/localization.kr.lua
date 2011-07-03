if GetLocale() ~= "koKR" then return end
local L

---------------
-- Alysrazor --
---------------
L= DBM:GetModLocalization(194)

L:SetWarningLocalization({
	WarnPhase			= "%d 단계",
	WarnNewInitiate		= "타오르는 발톱 수습생 (%d)"
})

L:SetTimerLocalization({
	TimerPhaseChange	= "%d 단계",
	TimerHatchEggs		= "녹아내린 알 부화",
	timerNextInitiate	= "다음 수습생"
})

L:SetOptionLocalization({
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
	PowerLevel		= "타오르는 힘"
})

-------------------
-- Lord Rhyolith --
-------------------
L= DBM:GetModLocalization(193)

L:SetWarningLocalization({
	WarnElementals		= "부하 소환"
})

L:SetTimerLocalization({
	TimerElementals		= "다음 부하"
})

L:SetOptionLocalization({
	WarnElementals		= "부하 소환 경고 보기",
	TimerElementals		= "다음 부하 소환 타이머 보기"
})

L:SetMiscLocalization({
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
})

L:SetTimerLocalization({
	TimerBladeActive	= "%s",
	TimerBladeNext		= "다음 칼날"
})

L:SetOptionLocalization({
	TimerBladeActive	= "칼날 유지 타이머 보기",
	TimerBladeNext		= "다음 칼날 타이머 보기",
	SetIconOnCountdown	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(99516),
	ArrowOnCountdown	= "$spell:99516의 영향을 받은 경우 DBM 화살표 보기"
})

L:SetMiscLocalization({
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
	RangeFrameCat				= "$spell:98374의 거리 프레임 보기(10 m)"
})

L:SetMiscLocalization({
})

--------------
-- Ragnaros --
--------------
L= DBM:GetModLocalization(198)

L:SetTimerLocalization({
	TimerPhaseSons		= "자손 단계 종료"
})

L:SetOptionLocalization({
	TimerPhaseSons		= "'용암의 자손' 단계 지속 타이머 보기",
	RangeFrame			= "거리 프레임 보기"
})

L:SetMiscLocalization({
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
	RangeFrame	= "$spell:100012의 거리프레임 보기(10 m)"
})

L:SetMiscLocalization({
})