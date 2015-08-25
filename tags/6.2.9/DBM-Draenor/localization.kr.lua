if GetLocale() ~= "koKR" then return end
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
	Pull				= "불타는 군단의 압도적인 힘을 느껴라!"
})