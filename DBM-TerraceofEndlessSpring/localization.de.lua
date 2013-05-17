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
	warnGroupOrder		= "Verkünde Gruppenrotation für $spell:118191\n(unterstützt derzeit nur 25-Spieler, Strategie: 5222 1222 1222 1222 1111)",
	specWarnYourGroup	= "Spezialwarnung, wenn deine Gruppe bei $spell:118191 dran ist\n(unterstützt derzeit nur 25-Spieler, siehe oben)",
	RangeFrame			= "Zeige Abstandsfenster (8m) für $spell:111850\n(zeigt jeden, falls du den Debuff hast; sonst nur betroffene Spieler)"
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
	SetIconOnProtector		= "Setze Zeichen auf $journal:6224 (nicht zuverlässig falls mehr als\nein Spieler mit Leiter-/Assistentenstatus diese Einstellung aktiviert)",
	RangeFrame				= "Zeige Abstandsfenster (3m) für $spell:123121\n(zeigt jeden während $spell:123244, sonst nur die Tanks)",
	GWHealthFrame			= "Zeige in Lebensanzeige den benötigten Schaden bis $spell:123461 endet\n(benötigt aktivierte Lebensanzeige)"
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
	warnBreathOnPlatform		= "Zeige Warnung für $spell:119414, falls du auf einem der äußeren Schreine\nbist (nicht allgemein empfohlen, gedacht für Schlachtzugsleiter)",
	specWarnBreathOfFearSoon	= "Spezialvorwarn. für $spell:119414, falls dir der $spell:117964 Buff fehlt",
	specWarnMovement			= "Spezialwarnung zum Laufen bei $spell:120047\n(http://mysticalos.com/terraceofendlesssprings.jpg)",
	timerSpecialAbility			= "Zeige Zeit bis nächste Spezialfähigkeit gewirkt wird",
	RangeFrame					= "Zeige Abstandsfenster (2m) für $spell:119519"
})
