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
	SetBubbles			= "Automatically disable chat bubbles during $spell:101871<br/>(restores them when game ends)"
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

-------------------------
--  Darkmoon Moonfang  --
-------------------------
L = DBM:GetModLocalization("Moonfang")

L:SetGeneralLocalization({
	name = "Moonfang"
})

L:SetWarningLocalization({
	specWarnCallPack		= "Call the Pack - Run > 40 yards from Moonfang!",
	specWarnMoonfangCurse	= "Moonfang's Curse - Run > 10 yards from Moonfang!"
})

L:SetOptionLocalization({
	specWarnCallPack		= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.run:format(144602),
	specWarnMoonfangCurse	= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.run:format(144590)
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
