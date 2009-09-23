if GetLocale() ~= "deDE" then return end

local L

----------------------------
--  General BG functions  --
----------------------------
L = DBM:GetModLocalization("Battlegrounds")

L:SetGeneralLocalization({
	name = "Allgemeine SF Funktionen"
})

L:SetTimerLocalization({
	TimerInvite = "%s"
})

L:SetOptionLocalization({
	ColorByClass	= "Einfärbung der Spielernamen in der Schlachtfeld-Punktetafel",
	ShowInviteTimer	= "Zeige Zeit für Schlachtfeld Beitrittsmöglichkeit",
	AutoSpirit	= "Automatisch Geist freilassen"
})


--------------
--  Arenas  --
--------------
L = DBM:GetModLocalization("Arenas")

L:SetGeneralLocalization({
	name = "Arena"
})

L:SetTimerLocalization({
	TimerStart	= "Spiel startet in",
})

L:SetOptionLocalization({
	TimerStart = "Zeite Startzeit an"
})

L:SetMiscLocalization({
	Start60 = "Noch eine Minute bis der Arenakampf beginnt!",
	Start30 = "Noch dreißig Sekunden bis der Arenakampf beginnt!",
	Start15 = "Noch fünfzehn Sekunden bis der Arenakampf beginnt!"
})

---------------
--  Alterac  --
---------------
L = DBM:GetModLocalization("Alterac")

L:SetGeneralLocalization({
	name = "Alteractal"
})

L:SetTimerLocalization({
	TimerStart = "Spiel startet in", 
	TimerTower = "%s",
	TimerGY = "%s",
})

L:SetMiscLocalization({
	BgStart60 = "Der Kampf um das Alteractal beginnt in 1 Minute.",
	BgStart30 = "Der Kampf um das Alteractal beginnt in 30 Sekunden.",
	ZoneName = "Alteractal",
})

L:SetOptionLocalization({
	TimerStart  = "Zeige Startzeit an",
	TimerTower = "Zeige Turmzerstörungs Zeiten",
	TimerGY = "Zeige Friedhof Eroberungszeiten",
	AutoTurnIn = "Automatisches abgeben der Quests im Alterac Tal"
})

---------------
--  Arathi  --
---------------
L = DBM:GetModLocalization("Arathi")

L:SetGeneralLocalization({
	name = "Arathibecken"
})

L:SetMiscLocalization({
	BgStart60 = "Die Schlacht um das Arathibecken wird in 1 Minute beginnen.",
	BgStart30 = "Die Schlacht um das Arathibecken wird in 30 Sekunden beginnen.",
	ZoneName = "Arathibecken",
	ScoreExpr = "(%d+)/2000",
	Alliance = "Allianz",
	Horde = "Horde",
	WinBarText = "%s gewinnt",
	BasesToWin = "Punkte nötig um zu gewinnen: %d",
	Flag = "Flagge"
})

L:SetTimerLocalization({
	TimerStart = "Spiel startet in", 
	TimerCap = "%s",
})

L:SetOptionLocalization({
	TimerStart  = "Zeige Startzeit an",
	TimerWin = "Zeige Siegzeiten an",
	TimerCap = "Zeige Eroberungszeit an",
	ShowAbEstimatedPoints = "Zeige geschätzte Kampf-Endpunkte",
	ShowAbBasesToWin = "Zeige benötigte Anzahl an Punkten zum Sieg"
})

-----------------------
--  Eye of the Storm --
-----------------------
L = DBM:GetModLocalization("EyeOfTheStorm")

L:SetGeneralLocalization({
	name = "Auge des Sturms"
})

L:SetMiscLocalization({
	BgStart60 = "Die Schlacht beginnt in 1 Minute!",
	BgStart30 = "Die Schlacht beginnt in 30 Sekunden!",
	ZoneName = "Auge des Sturms",
	ScoreExpr = "(%d+)/2000",
	Alliance = "Alliance",
	Horde = "Horde",
	WinBarText = "%s wins",
	FlagReset = "Die Flagge wurde zurückgesetzt.",
	FlagTaken = "(.+) hat die Flagge erobert%.",
	FlagCaptured = "Die %w+ hat die F%w+ erobert!",
	FlagDropped = "Die F%w+ wurde fallengelassen.",

})

L:SetTimerLocalization({
	TimerStart = "Spiel startet in", 
	TimerFlag = "Flaggen respawn",
})

L:SetOptionLocalization({
	TimerStart  = "Zeige Startzeit an",
	TimerWin = "Zeige Siegzeiten an",
	TimerFlag = "Zeige Flaggen Respawnzeit an",
	ShowPointFrame = "Zeige Flaggenträger und Entpunktestand",
})

--------------------
--  Warsong Gulch --
--------------------
L = DBM:GetModLocalization("Warsong")

L:SetGeneralLocalization({
	name = "Kriegshymnenschlucht"
})

L:SetMiscLocalization({
	BgStart60 = "Der Kampf um die Kriegshymnenschlucht beginnt in 1 Minute.",
	BgStart30 = "Der Kampf um die Kriegshymnenschlucht beginnt in 30 Sekunden. Haltet Euch bereit!",
	ZoneName = "Kriegshymnenschlucht",
	Alliance = "Allianz",
	Horde = "Horde",	
	InfoErrorText = "Die Zielauswahl funktion für den Flaggenträger wird bei Kampfende wiederhergestellt",
	ExprFlagPickUp = "(.*) hat die Flagge der (%w+) aufgenommen!",
	ExprFlagCaptured = "(.+) hat die Flagge der (%w+) errungen!",
	ExprFlagReturn = "Die Flagge der (%w+) wurde von (.+) zu ihrem Stützpunkt zurückgebracht!",
	FlagAlliance = "Allianz Flagge: ",
	FlagHorde = "Horde Flagge: ",
	FlagBase = "Basis",
})

L:SetTimerLocalization({
	TimerStart = "Spiel startet in", 
	TimerFlag = "Flaggen respawn",
})

L:SetOptionLocalization({
	TimerStart  = "Zeige Startzeit an",
	TimerWin = "Zeige Siegzeiten an",
	TimerFlag = "Zeige Flaggen Respawnzeit an",
	ShowFlagCarrier = "Zeige Flaggenträger",
	ShowFlagCarrierErrorNote = "Zeige Fehlermeldung wenn Flaggenträger Zielfunktion nicht gesetzt werden kann",
})



------------------------
--  Isle of Conquest  --
------------------------

L = DBM:GetModLocalization("IsleOfConquest")

L:SetGeneralLocalization({
	name = "Isle of Conquest"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	TimerStart		= "Game starts", 
	TimerPOI		= "%s",
})

L:SetOptionLocalization({
	TimerStart		= "Zeige Startzeit an", 
	TimerPOI		= "Zeige Zeit für Eroberungen",
})

L:SetMiscLocalization({
	ZoneName		= "Insel der Eroberung",
	BgStart60		= "Die Schlacht beginnt in 60 Sekunden.",
	BgStart30		= "Die Schlacht beginnt in 30 Sekunden.",
	BgStart15		= "Die Schlacht beginnt in 15 Sekunden.",
})




