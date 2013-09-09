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

L:SetMiscLocalization({
	Pull				= "你感覺到冷風吹過了嗎?"
})

---------------------------
-- Chi-ji, The Red Crane --
---------------------------
L= DBM:GetModLocalization(857)

L:SetOptionLocalization({
	BeaconArrow				= "當某人中了$spell:144473顯示DBM箭頭"
})

L:SetMiscLocalization({
	Pull					= "Then let us begin.",
	Victory					= "Your hope shines brightly, and even more brightly when you work together to overcome. It will ever light your way in even the darkest of places."
})

------------------------------
-- Yu'lon, The Jade Serpent --
------------------------------
L= DBM:GetModLocalization(858)

L:SetMiscLocalization({
	Pull					= "The trial begins!",
	Wave1					= "Do not let your judgement be clouded in trying times!",
	Wave2					= "Listen to your inner voice, and seek out the truth!",
	Victory					= "Your wisdom has seen you through this trial. May it ever light your way out of dark places."
})

--------------------------
-- Niuzao, The Black Ox --
--------------------------
L= DBM:GetModLocalization(859)

L:SetMiscLocalization({
	Pull					= "We shall see.",
--	Victory					= "",
	VictoryDem				= "Rakkas shi alar re pathrebosh il zila rethule kiel shi shi belaros rikk kanrethad adare revos shi xi thorje Rukadare zila te lok zekul melar "--Cover all bases and all
})


---------------------------
-- Xuen, The White Tiger --
---------------------------
L= DBM:GetModLocalization(860)

L:SetMiscLocalization({
	Pull					= "Ha ha! The trial commences",
	Victory					= "You are strong, stronger even than you realize. Carry this thought with you into the darkness ahead, and let it shield you."
})

------------------------------------
-- Ordos, Fire-God of the Yaungol --
------------------------------------
L= DBM:GetModLocalization(861)
