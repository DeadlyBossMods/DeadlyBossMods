if GetLocale() ~= "deDE" then return end
local L

---------------
-- Alysrazor --
---------------
L = DBM:GetModLocalization("Alysrazor")

L:SetGeneralLocalization({
	name = "Alysrazar"
})

L:SetWarningLocalization({
	WarnPhase		= "Phase %d"
})

L:SetTimerLocalization({
	TimerPhaseChange	= "Phase %d",
	TimerHatchEggs		= "Eierausschlüpfen"
})

L:SetOptionLocalization({
	WarnPhase		= "Zeige Warnung für jeden Phasenwechsel",
	TimerPhaseChange	= "Zeige Timer für nächste Phase",
	TimerHatchEggs		= "Zeige Timer für nächstes Eierausschlüpfen",
	InfoFrame		= "Zeige Infofenster für Blazing Power" --translate 'Blazing Power' later
})

L:SetMiscLocalization({
	YellPull		= "I serve a new master now, mortals!", --translate
	YellPhase2		= "These skies are MINE!", --translate
	PowerLevel		= "Blazing Power" --translate
})

-------------------
-- Lord Rhyolith --
-------------------
L = DBM:GetModLocalization("Rhyolith")

L:SetGeneralLocalization({
	name = "Lord Rhyolith"
})

L:SetWarningLocalization({
	WarnElementals		= "Elementare spawnen"
})

L:SetTimerLocalization({
	TimerElementals		= "Nächste Elementare"
})

L:SetOptionLocalization({
	WarnElementals		= "Zeige Warnung, wenn Elementare spawnen",
	TimerElementals		= "Zeige Timer für nächstes Spawnen der Elementare"
})

L:SetMiscLocalization({
})

----------------
-- Beth'tilac --
----------------
L = DBM:GetModLocalization("Bethtilac")

L:SetGeneralLocalization({
	name = "Beth'tilac"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	TimerSpinners 		= "Nächste Spinner",
	TimerSpiderlings	= "Nächste Spinnerlinge",
	TimerDrone		= "Nächste Drohne"
})

L:SetOptionLocalization({
	TimerSpinners		= "Zeige Timer für nächste Aschenweberspinner",
	TimerSpiderlings	= "Zeige Timer für nächste Aschenweberspinnlinge",
	TimerDrone		= "Zeige Timer für nächste Aschenweberdrohne"
})

L:SetMiscLocalization({
	EmoteSpiderlings 	= "Spiderlings have been roused from their nest!" --translate
})

-------------
-- Shannox --
-------------
L = DBM:GetModLocalization("Shannox")

L:SetGeneralLocalization({
	name = "Shannox"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

-------------
-- Baleroc --
-------------
L = DBM:GetModLocalization("Baleroc")

L:SetGeneralLocalization({
	name = "Baloroc"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

--------------------------------
-- Majordomo Fandral Staghelm --
--------------------------------
L = DBM:GetModLocalization("FandralStaghelm")

L:SetGeneralLocalization({
	name = "Majordomus Hirschhaupt"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

--------------
-- Ragnaros --
--------------
L = DBM:GetModLocalization("Ragnaros-Cata")

L:SetGeneralLocalization({
	name = "Ragnaros' Ende" -- Temp name (see localization.en); No conflict with MC version 
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})