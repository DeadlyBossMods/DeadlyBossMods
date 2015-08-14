-- Mini Dragon(projecteurs@gmail.com)
-- Last update: Aug 14 2015, 6:57 UTC@14333
if GetLocale() ~= "zhCN" then return end
local L

-----------------------
-- Drov the Ruiner --
-----------------------
L= DBM:GetModLocalization(1291)

-----------------------
-- Tarlna the Ageless --
-----------------------
L= DBM:GetModLocalization(1211)

--------------
-- Rukhmar --
--------------
L= DBM:GetModLocalization(1262)

-------------------------
-- Supreme Lord Kazzak --
-------------------------
L= DBM:GetModLocalization(1452)

L:SetMiscLocalization({
	Pull				= "你将面对燃烧军团的力量！" --by 图图
})