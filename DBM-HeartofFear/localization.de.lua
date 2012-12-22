if GetLocale() ~= "deDE" then return end
local L

------------
-- Imperial Vizier Zor'lok --
------------
L= DBM:GetModLocalization(745)

L:SetWarningLocalization({
	warnAttenuation		= "%s auf %s (%s)",
	specwarnAttenuation	= "%s auf %s (%s)",
	specwarnPlatform	= "Plattformwechsel"
})

L:SetOptionLocalization({
	warnAttenuation		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(127834, GetSpellInfo(127834)),
	specwarnAttenuation	= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format(127834, GetSpellInfo(127834)),
	specwarnPlatform	= "Zeige Spezialwarnung bei Plattformwechsel des Bosses",
	ArrowOnAttenuation	= "Zeige DBM-Pfeil während $spell:127834 zur Anzeige der Ausweichrichtung",
	MindControlIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122740)
})

L:SetMiscLocalization({
	Platform			= "fliegt zu einer seiner Plattformen!",
	Defeat				= "Wir werden der Verzweiflung der dunklen Leere nicht nachgeben. Wenn es Ihr Wille ist, dass wir dahinscheiden, dann soll es so sein.",
	Left				= "Links",
	Right				= "Rechts"
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

L:SetWarningLocalization({
	specwarnUnder	= "Raus aus dem violetten Kreis!"
})

L:SetOptionLocalization({
	specwarnUnder	= "Zeige Spezialwarnung, wenn du dich unter dem Boss befindest",
	PheromonesIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122835)
})

L:SetMiscLocalization({
	UnderHim	= "Unter ihm"
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
	warnReshapeLife				= "%s auf >%s< (%d)",
	warnReshapeLifeTutor		= "1: Unterbreche/Debuffe Ziel, 2: Unterbreche dich selbst, 3: Regeneriere Gesundheit/Willen, 4: Verlasse Konstrukt",
	warnAmberExplosion			= ">%s< wirkt %s",
	warnInterruptsAvailable		= "Unterbrechungen verfügbar für %s: >%s<",
	warnWillPower				= "Aktueller Willen: %s",
	specwarnWillPower			= "Geringer Willen!",
	specwarnAmberExplosionYou	= "Unterbreche DEINE %s!",--Struggle for Control interrupt.
	specwarnAmberExplosionAM	= "%s: Unterbreche %s!",--Amber Montrosity
	specwarnAmberExplosionOther	= "%s: Unterbreche %s!"--Amber Montrosity
})

L:SetTimerLocalization({
	timerAmberExplosionAMCD		= "%s CD: Monstrosität"
})

L:SetOptionLocalization({
	warnReshapeLife				= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target:format(122784, GetSpellInfo(122784)),
	warnReshapeLifeTutor		= "Zeige Überblick über den Zweck der Fähigkeiten Mutierter Konstrukte",
	warnAmberExplosion			= "Zeige Warnung (mit Quelle), wenn $spell:122398 gewirkt wird",
	warnInterruptsAvailable		= "Verkünde bei wem Amberstoß-Unterbrechungen für $spell:122402\nverfügbar sind",
	warnWillPower				= "Verkünde aktuellen Willen bei 75, 50, 25, 10 und 5",
	specwarnWillPower			= "Zeige Spezialwarnung bei geringem Willen als Mutiertes Konstrukt",
	specwarnAmberExplosionYou	= "Zeige Spezialwarnung zum Unterbrechen deiner eigenen $spell:122398",
	specwarnAmberExplosionAM	= "Zeige Spezialwarnung zum Unterbrechen der $spell:122402\nder Ambermonstrosität",
	specwarnAmberExplosionOther	= "Zeige Spezialwarnung zum Unterbrechen der $spell:122402\nunkontrollierter Mutierter Konstrukte",
	timerAmberExplosionAMCD		= "Zeige Zeit bis nächste $spell:122402 der Ambermonstrosität",
	InfoFrame					= "Zeige Infofenster für Willen der Spieler",
	FixNameplates				= "Automatische Deaktivierung störender Namensplaketten als Konstrukt\n(wird nach dem Kampfende auf die vorherige Einstellung zurückgesetzt)"
})

L:SetMiscLocalization({
	WillPower					= "Willen"
})

------------
-- Grand Empress Shek'zeer --
------------
L= DBM:GetModLocalization(743)

L:SetWarningLocalization({
	warnAmberTrap		= "Amberfallenbau: %d/5",
})

L:SetOptionLocalization({
	warnAmberTrap		= "Verkünde den Fortschritt beim Bau einer $spell:125826",
	InfoFrame			= "Zeige Infofenster für Spieler, welche von $spell:125390 betroffen sind",
	RangeFrame			= "Zeige Abstandsfenster (5m) für $spell:123735",
	StickyResinIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(124097)
})

L:SetMiscLocalization({
	PlayerDebuffs		= "Fixiert",
	YellPhase3			= "KEINE AUSREDEN MEHR, KAISERIN! Tötet diese Idioten oder ich selbst mache Euch den Garaus!"
})
