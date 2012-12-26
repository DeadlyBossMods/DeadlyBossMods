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

--[등장 메세지]
--투기장에 들어서는 건... 1계급 %s 입니다! %s은 여기 새로 온 친구니까, 살살 해봐요!
--요새 한창 잘나가는 2계급 사냥꾼, %s가 싸움장에 들어섭니다
--%s에게 박수를 부탁드립니다! %s는 3계급 주술사입니다.
--도전자가 나타났습니다. 4계급 언데드 흑마법사, %s를 환영해 주십시오!
--지금 싸움장에 주먹이 매콤한 주술사가 등장했습니다. 5계급 싸움꾼, %s게 인사하세요!
--조심하십시오... 무시무시한 6계급 언데드, %가 등장합니다!
--지금 싸움장에 들어서는 건... 돌아온 최고의 싸움꾼, 7계급 %s 입니다!
--드디어! 다들 아시죠? 다들 사랑하시죠? 8계급 싸움꾼, %s게 박수를 부탁드립니다!
--[승리 메세지]
--승자는 %s입니다!
--축하합니다, %s! 거기 투기장 밖에 피투성이 발자국은 남기지 마세요.
--멋진 승리였습니다, %s! 이제 다시 줄을 서세요.
--이런 이런 이런... %s가 이겼네요! 저도 돈을 좀 잃은 것 같아요.
--%s가 이겼습니다! %s가 이겼어요!
--멈추지 마시라고요, %s.
--끝났습니다! %s가 가까스로 살아남았습니다. 정말 아슬아슬했네요, %s!
--아하하하! 피가 줄줄 흐르네요! 아주 좋아요.
--[패배 메세지]
--솔직히 말할게요, %s... 대체 지금 뭘 하시는 건가요?
--안됐네요, %s. 이제 그 시체 좀 치워 주실래요? 다음 싸움꾼들이 기다리고 있어서요.
--아이코... 안됐네요, %s 님. 다시 도전해 보세요. 줄은 다시 서야 해요.
--아이구... 그렇게 아팠으니 많이 성숙해지겠어요.
--%s %s 우리 %s... 다음 번에는 이렇게 쉽게 죽지 마세요.
--우엑... 정말 처참하네요. 누가 사제나 뭐 그런 친구 하나 불러 줄래요?!
--지금까지 %s 였습니다.
--그거 참... 안 좋게 끝났네요.

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
	SetIconOnBlat	= "브랏 본체에 전술 목표 아이콘 설정 (해골)"
})

------------
-- Rank 4 --
------------
L= DBM:GetModLocalization("BrawlRank4")

L:SetGeneralLocalization({
	name = "싸움꾼: 4 계급"
})

L:SetOptionLocalization({
	SetIconOnDominika	= "환영술사 도미니카 본체에 전술 목표 아이콘 설정 (해골)"
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
