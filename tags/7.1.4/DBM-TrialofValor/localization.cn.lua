-- Mini Dragon(projecteurs@gmail.com)
-- Last update: Nov 1 2016, 6:03 UTC@15435

if GetLocale() ~= "zhCN" then return end
local L
---------------
-- Odyn --
---------------
L= DBM:GetModLocalization(1819)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

---------------------------
-- Guarm --
---------------------------
L= DBM:GetModLocalization(1830)

---------------------------
-- Helya --
---------------------------
L= DBM:GetModLocalization(1829)

L:SetMiscLocalization({
	phaseThree =	"Your efforts are for naught, mortals! Odyn will NEVER be free!", --pending
	near =			"近",
	far =			"远",
	multiple =		"多"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("TrialofValorTrash")

L:SetGeneralLocalization({
	name =	"勇气的试炼小怪"
})
