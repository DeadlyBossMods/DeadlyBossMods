if GetLocale() ~= "zhTW" then return end
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
	phaseThree =	"Your efforts are for naught, mortals! Odyn will NEVER be free!"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("TrialofValorTrash")

L:SetGeneralLocalization({
	name =	"勇氣試煉小怪"
})
