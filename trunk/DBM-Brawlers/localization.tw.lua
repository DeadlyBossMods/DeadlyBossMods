if GetLocale() ~= "zhTW" then return end
local L

-----------------------
-- Brawlers --
-----------------------
L= DBM:GetModLocalization("Brawlers")

L:SetGeneralLocalization({
	name = "鬥陣俱樂部:一般"
})

L:SetWarningLocalization({
	specWarnYourTurn	= "輪到你上場了!"
})

L:SetOptionLocalization({
	specWarnYourTurn	= "輪到你上時顯示特別警告",
	SpectatorMode		= "當旁觀戰鬥時顯示警告/計時器(旁觀者不會顯示個人的特別警告訊息)"
})

L:SetMiscLocalization({
	Bizmo			= "畢茲摩",--Alliance
	Bazzelflange	= "老闆貝索佛蘭吉",--Horde
	--I wish there was a better way to do this....so much localizing. :(
	Rank1			= "第1階",
	Rank2			= "第2階",
	Rank3			= "第3階",
	Rank4			= "第4階",
	Rank5			= "第5階",
	Rank6			= "第6階",
	Rank7			= "第7階",
	Rank8			= "第8階",
--[[	Victory1		= "is our victor",
	Victory2		= "Congratulations",
	Victory3		= "Brilliant victory",
	Victory4		= "wins",
	Victory5		= "Keep 'em comin'",
	Victory6		= "Great job not dying",
	Victory7		= "So much blood! Nice",
	Lost1			= "were you even trying",
	Lost2			= "Now would you kindly remove your corpse",
	Lost3			= "Get back in line and try again",
	Lost4			= "you're gonna have to break a few eggs",
	Lost5			= "try not to die so much",
	Lost6			= "what a mess",
	Lost7			= "name was",--LoL at fight club reference here
	Lost8			= "did not end well",--]]
	Proboskus		= "Oh dear... I'm sorry, but it looks like you're going to have to fight Proboskus."--This boss is only boss out of 32 that has a custom berserk, so we need a chat yell to detect when he specificly is pulled to adjust berserk timer--
})

------------
-- Rank 1 --
------------
L= DBM:GetModLocalization("BrawlRank1")

L:SetGeneralLocalization({
	name = "鬥陣俱樂部:第1階"
})

------------
-- Rank 2 --
------------
L= DBM:GetModLocalization("BrawlRank2")

L:SetGeneralLocalization({
	name = "鬥陣俱樂部:第2階"
})

------------
-- Rank 3 --
------------
L= DBM:GetModLocalization("BrawlRank3")

L:SetGeneralLocalization({
	name = "鬥陣俱樂部:第3階"
})

------------
-- Rank 4 --
------------
L= DBM:GetModLocalization("BrawlRank4")

L:SetGeneralLocalization({
	name = "鬥陣俱樂部:第4階"
})

------------
-- Rank 5 --
------------
L= DBM:GetModLocalization("BrawlRank5")

L:SetGeneralLocalization({
	name = "鬥陣俱樂部:第5階"
})

------------
-- Rank 6 --
------------
L= DBM:GetModLocalization("BrawlRank6")

L:SetGeneralLocalization({
	name = "鬥陣俱樂部:第6階"
})

------------
-- Rank 7 --
------------
L= DBM:GetModLocalization("BrawlRank7")

L:SetGeneralLocalization({
	name = "鬥陣俱樂部:第7階"
})

------------
-- Rank 8 --
------------
L= DBM:GetModLocalization("BrawlRank8")

L:SetGeneralLocalization({
	name = "鬥陣俱樂部:第8階"
})
