if GetLocale() ~= "deDE" then return end
local L

-------------
-- Morchok --
-------------
L= DBM:GetModLocalization(311)

L:SetWarningLocalization({
	KohcromWarning	= "%s: %s"--Bossname, spellname. At least with this we can get boss name from casts in this one, unlike a timer started off the previous bosses casts.
})

L:SetTimerLocalization({
	KohcromCD		= "Kohcrom mimicks %s",--Universal single local timer used for all of his mimick timers
})

L:SetOptionLocalization({
	KohcromWarning	= "Show warnings for Kohcrom mimicking abilities.",
	KohcromCD		= "Show timers for Kohcrom's next ability mimick.",
	RangeFrame		= "Zeige Abstandsfenster (5m) für den Erfolg."
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
	RangeFrame			= "Show dynamic range frame based on player debuff status for\n$spell:104601 on Heroic difficulty",
	NoFilterRangeFrame	= "Disable Range Frame debuff filter and always show everyone"
})

L:SetMiscLocalization({
	voidYell	= "Gul'kafh an'qov N'Zoth."--Start translating the yell he does for Void of the Unmaking cast, the latest logs from DS indicate blizz removed the UNIT_SPELLCAST_SUCCESS event that detected casts. sigh.
})

-----------------------------
-- Yor'sahj the Unsleeping --
-----------------------------
L= DBM:GetModLocalization(325)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	timerOozesActive	= "Kugeln verwundbar"
})

L:SetOptionLocalization({
	timerOozesActive	= "Zeige Timer bis zum Zeitpunkt da die Kugeln angreifbar werden.",
	RangeFrame			= "Zeige Abstandsfenster (4m) für $spell:104898\n(Normal & Heroisch)"
})

L:SetMiscLocalization({
	Black			= "|cFF424242schwarz|r",
	Purple			= "|cFF9932CDlila|r",
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
	warnFrostTombCast		= "%s in 8 Sek"
})

L:SetTimerLocalization({
	TimerSpecial			= "Erste Spezialfähigkeit"
})

L:SetOptionLocalization({
	TimerSpecial			= "Zeige Timer für die zuerst gewirkte Spezialfähigkeit",
	RangeFrame				= "Zeige Abstandsfenster(3m) für $spell:105269",
	AnnounceFrostTombIcons	= "Verkünde Schlachtzugsymbole für Ziele von $spell:104451 im Raidchat\n(benötigt Schlachtzugleiter)",
	warnFrostTombCast		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast:format(104448, GetSpellInfo(104448)),
	SetIconOnFrostTomb		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(104451),
	SetIconOnFrostflake		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(109325)
})

L:SetMiscLocalization({
	TombIconSet				= "Frost Beacon icon {rt%d} set on %s"
})

---------------
-- Ultraxion --
---------------
L= DBM:GetModLocalization(331)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	TimerCombatStart	= "Ultraxion landet"
})

L:SetOptionLocalization({
	TimerCombatStart	= "Zeige Timer für Ultraxion RP"
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
	TimerSapper			= "Nächster Zwielichtpionier",
	TimerAdd			= "Nächste Elitegegner"
})

L:SetOptionLocalization({
	TimerCombatStart	= "Zeige Timer für Kampfbeginn",
	TimerSapper			= "Zeige Timer für das Erscheinen des nächsten Zwielichtpioniers",--npc=56923
	TimerAdd			= "Zeige Timer für das Erscheinen der nächsten Zwielicht Elite "
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
	SpecWarnTendril			= "Haltet euch fest!"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SpecWarnTendril			= "Zeige Spezialwarnung wenn du nich von$spell:109454 betroffen bist.",--http://ptr.wowhead.com/npc=56188
	InfoFrame				= "Zeige Infofenster für Spieler ohne $spell:109454",
	SetIconOnGrip			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(109459),
	ShowShieldInfo			= "Zeige Bosslebensbalken für $spell:105479"
})

L:SetMiscLocalization({
	Pull		= "Die Platten! Es zerreißt ihn! Zerlegt die Platten und wir können ihn vielleicht runterbringen.",
	NoDebuff	= "Keine %s",
	PlasmaTarget	= "Sengendes Plasma: %s",
	DRoll		= "about to roll"
})

---------------------------
-- Madness of Deathwing  -- 
---------------------------
L= DBM:GetModLocalization(333)

L:SetWarningLocalization({
	SpecWarnTentacle	= "Blasiges Tentakel - Ziel wechseln!"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SpecWarnTentacle	= "Zeige Spezialwarnung wenn Blasige Tentakeln erscheinen (und Alexstrasza inaktiv ist)"
})

L:SetMiscLocalization({
	Pull				= "Ihr habt NICHTS erreicht. Ich werde Eure Welt in STÜCKE reißen."
})
