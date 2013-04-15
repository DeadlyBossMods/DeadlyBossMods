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
	HummelActive		= "Hummel becomes active",
	BaxterActive		= "Baxter becomes active",
	FryeActive			= "Frye becomes active"
}

L:SetOptionLocalization({
	TrioActiveTimer		= "Show timers for when Apothecary Trio becomes active"
})

L:SetMiscLocalization({
	SayCombatStart		= "Did they bother to tell you who I am and why I am doing this?"
})

-------------
--  Ahune  --
-------------
L = DBM:GetModLocalization("d286")

L:SetWarningLocalization({
	Submerged		= "Ahune has submerged",
	Emerged			= "Ahune has emerged",
	specWarnAttack	= "Ahune is vulnerable - Attack now!"
})

L:SetTimerLocalization{
	SubmergTimer	= "Submerge",
	EmergeTimer		= "Emerge",
	TimerCombat		= "Combat starts"
}

L:SetOptionLocalization({
	Submerged		= "Show warning when Ahune submerges",
	Emerged			= "Show warning when Ahune emerges",
	specWarnAttack	= "Show special warning when Ahune becomes vulnerable",
	SubmergTimer	= "Show timer for submerge",
	EmergeTimer		= "Show timer for emerge",
	TimerCombat		= "Show timer for start of combat",
})

L:SetMiscLocalization({
	Pull			= "The Ice Stone has melted!"
})

----------------------
--  Coren Direbrew  --
----------------------
L = DBM:GetModLocalization("d287")

L:SetWarningLocalization({
	specWarnBrew		= "Get rid of the brew before she tosses you another one!",
	specWarnBrewStun	= "HINT: You were bonked, remember to drink the brew next time!"
})

L:SetOptionLocalization({
	specWarnBrew		= "Show special warning for $spell:47376",
	specWarnBrewStun	= "Show special warning for $spell:47340",
	YellOnBarrel		= "Yell on $spell:51413"
})

L:SetMiscLocalization({
	YellBarrel			= "Barrel on me!"
})

-------------------------
--  Headless Horseman  --
-------------------------
L = DBM:GetModLocalization("d285")

L:SetWarningLocalization({
	WarnPhase				= "Phase %d",
	warnHorsemanSoldiers	= "Pulsing Pumpkins spawning",
	warnHorsemanHead		= "Head of the Horseman Active"
})

L:SetTimerLocalization{
	TimerCombatStart		= "Combat starts"
}

L:SetOptionLocalization({
	WarnPhase				= "Show a warning for each phase change",
	TimerCombatStart		= "Show timer for start of combat",
	warnHorsemanSoldiers	= "Show warning for Pulsing Pumpkin spawn",
	warnHorsemanHead		= "Show warning for Head of the Horseman spawning"
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
	warnGameOverQuest	= "Earned %d out of %d possible points spawned",
	warnGameOverNoQuest	= "Game ended with a total of %d possible points spawned",
	warnGnoll			= "Gnoll spawned",
	warnHogger			= "Hogger spawned",
	specWarnHogger		= "Hogger spawned!"
})

L:SetOptionLocalization({
	warnGameOver	= "Announce total possible points when game ends",
	warnGnoll		= "Announce when a Gnoll spawns",
	warnHogger		= "Announce when a Hogger spawns",
	specWarnHogger	= "Show special warning when a Hogger spawns"
})

------------------------
--  Shooting Gallery  --
------------------------
L = DBM:GetModLocalization("Shot")

L:SetGeneralLocalization({
	name = "Shooting Gallery"
})

L:SetOptionLocalization({
	SetBubbles			= "Automatically disable chat bubbles during $spell:101871\n(restores them when game ends)"
})

----------------------
--  Tonk Challenge  --
----------------------
L = DBM:GetModLocalization("Tonks")

L:SetGeneralLocalization({
	name = "Tonk Challenge"
})

-----------------------
--  Darkmoon Rabbit  --
-----------------------
L = DBM:GetModLocalization("Rabbit")

L:SetGeneralLocalization({
	name = "Darkmoon Rabbit"
})

--------------------------
--  Plants Vs. Zombies  --
--------------------------
L = DBM:GetModLocalization("PlantsVsZombies")

L:SetGeneralLocalization({
	name = "Plants Vs. Zombies"
})

L:SetWarningLocalization({
	warnTotalAdds	= "Total zombies spawned since last massive wave: %d",
	specWarnWave	= "Massive Wave!"
})

L:SetTimerLocalization{
	timerWave		= "Next Massive Wave"
}

L:SetOptionLocalization({
	warnTotalAdds	= "Announce total add spawn count between each massive wave",
	specWarnWave	= "Show special warning when a Massive Wave begins",
	timerWave		= "Show timer for next Massive Wave"
})

L:SetMiscLocalization({
	MassiveWave		= "A Massive Wave of Zombies is Approaching!"
})
