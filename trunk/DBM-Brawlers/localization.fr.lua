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
	warnQueuePosition2	= "Vous êtes %d dans la file",
	specWarnYourNext	= "Vous êtes le prochain !",
	specWarnYourTurn	= "C'est à votre tour !"
})

L:SetOptionLocalization({
	warnQueuePosition2	= "Annoncer votre place dans la file à chaque changement",
	specWarnYourNext	= "Afficher une alerte spéciale quand vous êtes le prochain",
	specWarnYourTurn	= "Alerte spéciale quand c'est à vous de combattre",
	SpectatorMode		= "Voir les alertes/délais lorsque vous êtes en mode spectateur<br/>(Les \"Alerte spécial\" personnelle, ne sont pas affichées aux spectateurs)",
	SpeakOutQueue		= "Indiquer votre position dans la file à chaque changement"
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
	Proboskus		= "Bonté divine... Navré, mais on dirait quue vous allez devoir affronter Proboskus.",--Alliance
	Proboskus2		= "Ha ha ha ! Vous avez vraiment pas de chance ! C’est Proboskus ! Aaaah ha ha ha !! J’ai vingt-cinq pièces d’or qui disent que vous allez mourir dans les flammes !"--Horde
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

L:SetOptionLocalization({
	SetIconOnBlat	= "Met un symbole (crâne) sur le vrai Blat"
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

------------
-- Rank 9 --
------------
L= DBM:GetModLocalization("BrawlRank9")

L:SetGeneralLocalization({
	name = "Bastonneurs : Rang 9"
})

-------------
-- Rares 1 --
-------------
L= DBM:GetModLocalization("BrawlLegacy")

L:SetGeneralLocalization({
	name = "Bastonneurs : Défis Héritage"
})

L:SetOptionLocalization({
	SpeakOutStrikes		= "Compter le nombre de $spell:141190"
})

-------------
-- Rares 2 --
-------------
L= DBM:GetModLocalization("BrawlChallenges")

L:SetGeneralLocalization({
	name = "Bastonneurs : Défis Spéciaux"
})

L:SetWarningLocalization({
	specWarnRPS			= "Utilisez %s!"
})

L:SetOptionLocalization({
	ArrowOnBoxing		= "Afficher une flèche DBM pendant $spell:140868 et $spell:140862 et $spell:140886",
	specWarnRPS			= "Afficher une alerte spéciale pour faire le bon choix lors de $spell:141206"
})

L:SetMiscLocalization({
	rock			= "Pierre",
	paper			= "Papier",
	scissors		= "Ciseaux"
})
