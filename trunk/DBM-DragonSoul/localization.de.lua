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
	KohcromWarning	= "Zeige Warnungen, wenn $journal:4262 Fähigkeiten nachahmt",
	KohcromCD		= "Zeige Zeiten bis $journal:4262 Fähigkeiten nachahmt",
	RangeFrame		= "Zeige Abstandsfenster (5m) für Erfolg \"Rück' mir nicht auf die Pelle\""
})

L:SetMiscLocalization({
})

---------------------
-- Warlord Zon'ozz --
---------------------
L= DBM:GetModLocalization(324)

L:SetOptionLocalization({
	ShadowYell			= "Schreie, wenn du von $spell:103434 betroffen bist\n(nur heroischer Schwierigkeitsgrad)",
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
	warnOozesHit	= "%s absorbierte %s"
})

L:SetTimerLocalization({
	timerOozesActive	= "Kugeln angreifbar",
	timerOozesReach		= "Kugeln erreichen Boss"
})

L:SetOptionLocalization({
	warnOozesHit		= "Verkünde die Farben der Blutkugeln, die den Boss getroffen haben",
	timerOozesActive	= "Zeige Zeit bis Blutkugeln angreifbar sind",
	timerOozesReach		= "Zeige Zeit bis Blutkugeln Yor'sahj erreichen",
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
	WarnPillars				= "%s: %d verbleibend",
	warnFrostTombCast		= "%s in 8 Sekunden"
})

L:SetTimerLocalization({
	TimerSpecial			= "Erste Spezialfähigkeit"
})

L:SetOptionLocalization({
	WarnPillars				= "Verkünde die Anzahl der verbleibenden $journal:3919 bzw. $journal:4069e",
	TimerSpecial			= "Zeige Zeit bis erste Spezialfähigkeit gewirkt wird",
	RangeFrame				= "Zeige Abstandsfenster für $spell:105269 (3m) bzw. $journal:4327 (10m)",
	AnnounceFrostTombIcons	= "Verkünde Zeichen für Ziele von $spell:104451 im Schlachtzugchat (nur als Leiter)",
	warnFrostTombCast		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast:format(104448, GetSpellInfo(104448)),
	SetIconOnFrostTomb		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(104451),
	SetIconOnFrostflake		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(109325),
	SpecialCount			= "Spiele Countdown-Sound für $spell:105256 bzw. $spell:105465",
	SetBubbles				= "Automatische Deaktivierung der 'Sprechblasen' bevor $spell:104451 gewirkt wird\n(wird nach dem Kampfende auf die vorherige Einstellung zurückgesetzt)"
})

L:SetMiscLocalization({
	TombIconSet				= "Eisgrabzeichen {rt%d} auf %s gesetzt"
})

---------------
-- Ultraxion --
---------------
L= DBM:GetModLocalization(331)

L:SetWarningLocalization({
	specWarnHourofTwilightN		= "%s (%d) in 5 Sek"--spellname Count
})

L:SetTimerLocalization({
	TimerCombatStart	= "Ultraxion aktiv",
	timerRaidCDs		= "%s CD: %s"--spellname CD Castername
})

L:SetOptionLocalization({
	TimerCombatStart	= "Zeige Dauer des Rollenspiels bevor Ultraxion aktiv wird",
	ResetHoTCounter		= "Neustart der Stunde des Zwielichts Zählung",
	Never				= "Nie",
	ResetDynamic		= "In 3er/2er-Gruppen (heroisch/normal)",
	Reset3Always		= "Immer in 3er-Gruppen",
	SpecWarnHoTN		= "Spezialvorwarnung für Stunde des Zwielichts (bei Neustart auf \"Nie\" nach 3er-Gruppenregel)",
	One					= "5 Sekunden vor Zählerstand 1 (1 4 7 ...)",
	Two					= "5 Sekunden vor Zählerstand 2 (2 5 ...)",
	Three				= "5 Sekunden vor Zählerstand 3 (3 6 ...)",
	dropdownRaidCDs		= "Zeige Timer für \"Raid-Cooldowns\"",
	ShowRaidCDs			= "Alle",
	ShowRaidCDsSelf		= "Nur meine"
})

L:SetMiscLocalization({
	Pull				= "Ich spüre, wie eine gewaltige Störung in der Harmonie näherkommt. Das Chaos bereitet meiner Seele Schmerzen."
})

-------------------------
-- Warmaster Blackhorn --
-------------------------
L= DBM:GetModLocalization(332)

L:SetWarningLocalization({
	SpecWarnElites	= "Zwielichtelitegegner!"
})

L:SetTimerLocalization({
	TimerCombatStart	= "Kampfbeginn",
	TimerAdd			= "Nächste Elitegegner"
})

L:SetOptionLocalization({
	TimerCombatStart	= "Zeige Zeit bis Kampfbeginn",
	TimerAdd			= "Zeige Zeit bis nächste Zwielichtelitegegner erscheinen",
	SpecWarnElites		= "Zeige Spezialwarnung, wenn neue Zwielichtelitegegner erscheinen",
	SetTextures			= "Automatische Deaktivierung der Grafikeinstellung 'Projizierte Texturen'\nin Phase 1 (wird in Phase 2 automatisch wieder aktiviert)"
})

L:SetMiscLocalization({
	SapperEmote			= "Ein Drache stürzt herab, um einen Zwielichtpionier auf dem Deck abzusetzen!",
	Broadside			= "spell:110153",
	DeckFire			= "spell:110095",
	GorionaRetreat			= "schreit vor Schmerzen auf und zieht sich in die wirbelnden Wolken zurück."
})

-------------------------
-- Spine of Deathwing  --
-------------------------
L= DBM:GetModLocalization(318)

L:SetWarningLocalization({
	SpecWarnTendril			= "Festhalten!"
})

L:SetOptionLocalization({
	SpecWarnTendril			= "Zeige Spezialwarnung, falls dir der $spell:105563 Buff fehlt",
	InfoFrame				= "Zeige Infofenster für Spieler ohne $spell:105563",
	SetIconOnGrip			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(105490),
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

L:SetOptionLocalization({
	RangeFrame			= "Zeige dynamisches Abstandsfenster (10m) basierend auf Spieler-Debuffs für\n$spell:108649 auf heroischem Schwierigkeitsgrad",
	SetIconOnParasite	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(108649)
})

L:SetMiscLocalization({
	Pull				= "Ihr habt NICHTS erreicht. Ich werde Eure Welt in STÜCKE reißen."
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("DSTrash")

L:SetGeneralLocalization({
	name =	"Trash der Drachenseele"
})

L:SetWarningLocalization({
	DrakesLeft			= "Zwielichtangreifer verbleibend: %d"
})

L:SetTimerLocalization({
	TimerDrakes			= "%s"--spellname from mod
})

L:SetOptionLocalization({
	DrakesLeft			= "Verkünde die Anzahl der verbleibenden Zwielichtangreifer",
	TimerDrakes			= "Zeige Zeit bis zur $spell:109904 der Zwielichtangreifer"
})

L:SetMiscLocalization({
	EoEEvent			= "Es ist sinnlos, die Macht der Drachenseele ist zu gewaltig",--Partial
	UltraxionTrash		= "Es tut gut, Euch wiederzusehen, Alexstrasza. Während meiner Abwesenheit war ich fleißig.",
	UltraxionTrashEnded = "Sie waren bloß Welpen, Experimente, Mittel zu einem Zweck. Ihr werdet sehen, was meine Forschung hervorgebracht hat."
})