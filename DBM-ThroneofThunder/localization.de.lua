if GetLocale() ~= "deDE" then return end
local L

--------------------------
-- Jin'rokh the Breaker --
--------------------------
L= DBM:GetModLocalization(827)

L:SetWarningLocalization({
	specWarnWaterMove	= "%s bald - Raus aus dem leitfähigen Wasser!"
})

L:SetOptionLocalization({
	specWarnWaterMove	= "Zeige Spezialwarnung, falls du in $spell:138470 stehst (warnt bevor\n$spell:137313 gewirkt wird und kurz bevor $spell:138732 ausläuft)",
	RangeFrame			= "Zeige Abstandsfenster"
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
	timerAdds				= "Zeige Zeit bis der nächste Gegner herunterspringt",
	RangeFrame				= "Zeige Abstandsfenster (5m) für $spell:136480"
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
	PHealthFrame		= "Zeige in Lebensanzeige den benötigten Schaden bis $spell:136442 endet\n(benötigt aktivierte Lebensanzeige)",
	RangeFrame			= "Zeige Abstandsfenster"
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
	specWarnCrystalShell	= "Zeige Spezialwarnung, falls dir der $spell:137633 Buff fehlt",
	InfoFrame				= "Zeige Infofenster für Spieler ohne $spell:137633",
	SetIconOnTurtles		= "Setze Zeichen auf $journal:7129",
	ClearIconOnTurtles		= "Entferne Zeichen von $journal:7129 im Zustand $spell:133971"
})

L:SetMiscLocalization({
	WrongDebuff		= "Kein %s"
})

-------------
-- Megaera --
-------------
L= DBM:GetModLocalization(821)

L:SetTimerLocalization({
	timerBreathsCD			= "Nächster Atem"
})

L:SetOptionLocalization({
	timerBreaths			= "Zeige Zeit bis nächster Atem\n($spell:139843 / $spell:137731 / $spell:139840 / $spell:139993)",
})

L:SetMiscLocalization({
	rampageEnds	= "Megaeras Wut lässt nach."
})

------------
-- Ji-Kun --
------------
L= DBM:GetModLocalization(828)

L:SetWarningLocalization({
	warnFlock		= "%s - %s (%s)",
	specWarnFlock	= "%s - %s (%s)",
	specWarnBigBird	= "Nestwächter %s"
})

L:SetTimerLocalization({
	timerFlockCD	= "Nest (%d): %s"
})

L:SetOptionLocalization({
	RangeFrame		= "Zeige Abstandsfenster (10m) für $spell:138923"
})

L:SetMiscLocalization({
	eggsHatchL		= "Die Eier in einem der unteren Nester beginnen, aufzubrechen!",
	eggsHatchU		= "Die Eier in einem der oberen Nester beginnen, aufzubrechen!",
	Upper			= "Oben",
	Lower			= "Unten",
	UpperAndLower	= "Oben & Unten",
	TrippleD		= "Dreifach (2xUnten)",
	TrippleU		= "Dreifach (2xOben)",
	SouthWest		= "SW",
	SouthEast		= "SO",
	NorthWest		= "NW",
	NorthEast		= "NO",
	West			= "W",
	Middle			= "Mitte"
})

--------------------------
-- Durumu the Forgotten --
--------------------------
L= DBM:GetModLocalization(818)

L:SetWarningLocalization({
	warnBeamNormal				= "Strahlen - |cffff0000Rot|r : >%s<, |cff0000ffBlau|r : >%s<",
	warnBeamHeroic				= "Strahlen - |cffff0000Rot|r : >%s<, |cff0000ffBlau|r : >%s<, |cffffff00Gelb|r : >%s<",
	warnAddsLeft				= "Nebel verbleibend: %d",
	specWarnBlueBeam			= "Blaue Strahlen auf dir - BLEIB STEHEN!",
	specWarnFogRevealed			= "%s offenbart!",
	specWarnDisintegrationBeam	= "%s (%s)"
})

L:SetOptionLocalization({
	warnBeam					= "Verkünde Ziele der Farbstrahlen",
	warnAddsLeft				= "Verkünde die Anzahl der verbleibenden Nebel",
	specWarnFogRevealed			= "Zeige Spezialwarnung, wenn ein Nebel offenbart wird",
	ArrowOnBeam					= "Zeige DBM-Pfeil während $journal:6882 zur Anzeige der Ausweichrichtung",
	InfoFrame					= "Zeige Infofenster für $spell:133795 Stapel"
})

----------------
-- Primordius --
----------------
L= DBM:GetModLocalization(820)

L:SetWarningLocalization({
	warnDebuffCount				= "Zu viele Mutationen: %d gute, %d schlechte",
	specWarnFullyMutatedFaded	= "%s ist beendet"
})

L:SetOptionLocalization({
	warnDebuffCount				= "Zeige Warnung für die Debuffanzahl, wenn du zu viele Mutagenpfützen absorbierst",
	specWarnFullyMutatedFaded	= "Zeige Spezialwarnung, wenn $spell:140546 beendet ist",
	RangeFrame					= "Zeige Abstandsfenster (5m/2m)"
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
	DuskPhase		= "Lu'lin, leiht mir Eure Kraft!"--needs to be verified (wowhead-captured translation)
})

--------------
-- Lei Shen --
--------------
L= DBM:GetModLocalization(832)

L:SetOptionLocalization({
	RangeFrame			= "Zeige Abstandsfenster",
	StaticShockArrow	= "Zeige DBM-Pfeil, wenn jemand von $spell:135695 betroffen ist",
	OverchargeArrow		= "Zeige DBM-Pfeil, wenn jemand von $spell:136295 betroffen ist"
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
