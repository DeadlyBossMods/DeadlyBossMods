if GetLocale() ~= "zhTW" then return end
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
	name =	"死靈戰地小怪"
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
	name =	"瘟疫之臨小怪"
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
	warnInfestor					= "寄生平靜在 %s",
	specWarnParasiticInfesterKick	= "寄生平靜 - 快打斷"
})

L:SetTimerLocalization{
	timerParasiticInfesterCD		= "~寄生"
}

L:SetOptionLocalization({
	warnInfestor					= "通告寄生平靜的目標",
	specWarnParasiticInfesterKick	= "需要打斷寄生平靜時顯示特別警告",
	timerParasiticInfesterCD		= "顯示寄生計時器",
	yellParasiticInfester			= "當受到平靜感染時大喊"
})

L:SetMiscLocalization({
	Infester					= "寄生"
})

---------
--Trash--
---------
L = DBM:GetModLocalization("TirnaScitheTrash")

L:SetGeneralLocalization({
	name =	"特那希迷霧小怪"
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
	name =	"贖罪之殿小怪"
})

-----------------------
-- <<<Spires of Ascension (1186J/2285M) >>> --
-----------------------
-----------------------
-- Kin-Tara --
-----------------------
--L= DBM:GetModLocalization(2399)

L:SetMiscLocalization({
	Flight	= "末日從天而降！",
	Flight2	= "恐怖來自天空！"
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
	RunThrough	= "我要用這柄長矛刺穿你的心臟！"
})

---------
--Trash--
---------
L = DBM:GetModLocalization("SpiresofAscensionTrash")

L:SetGeneralLocalization({
	name =	"晉升之巔小怪"
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
	name =	"苦痛劇場小怪"
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
-- Dealer G'exa --
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
	name =	"彼界境地小怪"
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
	name =	"血紅深淵小怪"
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
--L= DBM:GetModLocalization(2454)

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
--L= DBM:GetModLocalization(2451)

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
	name =	"塔札瓦蘇小怪"
})
