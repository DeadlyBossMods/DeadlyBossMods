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
	SpectatorMode		= "Zeige Warnungen/Timer auch beim Zuschauen fremder Kämpfe\n(persönliche Spezialwarnungsmeldungen werden nicht angezeigt)"
})

L:SetMiscLocalization({
	Bizmo			= "Bizmo",--Alliance
	Bazzelflange	= "Boss Nobelflansch",--Horde
	--I wish there was a better way to do this....so much localizing. :(
	Rank1			= "ersten Ranges",
	Rank2			= "zweiten Ranges",
	Rank3			= "dritten Ranges",
	Rank4			= "vierten Ranges",
	Rank5			= "fünften Ranges",
	Rank6			= "sechsten Ranges",
	Rank7			= "siebten Ranges",
	Rank8			= "achten Ranges",
	Rank9			= "neunten Ranges",--needs to be verified (guessed)
	Rank10			= "zehnten Ranges",--needs to be verified (guessed)
	Proboskus		= "Oje... tut mir leid, aber Ihr werdet wohl gegen Proboskus antreten müssen.",--Alliance - needs to be verified (wowhead-captured translation)
	Proboskus2		= "Ha ha ha! Was habt Ihr auch für ein Pech! Es ist Proboskus! Ahhh ha ha ha! Ich hab fünfundzwanzig Goldstücke darauf gesetzt, dass Ihr im Feuer draufgeht!"--Horde
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

L:SetOptionLocalization({
	SetIconOnBlat	= "Setze Zeichen auf echten \"Blat\" (Totenkopf)"
})

------------
-- Rank 4 --
------------
L= DBM:GetModLocalization("BrawlRank4")

L:SetGeneralLocalization({
	name = "Kampfgilde: Rang 4"
})

L:SetOptionLocalization({
	SetIconOnDominika	= "Setze Zeichen auf echte \"Dominika die Illusionistin\" (Totenkopf)"
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

------------
-- Rank 9 --
------------
L= DBM:GetModLocalization("BrawlRank9")

L:SetGeneralLocalization({
	name = "Kampfgilde: Rang 9"
})

-------------
-- Rares 1 --
-------------
L= DBM:GetModLocalization("BrawlRare1")

L:SetGeneralLocalization({
	name = "Kampfgilde: Seltene Gegner 1"
})

-------------
-- Rares 2 --
-------------
L= DBM:GetModLocalization("BrawlRare2")

L:SetGeneralLocalization({
	name = "Kampfgilde: Seltene Gegner 2"
})
