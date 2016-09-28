if GetLocale() ~= "deDE" then return end
local L

---------------
-- Nythendra --
---------------
L= DBM:GetModLocalization(1703)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

---------------------------
-- Il'gynoth, Heart of Corruption --
---------------------------
L= DBM:GetModLocalization(1738)

L:SetOptionLocalization({
	InfoFrameBehavior	= "Auswahl der Information im Infofenster während des Kampfes",
	Fixates				= "Zeige Spieler, die von Fixieren betroffen sind",
	Adds				= "Zeige Zähler für alle Add-Arten"
})

---------------------------
-- Elerethe Renferal --
---------------------------
L= DBM:GetModLocalization(1744)

---------------------------
-- Ursoc --
---------------------------
L= DBM:GetModLocalization(1667)

L:SetOptionLocalization({
	NoAutoSoaking2		= "Deaktiviere alle automatischen Abfangwarnungen/-pfeile/-HudMaps für Fokussierter Blick"
})

L:SetMiscLocalization({
	SoakersText		=	"Abfänger zugewiesen: %s"
})

---------------------------
-- Dragons of Nightmare --
---------------------------
L= DBM:GetModLocalization(1704)

------------------
-- Cenarius --
------------------
L= DBM:GetModLocalization(1750)

L:SetMiscLocalization({
	BrambleMessage		= "Hinweis: DBM kann nicht erkennen, wer tatsächlich von Stachelschwarm FIXIERT wird. Es wird stattdessen angezeigt, bei welchem Ziel er anfänglich ERSCHEINT. Der Boss wählt einen Spieler und wirft den Schwarm auf ihn. Danach wählt der Schwarm ein ANDERES Ziel, welches Mods nicht erkennen können."
})

------------------
-- Xavius --
------------------
L= DBM:GetModLocalization(1726)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("EmeraldNightmareTrash")

L:SetGeneralLocalization({
	name =	"Trash des Smaragdgrünen Alptraums"
})
