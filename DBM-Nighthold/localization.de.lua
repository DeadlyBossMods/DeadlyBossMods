if GetLocale() ~= "deDE" then return end
local L

---------------
-- Skorpyron --
---------------
L= DBM:GetModLocalization(1706)

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
	HUDSeekerLines		= "Show HUD lines with Seeker Swarm"--translate later
})

L:SetMiscLocalization({
	First				= "Erster",
	Second				= "Zweiter",
	Third				= "Dritter",
	Adds1				= "Underlings! Get in here!",--translate (trigger)
	Adds2				= "Show these pretenders how to fight!"--translate (trigger)
})

------------------
-- Krosus --
------------------
L= DBM:GetModLocalization(1713)

L:SetWarningLocalization({
	warnSlamSoon		= "Zerschmettern in %ds"
})

L:SetMiscLocalization({
	MoveLeft			= "Lauf nach links",
	MoveRight			= "Lauf nach rechts"
})

------------------
-- High Botanist Tel'arn --
------------------
L= DBM:GetModLocalization(1761)

L:SetWarningLocalization({
	warnStarLow				= "Plasmasphäre stirbt bald"
})

L:SetOptionLocalization({
	warnStarLow				= "Spezialwarnung, wenn eine Plasmasphäre bald stirbt (bei ~25%)"
})

L:SetMiscLocalization({
	RadarMessage			= "Use Radar to find a non debuff partner and HUD to avoid other debuffs. I hope to improve this function over time and provide more options than this."--translate later
})

------------------
-- Star Augur Etraeus --
------------------
L= DBM:GetModLocalization(1732)

L:SetOptionLocalization({
	ShowCustomNPAuraTextures= "Zeige spezielle grün/rote Zeichentexturen in Namensplaketten (statt Debuffzeichen), falls du von Sternzeichen betroffen bist",
	FilterOtherSigns		= "Filter target announces for Star Signs you are not affected by."--translate (unused)
})

------------------
-- Grand Magistrix Elisande --
------------------
L= DBM:GetModLocalization(1743)

L:SetTimerLocalization({
	timerFastTimeBubble		= "Schnelle Zone (%d)",
	timerSlowTimeBubble		= "Langsame Zone (%d)"
})

L:SetOptionLocalization({
	timerFastTimeBubble		= "Zeige Zeit für $spell:209166 Zonen",
	timerSlowTimeBubble		= "Zeige Zeit für $spell:209165 Zonen"
})

L:SetMiscLocalization({
	noCLEU4EchoRings		= "Let the waves of time crash over you!",--translate (trigger)
	noCLEU4EchoOrbs			= "You'll find time can be quite volatile.",--translate (trigger)
	prePullRP				= "I foresaw your coming, of course. The threads of fate that led you to this place. Your desperate attempt to stop the Legion."--translate (trigger)
})

------------------
-- Gul'dan --
------------------
L= DBM:GetModLocalization(1737)

L:SetMiscLocalization({
	mythicPhase3		= "Time to return the demon hunter's soul to his body... and deny the Legion's master a host!",--translate (trigger)
	prePullRP			= "Ah yes, the heroes have arrived. So persistent. So confident. But your arrogance will be your undoing!"--translate (trigger)
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("NightholdTrash")

L:SetGeneralLocalization({
	name =	"Trash der Nachtfestung"
})
