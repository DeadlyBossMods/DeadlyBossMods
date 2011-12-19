if GetLocale() ~= "deDE" then return end
local L

--------------------------
--  Halfus Wyrmbreaker  --
--------------------------
--L = DBM:GetModLocalization(156)
L = DBM:GetModLocalization("HalfusWyrmbreaker")

L:SetGeneralLocalization({
	name =	"Halfus Wyrmbrecher"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	ShowDrakeHealth		= "Zeige die Gesundheit befreiter Drachen (benötigt aktivierte Lebensanzeige)"
})

L:SetMiscLocalization({
})

---------------------------
--  Valiona & Theralion  --
---------------------------
--L = DBM:GetModLocalization(157)
L = DBM:GetModLocalization("ValionaTheralion")

L:SetGeneralLocalization({
	name =	"Theralion und Valiona"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	TBwarnWhileBlackout		= "Warne auch bei aktivem $spell:86788 vor $spell:92898",
	TwilightBlastArrow		= "Zeige DBM-Pfeil, falls $spell:92898 in deiner Nähe ist",
	RangeFrame				= "Zeige Abstandsfenster (10m)",
	BlackoutShieldFrame		= "Zeige Lebensanzeige mit einem Balken für $spell:92878",
	BlackoutIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92878),
	EngulfingIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(86622)
})

L:SetMiscLocalization({
	Trigger1				= "Tiefer Atem",
	BlackoutTarget			= "Blackout: %s"
})

----------------------------------
--  Twilight Ascendant Council  --
----------------------------------
--L = DBM:GetModLocalization(158)
L = DBM:GetModLocalization("AscendantCouncil")

L:SetGeneralLocalization({
	name =	"Rat der Aszendenten"
})

L:SetWarningLocalization({
	specWarnBossLow			= "%s unter 30%% - nächste Phase bald!",
	SpecWarnGrounded		= "Hole Geerdet",
	SpecWarnSearingWinds	= "Hole Wirbelnde Winde"
})

L:SetTimerLocalization({
	timerTransition			= "Phasenübergang"
})

L:SetOptionLocalization({
	specWarnBossLow			= "Zeige Spezialwarnung, wenn Bosse unter 30% Lebenspunkten sind",
	SpecWarnGrounded		= "Zeige Spezialwarnung, falls dir der $spell:83581 Buff fehlt\n(~10 Sekunden vor dem Wirken von $spell:83067)",
	SpecWarnSearingWinds	= "Zeige Spezialwarnung, falls dir der $spell:83500 Buff fehlt\n(~10 Sekunden vor dem Wirken von $spell:83565)",
	timerTransition			= "Dauer des Phasenübergangs anzeigen",
	RangeFrame				= "Zeige Abstandsfenster automatisch bei Bedarf",
	yellScrewed				= "Schreie, wenn du gleichzeitig von $spell:83099 und $spell:92307\nbetroffen bist",
	InfoFrame				= "Zeige Infofenster für Spieler ohne $spell:83581 bzw. $spell:83500",
	HeartIceIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82665),
	BurningBloodIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82660),
	LightningRodIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(83099),
	GravityCrushIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(84948),
	FrostBeaconIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92307),
	StaticOverloadIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92067),
	GravityCoreIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92075)
})

L:SetMiscLocalization({
	Quake			= "Der Boden unter Euch grollt unheilvoll...",
	Thundershock	= "Die Luft beginnt, vor Energie zu knistern...",
	Switch			= "Genug der Spielereien!",--"Wir kümmern uns um sie!" comes 3 seconds after this one
	Phase3			= "Beeindruckende Leistung…",--"SCHMECKT DIE VERDAMMNIS!" is about 13 seconds after; its indeed this special UTF-8 char at end, not "..." (logfiles 4.1.0.14007)
	Ignacious		= "Ignazius",
	Feludius		= "Feludius",
	Arion			= "Arion",
	Terrastra		= "Terrastra",
	Monstrosity		= "Elementiumungeheuer",
	Kill			= "Unmöglich…", -- its indeed this special UTF-8 char at end, not "..." (logfiles 4.1.0.14007)
	blizzHatesMe	= "Leuchtfeuer & Ableiter auf mir! Aus dem Weg!",
	WrongDebuff		= "Kein %s"
})

----------------
--  Cho'gall  --
----------------
--L = DBM:GetModLocalization(167)
L = DBM:GetModLocalization("Chogall")

L:SetGeneralLocalization({
	name =	"Cho'gall"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	CorruptingCrashArrow	= "Zeige DBM-Pfeil, falls $spell:93178 nahe bei dir ist",
	InfoFrame				= "Zeige Infofenster für $spell:81701",
	RangeFrame				= "Zeige Abstandsfenster (5m) für $spell:82235",
	SetIconOnWorship		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(91317),
	SetIconOnCreature		= "Setze Zeichen auf Verfinsterte Geschöpfe"
})

L:SetMiscLocalization({
	Bloodlevel				= "Verderbnis"
})

----------------
--  Sinestra  --
----------------
--L = DBM:GetModLocalization(168)
L = DBM:GetModLocalization("Sinestra")

L:SetGeneralLocalization({
	name =	"Sinestra"
})

L:SetWarningLocalization({
	WarnDragon			= "Zwielichtwelpen erschienen",
	WarnOrbSoon			= "Schattenkugeln in %d Sekunden!",
	SpecWarnOrbs		= "Schattenkugeln kommen! Aufpassen!",
	warnWrackJump		= "%s gesprungen auf >%s<",
	warnAggro			= "Spieler mit Aggro (Schattenkugeln-Kandidaten): >%s<",
	SpecWarnAggroOnYou	= "Du hast Aggro! Auf Schattenkugeln achten!",
	SpecWarnEggWeaken	= "Zwielichtpanzer ist zerfallen - Jetzt Schaden auf das EI!",
	SpecWarnEggShield	= "Zwielichtpanzer erneuert!"
})

L:SetTimerLocalization({
	TimerDragon			= "Nächste Zwielichtwelpen",
	TimerEggWeakening	= "Zwielichtpanzer zerfällt",   -- ( 4sec timer)
	TimerEggWeaken		= "Zwielichtpanzer Erneuerung", -- (30sec timer)
	TimerOrbs			= "Nächste Schattenkugeln"
})

L:SetOptionLocalization({
	WarnDragon			= "Zeige Warnung, wenn Zwielichtwelpen erscheinen",
	WarnOrbSoon			= "Zeige Vorwarnung für Schattenkugeln (5s zuvor, sekündlich)\n(voraussichtlich, kann ungenau sein, kann spammen)",
	warnWrackJump		= "Verkünde Sprungziele von $spell:92955 ",
	warnAggro			= "Verkünde Spieler mit Aggro, wenn Schattenkugeln erscheinen\n(mögliches Ziel der Schattenkugeln)",
	SpecWarnAggroOnYou	= "Zeige Spezialwarnung, falls du Aggro hast, wenn Schattenkugeln\nerscheinen (mögliches Ziel der Schattenkugeln)",
	SpecWarnOrbs		= "Zeige Spezialwarnung, wenn Schattenkugeln erscheinen (voraussichtlich)",
	SpecWarnEggWeaken	= "Zeige Spezialwarnung, wenn $spell:87654 zerfallen ist",
	SpecWarnEggShield	= "Zeige Spezialwarnung, wenn $spell:87654 erneuert wurde",
	TimerDragon			= "Zeige Zeit bis nächste Zwielichtwelpen erscheinen",
	TimerEggWeakening	= "Zeige Timer, wenn $spell:87654 zerfällt",
	TimerEggWeaken		= "Dauer der Erneuerung des $spell:87654 anzeigen",
	TimerOrbs			= "Zeige Zeit bis nächste Schattenkugeln erscheinen\n(voraussichtlich, kann ungenau sein)",
	SetIconOnOrbs		= "Setze Zeichen auf Spieler mit Aggro, wenn Schattenkugeln erscheinen\n(mögliches Ziel der Schattenkugeln)",
	OrbsCountdown		= "Spiele Countdown-Sound für Schattenkugeln",
	InfoFrame			= "Zeige Infofenster für Spieler mit Aggro"
})

L:SetMiscLocalization({
	YellDragon			= "Fresst, Kinder! Nährt Euch an ihrem Fleisch!", --needs to be verified (video-captured translation, maybe inaccurate whitespaces)
	YellEgg				= "Ihr denkt, ich sei schwach? Narren!", --needs to be verified (video-captured translation, maybe inaccurate whitespaces)
	HasAggro			= "Hat Aggro"
})

-------------------------------------
--  The Bastion of Twilight Trash  --
-------------------------------------
L = DBM:GetModLocalization("BoTrash")

L:SetGeneralLocalization({
	name =	"Trash der Bastion des Zwielichts"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})