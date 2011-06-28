if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

---------------
-- Alysrazor --
---------------
L= DBM:GetModLocalization(194)

L:SetWarningLocalization({
	WarnPhase		= "Fase %d"
})

L:SetTimerLocalization({
	TimerPhaseChange	= "Fase %d",
	TimerHatchEggs		= "Eclosión de huevos"
})

L:SetOptionLocalization({
	WarnPhase		= "Mostrar un aviso para cada cambio de fase",
	TimerPhaseChange	= "Mostrar tiempo para siguiente fasee",
	TimerHatchEggs		= "Mostrar tiempo hasta que los huevos eclosionen",
	InfoFrame		= "Mostrar información para Poder Llameante"
})

L:SetMiscLocalization({
	YellPull		= "I serve a new master now, mortals!",--translate
	YellPhase2		= "These skies are MINE!",--translate
	PowerLevel		= "Poder Llameante"
})

-------------------
-- Lord Rhyolith --
-------------------
L= DBM:GetModLocalization(193)

L:SetWarningLocalization({
	WarnElementals		= "Salen Elementales"
})

L:SetTimerLocalization({
	TimerElementals		= "Siguientes Elementales"
})

L:SetOptionLocalization({
	WarnElementals		= "Mostrar aviso cuando salgan los elementales",
	TimerElementals		= "Mostrar tiempo restante para que salgan elementales"
})

L:SetMiscLocalization({
})

-----------------
-- Beth'tilac --
-----------------
L= DBM:GetModLocalization(192)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	TimerSpinners 		= "Siguiente Hiladoras",
	TimerSpiderlings	= "Siguientes Arañitas",
	TimerDrone		= "Siguiente Zánganos"
})

L:SetOptionLocalization({
	TimerSpinners		= "Mostrar tiempo para siguientes $journal:2770",
	TimerSpiderlings	= "Mostrar tiempo para siguientes $journal:2778",
	TimerDrone		= "Mostrar tiempo para siguientes $journal:2773"
})

L:SetMiscLocalization({
	EmoteSpiderlings 	= "Spiderlings have been roused from their nest!"--translate
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
})

-------------
-- Baleroc --
-------------
L= DBM:GetModLocalization(196)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	TimerBladeActive	= "%s",
	TimerBladeNext		= "Siguiente Hoja"
})

L:SetOptionLocalization({
	TimerBladeActive	= "Mostrar tiempo de duración de la hoja activa",
	TimerBladeNext		= "Mostrar tiempo para la siguiente hoja",
	SetIconOnCountdown	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(99516),
	ArrowOnCountdown	= "Mostrar flecha cuando te afecte $spell:99516 "
})

L:SetMiscLocalization({
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
	TimerPhaseSons		= "Fase de hijos termina"
})

L:SetOptionLocalization({
	TimerPhaseSons		= "Mostrar tiempo de duración para la fase de \"Hijos de la Llama\"",
	RangeFrame		= "Mostrar distancia"
})

L:SetMiscLocalization({
})