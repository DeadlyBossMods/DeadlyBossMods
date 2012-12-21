-- Last update: 12/20/2012 (20/12/2012 in french format)
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
	SpectatorMode		= "Voir les alertes/délais lorsque vous êtes en mode spectateur"
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
--[[	Victory1		= "est notre",-- Good
	Victory2		= "Félicitations,",-- Good
	Victory3		= "Quelle magnifique victoire,",-- Good
	Victory4		= "remporte la victoire",-- Good
	Victory5		= "Continuez comme ça",-- Good
	Victory6		= "Bravo,",-- Good
	Victory7		= "Tellement de sang ! Joli",-- Good
	Lost1			= "Vous avez vraiment essayé",-- Good
	Lost2			= "Auriez-vous l’obligeance de bien vouloir enlever votre cadavre",-- Good
	Lost3			= "Retournez dans la file et retentez votre chance",-- Good
	Lost4			= "On ne fait pas d’omelette sans casser des œufs",-- Good
	Lost5			= "essayez de moins mourir",-- Good
	Lost6			= "quel carnage",-- Good
	Lost7			= "s’appelait",--LoL at fight club reference here
	Lost8			= "ne s’est pas très bien terminé",-- Good --]]
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

------------
-- Rank 4 --
------------
L= DBM:GetModLocalization("BrawlRank4")

L:SetGeneralLocalization({
	name = "Bastonneurs : Rang 4"
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
