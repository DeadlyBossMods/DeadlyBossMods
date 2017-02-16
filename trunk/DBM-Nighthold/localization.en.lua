local L

---------------
-- Skorpyron --
---------------
L= DBM:GetModLocalization(1706)

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

L:SetOptionLocalization({
	HUDSeekerLines		= "Show HUD lines with Seeker Swarm"
})

L:SetMiscLocalization({
	First				= "First",
	Second				= "Second",
	Third				= "Third",
	Adds1				= "Underlings! Get in here!",
	Adds2				= "Show these pretenders how to fight!"
})

------------------
-- Krosus --
------------------
L= DBM:GetModLocalization(1713)

L:SetWarningLocalization({
	warnSlamSoon		= "Bridge break in %ds"
})

L:SetOptionLocalization({
	warnSlamSoon		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.soon:format(205862)
})

L:SetMiscLocalization({
	MoveLeft			= "Move Left",
	MoveRight			= "Move Right"
})

------------------
-- High Botanist Tel'arn --
------------------
L= DBM:GetModLocalization(1761)

L:SetWarningLocalization({
	warnStarLow				= "Plasma Sphere is low"
})

L:SetOptionLocalization({
	warnStarLow				= "Show special warning when Plasma Sphere is low (at ~25%)"
})

L:SetMiscLocalization({
	RadarMessage			= "Use Radar to find a non debuff partner and HUD to avoid other debuffs. I hope to improve this function over time and provide more options than this."
})

------------------
-- Star Augur Etraeus --
------------------
L= DBM:GetModLocalization(1732)

L:SetOptionLocalization({
	ShowCustomNPAuraTextures= "Show custom green/red icon textures in nameplates instead of debuff signs if you are affected by star signs",
	FilterOtherSigns		= "Filter target announces for Star Signs you are not affected by."
})

------------------
-- Grand Magistrix Elisande --
------------------
L= DBM:GetModLocalization(1743)

L:SetTimerLocalization({
	timerFastTimeBubble		= "Fast Bubble (%d)",
	timerSlowTimeBubble		= "Slow Bubble (%d)"
})

L:SetOptionLocalization({
	timerFastTimeBubble		= "Show timer for $spell:209166 bubbles",
	timerSlowTimeBubble		= "Show timer for $spell:209165 bubbles"
})

L:SetMiscLocalization({
	noCLEU4EchoRings		= "Let the waves of time crash over you!",
	noCLEU4EchoOrbs			= "You'll find time can be quite volatile."
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

L:SetMiscLocalization({
	mythicPhase3		= "Time to return the demon hunter's soul to his body... and deny the Legion's master a host!"
})

