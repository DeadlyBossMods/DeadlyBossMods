if GetLocale() ~= "zhTW" then return end
local L

---------------
-- Odyn --
---------------
L= DBM:GetModLocalization(1819)

---------------------------
-- Guarm --
---------------------------
L= DBM:GetModLocalization(1830)

---------------------------
-- Helya --
---------------------------
L= DBM:GetModLocalization(1829)

L:SetTimerLocalization({
	OrbsTimerText		= "下一個球(%d-%s)"
})

L:SetMiscLocalization({
	phaseThree =	"凡人，你們根本白費工夫！歐丁永遠別想自由！",
	near =			"近",
	far =			"遠",
	multiple =		"多"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("TrialofValorTrash")

L:SetGeneralLocalization({
	name =	"勇氣試煉小怪"
})
