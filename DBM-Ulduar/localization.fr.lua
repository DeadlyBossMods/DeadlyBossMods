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
	SlagPotIcon		= "Mettre un ic஥sur la cible de la Marmite de scories"
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
	SpecWarnDevouringFlameCast	= "Flamme dévorante sur Vous",
	WarnDevouringFlameCast		= "Flamme dévorante sur >%s<" 
}
L:SetTimerLocalization{
	timerDeepBreathCooldown	= "Prochain souffle dans",
	timerDeepBreathCast		= "Souffle de flammes",
	timerAllTurretsReady	= "Tourelles",
	timerTurret1			= "Tourelle 1",
	timerTurret2			= "Tourelle 2",
	timerTurret3			= "Tourelle 3",
	timerTurret4			= "Tourelle 4",
	timerGroundedTemp		= "sur le sol"
}
L:SetOptionLocalization{
	timerDeepBreathCooldown		= "Afficher un timer pour le prochain Souffle de flammes",
	timerDeepBreathCast			= "Afficher la  barre d'incantation pour le Souffle de flammes",
	SpecWarnDevouringFlame		= "Activer l'avertissement spécial pour les Flammes dévorantes",
	PlaySoundOnDevouringFlame	= "Jouer un son quand vous êtes affecté par la Flamme dévorante",
	timerAllTurretsReady		= "Afficher un timer pour les tourelles",
	warnTurretsReadySoon		= "Activer le pré-avertissement pour les tourelles",
	warnTurretsReady			= "Activer l'avertissement pour les tourelles",
	SpecWarnDevouringFlameCast	= "Montre une alerte spécial quand les Flamme dévorante sont cast sur Vous",
	timerTurret1			= "Montre le timer pour la tourelle 1",
	timerTurret2			= "Montre le timer pour la tourelle 2",
	timerTurret3			= "Montre le timer pour la tourelle 3 (Heroique)",
	timerTurret4			= "Montre le timer pour la tourelle 4 (Heroique)",
	OptionDevouringFlame		= "Annonce la cible des Flamme dévorante (unreliable)",
	timerGroundedTemp		= "Montre le timer pour la phase au sol"
}

L:SetMiscLocalization{
	YellAir = "Laissez un instant pour préparer la construction des tourelles.",
	YellAir2			= "Incendie éteint ! Reconstruisons les tourelles !",
	YellGroundTemp			= "Faites vite ! Elle va pas rester au sol très longtemps !",
	EmotePhase2			= "%%s bloquée au sol !",
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
	WarningRuneofSummoning			= "Rune d'invocation",
	Overload				= "Surchage - BOUGEZ",
	WarningStaticDisruption			= "Static Disruption sur >%s<"
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
	WarningRuneofSummoning			= "Annonce les Rune d'invocation",
	SetIconOnStaticDisruption		= "Met une icone sur la cible de Static Disruption",
	Overload				= "Montre une alerte spécial pour la Surcharge",
	AllwaysWarnOnOverload			= "Toujours alerter pour la surcharge (otherwise only when targeted)",
	PlaySoundOnOverload			= "Joue un sons a la surcharge",
	WarningStaticDisruption			= "Annonce la Static Disruption"
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
	NextCollapsingStar	= "Prochain choque cosmique"
}
L:SetWarningLocalization{
	WarningPhasePunch	= "Coup de poing phasique sur >%s<",
	WarningBlackHole	= "Trou noir",
	WarningBigBang		= "Big Bang MAINTENANT",
	PreWarningBigBang	= "Big Bang dans ~10 sec",
}

L:SetOptionLocalization{
	TimerBigBangCast	= "Afficher une barre d'incantation pour le Big Bang",
	SpecWarnPhasePunch	= "Activer l'avertissement spécial quand vous êtes la cible du coup de poing phasique",
	WarningPhasePunch	= "Annoncer la cible du Coup de poing phasique",
	WarningBlackHole	= "Annoncer les trous noirs",
	WarningBigBang		= "Annonce le cast du Big Bang",
	PreWarningBigBang	= "Pré annonce le Big Bang",
	NextCollapsingStar	= "Montre un timer pour le prochain choque cosmique"
}

L:SetMiscLocalization{
	YellPull		= "Vos actions sont illogiques. Tous les résultats possibles de cette rencontre ont été calculés. Le panthéon recevra le message de l'Observateur quelque soit l'issue."
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
	timerRightArm			= "Afficher un timer pour le repop du bras droit",
	WarnGrip				= "Annonce les Targets de la poigne",
	WarnEyeBeam				= "Annonce les targets du rayon",
	SetIconOnGripTarget		= "Met une icone sur les joueurs victime du sort poigne"
}

L:SetMiscLocalization{
	Yell_Trigger_arm_left		= "Juste une éraflure !",
	Yell_Trigger_arm_right		= "Une blessure superficielle !",
	Health_Body				= "Torse de Kologarn",
	Health_Right_Arm		= "Bras droit",
	Health_Left_Arm			= "Bras gauche",
	FocusedEyebeam			= "%s concentre son regard sur vous !"
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
	WarnSwarm		= "Essaim gardien sur >%s<",
	SpecWarnVoid		= "Void Zone - BOUGEZ!",
	WarnCatDiedOne 		= "Défenseur farouche mort (1 vie en moin)",
}

L:SetOptionLocalization{
	SpecWarnBlast = "Activer l'avertissement spécial pour les Déflagration du factionnaire",
	WarnFear = "Activer l'avertissement pour les Hurlements terrifiants",
	WarnFearSoon = "Activer l'avertissement pour le Hurlement terrifiant imminent",
	WarnCatDied = "Activer l'avertissement quand un défenseur farouche meurt",
	WarnSwarm		= "Activer l'avertissement pour les Essaims gardien",
	WarnSonic		= "Activer l'avertissement pour les Hurlements sonores",
	SpecWarnVoid		= "Montre une alerte spécial quand vous êtes dans une Void Zone",
	WarnCatDiedOne		= "Montre une alerte spécial quand un Défenseur farouche meur"
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
	WarningBitingCold	= "Froid mordant - BOUGE",
	WarningStormCloud	= "Tempète de glace sur >%s<", 
}

L:SetTimerLocalization{
	TimerFlashFreeze	= "Gel instantané imminent",  -- all ppl have to move on the rock patches
}

L:SetOptionLocalization{
	TimerFlashFreeze	= "Afficher une barre d'incantation pour le gel instantané",
	WarningFlashFreeze	= "Activer l'avertissement pour le gel instantané",
	WarningBitingCold	= "Activer l'avertissement pour le froid mordant",
	PlaySoundOnFlashFreeze	= "Jouer un son lors de l'incantation du gel instantané",
	WarningStormCloud	= "Annonce le joueur de la tempète de glace",
	YellOnStormCloud	= "Crie quand la tempète de glace est active",
	SetIconOnStormCloud	= "Met une icone sur la cible de la tempète de glace"
}

L:SetMiscLocalization{
	YellKill		= "Je suis... libéré de son emprise... enfin."
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
	WarningLightningCharge	= "Charge de foudre",
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
	RangeFrame	= "Afficher la fenêtre de portée",
	WarningLightningCharge		= "Annonce les charges de foudre",
	AnnounceFails			= "Post player fails for Lightning Charge to the raid chat (requires announce enabled and promoted/leader status)" 
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
	SpawnYell = "Mes enfants, venez m'aider !",
	WaterSpirit = "Esprit de l'eau ancien",
	Snaplasher = "Flagellant mordant",
	StormLasher = "Flagellant des tempêtes",
	YellKill	= "Son emprise sur moi se dissipe. J'y vois à nouveau clair. Merci, héros."
}

L:SetWarningLocalization{
	WarnPhase2 = "Phase 2",
	WarnSimulKill = "Premier add mort - Résurection dans 1 minute",
	WarnFury = "Fureur de la nature sur >%s<",
	SpecWarnFury = "Fureur de la nature sur VOUS!",
	WarningTremor   = "Tremblement de terre - Arretez d'incanter!",
	WarnRoots	= "Racines de fer sur >%s<",
	UnstableEnergy	= "Energie instable - BOUGEZ!"
}

L:SetTimerLocalization{
	TimerUnstableSunBeam = "Rayon de soleil: %s",
	TimerAlliesOfNature = "Allies of Nature CD",
	TimerSimulKill = "Resurrection",
	TimerFuryYou = "Fureur de la nature sur vous"
}

L:SetOptionLocalization{
	WarnPhase2		= "Annonce la phase 2",
	WarnSimulKill		= "Annonce la mort du premier mob",
	WarnFury		= "Annonce la cible de la fureur de la nature",
	WarnRoots		= "Annonce les cibles des racines de fer",
	SpecWarnFury		= "Montre des alerte spécial pour la Fureur de la Nature",
	WarningTremor		= "Montre une alerte spécial pour le tremblement de terre (Hard-Mode)",
	TimerSimulKill		= "Montre le timer de la résurection des mobs",
	UnstableEnergy		= "Montre une alerte spécial pour l'énergie instable"
}

-- Elders
L = DBM:GetModLocalization("Freya_Elders")

L:SetGeneralLocalization{
	name = "Freya's Elders"
}

L:SetOptionLocalization{
	SpecWarnFistOfStone	= "Montre une alerte spécial pour le coup de poings de pierre",
	SpecWarnGroundTremor	= "Montre une alerte spécial pour le tremblement de terre",
	PlaySoundOnFistOfStone	= "Joue un sons au cast de poings de pierre",
	TrashRespawnTimer	= "Montre le timer du repop des trash"
}


-------------------
--  Mimiron  --
-------------------
L = DBM:GetModLocalization("Mimiron")

L:SetGeneralLocalization{
	name = "Mimiron"
}

L:SetWarningLocalization{
	DarkGlare			= "Barrage laser",
	WarningPlasmaBlast	= "Explosion de plasma sur %s - heal",
	Phase2Engaged		= "La phase 2 arrive - Regroupez vous",
	Phase3Engaged		= "La phase 3 arrive - Regroupez vous",
	WarnShell			= "Obus napalm sur >%s<",
	WarnBlast			= "Explosion de plasma sur >%s<",
	MagneticCore		= ">%s< viens de loot le Core Magnétique",
	WarningShockBlast	= "Horion explosif - BOUGEZ",
	WarnBombSpawn		= "Robot Bombe viens de pop"
}

L:SetTimerLocalization{
	ProximityMines		= "Nouvelle Mines de proximité",
	TimeToPhase2		= "Phase 2",
	TimeToPhase3		= "Phase 3",
	TimeToPhase4		= "Phase 4"
}

L:SetOptionLocalization{
	WarningShockBlast	= "Montre les alertes pour les Horion explosif",
	WarningPlasmaBlast	= "Montre les alertes pour les Explosion de plasma",
	ProximityMines		= "Montre le timer pour les Mines de proximité",
	DarkGlare				= "Montre une alerte spécial pour le Barrage laser",
	WarnBlast				= "Annonce la cible des Explosion de plasma",
	WarnShell				= "Annonce la cible des Obus napalm",
	TimeToPhase2			= "Montre le timer pour la Phase 2",
	TimeToPhase3			= "Montre le timer pour la Phase 3",
	TimeToPhase4			= "Montre le timer pour la Phase 4",
	MagneticCore			= "Annonce qui a loot le Core Magnétique",
	HealthFramePhase4		= "Montre les barres de vie dans la phase 4",
	AutoChangeLootToFFA		= "Met le butin en acces libre durant la phase 3",
	WarnBombSpawn			= "Annonce les Robot Bombe",
	PlaySoundOnShockBlast	= "Joue un sons lors des Horion explosif",
	PlaySoundOnDarkGlare	= "Joue un sons au Barrage laser",
	ShockBlastWarningInP1	= "Montre une alerte spécial pour les Horion explosif durant la Phase 1",
	ShockBlastWarningInP4	= "Montre une alerte spécial pour les Horion explosif durant la Phase 2"
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