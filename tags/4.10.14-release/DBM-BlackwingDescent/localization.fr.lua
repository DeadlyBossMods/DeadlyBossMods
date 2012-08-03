if GetLocale() ~= "frFR" then return end
local L

-- Initial release by Sasmira: 12/26/2010
-- Last update: 01/25/2011 (by Sasmira) 

-------------------------------
--  Dark Iron Golem Council  --
-------------------------------
L = DBM:GetModLocalization(169)

L:SetTimerLocalization({
	timerShadowConductorCast	= "Conducteur d'ombre",
	timerArcaneBlowbackCast	= "Retour arcanique"
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
})

--------------
--  Magmaw  --
--------------
L = DBM:GetModLocalization(170)

L:SetWarningLocalization({
	SpecWarnInferno	= "Assemblage d'os flamboyant Imminent (~4s)",
})

L:SetMiscLocalization({
	Slump			= "%s s'effondre vers l'avant et expose ses pinces !",
	HeadExposed		= "%s vient de s'empaler sur la pointe et expose sa tête !",
	YellPhase2			= "Inconcevable ! Vous pourriez vraiment vaincre mon ver de lave !"
})

L:SetOptionLocalization({
	SpecWarnInferno		= "Affiche une pré-alerte spéciale sur $spell:92190 (~4s)",
	RangeFrame		= "Affiche la fenêtre de portée en Phase 2 (5)"
})

-----------------
--  Atramedes  --
-----------------
L = DBM:GetModLocalization(171)

L:SetOptionLocalization({
	InfoFrame			= "Affiche une fenêtre d'info pour le niveau sonore",
	TrackingIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(78092)
})

L:SetMiscLocalization({
	Airphase			= "Oui, fuyez ! Chaque foulée accélère votre cœur. Les battements résonnent comme le tonnerre... Assourdissant. Vous ne vous échapperez pas !" -- à vérifier
})

-----------------
--  Chimaeron  --
-----------------
L = DBM:GetModLocalization(172)

L:SetOptionLocalization({
	RangeFrame	= "Affiche la fenêtre de portée (6)",
	SetIconOnSlime	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82935),
	InfoFrame		= "Affiche une fenêtre d'info sur la santé (<10k pv)"
})

L:SetMiscLocalization({
	HealthInfo		= "Info Santé"
})

----------------
--  Maloriak  --
----------------
L = DBM:GetModLocalization(173)

L:SetWarningLocalization({
	WarnPhase		= " Phase %s"
})

L:SetTimerLocalization({
	TimerPhase		= "Prochaine Phase"
})

L:SetOptionLocalization({
	WarnPhase			= "Affiche l'alerte d'une nouvelle phase",
	TimerPhase			= "Affiche le timer de la prochaine phase",
	RangeFrame		= "Affiche la fenêtre de portée (6) durant la Phase Bleue",
	FlashFreezeIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92979),
	BitingChillIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77760),
	ConsumingFlamesIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77786)
})

L:SetMiscLocalization({
	YellRed		= "Flacon rouge|r dans le chaudron !",-- à vérifier
	YellBlue		= "Flacon bleu|r dans le chaudron !",-- à vérifier
	YellGreen		= "Flacon vert|r dans le chaudron !",-- à vérifier
	YellDark		= "Flacon sombre|r dans le chaudron !"-- à vérifier
})

----------------
--  Nefarian  --
----------------
L = DBM:GetModLocalization(174)

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
	RangeFrame		= "Affiche la fenêtre de portée (10) lorsque vous avez $spell:79339",
	SetIconOnCinder		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79339)
})

L:SetMiscLocalization({
	NefAoe			= "L'air craque sous l'électricité !", -- à vérifier 
	YellPhase2			= "Soyez maudits, mortels ! Un tel mépris pour les possessions d'autrui doit être traité avec une extrême fermeté !", -- à vérifier
	YellPhase3			= "J'ai tout fait pour être un hôte accomodant, mais vous ne daignez pas mourir ! Oublions les bonnes manières et passons aux choses sérieuses... VOUS TUER TOUS !",
	ShadowBlazeExact		= "Shadowblaze in %ds",
	ShadowBlazeEstimate		= "Shadowblaze soon (~5s)"
})

-------------------------------
--  Blackwing Descent Trash  --
-------------------------------
L = DBM:GetModLocalization("BWDTrash")

L:SetGeneralLocalization({
	name = "Blackwing Descent Trash"
})
