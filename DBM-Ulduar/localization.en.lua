local L


----------------------
--  FlameLeviathan  --
----------------------
L = DBM:GetModLocalization("FlameLeviathan")

L:SetGeneralLocalization{
	name = "Flame Leviathan"
}

L:SetTimerLocalization{
	timerPursued		= "Pursuing: %s",
	timerFlameVents		= "Flame Vents",
	timerSystemOverload	= "System Overloaded"
}
	
L:SetMiscLocalization{
	YellPull	= "Hostile entities detected. Threat assessment protocol active. Primary target engaged. Time minus 30 seconds to re-evaluation.",
	Emote		= "%%s pursues (%S+)%."
}

L:SetWarningLocalization{
	pursueTargetWarn	= "Pursuing >%s<!",
	warnNextPursueSoon	= "Target Change in 5 Sec"
}

L:SetOptionLocalization{
	timerSystemOverload		= "Show Timer for System Overload",
	timerFlameVents			= "Show Timer for Flame Vents",
	timerPursued			= "Show Timer for Pursued",
	SystemOverload			= "Show Special Warning for System Overload",
	SpecialPursueWarnYou	= "Show Special Warning when Pursued",
	PursueWarn				= "Show warning for pursue on Player",
	warnNextPursueSoon		= "Warn before next pursue"
}


-------------
--  Ignis  --
-------------
L = DBM:GetModLocalization("Ignis")

L:SetGeneralLocalization{
	name = "Ignis the Furnace Master"
}

L:SetTimerLocalization{
	TimerFlameJetsCast		= "Flame Jets",
	TimerFlameJetsCooldown	= "Next Flame Jets in",
	TimerScorch				= "Next Scorch in",
	TimerScorchCast			= "Scorch",
	TimerSlagPot			= "Slag Pot: %s"
}

L:SetWarningLocalization{
	WarningSlagPot			= "Slag Pot on >%s<",
	SpecWarnJetsCast		= "Jets - Stop Casting"
}

L:SetOptionLocalization{
	SpecWarnJetsCast		= "Show Special Warning for Flame Jets Cast (interrupt)",
	TimerFlameJetsCast		= "Show Flame Jets Cast timer",
	TimerFlameJetsCooldown	= "Show Flame Jets Cooldown timer",
	TimerScorch				= "Show Scorch Cooldown timer",
	TimerScorchCast			= "Show Scorch Cast timer",
	WarningSlagPot			= "Announce Slag Pot target",
	TimerSlagPot			= "Show Slag Pot timer",
	SlagPotIcon				= "Set Icon on Slag Pot target"
}

------------------
--  Razorscale  --
------------------
L = DBM:GetModLocalization("Razorscale")

L:SetGeneralLocalization{
	name = "Razorscale"
}

L:SetWarningLocalization{	
	SpecWarnDevouringFlame		= "Devouring Flame - MOVE",
	warnTurretsReadySoon		= "Fourth Turret Ready in 20 Sec",
	warnTurretsReady		= "Fourth Turret Ready",
	SpecWarnDevouringFlameCast	= "Devouring Flame on You",
	WarnDevouringFlameCast		= "Devouring Flame on >%s<" 
}
L:SetTimerLocalization{
	timerDeepBreathCooldown		= "Next Flame Breath in",
	timerDeepBreathCast		= "Flame Breath",
	timerAllTurretsReady		= "Turrets",
	timerTurret1			= "Turret 1",
	timerTurret2			= "Turret 2",
	timerTurret3			= "Turret 3",
	timerTurret4			= "Turret 4"
}
L:SetOptionLocalization{
	timerDeepBreathCooldown		= "Show timer for next Flame Breath",
	timerDeepBreathCast		= "Show Flame Breath cast timer",
	SpecWarnDevouringFlame		= "Show Special Warning while in Devouring Flame patch",
	PlaySoundOnDevouringFlame	= "Play Sound when afflicted by Devoring Flame",
	timerAllTurretsReady		= "Show timer for turrets",
	warnTurretsReadySoon		= "Show pre-warning for turrets",
	warnTurretsReady		= "Show warning for turrets",
	SpecWarnDevouringFlameCast	= "Show Special Warning when Devouring Flame cast on you",
	WarnDevouringFlameCast		= "Show warning when Devouring Flame cast",
	timerTurret1			= "Show timer for Turret 1",
	timerTurret2			= "Show timer for Turret 2",
	timerTurret3			= "Show timer for Turret 3 (Heroic)",
	timerTurret4			= "Show timer for Turret 4 (Heroic)",	
}

L:SetMiscLocalization{
	YellAir				= "Give us a moment to prepare to build the turrets.",
	YellGroundTemp			= "Move quickly! She won't remain grounded for long!",
	EmotePhase2			= "%%s grounded permanently!",
	FlamecastUnknown		= "UNKNOWN"
}


-------------
--  XT002  --
-------------
L = DBM:GetModLocalization("XT002")

L:SetGeneralLocalization{
	name = "XT-002 Deconstructor"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
	SpecialWarningLightBomb 	= "Light Bomb on You!",
	WarningLightBomb			= "Light Bomb on >%s<",
	SpecialWarningGravityBomb	= "Gravity Bomb on YOU",
	WarningGravityBomb			= "Gravity Bomb on >%s<",
}

L:SetOptionLocalization{
	SpecialWarningLightBomb		= "Show Special Warning when you are affected by Light Bomb",
	WarningLightBomb			= "Announce Light Bomb",
	SpecialWarningGravityBomb	= "Show Special Warning when you are affected by Gravity Bomb",
	WarningGravityBomb			= "Announce Gravity Bomb",
	PlaySoundOnGravityBomb		= "Play Sound when Gravity Bomb is on you",
	PlaySoundOnTympanicTantrum	= "Play Sound on Tympanic Tandrum",
	SetIconOnLightBombTarget	= "Set Icon on Light Bomb target",
	SetIconOnGravityBombTarget	= "Set Icon on Gravity Bomb target",
}

-------------------
--  IronCouncil  --
-------------------
L = DBM:GetModLocalization("IronCouncil")

L:SetGeneralLocalization{
	name = "Iron Council"
}

L:SetWarningLocalization{
	WarningSupercharge			= "Supercharge incoming",
	WarningChainlight			= "Chain Lightning",
	WarningFusionPunch			= "Fusion Punch",
	WarningOverwhelmingPower		= "Overwhelming Power on >%s<",
	WarningRuneofPower			= "Rune of Power",
	WarningRuneofDeath			= "Rune of Death",
	RuneofDeath				= "Rune of Death - MOVE",
	LightningTendrils			= "Lightning Tendrils - MOVE",
	WarningRuneofSummoning			= "Rune of Summoning"
}

L:SetTimerLocalization{
	TimerSupercharge		= "Supercharge",
	TimerOverload			= "Overload",
	TimerLightningWhirl		= "Lightning Whirl",
	TimerLightningTendrils		= "Lightning Tendrils",
	timerFusionPunchCast		= "Fusion Punch cast",
	timerFusionPunchActive		= "Fusion Punch: %s",
	timerOverwhelmingPower		= "Overwhelming Power: %s",
	timerRunicBarrier		= "Runic Barrier",
	timerRuneofDeath		= "Rune of Death",
}

L:SetOptionLocalization{
	TimerSupercharge			= "Show Supercharge Timer",
	WarningSupercharge			= "Show warning when Supercharge is  being cast",
	WarningChainlight			= "Announce Chain Lightning",
	TimerOverload				= "Show Overload cast timer",
	TimerLightningWhirl			= "Show Lightning Whirl cast timer",
	LightningTendrils			= "Show Special Warning for Lightning Tendrils",
	TimerLightningTendrils		= "Show Lightning Tendrils duration timer",
	PlaySoundLightningTendrils	= "Play Sound on Lightning Tendrils",
	WarningFusionPunch			= "Announce Fusion Punch",
	timerFusionPunchCast		= "Show Castbar for Fusion Punch",
	timerFusionPunchActive		= "Show Fusion Punch timer",
	WarningOverwhelmingPower	= "Announce Overwhelming Power",
	timerOverwhelmingPower		= "Show Overwhelming Power timer",
	SetIconOnOverwhelmingPower	= "Set icon on Overwhelming Power target",
	timerRunicBarrier			= "Show Runic Barrier timer",
	WarningRuneofPower			= "Announce Rune of Power",
	WarningRuneofDeath			= "Announce Rune of Death",
	WarningRuneofSummoning			= "Announce Rune of Summoning",
	RuneofDeath					= "Show Special Warning for Rune of Death",
	timerRuneofDeath			= "Show Rune of Death duration timer",
}

L:SetMiscLocalization{
	Steelbreaker		= "Steelbreaker",
	RunemasterMolgeim	= "Runemaster Molgeim",
	StormcallerBrundir 	= "Stormcaller Brundir",
}


---------------
--  Algalon  --
---------------
L = DBM:GetModLocalization("Algalon")

L:SetGeneralLocalization{
	name = "Algalon the Observer"
}

L:SetTimerLocalization{
	TimerBigBangCast	= "Big Bang cast",
}
L:SetWarningLocalization{
	WarningPhasePunch	= "Phase Punch on >%s<",
	WarningBlackHole	= "Black Hole",
}

L:SetOptionLocalization{
	TimerBigBangCast	= "Show Castbar for Big Bang",
	SpecWarnPhasePunch	= "Show Special Warning when Phase Punch on you",
	WarningPhasePunch	= "Announce Phase Punch target",
	WarningBlackHole	= "Announce Black Hole",
}


----------------
--  Kologarn  --
----------------
L = DBM:GetModLocalization("Kologarn")

L:SetGeneralLocalization{
	name = "Kologarn"
}

L:SetWarningLocalization{
	SpecialWarningEyebeam		= "Eye Beam on You - MOVE",
	WarningEyebeam			= "Eye Beam on >%s<",
	WarnGrip			= "Grip on >%s<"
}

L:SetTimerLocalization{
	timerEyebeam			= "Eye Beam: %s",
	timerPetrifyingBreath		= "Petrifying Breath",
	timerNextShockwave		= "Next Shockwave",
	timerLeftArm			= "Respawn Left Arm",
	timerRightArm			= "Respawn Right Arm",
	achievementDisarmed		= "time for Disarm"
}

L:SetOptionLocalization{
	SpecialWarningEyebeam		= "Show a Special Warning for Eye Beam on YOU",
	WarningEyebeam			= "Announce Eye Beam target",
	timerEyebeam			= "Show timer for Eye Beam",
	timerPetrifyingBreath		= "Show timer for Petrifying Breath",
	timerNextShockwave		= "Show timer for Shockwave",
	timerLeftArm			= "Show timer for Arm Respawn (left)",
	timerRightArm			= "Show timer for Arm Respawn (right)",
	achievementDisarmed		= "Show timer for Disarm Achievement"
}

L:SetMiscLocalization{
	Yell_Trigger_arm_left		= "Just a scratch!",
	Yell_Trigger_arm_right		= "Only a flesh wound!",
	Health_Body			= "Kologarn Body",
	Health_Right_Arm		= "right Arm",
	Health_Left_Arm			= "left Arm"
}

---------------
--  Auriaya  --
---------------
L = DBM:GetModLocalization("Auriaya")

L:SetGeneralLocalization{
	name = "Auriaya"
}

L:SetMiscLocalization{
	Defender = "Feral Defender (%d)"
}

L:SetWarningLocalization{
	SpecWarnBlast	= "Sentinel Blast - Interrupt!",
	SpecWarnVoid	= "Void Zone - MOVE!",
	WarnCatDied 	= "Feral Defender down (%d lives remaining)",
	WarnCatDiedOne 	= "Feral Defender down (1 life remaining)",
	WarnFear		= "Fear!",
	WarnFearSoon 	= "Next Fear soon",
	WarnSonic		= "Sonic Screech!",
	WarnSwarm		= "Guardian Swarm on >%s<"
}

L:SetOptionLocalization{
	SpecWarnBlast	= "Show Special Warning on Sentinel Blast",
	SpecWarnVoid	= "Show Special Warning when standing in Feral Essence",
	WarnFear		= "Show Fear Warning",
	WarnFearSoon	= "Show Fear soon Warning",
	WarnCatDied		= "Show Warning when the Feral Defender dies",
	WarnSwarm		= "Show Warning on Guardian Swarm",
	WarnSonic		= "Show Sonic Screech Warning"
}


-------------
--  Hodir  --
-------------
L = DBM:GetModLocalization("Hodir")

L:SetGeneralLocalization{
	name = "Hodir"
}

L:SetWarningLocalization{
	WarningFlashFreeze	= "Flash Freeze",
	WarningBitingCold	= "Biting Cold - MOVE"
}

L:SetTimerLocalization{
	TimerFlashFreeze	= "Flash Freeze incoming",  -- all ppl have to move on the rock patches
}

L:SetOptionLocalization{
	TimerFlashFreeze	= "Show Flash Freeze Cast-Timer",
	WarningFlashFreeze	= "Show Warning for Flash Freeze",
	WarningBitingCold	= "Show warning for Biting Cold",
	PlaySoundOnFlashFreeze	= "Play sound on Flash Freeze Cast"
}

L:SetMiscLocalization{
	YellKill		= "I... I am released from his grasp... at last."
}


--------------
--  Thorim  --
--------------
L = DBM:GetModLocalization("Thorim")

L:SetGeneralLocalization{
	name = "Thorim"
}

L:SetWarningLocalization{
	WarningStormhammer	= "Stormhammer on >%s<",
	UnbalancingStrike	= "Unbalancing Strike on >%s<",
	WarningPhase2		= "Phase 2",
	WarningLightningCharge	= "Lightning Charge",
	WarningBomb		= "Rune Detonation on >%s<",
	LightningOrb		= "Lightning Shock on You! Move!"
}

L:SetTimerLocalization{
	TimerHardmode		= "Hard Mode"
}

L:SetOptionLocalization{
	TimerHardmode			= "Show Timer for Hard Mode",
	UnbalancingStrike		= "Announce Unbalancing Strike Target",
	WarningStormhammer		= "Announce Stormhammer Target",
	WarningLightningCharge		= "Announce Lightning Charge",
	WarningPhase2			= "Announce Phase 2",
	UnbalancingStrike		= "Announce Unbalancing Strike",
	WarningBomb			= "Announce Rune Detonation",
	RangeFrame			= "Show Range Frame"
}

L:SetMiscLocalization{
	YellPhase1		= "Interlopers! You mortals who dare to interfere with my sport will pay.... Wait--you...",
	YellPhase2		= "Impertinent whelps, you dare challenge me atop my pedestal? I will crush you myself!",
	YellKill		= "Stay your arms! I yield!"
}


-------------
--  Freya  --
-------------
L = DBM:GetModLocalization("Freya")

L:SetGeneralLocalization{
	name = "Freya"
}

L:SetMiscLocalization{
	SpawnYell	= "Children, assist me!",
	WaterSpirit	= "Ancient Water Spirit",
	Snaplasher	= "Snaplasher",
	StormLasher	= "Storm Lasher",
	YellKill	= "His hold on me dissipates. I can see clearly once more. Thank you, heroes."
}

L:SetWarningLocalization{
	WarnPhase2	= "Phase 2",
	WarnSimulKill	= "First add down - Resurrection in 1 min",
	WarnFury	= "Nature's Fury on >%s<",
	SpecWarnFury	= "Nature's Fury on You!",
	WarningTremor   = "GROUND TREMOR - STOP CASTING"
	
}

L:SetTimerLocalization{
	TimerUnstableSunBeam	= "Sun Beam: %s",
	TimerAlliesOfNature	= "Allies of Nature CD",
	TimerSimulKill		= "Resurrection",
	TimerFuryYou		= "Nature's Fury on you"
}


-------------------
--  Mimiron  --
-------------------
L = DBM:GetModLocalization("Mimiron")

L:SetGeneralLocalization{
	name = "Mimiron"
}

L:SetWarningLocalization{
	DarkGlare			= "Laser Barrage",
	WarningPlasmaBlast	= "Plasma Blast on %s - heal",
	Phase2Engaged		= "Phase 2 incoming - regroup now",
	Phase3Engaged		= "Phase 3 incoming - regroup now",
	WarnShell			= "Napalm Shells on >%s<",
	WarnBlast			= "Plasma Blast on >%s<",
	MagneticCore		= ">%s< got Magnetic Core",
	WarningShockBlast	= "Shock Blast - MOVE AWAY"
}

L:SetTimerLocalization{
	ProximityMines		= "New Proximity Mines",
}

L:SetOptionLocalization{
	TimeToPhase2		= "begin Phase 2",
	TimeToPhase3		= "begin Phase 3",
	MagneticCore		= "Announce Magnetic Core looter",
	HealthFramePhase4	= "Show Health Frame in Phase 4"
}

L:SetMiscLocalization{
	YellPull		= "We haven't much time, friends! You're going to help me test out my latest and greatest creation. Now, before you change your minds, remember that you kind of owe it to me after the mess you made with the XT-002.",	
	YellPhase2		= "WONDERFUL! Positively marvelous results! Hull integrity at 98.9%! Barely a dent! Moving right along.",
	YellPhase3		= "Thank you, friends! Your efforts have yielded some fantastic data! Now, where did I put-- oh, there it is.",
	LootMsg			= "([^%s]+).*Hitem:(%d+)"
}


--------------------
--  GeneralVezax  --
--------------------
L = DBM:GetModLocalization("GeneralVezax")

L:SetGeneralLocalization{
	name = "General Vezax"
}

L:SetWarningLocalization{
	SpecialWarningShadowCrash	= "Shadow Crash on You",
	SpecialWarningSurgeDarkness	= "Surge of Darkness",
	WarningShadowCrash			= "Shadow Crash on >%s<",
	SpecialWarningLLYou		= "Life Leech on you!",
	SpecialWarningLLNear		= "Life Leech on %s near you!"
}

L:SetOptionLocalization{
	WarningShadowCrash			= "Show Warning for Shadow Crash",
	SetIconOnShadowCrash		= "Set Icon on Shadow Crash target (skull)",
	SetIconOnLifeLeach			= "Set Icon on Life Leech target (cross)",
	SpecialWarningSurgeDarkness	= "Show Special Warning for Surge of Darkness",
	SpecialWarningShadowCrash	= "Show Special Warning for Shadow Crash",
	SpecialWarningLLYou		= "Show Special Warning for Life Leach on YOU",
	SpecialWarningLLNear		= "Show Special Warning for Life Leach in near of you",
	CrashWhisper			= "Send Whisper to Shadow Crash Target"
}

L:SetMiscLocalization{
	EmoteSaroniteVapors		= "A cloud of saronite vapors coalesces nearby!",
	CrashWhisper			= "Shadow Crash on You! Run away!"
}


-----------------
--  YoggSaron  --
-----------------
L = DBM:GetModLocalization("YoggSaron")

L:SetGeneralLocalization{
	name = "Yogg-Saron"
}

L:SetMiscLocalization{
	YellPull 		= "The time to strike at the head of the beast will soon be upon us! Focus your anger and hatred on his minions!",
	YellPhase2 		= "I am the lucid dream.",
	Sara 			= "Sara",
	WhisperBrainLink 	= "Brain Link on you! Run to %s!",
	WarningYellSqueeze	= "Squeeze on me! Help me!"
}

L:SetWarningLocalization{
	WarningGuardianSpawned 		= "Guardian spawned",
	WarningP2 			= "Phase 2",
	WarningBrainLink 		= "Brain Link on >%s< and >%s<",
	SpecWarnBrainLink 		= "Brain Link on you and %s!",
	WarningSanity 			= "%d Sanity debuffs remaining",
	SpecWarnSanity 			= "%d Sanity debuffs remaining",
	SpecWarnGuardianLow 		= "Stop attacking this Guardian!",
	WarnMadness			= "Casting Induce Madness",
	SpecWarnMadnessOutNow		= "Madness ends - MOVE OUT",
	WarnBrainPortalSoon		= "Portal  in 3 sec",	
	WarnSqueeze 			= "Squeeze: >%s<"
}

L:SetOptionLocalization{
	WarningGuardianSpawned		= "Announce Guardian Spawns",
	WarningP2			= "Announce Phase 2",
	WarningP3			= "Announce Phase 3",
	WarningBrainLink		= "Announce Brain Links",
	SpecWarnBrainLink		= "Show Special Warning when Brain Linked",
	WarningSanity			= "Show Warning when Sanity low",
	SpecWarnSanity			= "Show Special Warning when Sanity very low",
	SpecWarnGuardianLow		= "Show Special Warning when Guardian (P1) is low (for DDs)",
	WarnMadness			= "Announce Madness",
	WarnBrainPortalSoon		= "Announce Potral",
	SpecWarnMadnessOutNow		= "Show Special Warning shortly before Madness ends",
	SetIconOnFearTarget		= "Set Icon on Fear Target"
}



