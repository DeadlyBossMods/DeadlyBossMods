--Last update by GlitterStorm @ Azralon on Feb,21th,2015

if GetLocale() ~= "ptBR" then return end

local L

------------
--  Omen  --
------------
L = DBM:GetModLocalization("Omen")

L:SetGeneralLocalization({
	name = "Omen"
})

-----------------------
--  Apothecary Trio  --
-----------------------
L = DBM:GetModLocalization("d288")

L:SetTimerLocalization{
	HummelActive		= "Humberto se ativa",
	BaxterActive		= "Balduíno se ativa",
	FryeActive			= "Frias se ativa"
}

L:SetOptionLocalization({
	TrioActiveTimer		= "Exibir cronógrafos para quando o Apothecary Trio tornar-se ativo"
})

L:SetMiscLocalization({
	SayCombatStart		= "Eles se deram ao trabalho de lhe dizer quem eu sou e por que estou fazendo isso?"
})

-------------
--  Ahune  --
-------------
L = DBM:GetModLocalization("d286")

L:SetWarningLocalization({
	Emerged			= "Ahune Emergiu",
	specWarnAttack	= "Ahune está vulnerável - Ataque agora!"
})

L:SetTimerLocalization{
	SubmergeTimer	        = "Submergir",
	EmergeTimer		= "Emergir"
}


L:SetOptionLocalization({
	Emerged			= "Exibir aviso quando Ahune emergir",
	specWarnAttack	= "Exibir aviso especial quando Ahune tornar-se vulnerável",
	SubmergeTimer	= "Exibir cronógrafo para submergir",
	EmergeTimer		= "Exibir cronógrafo para emergir"
})

L:SetMiscLocalization({
	Pull			= "A pedra de gelo derreteu!"
})

----------------------
--  Coren Direbrew  --
----------------------
L = DBM:GetModLocalization("d287")

L:SetWarningLocalization({
	specWarnBrew		= "Livre-se da bebida antes que ela te jogue outra!",
	specWarnBrewStun	= "DICA: Você foi atordoado, lembre-se de beber da próxima vez!"
})

L:SetOptionLocalization({
	specWarnBrew		= "Exibir aviso especial para $spell:47376",
	specWarnBrewStun	= "Exibir aviso especial para $spell:47340"
})

L:SetMiscLocalization({
	YellBarrel			= "Barril em mim!"
})

-------------------------
--  Headless Horseman  --
-------------------------
L = DBM:GetModLocalization("d285")

L:SetWarningLocalization({
	WarnPhase				= "Fase %d",
	warnHorsemanSoldiers	= "Abóboras Pulsantes surgindo",
	warnHorsemanHead		= "Cabeça do Cavaleiro ativa"
})

L:SetOptionLocalization({
	WarnPhase				= "Exibir aviso para cada mudança de fase",
	warnHorsemanSoldiers	= "Exibir aviso para surgimento de Abóboras Pulsantes",
	warnHorsemanHead		= "Exibir aviso para surgimento da Cabeça do Cavaleiro"
})

L:SetMiscLocalization({
	HorsemanSummon			= "Cavaleiro ascende...",
	HorsemanSoldiers		= "Soldados levantem-se, fiquem e lutem! Tragam finalmente à vitória para este cavaleiro caido!"
})

------------------------------
--  The Abominable Greench  --
------------------------------
L = DBM:GetModLocalization("Greench")

L:SetGeneralLocalization({
	name = "O Greench abominável"
})

--------------------------
--  Plants Vs. Zombies  --
--------------------------
L = DBM:GetModLocalization("PlantsVsZombies")

L:SetGeneralLocalization({
	name = "Plantas Vs. Zumbis"
})

L:SetWarningLocalization({
	warnTotalAdds	= "Total zumbis gerados desde a última Onda Massiva: %d",
	specWarnWave	= "Onda Massiva!"
})

L:SetTimerLocalization{
	timerWave		= "Próxima Onda Massiva"
}

L:SetOptionLocalization({
	warnTotalAdds	= "Anuncia a contagem total de adds gerados entre cada onda massiva",
	specWarnWave	= "Mostra aviso especial quando uma onda massiva começar",
	timerWave		= "Mostra contador para próxima onda massiva"
})

L:SetMiscLocalization({
	MassiveWave		= "Uma onda Massiva de Zumbis está se aproximando!"
})

--------------------------
--  Memories of Azeroth: Burning Crusade  --
--------------------------
L = DBM:GetModLocalization("BCEvent")

L:SetGeneralLocalization({
	name = "MoA: Burning Crusade"
})

--------------------------
--  Memories of Azeroth: Wrath of the Lich King  --
--------------------------
L = DBM:GetModLocalization("WrathEvent")

L:SetGeneralLocalization({
	name = "MoA: WotLK"
})

L:SetMiscLocalization{
	Emerge				= "emerges from the ground!",
	Burrow				= "burrows into the ground!"
}

--------------------------
--  Memories of Azeroth: Cataclysm  --
--------------------------
L = DBM:GetModLocalization("CataEvent")

L:SetGeneralLocalization({
	name = "MoA: Cataclysm"
})

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
	name = "Galeria de tiro"
})

L:SetOptionLocalization({
	SetBubbles			= "Desabilita automaticamente balões de fala durante $spell:101871<br/>(Voltando ao normal ao fim da partida)"
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
	specWarnCallPack		= "Convocar a matilha - Corra > 40 metros do Presa Lunar!",
	specWarnMoonfangCurse	= "Maldição do Presa Lunar - Corra > 10 metros do Presa Lunar!"
})
