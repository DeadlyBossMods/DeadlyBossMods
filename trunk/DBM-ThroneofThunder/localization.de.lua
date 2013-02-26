if GetLocale() ~= "deDE" then return end
local L

--------------------------
-- Jin'rokh the Breaker --
--------------------------
L= DBM:GetModLocalization(827)

L:SetOptionLocalization({
	RangeFrame		= "Zeige Abstandsfenster (8m) für $spell:139997"
})

--------------
-- Horridon --
--------------
L= DBM:GetModLocalization(819)

L:SetTimerLocalization({
	timerDoor		= "Nächstes Stammesportal"
})

L:SetOptionLocalization({
	timerDoor		= "Zeige Zeit bis nächste Stammesportalphase"
})

L:SetMiscLocalization({
	newForces		= "stürmen aus dem Stammesportal", --needs to be verified (PTR video-captured translation)
	chargeTarget	= "schlägt mit dem Schwanz auf den Boden!" --needs to be verified (PTR video-captured translation)
})

---------------------------
-- The Council of Elders --
---------------------------
L= DBM:GetModLocalization(816)

L:SetOptionLocalization({
	warnPossessed	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target:format(136442),
	warnSandBolt	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target:format(136189),
	RangeFrame		= "Zeige Abstandsfenster"
})

------------
-- Tortos --
------------
L= DBM:GetModLocalization(825)

L:SetWarningLocalization({
	specWarnCrystalShell	= "Hole %s"
})

L:SetOptionLocalization({
	specWarnCrystalShell	= "Zeige Spezialwarnung, falls dir der $spell:137633 Buff fehlt",
	InfoFrame				= "Zeige Infofenster für Spieler ohne $spell:137633"
})

L:SetMiscLocalization({
	WrongDebuff		= "Kein %s"
})

-------------
-- Megaera --
-------------
L= DBM:GetModLocalization(821)

L:SetMiscLocalization({
	rampageEnds	= "Megaeras Wut lässt nach." --needs to be verified (PTR screenshot-captured translation)
})

------------
-- Ji-Kun --
------------
L= DBM:GetModLocalization(828)

L:SetWarningLocalization({
	warnFlock		= "%s %s (%d)",
	specWarnFlock	= "%s %s (%d)"
})

L:SetOptionLocalization({
	warnFlock		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.count:format("ej7348"),
	specWarnFlock	= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switch:format("ej7348")
})

L:SetMiscLocalization({
	eggsHatchL		= "Die Eier in den unteren Nestern beginnen zu schlüpfen!", --needs to be verified (PTR video-captured translation)
	eggsHatchU		= "Die Eier in den oberen Nestern beginnen zu schlüpfen!", --needs to be verified (guessed)
	Upper			= "Obere",
	Lower			= "Untere",
	UpperAndLower	= "Obere & Untere"
})

--------------------------
-- Durumu the Forgotten --
--------------------------
L= DBM:GetModLocalization(818)

L:SetWarningLocalization({
	specWarnDisintegrationBeam	= "%s (%s)"
})

L:SetOptionLocalization({
	specWarnDisintegrationBeam	= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format(133775)
})

----------------
-- Primordius --
----------------
L= DBM:GetModLocalization(820)

L:SetOptionLocalization({
	RangeFrame		= "Zeige Abstandsfenster (5m/2m)"
})

-----------------
-- Dark Animus --
-----------------
L= DBM:GetModLocalization(824)

L:SetWarningLocalization({
	warnMatterSwapped	= "%s: >%s< und >%s< getauscht"
})

L:SetOptionLocalization({
	warnMatterSwapped	= "Verkünde getauschte Ziele durch $spell:138618"
})

L:SetMiscLocalization({
	Pull		= "Die Kugel explodiert!" --needs to be verified (PTR video-captured translation)
})

--------------
-- Iron Qon --
--------------
L= DBM:GetModLocalization(817)

L:SetWarningLocalization({
	warnDeadZone	= "%s: %s und %s abgeschirmt"
})

L:SetOptionLocalization({
	warnDeadZone	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(137229),
	RangeFrame		= "Zeige dynamisches Abstandsfenster\n(mit Indikator für zuviele Spieler in Reichweite)"
})

-------------------
-- Twin Consorts --
-------------------
L= DBM:GetModLocalization(829)

L:SetOptionLocalization({
	RangeFrame		= "Zeige Abstandsfenster (8m)"
})

--------------
-- Lei Shen --
--------------
L= DBM:GetModLocalization(832)

L:SetOptionLocalization({
	RangeFrame		= "Zeige Abstandsfenster"
})

------------
-- Ra-den --
------------
L= DBM:GetModLocalization(831)

