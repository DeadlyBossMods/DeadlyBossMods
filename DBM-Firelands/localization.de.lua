if GetLocale() ~= "deDE" then return end
local L

-----------------
-- Beth'tilac --
-----------------
L= DBM:GetModLocalization(192)

L:SetOptionLocalization({
	RangeFrame			= "Zeige Abstandsfenster (10m)"
})

L:SetMiscLocalization({
	EmoteSpiderlings 	= "Spinnlinge sind aus ihrem Nest aufgeschreckt worden!"
})

-------------------
-- Lord Rhyolith --
-------------------
L= DBM:GetModLocalization(193)

---------------
-- Alysrazor --
---------------
L= DBM:GetModLocalization(194)

L:SetWarningLocalization({
	WarnPhase			= "Phase %d",
	WarnNewInitiate		= "Lodernde Kralleninitianden (%s)"
})

L:SetTimerLocalization({
	TimerPhaseChange	= "Phase %d",
	TimerHatchEggs		= "Eierausschlüpfen",
	timerNextInitiate	= "Nächste Initianden (%s)",
	TimerCombatStart	= "Kampfbeginn"
})

L:SetOptionLocalization({
	TimerCombatStart	= "Zeige Zeit bis Kampfbeginn",
	WarnPhase			= "Zeige Warnung für jeden Phasenwechsel",
	WarnNewInitiate		= "Zeige Warnung für neue Lodernde Kralleninitianden",
	timerNextInitiate	= "Zeige Zeit bis nächste Lodernde Kralleninitianden",
	TimerPhaseChange	= "Zeige Zeit bis nächste Phase",
	TimerHatchEggs		= "Zeige Zeit bis nächstes Eierausschlüpfen",
	InfoFrame			= "Zeige Infofenster für $spell:98734"
})

L:SetMiscLocalization({
	YellPull		= "Ich diene jetzt einem neuen Meister, Sterbliche!",
	YellPhase2		= "Dieser Himmel ist MEIN.",
	FullPower		= "spell:99925",--This is in the emote, shouldn't need localizing, just msg:find
	LavaWorms		= "Feurige Lavawürmer brechen aus dem Boden hervor!",
	East			= "Osten",
	West			= "Westen",
	Both			= "beidseitig"
})

-------------
-- Shannox --
-------------
L= DBM:GetModLocalization(195)

L:SetOptionLocalization({
	SetIconOnFaceRage	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(99947),
	SetIconOnRage		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100415)
})

-------------
-- Baleroc --
-------------
L= DBM:GetModLocalization(196)

L:SetWarningLocalization({
	warnStrike	= "%s (%d)"
})

L:SetTimerLocalization({
	timerStrike			= "Nächster %s",
	TimerBladeActive	= "%s",
	TimerBladeNext		= "Nächste Klinge"
})

L:SetOptionLocalization({
	ResetShardsinThrees	= "Neustart der $spell:99259 Zählung in 3er-Gruppen (25 Spieler)\nbzw. 2er-Gruppen (10 Spieler)",
	warnStrike			= "Zeige Warnungen für $spell:99353 / $spell:101002",
	timerStrike			= "Zeit bis nächster $spell:99353 / $spell:101002 anzeigen",
	TimerBladeActive	= "Dauer der aktiven Klinge anzeigen",
	TimerBladeNext		= "Zeit bis nächste $spell:99352 / $spell:99350 anzeigen",
	SetIconOnCountdown	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(99516),
	SetIconOnTorment	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(99256),
	ArrowOnCountdown	= "Zeige DBM-Pfeil, wenn du von $spell:99516 betroffen bist",
	InfoFrame			= "Zeige Infofenster für $spell:99262 Stapel",
	RangeFrame			= "Zeige Abstandsfenster (5m) für $spell:99257"
})

L:SetMiscLocalization({
	VitalSpark		= GetSpellInfo(99262).." Stapel"
})

--------------------------------
-- Majordomo Fandral Staghelm --
--------------------------------
L= DBM:GetModLocalization(197)

L:SetTimerLocalization({
	timerNextSpecial	= "Nächste %s (%d)"
})

L:SetOptionLocalization({
	timerNextSpecial			= "Zeige Zeit bis nächste Spezialfähigkeit ($spell:98474 / $spell:100208)",
	RangeFrameSeeds				= "Zeige Abstandsfenster (12m) für $spell:98450",
	RangeFrameCat				= "Zeige Abstandsfenster (10m) für $spell:98374",
	LeapArrow					= "Zeige DBM-Pfeil, falls $spell:98476 nahe bei dir ist",
	IconOnLeapingFlames			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(98476)
})

--------------
-- Ragnaros --
--------------
L= DBM:GetModLocalization(198)

L:SetWarningLocalization({
	warnRageRagnarosSoon	= "%s auf %s in 5 Sekunden",--Spellname on targetname
	warnSplittingBlow		= "%s im %s",--Spellname in Location
	warnEngulfingFlame		= "%s im %s",--Spellname in Location
	warnEmpoweredSulf		= "%s in 5 Sekunden"
})

L:SetTimerLocalization({
	timerRageRagnaros		= "%s auf %s",--Spellname on targetname
	TimerPhaseSons			= "Phasenübergang endet"
})

L:SetOptionLocalization({
	warnRageRagnarosSoon		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.prewarn:format(101109, GetSpellInfo(101109)),
	warnSplittingBlow			= "Zeige Warnungen für Position des $spell:98951",
	warnEngulfingFlame			= "Zeige Warnungen für Position der $spell:99171 auf Normal",
	warnEngulfingFlameHeroic	= "Zeige Warnungen für Position der $spell:99171 auf Heroisch",
	warnSeedsLand				= "Zeige Warnung/Timer für Landung der $spell:98520\n(anstatt Erzeugung)",
	warnEmpoweredSulf			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast:format(100604, GetSpellInfo(100604)),
	timerRageRagnaros			= DBM_CORE_AUTO_TIMER_OPTIONS.cast:format(101109, GetSpellInfo(101109)),
	TimerPhaseSons				= "Dauer des Phasenübergangs (\"Söhne der Flamme\") anzeigen",
	RangeFrame					= "Zeige Abstandsfenster",
	InfoHealthFrame				= "Zeige Infofenster für Gesundheit (<100k Lebenspunkte)",
	MeteorFrame					= "Zeige Infofenster für Ziele von $spell:99849",
	AggroFrame					= "Zeige Infofenster für Spieler, die keine Aggro während\n$journal:2647 haben",
	BlazingHeatIcons			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100460)
})

L:SetMiscLocalization({
	East				= "Osten",
	West				= "Westen",
	Middle				= "Zentrum",
	North				= "Nahkampfbereich",
	South				= "Außenbereich",
	HealthInfo			= "Unter 100k LP",
	HasNoAggro			= "Keine Aggro",
	MeteorTargets		= "Meteorziele!",
	TransitionEnded1	= "Genug! Ich werde dem ein Ende machen.",
	TransitionEnded2	= "Sulfuras wird Euer Ende sein.",
	TransitionEnded3	= "Auf die Knie, Sterbliche! Das ist das Ende.",
	Defeat				= "Zu früh!… Ihr kommt zu früh...",
	Phase4				= "Zu früh!…" --needs to be verified (wowhead-captured translation)
})

-----------------------
--  Firelands Trash  --
-----------------------
L = DBM:GetModLocalization("FirelandsTrash")

L:SetGeneralLocalization({
	name = "Trash der Feuerlande"
})

----------------
--  Volcanus  --
----------------
L = DBM:GetModLocalization("Volcanus")

L:SetGeneralLocalization({
	name = "Volcanus"
})

L:SetTimerLocalization({
	timerStaffTransition	= "Phasenübergang endet"
})

L:SetOptionLocalization({
	timerStaffTransition	= "Dauer des Phasenübergangs anzeigen"
})

L:SetMiscLocalization({
	StaffEvent			= "Der Zweig von Nordrassil reagiert heftig auf die Berührung von %S+.",--Reg expression pull match
	StaffTrees			= "Brennende Treants brechen aus dem Boden hervor, um dem Beschützer beizustehen!",--Might add a spec warning for this later.
	StaffTransition		= "Die Feuer, die den gepeinigten Beschützer verzehren, erlöschen!"
})

-----------------------
--  Nexus Legendary  --
-----------------------
L = DBM:GetModLocalization("NexusLegendary")

L:SetGeneralLocalization({
	name = "Thyrinar"
})
