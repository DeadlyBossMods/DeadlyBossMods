if GetLocale() ~= "frFR" then return end

local L


----------------------
--  FlameLeviathan  --
----------------------
L = DBM:GetModLocalization("FlameLeviathan")

L:SetGeneralLocalization{
	name = "LÃ©viathan des flammes"
}

L:SetTimerLocalization{
	timerPursued		= "Poursuivi: %s",
	timerFlameVents		= "Flots de flammes",
	timerSystemOverload	= "SystÃ¨me en surchage"
}
	
L:SetMiscLocalization{
	YellPull		= "EntitÃ©s hostiles dÃ©tectÃ©es. Protocole d'estimation de menace actif. Acquisition de la cible primaire. DÃ©compte avant rÃ©Ã©valuationÂ : 30Â secondes.",
	Emote			= "%%s poursuit (%S+)%."
}

L:SetWarningLocalization{
	pursueTargetWarn	= "Poursuit >%s<!",
	warnNextPursueSoon	= "Changement de cible dans 5 Sec"
}

L:SetOptionLocalization{
	timerSystemOverload	= "Activer le timer pour la surchage du systÃ¨me",
	timerFlameVents		= "Activer le timer pour les Flots de flammes",
	timerPursued		= "Activer le timer pour la poursuite",
	SystemOverload		= "Afficher l'avertissement spÃ©cial pour la surchage du systÃ¨me",
	SpecialPursueWarnYou	= "Afficher l'avertissement spÃ©cial quand un joueur est poursuivi",
	PursueWarn		= "Afficher l'avertissement quand vous Ãªtes poursuivi",
	warnNextPursueSoon	= "PrÃ©venir avant la prochaine poursuite"
}


-------------
--  Ignis  --
-------------
L = DBM:GetModLocalization("Ignis")

L:SetGeneralLocalization{
	name = "Ignis le maÃ®tre de la Fournaise"
}

L:SetTimerLocalization{
	TimerFlameJetsCast		= "Flots de flammes",
	TimerFlameJetsCooldown	= "Prochain flots de flammes dans",
	TimerScorch				= "Prochaine brÃ»lure dans",
	TimerScorchCast			= "BrÃ»lure",
	TimerSlagPot			= "Marmite de scories: %s"
}

L:SetWarningLocalization{
	WarningSlagPot			= "Marmite de scories sur >%s<",
	SpecWarnJetsCast		= "Flots de flammes - Stop Cast"
}

L:SetOptionLocalization{
	SpecWarnJetsCast	= "Activer l'avertissement spÃ©cial pour les Flots de flammes (contresort)",
	TimerFlameJetsCast	= "Afficher le timer des Flots de flammes",
	TimerFlameJetsCooldown	= "Afficher le cooldown du Flots de flammes",
	TimerScorch		= "Afficher le cooldown de brÃ»lure",
	TimerScorchCast		= "Afficher la barre de cast de brÃ»lure",
	WarningSlagPot		= "Annoncer la cible de la Marmite de scories",
	TimerSlagPot		= "Afficher le timer de la Marmite de scories",
	SlagPotIcon		= "Mettre un icà®¥sur la cible de la Marmite de scories"
}

------------------
--  Razorscale  --
------------------
L = DBM:GetModLocalization("Razorscale")

L:SetGeneralLocalization{
	name = "TranchÃ©caille"
}     

L:SetWarningLocalization{
	SpecWarnDevouringFlame	= "Flamme dÃ©vorante - BOUGEZ",
	warnTurretsReadySoon	= "QuatriÃ¨me tourelle Ã  harpon prÃªte dans 20 Sec",
	warnTurretsReady		= "QuatriÃ¨me tourelle Ã  harpon prÃªte",
	SpecWarnDevouringFlameCast	= "Flamme dÃ©vorante sur Vous",
	WarnDevouringFlameCast		= "Flamme dÃ©vorante sur >%s<" 
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
	SpecWarnDevouringFlame		= "Activer l'avertissement spÃ©cial pour les Flammes dÃ©vorantes",
	PlaySoundOnDevouringFlame	= "Jouer un son quand vous Ãªtes affectÃ© par la Flamme dÃ©vorante",
	timerAllTurretsReady		= "Afficher un timer pour les tourelles",
	warnTurretsReadySoon		= "Activer le prÃ©-avertissement pour les tourelles",
	warnTurretsReady			= "Activer l'avertissement pour les tourelles",
	SpecWarnDevouringFlameCast	= "Montre une alerte spÃ©cial quand les Flamme dÃ©vorante sont cast sur Vous",
	timerTurret1			= "Montre le timer pour la tourelle 1",
	timerTurret2			= "Montre le timer pour la tourelle 2",
	timerTurret3			= "Montre le timer pour la tourelle 3 (Heroique)",
	timerTurret4			= "Montre le timer pour la tourelle 4 (Heroique)",
	OptionDevouringFlame		= "Annonce la cible des Flamme dÃ©vorante (unreliable)",
	timerGroundedTemp		= "Montre le timer pour la phase au sol"
}

L:SetMiscLocalization{
	YellAir = "Laissez un instant pour prÃ©parer la construction des tourelles.",
	YellAir2			= "Incendie Ã©teintÂ ! Reconstruisons les tourellesÂ !",
	YellGroundTemp			= "Faites viteÂ ! Elle va pas rester au sol trÃ¨s longtempsÂ !",
	EmotePhase2			= "%%s bloquÃ©e au solÂ !",
}


-------------
--  XT002  --
-------------
L = DBM:GetModLocalization("XT002")

L:SetGeneralLocalization{
	name = "DÃ©constructeur XT-002"
}

L:SetTimerLocalization{
	timerTympanicTantrumCast	= "Lancement de ColÃ¨re assourdissante",
	timerTympanicTantrum		= "ColÃ¨re assourdissante",
	timerLightBomb			= "Bombe de lumiÃ¨re: %s",
	timerGravityBomb		= "Bombe Ã  gravitÃ©: %s",
}

L:SetWarningLocalization{
	SpecialWarningLightBomb 	= "Bombe de lumiÃ¨re sur TOI",
	WarningLightBomb		= "Bombe de lumiÃ¨re sur >%s<",
	SpecialWarningGravityBomb	= "Bombe Ã  gravitÃ© sur TOI",
	WarningGravityBomb		= "Bombe Ã  gravitÃ© sur >%s<",
}

L:SetOptionLocalization{
	SpecialWarningLightBomb		= "Activer l'avertissement spÃ©cial quand vous Ãªtes affectÃ© par la bombe de lumiÃ¨re",
	WarningLightBomb			= "Annoncer les bombes de lumiÃ¨re",
	SpecialWarningGravityBomb	= "Activer l'avertissement spÃ©cial quand vous Ãªtes affectÃ© par la bombe Ã  gravitÃ©",
	WarningGravityBomb			= "Annoncer les bombes Ã  gravitÃ©",
	PlaySoundOnGravityBomb		= "Jouer un son quand la bombe Ã  gravitÃ© est sur vous",
	PlaySoundOnTympanicTantrum	= "Jouer un son au lancement de la colÃ¨re assourdissante",
	SetIconOnLightBombTarget	= "Mettre un icÃ´ne sur la cible de la bombe de lumiÃ¨re",
	SetIconOnGravityBombTarget	= "Mettre un icÃ´ne sur la cible de la bombe Ã  gravitÃ©",
}

-------------------
--  IronCouncil  --
-------------------
L = DBM:GetModLocalization("IronCouncil")

L:SetGeneralLocalization{
	name = "AssemblÃ©e du Fer"
}

L:SetWarningLocalization{
	WarningSupercharge		= "Supercharge imminente",
	WarningChainlight		= "ChaÃ®ne d'Ã©clairs",
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
	TimerLightningTendrils		= "Vrilles d'Ã©clair",
	timerFusionPunchCast		= "Incantation du coup de poing fusion",
	timerFusionPunchActive		= "Coup de poing fusion: %s",
	timerOverwhelmingPower		= "Puissance accablante: %s",
	timerRunicBarrier		= "BarriÃ¨re runique",
	timerRuneofDeath		= "Rune de mort",
}

L:SetOptionLocalization{
	TimerSupercharge		= "Afficher le timer de la Supercharge",
	WarningSupercharge		= "Activer l'avertissement quand la Supercharge est incantÃ©",
	WarningChainlight		= "Annoncer les ChaÃ®nes d'Ã©clairs",
	TimerOverload			= "Afficher la barre d'incantation de la surcharge",
	TimerLightningWhirl		= "Afficher la barre d'incantation des Ã©clairs tourbillonnants",
	LightningTendrils		= "Activer l'avertissement spÃ©cial pour les Vrilles d'Ã©clair",
	TimerLightningTendrils		= "Afficher la durÃ©e des Vrilles d'Ã©clair",
	PlaySoundLightningTendrils	= "Jouer un son pour les Vrilles d'Ã©clair",
	WarningFusionPunch		= "Annoncer les coups de poing fusion",
	timerFusionPunchCast		= "Afficher la barre d'incantation pour les coups de poing fusion",
	timerFusionPunchActive		= "Afficher un timer pour les coups de poing fusion",
	WarningOverwhelmingPower	= "Annoncer la Puissance accablante",
	timerOverwhelmingPower		= "Afficher un timer pour la Puissance accablante",
	SetIconOnOverwhelmingPower	= "Mettre un icÃ´ne sur la cible de la Puissance accablante",
	timerRunicBarrier		= "Afficher un timer pour la BarriÃ¨re runique",
	WarningRuneofPower		= "Annoncer les runes de puissance",
	WarningRuneofDeath		= "Annoncer les runes de mort",
	RuneofDeath			= "Activer l'avertissement spÃ©cial pour les runes de mort",
	timerRuneofDeath		= "Afficher la durÃ©e des runes de mort",
	WarningRuneofSummoning			= "Annonce les Rune d'invocation",
	SetIconOnStaticDisruption		= "Met une icone sur la cible de Static Disruption",
	Overload				= "Montre une alerte spÃ©cial pour la Surcharge",
	AllwaysWarnOnOverload			= "Toujours alerter pour la surcharge (otherwise only when targeted)",
	PlaySoundOnOverload			= "Joue un sons a la surcharge",
	WarningStaticDisruption			= "Annonce la Static Disruption"
}

L:SetMiscLocalization{
	Steelbreaker		= "Brise-acier",
	RunemasterMolgeim	= "Maïµ²e des runes Molgeim",
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
	SpecWarnPhasePunch	= "Activer l'avertissement spÃ©cial quand vous Ãªtes la cible du coup de poing phasique",
	WarningPhasePunch	= "Annoncer la cible du Coup de poing phasique",
	WarningBlackHole	= "Annoncer les trous noirs",
	WarningBigBang		= "Annonce le cast du Big Bang",
	PreWarningBigBang	= "PrÃ© annonce le Big Bang",
	NextCollapsingStar	= "Montre un timer pour le prochain choque cosmique"
}

L:SetMiscLocalization{
	YellPull		= "Vos actions sont illogiques. Tous les rÃ©sultats possibles de cette rencontre ont Ã©tÃ© calculÃ©s. Le panthÃ©on recevra le message de l'Observateur quelque soit l'issue."
}

----------------
--  Kologarn  --
----------------
L = DBM:GetModLocalization("Kologarn")

L:SetGeneralLocalization{
	name = "Kologarn"
}

L:SetWarningLocalization{
	SpecialWarningEyebeam	= "Rayon de l'Å’il sur TOI - ECARTE-TOI",
	WarningEyebeam			= "Rayon de l'Å’il sur >%s<",
	WarnGrip				= "Poigne sur >%s<"
}

L:SetTimerLocalization{
	timerEyebeam			= "Rayon de l'Å’il: %s",
	timerPetrifyingBreath	= "Souffle pÃ©trifiant",
	timerNextShockwave		= "Prochaine Onde de choc",
	timerLeftArm			= "Repop du bras gauche",
	timerRightArm			= "Repop du bras droit"
}

L:SetOptionLocalization{
	SpecialWarningEyebeam		= "Activer l'avertissement spÃ©cial quand vous Ãªtes la cible du Rayon de l'Å’il",
	WarningEyebeam			= "Annoncer la cible du Rayon de l'Å’il",
	timerEyebeam			= "Afficher un timer pour le Rayon de l'Å’il",
	SetIconOnEyebeamTarget		= "Mettre un icÃ´ne sur la cible du Rayon de l'Å’il",
	timerPetrifyingBreath		= "Afficher un timer pour le souffle pÃ©trifiant",
	timerNextShockwave		= "Afficher un timer pour l'onde de choc",
	timerLeftArm			= "Afficher un timer pour le repop du bras gauche",
	timerRightArm			= "Afficher un timer pour le repop du bras droit",
	WarnGrip				= "Annonce les Targets de la poigne",
	WarnEyeBeam				= "Annonce les targets du rayon",
	SetIconOnGripTarget		= "Met une icone sur les joueurs victime du sort poigne"
}

L:SetMiscLocalization{
	Yell_Trigger_arm_left		= "Juste une Ã©raflureÂ !",
	Yell_Trigger_arm_right		= "Une blessure superficielleÂ !",
	Health_Body				= "Torse de Kologarn",
	Health_Right_Arm		= "Bras droit",
	Health_Left_Arm			= "Bras gauche",
	FocusedEyebeam			= "%s concentre son regard sur vousÂ !"
}

---------------
--  Auriaya  --
---------------
L = DBM:GetModLocalization("Auriaya")

L:SetGeneralLocalization{
	name = "Auriaya"
}

L:SetMiscLocalization{
	Defender = "DÃ©fenseur farouche (%d)"
}

L:SetWarningLocalization{
	SpecWarnBlast = "DÃ©flagration du factionnaire - Interrompu!",
	WarnCatDied = "DÃ©fenseur farouche mort (%d vies restantes)",
	WarnFear = "Hurlement terrifiant!",
	WarnFearSoon = "Hurlement terrifiant imminent",
	WarnSonic		= "Hurlement sonore",
	WarnSwarm		= "Essaim gardien sur >%s<",
	SpecWarnVoid		= "Void Zone - BOUGEZ!",
	WarnCatDiedOne 		= "DÃ©fenseur farouche mort (1 vie en moin)",
}

L:SetOptionLocalization{
	SpecWarnBlast = "Activer l'avertissement spÃ©cial pour les DÃ©flagration du factionnaire",
	WarnFear = "Activer l'avertissement pour les Hurlements terrifiants",
	WarnFearSoon = "Activer l'avertissement pour le Hurlement terrifiant imminent",
	WarnCatDied = "Activer l'avertissement quand un dÃ©fenseur farouche meurt",
	WarnSwarm		= "Activer l'avertissement pour les Essaims gardien",
	WarnSonic		= "Activer l'avertissement pour les Hurlements sonores",
	SpecWarnVoid		= "Montre une alerte spÃ©cial quand vous Ãªtes dans une Void Zone",
	WarnCatDiedOne		= "Montre une alerte spÃ©cial quand un DÃ©fenseur farouche meur"
}


-------------
--  Hodir  --
-------------
L = DBM:GetModLocalization("Hodir")

L:SetGeneralLocalization{
	name = "Hodir"
}

L:SetWarningLocalization{
	WarningFlashFreeze	= "Gel instantanÃ©",
	WarningBitingCold	= "Froid mordant - BOUGE",
	WarningStormCloud	= "TempÃ¨te de glace sur >%s<", 
}

L:SetTimerLocalization{
	TimerFlashFreeze	= "Gel instantanÃ© imminent",  -- all ppl have to move on the rock patches
}

L:SetOptionLocalization{
	TimerFlashFreeze	= "Afficher une barre d'incantation pour le gel instantanÃ©",
	WarningFlashFreeze	= "Activer l'avertissement pour le gel instantanÃ©",
	WarningBitingCold	= "Activer l'avertissement pour le froid mordant",
	PlaySoundOnFlashFreeze	= "Jouer un son lors de l'incantation du gel instantanÃ©",
	WarningStormCloud	= "Annonce le joueur de la tempÃ¨te de glace",
	YellOnStormCloud	= "Crie quand la tempÃ¨te de glace est active",
	SetIconOnStormCloud	= "Met une icone sur la cible de la tempÃ¨te de glace"
}

L:SetMiscLocalization{
	YellKill		= "Je suis... libÃ©rÃ© de son emprise... enfin."
}


--------------
--  Thorim  --
--------------
L = DBM:GetModLocalization("Thorim")

L:SetGeneralLocalization{
	name = "Thorim"
}

L:SetWarningLocalization{
	WarningStormhammer	= "Marteau-tempÃªte sur >%s<",
	UnbalancingStrike	= "Frappe dÃ©sÃ©quilibrante sur >%s<",
	WarningPhase2	= "Phase 2",
	WarningLightningCharge	= "Charge de foudre",
	WarningBomb	= "DÃ©tonation runique sur >%s<",
	LightningOrb = "Horion de foudre sur TOI! Bouge!"
}

L:SetTimerLocalization{
	TimerStormhammer	= "Marteau-tempÃªte (CD)",
	TimerUnbalancingStrike	= "Frappe dÃ©sÃ©quilibrante (CD)",
	TimerHardmode	= "Mode difficile"
}

L:SetOptionLocalization{
	TimerStormhammer	= "Afficher le cooldown du marteau-tempÃªte",
	TimerUnbalancingStrike	= "Afficher le timer pour la frappe dÃ©sÃ©quilibrante",
	TimerHardmode	= "Afficher le timer pour le mode difficile",
	UnbalancingStrike	= "Annoncer la cible de la frappe dÃ©sÃ©quilibrante",
	WarningStormhammer	= "Annoncer la cible du marteau-tempÃªte",
	WarningPhase2	= "Annoncer la phase 2",
	WarningBomb	= "Annoncer la dÃ©tonation runique",
	RangeFrame	= "Afficher la fenÃªtre de portÃ©e",
	WarningLightningCharge		= "Annonce les charges de foudre",
	AnnounceFails			= "Post player fails for Lightning Charge to the raid chat (requires announce enabled and promoted/leader status)" 
}

L:SetMiscLocalization{
	YellPhase1		= "Des intrusÂ ! Mortels, vous qui osez me dÃ©ranger en plein divertissement, allez payerÂ ! Attendez... vousÂ ?",    -- A vÃ©rifier
	YellPhase2		= "Avortons impertinents. Vous osez me dÃ©fier sur mon piÃ©destalÂ ! Je vais vous Ã©craser moi-mÃªmeÂ !"              -- A vÃ©rifier
}


-------------
--  Freya  --
-------------
L = DBM:GetModLocalization("Freya")

L:SetGeneralLocalization{
	name = "Freya"
}

L:SetMiscLocalization{
	SpawnYell = "Mes enfants, venez m'aiderÂ !",
	WaterSpirit = "Esprit de l'eau ancien",
	Snaplasher = "Flagellant mordant",
	StormLasher = "Flagellant des tempÃªtes",
	YellKill	= "Son emprise sur moi se dissipe. J'y vois Ã  nouveau clair. Merci, hÃ©ros."
}

L:SetWarningLocalization{
	WarnPhase2 = "Phase 2",
	WarnSimulKill = "Premier add mort - RÃ©surection dans 1 minute",
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
	SpecWarnFury		= "Montre des alerte spÃ©cial pour la Fureur de la Nature",
	WarningTremor		= "Montre une alerte spÃ©cial pour le tremblement de terre (Hard-Mode)",
	TimerSimulKill		= "Montre le timer de la rÃ©surection des mobs",
	UnstableEnergy		= "Montre une alerte spÃ©cial pour l'Ã©nergie instable"
}

-- Elders
L = DBM:GetModLocalization("Freya_Elders")

L:SetGeneralLocalization{
	name = "Freya's Elders"
}

L:SetOptionLocalization{
	SpecWarnFistOfStone	= "Montre une alerte spÃ©cial pour le coup de poings de pierre",
	SpecWarnGroundTremor	= "Montre une alerte spÃ©cial pour le tremblement de terre",
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
	MagneticCore		= ">%s< viens de loot le Core MagnÃ©tique",
	WarningShockBlast	= "Horion explosif - BOUGEZ",
	WarnBombSpawn		= "Robot Bombe viens de pop"
}

L:SetTimerLocalization{
	ProximityMines		= "Nouvelle Mines de proximitÃ©",
	TimeToPhase2		= "Phase 2",
	TimeToPhase3		= "Phase 3",
	TimeToPhase4		= "Phase 4"
}

L:SetOptionLocalization{
	WarningShockBlast	= "Montre les alertes pour les Horion explosif",
	WarningPlasmaBlast	= "Montre les alertes pour les Explosion de plasma",
	ProximityMines		= "Montre le timer pour les Mines de proximitÃ©",
	DarkGlare				= "Montre une alerte spÃ©cial pour le Barrage laser",
	WarnBlast				= "Annonce la cible des Explosion de plasma",
	WarnShell				= "Annonce la cible des Obus napalm",
	TimeToPhase2			= "Montre le timer pour la Phase 2",
	TimeToPhase3			= "Montre le timer pour la Phase 3",
	TimeToPhase4			= "Montre le timer pour la Phase 4",
	MagneticCore			= "Annonce qui a loot le Core MagnÃ©tique",
	HealthFramePhase4		= "Montre les barres de vie dans la phase 4",
	AutoChangeLootToFFA		= "Met le butin en acces libre durant la phase 3",
	WarnBombSpawn			= "Annonce les Robot Bombe",
	PlaySoundOnShockBlast	= "Joue un sons lors des Horion explosif",
	PlaySoundOnDarkGlare	= "Joue un sons au Barrage laser",
	ShockBlastWarningInP1	= "Montre une alerte spÃ©cial pour les Horion explosif durant la Phase 1",
	ShockBlastWarningInP4	= "Montre une alerte spÃ©cial pour les Horion explosif durant la Phase 2"
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
	name = "GÃ©nÃ©ral Vezax"
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