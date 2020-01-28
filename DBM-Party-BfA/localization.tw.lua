if GetLocale() ~= "zhTW" then return end
local L

-----------------------
-- <<<Atal'Dazar >>> --
-----------------------
-----------------------
-- Priestess Alun'za --
-----------------------
L= DBM:GetModLocalization(2082)

-----------------------
-- Vol'kaal --
-----------------------
L= DBM:GetModLocalization(2036)

-----------------------
-- Rezan --
-----------------------
L= DBM:GetModLocalization(2083)

-----------------------
-- Yazma --
-----------------------
L= DBM:GetModLocalization(2030)

---------
--Trash--
---------
L = DBM:GetModLocalization("AtalDazarTrash")

L:SetGeneralLocalization({
	name =	"阿塔達薩小怪"
})

-----------------------
-- <<<Freehold >>> --
-----------------------
-----------------------
-- Skycap'n Kragg --
-----------------------
L= DBM:GetModLocalization(2102)

-----------------------
-- Council o' Captains --
-----------------------
L= DBM:GetModLocalization(2093)

L:SetWarningLocalization({
	warnGoodBrew		= "正施放 %s: 3秒鐘",
	specWarnBrewOnBoss	= "好酒 - 移動到 %s"
})

L:SetOptionLocalization({
	warnGoodBrew		= "當開始施放好酒時顯示警告",
	specWarnBrewOnBoss	= "當好酒位於首領下方時顯示特別警告"
})

L:SetMiscLocalization({
	critBrew		= "致命酒",
	hasteBrew		= "加速酒"
})

-----------------------
-- Ring of Booty --
-----------------------
L= DBM:GetModLocalization(2094)

L:SetMiscLocalization({
	openingRP = "趕快過來下注啊！我們有新的肉靶…呃，是挑戰者！準備開始！葛爾薩克和烏丁！"
})

-----------------------
-- Harlan Sweete --
-----------------------
L= DBM:GetModLocalization(2095)

---------
--Trash--
---------
L = DBM:GetModLocalization("FreeholdTrash")

L:SetGeneralLocalization({
	name =	"自由港小怪"
})

-----------------------
-- <<<Kings' Rest >>> --
-----------------------
-----------------------
-- The Golden Serpent --
-----------------------
L= DBM:GetModLocalization(2165)

-----------------------
-- Mummification Construct --
-----------------------
L= DBM:GetModLocalization(2171)

-----------------------
-- The Warring Warlords --
-----------------------
L= DBM:GetModLocalization(2170)

-----------------------
-- Dazar, The First King --
-----------------------
L= DBM:GetModLocalization(2172)

---------
--Trash--
---------
L = DBM:GetModLocalization("KingsRestTrash")

L:SetGeneralLocalization({
	name =	"諸王之眠小怪"
})

-----------------------
-- <<<Shrine of the Storm >>> --
-----------------------
-----------------------
-- Agu'sirr --
-----------------------
L= DBM:GetModLocalization(2153)

-----------------------
-- Tidesage Council --
-----------------------
L= DBM:GetModLocalization(2154)

-----------------------
-- Lord Stormsong --
-----------------------
L= DBM:GetModLocalization(2155)

L:SetMiscLocalization({
	openingRP	= "斯陀頌恩領主，你好像有訪客呢。"
})

-----------------------
-- Vol'zith the Whisperer --
-----------------------
L= DBM:GetModLocalization(2156)

---------
--Trash--
---------
L = DBM:GetModLocalization("SotSTrash")

L:SetGeneralLocalization({
	name =	"風暴聖壇小怪"
})

-----------------------
-- <<<Siege of Boralus >>> --
-----------------------
-----------------------
-- Dread Captain Lockwood --
-----------------------
L= DBM:GetModLocalization(2173)

-----------------------
-- Chopper Redhook / Sergeant Bainbridge --
-----------------------
L= DBM:GetModLocalization(2132)

L= DBM:GetModLocalization(2133)

-----------------------
-- Hadal Darkfathom --
-----------------------
L= DBM:GetModLocalization(2134)

-----------------------
-- Kraken --
-----------------------
L= DBM:GetModLocalization(2140)

---------
--Trash--
---------
L = DBM:GetModLocalization("BoralusTrash")

L:SetGeneralLocalization({
	name =	"波拉勒斯圍城戰小怪"
})

-----------------------
-- <<<Temple of Sethraliss>>> --
-----------------------
-----------------------
-- Adderis and Aspix --
-----------------------
L= DBM:GetModLocalization(2142)

-----------------------
-- Merektha --
-----------------------
L= DBM:GetModLocalization(2143)

-----------------------
-- Lighting Elemental --
-----------------------
L= DBM:GetModLocalization(2144)

-----------------------
-- Avaar of Sethraliss --
-----------------------
L= DBM:GetModLocalization(2145)

---------
--Trash--
---------
L = DBM:GetModLocalization("SethralissTrash")

L:SetGeneralLocalization({
	name =	"瑟沙利斯神廟小怪"
})

-----------------------
-- <<<MOTHERLOAD>>> --
-----------------------
-----------------------
-- Coin-operated Crowd Pummeler --
-----------------------
L= DBM:GetModLocalization(2109)

-----------------------
-- Tik'ali --
-----------------------
L= DBM:GetModLocalization(2114)

-----------------------
-- Rixxa Fluxflame --
-----------------------
L= DBM:GetModLocalization(2115)

-----------------------
-- Mogul Razzdunk --
-----------------------
L= DBM:GetModLocalization(2116)

---------
--Trash--
---------
L = DBM:GetModLocalization("UndermineTrash")

L:SetGeneralLocalization({
	name =	"晶喜鎮！小怪"
})

-----------------------
-- <<<The Underrot>>> --
-----------------------
-----------------------
-- Elder Leaxa --
-----------------------
L= DBM:GetModLocalization(2157)

-----------------------
-- Infested Crawg --
-----------------------
L= DBM:GetModLocalization(2131)

-----------------------
-- Sporecaller Zancha --
-----------------------
L= DBM:GetModLocalization(2130)

-----------------------
-- Unbound Monstrosity --
-----------------------
L= DBM:GetModLocalization(2158)

---------
--Trash--
---------
L = DBM:GetModLocalization("UnderrotTrash")

L:SetGeneralLocalization({
	name =	"幽腐深窟小怪"
})

-----------------------
-- <<<Tol Dagor >>> --
-----------------------
-----------------------
-- The Sand Queen --
-----------------------
L= DBM:GetModLocalization(2097)

-----------------------
-- Jes Howlis --
-----------------------
L= DBM:GetModLocalization(2098)

-----------------------
-- Knight Captain Valyri --
-----------------------
L= DBM:GetModLocalization(2099)

-----------------------
-- Overseer Korgus --
-----------------------
L= DBM:GetModLocalization(2096)

---------
--Trash--
---------
L = DBM:GetModLocalization("TolDagorTrash")

L:SetGeneralLocalization({
	name =	"托達戈爾小怪"
})

-----------------------
-- <<<Waycrest Manor>>> --
-----------------------
-----------------------
-- Heartsbane Triad --
-----------------------
L= DBM:GetModLocalization(2125)

-----------------------
-- Soulbound Goliath --
-----------------------
L= DBM:GetModLocalization(2126)

-----------------------
-- Raal the Gluttonous --
-----------------------
L= DBM:GetModLocalization(2127)

-----------------------
-- Lord and Lady Waycrest --
-----------------------
L= DBM:GetModLocalization(2128)

-----------------------
-- Gorak Tul --
-----------------------
L= DBM:GetModLocalization(2129)

---------
--Trash--
---------
L = DBM:GetModLocalization("WaycrestTrash")

L:SetGeneralLocalization({
	name =	"威奎斯特莊園小怪"
})

-----------------------
-- <<<Operation: Mechagon>>> --
-----------------------
-----------------------
-- King Gobbamak --
-----------------------
L= DBM:GetModLocalization(2357)

-----------------------
-- Gunker --
-----------------------
L= DBM:GetModLocalization(2358)

-----------------------
-- Trixie & Naeno --
-----------------------
L= DBM:GetModLocalization(2360)

-----------------------
-- HK-8 Aerial Oppression Unit --
-----------------------
L= DBM:GetModLocalization(2355)

-----------------------
-- Tussle Tonks --
-----------------------
L= DBM:GetModLocalization(2336)

-----------------------
-- K.U.-J.0. --
-----------------------
L= DBM:GetModLocalization(2339)

-----------------------
-- Machinist's Garden --
-----------------------
L= DBM:GetModLocalization(2348)

-----------------------
-- King Mechagon --
-----------------------
L= DBM:GetModLocalization(2331)

---------
--Trash--
---------
L = DBM:GetModLocalization("MechagonTrash")

L:SetGeneralLocalization({
	name =	"機械岡小怪"
})
