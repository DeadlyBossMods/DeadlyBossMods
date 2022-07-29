if GetLocale() ~= "ruRU" then return end
local L

-----------------------
-- <<<The Necrotic Wake (1182J/2286M) >>> --
-----------------------
-----------------------
-- Blightbone --
-----------------------
--L= DBM:GetModLocalization(2395)

-----------------------
-- Amarth, The Reanimator  --
-----------------------
--L= DBM:GetModLocalization(2391)

-----------------------
-- Surgeon Stitchflesh --
-----------------------
--L= DBM:GetModLocalization(2392)

-----------------------
-- Nalthor the Rimebinder --
-----------------------
--L= DBM:GetModLocalization(2396)

---------
--Trash--
---------
L = DBM:GetModLocalization("NecroticWakeTrash")

L:SetGeneralLocalization({
	name =	"Трэш мобы Смертельная Тризна"
})

-----------------------
-- <<<Plaguefall (1183J/2289M) >>> --
-----------------------
-----------------------
-- Globgrog --
-----------------------
--L= DBM:GetModLocalization(2419)

-----------------------
-- Doctor Ickus --
-----------------------
--L= DBM:GetModLocalization(2403)

-----------------------
-- Domina Venomblade --
-----------------------
--L= DBM:GetModLocalization(2423)

-----------------------
-- Margrave Stradama --
-----------------------
--L= DBM:GetModLocalization(2404)

---------
--Trash--
---------
L = DBM:GetModLocalization("PlaguefallTrash")

L:SetGeneralLocalization({
	name =	"Трэш мобы Чумные Каскады"
})

-----------------------
-- <<<Mists of Tirna Scithe (1184J/2290M) >>> --
-----------------------
-----------------------
-- Ingra Maloch --
-----------------------
--L= DBM:GetModLocalization(2400)

-----------------------
-- Mistcaller (Probably placeholder) --
-----------------------
--L= DBM:GetModLocalization(2402)

-----------------------
-- Tred'ova --
-----------------------
L= DBM:GetModLocalization(2405)

L:SetWarningLocalization({
	warnInfestor					= "Паразитический заразитель на %s",
	specWarnParasiticInfesterKick	= "Паразитический заразитель - Прервать!"
})

L:SetTimerLocalization{
	timerParasiticInfesterCD		= "~Заразитель"
}

L:SetOptionLocalization({
	warnInfestor					= "Объявить цели, на которых Паразитический заразитель",
	specWarnParasiticInfesterKick	= "Показать специальное предупреждение, чтобы прервать Паразитический заразитель",
	timerParasiticInfesterCD		= "Показать таймер для Паразитический заразитель",
	yellParasiticInfester			= "Кричать, когда на Вас действует Паразитический заразитель"
})

L:SetMiscLocalization({
	Infester						= "Заразитель"
})

---------
--Trash--
---------
L = DBM:GetModLocalization("TirnaScitheTrash")

L:SetGeneralLocalization({
	name =	"Трэш мобы Туманы Тирна Скитта"
})

-----------------------
-- <<<Halls of Atonement (1185J/2287M) >>> --
-----------------------
-----------------------
-- Halkias, the Sin-Stained Goliath --
-----------------------
--L= DBM:GetModLocalization(2406)

-----------------------
-- Echelon --
-----------------------
--L= DBM:GetModLocalization(2387)

-----------------------
-- High Adjudicator Aleez --
-----------------------
--L= DBM:GetModLocalization(2411)

-----------------------
-- Lord Chamberlain --
-----------------------
--L= DBM:GetModLocalization(2413)

---------
--Trash--
---------
L = DBM:GetModLocalization("AtonementTrash")

L:SetGeneralLocalization({
	name =	"Трэш мобы Чертоги Покаяния"
})

-----------------------
-- <<<Spires of Ascension (1186J/2285M) >>> --
-----------------------
-----------------------
-- Kin-Tara --
-----------------------
L= DBM:GetModLocalization(2399)

L:SetMiscLocalization({
	Flight	= "Your doom takes flight!",
	Flight2	= "Fear the skies!"
})

-----------------------
-- Ventunax --
-----------------------
--L= DBM:GetModLocalization(2416)

-----------------------
-- Oryphrion --
-----------------------
--L= DBM:GetModLocalization(2414)

-----------------------
-- Devos, Paragon of Doubt --
-----------------------
L= DBM:GetModLocalization(2412)

L:SetMiscLocalization({
	RunThrough	= "Это копье пронзит твое сердце!"
})

---------
--Trash--
---------
L = DBM:GetModLocalization("SpiresofAscensionTrash")

L:SetGeneralLocalization({
	name =	"Трэш мобы Шпили Перерождения"
})

-----------------------
-- <<<Theater of Pain (1187J/2293M)>>> --
-----------------------
-----------------------
-- An Affront of Challengers --
-----------------------
--L= DBM:GetModLocalization(2397)

-----------------------
-- Gorechop --
-----------------------
--L= DBM:GetModLocalization(2401)

-----------------------
-- Xav the Unfallen --
-----------------------
--L= DBM:GetModLocalization(2390)

-----------------------
-- Kul'tharok --
-----------------------
--L= DBM:GetModLocalization(2389)

-----------------------
-- Mordretha, the Endless Empress --
-----------------------
--L= DBM:GetModLocalization(2417)

---------
--Trash--
---------
L = DBM:GetModLocalization("TheaterofPainTrash")

L:SetGeneralLocalization({
	name =	"Трэш мобы Театр Боли"
})

-----------------------
-- <<<De Other Side (1188J/2291M)>>> --
-----------------------
-----------------------
-- Hakkar the Soulflayer --
-----------------------
--L= DBM:GetModLocalization(2408)

-----------------------
-- The Manastorms --
-----------------------
--L= DBM:GetModLocalization(2409)

-----------------------
-- Dealer Xy'exa --
-----------------------
--L= DBM:GetModLocalization(2398)

-----------------------
-- Mueh'zala --
-----------------------
--L= DBM:GetModLocalization(2410)

---------
--Trash--
---------
L = DBM:GetModLocalization("DeOtherSideTrash")

L:SetGeneralLocalization({
	name =	"Трэш мобы Та Сторона"
})

-----------------------
-- <<<Sanguine Depths (1189J/2284M)>>> --
-----------------------
-----------------------
-- Kryxis the Voracious --
-----------------------
--L= DBM:GetModLocalization(2388)

-----------------------
-- Executor Tarvold --
-----------------------
--L= DBM:GetModLocalization(2415)

-----------------------
-- Grand Proctor Beryllia --
-----------------------
--L= DBM:GetModLocalization(2421)

-----------------------
-- General Kaal --
-----------------------
--L= DBM:GetModLocalization(2407)

---------
--Trash--
---------
L = DBM:GetModLocalization("SanguineDepthsTrash")

L:SetGeneralLocalization({
	name =	"Трэш мобы Кровавые катакомбы"
})

-----------------------
-- <<<Tazavesh, the Veiled Market (1194J/2441M)>>> --
-----------------------
-----------------------
-- Zo'phex the Sentinel --
-----------------------
--L= DBM:GetModLocalization(2437)

-----------------------
-- The Menagerie --
-----------------------
L= DBM:GetModLocalization(2454)

L:SetMiscLocalization({
	AchilliteRPTrigger	= "Докучают разъяренные звери? У нас есть решение!",
	VenzaRPTrigger		= "Вот мой шанс! Топор будет моим!"
})

-----------------------
-- Mailroom Mayhem --
-----------------------
--L= DBM:GetModLocalization(2436)

-----------------------
-- Au'myza's Oasis --
-----------------------
--L= DBM:GetModLocalization(2452)

-----------------------
-- So'azmi --
-----------------------
L= DBM:GetModLocalization(2451)

L:SetMiscLocalization({
	RPTrigger	= "Прости нас за вторжение, Со'лея. Кажется, сейчас не самое подходящее время."
})

-----------------------
-- Hylbrande --
-----------------------
--L= DBM:GetModLocalization(2448)

-----------------------
-- Timecap'n Hooktail --
-----------------------
--L= DBM:GetModLocalization(2449)

-----------------------
-- So'leah --
-----------------------
--L= DBM:GetModLocalization(2455)

---------
--Trash--
---------
L = DBM:GetModLocalization("TazaveshTrash")

L:SetGeneralLocalization({
	name =	"Трэш мобы Тайный рынок Тазавеш"
})
