if GetLocale() ~= "deDE" then return end
local L

---------------
-- Immerseus --
---------------
L= DBM:GetModLocalization(852)

L:SetMiscLocalization({
	Victory			= "Ah, Ihr habt es geschafft! Das Wasser ist wieder rein."
})

---------------------------
-- The Fallen Protectors --
---------------------------
L= DBM:GetModLocalization(849)

L:SetWarningLocalization({
	warnCalamity		= "%s",
	specWarnCalamity	= "%s",
	specWarnMeasures	= "Verzweifelte Maßnahmen bald (%s)!"
})

---------------------------
-- Norushen --
---------------------------
L= DBM:GetModLocalization(866)

L:SetMiscLocalization({
	wasteOfTime			= "Nun gut, ich werde ein Feld erschaffen, das Eure Verderbnis eindämmt."
})

------------------
-- Sha of Pride --
------------------
L= DBM:GetModLocalization(867)

L:SetOptionLocalization({
	SetIconOnFragment	= "Setze Zeichen auf Verderbtes Fragment"
})

--------------
-- Galakras --
--------------
L= DBM:GetModLocalization(868)

L:SetWarningLocalization({
	warnTowerOpen		= "Turm offen",
	warnTowerGrunt		= "Turmgrunzer"
})

L:SetTimerLocalization({
	timerTowerCD		= "Nächster Turm",
	timerTowerGruntCD	= "Nächster Turmgrunzer"
})

L:SetOptionLocalization({
	warnTowerOpen		= "Verkünde, wenn ein Turm geöffnet wurde",
	warnTowerGrunt		= "Verkünde das Erscheinen eines Turmgrunzers",
	timerTowerCD		= "Zeige Zeit bis nächsten Turmangriff",
	timerTowerGruntCD	= "Zeige Zeit bis nächster Turmgrunzer erscheint"
})

L:SetMiscLocalization({
	wasteOfTime		= "Well done! Landing parties, form up! Footmen to the front!",--translate (alliance trigger)
	wasteOfTime2	= "Gute Arbeit. Die erste Kompanie ist an Land.",
	Pull			= "Drachenmalklan, nehmt den Hafen wieder ein und treibt sie ins Meer! Im Namen Höllschreis und der wahren Horde!",
	newForces1		= "Da kommen sie!",--needs to be verified (wowhead-captured translation) (alliance)
	newForces1H		= "Holt sie schnell vom Himmel, damit ich sie erwürgen kann.",
	newForces2		= "Drachenmalklan, ausrücken!",
	newForces3		= "Für Höllschrei!",
	newForces4		= "Nächster Trupp, vorwärts!",
	tower			= "Das Tor zum"--"Das Tor zum Nordturm ist durchbrochen!"/"Das Tor zum Südturm ist durchbrochen!"
})

--------------------
--Iron Juggernaut --
--------------------
L= DBM:GetModLocalization(864)

--------------------------
-- Kor'kron Dark Shaman --
--------------------------
L= DBM:GetModLocalization(856)

L:SetMiscLocalization({
	PrisonYell		= "Gefängnis auf %s schwindet (%d)"
})

---------------------
-- General Nazgrim --
---------------------
L= DBM:GetModLocalization(850)

L:SetWarningLocalization({
	warnDefensiveStanceSoon		= "Verteidigungshaltung in %ds"
})

L:SetOptionLocalization({
	warnDefensiveStanceSoon		= "Zeige Vorwarnungscountdown für $spell:143593 (5s zuvor)"
})

L:SetMiscLocalization({
	newForces1					= "Krieger, im Laufschritt!",
	newForces2					= "Verteidigt das Tor!",
	newForces3					= "Truppen, sammelt Euch!",
	newForces4					= "Kor'kron, zu mir!",
	newForces5					= "Nächste Staffel, nach vorn!",
	allForces					= "Alle Kor'kron unter meinem Befehl, tötet sie! Jetzt!",
	nextAdds					= "Nächste Adds: "
})

-----------------
-- Malkorok -----
-----------------
L= DBM:GetModLocalization(846)

------------------------
-- Spoils of Pandaria --
------------------------
L= DBM:GetModLocalization(870)

L:SetMiscLocalization({
	wasteOfTime		= "Hallo? Mikrofontest... 1, 2, 3 – ok. Goblinisch-titanisches Steuerungsmodul wird gestartet, bitte zurückbleiben.",
	Module1 		= "Modul 1 bereit für den Systemneustart.",
	Victory			= "Modul 2 bereit für den Systemneustart."
})

---------------------------
-- Thok the Bloodthirsty --
---------------------------
L= DBM:GetModLocalization(851)

L:SetOptionLocalization({
	RangeFrame	= "Zeige dynamisches Abstandsfenster (10m)<br/>(mit Indikator für den \"Blutrausch\"-Schwellwert)"
})

----------------------------
-- Siegecrafter Blackfuse --
----------------------------
L= DBM:GetModLocalization(865)

L:SetMiscLocalization({
	newWeapons	= "Unfertige Waffen werden auf das Fabrikationsband befördert.",
	newShredder	= "Ein automatisierter Schredder nähert sich!"
})

----------------------------
-- Paragons of the Klaxxi --
----------------------------
L= DBM:GetModLocalization(853)

L:SetWarningLocalization({
	specWarnActivatedVulnerable		= "%s wird dir erhöhten Schaden zufügen - Meiden!",
	specWarnMoreParasites			= "Es werden mehr Parasiten benötigt - NICHT blocken!"
})

L:SetOptionLocalization({
	specWarnActivatedVulnerable		= "Spezialwarnung, wenn dir ein neuer Getreuer erhöhten Schaden zufügen wird",
	specWarnMoreParasites			= "Spezialwarnung, wenn mehr Parasiten benötigt werden"
})

L:SetMiscLocalization({
	one					= "Eins",
	two					= "Zwei",
	three				= "Drei",
	four				= "Vier",--needs to be verified (guessed)
	five				= "Fünf",--needs to be verified (guessed)
	hisekFlavor			= "Na, wer wurde jetzt zum Schweigen gebracht?",
	KilrukFlavor		= "Ein weiterer Tag der Vernichtung des Schwarms!",
	XarilFlavor			= "I sehe nur finstere Himmel in deiner Zukunft!",
	KaztikFlavor		= "Zerkleinert zu bloßen Kunchong-Leckereien!",
	KaztikFlavor2		= "1 Mantis tot, nur noch 199 weitere verbleibend!",
	KorvenFlavor		= "Das Ende eines uralten Reiches!",
	KorvenFlavor2		= "Nimm deine Gurthanitafeln und ersticke daran!",
	IyyokukFlavor		= "Erkennt die Möglichkeiten. Nutzt sie aus!",
	KarozFlavor			= "Du wirst nicht mehr herumspringen!",
	SkeerFlavor			= "Ein blutiges Vergnügen!",
	RikkalFlavor		= "Probenanforderung abgeschlossen!"
})

------------------------
-- Garrosh Hellscream --
------------------------
L= DBM:GetModLocalization(869)

L:SetTimerLocalization({
	timerRoleplay		= GUILD_INTEREST_RP
})

L:SetOptionLocalization({
	timerRoleplay		= "Dauer des Garrosh/Thrall-Rollenspiels anzeigen",
	RangeFrame			= "Zeige dynamisches Abstandsfenster (8m)<br/>(mit Indikator für den $spell:147088 Schwellwert)",
	InfoFrame			= "Zeige Infofenster für Spieler ohne Schadensreduzierung während der Unterbrechungsphasen",
	yellMaliceFading	= "Schreie, wenn $spell:147209 bald ausläuft"
})

L:SetMiscLocalization({
	wasteOfTime			= "Es ist noch nicht zu spät, Garrosh. Legt den Mantel des Kriegshäuptlings ab. Wir können dies hier beenden, jetzt, ohne Blutvergießen.",
	NoReduce			= "Keine Schadensreduzierung",
	MaliceFadeYell		= "Bösartigkeit schwindet auf %s (%d)",
	phase3End			= "You think you have WON?" --translate (trigger)
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("SoOTrash")

L:SetGeneralLocalization({
	name =	"Trash der Schlacht um Orgrimmar"
})
