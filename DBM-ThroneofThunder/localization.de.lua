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
	specWarnWaterMove	= "Spezialwarnung, falls du in $spell:138470 stehst (warnt bevor $spell:137313 gewirkt wird und kurz bevor $spell:138732 ausläuft)"
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
	specWarnOrbofControl	= "Spezialwarnung beim Fallenlassen einer $journal:7092",
	timerDoor				= "Zeige Zeit bis nächste Stammestorphase",
	timerAdds				= "Zeige Zeit bis der nächste Gegner herunterspringt",
	SetIconOnAdds			= "Setze Zeichen auf Balkongegner"
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
	PHealthFrame		= "Zeige in Lebensanzeige den benötigten Schaden bis $spell:136442 endet<br/>(benötigt aktivierte Lebensanzeige)",
	AnnounceCooldowns	= "Zähle akustisch die Anzahl der $spell:137166 Wirkungen<br/>(für \"Raid-Cooldowns\")"
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
	specWarnCrystalShell	= "Spezialwarnung, falls dir der $spell:137633 Buff fehlt",
	InfoFrame				= "Zeige Infofenster für Spieler ohne $spell:137633<br/>mit mehr als 90% Lebenspunkten",
	SetIconOnTurtles		= "Setze Zeichen auf $journal:7129",
	ClearIconOnTurtles		= "Entferne Zeichen von $journal:7129 im Zustand $spell:133971",
	AnnounceCooldowns		= "Zähle akustisch die Anzahl der $spell:134920 Wirkungen<br/>(für \"Raid-Cooldowns\")"
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
	timerBreaths			= "Zeige Zeit bis nächster Atem<br/>($spell:139843 / $spell:137731 / $spell:139840 / $spell:139993)",
	AnnounceCooldowns		= "Zähle akustisch die Anzahl der \"Toben\"-Wirkungen (für \"Raid-Cooldowns\")",
	Never					= "Nie",
	Every					= "Jede (fortlaufende Zählung)",
	EveryTwo				= "Jede (zyklisch bis 2)",
	EveryThree				= "Jede (zyklisch bis 3)",
	EveryTwoExcludeDiff		= "Ohne Diffusion (zyklisch bis 2)",
	EveryThreeExcludeDiff	= "Ohne Diffusion (zyklisch bis 3)"
})

L:SetMiscLocalization({
	rampageEnds	= "Megaeras Wut lässt nach."
})

------------
-- Ji-Kun --
------------
L= DBM:GetModLocalization(828)

L:SetWarningLocalization({
	warnFlock			= "%s - %s %s",
	specWarnFlock		= "%s - %s %s",
	specWarnBigBird		= "Nestwächter: %s",
	specWarnBigBirdSoon	= "Nestwächter bald: %s"
})

L:SetTimerLocalization({
	timerFlockCD	= "Nest (%d): %s"
})

L:SetOptionLocalization({
	ShowNestArrows		= "Zeige DBM-Pfeil für Nestaktivierung",
	Never				= "Nie",
	Northeast			= "Blau - Unten NO & Oben NO",
	Southeast			= "Grün - Unten SO & Oben SO",
	Southwest			= "Violett/Rot - Unten SW & Oben SW/Mitte (25er/10er)",
	West				= "Rot - Unten W & Oben Mitte (nur 25er)",
	Northwest			= "Gelb - Unten NW & Oben NW (nur 25er)",
	Guardians			= "Nestwächter"
})

L:SetMiscLocalization({
	eggsHatchL		= "Die Eier in einem der unteren Nester beginnen, aufzubrechen!",
	eggsHatchU		= "Die Eier in einem der oberen Nester beginnen, aufzubrechen!",
	Upper			= "Oben",
	Lower			= "Unten",
	UpperAndLower	= "Oben & Unten",
	TrippleD		= "Dreifach (2xUnten)",
	TrippleU		= "Dreifach (2xOben)",
	NorthEast		= "|cff0000ffNO|r",
	SouthEast		= "|cFF088A08SO|r",
	SouthWest		= "|cFF9932CDSW|r",
	West			= "|cffff0000W|r",
	NorthWest		= "|cffffff00NW|r",
	Middle10		= "|cFF9932CDMitte|r",
	Middle25		= "|cffff0000Mitte|r"
})

--------------------------
-- Durumu the Forgotten --
--------------------------
L= DBM:GetModLocalization(818)

L:SetWarningLocalization({
	warnBeamNormal				= "Strahlen - |cffff0000Rot|r : >%s<, |cff0000ffBlau|r : >%s<",
	warnBeamHeroic				= "Strahlen - |cffff0000Rot|r : >%s<, |cff0000ffBlau|r : >%s<, |cffffff00Gelb|r : >%s<",
	warnAddsLeft				= "Nebel verbleibend: %d",
	specWarnBlueBeam			= "Blaue Strahlen auf dir - Bleib möglichst stehen",
	specWarnFogRevealed			= "%s offenbart!",
	specWarnDisintegrationBeam	= "%s (%s)"
})

L:SetOptionLocalization({
	warnBeam					= "Verkünde Ziele der Farbstrahlen",
	warnAddsLeft				= "Verkünde die Anzahl der verbleibenden Nebel",
	specWarnFogRevealed			= "Spezialwarnung, wenn ein Nebel offenbart wird",
	ArrowOnBeam					= "Zeige DBM-Pfeil während $journal:6882 zur Anzeige der Ausweichrichtung",
	InfoFrame					= "Zeige Infofenster für $spell:133795 Stapel",
	SetParticle					= "Grafikeinstellung 'Partikeldichte' automatisch auf 'Niedrig' setzen\n(wird nach dem Kampfende auf die vorherige Einstellung zurückgesetzt)"
})

L:SetMiscLocalization({
	LifeYell		= "Lebensentzug auf %s (%d)"
})

----------------
-- Primordius --
----------------
L= DBM:GetModLocalization(820)

L:SetWarningLocalization({
	warnDebuffCount				= "Mutationen: %d/5 gute, %d schlechte",
})

L:SetOptionLocalization({
	warnDebuffCount				= "Zeige Warnung für die Debuffanzahl, wenn du Pfützen absorbierst",
	SetIconOnBigOoze			= "Setze Zeichen auf $journal:6969"
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
	Pull		= "Die Kugel explodiert!"
})

--------------
-- Iron Qon --
--------------
L= DBM:GetModLocalization(817)

L:SetWarningLocalization({
	warnDeadZone	= "%s: %s und %s abgeschirmt"
})

L:SetOptionLocalization({
	RangeFrame				= "Zeige dynamisches Abstandsfenster (10m)\n(mit Indikator für zuviele Spieler in Reichweite)",
	InfoFrame				= "Zeige Infofenster für Spieler mit $spell:136193"
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
	timerDuskCD		= "Nächste Dämmerungsphase"
})

L:SetMiscLocalization({
	DuskPhase		= "Lu'lin, leiht mir Eure Kraft!"
})

--------------
-- Lei Shen --
--------------
L= DBM:GetModLocalization(832)

L:SetWarningLocalization({
	specWarnIntermissionSoon	= "Unterbrechung bald",
	warnDiffusionChainSpread	= "%s gesprungen auf >%s<"
})

L:SetTimerLocalization({
	timerConduitCD				= "Erste Leitung CD"
})

L:SetOptionLocalization({
	specWarnIntermissionSoon	= "Spezialvorwarnung für Unterbrechung",
	warnDiffusionChainSpread	= "Verkünde Sprungziele von $spell:135991",
	timerConduitCD				= "Abklingzeit der Fähigkeit der ersten Leitung anzeigen",
	StaticShockArrow			= "Zeige DBM-Pfeil, wenn jemand von $spell:135695 betroffen ist",
	OverchargeArrow				= "Zeige DBM-Pfeil, wenn jemand von $spell:136295 betroffen ist"
})

L:SetMiscLocalization({
	StaticYell		= "Elektroschock auf %s (%d)"
})

------------
-- Ra-den --
------------
L= DBM:GetModLocalization(831)

L:SetWarningLocalization({
	specWarnVitaSoaker			= "Du bist als nächstes Vitaziel eingeteilt!",
	warnVitaSoakerSoon			= "Du bist als übernächstes Vitaziel eingeteilt."
})

L:SetOptionLocalization({
	warnVitaSoakerSoon	= "Zeige Warnung, wenn du als übernächstes Ziel für $spell:138297 eingeteilt bist (benötigt aktiviertes Infofenster)",
	specWarnVitaSoaker	= "Spezialwarnung, wenn du als nächstes Ziel für $spell:138297 eingeteilt bist, basierend auf deiner Position im Infofenster (benötigt aktiviertes Infofenster)",
	SetIconsOnVita		= "Setze Zeichen auf den Spieler mit dem Debuff $spell:138297 und den am weitesten davon entfernten Spieler",
	InfoFrame			= "Zeige Infofenster für eine automatische Einteilung der Reihenfolge der Spieler ohne $spell:138372 (ausgenommen Tanks) als Ziel für $spell:138297",
	AnnounceVitaSoaker	= "Verkünde nächstes eingeteiltes Ziel für $spell:138297 als Schlachtzugwarnung (nur als Leiter)"
})

L:SetMiscLocalization({
	Defeat						= "Wartet! Ich bin... Ich bin nicht Euer Feind.",--needs to be verified (video-captured translation)
	NoSensitivity				= "Reihenfolge Vitaziele",
	VitaSoakerOptionConflict	= "Achtung: Du hast die Warnungen für die Einteilung als nächstes bzw. übernächstes Ziel von Instabile Vita aktiviert, aber das Infofenster deaktiviert. Die Warnungen werden ohne das Infofenster nicht funktionieren!",
	VitaChatMessage				= "Nächstes Vitaziel: %s"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("ToTTrash")

L:SetGeneralLocalization({
	name =	"Trash des Thron des Donners"
})
