if GetLocale() ~= "zhTW" then return end
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
	name =	"玄鴉堡小怪"
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
	name =	"暗心灌木林小怪"
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
	specWarnStaticNova			= "靜電新星 - 快跑向沙洲",
	specWarnFocusedLightning	= "聚能閃電 - 快跑向水中"
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
	name =	"艾薩拉之眼小怪"
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
	tempestModeMessage		=	"不是耀眼風暴循環: %s。8秒後重新檢查。"
})

-----------------------
--Halls of Valor Trash
-----------------------
L = DBM:GetModLocalization("HoVTrash")

L:SetGeneralLocalization({
	name =	"英靈殿小怪"
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
	name =	"奈薩里奧巢穴小怪"
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
	batSpawn		=	"Reinforcements to me! NOW!"
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
	name =	"幽暗地道小怪"
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
	name =	"眾星之廷小怪"
})

L:SetOptionLocalization({
	SpyHelper	= "幫忙辨識間諜"
})

L:SetMiscLocalization({
	Gloves1			= "有傳聞說那個間諜一直戴著手套。",
	Gloves2			= "聽說那個間諜習慣把手藏起來。",
	Gloves3			= "我聽說那個間諜總是戴著手套。",
	Gloves4			= "有人說那位間諜總是穿著手套，因為手上有明顯的疤痕。",
	NoGloves1		= "有人說那個間諜從來不戴手套。",
	NoGloves2		= "你知道嗎…我剛在後房發現多的手套。那個間諜現在一定光著手。",
	NoGloves3		= "我聽到的是那個間諜根本不喜歡戴手套。",
	NoGloves4		= "聽說那名間諜盡量不戴手套，因為總有需要動作靈活的時候。",
	Cape1			= "剛剛有人說，間諜稍早進來時還穿著斗篷。",
	Cape2			= "聽說這個間諜很喜歡穿斗篷。",
	NoCape1			= "我剛聽說這個間諜討厭斗篷，所以絕對不穿斗篷。",
	NoCape2			= "我聽說間諜過來這裡之前把斗篷忘在皇宮了。",
	LightVest1		= "那位間諜特別喜歡淺顏色的外衣。",
	LightVest2		= "我剛聽說那個間諜今晚會穿著淺色的外衣。",
	LightVest3		= "人家說那個間諜今晚絕對不會穿深色外衣。",
	DarkVest1		= "間諜絕對比較喜歡深色衣服。",
	DarkVest2		= "聽說今晚那個間諜的外衣顏色很深。",
	DarkVest3		= "間諜喜歡顏色比較深的外衣…就像夜晚一樣。",
	DarkVest4		= "有個說法是那位間諜為了混入人群，特別避免淺色的衣著。",
	Female1			= "他們說間諜混進來了，而且她非常美貌。",
	Female2			= "聽說有個女人一直在打探這個地區的事情…",
	Female3			= "有人說間諜是女的。",
	Female4			= "有人看到她和艾莉珊德一起走進來。",
	Male1			= "我剛聽人家說間諜是男的。",
	Male2			= "我聽說間諜混進來了，而且長得很帥。",
	Male3			= "剛剛有人說看到他和大博學者一起走進去。",
	Male4			= "有個樂手說他一直在問關於這個地區的問題。",
	ShortSleeve1	= "我剛聽說那個間諜今晚穿短袖，這樣動作比較靈活。",
	ShortSleeve2	= "有人說那個間諜討厭長袖衣服。",
	ShortSleeve3	= "我朋友剛剛告訴我，她看到了，間諜沒穿長袖。",
	ShortSleeve4	= "聽說那個間諜喜歡今晚涼爽的天氣，所以不穿長袖。",
	LongSleeve1		= "聽說今晚那個間諜穿了長袖衣服。",
	LongSleeve2		= "剛剛有人說，間諜今晚為了能遮住手臂，才穿長袖的。",
	LongSleeve3		= "我剛剛碰巧看到那個間諜今晚穿著長袖衣服。",
	LongSleeve4		= "我朋友跟我說，那位間諜穿著長袖。",
	Potions1		= "聽說那個間諜帶了藥水…以防萬一。",
	Potions2		= "別說是我講的…那個間諜現在偽裝成鍊金師了，腰帶上繫著藥水瓶。",
	Potions3		= "聽說有間諜帶了藥水過來耶，不知道為什麼？",
	Potions4		= "我非常肯定那個間諜在腰帶上繫了藥水。",
	NoPotions1		= "我聽說那個間諜什麼藥水都沒帶。",
	NoPotions2		= "有個樂手告訴我，她看到間諜把最後一瓶藥水丟了，所以現在身上應該沒有藥水。",
	Book1			= "我聽說那個間諜在腰帶上掛著一本書，裡頭寫滿了各種秘密。",
	Book2			= "聽說那個間諜是喜歡讀書的人，不管到哪裡都會帶著一本書。",
	Pouch1			= "我聽說那位間諜總是帶著一個魔法小包。",
	Pouch2			= "我朋友說間諜喜歡黃金，所以腰帶上的隨身包裝滿黃金。",
	Pouch3			= "聽說間諜喜歡炫富，腰上的錢包裝滿金幣。",
	Pouch4			= "我聽說那名間諜的腰帶上有個口袋，口袋的刺繡非常精緻。",
	--
	Gloves		= "手套",
	NoGloves	= "沒有手套",
	Cape		= "斗篷",
	Nocape		= "沒有斗蓬",
	LightVest	= "淺色上衣",
	DarkVest	= "深色上衣",
	Female		= "女性",
	Male		= "男性",
	ShortSleeve = "短袖",
	LongSleeve	= "長袖",
	Potions		= "藥水瓶",
	NoPotions	= "無藥水瓶",
	Book		= "書本",
	Pouch		= "腰袋"
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
	name =	"靈魂之喉小怪"
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
	name =	"紫羅蘭堡之襲小怪"
})

L:SetWarningLocalization({
	WarningPortalSoon	= "準備開門",
	WarningPortalNow	= "第%d個傳送門",
	WarningBossNow		= "首領來了"
})

L:SetTimerLocalization({
	TimerPortal			= "傳送門冷卻"
})

L:SetOptionLocalization({
	WarningPortalNow		= "為新的傳送門顯示警告",
	WarningPortalSoon		= "為新的傳送門顯示準備警告",
	WarningBossNow			= "為首領到來顯示警告",
	TimerPortal				= "為擊殺首領後的傳送門顯示計時器"
})

L:SetMiscLocalization({
	Malgath		=	"馬爾加斯領主"
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
	name =	"看守者鐵獄小怪"
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
--Return To Karazhan Trash
-----------------------
L = DBM:GetModLocalization("RTKTrash")

L:SetGeneralLocalization({
	name =	"重返卡拉贊小怪"
})

L:SetMiscLocalization({
	speedRun		="一陣詭異的冷風吹了過來…"
})

-----------------------
-- <<<Cathedral of Eternal Night >>> --
-----------------------
-----------------------
-- Agronox --
-----------------------
L= DBM:GetModLocalization(1905)

-----------------------
-- Trashbite the Scornful  --
-----------------------
L= DBM:GetModLocalization(1906)

-----------------------
-- Domatrax --
-----------------------
L= DBM:GetModLocalization(1904)

-----------------------
-- Mephistroth  --
-----------------------
L= DBM:GetModLocalization(1878)

-----------------------
--Cathedral of Eternal Night Trash
-----------------------
L = DBM:GetModLocalization("CoENTrash")

L:SetGeneralLocalization({
	name =	"Cathedral of Eternal Night Trash"--Maybe something shorter?
})
