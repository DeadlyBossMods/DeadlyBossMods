if GetLocale() ~= "deDE" then return end
local L

---------------
-- Odyn --
---------------
L= DBM:GetModLocalization(1819)

---------------------------
-- Guarm --
---------------------------
L= DBM:GetModLocalization(1830)

L:SetOptionLocalization({
	YellActualRaidIcon		= "Change all DBM yells for foam to say icon set on player instead of matching colors (Requires raid leader)"--translate
})

---------------------------
-- Helya --
---------------------------
L= DBM:GetModLocalization(1829)

L:SetTimerLocalization({
	OrbsTimerText		= "Nächste Kugeln (%d-%s)"
})

L:SetMiscLocalization({
	phaseThree		= "Your efforts are for naught, mortals! Odyn will NEVER be free!",--translate (unused)
	near			= "in der Nähe von",--CHECK translate (near) (trigger)
	far				= "weit",--CHECK translate (far) (trigger)
	multiple		= "Mehrere"--needs to be verified (unused)
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("TrialofValorTrash")

L:SetGeneralLocalization({
	name =	"Trash der Prüfung der Tapferkeit"
})
