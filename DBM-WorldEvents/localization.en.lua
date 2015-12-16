local L

------------
--  Omen  --
------------
L = DBM:GetModLocalization("Omen")

L:SetGeneralLocalization({
	name = "Omen"
})

------------------------------
--  The Crown Chemical Co.  --
------------------------------
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

----------------------------
--  The Frost Lord Ahune  --
----------------------------
L = DBM:GetModLocalization("d286")

L:SetWarningLocalization({
	Emerged			= "Emerged",
	specWarnAttack	= "Ahune is vulnerable - Attack now!"
})

L:SetTimerLocalization{
	SubmergTimer	= "Submerge",
	EmergeTimer		= "Emerge"
}

L:SetOptionLocalization({
	Emerged			= "Show warning when Ahune emerges",
	specWarnAttack	= "Show special warning when Ahune becomes vulnerable",
	SubmergTimer	= "Show timer for submerge",
	EmergeTimer		= "Show timer for emerge"
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

----------------
--  Brewfest  --
----------------
L = DBM:GetModLocalization("Brew")

L:SetGeneralLocalization({
	name = "Brewfest"
})

L:SetOptionLocalization({
	NormalizeVolume			= "Automatically normalize the DIALOG sound channel volume to match music sound channel volume when in Brewfest area so that it's not so annoyingly loud. (If music sound volume is not set, then volume will be muted.)"
})

-----------------------------
--  The Headless Horseman  --
-----------------------------
L = DBM:GetModLocalization("d285")

L:SetWarningLocalization({
	WarnPhase				= "Phase %d",
	warnHorsemanSoldiers	= "Pulsing Pumpkins spawning",
	warnHorsemanHead		= "Head of the Horseman Active"
})

L:SetOptionLocalization({
	WarnPhase				= "Show a warning for each phase change",
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