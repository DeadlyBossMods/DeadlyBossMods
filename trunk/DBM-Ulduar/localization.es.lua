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
}
	
L:SetMiscLocalization{
	YellPull	= "Entidades hostiles detectadas. Protocolo de evaluación de amenaza activado. Objetivo principal fijado. Tiempo restante para re-evaluación: 30 segundos.",
	Emote		= "%%s persigue a (%S+)%."
}

L:SetWarningLocalization{
	PursueWarn	    = "Persigue a >%s<!",
	warnNextPursueSoon	    = "Cambiara de objetivo en 5 seg",
	SpecialPursueWarnYou	= "Te persigue a ti!",
	SystemOverload			= "Desconexion de sistemas",
	warnWardofLife			= "Sale un Guarda de Vida"
}

L:SetOptionLocalization{
	SystemOverload			= "Mostrar aviso especial para Desconexión de sistemas.",
	SpecialPursueWarnYou	= "Mostrar aviso especial cuando te persiga a ti.",
	PursueWarn				= "Mostrar aviso a quien persigue.",
	warnNextPursueSoon		= "Mostrar cuando va cambiar de objetivo.",
	warnWardofLife			= "Mostrar aviso cuando salga un Guarda de Vida"
}


-------------
--  Ignis  --
-------------
L = DBM:GetModLocalization("Ignis")

L:SetGeneralLocalization{
	name = "Ignis el Maestro de la Caldera"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
	WarningSlagPot			= "Agarrar en >%s<",
	SpecWarnJetsCast		= "Caños de llamas - Para de castear"
}

L:SetOptionLocalization{
	SpecWarnJetsCast		= "Mostrar aviso especial para Caños de llamas (corta casteos).",
	WarningSlagPot			= "Mostrar aviso a quien va agarrar.",
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
	timerTurret1			    = "Torreta 1",
	timerTurret2			    = "Torreta 2",
	timerTurret3			    = "Torreta 3",
	timerTurret4			    = "Torreta 4",
	timerGrounded		    = "En el suelo"
}
L:SetOptionLocalization{
	SpecWarnDevouringFlame		= "Mostrar aviso especial para Llama devoradora.",
	PlaySoundOnDevouringFlame	= "Mostrar aviso por sonido si pisas la Llama devoradora.",
	warnTurretsReadySoon		= "Mostrar aviso antes de que las torretas esten listas",
	warnTurretsReady		    = "Mostrar aviso si estan listas las torretas.",
	SpecWarnDevouringFlameCast	= "Mostrar aviso especial cuando Llama devoradora se lanze a ti.",
	timerTurret1			    = "Mostrar aviso para Torreta 1",
	timerTurret2			    = "Mostrar aviso para Torreta 2",
	timerTurret3			    = "Mostrar aviso para Torreta 3 ( solo en raid 25 ).",
	timerTurret4			    = "Mostrar aviso para Torreta 4 ( solo en raid 25 ).",
	OptionDevouringFlame		= "Mostrar aviso a quien lanza la Llama devoradora ( poco fiable )",
	timerGrounded		    = "Mostrar cuanto durara en el suelo."
}

L:SetMiscLocalization{
	YellAir				        = "Danos un momento para que nos preparemos para construir las torretas.",
	YellAir2			        = "Listos para salir, ¡impedid que esos enanos se peguen a nuestra espalda!!",
	YellGround			    = "¡Moveros! ¡No seguira mucho mas en el suelo!",
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
	SpecialWarningGravityBomb	= "Bomba de Gravedad en Ti",
	specWarnConsumption			= "Consumo! Muevete!"
}

L:SetOptionLocalization{
	SpecialWarningLightBomb		= "Mostrar aviso especial si Bomba de luz te afecta a ti.",
	SpecialWarningGravityBomb	= "Mostrar aviso especial si Bomba de Gravedad te afecta.",
	specWarnConsumption			= "Mostrar aviso especial cuando te afecte Consumo",
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
	RuneofPower			= "Runa de Poder en >%s<"
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	WarningSupercharge			= "Mostrar aviso si se castea Supercarga",
	PlaySoundLightningTendrils		= "Sonido para Zarcillos de relampagos",
	SetIconOnOverwhelmingPower		= "Poner icono a la persona con Poder sobrecargador",
	SetIconOnStaticDisruption		= "Poner icono para el objetivo de Perturbación estática",
	AlwaysWarnOnOverload			= "Siempre avisar Sobrecarga",
	PlaySoundOnOverload			= "Reproducir sonido para Sobrecarga",
	PlaySoundDeathRune			= "Reproducir sonido para Runa de muerte",
	RuneofPower        			= "Mostrar aviso especial cuando al boss le afecta Runa de poder"
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
	NextCollapsingStar		= "Next Collapsing Star",
	PossibleNextCosmicSmash	= "Next possible Cosmic Smash",
	TimerCombatStart		= "Empieza el combate"
}

L:SetWarningLocalization{
	WarningPhasePunch		= "Phase Punch on >%s< - Stack %d",
	WarningBlackHole		= "Black Hole",
	SpecWarnBigBang			= "Big Bang",
	PreWarningBigBang		= "Big Bang in ~10 seconds",
	WarningCosmicSmash 		= "Cosmic Smash - Explosion in 4 seconds",
	SpecWarnCosmicSmash 	= "Cosmic Smash",
	WarnPhase2Soon			= "Phase 2 soon",
	warnStarLow				= "Collapsing Star is low"
}

L:SetOptionLocalization{
	PreWarningBigBang		= "Show pre-warning for Big Bang",
	SpecWarnBigBang			= "Show special warning for Big Bang",
	WarningPhasePunch		= "Announce Phase Punch targets",
	WarningBlackHole		= "Show warning for Black Hole",
	NextCollapsingStar		= "Show timer for next Collapsing Star",
	WarningCosmicSmash 		= "Show warning for Cosmic Smash",
	SpecWarnCosmicSmash 	= "Show special warning for Cosmic Smash",
	PossibleNextCosmicSmash	= "Show timer for next possible Cosmic Smash",
	TimerCombatStart		= "Show timer for start of combat",
	WarnPhase2Soon			= "Show pre-warning for Phase 2 (at ~23%)",
	warnStarLow				= "Show special warning when Collapsing Star is low (at ~25%)"
}

L:SetMiscLocalization{
	YellPull				= "Your actions are illogical. All possible results for this encounter have been calculated. The Pantheon will receive the Observer's message regardless of outcome.",
	YellKill				= "I have seen worlds bathed in the Makers' flames. Their denizens fading without so much as a whimper. Entire planetary systems born and raised in the time that it takes your mortal hearts to beat once. Yet all throughout, my own heart, devoid of emotion... of empathy. I... have... felt... NOTHING! A million, million lives wasted. Had they all held within them your tenacity? Had they all loved life as you do?",
	Emote_CollapsingStar	= "%s begins to Summon Collapsing Stars!",
	Phase2					= "Behold the tools of creation",
	PullCheck				= "Time until Algalon transmits distress signal= (%d+) min."
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
	WarningEyeBeam			= "Haz ocular en >%s<",
	WarnGrip				= "Agarra a >%s<",
	SpecWarnCrunchArmor2	= "Hender armadura >%d< en ti"
}

L:SetTimerLocalization{
	timerLeftArm			= "Reaparición del brazo izquierdo",
	timerRightArm			= "Reaparición del brazo derecho",
	achievementDisarmed		= "Tiempo para desarmar"
}

L:SetOptionLocalization{
	SpecialWarningEyebeam	= "Mostrar aviso especial si Haz ocular te mira",
	SpecWarnCrunchArmor2	= "Mostrar aviso especial para Hender armadura (>=2 marcas)",
	WarningEyebeam			= "Anunciar objetivo de Haz ocular",
	timerLeftArm			= "Mostrar tiempo para Brazo izquierdo",
	timerRightArm			= "Mostrar tiempo para Brazo derecho",
	achievementDisarmed		= "Mostrar tiempo para el logro Desarmar",
	WarnGrip				= "Anunciar objetivos que Agarrara",
	SetIconOnGripTarget		= "Poner icono a los objetivos de Agarrar",
	SetIconOnEyebeamTarget	= "Poner iconos en objetivos de Haz ocular (cuadrado)",
	PlaySoundOnEyebeam		= "Reproducir sonido al ser ojetivo de Haz ocular"
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
	Defender = "Defensor feral (%d)",
	YellPull = "Some things are better left alone!"
}

L:SetTimerLocalization{
	timerDefender	= "Se activa Defensor feral"
}

L:SetWarningLocalization{
	SpecWarnBlast		= "Explosión de centinela - Interrumpe!",
	SpecWarnVoid		= "Zona de vacio - MUEVETE!",
	WarnCatDied 		= "Defensor feral muerto (Le quedan %d vidas)",
	WarnCatDiedOne 		= "Defensor feral muerto (Le queda 1 vida)",
	WarnFearSoon 		= "Siguiente miedo pronto"
}

L:SetOptionLocalization{
	SpecWarnBlast		= "Mostrar aviso especial para Explosión de centinela",
	SpecWarnVoid		= "Mostrar aviso especial cuando estas en Zona de vacio",
	WarnFearSoon		= "Mostrar aviso para Miedo pronto",
	WarnCatDied			= "Mostrar aviso cuando Defensor Feral muere",
	WarnCatDiedOne		= "Mostrar aviso cuando Defensor Feral muere",
	timerDefender		= "Mostrar tiempo para activación de Defensor feral"
}


-------------
--  Hodir  --
-------------
L = DBM:GetModLocalization("Hodir")

L:SetGeneralLocalization{
	name = "Hodir"
}

L:SetWarningLocalization{
	WarningFlashFreeze	= "Congelación apresurada",
	specWarnBitingCold	= "Frío cortante! Muévete!"
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	WarningFlashFreeze		= "Mostrar aviso especial para Congelación apresurada",
	PlaySoundOnFlashFreeze	= "Reproducir sonido cuando castee Congelación apresurada",
	YellOnStormCloud		= "Gritar cuando tengas Nube tormentosa",
	SetIconOnStormCloud		= "Poner iconos en los objetivos de Nube tormentosa",
	specWarnBitingCold		= "Mostrar aviso especial cuando te afecte Frío cortante"
}

L:SetMiscLocalization{
	YellKill	= "I... I am released from his grasp... at last.",
	YellCloud	= "Nube tormentosa en mi!"
}

--------------
--  Thorim  --
--------------
L = DBM:GetModLocalization("Thorim")

L:SetGeneralLocalization{
	name = "Thorim"
}

L:SetWarningLocalization{
	LightningOrb	= "Choque de relámpagos! Muévete!"
}

L:SetTimerLocalization{
	TimerHardmode	= "Hard mode"
}

L:SetOptionLocalization{
	TimerHardmode	= "Mostrar tiempo para hard mode",
	RangeFrame		= "Mostrar distancia",
	AnnounceFails	= "Anunciar los fallos de Cargar relámpago en el chat de raid\n(require 'anunciar' habilitado y líder o ayudante de banda)",
	LightningOrb	= "Mostrar aviso especial para Choque de relámpagos"
}

L:SetMiscLocalization{
	YellPhase1	= "Interlopers! You mortals who dare to interfere with my sport will pay.... Wait--you...",
	YellPhase2	= "Impertinent whelps, you dare challenge me atop my pedestal? I will crush you myself!",
	YellKill	= "Stay your arms! I yield!",
	ChargeOn	= "Cargar relámpago: %s",
	Charge		= "Fallos de Cargar relámpago (este try): %s" 
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
	WaterSpirit	= "Espíritu de agua antiguo",
	Snaplasher	= "Quiebrazotador",
	StormLasher	= "Azotador de tormenta",
	YellKill	= "His hold on me dissipates. I can see clearly once more. Thank you, heroes.",
	TrashRespawnTimer	= "Reaparicion de Adds de Freya"
}

L:SetWarningLocalization{
	WarnSimulKill	= "Primer add muerto - Resurrección en ~12 seg",
	SpecWarnFury	= "Furia de la naturaleza en ti!",
	WarningTremor   = "Tremor terrenal! Para de castear!",
	WarnRoots	= "Raices en >%s<",
	UnstableEnergy	= "Energía inestable! Muévete!"
}

L:SetTimerLocalization{
	TimerSimulKill		= "Resurrección",
}

L:SetOptionLocalization{
	WarnSimulKill		= "Anunciar primer mob muerto",
	WarnRoots			= "Anunciar objetivos de raíces férreas",
	SpecWarnFury		= "Mostrar aviso especial para Furia de la naturaleza",
	WarningTremor		= "Mostrar aviso especial para Tremor terrenal (hard mode)",
	PlaySoundOnFury 	= "Reproducir sonido cuando te afecte Furia de la naturaleza",
	TimerSimulKill		= "Mostrar resureccion de los mobs",
	UnstableEnergy		= "Mostrar aviso especial para Energía inestable"
}

-- Elders
L = DBM:GetModLocalization("Freya_Elders")

L:SetGeneralLocalization{
	name = "Ancestros de Freya"
}

L:SetMiscLocalization{
	TrashRespawnTimer	= "Reaparicion de Adds de Freya"
}

L:SetWarningLocalization{
	SpecWarnGroundTremor	= "Tremor terrenal! Para de castear!",
	SpecWarnFistOfStone		= "Puños de piedra"
}

L:SetOptionLocalization{
	SpecWarnFistOfStone	= "Mostrar aviso especial para Puños de piedra",
	SpecWarnGroundTremor	= "Mostrar aviso especial para Tremor terrenal",
	PlaySoundOnFistOfStone	= "Reproducir sonido cuando castee Puños de piedra",
	TrashRespawnTimer	= "Mostrar tiempo para reaparición de adds"
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
	MagneticCore		= ">%s< got Magnetic Core",
	WarningShockBlast	= "Shock Blast - MOVE AWAY",
	WarnBombSpawn		= "Bomb Bot spawned"
}

L:SetTimerLocalization{
	TimerHardmode		= "Hard Mode - Self-Destruct",
	TimeToPhase2		= "Phase 2",
	TimeToPhase3		= "Phase 3",
	TimeToPhase4		= "Phase 4"
}

L:SetOptionLocalization{
	DarkGlare				= "Show special warning for Laser Barrage",
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
	RangeFrame				= "Show range frame in Phase 1"
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
	SpecialWarningShadowCrash		= "Show special warning for Shadow Crash (must be targeted or focused by at least one raid member)",
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
	WarningYellSqueeze	= "Squeeze on me! Help me!"
}

L:SetWarningLocalization{
	WarningGuardianSpawned 			= "Guardian spawned",
	WarningCrusherTentacleSpawned	= "Crusher Tentacle spawned",
	SpecWarnBrainLink 				= "Brain Link on you",
	WarningSanity 					= "%d Sanity debuffs remaining",
	SpecWarnSanity 					= "%d Sanity debuffs remaining",
	SpecWarnGuardianLow				= "Stop attacking this Guardian",
	SpecWarnMadnessOutNow			= "Induce Madness ending - Move out",
	WarnBrainPortalSoon				= "Brain Portal in 3 seconds",	
	SpecWarnFervor					= "Sara's Fervor on you",
	SpecWarnFervorCast				= "Sara's Fervor is being cast on you",
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
	WarningBrainLink				= "Announce Brain Link targets",
	SpecWarnBrainLink				= "Show special warning when you are affected by Brain Link",
	WarningSanity					= "Show warning when Sanity is low",
	SpecWarnSanity					= "Show special warning when Sanity is very low",
	SpecWarnGuardianLow				= "Show special warning when Guardian (Phase 1) is low (for DDs)",
	WarnBrainPortalSoon				= "Show pre-warning for Brain Portal",
	SpecWarnMadnessOutNow			= "Show special warning shortly before Induce Madness ends",
	SetIconOnFearTarget				= "Set icons on Malady of the Mind targets",
	SpecWarnFervor					= "Show special warning when you are affected by Sara's Fervor",
	SpecWarnFervorCast				= "Show special warning when Sara's Fervor is being cast on you (must be targeted or focused by at least one raid member)",
	specWarnBrainPortalSoon			= "Show special warning for next Brain Portal",
	WarningSqueeze					= "Yell on Squeeze",
	NextPortal						= "Show timer for next Brain Portal",
	SetIconOnFervorTarget			= "Set icons on Sara's Fervor targets",
	SetIconOnMCTarget				= "Set icons on mind-controlled targets",
	ShowSaraHealth					= "Show health frame for Sara in Phase 1 (must be targeted or focused by at least one raid member)",
	WarnEmpowerSoon					= "Show pre-warning for Empowering Shadows",
	SpecWarnMaladyNear				= "Show special warning for Malady of the Mind near you",
	SpecWarnDeafeningRoar			= "Show special warning when casting Deafening Roar (silence and for legendary)",
	SetIconOnBrainLinkTarget		= "Set icons on Brain Link targets"
}