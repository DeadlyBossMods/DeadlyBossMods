if GetLocale() ~= "koKR" then return end
local L

------------
-- Imperial Vizier Zor'lok --
------------
L= DBM:GetModLocalization(745)

L:SetWarningLocalization({
	specwarnPlatform	= "Platform change"
})

L:SetOptionLocalization({
	specwarnPlatform	= "Show special warning when boss changes platforms",
	MindControlIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122740)
})

L:SetMiscLocalization({
	Platform	= "%s flies to one of his platforms!",
	Defeat		= "We will not give in to the despair of the dark void. If Her will for us is to perish, then it shall be so."
})


------------
-- Blade Lord Ta'yak --
------------
L= DBM:GetModLocalization(744)

L:SetOptionLocalization({
	UnseenStrikeArrow	= "$spell:122949 주문의 영향을 누군가 받은 경우 DBM 화살표 보기",
	RangeFrame			= "$spell:123175 주문의 영향을 받은 경우 거리 프레임 표시(10m)"
})

L:SetMiscLocalization{
	UnseenStrike	= "spell:122949"--This is in the emote, shouldn't need localizing, just msg:find
}


-------------------------------
-- Garalon --
-------------------------------
L= DBM:GetModLocalization(713)


----------------------
-- Wind Lord Mel'jarak --
----------------------
L= DBM:GetModLocalization(741)

L:SetOptionLocalization({
	AmberPrisonIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(121885)
})

L:SetMiscLocalization({
	Reinforcements		= "Wind Lord Mel'jarak calls for reinforcements!"
})

------------
-- Amber-Shaper Un'sok --
------------
L= DBM:GetModLocalization(737)


------------
-- Grand Empress Shek'zeer --
------------
L= DBM:GetModLocalization(743)

L:SetOptionLocalization({
	InfoFrame		= "Show info frame for players affected by $spell:125390"
})

L:SetMiscLocalization({
	PlayerDebuffs	= "Fixated"
})
