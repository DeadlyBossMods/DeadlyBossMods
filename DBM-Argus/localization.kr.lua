if GetLocale() ~= "koKR" then return end
local L

-----------------------
-- Inquisitor Meto --
-----------------------
L= DBM:GetModLocalization(2012)

-----------------------
-- Occularus --
-----------------------
L= DBM:GetModLocalization(2013)

-----------------------
-- Sotanathor --
-----------------------
L= DBM:GetModLocalization(2014)

-----------------------
-- Mistress Alluradel --
-----------------------
L= DBM:GetModLocalization(2011)

-----------------------
-- Matron Folnuna --
-----------------------
L= DBM:GetModLocalization(2010)

L:SetMiscLocalization({
	Pull				= "그래... 가까이 오거라, 귀여운 것들!"
})

-----------------------
-- Pit Lord Vilemus --
-----------------------
L= DBM:GetModLocalization(2015)
