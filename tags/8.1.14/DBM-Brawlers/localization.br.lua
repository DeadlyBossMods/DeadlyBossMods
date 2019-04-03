--Last update by GlitterStorm @ Azralon on Feb,22th,2015
if GetLocale() ~= "ptBR" then return end

local L

--------------
-- Brawlers --
--------------
L= DBM:GetModLocalization("Brigões")

L:SetGeneralLocalization({
	name = "Brigões: Geral"
})

L:SetWarningLocalization({
	warnQueuePosition2	= "Você é %d na fila",
	specWarnYourNext	= "Você é o próximo!",
	specWarnYourTurn	= "É a sua vez!"
})

L:SetOptionLocalization({
	warnQueuePosition2	= "Anuncia a sua posição atual na fila toda vez que ouver mudança",
	specWarnYourNext	= "Exibe aviso especial quando você for o próximo",
	specWarnYourTurn	= "Exibe aviso especial quando for a sua vez",
	SpectatorMode		= "Exibe avisos/temporizadores quando estiver assistindo lutas<br/>(Pessoal 'Aviso especial' mensagens não serão exibidas aos espectadores)",
	SpeakOutQueue		= "Conta em voz alta quando o numero da fila atualizar"
})

L:SetMiscLocalization({
	Bizmo			= "Bizmo",--Alliance
	Bazzelflange	= "Chefe Brazaflange",--Horde
	--I wish there was a better way to do this....so much localizing. :(
	Rank1			= "Rank 1",
	Rank2			= "Rank 2",
	Rank3			= "Rank 3",
	Rank4			= "Rank 4",
	Rank5			= "Rank 5",
	Rank6			= "Rank 6",
	Rank7			= "Rank 7",
	Rank8			= "Rank 8",
	Rank9			= "Rank 9",
	Rank10			= "Rank 10",
	Proboskus		= "Oh céus... eu sinto muito, mas parece que você tera que lutar com Proboskus.",--Alliance
	Proboskus2		= "Ha ha ha! Que falta de sorte! É o Proboskus! Ahhh ha ha ha! Apostei vinte e cinco ouros que você morrera no fogo!"--Horde
})

------------
-- Rank 1 --
------------
L= DBM:GetModLocalization("BrawlRank1")

L:SetGeneralLocalization({
	name = "Brigões: Rank 1"
})

------------
-- Rank 2 --
------------
L= DBM:GetModLocalization("BrawlRank2")

L:SetGeneralLocalization({
	name = "Brigões: Rank 2"
})

L:SetOptionLocalization({
	SetIconOnBlat	= "Marca (caveira) no verdadeiro Blat"
})

------------
-- Rank 3 --
------------
L= DBM:GetModLocalization("BrawlRank3")

L:SetGeneralLocalization({
	name = "Brigões: Rank 3"
})

------------
-- Rank 4 --
------------
L= DBM:GetModLocalization("BrawlRank4")

L:SetGeneralLocalization({
	name = "Brigões: Rank 4"
})

L:SetOptionLocalization({
	SetIconOnDominika	= "Marca (caveira) na verdadeira Dominika, a ilusionista"
})

------------
-- Rank 5 --
------------
L= DBM:GetModLocalization("BrawlRank5")

L:SetGeneralLocalization({
	name = "Brigões: Rank 5"
})

------------
-- Rank 6 --
------------
L= DBM:GetModLocalization("BrawlRank6")

L:SetGeneralLocalization({
	name = "Brigões: Rank 6"
})

------------
-- Rank 7 --
------------
L= DBM:GetModLocalization("BrawlRank7")

L:SetGeneralLocalization({
	name = "Brigões: Rank 7"
})

------------
-- Rank 8 --
------------
L= DBM:GetModLocalization("BrawlRank8")

L:SetGeneralLocalization({
	name = "Brigões: Rank 8"
})

------------
-- Rank 9 --
------------
L= DBM:GetModLocalization("BrawlRank9")

L:SetGeneralLocalization({
	name = "Brigões: Rank 9"
})

-------------
-- Rares 1 --
-------------
L= DBM:GetModLocalization("BrawlLegacy")

L:SetGeneralLocalization({
	name = "Brigões: Desafios passados"
})

L:SetOptionLocalization({
	SpeakOutStrikes		= "Contar em voz alta o numero de ataques $spell:141190"
})

-------------
-- Rares 2 --
-------------
L= DBM:GetModLocalization("BrawlChallenges")

L:SetGeneralLocalization({
	name = "Brigões: Desafios especiais"
})

L:SetWarningLocalization({
	specWarnRPS			= "Use %s!"
})

L:SetOptionLocalization({
	ArrowOnBoxing		= "Exibir flecha DBM durante $spell:140868 e $spell:140862 e $spell:140886",
	specWarnRPS			= "Exibir aviso especial sobre o que usar para $spell:141206"
})

L:SetMiscLocalization({
	rock			= "Pedra",
	paper			= "Papel",
	scissors		= "Tesoura"
})