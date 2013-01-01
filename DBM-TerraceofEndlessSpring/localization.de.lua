if GetLocale() ~= "deDE" then return end
local L

------------
-- Protectors of the Endless --
------------
L= DBM:GetModLocalization(683)

L:SetOptionLocalization({
	RangeFrame			= "Zeige Abstandsfenster (8m) für $spell:111850\n(zeigt jeden, falls du den Debuff hast; sonst nur betroffene Spieler)",
	SetIconOnPrison		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(117436)
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
	warnHideOver			= "%s ist beendet",
	warnHideProgress		= "Treffer: %s. Schaden: %s. Dauer: %s"
})

L:SetTimerLocalization({
	timerSpecialCD			= "Spezialfähigkeiten CD (%d)"
})

L:SetOptionLocalization({
	warnHideOver			= "Zeige Warnung, wenn $spell:123244 beendet ist",
	warnHideProgress		= "Zeige Statistiken für $spell:123244, wenn es beendet ist",
	timerSpecialCD			= "Abklingzeit der Spezialfähigkeiten anzeigen",
	SetIconOnGuard			= "Setze Zeichen auf $journal:6224",
	RangeFrame				= "Zeige Abstandsfenster (3m) für $spell:123121\n(zeigt jeden während $spell:123244, sonst nur die Tanks)",
	GWHealthFrame			= "Zeige Lebensanzeige für den benötigten Schaden bis $spell:123461 endet\n(benötigt aktivierte Lebensanzeige)"
})

L:SetMiscLocalization{
	Victory	= "Ich... ah... oh! Hab ich...? War ich...? Es war... so... trüb."
}


----------------------
-- Sha of Fear --
----------------------
L= DBM:GetModLocalization(709)

L:SetWarningLocalization({
	specWarnBreathOfFearSoon	= "Odem der Furcht bald - LAUFE in die Lichtmauer!",
})

L:SetOptionLocalization({
	specWarnBreathOfFearSoon	= "Zeige Spezialvorwarn. für $spell:119414, falls dir der $spell:117964 Buff fehlt",
})

L:SetOptionLocalization({
	RangeFrame			= "Zeige Abstandsfenster (2m) für $spell:119519"
})
