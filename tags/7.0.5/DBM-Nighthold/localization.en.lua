local L

---------------
-- Skorpyron --
---------------
L= DBM:GetModLocalization(1706)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	NoDebuff	= "No %s"
})

---------------------------
-- Chronomatic Anomaly --
---------------------------
L= DBM:GetModLocalization(1725)

---------------------------
-- Trilliax --
---------------------------
L= DBM:GetModLocalization(1731)

------------------
-- Spellblade Aluriel --
------------------
L= DBM:GetModLocalization(1751)

------------------
-- Tichondrius --
------------------
L= DBM:GetModLocalization(1762)

L:SetMiscLocalization({
	First				= "First",
	Second				= "Second",
	Third				= "Third"
})

------------------
-- Krosus --
------------------
L= DBM:GetModLocalization(1713)

------------------
-- High Botanist Tel'arn --
------------------
L= DBM:GetModLocalization(1761)

L:SetWarningLocalization({
	warnStarLow				= "Plasma Sphere is low"
})

L:SetOptionLocalization({
	warnStarLow				= "Show special warning when Plasma Sphere is low (at ~15%)"
})

L:SetMiscLocalization({
	RadarMessage			= "Use Radar to find a non debuff partner and HUD to avoid other debuffs. I hope to improve this function over time and provide more options than this."
})

------------------
-- Star Augur Etraeus --
------------------
L= DBM:GetModLocalization(1732)

L:SetOptionLocalization({
	ShowNeutralColor		= "Show white circles on HUD around players that have no star sign, until all signs are cleared.",
	FilterOtherSigns		= "Filter target announces for Star Signs you are not affected by."
})

------------------
-- Grand Magistrix Elisande --
------------------
L= DBM:GetModLocalization(1743)

L:SetMiscLocalization({
	noCLEU4EchoRings		= "Let the waves of time crash over you!"
})

------------------
-- Gul'dan --
------------------
L= DBM:GetModLocalization(1737)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("NightholdTrash")

L:SetGeneralLocalization({
	name =	"Nighthold Trash"
})
