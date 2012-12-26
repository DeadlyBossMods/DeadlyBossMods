-- Last update: 12/26/2012 (26/12/2012 in french format)
-- By Edoz (stephanelc35@msn.com)

if GetLocale() ~= "frFR" then return end
local L

--------------
-- Brawlers --
--------------
L= DBM:GetModLocalization("Brawlers")

L:SetGeneralLocalization({
	name = "Bastonneurs : Options"
})

L:SetWarningLocalization({
	specWarnYourTurn	= "C'est à votre tour !"
})

L:SetOptionLocalization({
	specWarnYourTurn	= "Alerte spéciale quand c'est à vous de combattre",
	SpectatorMode		= "Voir les alertes/délais lorsque vous êtes en mode spectateur\n(Les \"Alerte spécial\" personnelle, ne sont pas affichées aux spectateurs)"
})

L:SetMiscLocalization({
	Bizmo			= "Bizmo",--Alliance
	Bazzelflange	= "Chef Bazzelcol",--Horde
	--I wish there was a better way to do this....so much localizing. :(
	Rank1			= "rang 1",
	Rank2			= "rang 2",
	Rank3			= "rang 3",
	Rank4			= "rang 4",
	Rank5			= "rang 5",
	Rank6			= "rang 6",
	Rank7			= "rang 7",
	Rank8			= "rang 8",
	Proboskus		= "Oh dear... I'm sorry, but it looks like you're going to have to fight Proboskus."--This boss is only boss out of 32 that has a custom berserk, so we need a chat yell to detect when he specificly is pulled to adjust berserk timer
})

------------
-- Rank 1 --
------------
L= DBM:GetModLocalization("BrawlRank1")

L:SetGeneralLocalization({
	name = "Bastonneurs : Rang 1"
})

------------
-- Rank 2 --
------------
L= DBM:GetModLocalization("BrawlRank2")

L:SetGeneralLocalization({
	name = "Bastonneurs : Rang 2"
})

------------
-- Rank 3 --
------------
L= DBM:GetModLocalization("BrawlRank3")

L:SetGeneralLocalization({
	name = "Bastonneurs : Rang 3"
})

L:SetOptionLocalization({
	SetIconOnBlat	= "Met un symbole (crâne) sur le vrai Blat"
})

------------
-- Rank 4 --
------------
L= DBM:GetModLocalization("BrawlRank4")

L:SetGeneralLocalization({
	name = "Bastonneurs : Rang 4"
})

L:SetOptionLocalization({
	SetIconOnDominika	= "Met un symbole (crâne) sur la vrai Dominika l’illusionniste"
})
------------
-- Rank 5 --
------------
L= DBM:GetModLocalization("BrawlRank5")

L:SetGeneralLocalization({
	name = "Bastonneurs : Rang 5"
})

------------
-- Rank 6 --
------------
L= DBM:GetModLocalization("BrawlRank6")

L:SetGeneralLocalization({
	name = "Bastonneurs : Rang 6"
})

------------
-- Rank 7 --
------------
L= DBM:GetModLocalization("BrawlRank7")

L:SetGeneralLocalization({
	name = "Bastonneurs : Rang 7"
})

------------
-- Rank 8 --
------------
L= DBM:GetModLocalization("BrawlRank8")

L:SetGeneralLocalization({
	name = "Bastonneurs : Rang 8"
})
