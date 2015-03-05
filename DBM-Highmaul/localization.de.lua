if GetLocale() ~= "deDE" then return end
local L

---------------
-- Kargath Bladefist --
---------------
L= DBM:GetModLocalization(1128)

---------------------------
-- The Butcher --
---------------------------
L= DBM:GetModLocalization(971)

---------------------------
-- Tectus, the Living Mountain --
---------------------------
L= DBM:GetModLocalization(1195)

L:SetMiscLocalization({
	pillarSpawn	= "ERHEBT EUCH, BERGE!"
})

------------------
-- Brackenspore, Walker of the Deep --
------------------
L= DBM:GetModLocalization(1196)

L:SetOptionLocalization({
	InterruptCounter	= "Setze \"Verrottung\"-Zähler zurück nach",
	Two					= "zwei Wirkungen",
	Three				= "drei Wirkungen",
	Four				= "vier Wirkungen"
})

--------------
-- Twin Ogron --
--------------
L= DBM:GetModLocalization(1148)

L:SetOptionLocalization({
	PhemosSpecial	= "Spiele akustischen Countdown für Phemos' Spezialfähigkeiten",
	PolSpecial		= "Spiele akustischen Countdown für Pols Spezialfähigkeiten",
	PhemosSpecialVoice	= "Spiele gesprochene Warnungen für Phemos' Spezialfähigkeiten",
	PolSpecialVoice		= "Spiele gesprochene Warnungen für Pols Spezialfähigkeiten"
})

--------------------
--Koragh --
--------------------
L= DBM:GetModLocalization(1153)


L:SetWarningLocalization({
	specWarnExpelMagicFelFades	= "Teufelsenergie endet in 5s - geh zum Start"
})

L:SetOptionLocalization({
	specWarnExpelMagicFelFades	= "Spezialwarnung zum Hingehen zur Startposition, wenn $spell:172895 endet"
})

L:SetMiscLocalization({
	supressionTarget1	= "Ich werde Euch zermalmen!",
	supressionTarget2	= "Schweigt!",
	supressionTarget3	= "Ruhe!",
	supressionTarget4	= "Ich reiße Euch in Stücke!"
})

--------------------------
-- Imperator Mar'gok --
--------------------------
L= DBM:GetModLocalization(1197)

L:SetTimerLocalization({
	timerNightTwistedCD		= "Nächste Nachtsiechende Gläubiger"
})

L:SetOptionLocalization({
	GazeYellType		= "Typ des Schreis für Starren des Abgrunds",
	Countdown			= "Countdown bis zum Ablauf",
	Stacks				= "Stapelanzahl beim Erhalt",
	timerNightTwistedCD	= "Zeige Zeit bis nächste Nachtsiechende Gläubiger erscheinen"
})

L:SetMiscLocalization({
	BrandedYell			= "Gebrandmarkt (%d) %dm",
	GazeYell			= "Starren endet in %d",
	GazeYell2			= "Starren (%d) auf %s",
	PlayerDebuffs		= "Nächste zum Vorgeschmack"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("HighmaulTrash")

L:SetGeneralLocalization({
	name =	"Trash des Hochfels"
})
