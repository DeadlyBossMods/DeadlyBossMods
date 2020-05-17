if GetLocale() ~= "zhTW" then return end
local L

-----------------------
-- <<<Atal'Dazar >>> --
-----------------------
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
-- Lord Stormsong --
-----------------------
L= DBM:GetModLocalization(2155)

L:SetMiscLocalization({
	openingRP	= "斯陀頌恩領主，你好像有訪客呢。"
})

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
-- Tussle Tonks --
-----------------------
L= DBM:GetModLocalization(2336)

L:SetMiscLocalization({
	openingRP		= "真是一反常態，這群不速之客竟然還活著！"
})

---------
--Trash--
---------
L = DBM:GetModLocalization("MechagonTrash")

L:SetGeneralLocalization({
	name =	"機械岡小怪"
})
