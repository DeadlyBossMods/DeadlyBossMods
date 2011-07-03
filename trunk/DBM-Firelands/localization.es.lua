if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

---------------
-- Alysrazor --
---------------
L= DBM:GetModLocalization(194)

L:SetWarningLocalization({
	WarnPhase		= "Fase %d",
	WarnNewInitiate		= "Iniciado de Garfas Llameantes (%d)"
})

L:SetTimerLocalization({
	TimerPhaseChange	= "Fase %d",
	TimerHatchEggs		= "Eclosión de huevos",
	timerNextInitiate	= "Siguiente Iniciado"
})

L:SetOptionLocalization({
	WarnPhase		= "Mostrar un aviso para cada cambio de fase",
	WarnNewInitiate		= "Mostrar aviso para nuevo Iniciado de Garfas Llameantes",
	timerNextInitiate	= "Mostrar tiempo para siguiente Iniciado de Garfas Llameantes",
	TimerPhaseChange	= "Mostrar tiempo para siguiente fase",
	TimerHatchEggs		= "Mostrar tiempo hasta que los huevos eclosionen",
	InfoFrame		= "Mostrar información para Poder Llameante"
})

L:SetMiscLocalization({
	YellPull		= "I serve a new master now, mortals!",--translate
	YellInitiate1	= "We call upon you, Firelord!",--translate
	YellInitiate2	= "Behold His power!",--translate
	YellInitiate3	= "Let the unbelievers perish in fire!",--translate
	YellInitiate4	= "Witness the majesty of flame!",--translate
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
	TimerSpinners 		= "Siguientes hiladoras",
	TimerSpiderlings	= "Siguientes arañitas",
	TimerDrone		= "Siguiente zángano"
})

L:SetOptionLocalization({
	TimerSpinners		= "Mostrar tiempo para siguientes $journal:2770",
	TimerSpiderlings	= "Mostrar tiempo para siguientes $journal:2778",
	TimerDrone		= "Mostrar tiempo para siguiente $journal:2773",
	RangeFrame				= "Mostrar distancia (10)",
})

L:SetMiscLocalization({
	EmoteSpiderlings 	= "¡Las arañitas emergen de su nido!"
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
	Riplimb		= "Desmembrador",
	Rageface	= "Rostrofuria"
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
	RangeFrameSeeds				= "Mostrar distancia (12) para $spell:98450",
	RangeFrameCat				= "Mostrar distancia (10) para $spell:98374"
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
	TimerPhaseSons		= "Fase de Hijos termina"
})

L:SetOptionLocalization({
	TimerPhaseSons		= "Mostrar tiempo de duración para la fase de \"Hijos de la Llama\"",
	RangeFrame		= "Mostrar distancia"
})

L:SetMiscLocalization({
})

-----------------------
--  Firelands Trash  --
-----------------------
L = DBM:GetModLocalization("FirelandsTrash")

L:SetGeneralLocalization({
	name = "Trash de las Tierras del Fuego"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	RangeFrame	= "Mostrar distancia (10) para $spell:100012",
	BlazingHeatIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100983)
})

L:SetMiscLocalization({
})
