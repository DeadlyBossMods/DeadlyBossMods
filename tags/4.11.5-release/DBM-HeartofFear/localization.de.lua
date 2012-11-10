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
	Platform	= "%s fliegt zu einer seiner Plattformen!",
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

L:SetWarningLocalization({
	warnAmberExplosion			= ">%s< wirkt %s",
	warnInterruptsAvailable		= "Unterbrechungen verfügbar für %s: %s",
	specwarnWillPower			= "Geringe Willenskraft!",
	specwarnAmberExplosionYou	= "Unterbreche DEINE %s!",--Struggle for Control interrupt.
	specwarnAmberExplosionAM	= "%s: Unterbreche %s!",--Amber Montrosity
	specwarnAmberExplosionOther	= "%s: Unterbreche %s!"--Amber Montrosity
})

L:SetTimerLocalization{
	timerAmberExplosionAMCD		= "%s CD: %s"
}

L:SetOptionLocalization({
	warnAmberExplosion			= "Zeige Warnung (mit Quelle), wenn $spell:122398 gewirkt wird",
	warnInterruptsAvailable		= "Verkünde bei wem Amberstoß-Unterbrechungen für $spell:122402\nverfügbar sind",
	specwarnWillPower			= "Zeige Spezialwarnung bei geringer Willenskraft als Mutiertes Konstrukt",
	specwarnAmberExplosionYou	= "Zeige Spezialwarnung zum Unterbrechen deiner eigenen $spell:122398",
	specwarnAmberExplosionAM	= "Zeige Spezialwarnung zum Unterbrechen der $spell:122402\nder Ambermonstrosität",
	specwarnAmberExplosionOther	= "Zeige Spezialwarnung zum Unterbrechen der $spell:122402\nunkontrollierter Mutierter Konstrukte",
	timerAmberExplosionAMCD		= "Zeige Zeit bis nächste $spell:122402 der Ambermonstrosität",
	InfoFrame					= "Zeige Infofenster für Willenskraft der Spieler (IN ENTWICKLUNG)"
})

L:SetMiscLocalization({
	WillPower					= "Willenskraft"
})

------------
-- Grand Empress Shek'zeer --
------------
L= DBM:GetModLocalization(743)

L:SetOptionLocalization({
	InfoFrame			= "Zeige Infofenster für Spieler, welche von $spell:125390 betroffen sind",
	RangeFrame			= "Zeige Abstandsfenster (5m) für $spell:123735",
	StickyResinIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(124097)
})

L:SetMiscLocalization({
	PlayerDebuffs		= "Fixiert",
	YellPhase3			= "No more excuses, Empress! Eliminate these cretins or I will kill you myself!" --translate (trigger)
})
