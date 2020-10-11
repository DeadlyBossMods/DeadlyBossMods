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
	name =	"Necrotic Wake Trash"
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
	name =	"Plaguefall Trash"
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
	specWarnParasiticInfester	= "Parasitic Infester on YOU"
})

L:SetTimerLocalization{
	timerParasiticInfesterCD	= "~Infester"
}

L:SetOptionLocalization({
	specWarnParasiticInfester	= "Show special warning when you are affected by Parasitic Infester",
	timerParasiticInfesterCD	= "Show timer for Parasitic Infester",
	yellParasiticInfester		= "Yell when you are affected by Parasitic Infester"
})

L:SetMiscLocalization({
	Infester					= "Infester"
})

---------
--Trash--
---------
L = DBM:GetModLocalization("TirnaScitheTrash")

L:SetGeneralLocalization({
	name =	"Tirna Scithe Trash"--Or MOTS Trash?
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
	name =	"Halls of Atonement Trash"--HoA Trash?
})

-----------------------
-- <<<Spires of Ascension (1186J/2285M) >>> --
-----------------------
-----------------------
-- Kin-Tara --
-----------------------
L= DBM:GetModLocalization(2399)

L:SetMiscLocalization({
	Flight	= "Your doom takes flight!"
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
	RunThrough	= "This spear shall pierce your heart!"
})

---------
--Trash--
---------
L = DBM:GetModLocalization("SpiresofAscensionTrash")

L:SetGeneralLocalization({
	name =	"Spires of Ascension Trash"--SoA Trash?
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
	name =	"Theater of Pain Trash"
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
	name =	"De Other Side Trash"
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
	name =	"Sanguine Depths Trash"
})
