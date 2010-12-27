if GetLocale() ~= "frFR" then return end
local L

-- Initial release by Sasmira: 12/26/2010
-- Last update: 12/28/2010 (by Sasmira) 


--------------
--  Magmaw  --
--------------
L = DBM:GetModLocalization("Magmaw")

L:SetGeneralLocalization({
	name = "Magmagueule"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
})

-------------------------------
--  Dark Iron Golem Council  --
-------------------------------
L = DBM:GetModLocalization("DarkIronGolemCouncil")

L:SetGeneralLocalization({
	name = "Système de défense Omnitron"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
	Magmatron	= "Magmatron",
	Electron	= "Electron",
	Toxitron	= "Toxitron",
	Arcanotron	= "Arcanotron",
	SayBomb	= "Bombe de poison sur moi !"
})

L:SetOptionLocalization({
	SayBombTarget	= "Dire en SAY que vous êtes la cible du sort $spell:80157",
	AcquiringTargetIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79501),
	ConductorIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79888),
	BombTargetIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(80094),
	ShadowInfusionIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92048)
})

----------------
--  Maloriak  --
----------------
L = DBM:GetModLocalization("Maloriak")

L:SetGeneralLocalization({
	name = "Maloriak"
})

L:SetWarningLocalization({
	WarnPhase		= " Phase %s",
	WarnRemainingAdds	= "%d aberrations restants"
})

L:SetTimerLocalization({
	TimerPhase		= "Phase Suivante"
})

L:SetMiscLocalization({
	YellRed		= "red|r vial into the cauldron!",--Partial matchs, no need for full strings unless you really want em, mod checks for both.
	YellBlue		= "blue|r vial into the cauldron!",
	YellGreen		= "green|r vial into the cauldron!",
	YellDark		= "dark|r vial into the cauldron!",--guesswork, this isn't confirmed but if it's consistent with other strings is probably right.
	Red			= "Rouge",
	Blue			= "Bleu",
	Green		= "Vert",
	Dark			= "Sombre"
})

L:SetOptionLocalization({
	WarnPhase		= "Alerte de la phase arrivant",
	WarnRemainingAdds	= "Alerte sur le nombre d'aberrations restantes",
	TimerPhase		= "Affiche le timer de la Phase Suivante",
	RangeFrame		= "Affiche la fenêtre de portée (6) durant la Phase Bleue",
	FlashFreezeIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92979),
	BitingChillIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77760),
	ConsumingFlamesIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77786)
})

-----------------
--  Chimaeron  --
-----------------
L = DBM:GetModLocalization("Chimaeron")

L:SetGeneralLocalization({
	name = "Chimaeron"
})

L:SetWarningLocalization({
	WarnPhase2Soon	= "Phase 2 imminente",
	WarnBreak	= "%s on >%s< (%d)"
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
	WarnPhase2Soon	= "Afficher la pré-alerte pour la Phase 2",
	WarnBreak	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(82881, GetSpellInfo(82881) or "inconnu")
})

-----------------
--  Atramedes  --
-----------------
L = DBM:GetModLocalization("Atramedes")

L:SetGeneralLocalization({
	name = "Atramédès"
})

L:SetWarningLocalization({
	WarnAirphase		= "Phase d'Air",
	WarnGroundphase	= "Phase de Terre",
	WarnShieldsLeft		= "Ancien bouclier nain - %d restant"
})

L:SetTimerLocalization({
	TimerAirphase		= "Phase d'Air",
	TimerGroundphase	= "Phase de Terre"
})

L:SetMiscLocalization({
	AncientDwarvenShield	= "Ancien bouclier nain",
	Airphase			= "Yes, run! With every step your heart quickens. The beating, loud and thunderous... Almost deafening. You cannot escape!"
})

L:SetOptionLocalization({
	WarnAirphase		= "Affiche l'alerte lorsque Atramédès décolle",
	WarnGroundphase	= "Affiche l'alerte lorsque Atramédès est à terre",
	WarnShieldsLeft		= "Affiche l'alerte lorsqu'un Ancien bouclier nain est utilisé",
	TimerAirphase		= "Affiche le timer pour la prochaine Phase d'Air",
	TimerGroundphase	= "Affiche le timer pour la prochaine Phase de Terre",
	TrackingIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(78092)
})

----------------
--  Nefarian  --
----------------
L = DBM:GetModLocalization("Nefarian-BD")	-- No conflict with BWL version :)

L:SetGeneralLocalization({
	name = "Nefarian"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
	YellPhase2			= "Curse you, mortals! Such a callous disregard for one's possessions must be met with extreme force!",
	ChromaticPrototype	= "Prototype chromatique"
})

L:SetOptionLocalization({
})
