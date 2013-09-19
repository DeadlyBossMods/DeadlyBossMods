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
	Pull					= "那我們就開始吧。",
	Victory					= "你的希望閃耀，尤其在團結後更是燦爛。即使在最黑暗的地方，它也會照亮你的路途。"
})

------------------------------
-- Yu'lon, The Jade Serpent --
------------------------------
L= DBM:GetModLocalization(858)

L:SetMiscLocalization({
	Pull					= "試煉開始!",
	Wave1					= "別讓你們的判斷被困境蒙蔽!",
	Wave2					= "傾聽你們內心的聲音，找出真相!",
	Victory					= "你們的智慧幫你們度過了考驗。希望智慧能在黑暗中照亮你們的道路。"
})

--------------------------
-- Niuzao, The Black Ox --
--------------------------
L= DBM:GetModLocalization(859)

L:SetMiscLocalization({
	Pull					= "我們拭目以待。",
	Victory					= "雖然被難以想像的敵人包圍，你的堅毅會讓你堅持下去。在未來要記得這一點。",
	VictoryDem				= "Rakkas shi alar re pathrebosh il zila rethule kiel shi shi belaros rikk kanrethad adare revos shi xi thorje Rukadare zila te lok zekul melar "--Cover all bases and all
})


---------------------------
-- Xuen, The White Tiger --
---------------------------
L= DBM:GetModLocalization(860)

L:SetMiscLocalization({
	Pull					= "哈哈!試煉開始吧!",
	Victory					= "你很強，比你認知的還要強大。帶著這個信念迎接前方的黑暗，讓它保護你。"
})

------------------------------------
-- Ordos, Fire-God of the Yaungol --
------------------------------------
L= DBM:GetModLocalization(861)

L:SetMiscLocalization({
	Pull					= "你將代替我永恆地燃燒!"
})
