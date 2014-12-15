if GetLocale() ~= "ruRU" then return end
local L

---------------
-- Kargath Bladefist --
---------------
L= DBM:GetModLocalization(1128)

L:SetTimerLocalization({
	timerSweeperCD			= DBM_CORE_AUTO_TIMER_TEXTS.next:format("Чистильщик арены")
})

L:SetOptionLocalization({
	timerSweeperCD			= DBM_CORE_AUTO_TIMER_OPTIONS.next:format("Чистильщик арены"),
	countdownSweeper		= DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT:format("Чистильщик арены")
})

---------------------------
-- The Butcher --
---------------------------
L= DBM:GetModLocalization(971)

---------------------------
-- Tectus, the Living Mountain --
---------------------------
L= DBM:GetModLocalization(1195)

L:SetMiscLocalization({
	pillarSpawn	= "ВОССТАНЬТЕ, ГОРЫ!"
})

------------------
-- Brackenspore, Walker of the Deep --
------------------
L= DBM:GetModLocalization(1196)

--------------
-- Twin Ogron --
--------------
L= DBM:GetModLocalization(1148)

L:SetOptionLocalization({
	PhemosSpecial	= "Звуковой обратный отсчет для кулдаунов Фем'а",
	PolSpecial		= "Звуковой обратный отсчет для кулдаунов Пол'а",
	PhemosSpecialVoice	= "Звуковые оповещения для способностей Фем'а используя выбранный звуковой пакет",
	PolSpecialVoice		= "Звуковые оповещения для способностей Пол'а используя выбранный звуковой пакет"
})

--------------------
--Koragh --
--------------------
L= DBM:GetModLocalization(1153)

L:SetMiscLocalization({
	supressionTarget1	= "Я сокрушу вас!",
	supressionTarget2	= "Молчать!",
	supressionTarget3	= "Тихо!",
	supressionTarget4	= "Я разорву вас на части!"
})

--------------------------
-- Imperator Mar'gok --
--------------------------
L= DBM:GetModLocalization(1197)

L:SetMiscLocalization({
	BrandedYell			= "Клеймо (%s) на %s"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("HighmaulTrash")

L:SetGeneralLocalization({
	name =	"Трэш мобы Верховного Молота"
})
