if GetLocale() ~= "koKR" then return end
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
	name =	"죽음의 각성 일반몹"
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
	name =	"역병 몰락지 일반몹"
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
	specWarnParasiticInfester	= "당신에게 기생 감염충",
	specWarnParasiticInfesterKick	= "기생 감염충 - 차단!"
})

L:SetTimerLocalization{
	timerParasiticInfesterCD	= "~감염충"
}

L:SetOptionLocalization({
	specWarnParasiticInfester	= "당신이 기생 감염충 대상이면 특수 알림 보기",
	specWarnParasiticInfesterKick	= "기생 감염충을 차단해야 할 때 특수 경고 보기",
	timerParasiticInfesterCD	= "기생 감염충 타이머 바 보기",
	yellParasiticInfester		= "기생 감염충 대상일 때 말풍선으로 알리기"
})

L:SetMiscLocalization({
	Infester			= "감염충"
})

---------
--Trash--
---------
L = DBM:GetModLocalization("TirnaScitheTrash")

L:SetGeneralLocalization({
	name =	"티르나 사이드 일반몹"--Or MOTS Trash?
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
	name =	"속죄의 전당 일반몹"--HoA Trash?
})

-----------------------
-- <<<Spires of Ascension (1186J/2285M) >>> --
-----------------------
-----------------------
-- Kin-Tara --
-----------------------
L= DBM:GetModLocalization(2399)

L:SetMiscLocalization({
	Flight	= "죽음의 날갯짓을 맞이해라!"
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
	RunThrough	= "이 창이 네 심장을 꿰뚫을 것이다!",
	Flight2		= "하늘을 두려워 하라!"
})

---------
--Trash--
---------
L = DBM:GetModLocalization("SpiresofAscensionTrash")

L:SetGeneralLocalization({
	name =	"승천의 첨탑 일반몹"--SoA Trash?
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
	name =	"고통의 투기장 일반몹"
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
	name =	"저편 일반몹"
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
	name =	"핏빛 심연 일반몹"
})
