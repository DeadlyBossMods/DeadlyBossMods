-- Last update: 01/03/2013 (03/01/2013 in french format)
-- By Edoz (stephanelc35@msn.com)

if GetLocale() ~= "frFR" then return end
local L

-----------------------
-- Sha of Anger --
-----------------------
L= DBM:GetModLocalization(691)

L:SetOptionLocalization({
	RangeFrame			= "Afficher un cadre de distance dynamique (5m)\nbasé sur le debuff des joueurs pour $spell:119622"
})

-----------------------
-- Salyis --
-----------------------
L= DBM:GetModLocalization(725)

--------------
-- Oondasta --
--------------
L= DBM:GetModLocalization(826)

L:SetOptionLocalization({
	RangeFrame			= "Afficher le cadre de distance pour $spell:137511"
})

---------------------------
-- Nalak, The Storm Lord --
---------------------------
L= DBM:GetModLocalization(814)
