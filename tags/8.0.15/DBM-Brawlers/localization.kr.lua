if GetLocale() ~= "koKR" then return end
local L

--------------
-- Brawlers --
--------------
L= DBM:GetModLocalization("Brawlers")

L:SetGeneralLocalization({
	name = "싸움꾼: 일반"
})

L:SetWarningLocalization({
	warnQueuePosition2	= "대기 순번 %d번 입니다",
	specWarnYourNext	= "다음이 당신 차례입니다!",
	specWarnYourTurn	= "당신 차례입니다!"
})

L:SetOptionLocalization({
	warnQueuePosition2	= "대기 순번 변경시 몇번째 대기열에 있는지 알림 보기",
	specWarnYourNext	= "다음 차례일 때 특수 경고 보기",
	specWarnYourTurn	= "당신 차례가 되면 특수 경고 보기",
	SpectatorMode		= "관전할때도 경고/타이머 바 보기<br/>(개인별로 나오는 '특수 경고' 메시지는 관전자에겐 보이지 않습니다)",
	SpeakOutQueue		= "대기 순번 변경시 당신의 순번을 음성으로 불러주기",
	NormalizeVolume		= "싸움꾼 투기장에선 자동으로 대화 사운드 채널의 음량을 소리(효과음) 사운드 채널 음량에 맞춰 일정하게 만들기 때문에 관중석의 환호성이 크게 들리지 않습니다."
})

L:SetMiscLocalization({
	Bizmo			= "비즈모",--Alliance
	Bazzelflange	= "대표 바젤플랜지",--Horde
	--I wish there was a better way to do this....so much localizing. :(
	Rank1			= "1계급",
	Rank2			= "2계급",
	Rank3			= "3계급",
	Rank4			= "4계급",
	Rank5			= "5계급",
	Rank6			= "6계급",
	Rank7			= "7계급",
	Rank8			= "8계급",
	Rank9			= "9계급",
	Rank10			= "10계급",
	Proboskus		= "프로보스쿠스와",--Alliance
	Proboskus2		= "하하! 정말 운이 없군요! 프로보스쿠스입니다! 아하하하! 당신이 불길 속에서 죽는다에 25골드를 걸었어요!"--Horde
})

------------
-- Rank 1 --
------------
L= DBM:GetModLocalization("BrawlRank1")

L:SetGeneralLocalization({
	name = "싸움꾼: 1계급"
})

------------
-- Rank 2 --
------------
L= DBM:GetModLocalization("BrawlRank2")

L:SetGeneralLocalization({
	name = "싸움꾼: 2계급"
})

------------
-- Rank 3 --
------------
L= DBM:GetModLocalization("BrawlRank3")

L:SetGeneralLocalization({
	name = "싸움꾼: 3계급"
})

L:SetOptionLocalization({
	SetIconOnBlat	= "브랏 본체에 전술 목표 아이콘 설정(해골)"
})

------------
-- Rank 4 --
------------
L= DBM:GetModLocalization("BrawlRank4")

L:SetGeneralLocalization({
	name = "싸움꾼: 4계급"
})

L:SetOptionLocalization({
	SetIconOnDominika	= "환영술사 도미니카 본체에 전술 목표 아이콘 설정(해골)"
})

------------
-- Rank 5 --
------------
L= DBM:GetModLocalization("BrawlRank5")

L:SetGeneralLocalization({
	name = "싸움꾼: 5계급"
})

------------
-- Rank 6 --
------------
L= DBM:GetModLocalization("BrawlRank6")

L:SetGeneralLocalization({
	name = "싸움꾼: 6계급"
})

------------
-- Rank 7 --
------------
L= DBM:GetModLocalization("BrawlRank7")

L:SetGeneralLocalization({
	name = "싸움꾼: 7계급"
})

--[[
------------
-- Rank 8 --
------------
L= DBM:GetModLocalization("BrawlRank8")

L:SetGeneralLocalization({
	name = "싸움꾼: 8계급"
})

------------
-- Rank 9 --
------------
L= DBM:GetModLocalization("BrawlRank9")

L:SetGeneralLocalization({
	name = "싸움꾼: 9계급"
})
--]]

-------------
-- Brawlers: Legacy --
-------------
L= DBM:GetModLocalization("BrawlLegacy")

L:SetGeneralLocalization({
	name = "싸움꾼: 유산"
})

L:SetOptionLocalization({
	SpeakOutStrikes		= "$spell:141190의 공격 횟수를 소리로 듣기"
})

-------------
-- Brawlers: Challenges --
-------------
L= DBM:GetModLocalization("BrawlChallenges")

L:SetGeneralLocalization({
	name = "싸움꾼: 도전"
})

L:SetWarningLocalization({
	specWarnRPS			= "%s 내세요!"
})

L:SetOptionLocalization({
	ArrowOnBoxing		= "$spell:140868, $spell:140862, $spell:140886|1을;를; 시전하는 동안 DBM 화살표 보기",
	specWarnRPS			= "$spell:141206에서 내야하는 것 특수 경고 보기"
})

L:SetMiscLocalization({
	rock			= "바위",
	paper			= "보",
	scissors		= "가위"
})

-------------
-- Brawlers: Rumble --
-------------
L= DBM:GetModLocalization("BrawlRumble")

L:SetGeneralLocalization({
	name = "싸움꾼: 난장"
})
