if GetLocale() ~= "frFR" then return end
local L

-- Initial release by Sasmira: 12/26/2010
-- Last update: 12/27/2010 (by Sasmira) 


---------------------------
--  Valiona & Theralion  --
---------------------------
L = DBM:GetModLocalization("ValionaTheralion")

L:SetGeneralLocalization({
	name =	"Valiona & Theralion"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
	BlackoutIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92878),
	EngulfingIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(86622)
})

L:SetOptionLocalization({
	YellOnEngulfing			= "Pousse un cri sur $spell:86622",
	RangeFrame		= "Afficher la fenêtre de portée (10)"
})

L:SetMiscLocalization{
	Trigger1				= "Theralion, je vais engloutir le couloir. Couvre leur fuite!",--Terrible phase trigger, even transcriptor couldn't grab anything more usefull than this :(
	YellEngulfing				= "Magie enveloppante sur moi!"
}

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
	SpecWarnGrounded	= "Obtenir le buff Liaison à la masse",
	SpecWarnSearingWinds	= "Obtenir le buff Vents tournoyants" -- Searing Winds en anglais, je n'ai pas trouv� la correspondance actuellement
})

L:SetTimerLocalization({
	timerTransition		= "Phase de Transition"
})

L:SetMiscLocalization({
	Quake		= "The ground beneath you rumbles ominously....",
	Thundershock	= "The surrounding air crackles with energy....",
	Switch		= "Enough of this foolishness!",--"We will handle them!" comes 3 seconds after this one
	Phase3		= "An impressive display...",--"BEHOLD YOUR DOOM!" is about 13 seconds after
	Ignacious		= "Ignacious",
	Feludius		= "Feludius",
	Arion			= "Arion",
	Terrastra		= "Terrastra",
	Monstrosity		= "Monstruosité en élémentium",
	Kill			= "Impossible...."
})

L:SetOptionLocalization({
	SpecWarnGrounded	= "Alerte spéciale lorsque vous manquez l'amélioration $spell:83581 \n(~10sec avant le lancement du sort)",
	SpecWarnSearingWinds	= "Alerte spéciale lorsque vous manquez l'amélioration  $spell:83500 \n(~10sec avant le lancement du sort)",
	timerTransition		= "Afficher le temps pour: Phase de transition",
	HeartIceIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82665),
	BurningBloodIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82660),
	LightningRodIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(83099),
	GravityCrushIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(84948)
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
})

L:SetOptionLocalization({
	WarnPhase2Soon	= "Afficher la pré-alerte pour la Phase 2"
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