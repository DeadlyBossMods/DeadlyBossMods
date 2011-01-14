if GetLocale() ~= "koKR" then return end

local L

--------------
--  Magmaw  --
--------------
L = DBM:GetModLocalization("Magmaw")

L:SetGeneralLocalization({
	name = "용암아귀"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
	Slump			= "%s|1이;가; 집게를 드러내며 앞으로 몸을 기울입니다!",
	HeadExposed		= "%s|1이;가; 창에 꽂혀 머리가 노출되었습니다!"
})

L:SetOptionLocalization({
})

-------------------------------
--  Dark Iron Golem Council  --
-------------------------------
L = DBM:GetModLocalization("DarkIronGolemCouncil")

L:SetGeneralLocalization({
	name = "만능골렘 방어 시스템"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	timerShadowConductorCast	= "비전 역류",
	timerShadowConductorCast	= "암흑 전도체"
})

L:SetMiscLocalization({
	Magmatron	= "용암골렘",
	Electron	= "전기골렘",
	Toxitron	= "맹독골렘",
	Arcanotron	= "비전골렘"
})

L:SetOptionLocalization({
	timerShadowConductorCast	= "$spell:92053 시전 타이머 보기",
	timerArcaneBlowbackCast		= "$spell:91879 시전 타이머 보기",
	AcquiringTargetIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79501),
	ConductorIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79888),
	BombTargetIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(80094),
	ShadowConductorIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92053)
})

----------------
--  Maloriak  --
----------------
L = DBM:GetModLocalization("Maloriak")

L:SetGeneralLocalization({
	name = "말로리악"
})

L:SetWarningLocalization({
	WarnPhase			= "%s 단계",
	WarnRemainingAdds	= "%d 돌연변이 남음"
})

L:SetTimerLocalization({
	TimerPhase		= "다음 단계"
})

L:SetMiscLocalization({
	YellRed			= "섞고 흔들어서, 열을 가한다...",
	YellBlue		= "급격한 온도 변화에 필멸의 육신",
	YellGreen		= "이건 좀 불안정하지만",
	YellDark		= "혼합물이 너무 약하구나, 말로리악!",
	Red				= "|cFFFF0000붉은|r 단계",
	Blue			= "|cFF809FFE푸른|r 단계",
	Green			= "|cFF33FF00초록|r 단계",
	Dark			= "|cFF660099암흑|r 단계"
})

L:SetOptionLocalization({
	WarnPhase			= "다음 단계 전환 경고 보기",
	WarnRemainingAdds	= "돌연변이가 얼마나 남았는지 경고 보기",
	TimerPhase			= "다음 단계 타이머 보기",
	RangeFrame			= "푸른 단계에서 거리 프레임 보기",	
	FlashFreezeIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92979),
	BitingChillIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77760),
	ConsumingFlamesIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77786)
})

-----------------
--  Chimaeron  --
-----------------
L = DBM:GetModLocalization("Chimaeron")

L:SetGeneralLocalization({
	name = "키마이론"
})

L:SetWarningLocalization({
	WarnPhase2Soon	= "곧 2 단계",
	WarnBreak		= "%s : >%s< (%d)"
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
	WarnPhase2Soon	= "2 단계 사전 경고 보기",
	RangeFrame		= "거리 프레임 보기(6 m)",
	WarnBreak		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(82881, GetSpellInfo(82881) or "알 수 없음"),
	SetIconOnSlime	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82935)	
})

-----------------
--  Atramedes  --
-----------------
L = DBM:GetModLocalization("Atramedes")

L:SetGeneralLocalization({
	name = "아트라메데스"
})

L:SetWarningLocalization({
	WarnAirphase		= "공중 단계",
	WarnGroundphase		= "지상 단계",
	WarnShieldsLeft		= "고대 드워프 보호막 - %d -남음"
})

L:SetTimerLocalization({
	TimerAirphase		= "공중 단계",
	TimerGroundphase	= "지상 단계"
})

L:SetMiscLocalization({
	AncientDwarvenShield	= "고대 드워프 보호막",
	Soundlevel				= "소음계",	
	Airphase				= "그래, 도망가라! 발을 디딜 때마다 맥박은 빨라지지. 점점 더 크게 울리는구나... 귀청이 터질 것만 같군! 넌 달아날 수 없다!"
})

L:SetOptionLocalization({
	WarnAirphase		= "공중단계 경고 보기",
	WarnGroundphase		= "지상단계 경고 보기",
	WarnShieldsLeft		= "고대 드워프 보호막 남은 개수 경고 보기",
	TimerAirphase		= "다음 공중 단계 경고 보기",
	TimerGroundphase	= "다음 지상 단계 경고 보기",
	InfoFrame			= "소음계 정보 프레임 보기",
	TrackingIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(78092)
})

----------------
--  Nefarian  --
----------------
L = DBM:GetModLocalization("Nefarian-BD")	-- No conflict with BWL version :)

L:SetGeneralLocalization({
	name = "네파리안"
})

L:SetWarningLocalization({
	OnyTailSwipe		= "꼬리 채찍 (오닉시아)",
	NefTailSwipe		= "꼬리 채찍 (네파리안)",
	OnyBreath			= "암흑불길 숨결 (오닉시아)",
	NefBreath			= "암흑불길 숨결 (네파리안)"
})

L:SetTimerLocalization({
	OnySwipeTimer		= "꼬리 채찍 (오닉시아)",
	NefSwipeTimer		= "꼬리 채찍 (네파리안)",
	OnyBreathTimer		= "암흑불길 숨결 (오닉시아)",
	NefBreathTimer		= "암흑불길 숨결 (네파리안)"
})

L:SetOptionLocalization({
	OnyTailSwipe		= "오닉시아의 $spell:77827 경고 보기",
	NefTailSwipe		= "네파리안의 $spell:77827 경고 보기",
	OnyBreath			= "오닉시아의 $spell:94124 경고 보기",
	NefBreath			= "네파리안의 $spell:94124 경고 보기",
	OnySwipeTimer		= "오닉시아의 $spell:77827 쿨다운 타이머 보기",
	NefSwipeTimer		= "네파리안의 $spell:77827 쿨다운 타이머 보기",
	OnyBreathTimer		= "오닉시아의 $spell:94124 쿨다운 타이머 보기",
	NefBreathTimer		= "네파리안의 $spell:94124 쿨다운 타이머 보기"
})

L:SetMiscLocalization({
	NefAoe				= "전기가", -- "The air crackles with electricity!" check
	YellPhase2			= "저주받을 필멸자들!",
	ShadowblazeCast		= "살을 재로",	
	ChromaticPrototype	= "오색 실험체"
})
