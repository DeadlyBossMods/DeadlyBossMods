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

L:SetMiscLocalization({
	Pull				= "I see the weakness in your soul!"--translate (trigger)
})

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

L:SetMiscLocalization({
	Pull				= "New playthings? How irresistible!"--translate (trigger)
})

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

L:SetMiscLocalization({
	Pull				= "All worlds will burn in felfire!"--translate (trigger)
})
