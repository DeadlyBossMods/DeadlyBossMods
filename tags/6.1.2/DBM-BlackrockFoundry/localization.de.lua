if GetLocale() ~= "deDE" then return end
local L

---------------
-- Gruul --
---------------
L= DBM:GetModLocalization(1161)

---------------------------
-- Oregorger, The Devourer --
---------------------------
L= DBM:GetModLocalization(1202)

---------------------------
-- The Blast Furnace --
---------------------------
L= DBM:GetModLocalization(1154)

L:SetWarningLocalization({
	warnRegulators		= "Hitzeregler verbleibend: %d",
	warnBlastFrequency	= "Flammenzunge Häufigkeit erhöht: ca. alle %d Sekunden"
})

L:SetOptionLocalization({
	warnRegulators		= "Verkünde die Anzahl der verbleibenden Hitzeregler",
	warnBlastFrequency	= "Verkünde, wenn sich die $spell:155209 Häufigkeit erhöht",
	VFYellType			= "Typ des Schreis für Flüchtiges Feuer (nur mythischer Schwierigkeitsgrad)",
	Countdown			= "Countdown bis zum Ablauf",
	Apply				= "nur Erhalt"
})

L:SetMiscLocalization({
	heatRegulator		= "Hitzeregler"
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
	Delayed				= "nachdem der aktuelle Zug herausgekommen ist"
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
	specWarnReturnBase	= "Kehre JETZT zum Dock zurück!"
})

L:SetOptionLocalization({
	specWarnReturnBase	= "Spezialwarnung, wenn Spieler auf dem Schiff gefahrlos zum Dock zurückkehren können"
})
	
L:SetMiscLocalization({
	shipMessage		= "prepares to man the Dreadnaught's Main Cannon!"--translate (trigger)
})

--------------------------
-- Blackhand --
--------------------------
L= DBM:GetModLocalization(959)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("BlackrockFoundryTrash")

L:SetGeneralLocalization({
	name =	"Trash der Schwarzfelsgießerei"
})
