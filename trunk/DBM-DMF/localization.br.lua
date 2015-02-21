-- Last update: 02/21/2015 (21/02/2015 in Brazilian Portuguese format)
-- Por GlitterStorm @ Azralon
if GetLocale() ~= "ptBR" then return end
local L
--------------------------
--  Blastenheimer 5000  --
--------------------------
L = DBM:GetModLocalization("Cannon")
L:SetGeneralLocalization({
 name = "Blastenheimer 5000 Ultra Cannon"
})
-------------
--  Gnoll  --
-------------
L = DBM:GetModLocalization("Gnoll")
L:SetGeneralLocalization({
 name = "Pancada-no-Gnoll"
})
L:SetWarningLocalization({
 warnGameOverQuest = "Você ganhou %d de um total de %d pontos possíveis",
 warnGameOverNoQuest = "Fim de jogo com um total de %d pontos possíveis",
 warnGnoll   = "Gnoll apareceu",
 warnHogger   = "Hogger apareceu",
 specWarnHogger  = "Hogger apareceu!"
})
L:SetOptionLocalization({
 warnGameOver = "Anunciar total de pontos possíveis ao final da partida",
 warnGnoll  = "Anunciar quando um Gnoll aparecer",
 warnHogger  = "Anunciar quando um Hogger aparecer",
 specWarnHogger = "Exibir aviso especial quando um Hogger aparecer"
})
------------------------
--  Shooting Gallery  --
------------------------
L = DBM:GetModLocalization("Shot")
L:SetGeneralLocalization({
 name = "Galeria de tiro"
})
L:SetOptionLocalization({
 SetBubbles   = "Desabilita automaticamente balões de fala durante $spell:101871<br/>(Voltando ao normal ao fim da partida)"
})
----------------------
--  Tonk Challenge  --
----------------------
L = DBM:GetModLocalization("Tonks")
L:SetGeneralLocalization({
 name = "Comandante de Tonque"
})
---------------------------
--  Fire Ring Challenge  --
---------------------------
L = DBM:GetModLocalization("Rings")
L:SetGeneralLocalization({
 name = "Desafio da Ave Flamejante"
})
-----------------------
--  Darkmoon Rabbit  --
-----------------------
L = DBM:GetModLocalization("Rabbit")
L:SetGeneralLocalization({
 name = "Coelho de Negraluna"
})
-------------------------
--  Darkmoon Moonfang  --
-------------------------
L = DBM:GetModLocalization("Moonfang")
L:SetGeneralLocalization({
 name = "Presa Lunar"
})
L:SetWarningLocalization({
 specWarnCallPack  = "Convocar a matilha - Corra > 40 metros do Presa Lunar!",
 specWarnMoonfangCurse = "Maldição do Presa Lunar - Corra > 10 metros do Presa Lunar!"
})
L:SetOptionLocalization({
 specWarnCallPack  = DBM_CORE_AUTO_SPEC_WARN_OPTIONS.run:format(144602),
 specWarnMoonfangCurse = DBM_CORE_AUTO_SPEC_WARN_OPTIONS.run:format(144590)
})