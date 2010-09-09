if GetLocale() ~= "frFR" then return end

local L

---------------------------
--  Trash - Lower Spire  --
---------------------------
L = DBM:GetModLocalization("LowerSpireTrash")

L:SetGeneralLocalization{
	name = "Lower Spire trash"
}

L:SetWarningLocalization{
	SpecWarnTrap		= "Trap Activated! - Deathbound Ward released"--creatureid 37007
}

L:SetOptionLocalization{
	SpecWarnTrap		= "Show special warning for trap activation",
	SetIconOnDarkReckoning	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69483),
	SetIconOnDeathPlague	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72865)
}

L:SetMiscLocalization{
	WarderTrap1		= "Who... goes there...?",
	WarderTrap2		= "I... awaken!",
	WarderTrap3		= "The master's sanctum has been disturbed!"
}

---------------------------
--  Trash - Plagueworks  --
---------------------------
L = DBM:GetModLocalization("PlagueworksTrash")

L:SetGeneralLocalization{
	name = "Plagueworks Trash"
}

L:SetWarningLocalization{
	WarnMortalWound	= "%s on >%s< (%s)",		-- Mortal Wound on >args.destName< (args.amount)
	SpecWarnTrap	= "Trap Activated! - Vengeful Fleshreapers incoming"--creatureid 37038
}

L:SetOptionLocalization{
	SpecWarnTrap	= "Show special warning for trap activation",
	WarnMortalWound	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(71127, GetSpellInfo(71127) or "unknown")
}

L:SetMiscLocalization{
	FleshreaperTrap1		= "Quickly! We'll ambush them from behind!",
	FleshreaperTrap2		= "You... cannot escape us!",
	FleshreaperTrap3		= "The living... here?!"
}

---------------------------
--  Trash - Crimson Hall  --
---------------------------
L = DBM:GetModLocalization("CrimsonHallTrash")

L:SetGeneralLocalization{
	name = "Crimson Hall Trash"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
	BloodMirrorIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70451)
}

L:SetMiscLocalization{
}

----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization{
	name = "Seigneur Gargamoelle"
}

L:SetTimerLocalization{
	AchievementBoned		= "Temps pour libérer"
}

L:SetWarningLocalization{
	WarnImpale				= ">%s< est empalé(e)"
}

L:SetOptionLocalization{
	WarnImpale				= "Annonce les cibles de $spell:69062",
	AchievementBoned		= "Montre le timer pour le haut-fait Dans l'os",
	SetIconOnImpale			= "Met des icônes sur les cibles de $spell:69062"
}

-------------------------
--  Lady Deathwhisper  --
-------------------------
L = DBM:GetModLocalization("Deathwhisper")

L:SetGeneralLocalization{
	name = "Dame Murmemort"
}

L:SetTimerLocalization{
	TimerAdds						= "Nouveaux Adds"
}

L:SetWarningLocalization{
	WarnReanimating					= "Les adds revivent",
	WarnTouchInsignificance			= "%s sur >%s< (%s)",
	WarnAddsSoon					= "Nouveaux adds bientôt",
	SpecWarnVengefulShade			= "Ombre vengeresse vous attaque - COUREZ"
}

L:SetOptionLocalization{
	WarnAddsSoon					= "Montre une pré-alerte avant que les adds arrivent",
	WarnTouchInsignificance			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(71204, GetSpellInfo(71204) or "unknown"),
	WarnReanimating					= "Montre une alerte quand les adds vont revenir a la vie",
	TimerAdds						= "Montre le timer pour les nouveaux adds",
	SpecWarnVengefulShade			= "Montre une alerte spéciale quand vous êtes attaquer par une Ombre vengeresse",
	ShieldHealthFrame				= "Montre la vie du boss avec une barre de vie pour la $spell:70842",
	SetIconOnDominateMind			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71289),
	SetIconOnDeformedFanatic		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70900),
	SetIconOnEmpoweredAdherent		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70901)
}

L:SetMiscLocalization{
	YellPull						= "Quelle est cette perturbation ? Vous osez profaner cette terre sacrée ? Elle deviendra votre sépulture !",
	YellReanimatedFanatic			= "Lève-toi, dans l'exultation de cette nouvelle pureté",
	ShieldPercent					= "Barrière de mana",
	Fanatic1						= "Membres du culte",
	Fanatic2						= "Fanatique déformé",
	Fanatic3						= "Fanatique réanimé"
}

-----------------------------
--  Deathbringer Saurfang  --
-----------------------------
L = DBM:GetModLocalization("Deathbringer")

L:SetGeneralLocalization{
	name = "Porte-Mort Saurcroc"
}

L:SetWarningLocalization{
	WarnFrenzySoon		= "Frénésie bientôt"
}

L:SetTimerLocalization{
	TimerCombatStart	= "Début du combat"
}

L:SetOptionLocalization{
	WarnFrenzySoon		= "Montre une pré-alerte pour la Frénésie (à ~33%)",
	RangeFrame			= "Montre la fenêtre de proximité",
	TimerCombatStart	= "Montre le timer pour le début du combat",
	BoilingBloodIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72441),
	MarkCastIcon		= "Met des icones sur les cibles de $spell:72444 durant l'incantation (Experimental)",
	RunePowerFrame		= "Montre la barre de vie du boss + la barre de $spell:72371"
}

L:SetMiscLocalization{
	RunePower			= "Bêtes de sang",
	PullAlliance		= "Bon allez, on se bouge",
	PullHorde			= "surveillez bien vos arrières"
}

----------------------
--  Gunship Battle  --
----------------------
L = DBM:GetModLocalization("GunshipBattle")

L:SetGeneralLocalization{
	name = "La Bataille aérienne en Canonnière"
}

L:SetWarningLocalization{
	WarnBattleFury		= "%s (%d)",
	WarnAddsSoon		= "Nouveaux Add Bientôt"
}

L:SetOptionLocalization{
	WarnBattleFury		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(69638, GetSpellInfo(69638) or "Battle Fury"),
	TimerCombatStart	= "Montre le timer pour le début du combat",
	WarnAddsSoon		= "Montre une alerte avant que les adds arrivent",
	TimerAdds			= "Montre le timer pour les nouveaux adds"
}

L:SetTimerLocalization{
	TimerCombatStart	= "Le combat débute",
	TimerAdds			= "Nouveaux Adds"
}

L:SetMiscLocalization{
	PullAlliance		= "Faites chauffer les moteurs",
	KillAlliance		= "Vous direz pas que j'vous avais pas prévenus",
	PullHorde			= "nous affrontons le plus haï de nos ennemis",
	KillHorde			= "L'Alliance baisse pavillon"
}

-----------------
--  Festergut  --
-----------------
L = DBM:GetModLocalization("Festergut")

L:SetGeneralLocalization{
	name = "Pulentraille"
}

L:SetWarningLocalization{
	InhaledBlight		= "Prochain Chancre >%d<",
	WarnGastricBloat	= "%s sur >%s< (%s)"
}

L:SetOptionLocalization{
	InhaledBlight		= "Montre une alerte pour le $spell:71912",
	RangeFrame			= "Montre la fenêtre de portée (8 Mètres)",
	WarnGastricBloat	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(72551, GetSpellInfo(72551) or "unknown"),	
	SetIconOnGasSpore	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69279)
}

---------------
--  Rotface  --
---------------
L = DBM:GetModLocalization("Rotface")

L:SetGeneralLocalization{
	name = "Trognepus"
}

L:SetWarningLocalization{
	WarnOozeSpawn				= "Les Limons sont arrivées",
	WarnUnstableOoze			= "%s sur >%s< (%s)",
	SpecWarnLittleOoze			= "Les Limons vous attaque - COUREZ"
}

L:SetTimerLocalization{
	NextPoisonSlimePipes		= "Prochain distributeur de poison :"
}

L:SetOptionLocalization{
	NextPoisonSlimePipes		= "Montre le timer pour le prochain distributeur de poison",
	SpecWarnMutatedInfection 	= "Montre une alerte spéciale quand vous êtes affecté par Infection mutée",
	InfectionIcon				= "Met des icones sur la cible de l'Infection mutée",
	WarnOozeSpawn				= "Montre une alerte pour l'arrivée des Limons",
	SpecWarnLittleOoze			= "Montre une alerte spéciale quand vous êtes attaquer par des Limons",
	WarnUnstableOoze			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(69558, GetSpellInfo(69558) or "unknown")
}

L:SetMiscLocalization{
	YellSlimePipes1				= "réparé le distributeur de poison",	-- Professor Putricide
	YellSlimePipes2				= "Great news, everyone! The slime is flowing again!"	-- Professor Putricide
}

---------------------------
--  Professor Putricide  --
---------------------------
L = DBM:GetModLocalization("Putricide")

L:SetGeneralLocalization{
	name = "Professeur Putricide"
}

L:SetWarningLocalization{
	WarnPhase2Soon				= "Phase 2 bientôt",
	WarnPhase3Soon				= "Phase 3 bientôt",
	WarnMutatedPlague			= "%s sur >%s< (%s)",
	SpecWarnMalleableGoo		= "Gelée malléable sur Vous - BOUGEZ",
	SpecWarnMalleableGooNear	= "Gelée malléable à coter de Vous - Regardez",
	SpecWarnUnboundPlague		= "Perdez la Peste déliée",
	SpecWarnNextPlageSelf		= "Vous êtes le prochain pour la Peste déliée - Soyez pret"
}

L:SetOptionLocalization{
	WarnPhase2Soon				= "Montre une alerte avant la Phase 2 (at ~83%)",
	WarnPhase3Soon				= "Montre une alerte avant la 3 (at ~38%)",
	SpecWarnMalleableGoo		= "Montre une alerte spéciale si la Gelée malléable va sur vous (Marche seulement si vous êtes la première cible)",
	SpecWarnMalleableGooNear	= "Montre une alerte spéciale si la Gelée malléable va sur un joueur a coter de vous (Marche seulement si le joueur a coter de vous est la première cible)",
	WarnMutatedPlague			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(72451, GetSpellInfo(72451) or "unknown"),
	OozeAdhesiveIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70447),
	GaseousBloatIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70672),
	UnboundPlagueIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72856),
	MalleableGooIcon			= "Met une icone sur la première cible de $spell:72295",
	NextUnboundPlagueTargetIcon	= "Met une icone sur la prochaine cible de $spell:72856",
	YellOnMalleableGoo			= "Crie pour $spell:72295",	
	SpecWarnUnboundPlague		= "Montre une alerte spéciale pour le transfert de $spell:72856",
	SpecWarnNextPlageSelf		= "Montre une alerte spéciale si vous êtes la cible suivante de $spell:72856"
}

L:SetMiscLocalization{
	YellPull		= "mis au point une peste qui va",
	YellMalleable	= "Gelée malléable sur MOI !"
}

----------------------------
--  Blood Prince Council  --
----------------------------
L = DBM:GetModLocalization("BPCouncil")

L:SetGeneralLocalization{
	name = "Princes de Sang"
}

L:SetWarningLocalization{
	WarnTargetSwitch		= "Changement de cible sur : %s",
	WarnTargetSwitchSoon	= "Changement de cible bientôt",
	SpecWarnVortex			= "Vortex de choc sur VOUS - BOUGEZ",
	SpecWarnVortexNear		= "Vortex de choc à coter de Vous - REGARDEZ"
}

L:SetTimerLocalization{
	TimerTargetSwitch		= "Possible changement de cible"
}

L:SetOptionLocalization{
	WarnTargetSwitch		= "Montre l'alerte pour le changement de cible",
	WarnTargetSwitchSoon	= "Montre une pré-alerte pour le changement de cible",
	TimerTargetSwitch		= "Montre un timer pour le changement de cible",
	SpecWarnVortex			= "Montre une alerte spéciale pour le $spell:72037 sur vous",
	SpecWarnVortexNear		= "Montre une alerte spéciale pour le $spell:72037 à coter de vous",
	EmpoweredFlameIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72040),
	ActivePrinceIcon		= "Place l'icône de raid principale sur le prince de sang actuellement surpuissant (nécessite d'être assistant ou mieux)."
}

L:SetMiscLocalization{
	Keleseth				= "Prince Keleseth",
	Taldaram				= "Prince Taldaram",
	Valanar					= "Prince Valanar",
	EmpoweredFlames			= "L'Embrasement surpuissant (%S+)!"
}

-----------------------------
--  Blood-Queen Lana'thel  --
-----------------------------
L = DBM:GetModLocalization("Lanathel")

L:SetGeneralLocalization{
	name = "Reine de sang Lana'thel"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	SetIconOnDarkFallen			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71340),
	SwarmingShadowsIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71266),
	BloodMirrorIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70838)
}

L:SetMiscLocalization{
	SwarmingShadows			= "Shadows amass and swarm around (%S+)!"
}

-----------------------------
--  Valithria Dreamwalker  --
-----------------------------
L = DBM:GetModLocalization("Valithria")

L:SetGeneralLocalization{
	name = "Valithria Marcherêve"
}

L:SetWarningLocalization{
	WarnCorrosion	= "%s sur >%s< (%s)",
	WarnPortalOpen	= "Portails actifs !"
}

L:SetTimerLocalization{
	TimerPortalsOpen	= "Arrivée des portails"
}

L:SetOptionLocalization{
	SetIconOnBlazingSkeleton	= "Met une icone sur le Squelette flamboyant (Tête de mort)",
	WarnPortalOpen				= "Prévient via une alerte quand Valithria ouvre des portails.",
	TimerPortalsOpen			= "Montre une timer pour voir quand Valithria ouvre des portails.",
	WarnCorrosion				= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(70751, GetSpellInfo(70751) or "unknown")
}

L:SetMiscLocalization{
	YellPull		= "Ne gardez que les os et les tendons",
	YellKill		= "JE REVIS",
	YellPortals		= "Vous y trouverez votre salut",
	YellPhase2		= "My strength is returning. Press on, heroes!"
}

------------------
--  Sindragosa  --
------------------
L = DBM:GetModLocalization("Sindragosa")

L:SetGeneralLocalization{
	name = "Sindragosa"
}

L:SetTimerLocalization{
	TimerNextAirphase		= "Prochaine phase dans les airs",
	TimerNextGroundphase	= "Prochaine phase sur le sol",
	AchievementMystic		= "Time to clear Mystic stacks"
}

L:SetWarningLocalization{
	WarnAirphase			= "Phase dans les airs",
	WarnGroundphaseSoon		= "Sindragosa atterrie bientôt",
	WarnPhase2soon			= "Phase 2 bientôt",
	WarnInstability			= "Instabiliter >%d<",
	WarnChilledtotheBone	= "Transi jusqu'aux os >%d<",
	WarnMysticBuffet		= "Rafale mystique >%d<"
}

L:SetOptionLocalization{
	WarnAirphase				= "Annonce la phase dans les airs",
	WarnGroundphaseSoon			= "Montre une pré-alerte pour la phase au sol",
	TimerNextAirphase			= "Montre un timer pour la prochaine phase dans les airs",
	TimerNextGroundphase		= "Montre un timer pour la prochaine phase au sol",
	WarnPhase2soon				= "Montre une alerte pour la phase 2 (at ~38%)",
	WarnInstability				= "Montre une alerte pour les stacks de $spell:69766",
	WarnChilledtotheBone		= "Montre une alerte pour les stacks de $spell:70106",
	WarnMysticBuffet			= "Montre une alerte pour les stacks de $spell:70128",
	AnnounceFrostBeaconIcons	= "Annonce les icones pour les cibles de $spell:70126 dans le chat de raid (requires announce to be enabled and leader/promoted status)",
	SetIconOnFrostBeacon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70126),
	SetIconOnUnchainedMagic		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69762),
	ClearIconsOnAirphase		= "Retire toutes les icones avant la phase d'envol",
	RangeFrame					= "Montre la fenêtre de portée (10 normal, 20 heroic) (Montre uniquement les icones marquer sur les joueurs)"
}

L:SetMiscLocalization{
	YellAirphase	= "Votre incursion s'arrête ici",
	YellPhase2		= "Sentez maintenant le pouvoir infini de mon",
	YellAirphaseDem		= "Rikk zilthuras rikk zila Aman adare tiriosh ",--Demonic, since curse of tonges is used by some guilds and it messes up yell detection.
	YellPhase2Dem		= "Zar kiel xi romathIs zilthuras revos ruk toralar ",--Demonic, since curse of tonges is used by some guilds and it messes up yell detection.
	BeaconIconSet	= "Icone de Guide de givre {rt%d} mis sur %s",
	YellPull		= "est stupide d'être venus ici"
}

---------------------
--  The Lich King  --
---------------------
L = DBM:GetModLocalization("LichKing")

L:SetGeneralLocalization{
	name = "Le Roi Liche"
}

L:SetWarningLocalization{
	WarnPhase2Soon				= "Transition de la Phase 2 bientôt",
	WarnPhase3Soon				= "Transition de la Phase 3 bientôt",
	SpecWarnDefileCast			= "Profanation sur VOUS - BOUGEZ",
	SpecWarnDefileNear			= "Profanation à coter de VOUS - Regardez Autour",
	SpecWarnTrapNear			= "Piège d'ombre à coter de VOUS - Regardez Autour",
	WarnNecroticPlagueJump		= "La Peste nécrotique a sauter sur >%s<",
	WarningValkyrSpawned 		= "Val'kyr(s) spawn (%d)",
	SpecWarnValkyrLow		= "Valkyr below 55%"
}

L:SetTimerLocalization{
	TimerCombatStart			= "Le combat débute",
	TimerRoleplay				= "Jeux de role",
	PhaseTransition				= "Phase de transition",
	TimerNecroticPlagueCleanse 	= "Peste nécrotique Dispell"
}

L:SetOptionLocalization{
	TimerCombatStart			= "Montre le timer pour le début du combat",
	TimerRoleplay				= "Montre le timer pour l'event de role",
	WarnNecroticPlagueJump		= "Annonce sur qui saute la $spell:73912",
	TimerNecroticPlagueCleanse	= "Montre le timer pour dispell la Peste nécrotique avant le premier tic",
	PhaseTransition				= "Montre le timer pour la phase de transition",
	WarnPhase2Soon				= "Montre une alerte avant la transition de la phase 2 (at ~73%)",
	WarningValkyrSpawned		= "Montre une alerte pour l'arrivée des Val'kyr(s)",
	WarnPhase3Soon				= "Montre une alerte avant la transition de la phase 3 (at ~43%)",
	SpecWarnDefileCast			= "Montre une alerte spéciale pour la $spell:72762 sur vous",
	SpecWarnDefileNear			= "Montre une alerte spéciale pour la $spell:72762 à coter de vous",
	SpecWarnTrapNear			= "Montre une alerte spéciale pour le $spell:73539 à coter de vous",
	YellOnDefile				= "Crie pour $spell:72762",
	YellOnTrap					= "Crie pour $spell:73539",
	DefileIcon					= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72762),
	NecroticPlagueIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(73912),
	RagingSpiritIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69200),
	TrapIcon					= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(73539),
	ValkyrIcon					= "Met des icones sur les Valkyrs",
	DefileArrow					= "Montre les flèches de DBM quand $spell:72762 est à coter de vous",
	TrapArrow					= "Montre les flèches de DBM quand $spell:73539 est à coter de vous",
	SpecWarnValkyrLow		= "Show special warning when Valkyr is below 55% HP"
}

L:SetMiscLocalization{
	LKPull			= "la fameuse justice de la Lumière",
	YellDefile		= "Profanation sur MOI !",
	YellTrap		= "Piège d'ombre sur MOI !",
	YellKill		= "No questions remain unanswered. No doubts linger. You ARE Azeroth's greatest champions. You overcame every challenge I laid before you. My mightiest servants have fallen before your relentless onslaught... your unbridled fury...",
	LKRoleplay		= "Is it truly righteousness that drives you? I wonder...",
	PlagueWhisper	= "Vous êtes infecter par"
}

