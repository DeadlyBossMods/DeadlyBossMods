if GetLocale() ~= "esES" then return end

local L


----------------------
--  FlameLeviathan  --
----------------------
L = DBM:GetModLocalization("FlameLeviathan")

L:SetGeneralLocalization{
	name = "Leviatán de llamas"
}

L:SetTimerLocalization{
	timerPursued		= "Persigue a: %s",
	timerFlameVents		= "Corriente de Llamas",
	timerSystemOverload	= "Desconexión de sistemas"
}
	
L:SetMiscLocalization{
	YellPull	= "Entidades hostiles detectadas. Protocolo de evaluación de amenaza activado. Objetivo principal fijado. Tiempo restante para re-evaluación: 30 segundos.",
	Emote		= "%%s persigue a (%S+)%."
}

L:SetWarningLocalization{
	pursueTargetWarn	    = "Persigue a >%s<!",
	warnNextPursueSoon	    = "Cambiara de objetivo en 5 seg",
	SpecialPursueWarnYou	= "Te persigue a ti!",
	SystemOverload			= "Desconexion de sistemas"
}

L:SetOptionLocalization{
	timerSystemOverload		= "Mostrar tiempo para Desconexión de sistemas.",
	timerFlameVents			= "Mostrar tiempo para Corriente de Llamas.",
	timerPursued			= "Mostrar tiempo que perseguira al objetivo.",
	SystemOverload			= "Mostrar aviso especial para Desconexión de sistemas.",
	SpecialPursueWarnYou	= "Mostrar aviso especial cuando te persiga a ti.",
	PursueWarn				= "Mostrar aviso a quien persigue.",
	warnNextPursueSoon		= "Mostrar cuando va cambiar de objetivo."
}


-------------
--  Ignis  --
-------------
L = DBM:GetModLocalization("Ignis")

L:SetGeneralLocalization{
	name = "Ignis el Maestro de la Caldera"
}

L:SetTimerLocalization{
	TimerFlameJetsCast		= "Caños de llamas",
	TimerFlameJetsCooldown	= "Caños de llamas en",
	TimerScorch				= "Agostar en",
	TimerScorchCast			= "Agostar",
	TimerSlagPot			= "Agarra a: %s"
}

L:SetWarningLocalization{
	WarningSlagPot			= "Agarrar en >%s<",
	SpecWarnJetsCast		= "Caños de llamas - Para de castear"
}

L:SetOptionLocalization{
	SpecWarnJetsCast		= "Mostrar aviso especial para Caños de llamas (corta casteos).",
	TimerFlameJetsCast		= "Mostrar tiempo para Caños de llamas.",
	TimerFlameJetsCooldown	= "Mostrar el cd de Caños de llamas.",
	TimerScorch				= "Mostrar el cd de Agostar.",
	TimerScorchCast			= "Mostrar cuando va Agostar.",
	WarningSlagPot			= "Mostrar aviso a quien va agarrar.",
	TimerSlagPot			= "Mostrar cuando va agarrar a alguien.",
	SlagPotIcon				= "Mostrar icono a quien agarró"
}

------------------
--  Razorscale  --
------------------
L = DBM:GetModLocalization("Razorscale")

L:SetGeneralLocalization{
	name = "Tajoescama"
}

L:SetWarningLocalization{	
	SpecWarnDevouringFlame		= "Llama devoradora - MUEVETE",
	warnTurretsReadySoon		= "La torreta estara lista en 20 segundos",
	warnTurretsReady		    = "La torreta esta LISTA",
	SpecWarnDevouringFlameCast	= "Llava devoradora en Ti",
	WarnDevouringFlameCast		= "Llama devoradora en >%s<" 
}
L:SetTimerLocalization{
	timerDeepBreathCooldown		= "Siguiente Aliento de Llamas en",
	timerDeepBreathCast		    = "Aliento de Llamas",
	timerAllTurretsReady		= "Torretas",
	timerTurret1			    = "Torreta 1",
	timerTurret2			    = "Torreta 2",
	timerTurret3			    = "Torreta 3",
	timerTurret4			    = "Torreta 4",
	timerGroundedTemp		    = "sobre el suelo"
}
L:SetOptionLocalization{
	timerDeepBreathCooldown		= "Mostrar el cd de Aliente de Llamas.",
	timerDeepBreathCast		    = "Mostrar cuadno hara Aliento de Llamas.",
	SpecWarnDevouringFlame		= "Mostrar aviso especial para Llama devoradora.",
	PlaySoundOnDevouringFlame	= "Mostrar aviso por sonido si pisas la Llama devoradora.",
	timerAllTurretsReady		= "Mostrar tiempo para que las torretas esten listas.",
	warnTurretsReadySoon		= "Mostrar aviso antes de que las torretas esten listas",
	warnTurretsReady		    = "Mostrar aviso si estan listas las torretas.",
	SpecWarnDevouringFlameCast	= "Mostrar aviso especial cuando Llama devoradora se lanze a ti.",
	timerTurret1			    = "Mostrar aviso para Torreta 1",
	timerTurret2			    = "Mostrar aviso para Torreta 2",
	timerTurret3			    = "Mostrar aviso para Torreta 3 ( solo en raid 25 ).",
	timerTurret4			    = "Mostrar aviso para Torreta 4 ( solo en raid 25 ).",
	OptionDevouringFlame		= "Mostrar aviso a quien lanza la Llama devoradora ( poco fiable )",
	timerGroundedTemp		    = "Mostrar cuanto durara en el suelo."
}

L:SetMiscLocalization{
	YellAir				        = "Danos un momento para que nos preparemos para construir las torretas.",
	YellAir2			        = "Listos para salir, ¡impedid que esos enanos se peguen a nuestra espalda!!",
	YellGroundTemp			    = "¡Moveros! ¡No seguira mucho mas en el suelo!",
	EmotePhase2			        = "%%s ha aterrizado permanentemente!",
	FlamecastUnknown		    = DBM_CORE_UNKNOWN
}


-------------
--  XT002  --
-------------
L = DBM:GetModLocalization("XT002")

L:SetGeneralLocalization{
	name = "Desarmador XA-002"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
	SpecialWarningLightBomb 	= "Bomba de luz en Ti!",
	WarningLightBomb			= "Bomba de luz en >%s<",
	SpecialWarningGravityBomb	= "Bomba de Gravedad en Ti",
	WarningGravityBomb			= "Bomba de Gravedad en >%s<",
}

L:SetOptionLocalization{
	SpecialWarningLightBomb		= "Mostrar aviso especial si Bomba de luz te afecta a ti.",
	WarningLightBomb			= "Mostrar aviso para Bomba de Luz.",
	SpecialWarningGravityBomb	= "Mostrar aviso especial si Bomba de Gravedad te afecta.",
	WarningGravityBomb			= "Mostrar aviso para Bomba de Gravedad.",
	PlaySoundOnGravityBomb		= "Avisar por sonido si Bomba de Gravedad te afecta.",
	PlaySoundOnTympanicTantrum	= "Avisar por sonido para Rabia timpánica",
	SetIconOnLightBombTarget	= "Mostrar icono a quien pone Bomba de Luz",
	SetIconOnGravityBombTarget	= "Mostrar icono a quien pone Bomba de Gravedad",
}

-------------------
--  IronCouncil  --
-------------------
L = DBM:GetModLocalization("IronCouncil")

L:SetGeneralLocalization{
	name = "La Asamblea de Hierro"
}

L:SetWarningLocalization{
	WarningSupercharge			= "Supercarga",
	WarningChainlight			= "Cadena de relámpagos",
	WarningFusionPunch			= "Golpe de fusión",
	WarningOverwhelmingPower		= "Poder sobrecogedor en >%s<",
	WarningRuneofPower			= "Runa de poder",
	WarningRuneofDeath			= "Runa de muerte",
	RuneofDeath				= "Runa de muerte - MUEVETE",
	LightningTendrils			= "Zarcillos de relámpagos - MUEVETE",
	WarningRuneofSummoning			= "Runa de invocación",
	Overload				= "Sobrecarga - VETE LEJOS",
	WarningStaticDisruption			= "Perturbación estática en >%s<"
}

L:SetTimerLocalization{
	TimerSupercharge		= "Supercagar",
	TimerOverload			= "Sobrecarga",
	TimerLightningWhirl		= "Remolino de relámpagos",
	TimerLightningTendrils		= "Zarcillos de relámpagos",
	timerFusionPunchCast		= "Golpe de fusión casteo",
	timerFusionPunchActive		= "Golpe de fusión: %s",
	timerOverwhelmingPower		= "Poder sobrecogedor: %s",
	timerRunicBarrier		= "Barrera rúnica",
	timerRuneofDeath		= "Runa de muerte"
}

L:SetOptionLocalization{
	TimerSupercharge			= "Mostrar tiempo de Supercarga",
	WarningSupercharge			= "Mostrar aviso si se castea Supercarga",
	WarningChainlight			= "Anunciar Cadena de relampagos",
	TimerOverload				= "Mostrar tiempo para castear Sobrecarga",
	TimerLightningWhirl			= "Mostrar tiempo para castear Remolino de relampagos",
	LightningTendrils			= "Mostrar aviso especial para Zarcillos de relampagos",
	TimerLightningTendrils			= "Mostrar duracion de Zarcillos de relampagos",
	PlaySoundLightningTendrils		= "Sonido para Zarcillos de relampagos",
	WarningFusionPunch			= "Anunciar Gope de fusion",
	timerFusionPunchCast			= "Mostrar barra de casteo para Golpe de fusion",
	timerFusionPunchActive			= "Mostrar tiempo de Golpe de fusion",
	WarningOverwhelmingPower		= "Anunciar Poder sobrecargador",
	timerOverwhelmingPower			= "Mostrar tiempo de Poder sobrecargador",
	SetIconOnOverwhelmingPower		= "Poner icono a la persona con Poder sobrecargador",
	timerRunicBarrier			= "Mostrar tiempo de Barra runica",
	WarningRuneofPower			= "Anunciar Runa de poder",
	WarningRuneofDeath			= "Anunciar Runa de muerte",
	WarningRuneofSummoning			= "Anunciar Runa de invocacion",
	RuneofDeath				= "Mostrar aviso especial para Runa de muerte",
	timerRuneofDeath			= "Mostrar tiempo que dura Runa de muerte",
	SetIconOnStaticDisruption		= "Poner icono para el objetivo de Perturbación estática",
	Overload				= "Mostrar aviso especial para Sobrecarga",
	AlwaysWarnOnOverload			= "Siempre avisar Sobrecarga",
	PlaySoundOnOverload			= "Reproducir sonido para Sobrecarga",
	WarningStaticDisruption			= "Anunciar Perturbacion estatica"
}

L:SetMiscLocalization{
	Steelbreaker		= "Rompeacero",
	RunemasterMolgeim	= "Maestro de runas Molgeim",
	StormcallerBrundir 	= "Clamatormentas Brundir",
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
	SpecialWarningEyebeam	= "Estas en el Rayo - MUEVETE",
	WarningEyebeam			= "Haz ocular en >%s<",
	WarnGrip				= "Agarra a >%s<"
}

L:SetTimerLocalization{
	timerEyebeam			= "Rayo: %s",
	timerPetrifyingBreath	= "Aliento petrificador",
	timerNextShockwave		= "Siguiente Ola de choque",
	timerLeftArm			= "Reaparición del brazo izquierdo",
	timerRightArm			= "Reaparición del brazo derecho",
	achievementDisarmed		= "Tiempo para desarmar"
}

L:SetOptionLocalization{
	SpecialWarningEyebeam	= "Mostrar aviso especial si Haz ocular te mira",
	WarningEyebeam			= "Anunciar objetivo de Haz ocular",
	timerEyebeam			= "Mostrar tiempo para Haz ocular",
	timerPetrifyingBreath	= "Mostrar tiempo para Aliento petrificador",
	timerNextShockwave		= "Mostrar tiempo para Ola de choque",
	timerLeftArm			= "Mostrar tiempo para Brazo izquierdo",
	timerRightArm			= "Mostrar tiempo para Brazo derecho",
	achievementDisarmed		= "Mostrar tiempo para el logro Desarmar",
	WarnGrip				= "Anunciar objetivos que Agarrara",
	WarnEyeBeam				= "Anunciar objetivos para Haz ocular",
	SetIconOnGripTarget		= "Poner icono a los objetivos de Agarrar"
}

L:SetMiscLocalization{
	Yell_Trigger_arm_left	= "¡No es más que un arañazo!",
	Yell_Trigger_arm_right	= "¡No es más que un arañazo!",
	Health_Body				= "Kologarn",
	Health_Right_Arm		= "Brazo derecho",
	Health_Left_Arm			= "Brazo izquierdo",
	FocusedEyebeam			= "¡%s fija sus ojos en ti, MUEVETE!"
}

---------------
--  Auriaya  --
---------------
L = DBM:GetModLocalization("Auriaya")

L:SetGeneralLocalization{
	name = "Auriaya"
}

L:SetMiscLocalization{
	Defender = "Defensor feral (%d)"
}

L:SetWarningLocalization{
	SpecWarnBlast		= "Explosión de centinela - Interrumpe!",
	SpecWarnVoid		= "Zona de vacio - MUEVETE!",
	WarnCatDied 		= "Defensor feral muerto (Le quedan %d vidas)",
	WarnCatDiedOne 		= "Defensor feral muerto (Le queda 1 vida)",
	WarnFear			= "Miedo!",
	WarnFearSoon 		= "Siguiente miedo pronto",
	WarnSonic			= "Chirrido sónico!",
	WarnSwarm			= "Enjambre del guardián en >%s<"
}

L:SetOptionLocalization{
	SpecWarnBlast		= "Mostrar aviso especial para Explosión de centinela",
	SpecWarnVoid		= "Mostrar aviso especial cuando estas en Zona de vacio",
	WarnFear			= "Mostrar aviso de Miedo",
	WarnFearSoon		= "Mostrar aviso para Miedo pronto",
	WarnCatDied			= "Mostrar aviso cuando Defensor Feral muere",
	WarnSwarm			= "Mostrar aviso para Enjambre del Guardian",
	WarnSonic			= "Mostrar aviso para Chirrido sonico",
	WarnCatDiedOne		= "Mostrar aviso cuando Defensor Feral muere"
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
	TimerFuryYou		= "Nature's Fury en Ti",
	TrashRespawnTimer	= "Reaparicion de Adds de Freya"
}

L:SetOptionLocalization{
	WarnSimulKill		= "Anunciar primer mob muerto",
	WarnFury		= "Anunciar objetivo de Nature's Fury",
	WarnRoots		= "Anunciar objetivos de Iron Roots",
	SpecWarnFury		= "Mostrar aviso especial para Nature's Fury",
	WarningTremor		= "Mostrar aviso especial para Ground Tremor (hard mode)",
	TimerSimulKill		= "Mostrar resureccion de los mobs",
	UnstableEnergy		= "Mostrar aviso especial para Unstable Energy"
}

-- Elders
L = DBM:GetModLocalization("Freya_Elders")

L:SetGeneralLocalization{
	name = "Freya's Elders"
}

L:SetTimerLocalization{
	TrashRespawnTimer	= "Reaparicion de Adds de Freya"
}

L:SetOptionLocalization{
	SpecWarnFistOfStone	= "Mostrar aviso especial para Fist of Stone",
	SpecWarnGroundTremor	= "Mostrar aviso especial para Ground Tremor",
	PlaySoundOnFistOfStone	= "Play Sound on Fist of Stone cast",
	TrashRespawnTimer	= "Mostrar reaoarucib de adds de freya"
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
	SpecialWarningLLYou		= "Show Special Warning for Life Leach on YOU",
	SpecialWarningLLNear		= "Show Special Warning for Life Leach in near of you",
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
	SpecWarnMaladyNear				= "Malady Near You on >%s<"	
}

L:SetTimerLocalization{
	NextPortal			= "Brain Portal"
}

L:SetOptionLocalization{
	WarningGuardianSpawned			= "Announce Guardian Spawns",
	WarningCrusherTentacleSpawned	= "Announce Crusher Tentacle Spawns",
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
	SpecWarnMaladyNear				= "Special Warning if someone close to you has Malady of the Mind"
}



