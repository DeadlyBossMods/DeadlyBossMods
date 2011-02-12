if GetLocale() ~= "deDE" then return end
local L

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
	YellOnEngulfing			= "Schreie bei $spell:86622",
	YellOnMeteor			= "Schreie bei $spell:88518",
	YellOnTwilightBlast		= "Schreie bei $spell:92898",
	TwilightBlastArrow		= "Zeige DBM Pfeil, wenn $spell:92898 in deiner Nähe ist.",
	RangeFrame				= "Zeige Abstandsfenster (10 m)",
	BlackoutIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92878),
	EngulfingIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(86622)
})

L:SetMiscLocalization{
	Trigger1				= "Theralion, ich werde den Gang einhüllen. Deck ihre Flucht!",
	YellEngulfing			= "Einhüllende Magie auf mir!",
	YellMeteor				= "Zwielichtmeteorit auf mir!",
	YellTwilightBlast		= "Zwielichtdruckwelle auf mir!",
}

--------------------------
--  Halfus Wyrmbreaker  --
--------------------------
L = DBM:GetModLocalization("HalfusWyrmbreaker")

L:SetGeneralLocalization({
	name =	"Halfus Wyrmbrecher"
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
	name =	"Rat der Aszendenten"
})

L:SetWarningLocalization({
	specWarnBossLow			= ">%s< unter 30%",
	SpecWarnGrounded	= "Hole den Geerdet Buff",
	SpecWarnSearingWinds	= "Hole den Wirbelnde Winde Buff"
})

L:SetTimerLocalization({
	timerTransition		= "Phasenübergang"
})

L:SetMiscLocalization({
	Quake			= "Der Boden unter Euch grollt unheilvoll...",
	Thundershock	= "Die Luft beginnt, vor Energie zu knistern...",
	Switch			= "Wir kümmern uns um sie!",-- drycoded
	Phase3			= "SCHMECKT DIE VERDAMMNIS!",-- drycoded
	Ignacious		= "Ignazius",
	Feludius		= "Feludius ",
	Arion			= "Arion",
	Terrastra		= "Terrastra",
	Monstrosity		= "Elementiumungeheuer",
	Kill			= "Unmöglich..."-- drycoded
})

L:SetOptionLocalization({
	specWarnBossLow		= "Zeige Spezialwarnung wenn Boss unter 30% HP",
	SpecWarnGrounded	= "Zeige Spezialwarnung, wenn dir $spell:83581 Buff fehlt\n(~10Sek vor dem Zaubern)",
	SpecWarnSearingWinds	= "Zeige Spezialwarnung, wenn dir $spell:83500 Buff fehlt\n(~10Sek vor dem Zaubern)",
	timerTransition		= "Zeige Timer für den Phasenübergang",
	RangeFrame			= "Zeige Abstandsfenster automatisch bei Bedarf",
	HeartIceIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82665),
	BurningBloodIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82660),
	LightningRodIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(83099),
	GravityCrushIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(84948),
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
	WarnPhase2Soon	= "Phase 2 bald"
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
	Bloodlevel		= "Korruption" --maybe
})

L:SetOptionLocalization({
	WarnPhase2Soon	= "Zeige Vorwarnung für Phase 2",
	InfoFrame			= "Zeige Infofenster für $spell:82235",
	RangeFrame			= "Zeige Abstandsfenster (6) für $spell:82235",
	SetIconOnWorship	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(91317)
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