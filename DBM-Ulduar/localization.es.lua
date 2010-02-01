if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

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
	name = "Algalon el Observador"
}

L:SetTimerLocalization{
	NextCollapsingStar		= "Siguiente Estrella en colapso",
	PossibleNextCosmicSmash	= "Posible siguiente Machaque cósmico",
	TimerCombatStart		= "Empieza el combate"
}

L:SetWarningLocalization{
	WarningPhasePunch		= "Cambiar de fase en >%s< - Stack %d",
	WarningBlackHole		= "Agujero negro",
	SpecWarnBigBang			= "Big Bang",
	PreWarningBigBang		= "Big Bang en ~10 segundos",
	WarningCosmicSmash 		= "Machaque cósmico - Explosion en 4 segundos",
	SpecWarnCosmicSmash 	= "Machaque cósmico",
	WarnPhase2Soon			= "Fase 2 pronto",
	warnStarLow				= "Estrella en colapso a punto de morir"
}

L:SetOptionLocalization{
	PreWarningBigBang		= "Mostrar pre-aviso para Big Bang",
	SpecWarnBigBang			= "Mostrar aviso especial para Big Bang",
	WarningPhasePunch		= "Anunciar objetivos de Cambiar de fase",
	WarningBlackHole		= "Mostrar aviso para Agujero negro",
	NextCollapsingStar		= "Mostrar tiempo para siguiente Estrella en colapso",
	WarningCosmicSmash 		= "Mostrar aviso para Machaque cósmico",
	SpecWarnCosmicSmash 	= "Mostrar aviso especial para Machaque cósmico",
	PossibleNextCosmicSmash	= "Mostrar tiempo para posible siguiente Machaque cósmico",
	TimerCombatStart		= "Mostrar tiempo para el inicio del combate",
	WarnPhase2Soon			= "Mostrar pre-aviso para Fase 2 (al ~23%)",
	warnStarLow				= "Mostrar aviso especial cuando una Estrella en colapso esté a punto de morir (al ~25%)"
}

L:SetMiscLocalization{
	YellPull				= "Your actions are illogical. All possible results for this encounter have been calculated. The Pantheon will receive the Observer's message regardless of outcome.",--translate
	YellKill				= "I have seen worlds bathed in the Makers' flames. Their denizens fading without so much as a whimper. Entire planetary systems born and raised in the time that it takes your mortal hearts to beat once. Yet all throughout, my own heart, devoid of emotion... of empathy. I... have... felt... NOTHING! A million, million lives wasted. Had they all held within them your tenacity? Had they all loved life as you do?",--translate
	Emote_CollapsingStar	= "¡%s empieza a invocar Estrellas en colapso!",
	Phase2					= "Behold the tools of creation",--translate
	PullCheck				= "Tiempo hasta que Algalon transmita la señal de auxilio= (%d+) min."
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
	DarkGlare			= "Tromba de láseres",
	MagneticCore		= ">%s< tiene Núcleo magnético",
	WarningShockBlast	= "Explosión de choque! Muévete!",
	WarnBombSpawn		= "Robot bum sale"
}

L:SetTimerLocalization{
	TimerHardmode		= "Modo Difícil - Autodestrucción",
	TimeToPhase2		= "Fase 2",
	TimeToPhase3		= "Fase 3",
	TimeToPhase4		= "Fase 4"
}

L:SetOptionLocalization{
	DarkGlare				= "Mostrar aviso especial para Tromba de láseres",
	TimeToPhase2			= "Mostrar tiempo para Fase 2",
	TimeToPhase3			= "Mostrar tiempo para Fase 3",
	TimeToPhase4			= "Mostrar tiempo para Fase 4",
	MagneticCore			= "Anunciar quen lootea Núcleo magnético",
	HealthFramePhase4		= "Mostrar barra de vida en la fase 4",
	AutoChangeLootToFFA		= "Canviar el loot a Botín Libre en la fase 3",
	WarnBombSpawn			= "Mostrar aviso para Robot bum",
	TimerHardmode			= "Mostrar tiempo para Modo Difícil",
	PlaySoundOnShockBlast	= "Reproducir sonido en Explosión de choque",
	PlaySoundOnDarkGlare	= "Reproducir sonido en Tromba de láseres",
	ShockBlastWarningInP1	= "Mostrar aviso especial para Explosión de choque en Fase 1",
	ShockBlastWarningInP4	= "Mostrar aviso especial para Explosión de choque en Fase 4",
	RangeFrame				= "Mostrar distáncia en Fase 1 (6 yardas)"
}

L:SetMiscLocalization{
	MobPhase1		= "Mk II de leviatán",
	MobPhase2		= "VX-001",
	MobPhase3		= "Unidad de mando aérea",
	YellPull		= "We haven't much time, friends! You're going to help me test out my latest and greatest creation. Now, before you change your minds, remember that you kind of owe it to me after the mess you made with the XT-002.",--translate
	YellHardPull	= "Now, why would you go and do something like that? Didn't you see the sign that said, \"DO NOT PUSH THIS BUTTON!\"? How will we finish testing with the self-destruct mechanism active?",--translate
	YellPhase2		= "WONDERFUL! Positively marvelous results! Hull integrity at 98.9 percent! Barely a dent! Moving right along.",--translate
	YellPhase3		= "Thank you, friends! Your efforts have yielded some fantastic data! Now, where did I put-- oh, there it is.",--translate
	YellPhase4		= "Preliminary testing phase complete. Now comes the true test!",--translate
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
	hardmodeSpawn = "Animus de saronita sale"
}

L:SetWarningLocalization{
	SpecialWarningShadowCrash		= "Fragor de sombra en ti! Muévete!",
	SpecialWarningSurgeDarkness		= "Oleada de oscuridad",
	WarningShadowCrash				= "Fragor de sombra en >%s<",
	SpecialWarningShadowCrashNear	= "Fragor de sombra cerca de ti!",
	WarningLeechLife				= "Drenar vida en >%s<",
	SpecialWarningLLYou				= "Drenar vida en ti!",
	SpecialWarningLLNear			= "Drenar vida en %s cerca de ti"
}

L:SetOptionLocalization{
	WarningShadowCrash				= "Anunciar objetivos de Fragor de sombra",
	SetIconOnShadowCrash			= "Poner iconos en los objetivos de Fragor de sombra (calavera)",
	SetIconOnLifeLeach				= "Poner iconos en los objetivos de Drenar vida (cruz)",
	SpecialWarningSurgeDarkness		= "Mostrar aviso especial para Oleada de oscuridad",
	SpecialWarningShadowCrash		= "Mostrar aviso especial para Fragor de sombra",
	SpecialWarningShadowCrashNear	= "Mostrar aviso especial para Fragor de sombra cerca de ti",
	SpecialWarningLLYou				= "Mostrar aviso especial si te afecta Drenar vida ",
	SpecialWarningLLNear			= "Mostrar aviso especial para Drenar vida cerca de ti",
	CrashWhisper					= "Enviar susurro a los objetivos de Fragor de sombra",
	YellOnLifeLeech					= "Gritar si tienes Drenar vida",
	YellOnShadowCrash				= "Gritar si eres objetivo de Fragor de sombra",
	WarningLeechLife				= "Anunciar los objetivos de Drenar vida",
	hardmodeSpawn					= "Mostrar tiempo para salida de Animus de saronita (Modo Difícil)"
}

L:SetMiscLocalization{
	EmoteSaroniteVapors	= "Sale una nuve de vapor de saronita!",
	CrashWhisper		= "Fragor de sombra en ti! Muévete!",
	YellLeech			= "Drenar vida en mi!",
	YellCrash			= "Fragor de sombra en mi!"
}

------------------
--  Yogg-Saron  --
------------------
L = DBM:GetModLocalization("YoggSaron")

L:SetGeneralLocalization{
	name = "Yogg-Saron"
}

L:SetMiscLocalization{
	YellPull 			= "The time to strike at the head of the beast will soon be upon us! Focus your anger and hatred on his minions!",--translate
	YellPhase2	 		= "I am the lucid dream.",--translate
	Sara 				= "Sara",
	WarningYellSqueeze	= "Exprimir en mi! Ayudadme!"
}

L:SetWarningLocalization{
	WarningGuardianSpawned 			= "Guardián %d sale",
	WarningCrusherTentacleSpawned	= "Tentáculo triturador sale",
	SpecWarnBrainLink 				= "Vínculo cerebral en ti!",
	WarningSanity 					= "%d Cordura restante",
	SpecWarnSanity 					= "%d Cordura restante",
	SpecWarnGuardianLow				= "Deja de atacar a este Guardián",
	SpecWarnMadnessOutNow			= "Inducir a la locura terminando. Muévete!",
	WarnBrainPortalSoon				= "Portal cerebral en 3 segundos",
	SpecWarnFervor					= "Fervor de Sara en ti",
	SpecWarnFervorCast				= "Fervor de Sara esta siendo casteado en ti",
	WarnEmpowerSoon					= "Sombras potenciadas pronto",
	SpecWarnMaladyNear				= "Mal de la mente en %s cerca de ti",
	SpecWarnDeafeningRoar			= "Rugido ensordecedor",
	specWarnBrainPortalSoon			= "Portal cerebral pronto"
}

L:SetTimerLocalization{
	NextPortal	= "Portal cerebral"
}

L:SetOptionLocalization{
	WarningGuardianSpawned			= "Mostrar aviso cuando salga Guardián",
	WarningCrusherTentacleSpawned	= "Mostrar aviso cuando salga Tentáculo triturador",
	WarningBrainLink				= "Anunciar objetivos de Vínculo cerebral",
	SpecWarnBrainLink				= "Mostrar aviso especial cuando te afecte Vínculo cerebral",
	WarningSanity					= "Mostrar aviso cuando tengas poca Cordura",
	SpecWarnSanity					= "Mostrar aviso especial cuando tengas muy poca Cordura",
	SpecWarnGuardianLow				= "Mostrar aviso especial cuando el Guardián esté a punto de morir (Fase 1)",
	WarnBrainPortalSoon				= "Mostrar pre-aviso para Portal cerebral",
	SpecWarnMadnessOutNow			= "Mostrar aviso especial poco antes de que Inducir a la locura termine",
	SetIconOnFearTarget				= "Poner iconos en los objetivos de Mal de la mente",
	SpecWarnFervor					= "Mostrar aviso especial cuando te afecte Fervor de Sara",
	SpecWarnFervorCast				= "Mostrar aviso especial cuando Fervor de Sara esté siendo casteado en ti",
	specWarnBrainPortalSoon			= "Mostrar aviso especial para siguiente Portal cerebral",
	WarningSqueeze					= "Gritar si te afecta Exprimir",
	NextPortal						= "Mostrar tiempo para siguiente Portal cerebral",
	SetIconOnFervorTarget			= "Poner iconos en los objetivos de Fervor de Sara",
	SetIconOnMCTarget				= "Poner iconos en los objetivos con control mental",
	ShowSaraHealth					= "Mostrar barra de vida de Sara en Fase 1",
	WarnEmpowerSoon					= "Mostrar pre-aviso para Sombras potenciadas",
	SpecWarnMaladyNear				= "Mostrar aviso especial para Mal de la mente cerca de ti",
	SpecWarnDeafeningRoar			= "Mostrar aviso especial cuando castee Rugido ensordecedor (para silenciar y legendaria)",
	SetIconOnBrainLinkTarget		= "Poner iconos en los objetivos de Vínculo cerebral"
}