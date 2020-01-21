if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

---------------------------
--  Abyssal Commander Sivara --
---------------------------
L= DBM:GetModLocalization(2352)

---------------------------
--  Rage of Azshara --
---------------------------
L= DBM:GetModLocalization(2353)

---------------------------
--  Underwater Monstrosity --
---------------------------
L= DBM:GetModLocalization(2347)

---------------------------
--  Lady Priscilla Ashvane --
---------------------------
L= DBM:GetModLocalization(2354)

L:SetWarningLocalization({

})

L:SetTimerLocalization({

})

L:SetOptionLocalization({

})

L:SetMiscLocalization({
})

---------------------------
--  Orgozoa --
---------------------------
L= DBM:GetModLocalization(2351)

---------------------------
--  The Queen's Court --
---------------------------
L= DBM:GetModLocalization(2359)

L:SetMiscLocalization({
	Circles =	"Círculos en 3 segundos"
})

---------------------------
-- Za'qul --
---------------------------
L= DBM:GetModLocalization(2349)

L:SetMiscLocalization({
	Phase3	= "¡Za'qul abre el camino hacia el reino del delirio!",
	Tear	= "Rasgadura"
})

---------------------------
--  Queen Azshara --
---------------------------
L= DBM:GetModLocalization(2361)

L:SetTimerLocalization{
	timerStageThreeBerserk		= "Rabia de esbirros"
}

L:SetOptionLocalization({
	SortDesc 				= "Ordenar el marco de información de $spell:298569 de mayor a menor cantidad de acumulaciones (en lugar de de menor a mayor)",
	ShowTimeNotStacks		= "Mostrar el tiempo restante de $spell:298569 en el marco de información en lugar de la cantidad de acumulaciones",
	timerStageThreeBerserk	= "Mostrar temporizador para la Rabia de los esbirros de Fase 3"
})

L:SetMiscLocalization({
	SoakOrb 			= "Absorbe un orbe",
	AvoidOrb 			= "Evita absorber orbes",
	GroupUp 			= "En grupo",
	Spread 				= "Separado",
	Move				= "No dejes de moverte",
	DontMove 			= "No te muevas",
	--For Yells
	HelpSoakMove		= "{rt3}ORBE EN GRUPO - CORRER{rt3}",--Purple Diamond
	HelpSoakStay		= "{rt6}ORBE EN GRUPO - QUIETO{rt6}",--Blue Square
	HelpSoak			= "{rt3}ORBE EN GRUPO{rt3}",--Purple Diamond
	HelpMove			= "{rt4}CORRER EN GRUPO{rt4}",--Green Triangle
	HelpStay			= "{rt7}QUIETO EN GRUPO{rt7}",--Red X
	SoloSoak 			= "ORBE SOLO",
	Solo 				= "SOLO",
	--Not currently used Yells
	SoloMoving			= "CORRER SOLO",
	SoloStay			= "QUIETO SOLO",
	SoloSoakMove		= "ORBE SOLO - CORRER",
	SoloSoakStay		= "ORBE SOLO - QUIETO"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("EternalPalaceTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})

