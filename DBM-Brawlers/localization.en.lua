local L

-----------------------
-- Brawlers --
-----------------------
L= DBM:GetModLocalization("Brawlers")

L:SetGeneralLocalization({
	name = "Brawlers Guild"
})

L:SetWarningLocalization({
	specWarnYourTurn	= "You're up!"
})

L:SetOptionLocalization({
	specWarnYourTurn	= "Show special warning when it's your match",
	SpectatorMode		= "Show warnings/timers when spectating fights"
})

L:SetMiscLocalization({
	Bizmo			= "Bizmo",
	EnteringArena	= "Now entering the arena",
	Victory1		= "is our victor",
	Victory2		= "Congratulations",
	Victory3		= "Brilliant victory",
	Victory4		= "wins",
	Victory5		= "Keep 'em comin'",--Probably even more Victory yells
	Lost1			= "were you even trying",
	Lost2			= "Now would you kindly remove your corpse",
	Lost3			= "So much blood! Nice",
	Lost4			= "Get back in line and try again",--Definitely more Lost ones
})
