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
	SubmergTimer	        = "Submergir",
	EmergeTimer		= "Emergir"
}


L:SetOptionLocalization({
	Emerged			= "Exibir aviso quando Ahune emergir",
	specWarnAttack	= "Exibir aviso especial quando Ahune tornar-se vulnerável",
	SubmergTimer	= "Exibir cronógrafo para submergir",
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
	specWarnBrewStun	= "Exibir aviso especial para $spell:47340",
	YellOnBarrel		= "Gritar em $spell:51413"
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
--  Garrison Invasions  --
--------------------------
L = DBM:GetModLocalization("GarrisonInvasions")

L:SetGeneralLocalization({
	name = "Invasão das guarnições"
})

L:SetWarningLocalization({
	specWarnRylak	= "Catador Alanegra esta vindo",
	specWarnWorker	= "Trabalhador aterrorizado em perigo",
	specWarnSpy		= "Um espião infiltrou-se em",
	specWarnBuilding= "Uma construção esta sendo atacada"
})

L:SetOptionLocalization({
	specWarnRylak	= "Mostra aviso especial quando um Catador Alanegra estiver vindo",
	specWarnWorker	= "Mostra aviso especial quando um trabalhador aterrorizado estiver em perigo",
	specWarnSpy		= "Mostra aviso especial quando um espião infiltrar-se",
	specWarnBuilding= "Mostra aviso especial quando uma construção estiver sendo atacada"
})

L:SetMiscLocalization({
	--General
	preCombat			= "Às armas! para os seus postos!",--Comum em todos os gritos, restante varia de acordo com a invasão
	preCombat2			= "O céu se escureceu abruptamente...",--Conselho das sombras não segue o formato das outras :\
	rylakSpawn			= "A comoção da batalha atraiu um Catador Alanegra!",--origem pnj Catador Alanegra, alvo nomejogador
	terrifiedWorker		= "Trabalhador aterrorizado em perigo!",
	sneakySpy			= "espião se infiltrou em meio ao caos!",--encurtado para ajustar "horde/alliance"
	buildingAttack		= "A %s esta sob ataque!",--Seu ferro-velho esta sob ataque!
	--Ogre
	GorianwarCaller		= "Um Belarauto Goriano juntou-se a batalha e levantou o moral!",--Talvez combinado "add" aviso especial maioria dos adds?
	WildfireElemental	= "Um Elemental do Fogo Indômito esta sendo convocado no portão frontal!",--Talvez combinado "add" aviso especial maioria dos adds?
	--Iron Horde
	Assassin			= "Um assassino esta caçando seus guardas!"--Talvez combinado "add" aviso especial maioria dos adds??
})