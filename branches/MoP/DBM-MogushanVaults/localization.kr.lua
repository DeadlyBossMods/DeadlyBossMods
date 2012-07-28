if GetLocale() ~= "koKR" then return end
local L

------------
-- The Stone Guard --
------------
L= DBM:GetModLocalization(679)

L:SetMiscLocalization({
	Overload	= "%s is about to Overload!"
})

------------
-- Feng the Accursed --
------------
L= DBM:GetModLocalization(689)

L:SetMiscLocalization({
	Fire		= "Oh exalted one! Through me you shall melt flesh from bone!",
	Arcane		= "Oh sage of the ages! Instill to me your arcane wisdom!",
	Nature		= "Oh great spirit! Grant me the power of the earth!",--I did not log this one, text is probably not right
	Shadow		= "Great soul of champions past! Bear to me your shield!"
})

-------------------------------
-- Gara'jal the Spiritbinder --
-------------------------------
L= DBM:GetModLocalization(682)


----------------------
-- The Spirit Kings --
----------------------
L = DBM:GetModLocalization(687)

L:SetOptionLocalization({
	RangeFrame			= "거리 프레임 표시 (8m)"
})

L:SetMiscLocalization({
	--localized names for the CHAT_MSG_MONSTER_YELL (not EJ)
	Meng	= "Meng the Demented",
	Qiang	= "Qiang the Merciless",
	Subetai	= "Subetai the Swift"
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
