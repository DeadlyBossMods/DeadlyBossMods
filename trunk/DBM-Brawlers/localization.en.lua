local L

--------------
-- Brawlers --
--------------
L= DBM:GetModLocalization("Brawlers")

L:SetGeneralLocalization({
	name = "Brawlers: Options"
})

L:SetWarningLocalization({
	specWarnYourTurn	= "You're up!"
})

L:SetOptionLocalization({
	specWarnYourTurn	= "Show special warning when it's your match",
	SpectatorMode		= "Show warnings/timers when spectating fights"
})

L:SetMiscLocalization({
	Bizmo			= "Bizmo",--Alliance
	Bazzelflange	= "Boss Bazzelflange",--Horde
	--I wish there was a better way to do this....so much localizing. :(
	Rank1			= "Rank 1",
	Rank2			= "Rank 2",
	Rank3			= "Rank 3",
	Rank4			= "Rank 4",
	Rank5			= "Rank 5",
	Rank6			= "Rank 6",
	Rank7			= "Rank 7",
	Rank8			= "Rank 8",
--[[	Victory1		= "is our victor",
	Victory2		= "Congratulations",
	Victory3		= "Brilliant victory",
	Victory4		= "wins",
	Victory5		= "Keep 'em comin'",
	Victory6		= "Great job not dying",
	Lost1			= "were you even trying",
	Lost2			= "Now would you kindly remove your corpse",
	Lost3			= "So much blood! Nice",
	Lost4			= "Get back in line and try again",
	Lost5			= "you're gonna have to break a few eggs",
	Lost6			= "try not to die so much",
	Lost7			= "what a mess",
	Lost8			= "name was",--LoL at fight club reference here
	Lost9			= "did not end well",--]]
	Proboskus		= "Oh dear... I'm sorry, but it looks like you're going to have to fight Proboskus."--This boss is only boss out of 32 that has a custom berserk, so we need a chat yell to detect when he specificly is pulled to adjust berserk timer--
})

------------
-- Rank 1 --
------------
L= DBM:GetModLocalization("BrawlRank1")

L:SetGeneralLocalization({
	name = "Brawlers: Rank 1"
})

------------
-- Rank 2 --
------------
L= DBM:GetModLocalization("BrawlRank2")

L:SetGeneralLocalization({
	name = "Brawlers: Rank 2"
})

------------
-- Rank 3 --
------------
L= DBM:GetModLocalization("BrawlRank3")

L:SetGeneralLocalization({
	name = "Brawlers: Rank 3"
})

------------
-- Rank 4 --
------------
L= DBM:GetModLocalization("BrawlRank4")

L:SetGeneralLocalization({
	name = "Brawlers: Rank 4"
})

------------
-- Rank 5 --
------------
L= DBM:GetModLocalization("BrawlRank5")

L:SetGeneralLocalization({
	name = "Brawlers: Rank 5"
})

------------
-- Rank 6 --
------------
L= DBM:GetModLocalization("BrawlRank6")

L:SetGeneralLocalization({
	name = "Brawlers: Rank 6"
})

------------
-- Rank 7 --
------------
L= DBM:GetModLocalization("BrawlRank7")

L:SetGeneralLocalization({
	name = "Brawlers: Rank 7"
})

------------
-- Rank 8 --
------------
L= DBM:GetModLocalization("BrawlRank8")

L:SetGeneralLocalization({
	name = "Brawlers: Rank 8"
})
