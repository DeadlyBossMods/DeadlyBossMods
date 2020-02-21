if GetLocale() ~= "itIT" then return end
local L

---------------------------
--  Abyssal Commander Sivara --
---------------------------
--L= DBM:GetModLocalization(2352)

---------------------------
--  Rage of Azshara --
---------------------------
--L= DBM:GetModLocalization(2353)

---------------------------
--  Underwater Monstrosity --
---------------------------
--L= DBM:GetModLocalization(2347)

---------------------------
--  Lady Priscilla Ashvane --
---------------------------
--L= DBM:GetModLocalization(2354)

---------------------------
--  Orgozoa --
---------------------------
--L= DBM:GetModLocalization(2351)

---------------------------
--  The Queen's Court --
---------------------------
L= DBM:GetModLocalization(2359)

L:SetMiscLocalization({
	Circles =	"Cerchi tra 3s"
})

---------------------------
-- Za'qul --
---------------------------
L= DBM:GetModLocalization(2349)

L:SetMiscLocalization({
	Phase3	= "Le lacrime di Za'qul aprono la via al Reame del Delirio!",
	Tear	= "Lacrima"
})

---------------------------
--  Queen Azshara --
---------------------------
L= DBM:GetModLocalization(2361)

L:SetTimerLocalization{
	timerStageThreeBerserk		= "Furia degli Add"
}

L:SetOptionLocalization({
	SortDesc 				= "Mostra gli stack di debuff in ordine discendente nel riquadro informativo per $spell:298569 (anziché ascendente).",
	ShowTimeNotStacks		= "Usa il riquadro informativo per tempo rimanente di $spell:298569 anziché il conta-stack.",
	timerStageThreeBerserk	= "Mostra temporizzatore furia degli add nella Fase 3"
})

L:SetMiscLocalization({
	SoakOrb 			= "Entra nella Sfera",
	AvoidOrb 			= "Schiva la Sfera",
	GroupUp 			= "Raggruppati",
	Spread 				= "Spargiti",
	Move				= "Muoviti",
	DontMove 			= "Fermati",
	--For Yells
	HelpSoakMove		= "{rt3}HELP SOAK MOVE{rt3}", -- Purple Diamond
	HelpSoakStay		= "{rt6}HELP SOAK STAY{rt6}", -- Blue Square
	HelpSoak			= "{rt3}HELP SOAK{rt3}", -- Purple Diamond
	HelpMove			= "{rt4}HELP MOVE{rt4}", -- Green Triangle
	HelpStay			= "{rt7}HELP STAY{rt7}", -- Red X
	SoloSoak 			= "SOLO SOAK",
	Solo 				= "SOLO",
	--Not currently used Yells
	SoloMoving			= "SOLO MOVE",
	SoloStay			= "SOLO STAY",
	SoloSoakMove		= "SOLO SOAK MOVE",
	SoloSoakStay		= "SOLO SOAK STAY"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("EternalPalaceTrash")

L:SetGeneralLocalization({
	name =	"Scartini Palazzo Eterno"
})

