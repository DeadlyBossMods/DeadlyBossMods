if GetLocale() ~= "ruRU" then return end
local L

---------------
-- Immerseus --
---------------
L= DBM:GetModLocalization(852)

---------------------------
-- The Fallen Protectors --
---------------------------
L= DBM:GetModLocalization(849)

---------------------------
-- Norushen --
---------------------------
L= DBM:GetModLocalization(866)

L:SetOptionLocalization({
	InfoFrame			= "Информационное окно для $journal:8252"
})

L:SetMiscLocalization({
	wasteOfTime			= "Very well, I will create a field to keep your corruption quarantined."
})

------------------
-- Sha of Pride --
------------------
L= DBM:GetModLocalization(867)

L:SetOptionLocalization({
	InfoFrame			= "Информационное окно для $journal:8255"
})

--------------
-- Galakras --
--------------
L= DBM:GetModLocalization(868)

L:SetTimerLocalization({
	timerAddsCD		= "След. волна аддов",
	timerTowerCD	= "След. башня и адды"
})

L:SetOptionLocalization({
	timerAddsCD		= "Отсчет времени до следующей волны аддов",
	timerTowerCD	= "Отсчет времени до следующего нападения на башню"
})

L:SetMiscLocalization({
	newForces1	= "Вот и они!",--Jaina's line, horde may not be same
	newForces2	= "Драконья Пасть, вперед!",
	newForces3	= "За Гарроша!",
	newForces4	= "Следующий отряд!",
	tower		= "Дверь "--Дверь южной/северной башни разбита!
})

--------------------
--Iron Juggernaut --
--------------------
L= DBM:GetModLocalization(864)

--------------------------
-- Kor'kron Dark Shaman --
--------------------------
L= DBM:GetModLocalization(856)

L:SetMiscLocalization({
	PrisonYell		= "Тюрьма на %s спадает (%d)"
})

---------------------
-- General Nazgrim --
---------------------
L= DBM:GetModLocalization(850)

L:SetWarningLocalization({
	warnDefensiveStanceSoon		= "Оборонительная стойка через %d сек."
})

L:SetOptionLocalization({
	warnDefensiveStanceSoon		= "Обратный отсчет за 5 секунд до $spell:143593"
})

L:SetMiscLocalization({
	newForces1					= "Воины, бегом!",
	newForces2					= "Удерживайте врата!",
	newForces3					= "Сомкнуть ряды!",
	newForces4					= "Кор'крон, ко мне!",
	newForces5					= "Следующий отряд, вперед!",
	allForces					= "Кор'кронцы... все, кто со мной! Убейте их!"
})

-----------------
-- Malkorok -----
-----------------
L= DBM:GetModLocalization(846)

------------------------
-- Spoils of Pandaria --
------------------------
L= DBM:GetModLocalization(870)

L:SetMiscLocalization({
	Module1 = "Первый модуль готов к перезагрузке системы.",
	Victory	= "Второй модуль готов к перезагрузке системы."
})

---------------------------
-- Thok the Bloodthirsty --
---------------------------
L= DBM:GetModLocalization(851)

L:SetOptionLocalization({
	RangeFrame	= "Показывать динамическое окно проверки дистанции (10)<br/>(Это умное окно проверки дистанции, которое появляется когда вы достигаете порога Бешенства)"
})

----------------------------
-- Siegecrafter Blackfuse --
----------------------------
L= DBM:GetModLocalization(865)

L:SetMiscLocalization({
	newWeapons	= "Unfinished weapons begin to roll out on the assembly line.",
	newShredder	= "An Automated Shredder draws near!"
})

----------------------------
-- Paragons of the Klaxxi --
----------------------------
L= DBM:GetModLocalization(853)

L:SetWarningLocalization({
	specWarnActivatedVulnerable		= "Вы уязвимы к %s - Избегайте!",
	specWarnCriteriaLinked			= "Вы слинкованы с %s!"
})

L:SetOptionLocalization({
	specWarnActivatedVulnerable		= "Спец-предупреждение когда вы уязвимы к активирующимся идеалам",
	specWarnCriteriaLinked			= "Спец-предупреждение когда вы слинкованы с $spell:144095"
})

L:SetMiscLocalization({
	--thanks to blizz, the only accurate way for this to work, is to translate 5 emotes in all languages
	one					= "Один",--guessed
	two					= "Два",--guessed
	three				= "Три",--guessed
	four				= "Четыре",--guessed
	five				= "Пять",--guessed
	hisekFlavor			= "Look who's quiet now",--http://ptr.wowhead.com/quest=31510
	KilrukFlavor		= "Just another day, culling the swarm",--http://ptr.wowhead.com/quest=31109
	XarilFlavor			= "I see only dark skies in your future",--http://ptr.wowhead.com/quest=31216
	KaztikFlavor		= "Reduced to mere kunchong treats",--http://ptr.wowhead.com/quest=31024
	KaztikFlavor2		= "1 Mantid down, only 199 to go",--http://ptr.wowhead.com/quest=31808
	KorvenFlavor		= "The end of an ancient empire",--http://ptr.wowhead.com/quest=31232
	KorvenFlavor2		= "Take your Gurthani Tablets and choke on them",--http://ptr.wowhead.com/quest=31232
	IyyokukFlavor		= "See opportunities. Exploit them!",--Does not have quests, http://ptr.wowhead.com/npc=65305
	KarozFlavor			= "You won't be leaping anymore!",---Does not have questst, http://ptr.wowhead.com/npc=65303
	SkeerFlavor			= "A bloody delight!",--http://ptr.wowhead.com/quest=31178
	RikkalFlavor		= "Specimen request fulfilled"--http://ptr.wowhead.com/quest=31508
})

------------------------
-- Garrosh Hellscream --
------------------------
L= DBM:GetModLocalization(869)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("FoOTrash")

L:SetGeneralLocalization({
	name =	"Трэш мобы Осады Оргриммара"
})
