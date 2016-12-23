-- Mini Dragon(projecteurs@gmail.com)
-- Last update: Dec 22 2016, 4:21 UTC@15592

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
	phaseThree =	"你们的努力毫无意义，凡人!奥丁休想脱身!",
	near			= "近",
	far				= "远",
	multiple		= "多个"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("TrialofValorTrash")

L:SetGeneralLocalization({
	name =	"勇气的试炼小怪"
})
