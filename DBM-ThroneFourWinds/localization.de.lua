if GetLocale() ~= "deDE" then return end
local L

------------------------
--  Conclave of Wind  --
------------------------
L = DBM:GetModLocalization("Conclave")

L:SetGeneralLocalization({
	name = "Konklave des Windes"
})

L:SetWarningLocalization({
	warnSpecial			= "Hurrikan/Zephyr/Graupelsturm aktiv",
	specWarnSpecial		= "Spezialfähigkeiten aktiv!"
})

L:SetTimerLocalization({
	timerSpecial			= "Spezialfähigkeiten CD",
	timerSpecialActive		= "Spezialfähigkeiten aktiv"
})

L:SetMiscLocalization({
	gatherstrength			= "%s beinnt von den verbliebenen Windlords Stärke zu beziehen!" --yes the typo is from the logfiles (4.06a) "<356.9> CHAT_MSG_RAID_BOSS_EMOTE#%s beinnt von den verbliebenen Windlords Stärke zu beziehen!#Rohash#####0#0##0#1616##0#false#false", -- [6]
})

L:SetOptionLocalization({
	warnSpecial			= "Zeige Warnung, wenn Hurrikan/Zephyr/Graupelsturm gewirkt werden",
	specWarnSpecial		= "Zeige Spezialwarnung, wenn Spezialfähigkeiten gewirkt werden",
	timerSpecial		= "Zeige Timer für Spezialfähigkeiten CD",
	timerSpecialActive	= "Zeige Timer für die Dauer der Spezialfähigkeiten"
})

---------------
--  Al'Akir  --
---------------
L = DBM:GetModLocalization("AlAkir")

L:SetGeneralLocalization({
	name = "Al'Akir"
})

L:SetWarningLocalization({
	WarnFeedback	= "%s auf >%s< (%d)",
	WarnAdd			= "Sturmling gespawned" --check name
})

L:SetTimerLocalization({
	TimerFeedback 	= "Rückkopplung (%d)", --translate
	TimerAddCD		= "Nächstes Add"
})

L:SetOptionLocalization({
	WarnFeedback	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(87904, GetSpellInfo(87904) or "unknown"),
	LightningRodIcon= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(89668),
	TimerFeedback	= "Zeige Timer für die Dauer von $spell:87904",
	WarnAdd			= "Zeige Warnung, wenn ein Sturmling spawned", -- check name
	TimerAddCD		= "Zeige Timer für neues Add"

})

L:SetMiscLocalization({
	summonSquall	=	"Storms! I summon you to my side!", --translate
--	phase2		=	"Your futile persistance angers me!",--Not used, Acid rain is, but just in case there is reliability issues with that, localize this anyways. -- translate
	phase3		=	"Enough! I will no longer be contained!" --translate
})

