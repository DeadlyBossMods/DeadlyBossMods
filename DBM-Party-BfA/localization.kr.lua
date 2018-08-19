if GetLocale() ~= "koKR" then return end
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
	name =	"아탈다자르 일반몹"
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
	openingRP = "자, 다들 판돈을 거십시오! 여기 새로운 호구... 아니, 선수가 등장했습니다! 굴그토크, 우딘, 시작해!"
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
	name =	"자유지대 일반몹"
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
	name =	"왕들의 안식처 일반몹"
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
	openingRP	= "손님이 있는 것 같군, 스톰송 군주."
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
	name =	"폭풍의 사원 일반몹"
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
	name =	"보랄러스 공성전 일반몹"
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
	name =	"세스랄리스 사원 일반몹"
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
	name =	"왕노다지 광산!! 일반몹"
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
-- Taloc the Corrupted --
-----------------------
L= DBM:GetModLocalization(2158)

---------
--Trash--
---------
L = DBM:GetModLocalization("UnderrotTrash")

L:SetGeneralLocalization({
	name =	"썩은굴 일반몹"
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
	name =	"톨 다고르 일반몹"
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
	name =	"웨이크레스트 저택 일반몹"
})
