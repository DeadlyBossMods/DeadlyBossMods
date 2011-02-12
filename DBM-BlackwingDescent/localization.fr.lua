if GetLocale() ~= "frFR" then return end
local L

-- Initial release by Sasmira: 12/26/2010
-- Last update: 01/25/2011 (by Sasmira) 


--------------
--  Magmaw  --
--------------
L = DBM:GetModLocalization("Magmaw")

L:SetGeneralLocalization({
	name = "Magmagueule"
})

L:SetWarningLocalization({
	SpecWarnInferno	= "Blazing Bone Construct Imminent (~4s)", -- don't find in french Blazing bone contruct on wowhead :/
	WarnPhase2Soon	= "Phase 2 imminente"
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
	Slump			= "%s s'effondre vers l'avant et expose ses pinces !",
	HeadExposed		= "%s vient de s'empaler sur la pointe et expose sa tête !",
	YellPhase2			= "Inconceivable! You may actually defeat my lava worm! Perhaps I can help... tip the scales." -- need translation :(
})

L:SetOptionLocalization({
	SpecWarnInferno		= "Affiche une pré-alerte spéciale sur $spell:92190 (~4s)",
	WarnPhase2Soon		= "Affiche une pré-alerte pour la Phase 2",
	RangeFrame		= "Affiche la fenêtre de portée en Phase 2 (5)"
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
	timerArcaneBlowbackCast	= "Retour arcanique",
	timerShadowConductorCast	= "Conducteur d'ombre"
})

L:SetOptionLocalization({
	timerShadowConductorCast	= "Affiche le timer : $spell:92053",
	timerArcaneBlowbackCast	= "Affiche le timer : $spell:91879",
	AcquiringTargetIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79501),
	ConductorIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79888),
	BombTargetIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(80094),
	ShadowConductorIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92053)
})

L:SetMiscLocalization({
	Magmatron		= "Magmatron",
	Electron		= "Electron",
	Toxitron		= "Toxitron",
	Arcanotron		= "Arcanotron"
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
	WarnRemainingAdds	= "%d Aberrations restantes"
})

L:SetTimerLocalization({
	TimerPhase		= "Prochaine Phase"
})

L:SetMiscLocalization({
	YellRed		= "Flacon rouge|r dans le chaudron !",-- à vérifier
	YellBlue		= "Flacon bleu|r dans le chaudron !",-- à vérifier
	YellGreen		= "Flacon vert|r dans le chaudron !",-- à vérifier
	YellDark		= "Flacon sombre|r dans le chaudron !",-- à vérifier
	Red			= "Rouge",
	Blue			= "Bleue",
	Green		= "Verte",
	Dark			= "Sombre"
})

L:SetOptionLocalization({
	WarnPhase			= "Affiche l'alerte d'une nouvelle phase",
	WarnRemainingAdds	= "Alerte sur le nombre d'aberrations restantes",
	TimerPhase			= "Affiche le timer de la prochaine phase",
	RangeFrame		= "Affiche la fenêtre de portée (6) durant la Phase Bleue",
	FlashFreezeIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92979),
	BitingChillIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77760),
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
	WarnBreak		= "%s sur >%s< (%d)"
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
	HealthInfo		= "Info Santé"
})

L:SetOptionLocalization({
	WarnPhase2Soon	= "Affiche la pré-alerte de la Phase 2",
	RangeFrame	= "Affiche la fenêtre de portée (6)",
	WarnBreak		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(82881, GetSpellInfo(82881) or "inconnu"),
	SetIconOnSlime	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82935),
	InfoFrame		= "Affiche une fenêtre d'info sur la santé (<10k pv)"
})

-----------------
--  Atramedes  --
-----------------
L = DBM:GetModLocalization("Atramedes")

L:SetGeneralLocalization({
	name = "Atramédès"
})

L:SetWarningLocalization({
	WarnAirphase		= "Phase en l'air",
	WarnGroundphase	= "Phase au sol",
	WarnShieldsLeft		= "Ancien bouclier nain - %d restant"
})

L:SetTimerLocalization({
	TimerAirphase		= "Phase en l'air",
	TimerGroundphase	= "Phase au sol"
})

L:SetMiscLocalization({
	AncientDwarvenShield	= "Ancien bouclier nain",
	Soundlevel			= "Niveau Sonore",
	Airphase			= "Oui, fuyez ! Chaque foulée accélère votre cœur. Les battements résonnent comme le tonnerre... Assourdissant. Vous ne vous échapperez pas !" -- à vérifier
})

L:SetOptionLocalization({
	WarnAirphase		= "Affiche l'alerte lorsque Atramédès décolle",
	WarnGroundphase	= "Affiche l'alerte lorsque Atramédès est à terre",
	WarnShieldsLeft		= "Affiche l'alerte lorsqu'un Ancien bouclier nain est utilisé",
	TimerAirphase		= "Affiche le timer pour la prochaine Phase en l'air",
	TimerGroundphase	= "Affiche le timer pour la prochaine Phase au sol",
	InfoFrame			= "Affiche une fenêtre d'info pour le niveau sonore",
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
	OnyTailSwipe		= "(Onyxia) Fouette-queue",
	NefTailSwipe		= "(Nefarian) Fouette-queue",
	OnyBreath			= "(Onyxia) Souffle",
	NefBreath			= "(Nefarian) Souffle"
})

L:SetTimerLocalization({
	OnySwipeTimer		= "(Ony) CD Fouette-queue",
	NefSwipeTimer		= "(Nef) CD Fouette-queue",
	OnyBreathTimer		= "(Ony) CD Souffle",
	NefBreathTimer		= "(Nef) CD Souffle"
})

L:SetOptionLocalization({
	OnyTailSwipe		= "Alerte pour $spell:77827 d'Onyxia",
	NefTailSwipe		= "Alerte pour $spell:77827 de Nefarian",
	OnyBreath			= "Alerte pour $spell:94124 d'Onyxia",
	NefBreath			= "Alerte pour $spell:94124 de Nefarian",
	OnySwipeTimer		= "Affiche le CoolDown $spell:77827 d'Onyxia",
	NefSwipeTimer		= "Affiche le CoolDown $spell:77827 de Nefarian",
	OnyBreathTimer		= "Affiche le CoolDown $spell:94124 d'Onyxia",
	NefBreathTimer		= "Affiche le CoolDown $spell:94124 de Nefarian",
	YellOnCinder		= "Crier sur $spell:79339",
	RangeFrame		= "Affiche la fenêtre de portée (10) lorsque vous avez $spell:79339",
	SetIconOnCinder		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79339)
})

L:SetMiscLocalization({
	NefAoe			= "L'air craque sous l'électricité !", -- à vérifier 
	YellPhase2			= "Soyez maudits, mortels ! Un tel mépris pour les possessions d'autrui doit être traité avec une extrême fermeté !", -- à vérifier
	ShadowblazeCast		= "Que la chair se transforme en cendres !", -- à vérifier
	ChromaticPrototype	= "Prototype chromatique"
})