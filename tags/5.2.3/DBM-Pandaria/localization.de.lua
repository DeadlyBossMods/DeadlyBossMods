if GetLocale() ~= "deDE" then return end
local L

-----------------------
-- Sha of Anger --
-----------------------
L= DBM:GetModLocalization(691)

L:SetOptionLocalization({
	RangeFrame			= "Zeige dynamisches Abstandsfenster (5m) basierend auf Spieler-Debuffs für\n$spell:119622"
})

L:SetMiscLocalization({
	Pull				= "Ja... JA! Nutzt Eure Wut aus! Streckt mich nieder!"
})

-----------------------
-- Salyis --
-----------------------
L= DBM:GetModLocalization(725)

L:SetMiscLocalization({
	Pull				= "Bringt mir ihre Leichen!"
})

--------------
-- Oondasta --
--------------
L= DBM:GetModLocalization(826)

L:SetOptionLocalization({
	RangeFrame			= "Zeige Abstandsfenster für $spell:137511"
})

L:SetMiscLocalization({
	Pull				= "How dare you interrupt our preparations! The Zandalari will not be stopped, not this time!"--translate (trigger)
})

---------------------------
-- Nalak, The Storm Lord --
---------------------------
L= DBM:GetModLocalization(814)

L:SetOptionLocalization({
	RangeFrame			= "Zeige Abstandsfenster (10m) für $spell:136340"
})
