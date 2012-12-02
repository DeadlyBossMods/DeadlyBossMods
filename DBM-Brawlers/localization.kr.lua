if GetLocale() ~= "koKR" then return end
local L

-----------------------
-- Brawlers --
-----------------------
L= DBM:GetModLocalization("Brawlers")

L:SetGeneralLocalization({
	name = "기본 경고"
})

L:SetWarningLocalization({
	specWarnYourTurn	= "당신 차례입니다!"
})

L:SetOptionLocalization({
	specWarnYourTurn	= "당신 차례가 오면 특수 경고 보기",
	SpectatorMode		= "관전자 일때도 알림/바 보기"
})

L:SetMiscLocalization({
	Bizmo			= "Bizmo",
	--I wish there was a better way to do this....so much localizing. :(
	EnteringArena1	= "Now entering the arena",
	EnteringArena2	= "Here's our challenger",
	EnteringArena3	= "Look out... here comes",
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
})
