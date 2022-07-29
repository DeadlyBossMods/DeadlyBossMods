if GetLocale() ~= "koKR" then return end
local L

-----------------------
-- <<< M+ Affixes >>> --
-----------------------
L = DBM:GetModLocalization("MPlusAffixes")

L:SetGeneralLocalization({
	name =	"신화+ 어픽스"
})

-----------------------
-- <<< Fated Raid Affixes >>> --
-----------------------
L = DBM:GetModLocalization("FatedAffixes")

L:SetGeneralLocalization({
	name =	"운명의 공격대 어픽스"
})
