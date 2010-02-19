if GetLocale() ~= "deDE" then return end

local L

--------------------------
--  General BG Options  --
--------------------------
L = DBM:GetModLocalization("Battlegrounds")

L:SetGeneralLocalization({
	name = "Allgemeine Optionen"
})

L:SetTimerLocalization({
	TimerInvite = "%s"
})

L:SetOptionLocalization({
	ColorByClass	= "Einfärbung der Spielernamen in der Schlachtfeld-Punktetafel",
	ShowInviteTimer	= "Zeige Zeit für Schlachtfeld-Beitrittsmöglichkeit",
	AutoSpirit	= "Automatisch Geist freilassen"
})

L:SetMiscLocalization({
	ArenaInvite	= "Arena-Einladung"
})

--------------
--  Arenas  --
--------------
L = DBM:GetModLocalization("Arenas")

L:SetGeneralLocalization({
	name = "Arenas"
})

L:SetTimerLocalization({
	TimerStart	= "Spiel startet in",
	TimerShadow	= "Schattensicht"
})

L:SetOptionLocalization({
	TimerStart	= "Zeige Starttimer",
	TimerShadow = "Zeige Timer für Schattensicht"
})

L:SetMiscLocalization({
	Start60 = "Noch eine Minute bis der Arenakampf beginnt!",
	Start30 = "Noch dreißig Sekunden bis der Arenakampf beginnt!",
	Start15 = "Noch fünfzehn Sekunden bis der Arenakampf beginnt!"
})

----------------------
--  Alterac Valley  --
----------------------
L = DBM:GetModLocalization("AlteracValley")

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
	TimerStart  = "Zeige Starttimer",
	TimerTower = "Zeige Turmzerstörungstimer",
	TimerGY = "Zeige Friedhoferoberungstimer",
	AutoTurnIn = "Automatisches Abgeben der Quests im Alteractal"
})

--------------------
--  Arathi Basin  --
--------------------
L = DBM:GetModLocalization("ArathiBasin")

L:SetGeneralLocalization({
	name = "Arathibecken"
})

L:SetMiscLocalization({
	BgStart60 = "Die Schlacht um das Arathibecken beginnt in 1 Minute.",
	BgStart30 = "Die Schlacht um das Arathibecken beginnt in 30 Sekunden.",
	ZoneName = "Arathibecken",
	ScoreExpr = "(%d+)/1600",
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
	TimerStart  = "Zeige Starttimer",
	TimerWin = "Zeige Siegtimer",
	TimerCap = "Zeige Eroberungstimer",
	ShowAbEstimatedPoints = "Zeige geschätzte Kampf-Endpunkte",
	ShowAbBasesToWin = "Zeige benötigte Anzahl an Punkten zum Sieg"
})

------------------------
--  Eye of the Storm  --
------------------------
L = DBM:GetModLocalization("EyeoftheStorm")

L:SetGeneralLocalization({
	name = "Auge des Sturms"
})

L:SetMiscLocalization({
	BgStart60 = "Die Schlacht beginnt in 1 Minute!",
	BgStart30 = "Die Schlacht beginnt in 30 Sekunden!",
	ZoneName = "Auge des Sturms",
	ScoreExpr = "(%d+)/1600",
	Alliance = "Allianz",
	Horde = "Horde",
	WinBarText = "%s gewinnt",
	FlagReset = "Die Flagge wurde zurückgesetzt.",
	FlagTaken = "(.+) hat die Flagge erobert%.",
	FlagCaptured = "Die %w+ hat die F%w+ erobert!",
	FlagDropped = "Die F%w+ wurde fallengelassen."

})

L:SetTimerLocalization({
	TimerStart = "Spiel startet in", 
	TimerFlag = "Flaggenrespawn"
})

L:SetOptionLocalization({
	TimerStart  = "Zeige Starttimer",
	TimerWin = "Zeige Siegtimer",
	TimerFlag = "Zeige Timer für Flaggen-Respawn",
	ShowPointFrame = "Zeige Flaggenträger und geschätzten Endpunktestand"
})

---------------------
--  Warsong Gulch  --
---------------------
L = DBM:GetModLocalization("WarsongGulch")

L:SetGeneralLocalization({
	name = "Kriegshymnenschlucht"
})

L:SetMiscLocalization({
	BgStart60 = "Der Kampf um die Kriegshymnenschlucht beginnt in 1 Minute.",
	BgStart30 = "Der Kampf um die Kriegshymnenschlucht beginnt in 30 Sekunden. Haltet Euch bereit!",
	ZoneName = "Kriegshymnenschlucht",
	Alliance = "Allianz",
	Horde = "Horde",	
	InfoErrorText = "Die Zielauswahlfunktion für den Flaggenträger wird bei Kampfende wiederhergestellt.",
	ExprFlagPickUp = "(.*) hat die Flagge der (%w+) aufgenommen!",
	ExprFlagCaptured = "(.+) hat die Flagge der (%w+) errungen!",
	ExprFlagReturn = "Die Flagge der (%w+) wurde von (.+) zu ihrem Stützpunkt zurückgebracht!",
	FlagAlliance = "Allianz-Flagge: ",
	FlagHorde = "Horde-Flagge: ",
	FlagBase = "Basis"
})

L:SetTimerLocalization({
	TimerStart = "Spiel startet in", 
	TimerFlag = "Flaggen-Respawn"
})

L:SetOptionLocalization({
	TimerStart  = "Zeige Starttimer",
	TimerFlag = "Zeige Timer für Flaggen-Respawn",
	ShowFlagCarrier = "Zeige Flaggenträger",
	ShowFlagCarrierErrorNote = "Zeige Fehlermeldung wenn Flaggenträger-Zielauswahl nicht gesetzt werden kann"
})

----------------------------------
--  Archavon the Stone Watcher  --
----------------------------------
L = DBM:GetModLocalization("Archavon")

L:SetGeneralLocalization({
	name = "Archavon der Steinwächter"
})

L:SetWarningLocalization({
	WarningGrab	= "Archavon greift nach >%s<"
})

L:SetTimerLocalization({
	ArchavonEnrage	= "Archavon-Berserker"
})

L:SetMiscLocalization({
	TankSwitch	= "%%s stürzt sich auf (%S+)!"	-- to be checked
})

L:SetOptionLocalization({
	WarningGrab		= "Verkünde Griffziele",
	ArchavonEnrage	= "Zeige Timer für $spell:26662"
})

--------------------------------
--  Emalon the Storm Watcher  --
--------------------------------
L = DBM:GetModLocalization("Emalon")

L:SetGeneralLocalization{
	name = "Emalon der Sturmwächter"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
	timerMobOvercharge	= "Überladungsexplosion",
	EmalonEnrage		= "Emalon-Berserker"
}

L:SetOptionLocalization{
	NovaSound			= "Spiele Sound bei $spell:65279",
	timerMobOvercharge	= "Zeige Timer für Überladen (stapelnder Debuff)",
	EmalonEnrage		= "Zeige Timer für $spell:26662",
	RangeFrame			= "Zeige Abstandsfenster (10 m)"
}

---------------------------------
--  Koralon the Flame Watcher  --
---------------------------------
L = DBM:GetModLocalization("Koralon")

L:SetGeneralLocalization{
	name = "Koralon der Flammenwächter"
}

L:SetWarningLocalization{
	BurningFury		= "Brennender Atem >%d<"
}

L:SetTimerLocalization{
	KoralonEnrage	= "Koralon-Berserker"
}

L:SetOptionLocalization{
	PlaySoundOnCinder	= "Spiele Sound wenn du von $spell:67332 betroffen bist",
	BurningFury			= "Zeige Warnung für $spell:66721",
	KoralonEnrage		= "Zeige Timer für $spell:26662"
}

L:SetMiscLocalization{
	Meteor	= "%s wirkt Meteorfäuste!"
}

-------------------------------
--  Toravon the Ice Watcher  --
-------------------------------
L = DBM:GetModLocalization("Toravon")

L:SetGeneralLocalization{
	name = "Toravon der Eiswächter"
}

L:SetWarningLocalization{
	Frostbite	= "Erfrierung auf >%s< (%d)"
}

L:SetTimerLocalization{
	ToravonEnrage	= "Toravon-Berserker"
}

L:SetOptionLocalization{
	Frostbite	= "Zeige Warnung für $spell:72098",
}

L:SetMiscLocalization{
	ToravonEnrage	= "Zeige Timer für Berserker"
}

------------------------
--  Isle of Conquest  --
------------------------
L = DBM:GetModLocalization("IsleofConquest")

L:SetGeneralLocalization({
	name = "Insel der Eroberung"
})

L:SetWarningLocalization({
	WarnSiegeEngine		= "Belagerungsmaschine",
	WarnSiegeEngineSoon	= "Belagerungsmaschine in ~10 Sekunden",
})

L:SetTimerLocalization({
	TimerStart		= "Spiel startet in", 
	TimerPOI		= "%s",
	TimerSiegeEngine	= "Belagerungsmaschine"
})

L:SetOptionLocalization({
	TimerStart		= "Zeige Starttimer", 
	TimerPOI		= "Zeige Timer für Eroberungen",
	TimerSiegeEngine	= "Zeige Timer für Belagerungsmaschine",
	WarnSiegeEngine		= "Zeige Warnung wenn Belagerungsmaschine bereit ist",
	WarnSiegeEngineSoon	= "Zeige Warnung wenn Belagerungsmaschine fast bereit ist"
})

L:SetMiscLocalization({
	ZoneName		= "Insel der Eroberung",
	BgStart60		= "Die Schlacht beginnt in 60 Sekunden.",
	BgStart30		= "Die Schlacht beginnt in 30 Sekunden.",
	BgStart15		= "Die Schlacht beginnt in 15 Sekunden.",
	SiegeEngine		= "Belagerungsmaschine",
	GoblinStartAlliance	= "Seht Ihr diese Zephyriumbomben? Benutzt sie an den Toren, während ich die Belagerungsmaschine repariere!",
	GoblinStartHorde	= "Ich arbeite an der Belagerungsmaschine. Haltet mir einfach nur den Rücken frei. Benutzt diese Zephyriumbomben an den Toren, solltet Ihr sie brauchen!",
	GoblinHalfwayAlliance	= "Ich hab's gleich! Haltet die Horde von hier fern. Kämpfen stand in der Ingenieursschule nicht auf dem Lehrplan!",
	GoblinHalfwayHorde	= "Ich hab's gleich! Haltet mir die Allianz vom Leib. Kämpfen steht nicht in meinem Vertrag!",
	GoblinFinishedAlliance	= "Meine beste Arbeit bisher! Diese Belagerungsmaschine ist bereit, ein bisschen Aktion zu sehen!",
	GoblinFinishedHorde	= "Die Belagerungsmaschine ist bereit, loszurollen!",
	GoblinBrokenAlliance	= "Es ist schon kaputt?! Ach, keine Sorge, nichts, was ich nicht reparieren kann.",
	GoblinBrokenHorde	= "Schon wieder kaputt?! Ich werde es richten... Ihr solltet allerdings nicht davon ausgehen, dass das noch unter die Garantie fällt."
})

