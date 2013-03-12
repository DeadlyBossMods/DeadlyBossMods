if GetLocale() ~= "itIT" then return end
local L

------------
-- Imperial Vizier Zor'lok --
------------
L= DBM:GetModLocalization(745)

L:SetWarningLocalization({
	specwarnPlatform	= "Platform change"
})

L:SetOptionLocalization({
	specwarnPlatform	= "Visualizza un avviso speciale quando il boss cambia piattaforme.",
	MindControlIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122740)
})

L:SetMiscLocalization({
	Platform	= "Il Visir Imperiale Zor'lok vola verso una delle sue piattaforme!",-- da Chat Log
	Defeat		= "We will not give in to the despair of the dark void. If Her will for us is to perish, then it shall be so."-- da tradurre con Chat Log
})


------------
-- Blade Lord Ta'yak --
------------
L= DBM:GetModLocalization(744)

L:SetOptionLocalization({
	UnseenStrikeArrow	= "Visualizza la Freccia di DBM quando qualcuno e' affetto da $spell:122949 ",
	RangeFrame			= "Visualizza il radar (8) per $spell:123175"
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
	InfoFrame		= "Visualizza il frame di Informazioni per chi e' colpito da $spell:125390",
	RangeFrame		= "Visualizza il Radar di prossimita' (5) per $spell:123735"
})

L:SetMiscLocalization({
	PlayerDebuffs	= "Inseguito"
})
