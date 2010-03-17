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
	specWarnTrap		= "Trap Activated! - Deathbound Ward released"--creatureid 37007
}

L:SetOptionLocalization{
	specWarnTrap		= "Show special warning for trap activation",
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
	warnMortalWound	= "%s on >%s< (%s)",		-- Mortal Wound on >args.destName< (args.amount)
	specWarnTrap	= "Trap Activated! - Vengeful Fleshreapers incoming"--creatureid 37038
}

L:SetOptionLocalization{
	specWarnTrap	= "Show special warning for trap activation",
	warnMortalWound	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(71127, GetSpellInfo(71127) or "unknown")
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
	achievementBoned		= "Temps pour libérer"
}

L:SetWarningLocalization{
	WarnImpale				= ">%s< est empalé(e)"
}

L:SetOptionLocalization{
	WarnImpale				= "Annonce les cibles de $spell:69062",
	achievementBoned		= "Montre le timer pour le haut-fait Dans l'os",
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
	TimerAdds				= "Nouveaux Adds"
}

L:SetWarningLocalization{
	WarnReanimating					= "Les adds revivent",			-- Reanimating an adherent or fanatic
	WarnTouchInsignificance			= "%s sur >%s< (%s)",		-- Touch of Insignificance on >args.destName< (args.amount)
	WarnAddsSoon					= "Nouveaux adds bientôt",
	specWarnVengefulShade		= "Vengeful Shade attacking you - Run Away"--creatureid 38222
}

L:SetOptionLocalization{
	WarnAddsSoon					= "Montre une pré-alerte avant que les adds arrivent",
	WarnTouchInsignificance			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(71204, GetSpellInfo(71204) or "unknown"),
	WarnReanimating					= "Montre une alerte quand les adds vont revenir a la vie",								-- Reanimated Adherent/Fanatic spawning
	TimerAdds						= "Montre le timer pour les nouveaux adds",
	specWarnVengefulShade		= "Show special warning when you are attacked by Vengeful Shade",--creatureid 38222
	ShieldHealthFrame			= "Show boss health with a health bar for $spell:70842",
	SetIconOnDominateMind		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71289),
	SetIconOnDeformedFanatic	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70900),
	SetIconOnEmpoweredAdherent	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70901)
}

L:SetMiscLocalization{
	YellPull						= "Quelle est cette perturbation ? Vous osez profaner cette terre sacrée ? Elle deviendra votre sépulture !",--Incomplete
	YellReanimatedFanatic			= "Lève-toi, dans l'exultation de cette nouvelle pureté !",
	ShieldPercent					= "Mana Barrier",--Translate Spell id 70842
	Fanatic1						= "Cult Fanatic",
	Fanatic2						= "Deformed Fanatic",
	Fanatic3						= "Reanimated Fanatic"
}

-----------------------------
--  Deathbringer Saurfang  --
-----------------------------
L = DBM:GetModLocalization("Deathbringer")

L:SetGeneralLocalization{
	name = "Porte-Mort Saurcroc"
}

L:SetWarningLocalization{
	warnFrenzySoon	= "Frénésie bientôt"
}

L:SetTimerLocalization{
	TimerCombatStart		= "Combat starts"
}

L:SetOptionLocalization{
	warnFrenzySoon	= "Montre une pré-alerte pour la Frénésie (à ~33%)",
	RangeFrame		= "Montre la fenêtre de proximité",
	TimerCombatStart		= "Show time for start of combat",
	BoilingBloodIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72441),
	MarkCastIcon		= "Set icon on $spell:72444 targets during cast\n(Experimental, may mark tank incorrectly)",
	RunePowerFrame			= "Show Boss Health + $spell:72371 bar"
}

L:SetMiscLocalization{
	RunePower			= "Blood Power",
	PullAlliance		= "For every Horde soldier that you killed -- for every Alliance dog that fell, the Lich King's armies grew. Even now the val'kyr work to raise your fallen as Scourge.",
	PullHorde			= "Kor'kron, move out! Champions, watch your backs. The Scourge have been..."
}

----------------------
--  Gunship Battle  --
----------------------
L = DBM:GetModLocalization("GunshipBattle")

L:SetGeneralLocalization{
	name = "La Bataille aérienne en Canonnière"
}

L:SetWarningLocalization{
	WarnBattleFury	= "%s (%d)",
	WarnAddsSoon	= "New adds soon"
}

L:SetOptionLocalization{
	WarnBattleFury	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(69638, GetSpellInfo(69638) or "Battle Fury"),
	TimerCombatStart	= "Show time for start of combat",
	WarnAddsSoon		= "Show pre-warning for adds spawning",
	TimerAdds			= "Show timer for new adds"
}

L:SetTimerLocalization{
	TimerCombatStart	= "Combat starts",
	TimerAdds			= "New adds"
}

L:SetMiscLocalization{
	PullAlliance	= "Faites chauffer les moteurs ! On a rencart avec le destin, les gars !",
	KillAlliance	= "Vous direz pas que j'vous avais pas prévenus, canailles ! Mes frères et sœurs, en avant !",
	PullHorde		= "Levez-vous, fils et filles de la Horde ! Aujourd’hui, nous affrontons le plus haï de nos ennemis ! LOK’TAR OGAR !",
	KillHorde		= "L'Alliance baisse pavillon. Sus au roi-liche !"
}

-----------------
--  Festergut  --
-----------------
L = DBM:GetModLocalization("Festergut")

L:SetGeneralLocalization{
	name = "Pulentraille"
}

L:SetWarningLocalization{
	InhaledBlight		= "Inhaled Blight >%d<",
	WarnGastricBloat	= "%s on >%s< (%s)",		-- Gastric Bloat on >args.destName< (args.amount)
}

L:SetOptionLocalization{
	InhaledBlight		= "Show warning for $spell:71912",
	RangeFrame			= "Show range frame (8 yards)",
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
	WarnOozeSpawn				= "Little Ooze spawning",
	WarnUnstableOoze			= "%s on >%s< (%s)",			-- Unstable Ooze on >args.destName< (args.amount)
	specWarnLittleOoze			= "Little Ooze attacking you - Run Away"--creatureid 36897
}

L:SetTimerLocalization{
	NextPoisonSlimePipes		= "Prochain distributeur de poison :"
}

L:SetOptionLocalization{
	NextPoisonSlimePipes		= "Montre le timer pour le prochain distributeur de poison",
	SpecWarnMutatedInfection 	= "Montre une alerte spéciale quand vous êtes affecté par Infection mutée",
	InfectionIcon				= "Met des icones sur la cible de l'Infection mutée",
	WarnOozeSpawn				= "Montre une alerte pour l'arrivée des Little Ooze",
	specWarnLittleOoze			= "Show special warning when you are attacked by Little Ooze",--creatureid 36897
	WarnUnstableOoze			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(69558, GetSpellInfo(69558) or "unknown")
}

L:SetMiscLocalization{
	YellSlimePipes1				= "Grande nouvelle, mes amis ! J'ai réparé le distributeur de poison !",	-- Professor Putricide
	YellSlimePipes2	= "Great news, everyone! The slime is flowing again!"	-- Professor Putricide
}

---------------------------
--  Professor Putricide  --
---------------------------
L = DBM:GetModLocalization("Putricide")

L:SetGeneralLocalization{
	name = "Professeur Putricide"
}

L:SetWarningLocalization{
	WarnPhase2Soon				= "Phase 2 soon",
	WarnPhase3Soon				= "Phase 3 soon",
	WarnMutatedPlague			= "%s on >%s< (%s)",	-- Mutated Plague on >args.destName< (args.amount)
	specWarnMalleableGoo		= "Malleable Goo on you - Move away",
	specWarnMalleableGooNear	= "Malleable Goo near you - Watch out",
	specWarnUnboundPlague		= "Drop off the Unbound Plague",
	specWarnNextPlageSelf		= "Unbound Plage to you next, get prepared!"
}

L:SetOptionLocalization{
	WarnPhase2Soon				= "Show pre-warning for Phase 2 (at ~83%)",
	WarnPhase3Soon				= "Show pre-warning for Phase 3 (at ~38%)",
	specWarnMalleableGoo		= "Show special warning for Malleable Goo on you\n(Only works if you are first target)",
	specWarnMalleableGooNear	= "Show special warning for Malleable Goo near you\n(Only works if you are near first target)",
	WarnMutatedPlague			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(72451, GetSpellInfo(72451) or "unknown"),
	OozeAdhesiveIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70447),
	GaseousBloatIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70672),
	UnboundPlagueIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72856),
	MalleableGooIcon			= "Set icon on first $spell:72295 target",
	NextUnboundPlagueTargetIcon	= "Set icon on next $spell:72856 target",
	YellOnMalleableGoo			= "Yell on $spell:72295",	
	specWarnUnboundPlague		= "Show special warning for $spell:72856 transfer",
	specWarnNextPlageSelf		= "Show special warning when you are the next $spell:72856 target",
}

L:SetMiscLocalization{
	YellPull		= "Good news, everyone! I think I've perfected a plague that will destroy all life on Azeroth!",
	YellMalleable	= "Malleable Goo on me!"
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
	specWarnVortex			= "Shock Vortex on you - Move away",
	specWarnVortexNear		= "Shock Vortex near you - Watch out"
}

L:SetTimerLocalization{
	TimerTargetSwitch		= "Possible changement de cible"
}

L:SetOptionLocalization{
	WarnTargetSwitch		= "Montre l'alerte pour le changement de cible",								-- Warn when another Prince needs to be damaged
	WarnTargetSwitchSoon	= "Montre une pré-alerte pour le changement de cible",							-- Every ~31 secs, you have to dps a different Prince
	TimerTargetSwitch		= "Montre un timer pour le changement de cible",
	specWarnVortex			= "Show special warning for $spell:72037 on you",
	specWarnVortexNear		= "Show special warning for $spell:72037 near you",
	EmpoweredFlameIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72040),
	ActivePrinceIcon		= "Set icon on the empowered Prince (skull)"
}

L:SetMiscLocalization{
	Keleseth				= "Prince Keleseth",
	Taldaram				= "Prince Taldaram",
	Valanar					= "Prince Valanar",
	EmpoweredFlames			= "Empowered Flames speed toward (%S+)!"
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
	warnCorrosion	= "%s on >%s< (%s)",		-- Corrosion on >args.destName< (args.amount)
	warnPortalOpen	= "Portals open"
}

L:SetTimerLocalization{
	timerPortalsOpen	= "Portals open"
}

L:SetOptionLocalization{
	SetIconOnBlazingSkeleton	= "Set icon on Blazing Skeleton (skull)",
	warnPortalOpen				= "Show warning when Nightmare Portals are opened up",
	timerPortalsOpen			= "Show timer when Nightmare Portals are opened up",
	warnCorrosion				= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(70751, GetSpellInfo(70751) or "unknown")
}

L:SetMiscLocalization{
	YellPull		= "Intruders have breached the inner sanctum. Hasten the destruction of the green dragon! Leave only bones and sinew for the reanimation!",
	YellKill		= "I AM RENEWED! Ysera grant me the favor to lay these foul creatures to rest!",
	YellPortals		= "I have opened a portal into the Dream. Your salvation lies within, heroes...",
	YellPhase2		= "My strength is returning. Press on, heroes!"--Need to confirm this is when adds spawn faster (phase 2) before used in mod
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
	achievementMystic		= "Time to clear Mystic stacks"
}

L:SetWarningLocalization{
	WarnAirphase			= "Phase dans les airs",
	WarnGroundphaseSoon		= "Sindragosa atterie bientôt",
	warnPhase2soon			= "Phase 2 bientôt",
	warnInstability			= "Instabiliter >%d<",
	warnChilledtotheBone	= "Transi jusqu'aux os >%d<",
	warnMysticBuffet		= "Rafale mystique >%d<"
}

L:SetOptionLocalization{
	WarnAirphase			= "Annonce la phase dans les airs",
	WarnGroundphaseSoon		= "Montre une pré-alerte pour la phase au sol",
	TimerNextAirphase		= "Montre un timer pour la prochaine phase dans les airs",
	TimerNextGroundphase	= "Montre un timer pour la prochaine phase au sol",
	warnPhase2soon			= "Montre une alerte pour la phase 2 (at ~38%)",
	warnInstability			= "Montre une alerte pour les stacks de $spell:69766",
	warnChilledtotheBone	= "Montre une alerte pour les stacks de $spell:70106",
	warnMysticBuffet		= "Montre une alerte pour les stacks de $spell:70128",
	AnnounceFrostBeaconIcons= "Annonce les icones pour les cibles de $spell:70126 dans le chat de raid (requires announce to be enabled and leader/promoted status)",
	SetIconOnFrostBeacon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70126),
	SetIconOnUnchainedMagic	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69762),
	ClearIconsOnAirphase	= "Clear all icons before air phase",
	RangeFrame				= "Show range frame (10 normal, 20 heroic)\n(will only show raid icon marked players)"
}

L:SetMiscLocalization{
	YellAirphase	= "Your incursion ends here! None shall survive!",
	YellPhase2		= "Now, feel my master's limitless power and despair!",
	BeaconIconSet	= "Frost Beacon icon {rt%d} set on %s",
	YellPull		= "You are fools to have come to this place. The icy winds of Northrend will consume your souls!"--Not currently in use.
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
	specWarnDefileCast			= "Profanation sur VOUS - BOUGEZ",
	specWarnDefileNear			= "Profanation à coter de VOUS - Regardez Autour",
	specWarnTrapNear			= "Piège d'ombre à coter de VOUS - Regardez Autour",
	warnNecroticPlagueJump		= "La Peste nécrotique a sauter sur >%s<",
	WarningValkyrSpawned 		= "Val'kyr(s) spawn (%d)"
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
	warnNecroticPlagueJump		= "Annonce sur qui saute la $spell:73912",
	TimerNecroticPlagueCleanse	= "Montre le timer pour dispell la Peste nécrotique avant le premier tic",
	PhaseTransition				= "Montre le timer pour la phase de transition",
	WarnPhase2Soon				= "Montre une alerte avant la transition de la phase 2 (at ~73%)",
	WarningValkyrSpawned		= "Montre une alerte pour l'arrivée des Val'kyr(s)",
	WarnPhase3Soon				= "Montre une alerte avant la transition de la phase 3 (at ~43%)",
	specWarnDefileCast			= "Montre une alerte spéciale pour la $spell:72762 sur vous",
	specWarnDefileNear			= "Montre une alerte spéciale pour la $spell:72762 à coter de vous",
	specWarnTrapNear			= "Montre une alerte spéciale pour le $spell:73539 à coter de vous",
	YellOnDefile				= "Crie pour $spell:72762",
	YellOnTrap					= "Crie pour $spell:73539",
	DefileIcon					= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72762),
	NecroticPlagueIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(73912),
	RagingSpiritIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69200),
	TrapIcon					= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(73539),
	ValkyrIcon					= "Met des icones sur les Valkyrs",
	DefileArrow					= "Montre les flèches de DBM quand $spell:72762 est à coter de vous",
	TrapArrow					= "Montre les flèches de DBM quand $spell:73539 est à coter de vous"
}

L:SetMiscLocalization{
	LKPull			= "Voici donc qu’arrive la fameuse justice de la Lumière ?",
	YellDefile		= "Profanation sur MOI !",
	YellTrap		= "Piège d'ombre sur MOI !",
	YellKill		= "No questions remain unanswered. No doubts linger. You ARE Azeroth's greatest champions. You overcame every challenge I laid before you. My mightiest servants have fallen before your relentless onslaught... your unbridled fury...",
	LKRoleplay		= "Is it truly righteousness that drives you? I wonder...",
	PlagueWhisper	= "Vous êtes infecter par"
}

