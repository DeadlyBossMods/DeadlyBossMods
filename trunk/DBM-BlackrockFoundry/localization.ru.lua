if GetLocale() ~= "ruRU" then return end
local L

---------------
-- Gruul --
---------------
L= DBM:GetModLocalization(1161)

---------------------------
-- Oregorger, The Devourer --
---------------------------
L= DBM:GetModLocalization(1202)

---------------------------
-- The Blast Furnace --
---------------------------
L= DBM:GetModLocalization(1154)

------------------
-- Hans'gar And Franzok --
------------------
L= DBM:GetModLocalization(1155)

--------------
-- Flamebender Ka'graz --
--------------
L= DBM:GetModLocalization(1123)

L:SetMiscLocalization({
	return1		= "Wait till they get a load of me."--Not used yet but just in case my current hack to avoid localizing doesn't work
})

--------------------
--Kromog, Legend of the Mountain --
--------------------
L= DBM:GetModLocalization(1162)

--------------------------
-- Beastlord Darmac --
--------------------------
L= DBM:GetModLocalization(1122)

--------------------------
-- Operator Thogar --
--------------------------
L= DBM:GetModLocalization(1147)

L:SetMiscLocalization({
	Train			= GetSpellInfo(174806),
	lane			= "Путь",
	oneTrain		= "1 случайный путь: Поезд",
	oneRandom		= "Появляется на 1 случайном пути",
	threeTrains		= "3 случайных пути: Поезд",
	threeRandom		= "Появляются на 3 случайных путях",
	helperMessage	= "Этот бой может быть упрощен с помощью аддона 'Thogar Assist' или одного из множества доступных голосовых пакетов DBM, которые можно найти на http://wow.curse.com/."
})

--------------------------
-- The Iron Maidens --
--------------------------
L= DBM:GetModLocalization(1203)

L:SetMiscLocalization({
	shipMessage		= "prepares to man the Dreadnaught's Main Cannon!"
})

--------------------------
-- Blackhand --
--------------------------
L= DBM:GetModLocalization(959)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("BlackrockFoundryTrash")

L:SetGeneralLocalization({
	name =	"Трэш мобы Литейной клана Черной горы"
})
