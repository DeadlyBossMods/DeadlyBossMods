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
	achievementBoned		= "Temps pour libérer"
}

L:SetWarningLocalization{
	WarnImpale				= ">%s< est empalé(e)",
	SpecWarnWhirlwind		= "Tourbillon d'os - COUREZ !",
	SpecWarnColdflame		= "Flamme froide - BOUGEZ !"
}

L:SetOptionLocalization{
	WarnImpale				= "Annonce les cibles de $spell:69062",
	SpecWarnWhirlwind		= "Montre une alerte spéciale pour le $spell:69076",
	SpecWarnColdflame		= "Montre une alerte spéciale quand vous subissez des dégats provenant de $spell:70825",
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
	SpecWarnDeathDecay				= "Mort et décomposition - BOUGEZ",
	SpecWarnCurseTorpor				= "Malédiction de Torpeur sur VOUS",
	SpecWarnTouchInsignificance		= "Touch of Insignificance (3)",
	WarnAddsSoon					= "Nouveaux adds bientôt"
}

L:SetOptionLocalization{
	WarnAddsSoon					= "Montre une pré-alerte avant que les adds arrivent",
	WarnTouchInsignificance			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(71204, GetSpellInfo(71204) or "unknown"),		-- Warning isnt default (it has a count number), option is default tho (no need for translation this way)
	WarnReanimating					= "Montre une alerte quand les adds vont revenir a la vie",								-- Reanimated Adherent/Fanatic spawning
	SpecWarnTouchInsignificance		= "Montre une alerte spéciale quand vous avez 3 stack de $spell:71204",
	SpecWarnDeathDecay				= "Montre une alerte spéciale quand vous subissez des dégats provenant de $spell:72108",
	SpecWarnCurseTorpor				= "Montre une alerte spéciale quand vous êtes affecté par la $spell:71237",
	TimerAdds						= "Montre le timer pour les nouveaux adds",
	SetIconOnDominateMind			= "Met des icônes sur les cibles de $spell:71289"
}

L:SetMiscLocalization{
	YellPull						= "What is this disturbance? You dare trespass upon this hallowed ground? This shall be your final resting place!",
	YellReanimatedFanatic			= "Arise, and exult in your pure form!"
}
-----------------------------
--  Deathbringer S	aurfang  --
-----------------------------
L = DBM:GetModLocalization("Deathbringer")

L:SetGeneralLocalization{
	name = "Porte-Mort Saurcroc"
}

L:SetWarningLocalization{
	warnFrenzySoon	= "Frénésie bientôt"
}

L:SetOptionLocalization{
	warnFrenzySoon	= "Montre une pré-alerte pour la Frénésie (à ~33%)",
	RangeFrame		= "Montre la fenêtre de proximité"
}

----------------------
--  Gunship Battle  --
----------------------
L = DBM:GetModLocalization("GunshipBattle")

L:SetGeneralLocalization{
	name = "La Bataille aérienne en Canonnière"
}

L:SetWarningLocalization{
	WarnBattleFury	= "%s (%d)"
}

L:SetOptionLocalization{
	WarnBattleFury	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(69638, GetSpellInfo(69638) or "Battle Fury")
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
	SpecWarnMutatedInfection 	= "Montre une alerte spéciale quand vous êtes affecté par Infection mutée",
	InfectionIcon				= "Met des icones sur la cible de l'Infection mutée",
	WarnOozeSpawn				= "Montre une alerte pour l'arrivée des Little Ooze"
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
	TimerTargetSwitch		= "Montre un timer pour le changement de cible",
	SpecWarnResonance		= "Montre une alerte spéciale quand Dark Nucleus vous suit"	-- If it follows you, you have to move to the tank
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
	SpecWarnPactDarkfallen	= "Montre une alerte spéciale quand vous êtes affecté par Pact of the Darkfallen"
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
	SpecWarnFrostBeacon		= "Montre une alerte spéciale quand vous êtes affecté par Marque de Givre",
	WarnGroundphaseSoon		= "Montre une pré-alerte pour la phase au sol",
	TimerNextAirphase		= "Montre un timer pour la prochaine phase dans les airs",
	TimerNextGroundphase	= "Montre un timer pour la prochaine phase au sol",
	SpecWarnUnchainedMagic	= "Montre une alerte spéciale quand vous êtes affecté par Magie déchaînée"
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

