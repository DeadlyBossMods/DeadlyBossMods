if GetLocale() ~= "koKR" then return end
local L

------------
-- The Stone Guard --
------------
L= DBM:GetModLocalization(679)

L:SetWarningLocalization({
	SpecWarnOverloadSoon	= "7초 후 %s 가능!"
})

L:SetOptionLocalization({
	SpecWarnOverloadSoon	= "과부하 사전 특수 경고 보기",
})

L:SetMiscLocalization({
	Overload	= "과부하되기 직전입니다!"
})

------------
-- Feng the Accursed --
------------
L= DBM:GetModLocalization(689)

L:SetMiscLocalization({
	Fire		= "오 고귀한 자여! 나와 함께 발라내자! 뼈에서 살을!",
	Arcane		= "오 세기의 현자여! 내게 비전의 지혜를 불어넣어라!",
	Nature		= "오 위대한 영혼이여! 내게 대지의 힘을 부여하라!",--I did not log this one, text is probably not right
	Shadow		= "Great soul of champions past! Bear to me your shield!"
})

-------------------------------
-- Gara'jal the Spiritbinder --
-------------------------------
L= DBM:GetModLocalization(682)

L:SetOptionLocalization({
	RangeFrame			= "거리 프레임 표시 (8m)",
	SetIconOnVoodoo		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122151)
})

----------------------
-- The Spirit Kings --
----------------------
L = DBM:GetModLocalization(687)

L:SetOptionLocalization({
	RangeFrame			= "거리 프레임 표시 (8m)"
})


------------
-- Elegon --
------------
L = DBM:GetModLocalization(726)

L:SetWarningLocalization({
	specWarnDespawnFloor		= "바닥 조심!"
})

L:SetTimerLocalization({
	timerDespawnFloor			= "바닥 조심!"
})

L:SetOptionLocalization({
	specWarnDespawnFloor		= "바닥이 무너지기 전에 특수 경고 보기",
	timerDespawnFloor			= "바닥이 무너지기 전까지 남은 시간 바 표시"
})

------------
-- Will of the Emperor --
------------
L= DBM:GetModLocalization(677)

L:SetOptionLocalization({
	InfoFrame		= "$spell:116525 주문의 영향을 받은 플레이어를 정보 프레임에 표시"
})

L:SetMiscLocalization({
	Pull		= "Destroying the pipes leaks |cFFFF0000|Hspell:116779|h[Titan Gas]|h|r into the room!",--Emote
	Rage		= "The Emperor's Rage echoes through the hills.",--Yell
	Strength	= "The Emperor's Strength appears in the alcoves!",--Emote
	Courage		= "The Emperor's Courage appears in the alcoves!",--Emote
	Boss		= "Two titanic constructs appear in the large alcoves!"--Emote
})
