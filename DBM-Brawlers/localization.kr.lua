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
	specWarnYourTurn	= "당신 차례입니다!",
	specWarnRumble		= "난장!"
})

L:SetOptionLocalization({
	warnQueuePosition2	= "대기 순번 갱신시 몇번째에 있는지 알림",
	specWarnYourNext	= "다음 차례일 때 특별 경고 보기",
	specWarnYourTurn	= "내 차례가 되면 특별 경고 보기",
	specWarnRumble		= "누군가 난장을 시작했을 때 특별 경고 보기",
	SpectatorMode		= "관전시에도 경고/타이머 바 보기<br/>(개인용 '특별 경고' 메시지는 관전자에겐 보이지 않습니다)",
	SpeakOutQueue		= "대기 순번 갱신시 내 차례를 불러줍니다",
	NormalizeVolume		= "싸움꾼 조합에 들어오면 자동으로 대화 채널의 음량을 소리(효과음) 채널 음량과 균일하게 만들어 관중의 환호성 소리를 줄입니다."
})

L:SetMiscLocalization({
	Bizmo			= "비즈모",--Alliance
	Bazzelflange	= "대표 바젤플랜지",--Horde
	--Alliance pre berserk
	BizmoIgnored	= "We Don't have all night. Hurry it up already!",
	BizmoIgnored2	= "Do you smell smoke?",
	BizmoIgnored3	= "I think it's about time to call this fight.",
	BizmoIgnored4	= "Is it getting hot in here? Or is it just me?",
	BizmoIgnored5	= "불길이 다가옵니다!",
	BizmoIgnored6	= "I think we've seen just about enough of this. Am I right?",
	BizmoIgnored7	= "We've got a whole list of people who want to fight, you know.",
	--Horde pre berserk
	BazzelIgnored	= "이봐요! 다들 좀 서두르세요!",
	BazzelIgnored2	= "아이고... 연기 냄새가 나는데요...",
	BazzelIgnored3	= "시간이 거의 다 됐어요!",
	BazzelIgnored4	= "열기가 점점 뜨거워지나요?",
	BazzelIgnored5	= "불길이 다가옵니다!",
	BazzelIgnored6	= "이제 슬슬 지겹네요. 다들 그렇죠?",
	BazzelIgnored7	= "Alright, alright. We've got a line going out here, you know.",
	--I wish there was a better way to do this....so much localizing. :(
	Rank1			= "1계급",
	Rank2			= "2계급",
	Rank3			= "3계급",
	Rank4			= "4계급",
	Rank5			= "5계급",
	Rank6			= "6계급",
	Rank7			= "7계급",
	Rank8			= "8계급",
--	Rank9			= "9계급",
--	Rank10			= "10계급",
	Rumbler			= "싸움꾼",
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

L:SetOptionLocalization({
	SetIconOnBlat	= "브랏 본체에 공격대 징표 설정(해골)"
})

L:SetMiscLocalization({
	Sand			= "모래"
})

------------
-- Rank 3 --
------------
L= DBM:GetModLocalization("BrawlRank3")

L:SetGeneralLocalization({
	name = "싸움꾼: 3계급"
})

------------
-- Rank 4 --
------------
L= DBM:GetModLocalization("BrawlRank4")

L:SetGeneralLocalization({
	name = "싸움꾼: 4계급"
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
-- Brawlers: Rumble --
-------------
L= DBM:GetModLocalization("BrawlRumble")

L:SetGeneralLocalization({
	name = "싸움꾼: 난장"
})

-------------
-- Brawlers: Legacy --
-------------
L= DBM:GetModLocalization("BrawlLegacy")

L:SetGeneralLocalization({
	name = "싸움꾼: 기타"
})

L:SetOptionLocalization({
	SpeakOutStrikes		= "$spell:141190의 공격 횟수를 소리로 듣기"
})

-------------
-- Brawlers: Challenges --
-------------
L= DBM:GetModLocalization("BrawlChallenges")

L:SetGeneralLocalization({
	name = "싸움꾼: 기타 2"
})

L:SetWarningLocalization({
	specWarnRPS			= "%s|1을;를; 내세요!"
})

L:SetOptionLocalization({
	ArrowOnBoxing		= "$spell:140868, $spell:140862, $spell:140886|1을;를; 시전하는 동안 DBM 화살표 보기",
	specWarnRPS			= "$spell:141206에서 내야하는 것 특별 경고 보기"
})

L:SetMiscLocalization({
	rock			= "바위",
	paper			= "보",
	scissors		= "가위"
})
