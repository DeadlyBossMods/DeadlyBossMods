if GetLocale() ~= "zhTW" then return end
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
	Pull				= "面對燃燒軍團的力量吧！"
})