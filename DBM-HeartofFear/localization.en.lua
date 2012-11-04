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
	UnseenStrikeArrow	= "Show DBM Arrow when someone is affected by $spell:122949",
	RangeFrame			= "Show range frame (8) for $spell:123175"
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

L:SetWarningLocalization({
	warnAmberExplosion			= "%s is casting %s",
	warnInterruptsAvailable		= "Interupts available for %s: %s",
	specwarnWillPower			= "Low Will Power!",
	specwarnAmberExplosionYou	= "Interrupt YOUR %s!"--Struggle for Control interrupt.
})

L:SetTimerLocalization{
	timerAmberExplosionAMCD		= "Next %s: %s"
}

L:SetOptionLocalization({
	warnAmberExplosion			= "Show warning (with source) when $spell:122398 is cast",
	warnInterruptsAvailable		= "Announce who has Amber Strike interrupts available for $spell:122402",
	specwarnWillPower			= "Show special warning when will power is low in construct",
	specwarnAmberExplosionYou	= "Show special warning to interrupt your own $spell:122398",
	timerAmberExplosionAMCD		= "Show timer for Amber Monstrosity's next $spell:122402",
	InfoFrame					= "Show info frame for players will power (WIP)"
})

L:SetMiscLocalization({
	WillPower					= "Will Power"
})

------------
-- Grand Empress Shek'zeer --
------------
L= DBM:GetModLocalization(743)

L:SetOptionLocalization({
	InfoFrame			= "Show info frame for players affected by $spell:125390",
	RangeFrame			= "Show range frame (5) for $spell:123735"
})

L:SetMiscLocalization({
	PlayerDebuffs		= "Fixated",
	StickyResinIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(124097)
})
