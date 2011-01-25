if GetLocale() ~= "koKR" then return end
local L

---------------------------
--  Valiona & Theralion  --
---------------------------
L = DBM:GetModLocalization("ValionaTheralion")

L:SetGeneralLocalization({
	name =	"발라오나와 테랄리온"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	YellOnEngulfing			= "$spell:86622 외치기",
	YellOnMeteor			= "$spell:88518 외치기",
	YellOnTwilightBlast		= "$spell:92898 외치기",
	TwilightBlastArrow		= "당신의 근처에 $spell:92898이 있을 경우 DBM 화살표 보기",	
	RangeFrame				= "거리 프레임 보기(10m)"
})

L:SetMiscLocalization{
	Trigger1				= "테랄리온, 내가 전당에 불을 뿜겠다. 놈들의 퇴로를 막아라!",--Terrible phase trigger, even transcriptor couldn't grab anything more usefull than this :(
	YellMeteor				= "나에게 황혼 유성!!",
	YellTwilightBlast		= "나에게 황혼 폭발!!",	
	YellEngulfing			= "사로잡힌 마법에 걸렸어요! T_T",
	BlackoutIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92878),
	EngulfingIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(86622)
}

--------------------------
--  Halfus Wyrmbreaker  --
--------------------------
L = DBM:GetModLocalization("HalfusWyrmbreaker")

L:SetGeneralLocalization({
	name =	"할푸스 웜브레이커"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
})

----------------------------------
--  Twilight Ascendant Council  --
----------------------------------
L = DBM:GetModLocalization("AscendantCouncil")

L:SetGeneralLocalization({
	name =	"승천 의회"
})

L:SetWarningLocalization({
	specWarnBossLow			= ">%s< 체력 30%",
	SpecWarnGrounded		= "접지 버프 받기!!",
	SpecWarnSearingWinds	= "소용돌이 치는 바람 버프 받기!!"
})

L:SetTimerLocalization({
	timerTransition			= "전환 단계"
})

L:SetMiscLocalization({
	Quake			= "발밑의 땅이 불길하게 우르릉거립니다...",
	Thundershock	= "주변의 공기가 에너지로 진동합니다...",
	Switch			= "우리가 상대하겠다!",--"We will handle them!" comes 3 seconds after this one
	Phase3			= "꽤나 인상적이었다만...",--"BEHOLD YOUR DOOM!" is about 13 seconds after	
	Ignacious		= "이그니시우스",
	Feludius		= "펠루디우스",
	Arion			= "아리온",
	Terrastra		= "테라스트라",
	Monstrosity		= "엘레멘티움 괴물",
	Kill			= "이럴 수가..."
})

L:SetOptionLocalization({
	specWarnBossLow			= "보스의 체력이 30% 이하로 내려갈 경우 특수 경고 보기",
	SpecWarnGrounded		= "$spell:83581 버프가 없을 경우, 특수 경고 보기\n(~10초 전 캐스팅)",
	SpecWarnSearingWinds	= "$spell:83500 버프가 없을 경우, 특수 경고 보기\n(~10초 전 캐스팅)",
	timerTransition			= "전환 단계 타이머 보기",
	RangeFrame				= "거리 프레임이 필요하게 될 경우 자동으로 보기",	
	HeartIceIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82665),
	BurningBloodIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82660),
	LightningRodIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(83099),
	GravityCrushIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(84948),
	FrostBeaconIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92307),
	StaticOverloadIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92067),
	GravityCoreIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92075)
})

----------------
--  Cho'gall  --
----------------
L = DBM:GetModLocalization("Chogall")

L:SetGeneralLocalization({
	name =	"초갈"
})

L:SetWarningLocalization({
	WarnPhase2Soon	= "곧 2 단계"
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
	YellCrash				= "부패의 충돌!!",
	Bloodlevel				= "고통"
})

L:SetOptionLocalization({
	WarnPhase2Soon			= "2 단계 사전 경고 보기",
	CorruptingCrashArrow	= "당신 근처에 $spell:93178이 있을 경우 DBM 화살표 보기",
	InfoFrame				= "$spell:82235의 정보 프레임 보기",
	RangeFrame				= "$spell:82235의 거리 프레임(6m) 보기",
	YellOnCorrupting		= "$spell:93178 외치기",
	SetIconOnWorship		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(91317)
})


----------------
--  Sinestra  --
----------------
L = DBM:GetModLocalization("Sinestra")

L:SetGeneralLocalization({
	name =	"시네스트라"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
})