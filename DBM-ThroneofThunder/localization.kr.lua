if GetLocale() ~= "koKR" then return end
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
	timerAddsCD		= "추가병력 가능",
})

L:SetOptionLocalization({
	timerAddsCD		= "추가병력 대기시간 바 표시",
})

L:SetMiscLocalization({
	newForces		= "forces pour from the",--Farraki forces pour from the Farraki Tribal Door!
	chargeTarget	= "stamps his tail!"--Horridon sets his eyes on Eraeshio and stamps his tail!
})

---------------------------
-- The Council of Elders --
---------------------------
L= DBM:GetModLocalization(816)

L:SetOptionLocalization({
	warnSandBolt	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target:format(136189),
	RangeFrame		= "거리 창 보기"
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

