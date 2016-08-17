if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

-------------------------
-- Drov the Arruinador --
-------------------------
L= DBM:GetModLocalization(1291)

----------------------
-- Tarlna el Eterno --
----------------------
L= DBM:GetModLocalization(1211)

--------------
-- Rukhmar --
--------------
L= DBM:GetModLocalization(1262)

--------------------------
-- Señor supremo Kazzak --
--------------------------
L= DBM:GetModLocalization(1452)

L:SetMiscLocalization({
	Pull				= "¡Os enfrentáis al poder de la Legión Ardiente!"
})