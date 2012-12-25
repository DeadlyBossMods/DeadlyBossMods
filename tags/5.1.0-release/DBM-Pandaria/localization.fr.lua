-- Last update: 12/17/2012 (17/12/2012 in french format)
-- By Edoz (stephanelc35@msn.com)

if GetLocale() ~= "frFR" then return end
local L

-----------------------
-- Sha of Anger --
-----------------------
L= DBM:GetModLocalization(691)

L:SetOptionLocalization({
	RangeFrame			= "Afficher un cadre de distance dynamique (5m)\nbasé sur le debuff des joueurs pour $spell:119622",
	SetIconOnMC			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(119622)
})

-----------------------
-- Salyis --
-----------------------
L= DBM:GetModLocalization(725)
