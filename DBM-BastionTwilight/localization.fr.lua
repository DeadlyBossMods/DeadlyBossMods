if GetLocale() ~= "frFR" then return end
local L

-- Initial release by Sasmira: 12/26/2010
-- Last update: 01/22/2011 (by Sasmira) 


---------------------------
--  Valiona & Theralion  --
---------------------------
L = DBM:GetModLocalization("ValionaTheralion")

L:SetGeneralLocalization({
	name =	"Valiona & Theralion"
})

L:SetWarningLocalization({
	WarnDazzlingDestruction	= "%s (%d)",
	WarnDeepBreath			= "%s (%d)",
	WarnTwilightShift		= "%s : >%s< (%d)"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	YellOnEngulfing			= "Crier sur $spell:86622",
	YellOnTwilightMeteor	= "Crier sur $spell:88518",
	YellOnTwilightBlast		= "Crier sur $spell:92898",
	TwilightBlastArrow		= "Afficher la flèche DBM lorsque $spell:92898 est près de vous",
	RangeFrame				= "Afficher la fenêtre de portée (10)",
	BlackoutIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92878),
	EngulfingIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(86622)
})

L:SetMiscLocalization({
	Trigger1				= "Theralion, je m'occupe du vestibule. Couvre leur fuite !",--Change this to what deep breath emote is.
	YellEngulfing			= "Magie enveloppante sur moi !",
	YellMeteor				= "Météorite du Crépuscule sur moi !",
	YellTwilightBlast			= "Déflagration du Crépuscule sur moi !"
})

--------------------------
--  Halfus Wyrmbreaker  --
--------------------------
L = DBM:GetModLocalization("HalfusWyrmbreaker")

L:SetGeneralLocalization({
	name =	"Halfus Brise-wyrm"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
})

----------------------------------
--  Twilight Ascendant Council  --
----------------------------------
L = DBM:GetModLocalization("AscendantCouncil")

L:SetGeneralLocalization({
	name =	"Conseil d'ascendants"
})

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
	Ignacious		= "Ignacious",
	Feludius		= "Feludius",
	Arion			= "Arion",
	Terrastra		= "Terrastra",
	Monstrosity		= "Monstruosité en élémentium",
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
L = DBM:GetModLocalization("Chogall")

L:SetGeneralLocalization({
	name =	"Cho'gall"
})

L:SetWarningLocalization({
	WarnPhase2Soon	= "Phase 2 imminente"
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
	YellCrash		= "Déferlante corruptrice sur moi !",
	Bloodlevel		= "Corruption"
})

L:SetOptionLocalization({
	WarnPhase2Soon		= "Afficher la pré-alerte pour la Phase 2",
	YellOnCorrupting	= "Crier sur $spell:93178",
	CorruptingCrashArrow	= "Afficher la flèche DBM lorsque $spell:93178 est près de vous",
	InfoFrame			= "Afficher la fenêtre d'info pour le sort $spell:82235",
	RangeFrame		= "Afficher la fenêtre de portée (5) pour $spell:82235",
	SetIconOnWorship	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(91317),
	SetIconOnCreature		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82414)
})

----------------
--  Sinestra  --
----------------
L = DBM:GetModLocalization("Sinestra")

L:SetGeneralLocalization({
	name =	"Sinestra"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
})