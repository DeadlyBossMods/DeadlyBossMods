if GetLocale() ~= "koKR" then return end
local L

--------------
-- Brawlers --
--------------
L= DBM:GetModLocalization("Brawlers")

L:SetGeneralLocalization({
	name = "싸움꾼: 일반 설정"
})

L:SetWarningLocalization({
	specWarnYourTurn	= "당신 차례입니다!"
})

L:SetOptionLocalization({
	specWarnYourTurn	= "당신 차례가 오면 특수 경고 보기",
	SpectatorMode		= "관전중 일때도 알림/바 보기\n(개인별 특수 경고는 관전자에게 보이지 않습니다.)"
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
	Proboskus		= "하하! 정말 운이 없군요! 프로보스쿠스입니다! 아하하하! 당신이 불길 속에서 죽는다에 25골드를 걸었어요!"
})

--[등장 메세지들]-
--투기장에 들어서는 건... 1계급 %s 입니다! %s은 여기 새로 온 친구니까, 살살 해봐요!
--요새 한창 잘나가는 2계급 사냥꾼, %s가 싸움장에 들어섭니다
--%s에게 박수를 부탁드립니다! %s는 3계급 주술사입니다.
--도전자가 나타났습니다. 4계급 언데드 흑마법사, %s를 환영해 주십시오!
--지금 싸움장에 주먹이 매콤한 주술사가 등장했습니다. 5계급 싸움꾼, %s게 인사하세요!
--조심하십시오... 무시무시한 6계급 언데드, %가 등장합니다!
--지금 싸움장에 들어서는 건... 돌아온 최고의 싸움꾼, 7계급 %s 입니다!
--드디어! 다들 아시죠? 다들 사랑하시죠? 8계급 싸움꾼, %s게 박수를 부탁드립니다!

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
