if GetLocale() ~= "frFR" then return end
local L

-- Initial release by Sasmira: 12/26/2010
-- Last update: 01/22/2011 (by Sasmira) 

--------------------------
--  Halfus Wyrmbreaker  --
--------------------------
L= DBM:GetModLocalization(156)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
})

---------------------------
--  Valiona & Theralion  --
---------------------------
L= DBM:GetModLocalization(157)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	TwilightBlastArrow		= "Afficher la flèche DBM lorsque $spell:92898 est près de vous",
	RangeFrame				= "Afficher la fenêtre de portée (10)",
	BlackoutIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92878),
	EngulfingIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(86622)
})

L:SetMiscLocalization({
	Trigger1				= "Theralion, je m'occupe du vestibule. Couvre leur fuite !"--Change this to what deep breath emote is.
})

----------------------------------
--  Twilight Ascendant Council  --
----------------------------------
L= DBM:GetModLocalization(158)

L:SetWarningLocalization({
	specWarnBossLow	= ">%s< en dessous de 30%",
	SpecWarnGrounded	= "Obtenir le buff Liaison à la masse",
	SpecWarnSearingWinds	= "Obtenir le buff Vents tournoyants"
})

L:SetTimerLocalization({
	timerTransition		= "Changement de phase"
})

L:SetMiscLocalization({
	Quake		= "Le sol sous vos pieds gronde avec menace...", -- A verifier ...
	Thundershock	= "L'air qui vous entoure crépite d'énergie...", -- A verifier ...
	Switch		= "Nous allons nous occuper d'eux !", -- A verifier ...
	Phase3		= "CONTEMPLEZ VOTRE DESTIN !", -- A verifier ...
	Kill			= "Impossible...."
})

L:SetOptionLocalization({
	specWarnBossLow	= "Alerte spéciale lorsque les Boss sont en dessous de 30% de PV",
	SpecWarnGrounded	= "Alerte spéciale lorsque vous manquez l'amélioration $spell:83581 \n(~10sec avant le lancement du sort)",
	SpecWarnSearingWinds	= "Alerte spéciale lorsque vous manquez l'amélioration  $spell:83500 \n(~10sec avant le lancement du sort)",
	timerTransition		= "Affiche le temps pour: Changement de phase",
	RangeFrame		= "Affiche automatiquement la fenêtre de portée lorsque c'est nécessaire",
	HeartIceIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82665),
	BurningBloodIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82660),
	LightningRodIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(83099),
	GravityCrushIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(84948),
	FrostBeaconIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92307),
	StaticOverloadIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92067),
	GravityCoreIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92075)
})

----------------
--  Cho'gall  --
----------------
L= DBM:GetModLocalization(167)

L:SetWarningLocalization({
--	WarnPhase2Soon	= "Phase 2 imminente"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
--	WarnPhase2Soon		= "Afficher la pré-alerte pour la Phase 2",
	CorruptingCrashArrow	= "Afficher la flèche DBM lorsque $spell:93178 est près de vous",
	InfoFrame			= "Afficher la fenêtre d'info pour le sort $journal:3165",
	RangeFrame		= "Afficher la fenêtre de portée (5) pour $spell:82235",
	SetIconOnWorship	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(91317),
	SetIconOnCreature	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82414)
})

----------------
--  Sinestra  --
----------------
L= DBM:GetModLocalization(168)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
})

-------------------------------------
--  The Bastion of Twilight Trash  --
-------------------------------------
L = DBM:GetModLocalization("BoTrash")

L:SetGeneralLocalization({
	name =	"The Bastion of Twilight Trash"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})