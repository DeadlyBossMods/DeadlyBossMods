if GetLocale() ~= "deDE" then return end
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
	timerAddsCD		= "Nächste Tribal Door",--translate
})

L:SetOptionLocalization({
	timerAddsCD		= "Zeige Zeit bis nächste Tribal Door Phase",--translate
})

L:SetMiscLocalization({
	newForces		= "forces pour from the",--translate (trigger) Farraki forces pour from the Farraki Tribal Door!
	chargeTarget	= "stamps his tail!"--translate (trigger) Horridon sets his eyes on Eraeshio and stamps his tail!
})

---------------------------
-- The Council of Elders --
---------------------------
L= DBM:GetModLocalization(816)

L:SetOptionLocalization({
	warnSandBolt	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target:format(136189),
	RangeFrame		= "Zeige Abstandsfenster"
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
	RangeFrame		= "Zeige dynamisches Abstandsfenster\n(mit Indikator für zuviele Spieler in Reichweite)"
})

-------------------
-- Twin Consorts --
-------------------
L= DBM:GetModLocalization(829)

--------------
-- Lei Shen --
--------------
L= DBM:GetModLocalization(832)

L:SetOptionLocalization({
	RangeFrame		= "Zeige Abstandsfenster"--For two different spells
})

------------
-- Ra-den --
------------
L= DBM:GetModLocalization(831)

