if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

------------
-- Imperial Vizier Zor'lok --
------------
L= DBM:GetModLocalization(745)

L:SetWarningLocalization({
	specwarnPlatform	= "Cambio de plataforma"
})

L:SetOptionLocalization({
	specwarnPlatform	= "Mostrar aviso especial cuando el boss cambia de plataforma",
	MindControlIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122740)
})

L:SetMiscLocalization({
	Platform	= "%s flies to one of his platforms!",--translate
	Defeat		= "We will not give in to the despair of the dark void. If Her will for us is to perish, then it shall be so."--translate
})


------------
-- Blade Lord Ta'yak --
------------
L= DBM:GetModLocalization(744)

L:SetOptionLocalization({
	UnseenStrikeArrow	= "Mostrar flecha cuando a alguien le afecta $spell:122949 ",
	RangeFrame			= "Mostrar distancia (8) para $spell:123175"
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
	Reinforcements		= "Wind Lord Mel'jarak calls for reinforcements!"--translate
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
	InfoFrame		= "Mostrar información de jugadores a los que les afecta $spell:125390",
	RangeFrame		= "Mostrar distancia (5) para $spell:123735"
})

L:SetMiscLocalization({
	PlayerDebuffs	= "Fijado"
})
