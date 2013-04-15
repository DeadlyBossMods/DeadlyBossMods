-- Simplified Chinese by Diablohu(diablohudream@gmail.com)
-- Last update: 2/4/2013

if GetLocale() ~= "zhCN" then return end
local L

----------------------
-- Theramore's Fall --
----------------------
L= DBM:GetModLocalization("d566")

---------------------------
-- Arena Of Annihilation --
---------------------------
L= DBM:GetModLocalization("d511")

--------------
-- Landfall --
--------------
L = DBM:GetModLocalization("Landfall")

L:SetWarningLocalization({
	WarnAchFiveAlive	= "成就“五号还活着”失败"
})

L:SetOptionLocalization({
	WarnAchFiveAlive	= "警报：成就“五号还活着”失败"
})