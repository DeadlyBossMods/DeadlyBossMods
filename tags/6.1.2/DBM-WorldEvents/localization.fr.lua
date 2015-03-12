-- Last update: 12/20/2012 (20/12/2012 in french format)
-- By Edoz (stephanelc35@msn.com)
if GetLocale() ~= "frFR" then return end
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

L:SetWarningLocalization({
})

L:SetTimerLocalization{
	HummelActive	= "Hummel devient actif",
	BaxterActive	= "Baxter devient actif",
	FryeActive		= "Frye devient actif"
}

L:SetOptionLocalization({
	TrioActiveTimer		= "Afficher le timer lorsque le Trio d'apothicaire devient actif"
})

L:SetMiscLocalization({
	SayCombatStart		= "Ont-ils pris la peine de vous dire qui je suis et pourquoi je fais cela?"
})

-------------
--  Ahune  --
-------------
L = DBM:GetModLocalization("d286")

L:SetWarningLocalization({
	Submerged		= "Ahune est immergé",
	Emerged			= "Ahune a émergé",
	specWarnAttack	= "Ahune est vulnérable - Attaquez maintenant !"
})

L:SetTimerLocalization{
	SubmergTimer	= "Immerger",
	EmergeTimer		= "Emerger",
	TimerCombat		= "Début du combat dans"
}

L:SetOptionLocalization({
	Submerged		= "Afficher l'alerte lorsque Ahune est immergé",
	Emerged			= "Afficher l'alerter lorsque Ahune a émergé",
	specWarnAttack	= "Afficher une alerter spécial lorsque Ahune devient vulnérable",
	SubmergTimer	= "Afficher le timer pour l'immersion",
	EmergeTimer		= "Afficher le timer pour l'émersion",
	TimerCombat		= "Afficher le timer du début du combat"
})

L:SetMiscLocalization({
	Pull			= "Le glaçon a fondu!"
})

-------------------
-- Coren Direbrew --
-------------------
L = DBM:GetModLocalization("d287")

L:SetWarningLocalization({
	specWarnBrew		= "Débarrassez-vous de la bière avant qu'elle ne vous en lance une autre !",
	specWarnBrewStun	= "Vous avez reçu un coup sur la tête. La prochaine fois, videz votre verre !"
})

L:SetOptionLocalization({
	specWarnBrew		= "Montre une alerte spéciale pour $spell:47376",
	specWarnBrewStun	= "Montre une alerte spéciale pour $spell:47340",
	YellOnBarrel		= "Crie quand vous avez un $spell:51413 sur vous"
})

L:SetMiscLocalization({
	YellBarrel			= "Tonneau sur moi !"
})

-------------------
-- Headless Horseman --
-------------------
L = DBM:GetModLocalization("d285")

L:SetWarningLocalization({
	WarnPhase				= "Phase %d",
	warnHorsemanSoldiers		= "Arrivée des Citrouilles vibrantes !",
	warnHorsemanHead		= "Tapez la Tête du Cavalier"
})

L:SetTimerLocalization{
	TimerCombatStart		= "Début du combat dans"
}

L:SetOptionLocalization({
	TimerCombatStart		= "Afficher le timer du début du combat",
	warnHorsemanSoldiers		= "Montre une alerte pour l'arrivée des Citrouilles vibrantes",
	warnHorsemanHead		= "Montre une alerte spéciale pour l'arrivée de la Tête du Cavalier"
})

L:SetMiscLocalization({
	HorsemanSummon			= "Le cavalier sans tête se lève...",
	HorsemanSoldiers			= "Levez-vous, mes recrues ! Au combat sans surseoir ! Au chevalier déchu, donnez enfin victoire !"
})

------------------------------
--  The Abominable Greench  --
------------------------------
L = DBM:GetModLocalization("Greench")

L:SetGeneralLocalization({
	name = "L'abominable Grinche"
})

--------------------------
--  Plants Vs. Zombies  --
--------------------------
L = DBM:GetModLocalization("PlantsVsZombies")

L:SetGeneralLocalization({
	name = "Plants Vs. Zombies"
})

L:SetWarningLocalization({
	warnTotalAdds	= "Total des zombies engendrées depuis la dernière vague massive : %d",
	specWarnWave	= "Vague Massive !"
})

L:SetTimerLocalization{
	timerWave		= "Prochaine Vague Massive"
}

L:SetOptionLocalization({
	warnTotalAdds	= "Afficher le nombre total d'add engendrées entre chaque vague massive",
	specWarnWave	= "Alerte spécial quand une Vague Massive arrive",
	timerWave		= "Délai avant la prochaine Vague Massive"
})

L:SetMiscLocalization({
	MassiveWave		= "Une Vague Massive de Zombies est en approche !"
})

--------------------------
--  Garrison Invasions  --
--------------------------
L = DBM:GetModLocalization("GarrisonInvasions")

L:SetGeneralLocalization({
	name = "Invasions de Fief"
})

L:SetWarningLocalization({
	specWarnRylak	= "Charognard sombraile arrive",
	specWarnWorker	= "Paysan terrifié apparu",
	specWarnSpy		= "Un espion s'est infiltré",
	specWarnBuilding= "Un bâtiment est attaqué"
})

L:SetOptionLocalization({
	specWarnRylak	= "Afficher une alerte spéciale quand un rylak arrive",
	specWarnWorker	= "Afficher une alerte spéciale quand un Paysan terrifié apparait",
	specWarnSpy		= "Afficher une alerte spéciale quand un espion s'est infiltré",
	specWarnBuilding= "Afficher une alerte spéciale quand un bâtiment est attaqué"
})
