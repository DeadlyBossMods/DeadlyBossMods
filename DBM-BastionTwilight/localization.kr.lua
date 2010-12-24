if GetLocale() ~= "koKR" then return end
local L

---------------------------
--  Valiona & Theralion  --
---------------------------
L = DBM:GetModLocalization("ValionaTheralion")

L:SetGeneralLocalization({
	name =	"발라리온과 테랄리온"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
	BlackoutIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92878),
	EngulfingIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(86622)
})

L:SetOptionLocalization({
	YellOnEngulfing			= "$spell:86622 외치기",
	RangeFrame				= "거리 프레임 보기"
})

L:SetMiscLocalization{
	Trigger1				= "테랄리온, 내가 전당에 불을 뿜겠다. 놈들의 퇴로를 막아라!",--Terrible phase trigger, even transcriptor couldn't grab anything more usefull than this :(
	YellEngulfing			= "사로잡힌 마법에 걸렸어요! T_T"
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
	SpecWarnGrounded		= "접지!!",
	SpecWarnSearingWinds	= "소용돌이 치는 바람!!"
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
	Monstrosity		= "Elementium Monstrosity"
})

L:SetOptionLocalization({
	SpecWarnGrounded		= "$spell:83581 버프가 사라지기 전, 특수 경고 보기\n(~10초 전 캐스팅)",
	SpecWarnSearingWinds	= "$spell:83500 버프가 사라지기 전, 특수 경고 보기\n(~10초 전 캐스팅)",
	timerTransition			= "전환 단계 타이머 보기",	
	HeartIceIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82665),
	BurningBloodIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82660),
	LightningRodIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(83099),
	GravityCrushIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(84948)
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
})

L:SetOptionLocalization({
	WarnPhase2Soon	= "2 단계 사전 경고 보기"
})