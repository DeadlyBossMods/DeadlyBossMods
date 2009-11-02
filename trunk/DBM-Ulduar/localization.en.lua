local L


-----------------------
--  Flame Leviathan  --
-----------------------
L = DBM:GetModLocalization("FlameLeviathan")

L:SetGeneralLocalization{
	name = "Flame Leviathan"
}

L:SetTimerLocalization{
	timerPursued		= "Pursuing: %s",
	timerFlameVents		= "Flame Vents",
	timerSystemOverload	= "System Overload"
}
	
L:SetMiscLocalization{
	YellPull	= "Hostile entities detected. Threat assessment protocol active. Primary target engaged. Time minus 30 seconds to re-evaluation.",
	Emote		= "%%s pursues (%S+)%."
}

L:SetWarningLocalization{
	PursueWarn				= "Pursuing >%s<",
	warnNextPursueSoon		= "Target change in 5 seconds",
	SpecialPursueWarnYou	= "You are being pursued - Run away",
	SystemOverload			= "System Overload",
	warnWardofLife			= "Ward of Life spawned",
--	warnWrithingLasher		= "Writhing Lasher spawned"
}

L:SetOptionLocalization{
	timerSystemOverload		= "Show timer for System Overload",
	timerFlameVents			= "Show timer for Flame Vents",
	timerPursued			= "Show timer for pursue",
	SystemOverload			= "Show special warning for System Overload",
	SpecialPursueWarnYou	= "Show special warning when you are being pursued",
	PursueWarn				= "Announce pursued targets",
	warnNextPursueSoon		= "Show pre-warning for next pursue",
	warnWardofLife			= "Show special warning for Ward of Life spawn",
--	warnWrithingLasher		= "Show special warning for Writhing Lasher spawn" --commenting out as it is currently unused for Flame Leviathan
}


--------------------------------
--  Ignis the Furnace Master  --
--------------------------------
L = DBM:GetModLocalization("Ignis")

L:SetGeneralLocalization{
	name = "Ignis the Furnace Master"
}

L:SetTimerLocalization{
	TimerFlameJetsCast		= "Flame Jets",
	TimerFlameJetsCooldown	= "Next Flame Jets",
	TimerScorch				= "Next Scorch",
	TimerScorchCast			= "Scorch",
	TimerSlagPot			= "Slag Pot: %s"
}

L:SetWarningLocalization{
	WarningSlagPot			= "Slag Pot on >%s<",
	SpecWarnJetsCast		= "Flame Jets - Stop casting"
}

L:SetOptionLocalization{
	SpecWarnJetsCast		= "Show special warning for Flame Jets cast",
	TimerFlameJetsCast		= "Show timer for Flame Jets cast",
	TimerFlameJetsCooldown	= "Show timer for Flame Jets cooldown",
	TimerScorch				= "Show timer for Scorch cooldown",
	TimerScorchCast			= "Show timer for Scorch cast",
	WarningSlagPot			= "Announce Slag Pot targets",
	TimerSlagPot			= "Show timer for Slag Pot",
	SlagPotIcon				= "Set icons on Slag Pot targets"
}

------------------
--  Razorscale  --
------------------
L = DBM:GetModLocalization("Razorscale")

L:SetGeneralLocalization{
	name = "Razorscale"
}

L:SetWarningLocalization{	
	SpecWarnDevouringFlame		= "Devouring Flame - Move away",
	warnTurretsReadySoon		= "Last turret ready in 20 seconds",
	warnTurretsReady			= "Last turret ready",
	SpecWarnDevouringFlameCast	= "Devouring Flame on you",
	WarnDevouringFlameCast		= "Devouring Flame on >%s<" 
}
L:SetTimerLocalization{
	timerDeepBreathCooldown		= "Next Flame Breath",
	timerDeepBreathCast			= "Flame Breath",
	timerAllTurretsReady		= "Turrets",
	timerTurret1				= "Turret 1",
	timerTurret2				= "Turret 2",
	timerTurret3				= "Turret 3",
	timerTurret4				= "Turret 4",
	timerGroundedTemp			= "On the ground"
}
L:SetOptionLocalization{
	timerDeepBreathCooldown		= "Show timer for Flame Breath cooldown",
	timerDeepBreathCast			= "Show timer for Flame Breath cast",
	SpecWarnDevouringFlame		= "Show special warning when you are in Devouring Flame",
	PlaySoundOnDevouringFlame	= "Play sound when you are affected by Devouring Flame",
	timerAllTurretsReady		= "Show timer for turrets",
	warnTurretsReadySoon		= "Show pre-warning for turrets",
	warnTurretsReady			= "Show warning for turrets",
	SpecWarnDevouringFlameCast	= "Show special warning when Devouring Flame is cast on you",
	timerTurret1				= "Show timer for turret 1",
	timerTurret2				= "Show timer for turret 2",
	timerTurret3				= "Show timer for turret 3 (25 player)",
	timerTurret4				= "Show timer for turret 4 (25 player)",
	OptionDevouringFlame		= "Announce Devouring Flame targets (unreliable)",
	timerGroundedTemp			= "Show timer for ground phase duration"
}

L:SetMiscLocalization{
	YellAir						= "Give us a moment to prepare to build the turrets.",
	YellAir2					= "Fires out! Let's rebuild those turrets!",
	YellGroundTemp				= "Move quickly! She won't remain grounded for long!",
	EmotePhase2					= "%%s grounded permanently!",
	FlamecastUnknown			= DBM_CORE_UNKNOWN
}


----------------------------
--  XT-002 Deconstructor  --
----------------------------
L = DBM:GetModLocalization("XT002")

L:SetGeneralLocalization{
	name = "XT-002 Deconstructor"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
	SpecialWarningLightBomb 	= "Searing Light on you",
	SpecialWarningGravityBomb	= "Gravity Bomb on you",
	specWarnConsumption			= "Consumption - Move away"
}

L:SetOptionLocalization{
	SpecialWarningLightBomb		= "Show special warning when you are affected by Searing Light",
	SpecialWarningGravityBomb	= "Show special warning when you are affected by Gravity Bomb",
	specWarnConsumption			= "Show special warning when you take damage from Consumption",
	PlaySoundOnGravityBomb		= "Play sound when you are affected by Gravity Bomb",
	PlaySoundOnTympanicTantrum	= "Play sound on Tympanic Tantrum",
	SetIconOnLightBombTarget	= "Set icons on Searing Light targets",
	SetIconOnGravityBombTarget	= "Set icons on Gravity Bomb targets"
}

--------------------
--  Iron Council  --
--------------------
L = DBM:GetModLocalization("IronCouncil")

L:SetGeneralLocalization{
	name = "Iron Council"
}

L:SetWarningLocalization{
	WarningSupercharge			= "Supercharge incoming",
	RuneofDeath					= "Rune of Death - Move away",
	LightningTendrils			= "Lightning Tendrils - Run away",
	Overload					= "Overload - Run away",
	WarningStaticDisruption		= "Static Disruption on >%s<",
	PlaySoundDeathRune			= "Death Rune"
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	WarningSupercharge			= "Show warning when Supercharge is being cast",
	LightningTendrils			= "Show special warning for Lightning Tendrils",
	PlaySoundLightningTendrils	= "Play sound on Lightning Tendrils",
	SetIconOnOverwhelmingPower	= "Set icons on Overwhelming Power targets",
	RuneofDeath					= "Show special warning for Rune of Death",
	SetIconOnStaticDisruption	= "Set icons on Static Disruption targets",
	Overload					= "Show special warning for Overload",
	AllwaysWarnOnOverload		= "Always warn on Overload (otherwise, only when targeted)",
	PlaySoundOnOverload			= "Play sound on Overload",
	WarningStaticDisruption		= "Announce Static Disruption targets",
	PlaySoundDeathRune			= "Play sound on Rune of Death"
}

L:SetMiscLocalization{
	Steelbreaker		= "Steelbreaker",
	RunemasterMolgeim	= "Runemaster Molgeim",
	StormcallerBrundir 	= "Stormcaller Brundir",
}


----------------------------
--  Algalon the Observer  --
----------------------------
L = DBM:GetModLocalization("Algalon")

L:SetGeneralLocalization{
	name = "Algalon the Observer"
}

L:SetTimerLocalization{
	NextCollapsingStar		= "Next Collapsing Star",
	PossibleNextCosmicSmash	= "Next possible Cosmic Smash"
}

L:SetWarningLocalization{
	WarningPhasePunch		= "Phase Punch on >%s< - Stack %d",
	WarningBlackHole		= "Black Hole",
	SpecWarnBigBang			= "Big Bang",
	PreWarningBigBang		= "Big Bang in ~10 seconds",
	WarningCosmicSmash 		= "Cosmic Smash - Explosion in 4 seconds",
	SpecWarnCosmicSmash 	= "Cosmic Smash"
}

L:SetOptionLocalization{
	SpecWarnPhasePunch		= "Show special warning when you are affected by Phase Punch",
	PreWarningBigBang		= "Show pre-warning for Big Bang",
	SpecWarnBigBang			= "Show special warning for Big Bang",
	WarningPhasePunch		= "Announce Phase Punch targets",
	WarningBlackHole		= "Show warning for Black Hole",
	NextCollapsingStar		= "Show timer for next Collapsing Star",
	WarningCosmicSmash 		= "Show warning for Cosmic Smash",
	SpecWarnCosmicSmash 	= "Show special warning for Cosmic Smash",
	PossibleNextCosmicSmash	= "Show timer for next possible Cosmic Smash"
}

L:SetMiscLocalization{
	YellPull				= "Your actions are illogical. All possible results for this encounter have been calculated. The Pantheon will receive the Observer's message regardless of outcome.",
	YellPullFirst			= "",
	Emote_CollapsingStars	= "%s begins to Summon Collapsing Stars!",
	Emote_CosmicSmash		= "%s begins to cast Cosmic Smash!"

}


----------------
--  Kologarn  --
----------------
L = DBM:GetModLocalization("Kologarn")

L:SetGeneralLocalization{
	name = "Kologarn"
}

L:SetWarningLocalization{
	SpecialWarningEyebeam	= "Eye Beam on you - Move",
	WarningEyeBeam			= "Eye Beam on >%s<",
	WarnGrip				= "Grip on >%s<"
}

L:SetTimerLocalization{
	timerEyebeam			= "Eye Beam: %s",
	timerPetrifyingBreath	= "Petrifying Breath",
	timerNextShockwave		= "Next Shockwave",
	timerLeftArm			= "Left Arm respawn",
	timerRightArm			= "Right Arm respawn",
	achievementDisarmed		= "Timer for Disarm"
}

L:SetOptionLocalization{
	SpecialWarningEyebeam	= "Show special warning when Eye Beam is on you",
	WarningEyeBeam			= "Announce Eye Beam targets",
	timerEyebeam			= "Show timer for Eye Beam",
	timerPetrifyingBreath	= "Show timer for Petrifying Breath",
	timerNextShockwave		= "Show timer for Shockwave",
	timerLeftArm			= "Show timer for Left Arm respawn",
	timerRightArm			= "Show timer for Right Arm respawn",
	achievementDisarmed		= "Show timer for Disarm achievement",
	WarnGrip				= "Announce Grip targets",
	SetIconOnGripTarget		= "Set icons on Grip targets"
}

L:SetMiscLocalization{
	Yell_Trigger_arm_left	= "Just a scratch!",
	Yell_Trigger_arm_right	= "Only a flesh wound!",
	Health_Body				= "Kologarn Body",
	Health_Right_Arm		= "Right Arm",
	Health_Left_Arm			= "Left Arm",
	FocusedEyebeam			= "%s focuses his eyes on you!"
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
	SpecWarnBlast		= "Sentinel Blast - Interrupt",
	SpecWarnVoid		= "Void Zone - Move away",
	WarnCatDied 		= "Feral Defender down (%d lives remaining)",
	WarnCatDiedOne 		= "Feral Defender down (1 life remaining)",
	WarnFearSoon 		= "Next Terrifying Screech soon",
}

L:SetOptionLocalization{
	SpecWarnBlast		= "Show special warning for Sentinel Blast (to interrupt)",
	SpecWarnVoid		= "Show special warning when you are affected by Feral Essence",
	WarnFearSoon		= "Show pre-warning for Terrifying Screech",
	WarnCatDied			= "Show warning when Feral Defender dies",
	WarnCatDiedOne		= "Show warning when Feral Defender has 1 life remaining"
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
	WarningStormCloud	= "Storm Cloud on >%s<", 
}

L:SetTimerLocalization{
	TimerFlashFreeze	= "Flash Freeze incoming",
}

L:SetOptionLocalization{
	TimerFlashFreeze		= "Show timer for Flash Freeze cast",
	WarningFlashFreeze		= "Show special warning for Flash Freeze",
	PlaySoundOnFlashFreeze	= "Play sound on Flash Freeze cast",
	WarningStormCloud		= "Announce Storm Cloud targets",
	YellOnStormCloud		= "Yell when Storm Cloud is active",
	SetIconOnStormCloud		= "Set icons on Storm Cloud targets"
}

L:SetMiscLocalization{
	YellKill	= "I... I am released from his grasp... at last.",
	YellCloud	= "Storm Cloud on me!"
}


--------------
--  Thorim  --
--------------
L = DBM:GetModLocalization("Thorim")

L:SetGeneralLocalization{
	name = "Thorim"
}

L:SetWarningLocalization{
	WarningPhase2			= "Phase 2",
	WarningLightningCharge	= "Lightning Charge",
	LightningOrb			= "Lightning Shock - Move away"
}

L:SetTimerLocalization{
	TimerHardmode	= "Hard mode"
}

L:SetOptionLocalization{
	TimerHardmode			= "Show timer for hard mode",
	WarningLightningCharge	= "Show warning for Lightning Charge",
	WarningPhase2			= "Announce Phase 2",
	RangeFrame				= "Show range frame",
	AnnounceFails			= "Post player fails for Lightning Charge to raid chat (requires announce to be enabled and leader/promoted status)",
	LightningOrb			= "Show special warning for Lightning Shock"
}

L:SetMiscLocalization{
	YellPhase1		= "Interlopers! You mortals who dare to interfere with my sport will pay.... Wait--you...",
	YellPhase2		= "Impertinent whelps, you dare challenge me atop my pedestal? I will crush you myself!",
	YellKill		= "Stay your arms! I yield!",
	ChargeOn		= "Lightning Charge: %s",
	Charge			= "Lightning Charge fails (this try): %s" 
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
	WarnPhase2		= "Phase 2",
	WarnSimulKill	= "First add down - Resurrection in ~12 seconds",
	WarnFury		= "Nature's Fury on >%s<",
	SpecWarnFury	= "Nature's Fury on you",
	WarningTremor	= "Ground Tremor - Stop casting",
	WarnRoots		= "Iron Roots on >%s<",
	UnstableEnergy	= "Unstable Energy - Move away"
}

L:SetTimerLocalization{
	TimerUnstableSunBeam	= "Sun Beam: %s",
	TimerSimulKill			= "Resurrection",
	TimerFuryYou			= "Nature's Fury on you",
	TrashRespawnTimer		= "Freya trash respawn"
}

L:SetOptionLocalization{
	WarnPhase2		= "Announce Phase 2",
	WarnSimulKill	= "Announce first mob down",
	WarnFury		= "Announce Nature's Fury targets",
	WarnRoots		= "Announce Iron Roots targets",
	SpecWarnFury	= "Show special warning when you are affected by Nature's Fury",
	WarningTremor	= "Show special warning for Ground Tremor (hard mode)",
	PlaySoundOnFury = "Play sound when you are affected by Nature's Fury",
	TimerSimulKill	= "Show timer for mob resurrection",
	UnstableEnergy	= "Show special warning when you are affected by Unstable Energy"
}

----------------------
--  Freya's Elders  --
----------------------
L = DBM:GetModLocalization("Freya_Elders")

L:SetGeneralLocalization{
	name = "Freya's Elders"
}

L:SetMiscLocalization{
	TrashRespawnTimer	= "Freya trash respawn"
}

L:SetWarningLocalization{
	SpecWarnGroundTremor	= "Ground Tremor - Stop casting",
	SpecWarnFistOfStone		= "Fists of Stone"
}

L:SetOptionLocalization{
	SpecWarnFistOfStone		= "Show special warning for Fists of Stone",
	SpecWarnGroundTremor	= "Show special warning for Ground Tremor",
	PlaySoundOnFistOfStone	= "Play sound on Fists of Stone",
	TrashRespawnTimer		= "Show timer for trash respawn"
}


---------------
--  Mimiron  --
---------------
L = DBM:GetModLocalization("Mimiron")

L:SetGeneralLocalization{
	name = "Mimiron"
}

L:SetWarningLocalization{
	DarkGlare			= "Laser Barrage",
	WarningPlasmaBlast	= "Plasma Blast on %s - Heal",
	WarnShell			= "Napalm Shells on >%s<",
	WarnBlast			= "Plasma Blast on >%s<",
	MagneticCore		= ">%s< has Magnetic Core",
	WarningShockBlast	= "Shock Blast - Run away",
	WarnBombSpawn		= "Bomb Bot spawned"
}

L:SetTimerLocalization{
	TimerHardmode		= "Hard mode - Self-destruct",
	TimeToPhase2		= "Phase 2",
	TimeToPhase3		= "Phase 3",
	TimeToPhase4		= "Phase 4"
}

L:SetOptionLocalization{
	DarkGlare				= "Show special warning for Laser Barrage",
	WarnBlast				= "Announce Plasma Blast targets",
	WarnShell				= "Announce Napalm Shells targets",
	TimeToPhase2			= "Show timer for Phase 2",
	TimeToPhase3			= "Show timer for Phase 3",
	TimeToPhase4			= "Show timer for Phase 4",
	MagneticCore			= "Announce Magnetic Core looters",
	HealthFramePhase4		= "Show health frame in Phase 4",
	AutoChangeLootToFFA		= "Switch loot mode to Free for All in Phase 3",
	WarnBombSpawn			= "Show warning for Bomb Bots",
	TimerHardmode			= "Show timer for hard mode",
	PlaySoundOnShockBlast	= "Play sound on Shock Blast",
	PlaySoundOnDarkGlare	= "Play sound on Laser Barrage",
	ShockBlastWarningInP1	= "Show special warning for Shock Blast in Phase 1",
	ShockBlastWarningInP4	= "Show special warning for Shock Blast in Phase 4",
}

L:SetMiscLocalization{
	MobPhase1		= "Leviathan Mk II",
	MobPhase2		= "VX-001",
	MobPhase3		= "Aerial Command Unit",
	YellPull		= "We haven't much time, friends! You're going to help me test out my latest and greatest creation. Now, before you change your minds, remember that you kind of owe it to me after the mess you made with the XT-002.",	
	YellHardPull	= "Now, why would you go and do something like that? Didn't you see the sign that said, \"DO NOT PUSH THIS BUTTON!\"? How will we finish testing with the self-destruct mechanism active?",
	YellPhase2		= "WONDERFUL! Positively marvelous results! Hull integrity at 98.9 percent! Barely a dent! Moving right along.",
	YellPhase3		= "Thank you, friends! Your efforts have yielded some fantastic data! Now, where did I put-- oh, there it is.",
	YellPhase4		= "Preliminary testing phase complete. Now comes the true test!",
	LootMsg			= "([^%s]+).*Hitem:(%d+)"
}


---------------------
--  General Vezax  --
---------------------
L = DBM:GetModLocalization("GeneralVezax")

L:SetGeneralLocalization{
	name = "General Vezax"
}

L:SetTimerLocalization{
	hardmodeSpawn = "Saronite Animus spawn"
}

L:SetWarningLocalization{
	SpecialWarningShadowCrash		= "Shadow Crash on you - Move away",
	SpecialWarningSurgeDarkness		= "Surge of Darkness",
	WarningShadowCrash				= "Shadow Crash on >%s<",
	SpecialWarningShadowCrashNear	= "Shadow Crash near you - Watch out",
	WarningLeechLife				= "Life Leech on >%s<",
	SpecialWarningLLYou				= "Life Leech on you",
	SpecialWarningLLNear			= "Life Leech on %s near you"
}

L:SetOptionLocalization{
	WarningShadowCrash				= "Announce Shadow Crash targets",
	SetIconOnShadowCrash			= "Set icons on Shadow Crash targets (skull)",
	SetIconOnLifeLeach				= "Set icons on Life Leech targets (cross)",
	SpecialWarningSurgeDarkness		= "Show special warning for Surge of Darkness",
	SpecialWarningShadowCrash		= "Show special warning for Shadow Crash",
	SpecialWarningShadowCrashNear	= "Show special warning for Shadow Crash near you",
	SpecialWarningLLYou				= "Show special warning when you are affected by Life Leech",
	SpecialWarningLLNear			= "Show special warning for Life Leech near you",
	CrashWhisper					= "Send whisper to Shadow Crash targets",
	YellOnLifeLeech					= "Yell on Life Leech",
	YellOnShadowCrash				= "Yell on Shadow Crash",
	WarningLeechLife				= "Announce Life Leech targets",
	hardmodeSpawn					= "Show timer for Saronite Animus spawn (hard mode)"
}

L:SetMiscLocalization{
	EmoteSaroniteVapors	= "A cloud of saronite vapors coalesces nearby!",
	CrashWhisper		= "Shadow Crash on you - Run away",
	YellLeech			= "Life Leech on me!",
	YellCrash			= "Shadow Crash on me!"
}


------------------
--  Yogg-Saron  --
------------------
L = DBM:GetModLocalization("YoggSaron")

L:SetGeneralLocalization{
	name = "Yogg-Saron"
}

L:SetMiscLocalization{
	YellPull 			= "The time to strike at the head of the beast will soon be upon us! Focus your anger and hatred on his minions!",
	YellPhase2	 		= "I am the lucid dream.",
	Sara 				= "Sara",
	WhisperBrainLink 	= "Brain Link on you - Run to %s",
	WarningYellSqueeze	= "Squeeze on me! Help me!"
}

L:SetWarningLocalization{
	WarningGuardianSpawned 			= "Guardian spawned",
	WarningCrusherTentacleSpawned	= "Crusher Tentacle spawned",
	WarningP2 						= "Phase 2",
	WarningP3 						= "Phase 3",
	WarningBrainLink 				= "Brain Link on >%s< and >%s<",
	SpecWarnBrainLink 				= "Brain Link on you and %s",
	WarningSanity 					= "%d Sanity debuffs remaining",
	SpecWarnSanity 					= "%d Sanity debuffs remaining",
	SpecWarnGuardianLow				= "Stop attacking this Guardian",
	WarnMadness						= "Casting Induce Madness",
	SpecWarnMadnessOutNow			= "Induce Madness ending - Move out",
	WarnBrainPortalSoon				= "Brain Portal in 3 seconds",	
	WarnSqueeze 					= "Squeeze: >%s<",
	WarnFavor						= "Sara's Fervor on >%s<",
	SpecWarnFavor					= "Sara's Fervor on you",
	WarnEmpowerSoon					= "Empowering Shadows soon",
	SpecWarnMaladyNear				= "Malady of the Mind on %s near you",
	SpecWarnDeafeningRoar			= "Deafening Roar",
	specWarnBrainPortalSoon			= "Brain Portal soon"
}

L:SetTimerLocalization{
	NextPortal	= "Brain Portal"
}

L:SetOptionLocalization{
	WarningGuardianSpawned			= "Show warning for Guardian spawns",
	WarningCrusherTentacleSpawned	= "Show warning for Crusher Tentacle spawns",
	WarningP2						= "Announce Phase 2",
	WarningP3						= "Announce Phase 3",
	WarningBrainLink				= "Announce Brain Link targets",
	SpecWarnBrainLink				= "Show special warning when you are affected by Brain Link",
	WarningSanity					= "Show warning when Sanity is low",
	SpecWarnSanity					= "Show special warning when Sanity is very low",
	SpecWarnGuardianLow				= "Show special warning when Guardian (Phase 1) is low (for DDs)",
	WarnMadness						= "Show warning for Induce Madness",
	WarnBrainPortalSoon				= "Show pre-warning for Brain Portal",
	SpecWarnMadnessOutNow			= "Show special warning shortly before Induce Madness ends",
	SetIconOnFearTarget				= "Set icons on Malady of the Mind targets",
	WarnFavor						= "Announce Sara's Fervor targets",
	SpecWarnFavor					= "Show special warning when you are affected by Sara's Fervor",
	WarnSqueeze						= "Announce Squeeze targets",
	specWarnBrainPortalSoon			= "Show special warning for next Brain Portal",
	WarningSqueeze					= "Yell on Squeeze",
	NextPortal						= "Show timer for next Brain Portal",
	WhisperBrainLink				= "Send whisper to Brain Link targets",
	SetIconOnFavorTarget			= "Set icons on Sara's Fervor targets",
	SetIconOnMCTarget				= "Set icons on mind-controlled targets",
	ShowSaraHealth					= "Show health frame for Sara in Phase 1 (must be targeted by at least one raid member)",
	WarnEmpowerSoon					= "Show pre-warning for Empowering Shadows",
	SpecWarnMaladyNear				= "Show special warning for Malady of the Mind near you",
	SpecWarnDeafeningRoar			= "Show special warning when casting Deafening Roar (silence and for legendary)",
	SetIconOnBrainLinkTarget		= "Set icon on Brain Link targets"
}



