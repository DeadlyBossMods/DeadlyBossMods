if GetLocale() ~= "deDE" then return end
local L

--------------
-- Brawlers --
--------------
L= DBM:GetModLocalization("Brawlers")

L:SetGeneralLocalization({
	name = "Kampfgilde: Einstellungen"
})

L:SetWarningLocalization({
	specWarnYourTurn	= "Du bist dran!"
})

L:SetOptionLocalization({
	specWarnYourTurn	= "Zeige Spezialwarnung, wenn es dein Kampf ist",
	SpectatorMode		= "Zeige Warnungen/Timer auch beim Zuschauen fremder Kämpfe"
})

L:SetMiscLocalization({
--	Bizmo			= "Bizmo",
	--I wish there was a better way to do this....so much localizing. :(
--	Rank			= "Rang (%d+)",
--	EnteringArena1	= "Und jetzt in der Arena",
--	EnteringArena2	= "Hier kommt der Herausforderer",
--	EnteringArena3	= "Achtung... hier kommt",
--	EnteringArena4	= "Applaus für",
	Rank1			= "ersten Ranges",
	Rank2			= "zweiten Ranges",
	Rank3			= "dritten Ranges",
	Rank4			= "vierten Ranges",
	Rank5			= "fünften Ranges",
	Rank6			= "sechsten Ranges",
	Rank7			= "siebten Ranges",
	Rank8			= "achten Ranges",
	Victory1		= "hat gewonnen",
	Victory2		= "Glückwunsch",
	Victory3		= "prächtiger Sieg",
	Victory4		= "gewinnt",
	Victory5		= "Macht weiter so",
	Victory6		= "hat es geschafft, nicht zu sterben",
	Lost1			= "Habt Ihr Euch überhaupt angestrengt",
	Lost2			= "Könntet Ihr jetzt wohl bitte Eure Leiche aus dem Weg räumen",
	Lost3			= "So viel Blut! Herrlich",
	Lost4			= "Stellt Euch wieder an und versucht's erneut",
	Lost5			= "Wo gehobelt wird, fallen auch Späne",
	Lost6			= "versucht doch bitte, nicht so häufig zu sterben",
	Lost7			= "das sieht nicht so schön aus",
	Lost8			= "Name war",
	Lost9			= "hat kein gutes Ende gefunden"
})

------------
-- Rank 1 --
------------
L= DBM:GetModLocalization("BrawlRank1")

L:SetGeneralLocalization({
	name = "Kampfgilde: Rang 1"
})

------------
-- Rank 2 --
------------
L= DBM:GetModLocalization("BrawlRank2")

L:SetGeneralLocalization({
	name = "Kampfgilde: Rang 2"
})

------------
-- Rank 3 --
------------
L= DBM:GetModLocalization("BrawlRank3")

L:SetGeneralLocalization({
	name = "Kampfgilde: Rang 3"
})

------------
-- Rank 4 --
------------
L= DBM:GetModLocalization("BrawlRank4")

L:SetGeneralLocalization({
	name = "Kampfgilde: Rang 4"
})

------------
-- Rank 5 --
------------
L= DBM:GetModLocalization("BrawlRank5")

L:SetGeneralLocalization({
	name = "Kampfgilde: Rang 5"
})

------------
-- Rank 6 --
------------
L= DBM:GetModLocalization("BrawlRank6")

L:SetGeneralLocalization({
	name = "Kampfgilde: Rang 6"
})

------------
-- Rank 7 --
------------
L= DBM:GetModLocalization("BrawlRank7")

L:SetGeneralLocalization({
	name = "Kampfgilde: Rang 7"
})

------------
-- Rank 8 --
------------
L= DBM:GetModLocalization("BrawlRank8")

L:SetGeneralLocalization({
	name = "Kampfgilde: Rang 8"
})
