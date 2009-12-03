if GetLocale() ~= "frFR" then return end

local L

----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization{
	name = "Seigneur Gargamoelle"
}

L:SetTimerLocalization{
	achievementBoned		= "Time to free"
}

L:SetWarningLocalization{
	WarnImpale				= ">%s< est Empaler",
	SpecWarnWhirlwind		= "Tourbillon d'os - COUREZ !",
	SpecWarnColdflame		= "Flamme froide - BOUGEZ !"
}

L:SetOptionLocalization{
	WarnImpale				= "Annonce les cibles d'Empaler",
	SpecWarnWhirlwind		= "Montre une alerte spéciale pour le Tourbillon d'os",
	SpecWarnColdflame		= "Montre une alerte spéciale quand vous subissez des dégats provenant des Flamme froide",
	PlaySoundOnWhirlwind	= "Joue un sons pour le Tourbillon d'os",
	achievementBoned		= "Montre le timer pour le haut-Fait Boned",
	SetIconOnImpale			= "Met une icone sur la cible d'Empaler"
}

-------------------------
--  Lady Deathwhisper  --
-------------------------
L = DBM:GetModLocalization("Deathwhisper")

L:SetGeneralLocalization{
	name = "Dame Murmemort"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
	WarnReanimating					= "Les adds revivent",			-- Reanimating an adherent or fanatic
	WarnTouchInsignificance			= "%s sur >%s< (%s)",		-- Touch of Insignificance on >args.destName< (args.amount)
	SpecWarnDeathDecay				= "Mort et décomposition - BOUGEZ",
	SpecWarnCurseTorpor				= "Malédiction de Torpeur sur VOUS",
	SpecWarnTouchInsignificance		= "Touch of Insignificance (3)",
	WarnAddsSoon					= "Nouveaux add bientôt"
}

L:SetOptionLocalization{
	WarnAddsSoon					= "Montre une pré-alerte avant que les adds arrivent",
	WarnTouchInsignificance			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(71204, GetSpellInfo(71204) or "unknown"),		-- Warning isnt default (it has a count number), option is default tho (no need for translation this way)
	WarnReanimating					= "Montre une alerte quand les add vont revenir a la vie",								-- Reanimated Adherent/Fanatic spawning
	SpecWarnTouchInsignificance		= "Montre une alerte spéciale quand vous avez 3 stack de Touch of Insignificance",
	SpecWarnDeathDecay				= "Montre une alerte spéciale quand vous subissez des dégats provenant de Mort et décomposition",
	SpecWarnCurseTorpor				= "Montre une alerte spéciale quand vous êtes affecter par la Malédiction de Torpeur",
	SetIconOnDominateMind			= "Met une icone sur Domination mentale"
}

L:SetMiscLocalization{
	YellPull						= "What is this disturbance? You dare trespass upon this hallowed ground? This shall be your final resting place!",
	YellReanimatedFanatic			= "Arise, and exult in your pure form!"
}
------------------------
--  The Deathbringer  --
------------------------
L = DBM:GetModLocalization("Deathbringer")

L:SetGeneralLocalization{
	name = "Porte-Mort Saurcroc"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}

----------------------
--  Gunship Battle  --
----------------------
L = DBM:GetModLocalization("GunshipBattle")

L:SetGeneralLocalization{
	name = "La Bataille aérienne en Canonnière"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}

-----------------
--  Festergut  --
-----------------
L = DBM:GetModLocalization("Festergut")

L:SetGeneralLocalization{
	name = "Pulentraille"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}

---------------
--  Rotface  --
---------------
L = DBM:GetModLocalization("Rotface")

L:SetGeneralLocalization{
	name = "Trognepus"
}

L:SetWarningLocalization{
	SpecWarnStickyOoze			= "Limon collant - BOUGEZ PLUS LOIN",
	SpecWarnRadiatingOoze		= "Limon rayonnant",
	SpecWarnMutatedInfection 	= "Infection mutée sur vous"
}

L:SetTimerLocalization{
	NextPoisonSlimePipes		= "Prochain distributeur de poison :"
}

L:SetOptionLocalization{
	SpecWarnStickyOoze			= "Montre une alerte spéciale pour les Limon collant",
	SpecWarnRadiatingOoze		= "Montre une alerte spéciale pour les Limon rayonnant",
	NextPoisonSlimePipes		= "Montre le timer pour le prochain distributeur de poison",
	SpecWarnMutatedInfection 	= "Montre une alerte spéciale quand vous êtes affecter par Infection mutée",
	InfectionIcon				= "Met des icones sur la cible de l'Infection mutée",
	WarnOozeSpawn				= "Montre une alerte pour l'arriver des Little Ooze"
}

L:SetMiscLocalization{
	YellSlimePipes				= "Grande nouvelle, mes amis ! J'ai réparé le distributeur de poison !"	-- Professor Putricide
}

---------------------------
--  Professor Putricide  --
---------------------------
L = DBM:GetModLocalization("Putricide")

L:SetGeneralLocalization{
	name = "Professeur Putricide"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}

L:SetMiscLocalization{
	YellPull	= "Good news, everyone! I think I've perfected a plague that will destroy all life on Azeroth!"
}

----------------------------
--  Blood Prince Council  --
----------------------------
L = DBM:GetModLocalization("BPCouncil")

L:SetGeneralLocalization{
	name = "Princes de Sang"
}

L:SetWarningLocalization{
	WarnTargetSwitch		= "Changement de cible sur : %s",	-- Ugh, no nice spellname/id to use for general localization :(
	WarnTargetSwitchSoon	= "Changement de cible bientôt",	-- Spellname = Invocation of Blood   or   Spellname = Invocation of Blood (X) Move  (server side script where X indicates the first letter of the Prince name
	SpecWarnResonance		= "Résonance d'Ombre - BOUGEZ"
}

L:SetTimerLocalization{
	TimerTargetSwitch		= "Possible changement de cible"
}

L:SetOptionLocalization{
	WarnTargetSwitch		= "Montre l'alerte pour le changement de cible",								-- Warn when another Prince needs to be damaged
	WarnTargetSwitchSoon	= "Montre une pré-alerte pour le changement de cible",							-- Every ~31 secs, you have to dps a different Prince
	TimerTargetSwitch		= "Show timer for target switch cooldown",
	SpecWarnResonance		= "Montre une alerte spéciale quand Dark Nucleus vous suis"	-- If it follows you, you have to move to the tank
}

L:SetMiscLocalization{
	Keleseth				= "Prince Keleseth",
	Taldaram				= "Prince Taldaram",
	Valanar					= "Prince Valanar"
}

-----------------------
--  Queen Lana'thel  --
-----------------------
L = DBM:GetModLocalization("Lanathel")

L:SetGeneralLocalization{
	name = "Reine de sang Lana'thel"
}

L:SetWarningLocalization{
	SpecWarnPactDarkfallen	= "Pact of the Darkfallen sur vous"
}

L:SetOptionLocalization{
	SpecWarnPactDarkfallen	= "Montre une alerte spéciale quand vous êtes affecter par Pact of the Darkfallen"
}

-----------------------------
--  Valithria Dreamwalker  --
-----------------------------
L = DBM:GetModLocalization("Valithria")

L:SetGeneralLocalization{
	name = "Valithria Marcherêve"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
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
	TimerNextGroundphase	= "Prochaine phase sur le sol"
}

L:SetWarningLocalization{
	WarnAirphase			= "Phase dans les airs",
	SpecWarnBlisteringCold	= "Froid Caustique - COUREZ PLUS LOIN",
	SpecWarnFrostBeacon		= "Marque de Givre sur vous",
	WarnGroundphaseSoon		= "Sindragosa atterie bientôt",
	SpecWarnUnchainedMagic	= "Magie déchaînée sur vous"
}

L:SetOptionLocalization{
	WarnAirphase			= "Annonce la phase dans les airs",
	SpecWarnBlisteringCold	= "Montre une alerte spéciale pour Froid Caustique",
	SpecWarnFrostBeacon		= "Montre une alerte spéciale quand vous êtes affecter par Marque de Givre",
	WarnGroundphaseSoon		= "Montre une pré-alerte pour la phase au sol",
	TimerNextAirphase		= "Montre un timer pour la prochaine phase dans les airs",
	TimerNextGroundphase	= "Montre une timer pour la prochaine phase au sol",
	SpecWarnUnchainedMagic	= "Montre une alerte spéciale quand vous êtes affecter par Magie déchaînée"
}

L:SetMiscLocalization{
	YellAirphase			= "Votre incursion s'arrête ici",
	YellPull				= "You are fools to have come to this place. The icy winds of Northrend will consume your souls!"
}

---------------------
--  The Lich King  --
---------------------
L = DBM:GetModLocalization("LichKing")

L:SetGeneralLocalization{
	name = "Le Roi Liche"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}

