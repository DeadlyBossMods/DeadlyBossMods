if GetLocale() ~= "ruRU" then return end

local L

-----------------------
-- Sha of Anger --
-----------------------
L= DBM:GetModLocalization(691)

L:SetOptionLocalization({
	RangeFrame			= "Показывать окно проверки дистанции, основанное на статусе игроков с $spell:119622"
})

L:SetMiscLocalization({
	Pull				= "Да! Пусти в ход свою ярость! Попробуй совладать со мной!"
})

-----------------------
-- Salyis --
-----------------------
L= DBM:GetModLocalization(725)

L:SetMiscLocalization({
	Pull				= "Принесите мне их трупы!"
})

--------------
-- Oondasta --
--------------
L= DBM:GetModLocalization(826)

L:SetOptionLocalization({
	RangeFrame			= "Показывать окно проверки дистанции для $spell:137511"
})

---------------------------
-- Nalak, The Storm Lord --
---------------------------
L= DBM:GetModLocalization(814)

