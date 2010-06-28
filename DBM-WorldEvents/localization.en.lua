local L

----------------------
--  Coren Direbrew  --
----------------------
L = DBM:GetModLocalization("CorenDirebrew")

L:SetGeneralLocalization({
	name = "Coren Direbrew"
})

L:SetWarningLocalization({
	specWarnBrew		= "Get rid of the brew before she tosses you another one!",
	specWarnBrewStun	= "HINT: You were bonked, remember to drink the brew next time!"
})

L:SetOptionLocalization({
	specWarnBrew		= "Show special warning for Dark Brewmaiden's Brew",
	specWarnBrewStun	= "Show special warning for Dark Brewmaiden's Stun",
	YellOnBarrel		= "Yell on Barrel"
})

L:SetMiscLocalization({
	YellBarrel	= "Barrel on me!"
})

-------------------------
--  Headless Horseman  --
-------------------------
L = DBM:GetModLocalization("HeadlessHorseman")

L:SetGeneralLocalization({
	name = "Headless Horseman"
})

L:SetWarningLocalization({
	warnHorsemanSoldiers	= "Pulsing Pumpkin spawning",
	specWarnHorsemanHead	= "Whirlwind - Switch to the head"
})

L:SetOptionLocalization({
	warnHorsemanSoldiers	= "Show warning for Pulsing Pumpkin spawn",
	specWarnHorsemanHead	= "Show special warning for Whirlwind (2nd and later head spawn)"
})

L:SetMiscLocalization({
	HorsemanHead		= "Get over here, you idiot!",
	HorsemanSoldiers	= "Soldiers arise, stand and fight! Bring victory at last to this fallen knight!",
	SayCombatEnd		= "This end have I reached before.  What new adventure lies in store?"
})

-----------------------
--  Apothecary Trio  --
-----------------------
L = DBM:GetModLocalization("ApothecaryTrio")

L:SetGeneralLocalization({
	name = "Apothecary Trio"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization{
	HummelActive	= "Hummel becomes active",
	BaxterActive	= "Baxter becomes active",
	FryeActive		= "Frye becomes active"
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
L = DBM:GetModLocalization("Ahune")

L:SetGeneralLocalization({
	name = "Ahune"
})

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