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
	timerTurret4			= "Turret 4",
	timerGroundedTemp		= "on the Ground"
}
L:SetOptionLocalization{
	timerDeepBreathCooldown		= "Show timer for next Flame Breath",
	timerDeepBreathCast		= "Show Flame Breath cast timer",
	SpecWarnDevouringFlame		= "Show Special Warning while in Devouring Flame patch",
	PlaySoundOnDevouringFlame	= "Play Sound when afflicted by Devoring Flame",
	timerAllTurretsReady		= "Show timer for turrets",
	warnTurretsReadySoon		= "Show pre-warning for turrets",
	warnTurretsReady		= "Show warning for turrets",
	SpecWarnDevouringFlameCast	= "Show Special Warning when Devouring Flame is cast on you",
	timerTurret1			= "Show timer for Turret 1",
	timerTurret2			= "Show timer for Turret 2",
	timerTurret3			= "Show timer for Turret 3 (Heroic)",
	timerTurret4			= "Show timer for Turret 4 (Heroic)",
	OptionDevouringFlame		= "Announce target of Devouring Flame (unreliable)",
	timerGroundedTemp		= "Show Timer for Ground Phase Duration"
}

L:SetMiscLocalization{
	YellAir				= "Give us a moment to prepare to build the turrets.",
	YellAir2			= "Fires out! Let's rebuild those turrets!",
	YellGroundTemp			= "Move quickly! She won't remain grounded for long!",
	EmotePhase2			= "%%s grounded permanently!",
	FlamecastUnknown		= DBM_CORE_UNKNOWN
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
	WarningRuneofSummoning			= "Rune of Summoning",
	Overload				= "Overload - MOVE AWAY",
	WarningStaticDisruption			= "Static Disruption on >%s<"
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
	timerRuneofDeath		= "Rune of Death"
}

L:SetOptionLocalization{
	TimerSupercharge			= "Show Supercharge Timer",
	WarningSupercharge			= "Show warning when Supercharge is  being cast",
	WarningChainlight			= "Announce Chain Lightning",
	TimerOverload				= "Show Overload cast timer",
	TimerLightningWhirl			= "Show Lightning Whirl cast timer",
	LightningTendrils			= "Show Special Warning for Lightning Tendrils",
	TimerLightningTendrils			= "Show Lightning Tendrils duration timer",
	PlaySoundLightningTendrils		= "Play Sound on Lightning Tendrils",
	WarningFusionPunch			= "Announce Fusion Punch",
	timerFusionPunchCast			= "Show Castbar for Fusion Punch",
	timerFusionPunchActive			= "Show Fusion Punch timer",
	WarningOverwhelmingPower		= "Announce Overwhelming Power",
	timerOverwhelmingPower			= "Show Overwhelming Power timer",
	SetIconOnOverwhelmingPower		= "Set Icon on Overwhelming Power target",
	timerRunicBarrier			= "Show Runic Barrier timer",
	WarningRuneofPower			= "Announce Rune of Power",
	WarningRuneofDeath			= "Announce Rune of Death",
	WarningRuneofSummoning			= "Announce Rune of Summoning",
	RuneofDeath				= "Show Special Warning for Rune of Death",
	timerRuneofDeath			= "Show Rune of Death duration timer",
	SetIconOnStaticDisruption		= "Set Icon on Static Disruption Target",
	Overload				= "Show Special Warning for Overload",
	AllwaysWarnOnOverload			= "Always Warn on Overload (otherwise only when targeted)",
	PlaySoundOnOverload			= "Play Sound on Overload",
	WarningStaticDisruption			= "Announce Static Disruption"
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
	NextCollapsingStar		= "Next Collapsing Star"
}
L:SetWarningLocalization{
	WarningPhasePunch		= "Phase Punch on >%s< - Stack %d",
	WarningBlackHole		= "Black Hole",
	WarningBigBang			= "Big Bang NOW",
	SpecWarnBigBang			= "Big Bang",
	PreWarningBigBang		= "Big Bang in ~10 sec",
	WarningCosmicSmash 		= "Cosmic Smash - Explosion in 4 sec",
	SpecWarnCosmicSmash 	= "Cosmic Smash"
}

L:SetOptionLocalization{
	SpecWarnPhasePunch		= "Show Special Warning when Phase Punch on you",
	WarningBigBang			= "Announce Big Bang Cast",
	PreWarningBigBang		= "Pre Announce Big Bang",
	SpecWarnBigBang			= "Show Special Warning for Big Bang",
	WarningPhasePunch		= "Announce Phase Punch target",
	WarningBlackHole		= "Announce Black Hole",
	NextCollapsingStar		= "Show Timer for Next Colapsing Star",
	WarningCosmicSmash 		= "Announce Cosmic Smash",
	SpecWarnCosmicSmash 	= "Show Special Warning for Cosmic Smash"
}

L:SetMiscLocalization{
	YellPull				= "Your actions are illogical. All possible results for this encounter have been calculated. The Pantheon will receive the Observer's message regardless of outcome.",
	YellPullFirst			= "",
	Emote_CollapsingStars	= "%s begins to Summon Collapsing Stars!",
	Emote_CosmicSmash	= "%s begins to cast Cosmic Smash!"

}


----------------
--  Kologarn  --
----------------
L = DBM:GetModLocalization("Kologarn")

L:SetGeneralLocalization{
	name = "Kologarn"
}

L:SetWarningLocalization{
	SpecialWarningEyebeam	= "Eye Beam on You - MOVE",
	WarningEyebeam			= "Eye Beam on >%s<",
	WarnGrip				= "Grip on >%s<"
}

L:SetTimerLocalization{
	timerEyebeam			= "Eye Beam: %s",
	timerPetrifyingBreath	= "Petrifying Breath",
	timerNextShockwave		= "Next Shockwave",
	timerLeftArm			= "Respawn Left Arm",
	timerRightArm			= "Respawn Right Arm",
	achievementDisarmed		= "Time for Disarm"
}

L:SetOptionLocalization{
	SpecialWarningEyebeam	= "Show a Special Warning for Eye Beam on YOU",
	WarningEyebeam			= "Announce Eye Beam target",
	timerEyebeam			= "Show timer for Eye Beam",
	timerPetrifyingBreath	= "Show timer for Petrifying Breath",
	timerNextShockwave		= "Show timer for Shockwave",
	timerLeftArm			= "Show timer for Arm Respawn (left)",
	timerRightArm			= "Show timer for Arm Respawn (right)",
	achievementDisarmed		= "Show timer for Disarm Achievement",
	WarnGrip				= "Announce Grip Targets",
	WarnEyeBeam				= "Announce Eye Beam Target",
	SetIconOnGripTarget		= "Set Icons on Grip Targets"
}

L:SetMiscLocalization{
	Yell_Trigger_arm_left	= "Just a scratch!",
	Yell_Trigger_arm_right	= "Only a flesh wound!",
	Health_Body				= "Kologarn Body",
	Health_Right_Arm		= "right Arm",
	Health_Left_Arm			= "left Arm",
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
	SpecWarnBlast		= "Sentinel Blast - Interrupt!",
	SpecWarnVoid		= "Void Zone - MOVE!",
	WarnCatDied 		= "Feral Defender down (%d lives remaining)",
	WarnCatDiedOne 		= "Feral Defender down (1 life remaining)",
	WarnFear			= "Fear!",
	WarnFearSoon 		= "Next Fear soon",
	WarnSonic			= "Sonic Screech!",
	WarnSwarm			= "Guardian Swarm on >%s<"
}

L:SetOptionLocalization{
	SpecWarnBlast		= "Show Special Warning on Sentinel Blast",
	SpecWarnVoid		= "Show Special Warning when standing in Feral Essence",
	WarnFear			= "Show Fear Warning",
	WarnFearSoon		= "Show Fear soon Warning",
	WarnCatDied			= "Show Warning when the Feral Defender dies",
	WarnSwarm			= "Show Warning on Guardian Swarm",
	WarnSonic			= "Show Sonic Screech Warning",
	WarnCatDiedOne		= "Show Warning when Cat dies"
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
	TimerFlashFreeze	= "Flash Freeze incoming",  -- all ppl have to move on the rock patches
}

L:SetOptionLocalization{
	TimerFlashFreeze	= "Show Flash Freeze Cast-Timer",
	WarningFlashFreeze	= "Show Warning for Flash Freeze",
	PlaySoundOnFlashFreeze	= "Play sound on Flash Freeze Cast",
	WarningStormCloud	= "Announce Storm Cloud Players",
	YellOnStormCloud	= "Yell when Storm Cloud active",
	SetIconOnStormCloud	= "Set Icon on Storm Cloud Target"
}

L:SetMiscLocalization{
	YellKill		= "I... I am released from his grasp... at last.",
	YellCloud		= "Storm Cloud on me!"
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
	WarningStormhammer		= "Announce Stormhammer Target",
	WarningLightningCharge		= "Announce Lightning Charge",
	WarningPhase2			= "Announce Phase 2",
	UnbalancingStrike		= "Announce Unbalancing Strike",
	WarningBomb			= "Announce Rune Detonation",
	RangeFrame			= "Show Range Frame",
	AnnounceFails			= "Post player fails for Lightning Charge to the raid chat (requires announce enabled and promoted/leader status)" 
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
	WarnPhase2	= "Phase 2",
	WarnSimulKill	= "First add down - Resurrection in ~12 sec",
	WarnFury	= "Nature's Fury on >%s<",
	SpecWarnFury	= "Nature's Fury on You!",
	WarningTremor   = "Ground Tremor - Stop Casting!",
	WarnRoots	= "Roots on >%s<",
	UnstableEnergy	= "Unstable Energy - MOVE"
}

L:SetTimerLocalization{
	TimerUnstableSunBeam	= "Sun Beam: %s",
	TimerSimulKill		= "Resurrection",
	TimerFuryYou		= "Nature's Fury on you",
	TrashRespawnTimer	= "Freya Trash Respawn"
}

L:SetOptionLocalization{
	WarnPhase2		= "Announce Phase2",
	WarnSimulKill		= "Announce first mob down",
	WarnFury		= "Announce Nature's Fury target",
	WarnRoots		= "Announce Iron Roots targets",
	SpecWarnFury		= "Show Special Warning for Nature's Fury",
	WarningTremor		= "Show Special Warning for Ground Tremor (hard mode)",
	TimerSimulKill		= "Show Timer for mob resurrection",
	UnstableEnergy		= "Show Special Warning for Unstable Energy"
}

-- Elders
L = DBM:GetModLocalization("Freya_Elders")

L:SetGeneralLocalization{
	name = "Freya's Elders"
}

L:SetTimerLocalization{
	TrashRespawnTimer	= "Freya Trash Respawn"
}

L:SetOptionLocalization{
	SpecWarnFistOfStone	= "Show Special Warning for Fist of Stone",
	SpecWarnGroundTremor	= "Show Special Warning for Ground Tremor",
	PlaySoundOnFistOfStone	= "Play Sound on Fist of Stone cast",
	TrashRespawnTimer	= "Show Trash Respawn timer"
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
	WarnShell			= "Napalm Shells on >%s<",
	WarnBlast			= "Plasma Blast on >%s<",
	MagneticCore		= ">%s< got Magnetic Core",
	WarningShockBlast	= "Shock Blast - MOVE AWAY",
	WarnBombSpawn		= "Bomb Bot spawned",
	WarnFrostBomb		= "Frost Bomb",
	WarnFlamesSoon		= "New Flames in ~5sec!"
}

L:SetTimerLocalization{
	ProximityMines		= "New Proximity Mines",
	TimerHardmode		= "Hard Mode - Self-Destruct",
	TimeToPhase2		= "Phase 2",
	TimeToPhase3		= "Phase 3",
	TimeToPhase4		= "Phase 4",
	TimerNewFlames		= "New Flames"
}

L:SetOptionLocalization{
	DarkGlare				= "Show Special Warning for Laser Barrage",
	WarnBlast				= "Announce Plasma Blast target",
	WarnShell				= "Announce Napalm Shells target",
	TimeToPhase2			= "Show Timer for Phase 2",
	TimeToPhase3			= "Show Timer for Phase 3",
	TimeToPhase4			= "Show Timer for Phase 4",
	MagneticCore			= "Announce Magnetic Core looter",
	HealthFramePhase4		= "Show Health Frame in Phase 4",
	AutoChangeLootToFFA		= "Switch Loot Mode to Free For All in Phase 3",
	WarnBombSpawn			= "Announce Bomb Bots",
	TimerHardmode			= "Show Timer for Hard Mode",
	PlaySoundOnShockBlast	= "Play Sound on Shock Blast",
	PlaySoundOnDarkGlare	= "Play Sound on Dark Glare",
	ShockBlastWarningInP1	= "Show Special Warning for Shock Blast in Phase 1",
	ShockBlastWarningInP4	= "Show Special Warning for Shock Blast in Phase 4",
	WarnFrostBomb		= "Announce Frost Bomb"
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


--------------------
--  GeneralVezax  --
--------------------
L = DBM:GetModLocalization("GeneralVezax")

L:SetGeneralLocalization{
	name = "General Vezax"
}

L:SetTimerLocalization{
	hardmodeSpawn = "Saronite Animus spawn"
}

L:SetWarningLocalization{
	SpecialWarningShadowCrash	= "Shadow Crash on You",
	SpecialWarningSurgeDarkness	= "Surge of Darkness",
	WarningShadowCrash		= "Shadow Crash on >%s<",
	SpecialWarningShadowCrashNear	= "Shadow Crash near you!",
	WarningLeechLife		= "Life Leech on >%s<",
	SpecialWarningLLYou		= "Life Leech on you!",
	SpecialWarningLLNear		= "Life Leech on %s near you!"
}

L:SetOptionLocalization{
	WarningShadowCrash		= "Show Warning for Shadow Crash",
	SetIconOnShadowCrash		= "Set Icon on Shadow Crash target (skull)",
	SetIconOnLifeLeach		= "Set Icon on Life Leech target (cross)",
	SpecialWarningSurgeDarkness	= "Show Special Warning for Surge of Darkness",
	SpecialWarningShadowCrash	= "Show Special Warning for Shadow Crash",
	SpecialWarningShadowCrashNear	= "Show Special Warning for Shadow Crash in near of you",
	SpecialWarningLLYou		= "Show Special Warning for Life Leech on you",
	SpecialWarningLLNear		= "Show Special Warning for nearby Life Leech",
	CrashWhisper			= "Send Whisper to Shadow Crash Target",
	YellOnLifeLeech			= "Yell on Life Leech",
	YellOnShadowCrash		= "Yell on Shadow Crash",
	specWarnShadowCrashNear		= "Show Special Warning when Shadow Crash near you",
	WarningLeechLife		= "Announce Life Leech Target",
	hardmodeSpawn			= "Show Timer for Saronite Animus Spawn (hardmode)"
}

L:SetMiscLocalization{
	EmoteSaroniteVapors		= "A cloud of saronite vapors coalesces nearby!",
	CrashWhisper			= "Shadow Crash on You! Run away!",
	YellLeech			= "Life Leech on me!",
	YellCrash			= "Shadow Crash on me!"
}


-----------------
--  YoggSaron  --
-----------------
L = DBM:GetModLocalization("YoggSaron")

L:SetGeneralLocalization{
	name = "Yogg-Saron"
}

L:SetMiscLocalization{
	YellPull 			= "The time to strike at the head of the beast will soon be upon us! Focus your anger and hatred on his minions!",
	YellPhase2	 		= "I am the lucid dream.",
	Sara 				= "Sara",
	WhisperBrainLink 	= "Brain Link on you! Run to %s!",
	WarningYellSqueeze	= "Squeeze on me! Help me!"
}

L:SetWarningLocalization{
	WarningGuardianSpawned 			= "Guardian spawned",
	WarningCrusherTentacleSpawned	= "Crusher Tentacle Spawned",
	WarningP2 						= "Phase 2",
	WarningBrainLink 				= "Brain Link on >%s< and >%s<",
	SpecWarnBrainLink 				= "Brain Link on you and %s!",
	WarningSanity 					= "%d Sanity debuffs remaining",
	SpecWarnSanity 					= "%d Sanity debuffs remaining",
	SpecWarnGuardianLow				= "Stop attacking this Guardian!",
	WarnMadness						= "Casting Induce Madness",
	SpecWarnMadnessOutNow			= "Madness ends - MOVE OUT",
	WarnBrainPortalSoon				= "Portal  in 3 sec",	
	WarnSqueeze 					= "Squeeze: >%s<",
	WarnFavor						= "Sara's Fervor on >%s<",
	SpecWarnFavor					= "Sara's Fervor on YOU",
	WarnEmpowerSoon					= "Empowering Shadows Soon!",
	SpecWarnMaladyNear				= "Malady Near You on >%s<"	,
	SpecWarnDeafeningRoar			= "Deafening Roar"
}

L:SetTimerLocalization{
	NextPortal			= "Brain Portal"
}

L:SetOptionLocalization{
	WarningGuardianSpawned			= "Announce Guardian Spawns",
	WarningCrusherTentacleSpawned	= "Announce Crusher Tentacle Spawns",
	WarningP2						= "Announce Phase 2",
	WarningP3						= "Announce Phase 3",
	WarningBrainLink				= "Announce Brain Links",
	SpecWarnBrainLink				= "Show Special Warning when Brain Linked",
	WarningSanity					= "Show Warning when Sanity low",
	SpecWarnSanity					= "Show Special Warning when Sanity very low",
	SpecWarnGuardianLow				= "Show Special Warning when Guardian (P1) is low (for DDs)",
	WarnMadness						= "Announce Madness",
	WarnBrainPortalSoon				= "Announce Portal",
	SpecWarnMadnessOutNow			= "Show Special Warning shortly before Madness ends",
	SetIconOnFearTarget				= "Set Icon on Fear Target",
	WarnFavor						= "Announce Sara's Fervor target",
	SpecWarnFavor					= "Show Special Warning for Sara's Fervor",
	WarnSqueeze						= "Announce Squeeze target",
	specWarnBrainPortalSoon			= "Announce Brain Portal soon",
	WarningSqueeze					= "Announce Squeeze Targets",
	NextPortal						= "Show Timer for Next Brain Portal",
	WhisperBrainLink				= "Whisper players on Brain Link",
	SetIconOnFavorTarget			= "Set Icon on Saras Fervor target",
	SetIconOnMCTarget				= "Set Icon on Mindcontrol target",
	ShowSaraHealth					= "Show Healthframe for Sara in P1 (must be targeted by at least one Raidmember)",
	WarnEmpowerSoon					= "Warn for Empowering Shadows soon",
	SpecWarnMaladyNear				= "Special Warning if someone close to you has Malady of the Mind",
	SpecWarnDeafeningRoar			= "Special Warning when casting Deafening Roar (silience and for Legendary!)"
}



