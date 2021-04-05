if GetLocale() ~= "ruRU" then return end

local L

--------------------------
--  Blastenheimer 5000  --
--------------------------
L = DBM:GetModLocalization("Cannon")

L:SetGeneralLocalization({
	name = "Подрывайстер 5000"
})

-------------
--  Gnoll  --
-------------
L = DBM:GetModLocalization("Gnoll")

L:SetGeneralLocalization({
	name = "Гноллобой"
})

L:SetWarningLocalization({
	warnGameOverQuest	= "Заработано %d из %d возможных появившихся очков",
	warnGameOverNoQuest	= "Игра окончилась с всего %d возможных появившихся очков",
	warnGnoll			= "Гнолл появился",
	warnHogger			= "Хоггер появился",
	specWarnHogger		= "Хоггер появился!"
})

L:SetOptionLocalization({
	warnGameOver	= "Объявлять общее возможное число очков при завершении игры",
	warnGnoll		= "Объявлять появление Гнолла",
	warnHogger		= "Объявлять появление Хоггера",
	specWarnHogger	= "Спец-предупреждение при появлении Хоггера"
})

------------------------
--  Shooting Gallery  --
------------------------
L = DBM:GetModLocalization("Shot")

L:SetGeneralLocalization({
	name = "Тир"
})

L:SetOptionLocalization({
	SetBubbles			= "Автоматически отключать сообщения в облачках во время $spell:101871<br/>(восстанавливает их после завершения игры)"
})

----------------------
--  Tonk Challenge  --
----------------------
L = DBM:GetModLocalization("Tonks")

L:SetGeneralLocalization({
	name = "Танковые баталии"
})

-----------------------
--  Darkmoon Rabbit  --
-----------------------
L = DBM:GetModLocalization("Rabbit")

L:SetGeneralLocalization({
	name = "Кролик ярмарки Новолуния"
})

-------------------------
--  Darkmoon Moonfang  --
-------------------------
L = DBM:GetModLocalization("Moonfang")

L:SetGeneralLocalization({
	name = "Лунная волчица"
})

L:SetWarningLocalization({
	specWarnCallPack		= "Призыв стаи - Отбегите на > 40 метров от Лунной волчицы!",
	specWarnMoonfangCurse	= "Проклятие Лунной волчицы - Отбегите на > 10 метров от Лунной волчицы!"
})
