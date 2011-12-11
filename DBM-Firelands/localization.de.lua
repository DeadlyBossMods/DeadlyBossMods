if GetLocale() ~= "deDE" then return end
local L

---------------
-- Alysrazor --
---------------
L= DBM:GetModLocalization(194)

L:SetWarningLocalization({
	WarnPhase			= "Phase %d",
	WarnNewInitiate		= "Lodernder Kralleninitiand (%s)"
})

L:SetTimerLocalization({
	TimerPhaseChange	= "Phase %d",
	TimerHatchEggs		= "Eierausschlüpfen",
	timerNextInitiate	= "Nächster Initiand"
})

L:SetOptionLocalization({
	TimerCombatStart	= "Zeige Zeit bis zum Kampfbeginn",
	WarnPhase			= "Zeige Warnung für jeden Phasenwechsel",
	WarnNewInitiate		= "Zeige Warnung für neuen Lodernder Kralleninitiand",
	timerNextInitiate	= "Zeige Zeit bis nächster Lodernder Kralleninitiand",
	TimerPhaseChange	= "Zeige Zeit bis nächste Phase",
	TimerHatchEggs		= "Zeige Zeit bis nächstes Eierausschlüpfen",
	InfoFrame			= "Zeige Infofenster für Lodernde Macht"
})

L:SetMiscLocalization({
	YellPull		= "Ich diene jetzt einem neuen Meister, Sterbliche!",
	Initiate		= "Lodernder Kralleninitiand",--http://de.wowhead.com/npc=53896
	YellPhase2		= "Dieser Himmel ist MEIN.",
	FullPower		= "spell:99925",--This is in the emote, shouldn't need localizing, just msg:find
	LavaWorms		= "Feurige Lavawürmer brechen aus dem Boden hervor!",
	PowerLevel		= "Lodernde Macht",
	East			= "Osten",
	West			= "Westen",
	Both			= "Beide"
})

-------------------
-- Lord Rhyolith --
-------------------
L= DBM:GetModLocalization(193)

L:SetWarningLocalization({
})
	
L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	yellPhase2			= "Äonen habe ich ungestört durchgeschlafen… jetzt das… Fleischlinge, Ihr werdet BRENNEN!"
})

----------------
-- Beth'tilac --
----------------
L= DBM:GetModLocalization(192)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	RangeFrame				= "Zeige Abstandsfenster (10m)"
})

L:SetMiscLocalization({
	EmoteSpiderlings 	= "Spinnlinge sind aus ihrem Nest aufgeschreckt worden!"
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
	SetIconOnTorment	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100232),
	ArrowOnCountdown	= "Zeige DBM-Pfeil, wenn du von $spell:99516 betroffen bist",
	InfoFrame		= "Zeige Infofenster für Stapel von Lebensfunke"
})

L:SetMiscLocalization({
	VitalSpark		= GetSpellInfo(99262).." Stapel"
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
	warnSplittingBlow		= "%s in %s",--Spellname in Location
	warnEngulfingFlame		= "%s in %s",--Spellname in Location
	WarnRemainingAdds		= "Noch %d Söhne der Flamme"
})

L:SetTimerLocalization({
	TimerPhaseSons		= "Söhne Phase endet"
})

L:SetOptionLocalization({
	warnSplittingBlow	= "Zeige Warnung für $spell:100877",
	warnEngulfingFlame	= "Zeige Warnung für $spell:99171",
	WarnRemainingAdds	= "Zeige verbleibende Anzahl der Söhne der Flammen",
	TimerPhaseSons		= "Dauer der \"Söhne der Flamme Phase\" anzeigen",
	RangeFrame		= "Zeige Abstandsfenster",
	MeteorFrame			= "Zeige Infofenster für Ziele von $spell:99849",
	BlazingHeatIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100983)
})

L:SetMiscLocalization({
	East				= "Osten",
	West				= "Westen",
	Middle				= "Mitte",
	North				= "Nahkämpfer",
	South				= "Hinten",
	MeteorTargets		= "Meteore!",
	TransitionEnded1	= "Genug! Ich werde dem ein Ende machen.",
	TransitionEnded2	= "Sulfuras wird Euer Ende sein.",
	TransitionEnded3	= "Auf die Knie, Sterbliche! Das ist das Ende.",
	Defeat				= "Zu früh!… Ihr kommt zu früh...",
	Phase4				= "Too soon..."--Translate
})

-----------------------
--  Firelands Trash  --
-----------------------
L = DBM:GetModLocalization("FirelandsTrash")

L:SetGeneralLocalization({
	name = "Feuerlande Trash"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	TrashRangeFrame	= "Zeige Abstandsfenster (10) für $spell:100012"
})

L:SetMiscLocalization({

})

----------------
--  Volcanus  --
----------------
L = DBM:GetModLocalization("Volcanus")

L:SetGeneralLocalization({
	name = "Volcanus"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	timerStaffTransition	= "Übergangsphase endet"
})

L:SetOptionLocalization({
	timerStaffTransition	= "Zeige Timer für den Phasenübergang"
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

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})