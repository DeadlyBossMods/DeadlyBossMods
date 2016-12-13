if GetLocale() ~= "koKR" then return end
local L

-----------------------
-- <<<Black Rook Hold>>> --
-----------------------
-----------------------
-- The Amalgam of Souls --
-----------------------
L= DBM:GetModLocalization(1518)

-----------------------
-- Illysanna Ravencrest --
-----------------------
L= DBM:GetModLocalization(1653)

-----------------------
-- Smashspite the Hateful --
-----------------------
L= DBM:GetModLocalization(1664)

-----------------------
-- Lord Kur'talos Ravencrest --
-----------------------
L= DBM:GetModLocalization(1672)

-----------------------
--Black Rook Hold Trash
-----------------------
L = DBM:GetModLocalization("BRHTrash")

L:SetGeneralLocalization({
	name =	"검은 떼까마귀 요새 일반몹"
})

-----------------------
-- <<<Darkheart Thicket>>> --
-----------------------
-----------------------
-- Arch-Druid Glaidalis --
-----------------------
L= DBM:GetModLocalization(1654)

-----------------------
-- Oakheart --
-----------------------
L= DBM:GetModLocalization(1655)

-----------------------
-- Dresaron --
-----------------------
L= DBM:GetModLocalization(1656)

-----------------------
-- Shade of Xavius --
-----------------------
L= DBM:GetModLocalization(1657)

-----------------------
--Darkheart Thicket Trash
-----------------------
L = DBM:GetModLocalization("DHTTrash")

L:SetGeneralLocalization({
	name =	"어둠심장 숲 일반몹"
})


-----------------------
-- <<<Eye of Azshara>>> --
-----------------------
-----------------------
-- Warlord Parjesh --
-----------------------
L= DBM:GetModLocalization(1480)

-----------------------
-- Lady Hatecoil --
-----------------------
L= DBM:GetModLocalization(1490)

L:SetWarningLocalization({
	specWarnStaticNova			= "정전기 회오리 - 땅으로 이동",
	specWarnFocusedLightning	= "집중된 번개 - 물로 이동"
})

-----------------------
-- King Deepbeard --
-----------------------
L= DBM:GetModLocalization(1491)

-----------------------
-- Serpentrix --
-----------------------
L= DBM:GetModLocalization(1479)

-----------------------
-- Wrath of Azshara --
-----------------------
L= DBM:GetModLocalization(1492)

-----------------------
--Eye of Azshara Trash
-----------------------
L = DBM:GetModLocalization("EoATrash")

L:SetGeneralLocalization({
	name =	"아즈샤라의 눈 일반몹"
})

-----------------------
-- <<<Halls of Valor>>> --
-----------------------
-----------------------
-- Hymdall --
-----------------------
L= DBM:GetModLocalization(1485)

-----------------------
-- Hyrja --
-----------------------
L= DBM:GetModLocalization(1486)

-----------------------
-- Fenryr --
-----------------------
L= DBM:GetModLocalization(1487)

-----------------------
-- God-King Skovald --
-----------------------
L= DBM:GetModLocalization(1488)

-----------------------
-- Odyn --
-----------------------
L= DBM:GetModLocalization(1489)

L:SetMiscLocalization({
	tempestModeMessage		=	"폭풍우 시퀀스 아님: %s. 8초 후 다시 검사합니다."
})

-----------------------
--Halls of Valor Trash
-----------------------
L = DBM:GetModLocalization("HoVTrash")

L:SetGeneralLocalization({
	name =	"용맹의 전당 일반몹"
})

-----------------------
-- <<<Neltharion's Lair>>> --
-----------------------
-----------------------
-- Rokmora --
-----------------------
L= DBM:GetModLocalization(1662)

-----------------------
-- Ularogg Cragshaper --
-----------------------
L= DBM:GetModLocalization(1665)

-----------------------
-- Naraxas --
-----------------------
L= DBM:GetModLocalization(1673)

-----------------------
-- Dargrul the Underking --
-----------------------
L= DBM:GetModLocalization(1687)

-----------------------
--Neltharion's Lair Trash
-----------------------
L = DBM:GetModLocalization("NLTrash")

L:SetGeneralLocalization({
	name =	"넬타리온의 둥지 일반몹"
})

-----------------------
-- <<<The Arcway>>> --
-----------------------
-----------------------
-- Ivanyr --
-----------------------
L= DBM:GetModLocalization(1497)

-----------------------
-- Nightwell Sentry --
-----------------------
L= DBM:GetModLocalization(1498)

-----------------------
-- General Xakal --
-----------------------
L= DBM:GetModLocalization(1499)

L:SetMiscLocalization({
	batSpawn		=	"나에게 박쥐 붙음!"
})

-----------------------
-- Nal'tira --
-----------------------
L= DBM:GetModLocalization(1500)

-----------------------
-- Advisor Vandros --
-----------------------
L= DBM:GetModLocalization(1501)

-----------------------
--The Arcway Trash
-----------------------
L = DBM:GetModLocalization("ArcwayTrash")

L:SetGeneralLocalization({
	name =	"비전로 일반몹"
})

-----------------------
-- <<<Court of Stars>>> --
-----------------------
-----------------------
-- Patrol Captain Gerdo --
-----------------------
L= DBM:GetModLocalization(1718)

-----------------------
-- Talixae Flamewreath --
-----------------------
L= DBM:GetModLocalization(1719)

-----------------------
-- Advisor Melandrus --
-----------------------
L= DBM:GetModLocalization(1720)

-----------------------
--Court of Stars Trash
-----------------------
L = DBM:GetModLocalization("CoSTrash")

L:SetGeneralLocalization({
	name =	"별의 궁정 일반몹"
})

L:SetOptionLocalization({
	SpyHelper	= "첩자 색출 도우미"
})

L:SetMiscLocalization({
	Gloves1		= "그 첩자는 항상 장갑을 낀다고 하더군요.",
	Gloves2		= "제가 듣기로는, 그 첩자는 항상 신경 써서 손을 가린다고 합니다.",
	Gloves3		= "그 첩자는 항상 장갑을 낀다고 들었습니다.",
	Gloves4		= "그 첩자는 손에 있는 선명한 흉터를 가리려고 장갑을 낀다고 합니다.",
	NoGloves1	= "그 첩자는 장갑을 끼는 일이 없다고 하더군요.",
	NoGloves2	= "안쪽 방에서 장갑 한 켤레를 발견했습니다. 첩자는 분명히 이 주변에 장갑을 끼지 않은 사람중 하나일 거에요.",
	NoGloves3	= "그 첩자는 장갑을 끼는 걸 싫어한다고 들었습니다.",
	NoGloves4	= "그 첩자는 장갑을 끼지 않는답니다. 위급한 순간에 걸리적거려서 그렇겠지요.",
	Cape1		= "그 첩자가 망토를 걸친 모습을 봤다는 사람이 있었습니다.",
	Cape2		= "그 첩자는 망토를 즐겨 입는다고 들었습니다.",
	NoCape1		= "그 첩자는 망토를 싫어해서 절대로 입지 않는다고 합니다.",
	NoCape2		= "제가 듣기로는 그 첩자가 궁전에 망토를 벗어두고 여기 왔다고 합니다.",
	LightVest1	= "그자는 첩자인데도 밝은색 조끼를 즐겨 입는다고 합니다.",
	LightVest2	= "오늘 밤 파티에 그 첩자는 밝은색 조끼를 입고 올 거라는 말을 들었습니다.",
	LightVest3	= "사람들이 그러는데, 오늘 밤 그 첩자는 어두운 색 조끼를 입지 않았다고 합니다.",
	DarkVest1	= "그 첩자는 분명 어두운 옷을 선호합니다.",
	DarkVest2	= "오늘 밤 그 첩자는 어둡고 짙은 색의 조끼를 입었다고 합니다.",
	DarkVest3	= "그 첩자는 어두운 색 조끼를 즐겨 입어요... 밤과 같은 색이죠.",
	DarkVest4	= "소문에 그 첩자는 눈에 띄지 않으려고 밝은색 옷은 피한다더군요.",
	Female1		= "첩자가 나타났다고 합니다. 그 여자는 아주 미인이라고도 하더군요.",
	Female2		= "어떤 여자가 귀족 지구에 관해 계속 묻고 다닌다고 하던데...",
	Female3		= "그 불청객은 남자가 아니라는 말을 들었습니다.",
	Female4		= "아까 한 방문객이 그녀와 엘리산드가 함께 도착하는 걸 보았답니다.",
	Male1		= "첩자가 여성이 아니라는 얘기를 들었습니다.",
	Male2		= "첩자가 나타났다고 합니다. 그 남자는 대단히 호감형이라고도 하더군요.",
	Male3		= "한 남자가 대마법학자와 나란히 저택에 들어오는 걸 봤다는 얘기가 있더군요.",
	Male4		= "한 연주자가 말하길, 그 남자가 끊임없이 그 지구에 관한 질문을 늘어놨다고 합니다.",
	ShortSleave1= "그 첩자는 팔을 빠르게 움직이려고 짧은 소매 옷만 고집한다고 합니다.",
	ShortSleave2= "그 첩자는 소매가 긴 옷을 입는 걸 정말 싫어한다고 합니다.",
	ShortSleave3= "제 친구가 그 첩자가 입은 옷을 봤는데, 긴 소매는 아니었다는군요!",
	ShortSleave4= "그 첩자는 시원한 걸 좋아해서 오늘 밤 짧은 소매를 입고 왔다고 들었습니다.",
	LongSleave1 = "오늘 밤 첩자는 긴 소매 옷을 입었다고 하더군요.",
	LongSleave2 = "오늘 밤 그 첩자는 소매가 긴 옷을 입었다고 들었어요.",
	LongSleave3 = "초저녁에 첩자를 언뜻 보았는데... 긴 소매 옷을 입었던 것 같습니다.",
	LongSleave4 = "제 친구 말로는, 첩자가 긴 소매 옷을 입었다고 합니다.",
	Potions1	= "그 첩자는 물약을 가지고 다닌데요. 이유가 뭘까요?",
	Potions2	= "이 얘기를 깜빡할 뻔했네요... 그 첩자는 연금술사로 가장해 허리띠에 물약을 달고 다닌다고 합니다.",
	Potions3	= "그 첩자는 허리띠에 물약을 매달고 있을 게 분명합니다. 있는 게 분명해요.",
	NoPotions1	= "그 첩자는 물약을 가지고 다니지 않는다고 합니다.",
	NoPotions2	= "한 연주자가 그 첩자가 마지막 물약을 버리는 걸 봤다고 합니다. 그러니 더는 물약이 없겠죠.",
	Book1		= "그 첩자의 허리띠 주머니에는 비밀이 잔뜩 적힌 책이 담겨 있다고 합니다.",
	Book2		= "소문을 들어 보니, 그 첩자는 독서를 좋아해서 항상 책을 가지고 다닌다고 합니다.",
	Pouch1		= "그 첩자는 마법의 주머니를 항상 가지고 다닌다고 들었습니다.",
	Pouch2		= "제 친구가 말하길, 그 첩자는 금을 너무 좋아해서 허리띠 주머니에도 금이 가득 들어 있다고 합니다.",
	Pouch3		= "그 첩자는 어찌나 사치스러운지 허리띠에 달린 주머니에 금화를 잔뜩 넣어서 다닌다고 합니다.",
	Pouch4		= "그 첩자는 허리띠 주머니도 휘황찬란한 자수로 꾸며져 있다고 합니다."
})


-----------------------
-- <<<The Maw of Souls>>> --
-----------------------
-----------------------
-- Ymiron, the Fallen King --
-----------------------
L= DBM:GetModLocalization(1502)

-----------------------
-- Harbaron --
-----------------------
L= DBM:GetModLocalization(1512)

-----------------------
-- Helya --
-----------------------
L= DBM:GetModLocalization(1663)

-----------------------
--Maw of Souls Trash
-----------------------
L = DBM:GetModLocalization("MawTrash")

L:SetGeneralLocalization({
	name =	"영혼의 아귀 일반몹"
})

-----------------------
-- <<<Assault Violet Hold>>> --
-----------------------
-----------------------
-- Mindflayer Kaahrj --
-----------------------
L= DBM:GetModLocalization(1686)

-----------------------
-- Millificent Manastorm --
-----------------------
L= DBM:GetModLocalization(1688)

-----------------------
-- Festerface --
-----------------------
L= DBM:GetModLocalization(1693)

-----------------------
-- Shivermaw --
-----------------------
L= DBM:GetModLocalization(1694)

-----------------------
-- Blood-Princess Thal'ena --
-----------------------
L= DBM:GetModLocalization(1702)

-----------------------
-- Anub'esset --
-----------------------
L= DBM:GetModLocalization(1696)

-----------------------
-- Sael'orn --
-----------------------
L= DBM:GetModLocalization(1697)

-----------------------
-- Fel Lord Betrug --
-----------------------
L= DBM:GetModLocalization(1711)

-----------------------
--Assault Violet Hold Trash
-----------------------
L = DBM:GetModLocalization("AVHTrash")

L:SetGeneralLocalization({
	name =	"보랏빛 요새 침공 일반몹"
})

L:SetWarningLocalization({
	WarningPortalSoon	= "곧 새 차원문 열림",
	WarningPortalNow	= "차원문 #%d",
	WarningBossNow		= "보스 등장"
})

L:SetTimerLocalization({
	TimerPortal			= "차원문 가능"
})

L:SetOptionLocalization({
	WarningPortalNow		= "새 차원문 등장시 경고 표시",
	WarningPortalSoon		= "새 차원문 사전 경고 표시",
	WarningBossNow			= "보스 등장 경고 표시",
	TimerPortal				= "다음 차원문 타이머 표시 (보스 처치 이후)"
})

L:SetMiscLocalization({
	Malgath		=	"군주 말가스"
})

-----------------------
-- <<<Vault of the Wardens>>> --
-----------------------
-----------------------
-- Tirathon Saltheril --
-----------------------
L= DBM:GetModLocalization(1467)

-----------------------
-- Inquisitor Tormentorum --
-----------------------
L= DBM:GetModLocalization(1695)

-----------------------
-- Ash'golm --
-----------------------
L= DBM:GetModLocalization(1468)

-----------------------
-- Glazer --
-----------------------
L= DBM:GetModLocalization(1469)

-----------------------
-- Cordana --
-----------------------
L= DBM:GetModLocalization(1470)

-----------------------
--Vault of Wardens Trash
-----------------------
L = DBM:GetModLocalization("VoWTrash")

L:SetGeneralLocalization({
	name =	"감시관의 금고 일반몹"
})

-----------------------
-- <<<Return To Karazhan>>> --
-----------------------
-----------------------
-- Maiden of Virtue --
-----------------------
L= DBM:GetModLocalization(1825)

-----------------------
-- Opera Hall: Wikket  --
-----------------------
L= DBM:GetModLocalization(1820)

-----------------------
-- Opera Hall: Westfall Story --
-----------------------
L= DBM:GetModLocalization(1826)

-----------------------
-- Opera Hall: Beautiful Beast  --
-----------------------
L= DBM:GetModLocalization(1827)

-----------------------
-- Attumen the Huntsman --
-----------------------
L= DBM:GetModLocalization(1835)

-----------------------
-- Moroes --
-----------------------
L= DBM:GetModLocalization(1837)

-----------------------
-- The Curator --
-----------------------
L= DBM:GetModLocalization(1836)

-----------------------
-- Shade of Medivh --
-----------------------
L= DBM:GetModLocalization(1817)

-----------------------
-- Mana Devourer --
-----------------------
L= DBM:GetModLocalization(1818)

-----------------------
-- Viz'aduum the Watcher --
-----------------------
L= DBM:GetModLocalization(1838)

-----------------------
--Nightbane
-----------------------
L = DBM:GetModLocalization("Nightbane")

L:SetGeneralLocalization({
	name =	"파멸의 어둠"
})

-----------------------
--Return To Karazhan Trash
-----------------------
L = DBM:GetModLocalization("RTKTrash")

L:SetGeneralLocalization({
	name =	"다시 찾은 카라잔 일반몹"
})

L:SetMiscLocalization({
	speedRun		=	"어둠의 존재를 알리는 기묘한 한기가 주위에 퍼져나갑니다..."
})

