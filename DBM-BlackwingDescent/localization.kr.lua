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
	SpecWarnInferno	= "곧 해골 소환 - 바닥 확인!",
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SpecWarnInferno	= "$spell:92190의 사전 특수 경고 보기(~4초 전)",
	RangeFrame		= "2 단계 거리 프레임 보기 (5m)"
})

L:SetMiscLocalization({
	Slump			= "%s|1이;가; 집게를 드러내며 앞으로 몸을 기울입니다!",
	HeadExposed		= "%s|1이;가; 창에 꽂혀 머리가 노출되었습니다!",
	YellPhase2		= "이런 곤란할 데가! 이러다간 내 용암 벌레가 정말 질 수도 있겠군! 그럼... 내가 상황을 좀 바꿔 볼까?" --"Inconceivable! You may actually defeat my lava worm! Perhaps I can help... tip the scales."
})

-------------------------------
--  Dark Iron Golem Council  --
-------------------------------
L = DBM:GetModLocalization("DarkIronGolemCouncil")

L:SetGeneralLocalization({
	name = "만능골렘 방어 시스템"
})

L:SetWarningLocalization({
	SpecWarnActivated			= "대상 전환! - %s",
	specWarnGenerator			= "%s이 동력 증폭장 영향을 받음 - 빼세요!"
})

L:SetTimerLocalization({
	timerArcaneBlowbackCast		= "폭발!",
	timerShadowConductorCast	= "암흑 전도체 변환",
	timerNefAblity				= "스킬 강화 쿨다운",
	timerArcaneLockout			= "비전 파괴자 쿨다운"
})

L:SetOptionLocalization({
	timerShadowConductorCast	= "$spell:92053 시전 타이머 보기",
	timerArcaneBlowbackCast		= "$spell:91879 시전 타이머 보기",
	timerNefAblity				= "영웅 모드에서 골렘 스킬 강화 쿨다운 타이머 보기",
	timerArcaneLockout			= "$spell:91542 침묵 타이머 보기",
	SpecWarnActivated			= "새로운 보스가 활성화 될 때 특수 경고 보기",
	specWarnGenerator			= "보스가 $spell:91557의 영향을 받을 경우 특수 경고 보기",
	AcquiringTargetIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79501),
	ConductorIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79888),
	ShadowConductorIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92053),
	SetIconOnActivated			= "새로 활성화된 보스에게 전술 목표 아이콘 설정하기"
})

L:SetMiscLocalization({
	Magmatron					= "용암골렘",
	Electron					= "전기골렘",
	Toxitron					= "맹독골렘",
	Arcanotron					= "비전골렘",
	YellTargetLock				= "어둠의 휘감기! 제 주변에서 빠지세요!"
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

L:SetOptionLocalization({
	WarnPhase			= "다음 단계 전환 경고 보기",
	WarnRemainingAdds	= "돌연변이가 얼마나 남았는지 경고 보기",
	TimerPhase			= "다음 단계 타이머 보기",
	RangeFrame			= "푸른 단계에서 거리 프레임 보기",	
	SetTextures			= "암흑 단계에서 텍스쳐 투영 효과 자동으로 끄기\n(암흑 단계가 종료 되면 원상태로)",
	FlashFreezeIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92979),
	BitingChillIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77760),
	ConsumingFlamesIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77786)
})

L:SetMiscLocalization({
	YellRed			= "붉은색|r 약병을 가마솥",
	YellBlue		= "푸른색|r 약병을 가마솥",
	YellGreen		= "초록색|r 약병을 가마솥",
	YellDark		= "암흑|r 마법을 사용합니다!",
	Red				= "붉은색",
	Blue			= "푸른색",
	Green			= "초록색",
	Dark			= "암흑"
})

-----------------
--  Chimaeron  --
-----------------
L = DBM:GetModLocalization("Chimaeron")

L:SetGeneralLocalization({
	name = "키마이론"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	RangeFrame		= "거리 프레임 보기(6 m)",
	SetIconOnSlime	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82935),
	InfoFrame		= "체력 정보 프레임 보기"
})

L:SetMiscLocalization({
	HealthInfo	= "체력 정보"
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
	WarnShieldsLeft		= "고대 드워프 방패 - %d - 남음",
	warnAddSoon				= "곧 불쾌한 마귀 소환",
	specWarnAddTargetable	= "%s 공격 가능!"
})

L:SetTimerLocalization({
	TimerAirphase		= "다음 공중 단계",
	TimerGroundphase	= "다음 지상 단계"
})

L:SetOptionLocalization({
	WarnAirphase			= "공중 단계 경고 보기",
	WarnGroundphase			= "지상 단계 경고 보기",
	WarnShieldsLeft			= "고대 드워프 방패 사용시 경고 보기",
	warnAddSoon				= "불쾌한 마귀 소환 경고 보기",
	specWarnAddTargetable	= "불쾌한 마귀가 공격 가능할 때 특수 경고 보기",
	TimerAirphase			= "다음 공중 단계 경고 보기",
	TimerGroundphase		= "다음 지상 단계 경고 보기",
	InfoFrame				= "소음계 정보 프레임 보기",
	TrackingIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(78092)
})

L:SetMiscLocalization({
	AncientDwarvenShield	= "고대 드워프 보호막",
	Soundlevel				= "소음계",
	YellPestered			= "나에게 불쾌한 마귀!!",--npc 49740
	NefAdd					= "아트라메데스, 적은 바로 저기에 있다!",
	Airphase				= "그래, 도망가라! 발을 디딜 때마다 맥박은 빨라지지. 점점 더 크게 울리는구나... 귀청이 터질 것만 같군! 넌 달아날 수 없다!"
})
----------------
--  Nefarian  --
----------------
L = DBM:GetModLocalization("Nefarian-BD")	-- No conflict with BWL version :)

L:SetGeneralLocalization({
	name = "네파리안의 최후"
})

L:SetWarningLocalization({
	OnyTailSwipe			= "꼬리 채찍 (오닉시아)",
	NefTailSwipe			= "꼬리 채찍 (네파리안)",
	OnyBreath				= "암흑불길 숨결 (오닉시아)",
	NefBreath				= "암흑불길 숨결 (네파리안)",
	specWarnShadowblazeSoon	= "곧 암흑 화로 (~5초 전)!"
})

L:SetTimerLocalization({
	timerNefLanding		= "네파리안 착지",
	OnySwipeTimer		= "오닉 꼬리 채찍 쿨다운",
	NefSwipeTimer		= "네파 꼬리 채찍 쿨다운",
	OnyBreathTimer		= "오닉 브레스 쿨다운",
	NefBreathTimer		= "네파 브레스 쿨다운"
})

L:SetOptionLocalization({
	OnyTailSwipe			= "오닉시아의 $spell:77827 경고 보기",
	NefTailSwipe			= "네파리안의 $spell:77827 경고 보기",
	OnyBreath				= "오닉시아의 $spell:94124 경고 보기",
	NefBreath				= "네파리안의 $spell:94124 경고 보기",
	specWarnShadowblazeSoon	= "$spell:94085의 사전 특수 경고 보기 (~5초 전)",
	timerNefLanding			= "네파리안 착지 타이머 보기",
	OnySwipeTimer			= "오닉시아의 $spell:77827 쿨다운 타이머 보기",
	NefSwipeTimer			= "네파리안의 $spell:77827 쿨다운 타이머 보기",
	OnyBreathTimer			= "오닉시아의 $spell:94124 쿨다운 타이머 보기",
	NefBreathTimer			= "네파리안의 $spell:94124 쿨다운 타이머 보기",
	InfoFrame				= "오닉시아 전하 충전 정보 프레임 보기",
	SetWater				= "풀링시 수면 자동 시점 옵션을 자동으로 끄기\n(전투가 종료 되면 원상태로)",
	TankArrow				= "살아난 뼈다귀 전사 탱커 방향으로 DBM 화살표 보기\n(한 명의 탱커를 사용하는 경우에만 정상 작동)",--npc 41918
	SetIconOnCinder			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79339),
	RangeFrame				= "$spell:79339의 거리 프레임(10m) 보기\n(대상자는 범위내 모든 플레이어 보임. 대상자가 아닌 경우 대상자와 아이콘만 보임)"
})

L:SetMiscLocalization({
	NefAoe				= "전기가 튀며 파지직하는 소리가 납니다!",
	YellPhase2			= "저주받을 필멸자들! 내 소중한 작품을 이렇게 망치다니! 쓴맛을 봐야 정신을 차리겠군!",
	YellPhase3			= "품위있는 집주인답게 행동하려 했건만, 네놈들이 도무지 죽질 않는군! 겉치레는 이제 집어치우자고. 그냥 모두 없애 버리겠어!", -- "I have tried to be an accommodating host, but you simply will not die! Time to throw all pretense aside and just... KILL YOU ALL!",
	Nefarian			= "네파리안",
	Onyxia				= "오닉시아",
	Charge				= "전하 충전"
})

--------------
--  Blackwing Descent Trash  --
--------------
L = DBM:GetModLocalization("BWDTrash")

L:SetGeneralLocalization({
	name = "검은날개 강림지 일반몹"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})