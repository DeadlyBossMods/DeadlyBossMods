if GetLocale() ~= "deDE" then return end
local L

---------------
-- Alysrazor --
---------------
L= DBM:GetModLocalization(194)

L:SetWarningLocalization({
	WarnPhase			= "Phase %d",
	WarnNewInitiate		= "Lodernder Kralleninitiand (%d)"
})

L:SetTimerLocalization({
	TimerPhaseChange	= "Phase %d",
	TimerHatchEggs		= "Eierausschlüpfen",
	timerNextInitiate	= "Nächster Initiand"
})

L:SetOptionLocalization({
	WarnPhase			= "Zeige Warnung für jeden Phasenwechsel",
	WarnNewInitiate		= "Zeige Warnung für neuen Lodernder Kralleninitiand",
	timerNextInitiate	= "Zeige Zeit bis nächster Lodernder Kralleninitiand",
	TimerPhaseChange	= "Zeige Zeit bis nächste Phase",
	TimerHatchEggs		= "Zeige Zeit bis nächstes Eierausschlüpfen",
	InfoFrame			= "Zeige Infofenster für Lodernde Macht"
})

L:SetMiscLocalization({
	YellPull		= "Ich diene jetzt einem neuen Meister, Sterbliche!", --needs to be verified (screenshot-captured translation)
	YellInitiate1	= "Wir rufen Euch, Feuerlord!",      --needs to be verified (screenshot-captured translation)
	YellInitiate2	= "Seht seine Macht!",               --needs to be verified (screenshot-captured translation)
	YellInitiate3	= "Äschert die Ungläubigen ein!",    --needs to be verified (screenshot-captured translation)
	YellInitiate4	= "Erblicket den Ruhm der Flammen.", --needs to be verified (screenshot-captured translation)
	YellPhase2		= "Dieser Himmel ist MEIN!",         --needs to be verified (screenshot-captured translation)
	PowerLevel		= "Lodernde Macht"
})

-------------------
-- Lord Rhyolith --
-------------------
L= DBM:GetModLocalization(193)

L:SetWarningLocalization({
	WarnElementals		= "Elementare erscheinen"
})

L:SetTimerLocalization({
	TimerElementals		= "Nächste Elementare"
})

L:SetOptionLocalization({
	WarnElementals		= "Zeige Warnung, wenn Elementare erscheinen",
	TimerElementals		= "Zeige Zeit bis nächstes Erscheinen der Elementare"
})

L:SetMiscLocalization({
})

----------------
-- Beth'tilac --
----------------
L= DBM:GetModLocalization(192)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	TimerSpinners 		= "Nächste Spinner",
	TimerSpiderlings	= "Nächste Spinnerlinge",
	TimerDrone		= "Nächste Drohne"
})

L:SetOptionLocalization({
	TimerSpinners		= "Zeige Zeit bis nächste $journal:2770",
	TimerSpiderlings	= "Zeige Zeit bis nächste $journal:2778e",
	TimerDrone		= "Zeige Zeit bis nächste $journal:2773",
	RangeFrame				= "Zeige Abstandsfenster (10m)",
})

L:SetMiscLocalization({
	EmoteSpiderlings 	= "Spiderlings have been roused from their nest!" --translate
})

-------------
-- Shannox --
-------------
L= DBM:GetModLocalization(195)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SetIconOnFaceRage	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(99945),
	SetIconOnRage		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100415)
})

L:SetMiscLocalization({
	Riplimb		= "Wadenbeißer",
	Rageface	= "Augenkratzer"
})

-------------
-- Baleroc --
-------------
L= DBM:GetModLocalization(196)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	TimerBladeActive	= "%s",
	TimerBladeNext		= "Nächste Klinge"
})

L:SetOptionLocalization({
	TimerBladeActive	= "Dauer der aktiven Klinge anzeigen",
	TimerBladeNext		= "Zeige Zeit bis nächste Klinge",
	SetIconOnCountdown	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(99516),
	ArrowOnCountdown	= "Zeige DBM-Pfeil, wenn du von $spell:99516 betroffen bist",
	InfoFrame		= "Show info frame for Vital Spark stacks"
})

L:SetMiscLocalization({
	VitalSpark		= GetSpellInfo(99262).." stacks"
})


--------------------------------
-- Majordomo Fandral Staghelm --
--------------------------------
L= DBM:GetModLocalization(197)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	RangeFrameSeeds				= "Zeige Abstandsfenster (12m) für $spell:98450",
	RangeFrameCat				= "Zeige Abstandsfenster (10m) für $spell:98374",
	IconOnLeapingFlames			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100208)
})

L:SetMiscLocalization({
})

--------------
-- Ragnaros --
--------------
L= DBM:GetModLocalization(198)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	TimerPhaseSons		= "Söhne Phase endet"
})

L:SetOptionLocalization({
	TimerPhaseSons		= "Dauer der \"Söhne der Flamme Phase\" anzeigen",
	RangeFrame		= "Zeige Abstandsfenster"
})

L:SetMiscLocalization({
})

-----------------------
--  Firelands Trash  --
-----------------------
L = DBM:GetModLocalization("FirelandsTrash")

L:SetGeneralLocalization({
	name = "Trash der Feuerlande"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	RangeFrame	= "Zeige Abstandsfenster (10m) für $spell:100012"
})

L:SetMiscLocalization({
})