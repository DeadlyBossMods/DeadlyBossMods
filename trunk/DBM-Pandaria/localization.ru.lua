if GetLocale() ~= "ruRU" then return end

local L

-----------------------
-- Sha of Anger --
-----------------------
L= DBM:GetModLocalization(691)

L:SetOptionLocalization({
	RangeFrame			= "Показывать динамическое окно проверки дистанции, основанное\nна статусе игроков с дебаффом $spell:119622",
	ReadyCheck			= "Проигрывать звук проверки готовности когда пулят мирового босса (даже если он не является целью)"
})

L:SetMiscLocalization({
	Pull				= "Да… да! Дайте волю своей ярости! Попробуйте меня убить!"
})

-----------------------
-- Salyis --
-----------------------
L= DBM:GetModLocalization(725)

L:SetOptionLocalization({
	ReadyCheck			= "Проигрывать звук проверки готовности когда пулят мирового босса (даже если он не является целью)"
})

L:SetMiscLocalization({
	Pull				= "Принесите мне их трупы!"
})

--------------
-- Oondasta --
--------------
L= DBM:GetModLocalization(826)

L:SetOptionLocalization({
	ReadyCheck			= "Проигрывать звук проверки готовности когда пулят мирового босса (даже если он не является целью)"
})

L:SetMiscLocalization({
	Pull				= "Как вы смеете вмешиваться в наши планы! На этот раз зандаларов не остановить!"
})

---------------------------
-- Nalak, The Storm Lord --
---------------------------
L= DBM:GetModLocalization(814)

L:SetOptionLocalization({
	ReadyCheck			= "Проигрывать звук проверки готовности когда пулят мирового босса (даже если он не является целью)"
})

L:SetMiscLocalization({
	Pull				= "Чувствуете порывы холодного ветра? Приближается буря…"
})

---------------------------
-- Chi-ji, The Red Crane --
---------------------------
L= DBM:GetModLocalization(857)

L:SetOptionLocalization({
	BeaconArrow				= "Показывать стрелку DBM когда на ком-то $spell:144473"
})

------------------------------
-- Yu'lon, The Jade Serpent --
------------------------------
L= DBM:GetModLocalization(858)

--------------------------
-- Niuzao, The Black Ox --
--------------------------
L= DBM:GetModLocalization(859)

---------------------------
-- Xuen, The White Tiger --
---------------------------
L= DBM:GetModLocalization(860)

------------------------------------
-- Ordos, Fire-God of the Yaungol --
------------------------------------
L= DBM:GetModLocalization(861)
