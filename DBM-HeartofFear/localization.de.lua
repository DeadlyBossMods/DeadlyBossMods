if GetLocale() ~= "deDE" then return end
local L

------------
-- Imperial Vizier Zor'lok --
------------
L= DBM:GetModLocalization(745)

L:SetWarningLocalization({
	specwarnPlatform	= "Plattformwechsel"
})

L:SetOptionLocalization({
	specwarnPlatform	= "Zeige Spezialwarnung bei Plattformwechsel des Bosses",
	MindControlIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122740)
})

L:SetMiscLocalization({
	Platform	= "%s flies to one of his platforms!", --translate (trigger)
	Defeat		= "We will not give in to the despair of the dark void. If Her will for us is to perish, then it shall be so." --translate (trigger)
})


------------
-- Blade Lord Ta'yak --
------------
L= DBM:GetModLocalization(744)

L:SetOptionLocalization({
	UnseenStrikeArrow	= "Zeige DBM-Pfeil, wenn jemand von $spell:122949 betroffen ist",
	RangeFrame			= "Zeige Abstandsfenster (8m) für $spell:123175"
})


-------------------------------
-- Garalon --
-------------------------------
L= DBM:GetModLocalization(713)

L:SetOptionLocalization({
	PheromonesIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122835)
})

----------------------
-- Wind Lord Mel'jarak --
----------------------
L= DBM:GetModLocalization(741)

L:SetOptionLocalization({
	AmberPrisonIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(121885)
})

L:SetMiscLocalization({
	Reinforcements		= "Wind Lord Mel'jarak calls for reinforcements!" --translate (trigger)
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
	InfoFrame		= "Zeige Infofenster für Spieler, welche von $spell:125390 betroffen sind",
	RangeFrame		= "Zeige Abstandsfenster (5m) für $spell:123735"
})

L:SetMiscLocalization({
	PlayerDebuffs	= "Fixiert"
})
