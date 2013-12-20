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
	Submerged		= "Ahune submergiu",
	Emerged			= "Ahune emergiu",
	specWarnAttack	= "Ahune está vulnerável - Ataque agora!"
})

L:SetTimerLocalization{
	SubmergTimer	= "Submergir",
	EmergeTimer		= "Emergir",
	TimerCombat		= "Combate inicia"
}

L:SetOptionLocalization({
	Submerged		= "Exibir aviso quando Ahune submergir",
	Emerged			= "Exibir aviso quando Ahune emergir",
	specWarnAttack	= "Exibir aviso especial quando Ahune tornar-se vulnerável",
	SubmergTimer	= "Exibir cronógrafo para submergir",
	EmergeTimer		= "Exibir cronógrafo para emerge",
	TimerCombat		= "Exibir cronógrafo para início do combate"
})

L:SetMiscLocalization({
	Pull			= "The Ice Stone has melted!"
})

----------------------
--  Coren Direbrew  --
----------------------
L = DBM:GetModLocalization("d287")

L:SetWarningLocalization({
	specWarnBrew		= "Livre-se da bebida antes que ela te atire outra!",
	specWarnBrewStun	= "DICA: Você foi atordoado, lembre-se de beber da próxima vez!"
})

L:SetOptionLocalization({
	specWarnBrew		= "Exibir aviso especial para $spell:47376",
	specWarnBrewStun	= "Exibir aviso especial para $spell:47340",
	YellOnBarrel		= "Gritar no $spell:51413"
})

L:SetMiscLocalization({
	YellBarrel			= "Estou Embarrilado!"
})

-------------------------
--  Headless Horseman  --
-------------------------
L = DBM:GetModLocalization("d285")

L:SetWarningLocalization({
	WarnPhase				= "Fase %d",
	warnHorsemanSoldiers	= "Abóboras Pulsantes surgindo",
	warnHorsemanHead		= "Cabeça do Horseman ativa"
})

L:SetTimerLocalization{
	TimerCombatStart		= "Combate inicia"
}

L:SetOptionLocalization({
	WarnPhase				= "Exibir aviso para cada mudança de fase",
	TimerCombatStart		= "Exibir cronógrafo para início do combate",
	warnHorsemanSoldiers	= "Exibir aviso para surgimento de Abóboras Pulsantes",
	warnHorsemanHead		= "Exibir aviso para surgimento da Cabeça do Horseman"
})

L:SetMiscLocalization({
	HorsemanSummon			= "Horseman rise...",
	HorsemanSoldiers		= "Soldiers arise, stand and fight! Bring victory at last to this fallen knight!"
})

------------------------------
--  The Abominable Greench  --
------------------------------
L = DBM:GetModLocalization("Greench")

L:SetGeneralLocalization({
	name = "The Abominable Greench"
})
