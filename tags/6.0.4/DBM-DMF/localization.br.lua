if GetLocale() ~= "ptBR" then return end

local L

--------------------------
--  Blastenheimer 5000  --
--------------------------
L = DBM:GetModLocalization("Cannon")

L:SetGeneralLocalization({
	name = "Blastenheimer 5000"
})

-------------
--  Gnoll  --
-------------
L = DBM:GetModLocalization("Gnoll")

L:SetGeneralLocalization({
	name = "Whack-a-Gnoll"
})

L:SetWarningLocalization({
	warnGameOverQuest	= "Você ganhou %d de um total de %d pontos possíveis",
	warnGameOverNoQuest	= "Fim de jogo com um total de %d pontos possíveis",
	warnGnoll			= "Gnoll apareceu",
	warnHogger			= "Hogger apareceu",
	specWarnHogger		= "Hogger apareceu!"
})

L:SetOptionLocalization({
	warnGameOver	= "Anunciar total de pontos possíveis ao final da partida",
	warnGnoll		= "Anunciar quando um Gnoll aparecer",
	warnHogger		= "Anunciar quando um Hogger aparecer",
	specWarnHogger	= "Exibir aviso especial quando um Hogger aparecer"
})

------------------------
--  Shooting Gallery  --
------------------------
L = DBM:GetModLocalization("Shot")

L:SetGeneralLocalization({
	name = "Shooting Gallery"
})

L:SetOptionLocalization({
	SetBubbles			= "Automaticamente desabilitar balões de fala durante $spell:101871<br/>(Voltando ao normal ao fim da partida)"
})

----------------------
--  Tonk Challenge  --
----------------------
L = DBM:GetModLocalization("Tonks")

L:SetGeneralLocalization({
	name = "Tonk Challenge"
})
