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
	warnQueuePosition	= "현재 대기 순위 : %d번째",
	specWarnYourNext	= "다음이 당신 차례입니다!",
	specWarnYourTurn	= "당신 차례입니다!"
})

L:SetOptionLocalization({
	warnQueuePosition	= "대기 인원 변경시 당신이 몇 번째 순위인지 알림 보기",
	specWarnYourNext	= "다음 차례가 당신일 경우 특수 경고 보기",
	specWarnYourTurn	= "당신 차례가 오면 특수 경고 보기",
	SpectatorMode		= "관전중 일때도 알림/바 보기(개별 특수 경고 제외)",
	SpeakOutQueue		= "대기 인원 변경시 당신의 순위를 소리로 듣기"
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

L:SetOptionLocalization({
	SetIconOnBlat	= "브랏 본체에 전술 목표 아이콘 설정(해골)"
})

------------
-- Rank 4 --
------------
L= DBM:GetModLocalization("BrawlRank4")

L:SetGeneralLocalization({
	name = "싸움꾼: 4 계급"
})

L:SetOptionLocalization({
	SetIconOnDominika	= "환영술사 도미니카 본체에 전술 목표 아이콘 설정(해골)"
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

------------
-- Rank 9 --
------------
L= DBM:GetModLocalization("BrawlRank9")

L:SetGeneralLocalization({
	name = "싸움꾼: 9 계급"
})

-------------
-- Rares 1 --
-------------
L= DBM:GetModLocalization("BrawlLegacy")

L:SetGeneralLocalization({
	name = "싸움꾼: 도전(유산)"
})

L:SetOptionLocalization({
	SpeakOutStrikes		= "$spell:141190 공격 횟수를 소리로 듣기"
})

-------------
-- Rares 2 --
-------------
L= DBM:GetModLocalization("BrawlChallenges")

L:SetGeneralLocalization({
	name = "싸움꾼: 도전(특수)"
})

L:SetWarningLocalization({
	specWarnRPS			= "%s 내세요!"
})

L:SetOptionLocalization({
	ArrowOnBoxing		= "$spell:140868, $spell:140862, $spell:140886 활성화 중일때 DBM 화살표 보기",
	specWarnRPS			= "$spell:141206 진행 중일때 무엇을 내야할지 특수 경고 보기"
})

L:SetMiscLocalization({
	rock			= "바위",
	paper			= "보",
	scissors		= "가위"
})
