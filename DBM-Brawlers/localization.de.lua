if GetLocale() ~= "deDE" then return end
local L

-----------------------
-- Brawlers --
-----------------------
L= DBM:GetModLocalization("Brawlers")

L:SetGeneralLocalization({
	name = "Kampfgildengegner"
})

L:SetWarningLocalization({
	specWarnYourTurn	= "Du bist dran!"
})

L:SetOptionLocalization({
	specWarnYourTurn	= "Zeige Spezialwarnung, wenn es dein Kampf ist",
	SpectatorMode		= "Zeige Warnungen/Timer auch beim Zuschauen fremder Kämpfe"
})

L:SetMiscLocalization({
	Bizmo			= "Bizmo",
	--I wish there was a better way to do this....so much localizing. :(
	EnteringArena1	= "Now entering the arena", -- translate (trigger)
	EnteringArena2	= "Here's our challenger", -- translate (trigger)
	EnteringArena3	= "Look out... here comes", -- translate (trigger)
	Victory1		= "is our victor", -- translate (trigger)
	Victory2		= "Congratulations", -- translate (trigger)
	Victory3		= "Brilliant victory", -- translate (trigger)
	Victory4		= "wins", -- translate (trigger)
	Victory5		= "Keep 'em comin'", -- translate (trigger)
	Victory6		= "Great job not dying", -- translate (trigger)
	Lost1			= "were you even trying", -- translate (trigger)
	Lost2			= "Now would you kindly remove your corpse", -- translate (trigger)
	Lost3			= "So much blood! Nice", -- translate (trigger)
	Lost4			= "Get back in line and try again", -- translate (trigger)
	Lost5			= "you're gonna have to break a few eggs", -- translate (trigger)
	Lost6			= "try not to die so much", -- translate (trigger)
	Lost7			= "what a mess", -- translate (trigger)
	Lost8			= "His name was", -- translate (trigger)
})
