-- Simplified Chinese by Diablohu(diablohudream@gmail.com)
-- Last update: 1/4/2013

if GetLocale() ~= "zhCN" then return end
local L

-----------------------
-- Sha of Anger --
-----------------------
L= DBM:GetModLocalization(691)

L:SetOptionLocalization({
	RangeFrame			= "距离监视（动态）：$spell:119622",
	SetIconOnMC			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(119622)
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
	RangeFrame			= "距离监视：$spell:137511"
})

---------------------------
-- Nalak, The Storm Lord --
---------------------------
L= DBM:GetModLocalization(814)