if GetLocale() ~= "deDE" then return end
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
	phaseThree =	"Your efforts are for naught, mortals! Odyn will NEVER be free!",
	near =			"in der Nähe von",
	far =			"weit",
	multiple =		"Mehrere"
})
