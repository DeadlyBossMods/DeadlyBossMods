if GetLocale() ~= "deDE" then return end
local L

-----------------------
-- Inquisitor Meto --
-----------------------
L= DBM:GetModLocalization(2012)

L:SetMiscLocalization({
	Pull				= "Your fate is only death!"--translate (trigger)
})

-----------------------
-- Occularus --
-----------------------
L= DBM:GetModLocalization(2013)

-----------------------
-- Sotanathor --
-----------------------
L= DBM:GetModLocalization(2014)

L:SetMiscLocalization({
	Pull				= "Come, small ones. Die by my hand!"--translate (trigger)
})

-----------------------
-- Mistress Alluradel --
-----------------------
L= DBM:GetModLocalization(2011)

-----------------------
-- Matron Folnuna --
-----------------------
L= DBM:GetModLocalization(2010)

L:SetMiscLocalization({
	Pull				= "Yes... come closer, little ones!"--translate (trigger)
})

-----------------------
-- Pit Lord Vilemus --
-----------------------
L= DBM:GetModLocalization(2015)
