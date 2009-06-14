if GetLocale() ~= "frFR" then return end

local L


----------------------
--  FlameLeviathan  --
----------------------
L = DBM:GetModLocalization("FlameLeviathan")

L:SetGeneralLocalization{
	name = "Léviathan des flammes"
}

L:SetTimerLocalization{
	timerPursued		= "Poursuivi: %s",
	timerFlameVents		= "Flots de flammes",
	timerSystemOverload	= "Système en surchage"
}
	
L:SetMiscLocalization{
	YellPull		= "Entités hostiles détectées. Protocole d'estimation de menace actif. Acquisition de la cible primaire. Décompte avant réévaluation : 30 secondes.",
	Emote			= "%%s poursuit (%S+)%."
}

L:SetWarningLocalization{
	pursueTargetWarn	= "Poursuit >%s<!",
	warnNextPursueSoon	= "Changement de cible dans 5 Sec"
}

L:SetOptionLocalization{
	timerSystemOverload	= "Activer le timer pour la surchage du système",
	timerFlameVents		= "Activer le timer pour les Flots de flammes",
	timerPursued		= "Activer le timer pour la poursuite",
	SystemOverload		= "Afficher l'avertissement spécial pour la surchage du système",
	SpecialPursueWarnYou	= "Afficher l'avertissement spécial quand un joueur est poursuivi",
	PursueWarn		= "Afficher l'avertissement quand vous êtes poursuivi",
	warnNextPursueSoon	= "Prévenir avant la prochaine poursuite"
}


-------------
--  Ignis  --
-------------
L = DBM:GetModLocalization("Ignis")

L:SetGeneralLocalization{
	name = "Ignis le maître de la Fournaise"
}

L:SetTimerLocalization{
	TimerFlameJetsCast		= "Flots de flammes",
	TimerFlameJetsCooldown	= "Prochain flots de flammes dans",
	TimerScorch				= "Prochaine brûlure dans",
	TimerScorchCast			= "Brûlure",
	TimerSlagPot			= "Marmite de scories: %s"
}

L:SetWarningLocalization{
	WarningSlagPot			= "Marmite de scories sur >%s<",
	SpecWarnJetsCast		= "Flots de flammes - Stop Cast"
}

L:SetOptionLocalization{
	SpecWarnJetsCast	= "Activer l'avertissement spécial pour les Flots de flammes (contresort)",
	TimerFlameJetsCast	= "Afficher le timer des Flots de flammes",
	TimerFlameJetsCooldown	= "Afficher le cooldown du Flots de flammes",
	TimerScorch		= "Afficher le cooldown de brûlure",
	TimerScorchCast		= "Afficher la barre de cast de brûlure",
	WarningSlagPot		= "Annoncer la cible de la Marmite de scories",
	TimerSlagPot		= "Afficher le timer de la Marmite de scories",
	SlagPotIcon		= "Mettre un ic𮥠sur la cible de la Marmite de scories"
}

------------------
--  Razorscale  --
------------------
L = DBM:GetModLocalization("Razorscale")

L:SetGeneralLocalization{
	name = "Tranchécaille"
}     

L:SetWarningLocalization{
	SpecWarnDevouringFlame	= "Flamme dévorante - BOUGEZ",
	warnTurretsReadySoon	= "Quatrième tourelle à harpon prête dans 20 Sec",
	warnTurretsReady		= "Quatrième tourelle à harpon prête",
}
L:SetTimerLocalization{
	timerDeepBreathCooldown	= "Prochain souffle dans",
	timerDeepBreathCast		= "Souffle de flammes",
	timerAllTurretsReady	= "Tourelles"
}
L:SetOptionLocalization{
	timerDeepBreathCooldown		= "Afficher un timer pour le prochain Souffle de flammes",
	timerDeepBreathCast			= "Afficher la  barre d'incantation pour le Souffle de flammes",
	SpecWarnDevouringFlame		= "Activer l'avertissement spécial pour les Flammes dévorantes",
	PlaySoundOnDevouringFlame	= "Jouer un son quand vous êtes affecté par la Flamme dévorante",
	timerAllTurretsReady		= "Afficher un timer pour les tourelles",
	warnTurretsReadySoon		= "Activer le pré-avertissement pour les tourelles",
	warnTurretsReady			= "Activer l'avertissement pour les tourelles",
}

L:SetMiscLocalization{
	YellAir = "Laissez un instant pour préparer la construction des tourelles."
}


-------------
--  XT002  --
-------------
L = DBM:GetModLocalization("XT002")

L:SetGeneralLocalization{
	name = "Déconstructeur XT-002"
}

L:SetTimerLocalization{
	timerTympanicTantrumCast	= "Lancement de Colère assourdissante",
	timerTympanicTantrum		= "Colère assourdissante",
	timerLightBomb			= "Bombe de lumière: %s",
	timerGravityBomb		= "Bombe à gravité: %s",
}

L:SetWarningLocalization{
	SpecialWarningLightBomb 	= "Bombe de lumière sur TOI",
	WarningLightBomb		= "Bombe de lumière sur >%s<",
	SpecialWarningGravityBomb	= "Bombe à gravité sur TOI",
	WarningGravityBomb		= "Bombe à gravité sur >%s<",
}

L:SetOptionLocalization{
	SpecialWarningLightBomb		= "Activer l'avertissement spécial quand vous êtes affecté par la bombe de lumière",
	WarningLightBomb			= "Annoncer les bombes de lumière",
	SpecialWarningGravityBomb	= "Activer l'avertissement spécial quand vous êtes affecté par la bombe à gravité",
	WarningGravityBomb			= "Annoncer les bombes à gravité",
	PlaySoundOnGravityBomb		= "Jouer un son quand la bombe à gravité est sur vous",
	PlaySoundOnTympanicTantrum	= "Jouer un son au lancement de la colère assourdissante",
	SetIconOnLightBombTarget	= "Mettre un icône sur la cible de la bombe de lumière",
	SetIconOnGravityBombTarget	= "Mettre un icône sur la cible de la bombe à gravité",
}

-------------------
--  IronCouncil  --
-------------------
L = DBM:GetModLocalization("IronCouncil")

L:SetGeneralLocalization{
	name = "Assemblée du Fer"
}

L:SetWarningLocalization{
	WarningSupercharge		= "Supercharge imminente",
	WarningChainlight		= "Chaîne d'éclairs",
	WarningFusionPunch		= "Coup de poing fusion",
	WarningOverwhelmingPower	= "Puissance accablante sur >%s<",
	WarningRuneofPower		= "Rune de puissance",
	WarningRuneofDeath		= "Rune de mort",
	RuneofDeath			= "Rune de mort - BOUGEZ",
	LightningTendrils		= "Vrilles de foudre - COURREZ",
}

L:SetTimerLocalization{
	TimerSupercharge		= "Supercharge",
	TimerOverload			= "Surchage",
	TimerLightningWhirl		= "Eclair tourbillonnant",
	TimerLightningTendrils		= "Vrilles d'éclair",
	timerFusionPunchCast		= "Incantation du coup de poing fusion",
	timerFusionPunchActive		= "Coup de poing fusion: %s",
	timerOverwhelmingPower		= "Puissance accablante: %s",
	timerRunicBarrier		= "Barrière runique",
	timerRuneofDeath		= "Rune de mort",
}

L:SetOptionLocalization{
	TimerSupercharge		= "Afficher le timer de la Supercharge",
	WarningSupercharge		= "Activer l'avertissement quand la Supercharge est incanté",
	WarningChainlight		= "Annoncer les Chaînes d'éclairs",
	TimerOverload			= "Afficher la barre d'incantation de la surcharge",
	TimerLightningWhirl		= "Afficher la barre d'incantation des éclairs tourbillonnants",
	LightningTendrils		= "Activer l'avertissement spécial pour les Vrilles d'éclair",
	TimerLightningTendrils		= "Afficher la durée des Vrilles d'éclair",
	PlaySoundLightningTendrils	= "Jouer un son pour les Vrilles d'éclair",
	WarningFusionPunch		= "Annoncer les coups de poing fusion",
	timerFusionPunchCast		= "Afficher la barre d'incantation pour les coups de poing fusion",
	timerFusionPunchActive		= "Afficher un timer pour les coups de poing fusion",
	WarningOverwhelmingPower	= "Annoncer la Puissance accablante",
	timerOverwhelmingPower		= "Afficher un timer pour la Puissance accablante",
	SetIconOnOverwhelmingPower	= "Mettre un icône sur la cible de la Puissance accablante",
	timerRunicBarrier		= "Afficher un timer pour la Barrière runique",
	WarningRuneofPower		= "Annoncer les runes de puissance",
	WarningRuneofDeath		= "Annoncer les runes de mort",
	RuneofDeath			= "Activer l'avertissement spécial pour les runes de mort",
	timerRuneofDeath		= "Afficher la durée des runes de mort",
}

L:SetMiscLocalization{
	Steelbreaker		= "Brise-acier",
	RunemasterMolgeim	= "Maﵲe des runes Molgeim",
	StormcallerBrundir 	= "Mande-foudre Brundir",
}


---------------
--  Algalon  --
---------------
L = DBM:GetModLocalization("Algalon")

L:SetGeneralLocalization{
	name = "Algalon l'Observateur"
}

L:SetTimerLocalization{
	TimerBigBangCast	= "Incantation du Big Bang",
}
L:SetWarningLocalization{
	WarningPhasePunch	= "Coup de poing phasique sur >%s<",
	WarningBlackHole	= "Trou noir",
}

L:SetOptionLocalization{
	TimerBigBangCast	= "Afficher une barre d'incantation pour le Big Bang",
	SpecWarnPhasePunch	= "Activer l'avertissement spécial quand vous êtes la cible du coup de poing phasique",
	WarningPhasePunch	= "Annoncer la cible du Coup de poing phasique",
	WarningBlackHole	= "Annoncer les trous noirs",
}


----------------
--  Kologarn  --
----------------
L = DBM:GetModLocalization("Kologarn")

L:SetGeneralLocalization{
	name = "Kologarn"
}

L:SetWarningLocalization{
	SpecialWarningEyebeam	= "Rayon de l'Œil sur TOI - ECARTE-TOI",
	WarningEyebeam			= "Rayon de l'Œil sur >%s<",
	WarnGrip				= "Poigne sur >%s<"
}

L:SetTimerLocalization{
	timerEyebeam			= "Rayon de l'Œil: %s",
	timerPetrifyingBreath	= "Souffle pétrifiant",
	timerNextShockwave		= "Prochaine Onde de choc",
	timerLeftArm			= "Repop du bras gauche",
	timerRightArm			= "Repop du bras droit"
}

L:SetOptionLocalization{
	SpecialWarningEyebeam		= "Activer l'avertissement spécial quand vous êtes la cible du Rayon de l'Œil",
	WarningEyebeam			= "Annoncer la cible du Rayon de l'Œil",
	timerEyebeam			= "Afficher un timer pour le Rayon de l'Œil",
	SetIconOnEyebeamTarget		= "Mettre un icône sur la cible du Rayon de l'Œil",
	timerPetrifyingBreath		= "Afficher un timer pour le souffle pétrifiant",
	timerNextShockwave		= "Afficher un timer pour l'onde de choc",
	timerLeftArm			= "Afficher un timer pour le repop du bras gauche",
	timerRightArm			= "Afficher un timer pour le repop du bras droit"
}

L:SetMiscLocalization{
	Yell_Trigger_arm_left		= "Juste une éraflure !",
	Yell_Trigger_arm_right		= "Une blessure superficielle !"
}

---------------
--  Auriaya  --
---------------
L = DBM:GetModLocalization("Auriaya")

L:SetGeneralLocalization{
	name = "Auriaya"
}

L:SetMiscLocalization{
	Defender = "Défenseur farouche (%d)"
}

L:SetWarningLocalization{
	SpecWarnBlast = "Déflagration du factionnaire - Interrompu!",
	WarnCatDied = "Défenseur farouche mort (%d vies restantes)",
	WarnFear = "Hurlement terrifiant!",
	WarnFearSoon = "Hurlement terrifiant imminent",
	WarnSonic		= "Hurlement sonore",
	WarnSwarm		= "Essaim gardien sur >%s<"
}

L:SetOptionLocalization{
	SpecWarnBlast = "Activer l'avertissement spécial pour les Déflagration du factionnaire",
	WarnFear = "Activer l'avertissement pour les Hurlements terrifiants",
	WarnFearSoon = "Activer l'avertissement pour le Hurlement terrifiant imminent",
	WarnCatDied = "Activer l'avertissement quand un défenseur farouche meurt",
	WarnSwarm		= "Activer l'avertissement pour les Essaims gardien",
	WarnSonic		= "Activer l'avertissement pour les Hurlements sonores"
}


-------------
--  Hodir  --
-------------
L = DBM:GetModLocalization("Hodir")

L:SetGeneralLocalization{
	name = "Hodir"
}

L:SetWarningLocalization{
	WarningFlashFreeze	= "Gel instantané",
	WarningBitingCold	= "Froid mordant - BOUGE"
}

L:SetTimerLocalization{
	TimerFlashFreeze	= "Gel instantané imminent",  -- all ppl have to move on the rock patches
}

L:SetOptionLocalization{
	TimerFlashFreeze	= "Afficher une barre d'incantation pour le gel instantané",
	WarningFlashFreeze	= "Activer l'avertissement pour le gel instantané",
	WarningBitingCold	= "Activer l'avertissement pour le froid mordant",
	PlaySoundOnFlashFreeze	= "Jouer un son lors de l'incantation du gel instantané"
}

L:SetMiscLocalization{

}


--------------
--  Thorim  --
--------------
L = DBM:GetModLocalization("Thorim")

L:SetGeneralLocalization{
	name = "Thorim"
}

L:SetWarningLocalization{
	WarningStormhammer	= "Marteau-tempête sur >%s<",
	UnbalancingStrike	= "Frappe déséquilibrante sur >%s<",
	WarningPhase2	= "Phase 2",
	WarningBomb	= "Détonation runique sur >%s<",
	LightningOrb = "Horion de foudre sur TOI! Bouge!"
}

L:SetTimerLocalization{
	TimerStormhammer	= "Marteau-tempête (CD)",
	TimerUnbalancingStrike	= "Frappe déséquilibrante (CD)",
	TimerHardmode	= "Mode difficile"
}

L:SetOptionLocalization{
	TimerStormhammer	= "Afficher le cooldown du marteau-tempête",
	TimerUnbalancingStrike	= "Afficher le timer pour la frappe déséquilibrante",
	TimerHardmode	= "Afficher le timer pour le mode difficile",
	UnbalancingStrike	= "Annoncer la cible de la frappe déséquilibrante",
	WarningStormhammer	= "Annoncer la cible du marteau-tempête",
	WarningPhase2	= "Annoncer la phase 2",
	WarningBomb	= "Annoncer la détonation runique",
	RangeFrame	= "Afficher la fenêtre de portée"
}

L:SetMiscLocalization{
	YellPhase1		= "Des intrus ! Mortels, vous qui osez me déranger en plein divertissement, allez payer ! Attendez... vous ?",    -- A vérifier
	YellPhase2		= "Avortons impertinents. Vous osez me défier sur mon piédestal ! Je vais vous écraser moi-même !"              -- A vérifier
}


-------------
--  Freya  --
-------------
L = DBM:GetModLocalization("Freya")

L:SetGeneralLocalization{
	name = "Freya"
}

L:SetMiscLocalization{
	SpawnYell = "Children, assist me!",
	WaterSpirit = "Ancient Water Spirit",
	Snaplasher = "Snaplasher",
	StormLasher = "Storm Lasher",
	EmoteTree = "???" -- /chatlog failed
}

L:SetWarningLocalization{
	WarnPhase2 = "Phase 2",
	WarnSimulKill = "First add down - Resurrection in 1 min",
	WarnFury = "Nature's Fury on >%s<",
	SpecWarnFury = "Nature's Fury on You!"
}

L:SetTimerLocalization{
	TimerUnstableSunBeam = "Sun Beam: %s",
	TimerAlliesOfNature = "Allies of Nature CD",
	TimerSimulKill = "Resurrection",
	TimerFuryYou = "Nature's Fury on you"
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
	WarningShockBlast	= "Show Shock Blast Warning",
	WarningPlasmaBlast	= "Show Plasma Blast Warning",
	ProximityMines		= "Show Timer for Proximity Mines",
	PlaySoundOnShockBlast 	= "Play sound on Shock Blast cast",
}

L:SetMiscLocalization{
	YellPull		= "We haven't much time, friends! You're going to help me test out my latest and greatest creation. Now, before you change your minds, remember that you kind of owe it to me after the mess you made with the XT-002.",
	YellPhase2		= "WONDERFUL! Positively marvelous results! Hull integrity at 98.9%! Barely a dent! Moving right along.",
	YellPhase3		= "Thank you, friends! Your efforts have yielded some fantastic data! Now, where did I put-- oh, there it is.",
}


--------------------
--  GeneralVezax  --
--------------------
L = DBM:GetModLocalization("GeneralVezax")

L:SetGeneralLocalization{
	name = "Général Vezax"
}

L:SetWarningLocalization{
	SpecialWarningShadowCrash	= "Shadow Crash on You",
	SpecialWarningSurgeDarkness	= "Surge of Darkness",
	WarningShadowCrash		= "Shadow Crash on >%s<",
	specWarnLifeLeechYou		= "Life Leech on you!",
	specWarnLifeLeechNear		= "Life Leech on %s near you!"
}

L:SetTimerLocalization{
	timerSearingFlamesCast		= "Searing Flames",
	timerSurgeofDarkness		= "Surge of Darkness",
	timerSaroniteVapors		= "Next Saronite Vapors"
}

L:SetOptionLocalization{
	WarningShadowCrash		= "Show Warning for Shadow Crash",
	timerSearingFlamesCast		= "Show Timer for Searing Flame Cast",
	timerSurgeofDarkness		= "Show Timer for Sourge of Darkness",
	timerSaroniteVapors		= "Show Timer for Saronite Vapors",
	SetIconOnShadowCrash		= "Set Icon on Shadow Crash target (skull)",
	SetIconOnLifeLeach		= "Set Icon on Life Leech target (cross)",
	SpecialWarningSurgeDarkness	= "Show Special Warning for Surge of Darkness",
	SpecialWarningShadowCrash	= "Show Special Warning for Shadow Crash",
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
	YellPull = "The time to strike at the head of the beast will soon be upon us! Focus your anger and hatred on his minions!",
	YellPhase2 = "Let hatred an rage guide your blows!",
	Sara = "Sara",
	WhisperBrainLink = "Brain Link on you! Run to %s!",
}

L:SetWarningLocalization{
	WarningWellSpawned = "Sanity Well spawned",
	WarningGuardianSpawned = "Guardian spawned",
	WarningP2 = "Phase 2",
	WarningBrainLink = "Brain Link on >%s< and >%s<",
	SpecWarnBrainLink = "Brain Link on you and %s!",
	WarningSanity = "%d Sanity debuffs remaining",
	SpecWarnSanity = "%d Sanity debuffs remaining",
	SpecWarnGuardianLow = "Stop attacking this Guardian!",
	WarnMadness = "Casting Induce Madness"
}