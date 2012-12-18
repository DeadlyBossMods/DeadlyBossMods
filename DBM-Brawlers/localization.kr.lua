if GetLocale() ~= "koKR" then return end
local L

--------------
-- Brawlers --
--------------
L= DBM:GetModLocalization("Brawlers")

L:SetGeneralLocalization({
	name = "기본 설정"
})

L:SetWarningLocalization({
	specWarnYourTurn	= "당신 차례입니다!"
})

L:SetOptionLocalization({
	specWarnYourTurn	= "당신 차례가 오면 특수 경고 보기",
	SpectatorMode		= "관전자 일때도 알림/바 보기"
})

L:SetMiscLocalization({
--	Bizmo			= "Bizmo",
	--I wish there was a better way to do this....so much localizing. :(
--	Rank			= "(%d+) 계급",--Experimental "Entering arena" detection by scanning for Rank plus number
--	EnteringArena1	= "Now entering the arena",
--	EnteringArena2	= "Here's our challenger",
--	EnteringArena3	= "Look out... here comes",
--	EnteringArena4	= "Put your hands together",
	Rank1			= "1 계급",
	Rank2			= "2 계급",
	Rank3			= "3 계급",
	Rank4			= "4 계급",
	Rank5			= "5 계급",
	Rank6			= "6 계급",
	Rank7			= "7 계급",
	Rank8			= "8 계급",
	Victory1		= "is our victor",
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
	Lost8			= "His name was",--LoL at fight club reference here
	Lost9			= "did not end well"
})

------------
-- Rank 1 --
------------
L= DBM:GetModLocalization("BrawlRank1")

L:SetGeneralLocalization({
	name = "싸움꾼: 1 계급"
})

------------
-- Rank 2 --
------------
L= DBM:GetModLocalization("BrawlRank2")

L:SetGeneralLocalization({
	name = "싸움꾼: 2 계급"
})

------------
-- Rank 3 --
------------
L= DBM:GetModLocalization("BrawlRank3")

L:SetGeneralLocalization({
	name = "싸움꾼: 3 계급"
})

------------
-- Rank 4 --
------------
L= DBM:GetModLocalization("BrawlRank4")

L:SetGeneralLocalization({
	name = "싸움꾼: 4 계급"
})

------------
-- Rank 5 --
------------
L= DBM:GetModLocalization("BrawlRank5")

L:SetGeneralLocalization({
	name = "싸움꾼: 5 계급"
})

------------
-- Rank 6 --
------------
L= DBM:GetModLocalization("BrawlRank6")

L:SetGeneralLocalization({
	name = "싸움꾼: 6 계급"
})

------------
-- Rank 7 --
------------
L= DBM:GetModLocalization("BrawlRank7")

L:SetGeneralLocalization({
	name = "싸움꾼: 7 계급"
})

------------
-- Rank 8 --
------------
L= DBM:GetModLocalization("BrawlRank8")

L:SetGeneralLocalization({
	name = "싸움꾼: 8 계급"
})
