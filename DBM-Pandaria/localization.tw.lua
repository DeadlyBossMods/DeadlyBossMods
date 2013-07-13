if GetLocale() ~= "zhTW" then return end
local L

-----------------------
-- Sha of Anger --
-----------------------
L= DBM:GetModLocalization(691)

L:SetOptionLocalization({
	RangeFrame			= "根據玩家減益顯示動態的距離框以對應$spell:119622",
	ReadyCheck			= "當世界首領開打時撥放準備檢查的音效(即使沒有選定目標)"
})

L:SetMiscLocalization({
	Pull				= "沒錯...沒錯!釋放你的怒火!試著擊敗我!"
})

-----------------------
-- Salyis --
-----------------------
L= DBM:GetModLocalization(725)

L:SetOptionLocalization({
	ReadyCheck			= "當世界首領開打時撥放準備檢查的音效(即使沒有選定目標)"
})

L:SetMiscLocalization({
	Pull				= "把他們的屍體帶給我!"
})

--------------
-- Oondasta --
--------------
L= DBM:GetModLocalization(826)

L:SetOptionLocalization({
	ReadyCheck			= "當世界首領開打時撥放準備檢查的音效(即使沒有選定目標)"
})

L:SetOptionLocalization({
	RangeFrame			= "為$spell:137511顯示距離框架"
})

L:SetMiscLocalization({
	Pull				= "你們竟敢打擾我們的準備工作!贊達拉這次不會再被阻止了!"
})

---------------------------
-- Nalak, The Storm Lord --
---------------------------
L= DBM:GetModLocalization(814)

L:SetOptionLocalization({
	ReadyCheck			= "當世界首領開打時撥放準備檢查的音效(即使沒有選定目標)"
})

---------------------------
-- Chi-ji, The Red Crane --
---------------------------
L= DBM:GetModLocalization(857)

L:SetOptionLocalization({
	BeaconArrow				= "當某人中了$spell:144473顯示DBM箭頭"
})

------------------------------
-- Yu'lon, The Jade Serpent --
------------------------------
L= DBM:GetModLocalization(858)

--------------------------
-- Niuzao, The Black Ox --
--------------------------
L= DBM:GetModLocalization(859)

---------------------------
-- Xuen, The White Tiger --
---------------------------
L= DBM:GetModLocalization(860)

------------------------------------
-- Ordos, Fire-God of the Yaungol --
------------------------------------
L= DBM:GetModLocalization(861)
