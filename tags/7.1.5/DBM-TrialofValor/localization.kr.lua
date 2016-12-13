if GetLocale() ~= "koKR" then return end
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
	OrbsTimerText		= "다음 구슬 (%d-%s)"
})

L:SetMiscLocalization({
	phaseThree =	"발버둥쳐 봐야 소용 없다, 필멸자여! 오딘은 풀려나지 않아!",
	near =			"가까운",
	far =			"먼",
	multiple =		"양쪽"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("TrialofValorTrash")

L:SetGeneralLocalization({
	name =	"용맹의 시험 일반몹"
})

