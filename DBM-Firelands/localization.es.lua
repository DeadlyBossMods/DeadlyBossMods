if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

---------------
-- Alysrazor --
---------------
L= DBM:GetModLocalization(194)

L:SetWarningLocalization({
	WarnPhase		= "Fase %d",
	WarnNewInitiate		= "Iniciado de Garfas Llameantes (%s)"
})

L:SetTimerLocalization({
	TimerPhaseChange	= "Fase %d",
	TimerHatchEggs		= "Siguientes huevos",
	timerNextInitiate	= "Siguiente Iniciado",
	TimerCombatStart	= "Empieza el combate"
})

L:SetOptionLocalization({
	TimerCombatStart	= "Mostrar tiempo para el inicio del combate",
	WarnPhase		= "Mostrar un aviso para cada cambio de fase",
	WarnNewInitiate		= "Mostrar aviso para nuevo Iniciado de Garfas Llameantes",
	timerNextInitiate	= "Mostrar tiempo para siguiente Iniciado de Garfas Llameantes",
	TimerPhaseChange	= "Mostrar tiempo para siguiente fase",
	TimerHatchEggs		= "Mostrar tiempo hasta que los huevos eclosionen",
	InfoFrame		= "Mostrar información para Pluma de arrabio"
})

L:SetMiscLocalization({
	YellPull		= "¡Mortales, ahora sirvo a un nuevo amo!",
	YellInitiate1	= "¡Te invocamos, Señor del Fuego!",
	YellInitiate2	= "¡Contemplad su poder!",
	YellInitiate3	= "¡Que los infieles perezcan en el fuego!",
	YellInitiate4	= "Presenciad la majestuosidad de la llama.",
	YellPhase2		= "¡Estos cielos son MÍOS!",
	FullPower		= "spell:99925",
	LavaWorms		= "¡Gusanos de lava ígneos surgen del suelo!",
	PowerLevel		= "Pluma de arrabio",
	East			= "Este",
	West			= "Oeste",
	Both			= "Ambos"
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
	yellPhase2			= "Eons I have slept undisturbed... Now this... Creatures of flesh, now you will BURN!"--translate
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
	SetIconOnTorment	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100232),
	ArrowOnCountdown	= "Mostrar flecha cuando te afecte $spell:99516 ",
	InfoFrame		= "Mostrar información de las marcas de Chispa vital"
})

L:SetMiscLocalization({
	VitalSpark		= "Marcas de "..GetSpellInfo(99262)
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
	RangeFrameCat				= "Mostrar distancia (10) para $spell:98374",
	IconOnLeapingFlames			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100208)
})

L:SetMiscLocalization({
})

--------------
-- Ragnaros --
--------------
L= DBM:GetModLocalization(198)

L:SetWarningLocalization({
	warnSplittingBlow		= "%s en %s",
	warnEngulfingFlame		= "%s en %s"
})

L:SetTimerLocalization({
	TimerPhaseSons		= "Transición termina"
})

L:SetOptionLocalization({
	warnSplittingBlow	= "Mostrar aviso para $spell:100877",
	warnEngulfingFlame	= "Mostrar aviso para $spell:99171",
	TimerPhaseSons		= "Mostrar tiempo de duración para la fase de \"Hijos de la Llama\"",
	RangeFrame		= "Mostrar distancia",
	InfoFrame			= "Mostrar información de los objetivos de $spell:99849",
	BlazingHeatIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100983)
})

L:SetMiscLocalization({
	East				= "Este",
	West				= "Oeste",
	Middle				= "Medio",
	North				= "Melee",
	South				= "Atrás",
	MeteorTargets		= "HOYGA METEHORITOS!",
	transitionended		= "Enough! I will finish this.",--translate
	Defeat				= "Too soon! ... You have come too soon..."--translate

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
	timerStaffTransition	= "Transition ends"--translate
})

L:SetOptionLocalization({
	timerStaffTransition	= "Show a timer for the phase transition"--translate
})

L:SetMiscLocalization({
	StaffEvent			= "The Branch of Nordrassil reacts violently",--translate
	StaffTrees			= "Burning Treants erupt from the ground to aid the Protector!",--translate
	StaffTransition		= "The fires consuming the Tormented Protector wink out!"--translate
})