local L


----------------------
--  FlameLeviathan  --
----------------------
L = DBM:GetModLocalization("FlameLeviathan")

L:SetGeneralLocalization({
	name = "Flame Leviathan"
})

L:SetTimerLocalization({
	timerPursued		= "Pursued: %s",
	timerFlameVents		= "Flame Vents",
	timerSystemOverload	= "System Overloaded"
})
	
L:SetMiscLocalization({
	YellPull		= "Hostile entities detected. Threat assessment protocol active. Primary target engaged. Time minus 30 seconds to re-evaluation.",
	Emote			= "%%s pursues (%S+)%."
})

L:SetWarningLocalization({
	pursueTargetWarn	= "Pursuing >%s<!",
	warnNextPursueSoon	= "pursue change in 5 Seconds"
})

L:SetOptionLocalization({
	timerSystemOverload	= "Show Timer for System Overload",
	timerFlameVents		= "Show Timer for Flame Vents",
	timerPursued		= "Show Timer for Pursued",
	SystemOverload		= "Show Special Warning for System Overload",
	SpecialPursueWarnYou	= "Show Special Warning when Pursued",
	PursueWarn		= "Show Raidwarning for pursue on Player",
	warnNextPursueSoon	= "Warn before next pursue"
})


-------------
--  Ignis  --
-------------
L = DBM:GetModLocalization("Ignis")

L:SetGeneralLocalization({
	name = "Ignis"
})

L:SetMiscLocalization({
})

L:SetWarningLocalization({
})

------------------
--  Razorscale  --
------------------
L = DBM:GetModLocalization("Razorscale")

L:SetGeneralLocalization({
	name = "Razorscale"
})

L:SetMiscLocalization({
})

L:SetWarningLocalization({
})

-------------
--  XT002  --
-------------
L = DBM:GetModLocalization("XT002")

L:SetGeneralLocalization({
	name = "XT002"
})

L:SetMiscLocalization({
})

L:SetWarningLocalization({
})


-------------------
--  IronCouncil  --
-------------------
L = DBM:GetModLocalization("IronCouncil")

L:SetGeneralLocalization({
	name = "Iron Council"
})

L:SetWarningLocalization({
	WarningSupercharge	= "Supercharge incoming",
})

L:SetTimerLocalization({
	TimerSupercharge	= "Supercharge",  -- gives the other bosses more power
})

L:SetOptionLocalization({
	TimerSupercharge	= "Show Supercharge Timer",
	WarningSupercharge	= "Show warning when Supercharge casting",
})

L:SetMiscLocalization({
	Steelbreaker		= "Steelbreaker",
	RunemasterMolgeim	= "Runemaster Molgeim",
	StormcallerBrundir 	= "Stormcaller Brundir",
})


---------------
--  Algalon  --
---------------
L = DBM:GetModLocalization("Algalon")

L:SetGeneralLocalization({
	name = "Algalon"
})

L:SetMiscLocalization({
})

L:SetWarningLocalization({
})


----------------
--  Kologarn  --
----------------
L = DBM:GetModLocalization("Kologarn")

L:SetGeneralLocalization({
	name = "Kologarn"
})

L:SetMiscLocalization({
})

L:SetWarningLocalization({
})

--------------
--  Auriya  --
--------------
L = DBM:GetModLocalization("Auriya")

L:SetGeneralLocalization({
	name = "Auriya"
})

L:SetMiscLocalization({
})

L:SetWarningLocalization({
})


-------------
--  Hodir  --
-------------
L = DBM:GetModLocalization("Hodir")

L:SetGeneralLocalization({
	name = "Hodir"
})

L:SetWarningLocalization({
	WarningFlashFreeze	= "Flesh Freeze",
	WarningBitingCold	= "Biting Cold - MOVE"
})

L:SetTimerLocalization({
	TimerFlashFreeze	= "Flesh Freeze incoming",  -- all ppl have to move on the rock patches
})

L:SetOptionLocalization({
	TimerFlashFreeze	= "Show Flash Freeze Cast-Timer",
	WarningFlashFreeze	= "Show Warning for Flash Freeze",
})

L:SetMiscLocalization({
	PlaySoundOnFlashFreeze	= "Play sound on Flash Freeze Cast",
})


--------------
--  Thorim  --
--------------
L = DBM:GetModLocalization("Thorim")

L:SetGeneralLocalization({
	name = "Thorim"
})

L:SetWarningLocalization({
	WarningStormhammer	= "Stormhammer on >%s<",
	UnbalancingStrike	= "Unbalancing Strike on >%s<",
	WarningPhase2	= "Phase 2",
	WarningBomb	= "Rune Detonation on >%s<",
	LightningOrb = "Lightning Shock on You! Move!"
})

L:SetTimerLocalization({
	TimerStormhammer	= "Stormhammer CD",
	TimerUnbalancingStrike	= "Unbalancing Strike CD",
	TimerHardmode	= "Hard Mode"
})

L:SetOptionLocalization({
	TimerStormhammer	= "Show Stormhammer Cooldown",
	TimerUnbalancingStrike	= "Show Timer for Unbalancing Strike",
	TimerHardmode	= "Show Timer for Hard Mode",
	UnbalancingStrike	= "Announce Unbalancing Strike Target",
	WarningStormhammer	= "Announce Stormhammer Target",
	WarningPhase2	= "Announce Phase 2",
	RangeFrame	= "Show Range Frame"
})

L:SetMiscLocalization({
	YellPhase1		= "Interlopers! You mortals who dare to interfere with my sport will pay.... Wait--you...",
	YellPhase2		= "Impertinent whelps, you dare challenge me atop my pedestal? I will crush you myself!"
})


-------------
--  Freya  --
-------------
L = DBM:GetModLocalization("Freya")

L:SetGeneralLocalization({
	name = "Freya"
})

L:SetMiscLocalization({
})

L:SetWarningLocalization({
})


-------------------
--  Mimiron  --
-------------------
L = DBM:GetModLocalization("Mimiron")

L:SetGeneralLocalization({
	name = "Mimiron"
})

L:SetWarningLocalization({
	WarningPlasmaBlast	= "Plasma Blast on %s - heal",
})

L:SetTimerLocalization({
	ProximityMines		= "New Proximity Mines",
})

L:SetOptionLocalization({
	WarningShockBlast	= "Show Shock Blast Warning",
	WarningPlasmaBlast	= "Show Plasma Blast Warning",
	ProximityMines		= "Show Timer for Proximity Mines",
})

L:SetMiscLocalization({
	YellPull		= "We haven't much time, friends! You're going to help me test out my latest and greatest creation. Now, before you change your minds, remember that you kind of owe it to me after the mess you made with the XT-002.",
	PlaySoundOnShockBlast 	= "Play sound on Shock Blast cast",
	
	YellPhase2		= "WONDERFUL! Positively marvelous results! Hull integrity at 98.9%! Barely a dent! Moving right along.",
	Phase2Engaged		= "Phase 2 incoming - regroup now",

	YellPhase3		= "Thank you, friends! Your efforts have yielded some fantastic data! Now, where did I put-- oh, there it is.",
	Phase3Engaged		= "Phase 3 incoming - regroup now",
})


--------------------
--  GeneralVezax  --
--------------------
L = DBM:GetModLocalization("GeneralVezax")

L:SetGeneralLocalization({
	name = "General Vezax"
})

L:SetWarningLocalization({
	WarningShadowCrash	= "Shadow Crash on YOU"
})

L:SetTimerLocalization({
	timerSearingFlamesCast	= "Searing Flames",
	timerSurgeofDarkness	= "Surge of Darkness",
	timerSaroniteVapors	= "Next Saronite Vapors"
})

L:SetOptionLocalization({
	WarningShadowCrash	= "Show Special Warning for Shadow Crash",
	timerSearingFlamesCast	= "Show Timer for Searing Flame Cast",
	timerSurgeofDarkness	= "Show Timer for Sourge of Darkness",
	timerSaroniteVapors	= "Show Timer for Saronite Vapors",
	SetIconOnShadowCrash	= "Set Icon on Shadow Crash target (skull)",
	SetIconOnLifeLeach	= "Set Icon on Life Leach target (cross)"
})

L:SetMiscLocalization({
	EmoteSaroniteVapors	= "A cloud of saronite vapors coalesces nearby!"
})


-----------------
--  YoggSaron  --
-----------------
L = DBM:GetModLocalization("YoggSaron")

L:SetGeneralLocalization({
	name = "Yogg-Saron"
})

L:SetMiscLocalization({
})

L:SetWarningLocalization({
})




