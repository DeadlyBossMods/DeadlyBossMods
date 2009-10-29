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
	PursueWarn				= "Poursuit >%s<!",
	warnNextPursueSoon		= "Changement de cible dans 5 Sec",
	SpecialPursueWarnYou	= "Vous êtes poursuivit!",
	SystemOverload			= "Extinction des systèmes !",
	warnWardofLife			= "Gardien de Vie viens d'arriver",
	warnWrithingLasher		= "Flagellant frémissant viens d'arriver"
}

L:SetOptionLocalization{
	timerSystemOverload		= "Activer le timer pour la surchage du système",
	timerFlameVents			= "Activer le timer pour les Flots de flammes",
	timerPursued			= "Activer le timer pour la poursuite",
	SystemOverload			= "Afficher l'avertissement spécial pour la surchage du système",
	SpecialPursueWarnYou	= "Afficher l'avertissement spécial quand un joueur est poursuivi",
	PursueWarn				= "Afficher l'avertissement quand vous êtes poursuivi",
	warnNextPursueSoon		= "Prévenir avant la prochaine poursuite",
	warnWardofLife			= "Montre une alerte quand un Gardien de Vie arrive",
	warnWrithingLasher		= "Montre une alerte quand un Flagellant frémissant arrive"
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
	SpecWarnJetsCast		= "Activer l'avertissement spécial pour les Flots de flammes (contresort)",
	TimerFlameJetsCast		= "Afficher le timer des Flots de flammes",
	TimerFlameJetsCooldown	= "Afficher le cooldown du Flots de flammes",
	TimerScorch				= "Afficher le cooldown de brûlure",
	TimerScorchCast			= "Afficher la barre de cast de brûlure",
	WarningSlagPot			= "Annoncer la cible de la Marmite de scories",
	TimerSlagPot			= "Afficher le timer de la Marmite de scories",
	SlagPotIcon				= "Mettre une icône sur la cible de la Marmite de scories"
}

------------------
--  Razorscale  --
------------------
L = DBM:GetModLocalization("Razorscale")

L:SetGeneralLocalization{
	name = "Tranchécaille"
}     

L:SetWarningLocalization{
	SpecWarnDevouringFlame		= "Flamme dévorante - BOUGEZ",
	warnTurretsReadySoon		= "Quatrième tourelle à harpon prête dans 20 Sec",
	warnTurretsReady			= "Quatrième tourelle à harpon prête",
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
	timerGroundedTemp		= "Sur le sol"
}
L:SetOptionLocalization{
	timerDeepBreathCooldown		= "Afficher un timer pour le prochain Souffle de flammes",
	timerDeepBreathCast			= "Afficher la  barre d'incantation pour le Souffle de flammes",
	SpecWarnDevouringFlame		= "Activer l'avertissement spécial pour les Flammes dévorantes",
	PlaySoundOnDevouringFlame	= "Jouer un son quand vous êtes affecté par la Flamme dévorante",
	timerAllTurretsReady		= "Afficher un timer pour les tourelles",
	warnTurretsReadySoon		= "Activer le pré-avertissement pour les tourelles",
	warnTurretsReady			= "Activer l'avertissement pour les tourelles",
	SpecWarnDevouringFlameCast	= "Montre une alerte spéciale quand les Flammes dévorantes sont cast sur Vous",
	timerTurret1				= "Montre le timer pour la tourelle 1",
	timerTurret2				= "Montre le timer pour la tourelle 2",
	timerTurret3				= "Montre le timer pour la tourelle 3 (Héroique)",
	timerTurret4				= "Montre le timer pour la tourelle 4 (Héroique)",
	OptionDevouringFlame		= "Annonce la cible des Flammes dévorantes (Incertain)",
	timerGroundedTemp			= "Montre le timer pour la phase au sol"
}

L:SetMiscLocalization{
	YellAir 			= "Laissez un instant pour préparer la construction des tourelles.",
	YellAir2			= "Incendie éteint ! Reconstruisons les tourelles !",
	YellGroundTemp		= "Faites vite ! Elle va pas rester au sol très longtemps !",
	EmotePhase2			= "%%s bloquée au sol !",
	FlamecastUnknown	= DBM_CORE_UNKNOWN
}


-------------
--  XT002  --
-------------
L = DBM:GetModLocalization("XT002")

L:SetGeneralLocalization{
	name = "Déconstructeur XT-002"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
	SpecialWarningLightBomb 	= "Bombe de lumière sur TOI",
	WarningLightBomb			= "Bombe de lumière sur >%s<",
	SpecialWarningGravityBomb	= "Bombe à gravité sur TOI",
	WarningGravityBomb			= "Bombe à gravité sur >%s<"
}

L:SetOptionLocalization{
	SpecialWarningLightBomb		= "Activer l'avertissement spécial quand vous êtes affecté par la bombe de lumière",
	WarningLightBomb			= "Annoncer les bombes de lumière",
	SpecialWarningGravityBomb	= "Activer l'avertissement spécial quand vous êtes affecté par la bombe à gravité",
	WarningGravityBomb			= "Annoncer les bombes à gravité",
	PlaySoundOnGravityBomb		= "Jouer un son quand la bombe à gravité est sur vous",
	PlaySoundOnTympanicTantrum	= "Jouer un son au lancement de la colère assourdissante",
	SetIconOnLightBombTarget	= "Mettre un icône sur la cible de la bombe de lumière",
	SetIconOnGravityBombTarget	= "Mettre un icône sur la cible de la bombe à gravité"
}

-------------------
--  IronCouncil  --
-------------------
L = DBM:GetModLocalization("IronCouncil")

L:SetGeneralLocalization{
	name = "Assemblée du Fer"
}

L:SetWarningLocalization{
	WarningSupercharge			= "Supercharge imminente",
	WarningChainlight			= "Chaîne d'éclairs",
	WarningFusionPunch			= "Coup de poing fusion",
	WarningOverwhelmingPower	= "Puissance accablante sur >%s<",
	WarningRuneofPower			= "Rune de puissance",
	WarningRuneofDeath			= "Rune de mort",
	RuneofDeath					= "Rune de mort - BOUGEZ",
	LightningTendrils			= "Vrilles de foudre - COURREZ",
	WarningRuneofSummoning		= "Rune d'invocation",
	Overload					= "Surchage - BOUGEZ",
	WarningStaticDisruption		= "Static Disruption sur >%s<",
	PlaySoundDeathRune			= "Death Rune"
}

L:SetTimerLocalization{
	TimerSupercharge		= "Supercharge",
	TimerOverload			= "Surchage",
	TimerLightningWhirl		= "Eclair tourbillonnant",
	TimerLightningTendrils	= "Vrilles d'éclair",
	timerFusionPunchCast	= "Incantation du coup de poing fusion",
	timerFusionPunchActive	= "Coup de poing fusion: %s",
	timerOverwhelmingPower	= "Puissance accablante: %s",
	timerRunicBarrier		= "Barrière runique",
	timerRuneofDeath		= "Rune de mort"
}

L:SetOptionLocalization{
	TimerSupercharge			= "Afficher le timer de la Supercharge",
	WarningSupercharge			= "Activer l'avertissement quand la Supercharge est incanté",
	WarningChainlight			= "Annoncer les Chaînes d'éclairs",
	TimerOverload				= "Afficher la barre d'incantation de la surcharge",
	TimerLightningWhirl			= "Afficher la barre d'incantation des éclairs tourbillonnants",
	LightningTendrils			= "Activer l'avertissement spécial pour les Vrilles d'éclair",
	TimerLightningTendrils		= "Afficher la durée des Vrilles d'éclair",
	PlaySoundLightningTendrils	= "Jouer un son pour les Vrilles d'éclair",
	WarningFusionPunch			= "Annoncer les coups de poing fusion",
	timerFusionPunchCast		= "Afficher la barre d'incantation pour les coups de poing fusion",
	timerFusionPunchActive		= "Afficher un timer pour les coups de poing fusion",
	WarningOverwhelmingPower	= "Annoncer la Puissance accablante",
	timerOverwhelmingPower		= "Afficher un timer pour la Puissance accablante",
	SetIconOnOverwhelmingPower	= "Mettre un icône sur la cible de la Puissance accablante",
	timerRunicBarrier			= "Afficher un timer pour la Barrière runique",
	WarningRuneofPower			= "Annoncer les runes de puissance",
	WarningRuneofDeath			= "Annoncer les runes de mort",
	WarningRuneofSummoning		= "Annonce les Runes d'invocation",
	RuneofDeath					= "Activer l'avertissement spécial pour les runes de mort",
	timerRuneofDeath			= "Afficher la durée des runes de mort",
	SetIconOnStaticDisruption	= "Met une icône sur la cible de Static Disruption",
	Overload					= "Montre une alerte spéciale pour la Surcharge",
	AllwaysWarnOnOverload		= "Toujours alerter pour la surcharge (sinon seulement quand ciblé)",
	PlaySoundOnOverload			= "Joue un son à la surcharge",
	WarningStaticDisruption		= "Annonce la Static Disruption",
	PlaySoundDeathRune			= "Joue un son pour les runes de mort"
}

L:SetMiscLocalization{
	Steelbreaker		= "Brise-acier",
	RunemasterMolgeim	= "Maître des runes Molgeim",
	StormcallerBrundir 	= "Mande-foudre Brundir"
}


---------------
--  Algalon  --
---------------
L = DBM:GetModLocalization("Algalon")

L:SetGeneralLocalization{
	name = "Algalon l'Observateur"
}

L:SetTimerLocalization{
	NextCollapsingStar		= "Prochain choc cosmique",
	PossibleNextCosmicSmash	= "Prochain Choc cosmique possible"
}

L:SetWarningLocalization{
	WarningPhasePunch	= "Coup de poing phasique sur >%s<",
	WarningBlackHole	= "Trou noir",
	WarningBigBang		= "Big Bang MAINTENANT",
	SpecWarnBigBang			= "Big Bang",
	PreWarningBigBang	= "Big Bang dans ~10 sec",
	WarningCosmicSmash 		= "Choc cosmique - Explosion dans 4 sec",
	SpecWarnCosmicSmash 	= "Choc cosmique"
}

L:SetOptionLocalization{
	SpecWarnPhasePunch	= "Activer l'avertissement spécial quand vous êtes la cible du coup de poing phasique",
	WarningBigBang		= "Annonce le cast du Big Bang",
	PreWarningBigBang	= "Pré annonce le Big Bang",
	SpecWarnBigBang			= "Montre une alerte spéciale pour le Big Bang",
	WarningPhasePunch	= "Annoncer la cible du Coup de poing phasique",
	WarningBlackHole	= "Annoncer les trous noirs",
	NextCollapsingStar	= "Montre un timer pour le prochain choque cosmique",
	WarningCosmicSmash 		= "Annonce le Choc cosmique",
	SpecWarnCosmicSmash 	= "Montre une alerte spéciale pour le Choc cosmique",
	PossibleNextCosmicSmash	= "Montre le timer pour un possible Choc cosmique"
}

L:SetMiscLocalization{
	YellPull		= "Vos actions sont illogiques. Tous les résultats possibles de cette rencontre ont été calculés. Le panthéon recevra le message de l'Observateur quelque soit l'issue.",
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
	SpecialWarningEyebeam	= "Rayon de l'Œil sur TOI - ECARTE-TOI",
	WarningEyeBeam			= "Rayon de l'Œil sur >%s<",
	WarnGrip				= "Poigne sur >%s<"
}

L:SetTimerLocalization{
	timerEyebeam			= "Rayon de l'Œil: %s",
	timerPetrifyingBreath	= "Souffle pétrifiant",
	timerNextShockwave		= "Prochaine Onde de choc",
	timerLeftArm			= "Repop du bras gauche",
	timerRightArm			= "Repop du bras droit",
	achievementDisarmed		= "Temps pour Désarmement"
}

L:SetOptionLocalization{
	SpecialWarningEyebeam	= "Activer l'avertissement spécial quand vous êtes la cible du Rayon de l'Œil",
	WarningEyeBeam			= "Annoncer la cible du Rayon de l'Œil",
	timerEyebeam			= "Afficher un timer pour le Rayon de l'Œil",
	timerPetrifyingBreath	= "Afficher un timer pour le souffle pétrifiant",
	timerNextShockwave		= "Afficher un timer pour l'onde de choc",
	timerLeftArm			= "Afficher un timer pour le repop du bras gauche",
	timerRightArm			= "Afficher un timer pour le repop du bras droit",
	achievementDisarmed		= "Afficher un timer pour le Haut Fait Désarmement",
	WarnGrip				= "Annonce les cibles de la poigne",
	WarnEyeBeam				= "Annonce les cibles du rayon",
	SetIconOnGripTarget		= "Met une icône sur les joueurs victimes du sort poigne"
}

L:SetMiscLocalization{
	Yell_Trigger_arm_left	= "Juste une éraflure !",
	Yell_Trigger_arm_right	= "Une blessure superficielle !",
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
	SpecWarnBlast 		= "Déflagration du factionnaire - Interrompu!",
	SpecWarnVoid		= "Zone de Vide - BOUGEZ!",
	WarnCatDied 		= "Défenseur farouche mort (%d vies restantes)",
	WarnCatDiedOne 		= "Défenseur farouche mort (1 vie en moins)",
	WarnFear 			= "Hurlement terrifiant!",
	WarnFearSoon 		= "Hurlement terrifiant imminent",
	WarnSonic			= "Hurlement sonore",
	WarnSwarm			= "Essaim gardien sur >%s<"
}

L:SetOptionLocalization{
	SpecWarnBlast 		= "Activer l'avertissement spécial pour les Déflagration du factionnaire",
	SpecWarnVoid		= "Montre une alerte spéciale quand vous êtes dans une Zone de Vide",
	WarnFear 			= "Activer l'avertissement pour les Hurlements terrifiants",
	WarnFearSoon 		= "Activer l'avertissement pour le Hurlement terrifiant imminent",
	WarnCatDied 		= "Activer l'avertissement quand un défenseur farouche meurt",
	WarnSwarm			= "Activer l'avertissement pour les Essaims gardiens",
	WarnSonic			= "Activer l'avertissement pour les Hurlements sonores",
	WarnCatDiedOne		= "Montre une alerte spéciale quand un Défenseur farouche meurt"
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
	WarningStormCloud	= "Tempète de glace sur >%s<"
}

L:SetTimerLocalization{
	TimerFlashFreeze	= "Gel instantané imminent"  -- all ppl have to move on the rock patches
}

L:SetOptionLocalization{
	TimerFlashFreeze		= "Afficher une barre d'incantation pour le gel instantané",
	WarningFlashFreeze		= "Activer l'avertissement pour le gel instantané",
	PlaySoundOnFlashFreeze	= "Jouer un son lors de l'incantation du gel instantané",
	WarningStormCloud		= "Annonce le joueur de la tempête de glace",
	YellOnStormCloud		= "Crie quand la tempête de glace est active",
	SetIconOnStormCloud		= "Met une icône sur la cible de la tempête de glace"
}

L:SetMiscLocalization{
	YellKill		= "Je suis... libéré de son emprise... enfin.",
	YellCloud		= "Tempête de glace sur moi!"
}


--------------
--  Thorim  --
--------------
L = DBM:GetModLocalization("Thorim")

L:SetGeneralLocalization{
	name = "Thorim"
}

L:SetWarningLocalization{
	WarningStormhammer		= "Marteau-tempête sur >%s<",
	UnbalancingStrike		= "Frappe déséquilibrante sur >%s<",
	WarningPhase2			= "Phase 2",
	WarningLightningCharge	= "Charge de foudre",
	WarningBomb				= "Détonation runique sur >%s<",
	LightningOrb 			= "Horion de foudre sur TOI! Bouge!"
}

L:SetTimerLocalization{
	TimerHardmode	= "Mode difficile"
}

L:SetOptionLocalization{
	TimerHardmode			= "Afficher le timer pour le mode difficile",
	WarningStormhammer		= "Annoncer la cible du marteau-tempête",
	WarningLightningCharge	= "Annonce les charges de foudre",
	WarningPhase2			= "Annoncer la phase 2",
	UnbalancingStrike		= "Annoncer la cible de la frappe déséquilibrante",
	WarningBomb				= "Annoncer la détonation runique",
	RangeFrame				= "Afficher la fenêtre de portée",
	AnnounceFails			= "Affiche les joueurs qui n'ont pas évité les Charges de foudre (Nécessite l'activation des annonces et être promu ou leader)",
	LightningOrb			= "Montre une alerte spéciale pour les Charges de foudre"
}

L:SetMiscLocalization{
	YellPhase1		= "Des intrus ! Mortels, vous qui osez me déranger en plein divertissement, allez payer ! Attendez... vous ?",
	YellPhase2		= "Avortons impertinents. Vous osez me défier sur mon piédestal ! Je vais vous écraser moi-même !",
	YellKill		= "Stay your arms! I yield!",
	ChargeOn		= "Charge(s) de foudre: %s",
	Charge			= "Charge(s) de foudre non évitée(s) (cet essai): %s" 
}


-------------
--  Freya  --
-------------
L = DBM:GetModLocalization("Freya")

L:SetGeneralLocalization{
	name = "Freya"
}

L:SetMiscLocalization{
	SpawnYell 	= "Mes enfants, venez m'aider !",
	WaterSpirit = "Esprit de l'eau ancien",
	Snaplasher 	= "Flagellant mordant",
	StormLasher = "Flagellant des tempêtes",
	YellKill	= "Son emprise sur moi se dissipe. J'y vois à nouveau clair. Merci, héros."
}

L:SetWarningLocalization{
	WarnPhase2 		= "Phase 2",
	WarnSimulKill 	= "Premier add mort - Résurrection dans 1 minute",
	WarnFury 		= "Fureur de la nature sur >%s<",
	SpecWarnFury 	= "Fureur de la nature sur VOUS!",
	WarningTremor   = "Tremblement de terre - Arretez d'incanter!",
	WarnRoots		= "Racines de fer sur >%s<",
	UnstableEnergy	= "Energie instable - BOUGEZ!"
}

L:SetTimerLocalization{
	TimerUnstableSunBeam 	= "Rayon de soleil: %s",
	TimerSimulKill 			= "Résurrection",
	TimerFuryYou 			= "Fureur de la nature sur vous",
	TrashRespawnTimer		= "Respawn des Trashs de Freya"
}

L:SetOptionLocalization{
	WarnPhase2		= "Annonce la phase 2",
	WarnSimulKill	= "Annonce la mort du premier mob",
	WarnFury		= "Annonce la cible de la fureur de la nature",
	WarnRoots		= "Annonce les cibles des racines de fer",
	SpecWarnFury	= "Montre des alertes spéciales pour la Fureur de la Nature",
	WarningTremor	= "Montre une alerte spéciale pour le tremblement de terre (Hard-Mode)",
	PlaySoundOnFury = "Joue un sons quand vous êtes affecter par la Fureur de la nature",
	TimerSimulKill	= "Montre le timer de la résurrection des mobs",
	UnstableEnergy	= "Montre une alerte spéciale pour l'énergie instable"
}

----------------------
--  Freya's Elders  --
----------------------
L = DBM:GetModLocalization("Freya_Elders")

L:SetGeneralLocalization{
	name = "Freya's Elders"
}

L:SetMiscLocalization{
	TrashRespawnTimer	= "Respawn des Trashs de Freya"
}

L:SetWarningLocalization{
	SpecWarnGroundTremor	= "Tremblement de terre - Arrêtez les sorts !",
	SpecWarnFistOfStone		= "Poings de pierre"
}

L:SetOptionLocalization{
	SpecWarnFistOfStone		= "Montre une alerte spéciale pour le coup de poings de pierre",
	SpecWarnGroundTremor	= "Montre une alerte spéciale pour le tremblement de terre",
	PlaySoundOnFistOfStone	= "Joue un son à l'incantation des poings de pierre",
	TrashRespawnTimer		= "Montre le timer du repop des trashs"
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
	WarnShell			= "Obus napalm sur >%s<",
	WarnBlast			= "Explosion de plasma sur >%s<",
	MagneticCore		= ">%s< vient de loot le Core Magnétique",
	WarningShockBlast	= "Horion explosif - BOUGEZ",
	WarnBombSpawn		= "Robot Bombe vient de pop",
	WarnFrostBomb		= "Frost Bomb",
	WarnFlamesSoon		= "New Flames in ~5sec!"
}

L:SetTimerLocalization{
	ProximityMines		= "Nouvelles Mines de proximité",
	TimerHardmode		= "Hard Mode - Autodestruction",
	TimeToPhase2		= "Phase 2",
	TimeToPhase3		= "Phase 3",
	TimeToPhase4		= "Phase 4",
	TimerNewFlames		= "Nouvelles flammes"
}

L:SetOptionLocalization{
	DarkGlare				= "Montre une alerte spéciale pour le Barrage laser",
	WarnBlast				= "Annonce la cible des Explosions de plasma",
	WarnShell				= "Annonce la cible des Obus napalm",
	TimeToPhase2			= "Montre le timer pour la Phase 2",
	TimeToPhase3			= "Montre le timer pour la Phase 3",
	TimeToPhase4			= "Montre le timer pour la Phase 4",
	MagneticCore			= "Annonce qui a loot le Core Magnétique",
	HealthFramePhase4		= "Montre les barres de vie dans la phase 4",
	AutoChangeLootToFFA		= "Met le butin en accès libre durant la phase 3",
	WarnBombSpawn			= "Annonce les Robots Bombes",
	TimerHardmode			= "Montre le timer pour le Hard Mode",
	PlaySoundOnShockBlast	= "Joue un son lors des Horions explosifs",
	PlaySoundOnDarkGlare	= "Joue un son au Barrage laser",
	ShockBlastWarningInP1	= "Montre une alerte spéciale pour les Horions explosifs durant la Phase 1",
	ShockBlastWarningInP4	= "Montre une alerte spéciale pour les Horions explosifs durant la Phase 4",
	WarnFrostBomb			= "Annonce les Bombes de Givre"
}

L:SetMiscLocalization{
	MobPhase1		= "Léviathan Mod. II",
	MobPhase2		= "VX-001",
	MobPhase3		= "Unité de commandement aérien",
	YellPull		= "Nous n'avons pas beaucoup de temps, les amis ! Vous allez m'aider à tester ma dernière création en date, la plus grande de toutes. Avant de changer d'avis, n'oubliez pas que que vous me devez bien ça après m'avoir complètement déglingué le XT-002.",	
	YellHardPull	= "Now, why would you go and do something like that? Didn't you see the sign that said, \"DO NOT PUSH THIS BUTTON!\"? How will we finish testing with the self-destruct mechanism active?",
	YellPhase2		= "MERVEILLEUX ! Résultats parfaitement formidables ! Intégrité de la coque à 98,9 pour cent ! À peine une égratignure ! Poursuivons l'opération.",
	YellPhase3		= "Thank you, friends! Your efforts have yielded some fantastic data! Now, where did I put-- oh, there it is.",
	YellPhase4		= "Fin de la phase d'essais préliminaires. Passons à la véritable expérience !",
	LootMsg			= "([^%s]+).*Hitem:(%d+)"
}


--------------------
--  General Vezax  --
--------------------
L = DBM:GetModLocalization("GeneralVezax")

L:SetGeneralLocalization{
	name = "Général Vezax"
}

L:SetTimerLocalization{
	hardmodeSpawn = "Arriver d'Animus de saronite"
}

L:SetWarningLocalization{
	SpecialWarningShadowCrash		= "Déferlante d'ombre sur VOUS",
	SpecialWarningSurgeDarkness		= "Vague de ténèbres",
	WarningShadowCrash				= "Déferlante d'ombre sur >%s<",
	SpecialWarningShadowCrashNear	= "Déferlante d'ombre à côté de VOUS!",
	WarningLeechLife				= "Marque du Sans-visage sur >%s<",
	SpecialWarningLLYou				= "Marque du Sans-visage sur VOUS!",
	SpecialWarningLLNear			= "Marque du Sans-visage sur %s à côté de VOUS!"
}

L:SetOptionLocalization{
	WarningShadowCrash				= "Montre une alerte spéciale pour les Déferlante d'ombre",
	SetIconOnShadowCrash			= "met une icône sur la cible des Déferlante d'ombre ( Tête de mort )",
	SetIconOnLifeLeach				= "Met une icône sur la cible de la Marque du Sans-visage ( Croix )",
	SpecialWarningSurgeDarkness		= "Montre une alerte spéciale pour les Vague de ténèbres",
	SpecialWarningShadowCrash		= "Montre une alerte spéciale pour les Déferlante d'ombre",
	SpecialWarningShadowCrashNear	= "Montre une alerte spéciale quand la Déferlante d'ombre tombe à côté de vous",
	SpecialWarningLLYou				= "Montre une alerte spéciale quand la Marque du Sans-visage est sur Vous",
	SpecialWarningLLNear			= "Montre une alerte spéciale quand la Marque du Sans-visage est à côté de vous",
	CrashWhisper					= "Envoie un whisp à la cible de la Déferlante d'ombre",
	YellOnLifeLeech					= "Crie pour la Marque du Sans-visage",
	YellOnShadowCrash				= "Crie pour la Déferlante d'ombre",
	WarningLeechLife				= "Annonce la cible de la Marque du Sans-visage",
	hardmodeSpawn					= "Montre le timer pour l'arriver d'Animus de saronite (Hard Mode)"
}

L:SetMiscLocalization{
	EmoteSaroniteVapors	= "A cloud of saronite vapors coalesces nearby!",
	CrashWhisper		= "Déferlante d'ombre sur toi ! BOUGE !",
	YellLeech			= "Marque du Sans-visage sur moi !",
	YellCrash			= "Déferlante d'ombre sur moi !"
}


------------------
--  Yogg Saron  --
------------------
L = DBM:GetModLocalization("YoggSaron")

L:SetGeneralLocalization{
	name = "Yogg-Saron"
}

L:SetMiscLocalization{
	YellPull 						= "Il sera bientôt temps de frapper la tête de la bête ! Concentrez votre rage et votre haine sur ses laquais !",
	YellPhase2 						= "Je suis le rêve éveillé",
	Sara 							= "Sara",
	WhisperBrainLink 				= "Votre cerveau est lié ! Courez vers %s !",
	WarningYellSqueeze				= "Ecrasement sur moi ! Aidez-moi !"
}

L:SetWarningLocalization{
	WarningGuardianSpawned 			= "Un gardien vient d'arriver",
	WarningCrusherTentacleSpawned	= "Une Tentacule écraseur vient d'arriver",
	WarningP2 						= "Phase 2",
	WarningP3 						= "Phase 3",
	WarningBrainLink 				= "Cerveaux liés sur >%s< et >%s<",
	SpecWarnBrainLink 				= "Cerveaux liés sur Vous et sur %s !",
	WarningSanity 					= "%d de Santé mentale restant",
	SpecWarnSanity 					= "%d de Santé mentale restant",
	SpecWarnGuardianLow				= "Arretez d'attaquer ce gardien !",
	WarnMadness						= "Incantation de Susciter la folie en cours",
	SpecWarnMadnessOutNow			= "Incantation de Susciter la folie fini - SORTEZ",
	WarnBrainPortalSoon				= "Portail dans 3 sec",	
	WarnSqueeze 					= "Ecrasement: >%s<",
	WarnFavor						= "Ferveur de Sara sur >%s<",
	SpecWarnFavor					= "Ferveur de Sara sur VOUS",
	WarnEmpowerSoon					= "Renforcement des ombres Bientôt !",
	SpecWarnMaladyNear				= "Mal de la raison à côté de vous sur >%s<",
	SpecWarnDeafeningRoar			= "Rugissement assourdissant",
	specWarnBrainPortalSoon			= "Portail bientôt"
}

L:SetTimerLocalization{
	NextPortal			= "Portail du Cerveau"
}

L:SetOptionLocalization{
	WarningGuardianSpawned			= "Annonce l'arrivée des Gardiens",
	WarningCrusherTentacleSpawned	= "Annonce l'arrivée des Tentacules",
	WarningP2						= "Annonce la Phase 2",
	WarningP3						= "Annonce la Phase 3",
	WarningBrainLink				= "Annonce les Cerveaux liés",
	SpecWarnBrainLink				= "Montre une alerte spéciale quand il y a des Cerveaux liés",
	WarningSanity					= "Montre une alerte quand la Santé mentale est basse",
	SpecWarnSanity					= "Montre une alerte quand la Santé mentale est très basse",
	SpecWarnGuardianLow				= "Montre une alerte spéciale quand les gardiens (P1) n'a plus beaucoup de vie",
	WarnMadness						= "Annonce Susciter la folie",
	WarnBrainPortalSoon				= "Annonce les Portails",
	SpecWarnMadnessOutNow			= "Montre une alerte spéciale avant la fin du cast de Susciter la folie",
	SetIconOnFearTarget				= "Met une icône sur la cible du fear",
	WarnFavor						= "Annonce la cible de la ferveur de Sara",
	SpecWarnFavor					= "Montre une alerte spéciale pour la ferveur de Sara",
	WarnSqueeze						= "Annonce la cible d'Ecrasement",
	specWarnBrainPortalSoon			= "Annonce l'arrivée d'un portail",
	WarningSqueeze					= "Annonce la cible d'Ecrasement",
	NextPortal						= "Montre un timer avant le prochain portail",
	WhisperBrainLink				= "Envoie un whisp aux Cerveaux liés",
	SetIconOnFavorTarget			= "Met une icône sur les cible de la ferveur de Sara",
	SetIconOnMCTarget				= "met une icône sur la cible du contrôle mental",
	ShowSaraHealth					= "Montre la vie de Sara durant la P1 (Doit être sélectionnée par au moins un membre du raid)",
	WarnEmpowerSoon					= "Alerte avant le Renforcement des ombres",
	SpecWarnMaladyNear				= "Montre une alerte spéciale si une personne à côté de vous est victime du Mal de la raison",
	SpecWarnDeafeningRoar			= "Montre une alerte spéciale pour le Rugissement assourdissant (silence et haut-fait)"
}



