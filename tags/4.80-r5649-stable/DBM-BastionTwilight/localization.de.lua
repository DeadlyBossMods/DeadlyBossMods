if GetLocale() ~= "deDE" then return end
local L

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

L:SetOptionLocalization({
	TwilightBlastArrow		= "Zeige DBM Pfeil, wenn $spell:92898 in deiner Nähe ist.",
	RangeFrame				= "Zeige Abstandsfenster (10 m)",
	BlackoutIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92878),
	EngulfingIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(86622)
})

L:SetMiscLocalization{
	Trigger1				= "Theralion, ich werde den Gang einhüllen. Deck ihre Flucht!"--Change this to what deep breath emote is.
}

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

L:SetMiscLocalization({
	Quake			= "Der Boden unter Euch grollt unheilvoll...",
	Thundershock	= "Die Luft beginnt, vor Energie zu knistern...",
	Switch			= "Genug der Spielereien",
	Phase3			= "Beeindruckende Leistung…",
	Ignacious		= "Ignazius",
	Feludius		= "Feludius ",
	Arion			= "Arion",
	Terrastra		= "Terrastra",
	Monstrosity		= "Elementiumungeheuer",
	Kill			= "Unmöglich…"
})

----------------
--  Cho'gall  --
----------------
L = DBM:GetModLocalization("Chogall")

L:SetGeneralLocalization({
	name =	"Cho'gall"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
--	WarnPhase2Soon	= "Zeige Vorwarnung für Phase 2",
	InfoFrame			= "Zeige Infofenster für $spell:81701",
	RangeFrame			= "Zeige Abstandsfenster (5) für $spell:82235",
	SetIconOnWorship	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(91317),
	SetIconOnCreature	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82414)
})

L:SetMiscLocalization({
	Bloodlevel		= "Korruption" --maybe
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