-- Mini Dragon(projecteurs@gmail.com)
-- 夏一可
-- Blizzard Entertainment
-- Last update: 2018/07/12

if GetLocale() ~= "zhCN" then return end
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
	name =	"阿塔达萨小怪"
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

-----------------------
-- Ring of Booty --
-----------------------
L= DBM:GetModLocalization(2094)

L:SetMiscLocalization({
	openingRP = "来来来，下注了！又来了一群受害——呃，参赛者！交给你们了，古尔戈索克和伍迪！" --official
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
	name =	"自由镇小怪"
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
	name =	"国王之眠小怪"
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
	openingRP	= "看来你有客人来了，斯托颂勋爵。" --official
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
	name =	"风暴神殿小怪"
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
-- Lady Ashvane --
-----------------------
L= DBM:GetModLocalization(2140)

---------
--Trash--
---------
L = DBM:GetModLocalization("BoralusTrash")

L:SetGeneralLocalization({
	name =	"围攻伯拉勒斯小怪"
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
	name =	"塞塔里斯神殿小怪"
})

-----------------------
-- <<<The Undermine>>> --
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
	name =	"安德麦小怪"
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
	name =	"地渊孢林小怪"
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
	name =	"托尔达戈小怪"
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
	name =	"维克雷斯庄园小怪"
})
