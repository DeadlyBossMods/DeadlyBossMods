if GetLocale() ~= "deDE" then return end
local L

------------------------
--  Conclave of Wind  --
------------------------
--L = DBM:GetModLocalization(154)
L = DBM:GetModLocalization("Conclave")

L:SetGeneralLocalization({
	name = "Konklave des Windes"
})

L:SetWarningLocalization({
	warnSpecial			= "Hurrikan/Zephyr/Graupelsturm aktiv",
	specWarnSpecial		= "Spezialfähigkeiten aktiv!",
	warnSpecialSoon		= "Spezialfähigkeiten in 10 Sekunden!"
})

L:SetTimerLocalization({
	timerSpecial		= "Spezialfähigkeiten CD",
	timerSpecialActive	= "Spezialfähigkeiten aktiv"
})

L:SetOptionLocalization({
	warnSpecial			= "Zeige Warnung, wenn Hurrikan/Zephyr/Graupelsturm gewirkt werden",
	specWarnSpecial		= "Zeige Spezialwarnung, wenn Spezialfähigkeiten gewirkt werden",
	timerSpecial		= "Zeige Abklingzeit für Spezialfähigkeiten",
	timerSpecialActive	= "Dauer der Spezialfähigkeiten anzeigen",
	warnSpecialSoon		= "Zeige Vorwarnung 10 Sekunden vor den Spezialfähigkeiten",
	OnlyWarnforMyTarget	= "Zeige Warnungen und Timer nur für aktuelles Ziel und Fokusziel\n(Versteckt den Rest. Dies beinhaltet den PULL!)"
})

L:SetMiscLocalization({
	gatherstrength	= "%s beinnt von den verbliebenen Windlords Stärke zu beziehen!", --yes the typo is from the logfiles (4.06a) "<356.9> RAID_BOSS_EMOTE#%s beinnt von den verbliebenen Windlords Stärke zu beziehen!#Rohash#####0#0##0#1616##0#false#false", -- [6]
	Anshal			= "Anshal",
	Nezir			= "Nezir",
	Rohash			= "Rohash"
})

---------------
--  Al'Akir  --
---------------
--L = DBM:GetModLocalization(155)
L = DBM:GetModLocalization("AlAkir")

L:SetGeneralLocalization({
	name = "Al'Akir"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	TimerFeedback 	= "Rückkopplung (%d)",
})

L:SetOptionLocalization({
	LightningRodIcon= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(89668),
	TimerFeedback	= "Dauer von $spell:87904 anzeigen",
	RangeFrame		= "Zeige Abstandsfenster (20m), wenn du von $spell:89668 betroffen bist"
})

L:SetMiscLocalization({
})
