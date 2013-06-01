-- Last update: 01/19/2013 (19/01/2013 in french format)
-- By Edoz (stephanelc35@msn.com)

if GetLocale() ~= "frFR" then return end
local L

--------------------------
-- Jin'rokh the Breaker --
--------------------------
L= DBM:GetModLocalization(827)

--------------
-- Horridon --
--------------
L= DBM:GetModLocalization(819)

L:SetTimerLocalization({
	timerDoor		= "Prochaine Porte Tribale",
})

L:SetOptionLocalization({
	timerDoor		= "Afficher le temps pour la prochain phase de Porte Tribale",
})

L:SetMiscLocalization({
	newForces		= "surgissent de la porte",--Farraki forces pour from the Farraki Tribal Door!
	chargeTarget	= "fait battre sa queue"--Horridon sets his eyes on Eraeshio and stamps his tail!
})

---------------------------
-- The Council of Elders --
---------------------------
L= DBM:GetModLocalization(816)

L:SetOptionLocalization({
	RangeFrame			= "Afficher le cadre de distance"
})


------------
-- Tortos --
------------
L= DBM:GetModLocalization(825)

-------------
-- Megaera --
-------------
L= DBM:GetModLocalization(821)

------------
-- Ji-Kun --
------------
L= DBM:GetModLocalization(828)

--------------------------
-- Durumu the Forgotten --
--------------------------
L= DBM:GetModLocalization(818)

----------------
-- Primordius --
----------------
L= DBM:GetModLocalization(820)

-----------------
-- Dark Animus --
-----------------
L= DBM:GetModLocalization(824)

--------------
-- Iron Qon --
--------------
L= DBM:GetModLocalization(817)

L:SetOptionLocalization({
	RangeFrame		= "Afficher le cadre de distance dynamique\n(Un cadre de distance intelligent qui indique quand trop de joueurs sont trop proches)"
})


-------------------
-- Twin Consorts --
-------------------
L= DBM:GetModLocalization(829)

--------------
-- Lei Shen --
--------------
L= DBM:GetModLocalization(832)

------------
-- Ra-den --
------------
L= DBM:GetModLocalization(831)

