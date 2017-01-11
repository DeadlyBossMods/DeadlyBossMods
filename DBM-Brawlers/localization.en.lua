local L

--------------
-- Brawlers --
--------------
L= DBM:GetModLocalization("Brawlers")

L:SetGeneralLocalization({
	name = "Brawlers: General"
})

L:SetWarningLocalization({
	warnQueuePosition	= "You're %d in queue",
	specWarnYourNext	= "You're next!",
	specWarnYourTurn	= "You're up!"
})

L:SetOptionLocalization({
	warnQueuePosition	= "Announce your current position in queue whenever it changes",
	specWarnYourNext	= "Show special warning when you're next in line",
	specWarnYourTurn	= "Show special warning when it's your match",
	SpectatorMode		= "Show warnings/timers when spectating fights<br/>(Personal 'Special Warning' messages not shown to spectators)",
	SpeakOutQueue		= "Count out your number in the queue when it updates"
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
	Rank9			= "Rank 9",
	Rank10			= "Rank 10",
	Proboskus		= "Oh dear... I'm sorry, but it looks like you're going to have to fight Proboskus.",--Alliance
	Proboskus2		= "Ha ha ha! What bad luck you have! It's Proboskus! Ahhh ha ha ha! I've got twenty five gold that says you die in the fire!"--Horde
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

L:SetOptionLocalization({
	SetIconOnBlat	= "Set icon (skull) on real Blat"
})

------------
-- Rank 4 --
------------
L= DBM:GetModLocalization("BrawlRank4")

L:SetGeneralLocalization({
	name = "Brawlers: Rank 4"
})

L:SetOptionLocalization({
	SetIconOnDominika	= "Set icon (skull) on real Dominika the Illusionist"
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

--[[
------------
-- Rank 8 --
------------
L= DBM:GetModLocalization("BrawlRank8")

L:SetGeneralLocalization({
	name = "Brawlers: Rank 8"
})

------------
-- Rank 9 --
------------
L= DBM:GetModLocalization("BrawlRank9")

L:SetGeneralLocalization({
	name = "Brawlers: Rank 9"
})
--]]

-------------
-- Brawlers: Legacy --
-------------
L= DBM:GetModLocalization("BrawlLegacy")

L:SetGeneralLocalization({
	name = "Brawlers: Legacy"
})

L:SetOptionLocalization({
	SpeakOutStrikes		= "Count out number of $spell:141190 attacks"
})

-------------
-- Brawlers: Challenges --
-------------
L= DBM:GetModLocalization("BrawlChallenges")

L:SetGeneralLocalization({
	name = "Brawlers: Challenge"
})

L:SetWarningLocalization({
	specWarnRPS			= "Use %s!"
})

L:SetOptionLocalization({
	ArrowOnBoxing		= "Show DBM Arrow during $spell:140868 and $spell:140862 and $spell:140886",
	specWarnRPS			= "Show special warning on what to use for $spell:141206"
})

L:SetMiscLocalization({
	rock			= "Rock",
	paper			= "Paper",
	scissors		= "Scissors"
})

-------------
-- Brawlers: Brumble --
-------------
L= DBM:GetModLocalization("BrawlRumble")

L:SetGeneralLocalization({
	name = "Brawlers: Rumble"
})
