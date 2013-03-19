if GetLocale() ~= "deDE" then return end
local L

--------------------------
-- Jin'rokh the Breaker --
--------------------------
L= DBM:GetModLocalization(827)

L:SetOptionLocalization({
	RangeFrame		= "Zeige Abstandsfenster"
})


--------------
-- Horridon --
--------------
L= DBM:GetModLocalization(819)

L:SetWarningLocalization({
	warnAdds				= "%s",
	warnOrbofControl		= "Kugel der Kontrolle fallen gelassen",
	specWarnOrbofControl	= "Kugel der Kontrolle fallen gelassen!"
})

L:SetTimerLocalization({
	timerDoor				= "Nächstes Stammestor",
	timerAdds				= "Nächster %s"
})

L:SetOptionLocalization({
	warnAdds				= "Verkünde das Herunterspringen neuer Gegner",
	warnOrbofControl		= "Verkünde das Fallenlassen einer $journal:7092",
	specWarnOrbofControl	= "Zeige Spezialwarnung beim Fallenlassen einer $journal:7092",
	timerDoor				= "Zeige Zeit bis nächste Stammestorphase",
	timerAdds				= "Zeige Zeit bis der nächste Gegner herunterspringt"
})

L:SetMiscLocalization({
	newForces				= "stürmen aus dem Stammestor",
	chargeTarget			= "schlägt mit dem Schwanz auf den Boden!"
})

---------------------------
-- The Council of Elders --
---------------------------
L= DBM:GetModLocalization(816)

L:SetWarningLocalization({
	specWarnPossessed		= "%s auf %s - Ziel wechseln"
})

L:SetOptionLocalization({
	warnPossessed		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target:format(136442),
	specWarnPossessed	= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switch:format(136442),
	warnSandBolt		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target:format(136189),
	PHealthFrame		= "Zeige in Lebensanzeige den benötigten Schaden bis $spell:136442 endet\n(benötigt aktivierte Lebensanzeige)",
	RangeFrame			= "Zeige Abstandsfenster",
	SetIconOnBitingCold	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(136992),
	SetIconOnFrostBite	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(136922)
})

------------
-- Tortos --
------------
L= DBM:GetModLocalization(825)

L:SetWarningLocalization({
	warnKickShell			= "%s genutzt von >%s< (%d verbleibend)",
	specWarnCrystalShell	= "Hole %s"
})

L:SetOptionLocalization({
	warnKickShell			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(134031),
	specWarnCrystalShell	= "Zeige Spezialwarnung, falls dir der $spell:137633 Buff fehlt",
	InfoFrame				= "Zeige Infofenster für Spieler ohne $spell:137633",
	SetIconOnTurtles		= "Setze Zeichen auf $journal:7129 (mglw. nicht zuverlässig falls mehr als\nein Spieler mit Leiter-/Assistentenstatus diese Einstellung aktiviert)",
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
	warnFlock		= "%s %s (%s)",
	specWarnFlock	= "%s %s (%s)"
})

L:SetTimerLocalization({
	timerFlockCD	= "Nest (%d): %s"
})

L:SetOptionLocalization({
	warnFlock		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.count:format("ej7348"),
	specWarnFlock	= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switch:format("ej7348"),
	timerFlockCD	= DBM_CORE_AUTO_TIMER_OPTIONS.nextcount:format("ej7348"),
	RangeFrame		= "Zeige Abstandsfenster (8m) für $spell:138923"
})

L:SetMiscLocalization({
	eggsHatchL		= "Die Eier in den unteren Nestern beginnen zu schlüpfen!", --needs to be verified (PTR video-captured translation), maybe "Die Eier in einem der unteren Nester beginnen, aufzubrechen!" instead
	eggsHatchU		= "Die Eier in den oberen Nestern beginnen zu schlüpfen!", --needs to be verified (guessed), maybe "Die Eier in einem der oberen Nester beginnen, aufzubrechen!" instead
	Upper			= "Obere",
	Lower			= "Untere",
	UpperAndLower	= "Obere & Untere"
})

--------------------------
-- Durumu the Forgotten --
--------------------------
L= DBM:GetModLocalization(818)

L:SetWarningLocalization({
	warnAddsLeft				= "Nebel verbleibend: %d",
	specWarnFogRevealed			= "%s offenbart!",
	specWarnDisintegrationBeam	= "%s (%s)"
})

L:SetOptionLocalization({
	warnAddsLeft				= "Verkünde die Anzahl der verbleibenden Nebel",
	specWarnFogRevealed			= "Zeige Spezialwarnung, wenn ein Nebel offenbart wird",
	specWarnDisintegrationBeam	= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format("ej6882"),
	ArrowOnBeam					= "Zeige DBM-Pfeil während $journal:6882 zur Anzeige der Ausweichrichtung",
	SetIconRays					= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format("ej6891")
})

L:SetMiscLocalization({
	Eye		= "Auge" --needs to be verified (guessed)
})

----------------
-- Primordius --
----------------
L= DBM:GetModLocalization(820)

L:SetOptionLocalization({
	RangeFrame			= "Zeige Abstandsfenster (5m/2m)"
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
	RangeFrame		= "Zeige dynamisches Abstandsfenster\n(mit Indikator für zuviele Spieler in Reichweite)",
	InfoFrame		= "Zeige Infofenster für Spieler mit $spell:136193"
})

-------------------
-- Twin Consorts --
-------------------
L= DBM:GetModLocalization(829)

L:SetWarningLocalization({
	warnNight		= "Nachtphase",
	warnDay			= "Tagphase",
	warnDusk		= "Dämmerungsphase"
})

L:SetTimerLocalization({
	timerDayCD		= "Nächste Tagphase",
	timerDuskCD		= "Nächste Dämmerungsphase",
})

L:SetOptionLocalization({
	warnNight		= "Verkünde Nachtphase",
	warnDay			= "Verkünde Tagphase",
	warnDusk		= "Verkünde Dämmerungsphase",
	timerDayCD		= "Zeige Zeit bis nächste Tagphase",
	timerDuskCD		= "Zeige Zeit bis nächste Dämmerungsphase",
	RangeFrame		= "Zeige Abstandsfenster (8m)"
})

L:SetMiscLocalization({
	DuskPhase		= "Lu'lin! Lend me your strength!"--translate (trigger)
})

--------------
-- Lei Shen --
--------------
L= DBM:GetModLocalization(832)

L:SetOptionLocalization({
	RangeFrame			= "Zeige Abstandsfenster",
	StaticShockArrow	= "Zeige DBM-Pfeil, wenn jemand von $spell:135695 betroffen ist",
	OverchargeArrow		= "Zeige DBM-Pfeil, wenn jemand von $spell:136295 betroffen ist",
	SetIconOnOvercharge	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(136295),
	SetIconOnStaticShock= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(135695)
})

------------
-- Ra-den --
------------
L= DBM:GetModLocalization(831)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("ToTTrash")

L:SetGeneralLocalization({
	name =	"Trash des Thron des Donners"
})

L:SetOptionLocalization({
	RangeFrame		= "Zeige Abstandsfenster (10m)"
})
