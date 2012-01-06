if GetLocale() ~= "deDE" then return end
local L

-------------
-- Morchok --
-------------
L= DBM:GetModLocalization(311)

L:SetWarningLocalization({
	KohcromWarning	= "%s: %s"
})

L:SetTimerLocalization({
	KohcromCD		= "Kohcrom imitiert %s",
})

L:SetOptionLocalization({
	KohcromWarning	= "Zeige Warnungen, wenn Kohcrom Fähigkeiten nachahmt",
	KohcromCD		= "Zeige Zeiten bis Kohcrom Fähigkeiten nachahmt",
	RangeFrame		= "Zeige Abstandsfenster (5m) für Erfolg \"Rück' mir nicht auf die Pelle\""
})

L:SetMiscLocalization({
})

---------------------
-- Warlord Zon'ozz --
---------------------
L= DBM:GetModLocalization(324)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	ShadowYell			= "Schreie, wenn du von $spell:104600 betroffen bist\n(nur heroischer Schwierigkeitsgrad)",
	CustomRangeFrame	= "Abstandsfenster (10m) für Störende Schatten (nur heroischer Schwierigkeitsgrad)",
	Never				= "Deaktiviert",
	Normal				= "Aktiviert (ohne Debufffilter)",
	DynamicPhase2		= "Aktiviert (mit Debufffilter in Phase 2)",
	DynamicAlways		= "Aktiviert (mit Debufffilter in allen Phasen)"
})

L:SetMiscLocalization({
	voidYell	= "Gul'kafh an'qov N'Zoth." -- verified (4.3.0.15050de)
})

-----------------------------
-- Yor'sahj the Unsleeping --
-----------------------------
L= DBM:GetModLocalization(325)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	timerOozesActive	= "Kugeln angreifbar"
})

L:SetOptionLocalization({
	timerOozesActive	= "Zeige Zeit bis Blutkugeln angreifbar sind",
	RangeFrame			= "Zeige Abstandsfenster (4m) für $spell:104898\n(normaler und heroischer Schwierigkeitsgrad)"
})

L:SetMiscLocalization({
	Black			= "|cFF424242schwarz|r",
	Purple			= "|cFF9932CDpurpur|r",
	Red				= "|cFFFF0404rot|r",
	Green			= "|cFF088A08grün|r",
	Blue			= "|cFF0080FFblau|r",
	Yellow			= "|cFFFFA901gelb|r"
})

-----------------------
-- Hagara the Binder --
-----------------------
L= DBM:GetModLocalization(317)

L:SetWarningLocalization({
	warnFrostTombCast		= "%s in 8 Sekunden"
})

L:SetTimerLocalization({
	TimerSpecial			= "Erste Spezialfähigkeit"
})

L:SetOptionLocalization({
	TimerSpecial			= "Zeige Zeit bis erste Spezialfähigkeit gewirkt wird",
	RangeFrame				= "Zeige Abstandsfenster: (3m) für $spell:105269, (10m) für $journal:4327",
	AnnounceFrostTombIcons	= "Verkünde Zeichen für Ziele von $spell:104451 im Schlachtzugchat (nur als Leiter)",
	warnFrostTombCast		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast:format(104448, GetSpellInfo(104448)),
	SetIconOnFrostTomb		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(104451),
	SetIconOnFrostflake		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(109325)
})

L:SetMiscLocalization({
	TombIconSet				= "Eisgrabzeichen {rt%d} auf %s gesetzt"
})

---------------
-- Ultraxion --
---------------
L= DBM:GetModLocalization(331)

L:SetWarningLocalization({
	specWarnHourofTwilightN		= "%s (%%d)"--spellname Count
})

L:SetTimerLocalization({
	TimerDrakes			= "%s",--spellname from mod
	TimerCombatStart	= "Ultraxion aktiv",
	timerRaidCDs		= "%s CD: %s"--spellname CD Castername
})

L:SetOptionLocalization({
	TimerDrakes			= "Zeige Zeit bis zur $spell:109904 der Zwielichtkampfdrachen",
	TimerCombatStart	= "Zeige Dauer des Rollenspiels bevor Ultraxion aktiv wird",
	ResetHoTCounter		= "Neustart der Stunde des Zwielichts Zählung",
	Never				= "Kein Neustart",
	Reset3				= "Neustart in 3er/2er-Gruppen (heroisch/normal)",
	Reset3Always		= "Neustart immer in 3er-Gruppen",
	ShowRaidCDs			= "Zeige Timer für \"Raid-Cooldowns\" (in Entwicklung)",
	ShowRaidCDsSelf		= "Zeige jedoch nur Timer für eigene \"Raid-Cooldowns\"\n(benötigt aktivierte Timer für \"Raid-Cooldowns\")"
})

L:SetMiscLocalization({
	Trash				= "Es tut gut, Euch wiederzusehen, Alexstrasza. Während meiner Abwesenheit war ich fleißig.",
	Pull				= "Ich spüre, wie eine gewaltige Störung in der Harmonie näherkommt. Das Chaos bereitet meiner Seele Schmerzen."
})

-------------------------
-- Warmaster Blackhorn --
-------------------------
L= DBM:GetModLocalization(332)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	TimerCombatStart	= "Kampfbeginn",
	TimerAdd			= "Nächste Elitegegner"
})

L:SetOptionLocalization({
	TimerCombatStart	= "Zeige Zeit bis Kampfbeginn",
	TimerAdd			= "Zeige Zeit bis nächste Zwielichtelitegegner erscheinen"
})

L:SetMiscLocalization({
	SapperEmote			= "Ein Drache stürzt herab, um einen Zwielichtpionier auf dem Deck abzusetzen!",
	Broadside			= "spell:110153",
	DeckFire			= "spell:110095"
})

-------------------------
-- Spine of Deathwing  --
-------------------------
L= DBM:GetModLocalization(318)

L:SetWarningLocalization({
	SpecWarnTendril			= "Festhalten!"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SpecWarnTendril			= "Zeige Spezialwarnung, falls dir der $spell:109454 Buff fehlt",
	InfoFrame				= "Zeige Infofenster für Spieler ohne $spell:109454",
	SetIconOnGrip			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(109459),
	ShowShieldInfo			= "Zeige Lebensanzeige mit einem Balken für $spell:105479"
})

L:SetMiscLocalization({
	Pull			= "Die Platten! Es zerreißt ihn! Zerlegt die Platten und wir können ihn vielleicht runterbringen.",
	NoDebuff		= "Keine %s",
	PlasmaTarget	= "Sengendes Plasma: %s",
	DRoll			= "wird gleich",
	DLevels			= "stabilisiert sich"
})

---------------------------
-- Madness of Deathwing  -- 
---------------------------
L= DBM:GetModLocalization(333)

L:SetWarningLocalization({
	SpecWarnTentacle	= "Blasige Tentakel fokussieren!",
	SpecWarnCongealing	= "Gerinnendes Blut beseitigen!"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SpecWarnTentacle	= "Zeige Spezialwarnung, wenn Blasige Tentakel erscheinen (und Alexstrasza nicht aktiv ist)",
	SpecWarnCongealing	= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format(109089),
	RangeFrame			= "Zeige dynamisches Abstandsfenster (10m) basierend auf Spieler-Debuffs für\n$spell:108649 auf heroischem Schwierigkeitsgrad",
	SetIconOnParasite	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(108649)
})

L:SetMiscLocalization({
	Pull				= "Ihr habt NICHTS erreicht. Ich werde Eure Welt in STÜCKE reißen."
})