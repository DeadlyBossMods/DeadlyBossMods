if GetLocale() ~= "deDE" then return end
local L

---------------
-- Gruul --
---------------
L= DBM:GetModLocalization(1161)

L:SetOptionLocalization({
	MythicSoakBehavior	= "Strategie für Infernoschlitzer im mythischen Schwierigkeitsgrad (für Spezialwarnungen)",
	ThreeGroup			= "3 Gruppen (jede 1 Stapel)",
	TwoGroup			= "2 Gruppen (jede 2 Stapel)"
})

---------------------------
-- Oregorger, The Devourer --
---------------------------
L= DBM:GetModLocalization(1202)

---------------------------
-- The Blast Furnace --
---------------------------
L= DBM:GetModLocalization(1154)

L:SetWarningLocalization({
	warnRegulators			= "Hitzeregler verbleibend: %d",
	warnBlastFrequency		= "Flammenzunge Häufigkeit erhöht: ca. alle %d Sekunden",
	specWarnTwoVolatileFire	= "Doppeltes Flüchtiges Feuer auf dir!"
})

L:SetOptionLocalization({
	warnRegulators			= "Verkünde die Anzahl der verbleibenden Hitzeregler",
	warnBlastFrequency		= "Verkünde, wenn sich die $spell:155209 Häufigkeit erhöht",
	specWarnTwoVolatileFire	= "Spezialwarnung, wenn du $spell:176121 doppelt hast",
	InfoFrame				= "Zeige Infofenster für $spell:155192 und $spell:155196",
	VFYellType2				= "Typ des Schreis für Flüchtiges Feuer (nur mythischer Schwierigkeitsgrad)",
	Countdown				= "Countdown bis zum Ablauf",
	Apply					= "nur Erhalt"
})

L:SetMiscLocalization({
	heatRegulator		= "Hitzeregler",
	Regulator			= "Regler %d",
	bombNeeded			= "%d Bombe(n)"
})

------------------
-- Hans'gar And Franzok --
------------------
L= DBM:GetModLocalization(1155)

--------------
-- Flamebender Ka'graz --
--------------
L= DBM:GetModLocalization(1123)

--------------------
--Kromog, Legend of the Mountain --
--------------------
L= DBM:GetModLocalization(1162)

L:SetMiscLocalization({
	ExRTNotice		= "%s hat ExRT Positionszuweisungen für die Runen gesendet. Deine Position ist: %s"
})

--------------------------
-- Beastlord Darmac --
--------------------------
L= DBM:GetModLocalization(1122)

--------------------------
-- Operator Thogar --
--------------------------
L= DBM:GetModLocalization(1147)

L:SetWarningLocalization({
	specWarnSplitSoon	= "Schlachtzugteilung in 10"
})

L:SetOptionLocalization({
	specWarnSplitSoon	= "Spezialwarnung 10 Sekunden bevor sich der Schlachtzug teilt",
	InfoFrameSpeed		= "Infofenster zeigt nächste Zuginformation",
	Immediately			= "sobald sich die Türen für den aktuellen Zug öffnen",
	Delayed				= "nachdem der aktuelle Zug herausgekommen ist",
	HudMapUseIcons		= "Use raid Icons for HudMap instead of green circle",--translate
	TrainVoiceAnnounce	= "Set when spoken alerts will play for trains",--translate
	LanesOnly			= "Only announce incoming lanes",--translate
	MovementsOnly		= "Only announce lane movements (Mythic Only)",--translate
	LanesandMovements	= "Announce incoming lanes & movmeents (Mythic Only)"--translate
})

L:SetMiscLocalization({
	Train			= GetSpellInfo(174806),
	lane			= "Gleis",
	oneTrain		= "ein zufälliges Gleis: Zug",
	oneRandom		= "erscheinen auf einem zufälligen Gleis",
	threeTrains		= "drei zufällige Gleise: Zug",
	threeRandom		= "erscheinen auf drei zufälligen Gleisen",
	helperMessage	= "Dieser Kampf kann durch das Drittanbieter-Addon \"Thogar Assist\" oder einen der zahlreichen DBM-Sprachpacks (diese sagen die Züge akustisch an) erleichtert werden, verfügbar auf Curse."
})

--------------------------
-- The Iron Maidens --
--------------------------
L= DBM:GetModLocalization(1203)

L:SetWarningLocalization({
	specWarnReturnBase	= "Kehre zum Dock zurück!"
})

L:SetOptionLocalization({
	specWarnReturnBase	= "Spezialwarnung, wenn Spieler auf dem Schiff gefahrlos zum Dock zurückkehren können",
	filterBladeDash3	= "Keine Spezialwarnung für $spell:155794, wenn du von $spell:170395 betroffen bist",
	filterBloodRitual3	= "Keine Spezialwarnung für $spell:158078, wenn du von $spell:170405 betroffen bist"
})

L:SetMiscLocalization({
	shipMessage		= "bereitet sich darauf vor, die Hauptkanone des Schlachtschiffs zu bemannen!"
})

--------------------------
-- Blackhand --
--------------------------
L= DBM:GetModLocalization(959)

L:SetWarningLocalization({
	specWarnMFDPosition		= "Mark Position: %s",--translate
	specWarnSlagPosition	= "Bomb Position: %s"--translate
})

L:SetOptionLocalization({
	PositionsAllPhases	= "Give positions for $spell:156096 yells during all phases (Instead of just phase 3. This is mostly for testing and assurances, this option is not actually recommended)"--translate
})

L:SetMiscLocalization({
	customMFDSay	= "Marked %s on %s",--translate
	customSlagSay	= "Bomb %s on %s",--translate
	left			= "left",--translate
	middle			= "middle",--translate
	right			= "right"--translate
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("BlackrockFoundryTrash")

L:SetGeneralLocalization({
	name =	"Trash der Schwarzfelsgießerei"
})
