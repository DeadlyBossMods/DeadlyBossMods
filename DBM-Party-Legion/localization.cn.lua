-- Mini Dragon(projecteurs@gmail.com)
-- 夏一可
-- Blizzard Entertainment
-- Last update: Feb 06 2017, 02:50 UTC@15833

if GetLocale() ~= "zhCN" then return end
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
	name =	"黑鸦堡垒小怪"
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
	name =	"黑心林地小怪"
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
	specWarnStaticNova			= "静电新星 - 快站沙丘",
	specWarnFocusedLightning	= "凝聚闪电 - 快进水域"
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
	name =	"艾萨拉之眼小怪"
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
	tempestModeMessage		=	"非明光风暴序列: %s. 8秒后再检查."
})

-----------------------
--Halls of Valor Trash
-----------------------
L = DBM:GetModLocalization("HoVTrash")

L:SetGeneralLocalization({
	name =	"英灵殿小怪"
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
	name =	"奈萨里奥的巢穴小怪"
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
	batSpawn		=	"援助我！快！" --offical
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
	name =	"魔法回廊小怪"
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
	name =	"群星庭院小怪"
})

L:SetOptionLocalization({
	SpyHelper	= "帮忙识别密探"
})

L:SetMiscLocalization({ --神坑
	Gloves1		= "有传言说那个密探总是带着手套。",
	Gloves2		= "我听说密探都会小心隐藏自己的双手。",
	Gloves3		= "我听说那个密探总是带着手套。",
	Gloves4		= "有人说那个密探带着手套，以掩盖手上明显的疤痕。",
	NoGloves1	= "有传言说那个密探从来不戴手套。",
	NoGloves2	= "你知道吗……我在后头的房间里发现了一双多余的手套。那个密探现在可能就赤着双手在这附近转悠呢。",
	NoGloves3	= "我听说那个密探不喜欢戴手套。",
	NoGloves4	= "我听说那个密探会尽量不戴手套，以防在快速行动时受到阻碍。",
	Cape1		= "有人提到那个密探之前是穿着斗篷来的。",
	Cape2		= "我听说那个密探喜欢穿斗篷。",
	NoCape1		= "我听说那个密探讨厌斗篷，所以没有穿。",
	NoCape2		= "我听说那个密探在来这里之前，把斗篷忘在王宫里了。",
	LightVest1	= "那个间谍肯定更喜欢浅色的上衣。",
	LightVest2	= "我听说那个密探穿着一件浅色上衣来参加今晚的聚会。",
	LightVest3	= "大家都在说那个密探今晚没有穿深色的上衣。",
	DarkVest1	= "那个间谍肯定更喜欢深色的服装。",
	DarkVest2	= "我听说那个密探今晚所穿的外衣是浓密的暗深色。",
	DarkVest3	= "那个密探喜欢深色的上衣……就像夜空一样深沉。",
	DarkVest4	= "传说那个密探会避免穿浅色的服装，以便更好地混入人群。",
	Female1		= "他们说那个密探已经来了，而且她是个大美人。",
	Female2		= "我听说有个女人一直打听贵族区的情况……",
	Female3		= "有人说我们的新客人不是男性。",
	Female4		= "他们说那个密探已经来了，而且她是个大美人。",
	Male1		= "我在别处听说那个密探不是女性。",
	Male2		= "我听说那个密探已经来了，而且他很英俊。",
	Male3		= "有个客人说她看见他和大魔导师一起走进了庄园。",
	Male4		= "有个乐师说，他一直在打听这一带的消息。",
	Shortsleeve1= "我听说密探喜欢穿短袖服装，以免妨碍双臂的活动。",
	Shortsleeve2= "有人告诉我那个密探讨厌长袖的衣服。",
	Shortsleeve3= "我的一个朋友说，她看到了密探穿的衣服，是一件短袖上衣。",
	Shortsleeve4= "我听说那个密探喜欢清凉的空气，所以今晚没有穿长袖衣服。",
	Longsleeve1 = "我听说那个密探今天穿着长袖外套。",
	Longsleeve2 = "有人说，那个密探今晚穿了一件长袖的衣服。",
	Longsleeve3 = "上半夜的时候，我正巧瞥见那个密探穿着长袖衣服。",
	Longsleeve4 = "我的一个朋友说那个密探穿着长袖衣服。",
	Potions1	= "我听说那个密探随身带着药水，这是为什么呢？",
	Potions2	= "可别说是我告诉你的……那个密探伪装成了炼金师，腰带上挂着药水。",
	Potions3	= "我敢肯定，那个密探的腰带上挂着药水。",
	Potions4	= "我听说那个密探买了一些药水……以防万一。",
	NoPotions1	= "我听说那个密探根本没带任何药水。",
	NoPotions2	= "有个乐师告诉我，她看到那个密探扔掉了身上的最后一瓶药水，已经没有药水了。",
	Book1		= "我听说那个密探的腰带上，总是挂着一本写满机密的书。",
	Book2		= "据说那个密探喜欢读书，而且总是随身携带至少一本书。",
	Pouch1		= "我听说那个密探总是带着一个魔法袋。",
	Pouch2		= "一个朋友说，那个密探喜欢黄金，所以在腰包里装满了金币。",
	Pouch3		= "我听说那个密探的腰包里装满了摆阔用的金币。",
	Pouch4		= "我听说那个密探的腰包上绣着精美的丝线。",
	--
	Gloves		= "手套",
	NoGloves	= "没手套",
	Cape		= "斗篷",
	Nocape		= "没斗篷",
	LightVest	= "浅色上衣",
	DarkVest	= "深色上衣",
	Female		= "女性",
	Male		= "男性",
	ShortSleeve = "短袖",
	LongSleeve	= "长袖",
	Potions		= "腰上药水",
	NoPotions	= "没有药水",
	Book		= "带书",
	Pouch		= "挂腰包"
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
	name =	"噬魂之喉小怪"
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
	name =	"突袭紫罗兰监狱小怪"
})

L:SetWarningLocalization({
	WarningPortalSoon	= "准备开门",
	WarningPortalNow	= "第%d个传送门",
	WarningBossNow		= "Boss来了"
})

L:SetTimerLocalization({
	TimerPortal			= "传送门CD"
})

L:SetOptionLocalization({
	WarningPortalNow		= "警报：新的传送门",
	WarningPortalSoon		= "警报：准备开门",
	WarningBossNow			= "警报：Boss来了",
	TimerPortal				= "计时条：Boss后的下一个门"
})

L:SetMiscLocalization({
	Malgath		=	"督军马尔加斯" --offical
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
--Vault of the Wardens Trash
-----------------------
L = DBM:GetModLocalization("")

L:SetGeneralLocalization({
	name =	"守望者地窟小怪"
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
	name =	"重返卡拉赞小怪"
})

L:SetMiscLocalization({
	speedRun		=	"空气中弥漫着某种诡异的黑暗寒风……"
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
	name =	"永夜大教堂小怪"
})
