if GetLocale() ~= "deDE" then return end
local L

------------
-- Imperial Vizier Zor'lok --
------------
L= DBM:GetModLocalization(745)

L:SetWarningLocalization({
	warnAttenuation		= "%s auf %s (%s)",
	warnEcho			= "Echo erschienen",
	warnEchoDown		= "Echo besiegt",
	specwarnAttenuation	= "%s auf %s (%s)",
	specwarnPlatform	= "Plattformwechsel"
})

L:SetOptionLocalization({
	warnEcho			= "Verkünde das Erscheinen eines Echos",
	warnEchoDown		= "Verkünde den Sieg über ein Echo",
	specwarnPlatform	= "Spezialwarnung bei Plattformwechsel des Bosses",
	ArrowOnAttenuation	= "Zeige DBM-Pfeil während $spell:127834 zur Anzeige der Ausweichrichtung"
})

L:SetMiscLocalization({
	Platform			= "fliegt zu einer seiner Plattformen!",
	Defeat				= "Wir werden der Verzweiflung der dunklen Leere nicht nachgeben. Wenn es Ihr Wille ist, dass wir dahinscheiden, dann soll es so sein."
})


------------
-- Blade Lord Ta'yak --
------------
L= DBM:GetModLocalization(744)

L:SetOptionLocalization({
	UnseenStrikeArrow	= "Zeige DBM-Pfeil, wenn jemand von $spell:122949 betroffen ist",
	RangeFrame			= "Zeige Abstandsfenster (10m) für $spell:123175"
})


-------------------------------
-- Garalon --
-------------------------------
L= DBM:GetModLocalization(713)

L:SetWarningLocalization({
	warnCrush		= "%s",
	specwarnUnder	= "Raus aus dem violetten Kreis!"
})

L:SetOptionLocalization({
	specwarnUnder	= "Spezialwarnung, wenn du dich unter dem Boss befindest",
	countdownCrush	= DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT:format(122774).."\n(nur heroischer Schwierigkeitsgrad)"
})

L:SetMiscLocalization({
	UnderHim	= "Unter ihm",
	Phase2		= "Plattenrüstung reißt und platzt auf" --needs to be verified (video-captured translation, hero only)
})

----------------------
-- Wind Lord Mel'jarak --
----------------------
L= DBM:GetModLocalization(741)

------------
-- Amber-Shaper Un'sok --
------------
L= DBM:GetModLocalization(737)

L:SetWarningLocalization({
	warnReshapeLife				= "%s auf >%s< (%d)",
	warnReshapeLifeTutor		= "1: Unterbreche/Debuffe Ziel, 2: Unterbreche dich selbst, 3: Regeneriere Gesundheit/Willen, 4: Verlasse Konstrukt",
	warnAmberExplosion			= ">%s< wirkt %s",
	warnAmberExplosionAM		= "Bernmonstrosität wirkt Bernexplosion - Jetzt unterbrechen!",
	warnInterruptsAvailable		= "Unterbrechungen verfügbar für %s: >%s<",
	warnWillPower				= "Aktueller Willen: %s",
	specwarnWillPower			= "Geringer Willen! - 5 Sekunden verbleibend",
	specwarnAmberExplosionYou	= "Unterbreche DEINE %s!",--Struggle for Control interrupt.
	specwarnAmberExplosionAM	= "%s: Unterbreche %s!",--Amber Montrosity
	specwarnAmberExplosionOther	= "%s: Unterbreche %s!"--Mutated Construct
})

L:SetTimerLocalization({
	timerDestabalize			= "Destabilisieren (%2$d) : %1$s",
	timerAmberExplosionAMCD		= "Explosion CD: Monstrosität"
})

L:SetOptionLocalization({
	warnReshapeLifeTutor		= "Zeige Überblick über den Zweck der Fähigkeiten Mutierter Konstrukte",
	warnAmberExplosion			= "Zeige Warnung (mit Quelle), wenn $spell:122398 gewirkt wird",
	warnAmberExplosionAM		= "Zeige persönliche Warnung, wenn Bernmonstrosität $spell:122398 wirkt\n(zum Unterbrechen)",
	warnInterruptsAvailable		= "Verkünde bei wem Bernstoß-Unterbrechungen für $spell:122402\nverfügbar sind",
	warnWillPower				= "Verkünde aktuellen Willen bei 80, 50, 30, 10 und 4",
	specwarnWillPower			= "Spezialwarnung bei geringem Willen als Mutiertes Konstrukt",
	specwarnAmberExplosionYou	= "Spezialwarnung zum Unterbrechen deiner eigenen $spell:122398",
	specwarnAmberExplosionAM	= "Spezialwarnung zum Unterbrechen der $spell:122402\nder Bernmonstrosität",
	specwarnAmberExplosionOther	= "Spezialwarnung zum Unterbrechen der $spell:122398\nunkontrollierter Mutierter Konstrukte",
	timerAmberExplosionAMCD		= "Zeige Zeit bis nächste $spell:122402 der Bernmonstrosität",
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
	warnAmberTrap		= "Bernfallenbau: %d/5",
})

L:SetOptionLocalization({
	warnAmberTrap		= "Verkünde den Fortschritt beim Bau einer $spell:125826",
	InfoFrame			= "Zeige Infofenster für Spieler, welche von $spell:125390 betroffen sind",
	RangeFrame			= "Zeige Abstandsfenster (5m) für $spell:123735"
})

L:SetMiscLocalization({
	PlayerDebuffs		= "Fixiert",
	YellPhase3			= "KEINE AUSREDEN MEHR, KAISERIN! Tötet diese Idioten oder ich selbst mache Euch den Garaus!"
})
