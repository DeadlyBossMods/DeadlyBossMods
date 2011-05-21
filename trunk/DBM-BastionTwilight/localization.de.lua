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

L:SetOptionLocalization({
	ShowDrakeHealth		= "Zeige die Gesundheit befreiter Drachen (benötigt aktivierte Lebensanzeige)"
})

L:SetMiscLocalization({
})

---------------------------
--  Valiona & Theralion  --
---------------------------
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
L = DBM:GetModLocalization("AscendantCouncil")

L:SetGeneralLocalization({
	name =	"Rat der Aszendenten"
})

L:SetWarningLocalization({
	specWarnBossLow			= "%s unter 30%% - nächste Phase bald!",
	SpecWarnGrounded		= "Hole den Geerdet Buff",
	SpecWarnSearingWinds	= "Hole den Wirbelnde Winde Buff"
})

L:SetTimerLocalization({
	timerTransition			= "Phasenübergang"
})

L:SetOptionLocalization({
	specWarnBossLow			= "Zeige Spezialwarnung, wenn Bosse unter 30% Lebenspunkten sind",
	SpecWarnGrounded		= "Zeige Spezialwarnung, falls dir der $spell:83581 Buff fehlt\n(~10 Sekunden vor dem Wirken von $spell:83067)",
	SpecWarnSearingWinds	= "Zeige Spezialwarnung, falls dir der $spell:83500 Buff fehlt\n(~10 Sekunden vor dem Wirken von $spell:83565)",
	timerTransition			= "Zeige Timer für den Phasenübergang",
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
	Phase3			= "Beeindruckende Leistung...",--"SCHMECKT DIE VERDAMMNIS!" is about 13 seconds after
	Ignacious		= "Ignazius",
	Feludius		= "Feludius",
	Arion			= "Arion",
	Terrastra		= "Terrastra",
	Monstrosity		= "Elementiumungeheuer",
	Kill			= "Unmöglich...",
	blizzHatesMe	= "Leuchtfeuer & Ableiter auf mir! Aus dem Weg!",
	PlayerDebuffs	= "Falscher Debuff"
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
L = DBM:GetModLocalization("Sinestra")

L:SetGeneralLocalization({
	name =	"Sinestra"
})

L:SetWarningLocalization({
	WarnDragon			= "Zwielichtwelpen gespawnt",
	WarnOrbsSoon		= "Schattenkugeln in %d Sekunden!",
	WarnEggWeaken		= "Zwielichtpanzer um Ei ist zerfallen",
	SpecWarnOrbs		= "Schattenkugeln kommen! Aufpassen!",
	warnWrackJump		= "%s gesprungen auf >%s<",
	WarnWrackCount5s	= "%d Sek. vergangen seit letztem Zermürben",
	warnAggro			= "%s hat Aggro (Schattenkugeln-Kandidat)",
	SpecWarnAggroOnYou	= "Du hast Aggro! Auf Schattenkugeln achten!",
	SpecWarnDispel		= "%d Sek. vergangen seit letztem Zermürben - Jetzt reinigen!",
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
	WarnDragon			= "Zeige Warnung, wenn Zwielichtwelpen spawnen",
	WarnOrbsSoon		= "Zeige Vorwarnung für Schattenkugeln (5s zuvor, sekündlich)\n(voraussichtlich, kann ungenau sein, kann spammen)",
	WarnEggWeaken		= "Zeige Warnung, wenn $spell:87654 zerfallen ist",
	warnWrackJump		= "Verkünde Sprungziele von $spell:92955 ",
	WarnWrackCount5s	= "Verkünde die Zeit, die ein Spieler von $spell:92955 betroffen ist,\n bei 10, 15, 20 Sekunden",
	warnAggro			= "Verkünde Spieler mit Aggro, wenn Schattenkugeln spawnen\n(mögliches Ziel der Schattenkugeln)",
	SpecWarnAggroOnYou	= "Zeige Spezialwarnung, falls du Aggro hast, wenn Schattenkugeln spawnen\n(mögliches Ziel der Schattenkugeln)",
	SpecWarnOrbs		= "Zeige Spezialwarnung, wenn Schattenkugeln spawnen (voraussichtlich)",
	SpecWarnDispel		= "Zeige Spezialwarnung um $spell:92955 zu reinigen\n(nachdem nach dem Wirken/Springen eine bestimmte Zeit vergangen ist)",
	SpecWarnEggWeaken	= "Zeige Spezialwarnung, wenn $spell:87654 zerfallen ist",
	SpecWarnEggShield	= "Zeige Spezialwarnung, wenn $spell:87654 erneuert wurde",
	TimerDragon			= "Zeit bis nächste Zwielichtwelpen spawnen anzeigen",
	TimerEggWeakening	= "Zeige Timer, wenn $spell:87654 zerfällt",
	TimerEggWeaken		= "Dauer der Erneuerung des $spell:87654 anzeigen",
	TimerOrbs			= "Zeit bis nächste Schattenkugeln anzeigen\n(voraussichtlich, kann ungenau sein)",
	SetIconOnOrbs		= "Setze Zeichen auf Spieler mit Aggro wenn Schattenkugeln spawnen\n(mögliches Ziel der Schattenkugeln)"
})

L:SetMiscLocalization({
	YellDragon			= "Fresst, Kinder! Nährt Euch an ihrem Fleisch!", --needs to be verified (video-captured translation, maybe inaccurate whitespaces)
	YellEgg				= "Ihr denkt, ich sei schwach? Narren!" --needs to be verified (video-captured translation, maybe inaccurate whitespaces)
})

--------------------------
--  The Bastion of Twilight Trash  --
--------------------------
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