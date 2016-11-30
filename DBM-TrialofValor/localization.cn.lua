-- Mini Dragon(projecteurs@gmail.com)
-- Last update: Nov 30 2016, 3:32 UTC@15461

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
	phaseThree =	"你们的努力毫无意义，凡人!奥丁休想脱身!"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("TrialofValorTrash")

L:SetGeneralLocalization({
	name =	"勇气的试炼小怪"
})
