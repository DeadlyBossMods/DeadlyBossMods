if GetLocale() ~= "deDE" then return end
local L

------------
-- Protectors of the Endless --
------------
L= DBM:GetModLocalization(683)

L:SetWarningLocalization({
	warnGroupOrder		= "Neue Gruppe für Verderbte Essenz: %s",
	specWarnYourGroup	= "Deine Gruppe ist dran!"
})

L:SetOptionLocalization({
	warnGroupOrder		= "Verkünde Gruppenrotation für $spell:118191<br/>(unterstützt derzeit nur 25-Spieler, Strategie: 5222 1222 1222 1222 1111)",
	specWarnYourGroup	= "Spezialwarnung, wenn deine Gruppe bei $spell:118191 dran ist (unterstützt derzeit nur 25-Spieler, siehe oben)",
	RangeFrame			= DBM_CORE_AUTO_RANGE_OPTION_TEXT:format(8, 111850) .. "<br/>(zeigt jeden, falls du den Debuff hast; sonst nur betroffene Spieler)"
})

------------
-- Tsulong --
------------
L= DBM:GetModLocalization(742)

L:SetMiscLocalization{
	Victory	= "Ich danke Euch, Fremdlinge. Ich wurde befreit."
}

-------------------------------
-- Lei Shi --
-------------------------------
L= DBM:GetModLocalization(729)

L:SetWarningLocalization({
	warnHideOver			= "%s ist beendet"
})

L:SetTimerLocalization({
	timerSpecialCD			= "Spezialfähigkeiten CD (%d)"
})

L:SetOptionLocalization({
	warnHideOver			= "Zeige Warnung, wenn $spell:123244 beendet ist",
	timerSpecialCD			= "Abklingzeit der Spezialfähigkeiten anzeigen",
	SetIconOnProtector		= "Setze Zeichen auf $journal:6224 (nicht zuverlässig falls mehr als ein Spieler mit Leiter-/Assistentenstatus diese Einstellung aktiviert)",
	RangeFrame				= DBM_CORE_AUTO_RANGE_OPTION_TEXT:format(3, 123121) .. "<br/>(zeigt jeden während $spell:123244, sonst nur die Tanks)",
	GWHealthFrame			= "Zeige in Lebensanzeige den benötigten Schaden bis $spell:123461 endet<br/>(benötigt aktivierte Lebensanzeige)"
})

L:SetMiscLocalization{
	Victory	= "Ich... ah... oh! Hab ich...? War ich...? Es war... so... trüb."
}

----------------------
-- Sha of Fear --
----------------------
L= DBM:GetModLocalization(709)

L:SetWarningLocalization({
	MoveWarningForward			= "Lauf durch",
	MoveWarningRight			= "Lauf nach rechts",
	MoveWarningBack				= "Lauf in alte Position",
	specWarnBreathOfFearSoon	= "Odem der Furcht bald - LAUFE in die Lichtmauer!"
})

L:SetTimerLocalization({
	timerSpecialAbilityCD		= "Nächste Spezialfähigkeit",
	timerSpoHudCD				= "Angst/Fontäne CD", -- Furchterfülltes Kauern / Wasserfontäne
	timerSpoStrCD				= "Fontäne/Stoß CD", -- Wasserfontäne / Unerbittlicher Stoß
	timerHudStrCD				= "Angst/Stoß CD" -- Furchterfülltes Kauern / Stoß
})

L:SetOptionLocalization({
	warnBreathOnPlatform		= "Zeige Warnung für $spell:119414, falls du auf einem der äußeren Schreine bist (nicht allgemein empfohlen, gedacht für Schlachtzugsleiter)",
	specWarnBreathOfFearSoon	= "Spezialvorwarn. für $spell:119414, falls dir der $spell:117964 Buff fehlt",
	specWarnMovement			= "Spezialwarnung zum Laufen bei $spell:120047 (auf den Link klicken um ihn zu kopieren: <a href=\"http://mysticalos.com/terraceofendlesssprings.jpg\">|cff3588ffhttp://mysticalos.com/terraceofendlesssprings.jpg|r</a>)",
	timerSpecialAbility			= "Zeige Zeit bis nächste Spezialfähigkeit gewirkt wird"
})
