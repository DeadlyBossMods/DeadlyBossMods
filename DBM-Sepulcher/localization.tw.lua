--翻譯：BNS (三皈依 - 暗影之月)，沒玩測試服，翻譯部分參考自簡中，以後視實際技能名稱更正。

if GetLocale() ~= "zhTW" then return end
local L

---------------------------
--  Vigilant Guardian
---------------------------
--L= DBM:GetModLocalization(2458)

--L:SetOptionLocalization({

--})

--L:SetMiscLocalization({

--})

---------------------------
--  Dausegne, the Fallen Oracle
---------------------------
--L= DBM:GetModLocalization(2459)

---------------------------
--  Artificer Xy'mox
---------------------------
--L= DBM:GetModLocalization(2470)

---------------------------
--  Prototype Pantheon
---------------------------
L= DBM:GetModLocalization(2460)

L:SetOptionLocalization({
	RitualistIconSetting	= "設置儀式的圖示行為。團長的設定將覆蓋全團DBM設定",
	SetOne					= "與種子/午夜獵手不同 (無衝突) |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:16:32|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:16:32|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:16:32|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:48:64:16:32|t",--5-8 (Default)
	SetTwo					= "與種子/午夜獵手配對 (如果種子與儀式同時出現則衝突) |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:0:16|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:0:16|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:48:64:0:16|t",-- 1-4
	SetThree				= "與種子/午夜獵手配對 (不衝突，但需要團隊成員安裝特殊擴展圖示來看見他們) |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:32:48|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:32:48|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:32:48|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:48:64:32:48|t"--9-12
})

L:SetMiscLocalization({
	Deathtouch		= "死亡之觸",
	Dispel			  = "驅散",
	ExtendReset		= "由於您之前使用了擴展圖示，但已不再使用，因此您的儀式圖示下拉設定已被重置。"
})

---------------------------
--  Lihuvim, Principal Architect
---------------------------
--L= DBM:GetModLocalization(2461)

---------------------------
--  Skolex, the Insatiable Ravener
---------------------------
--L= DBM:GetModLocalization(2465)

L:SetTimerLocalization{
	timerComboCD		= "~坦克連擊"
}

L:SetOptionLocalization({
	timerComboCD		= "顯示坦克連擊冷卻的計時器"
})

---------------------------
--  Halondrus the Reclaimer
---------------------------
--L= DBM:GetModLocalization(2463)

---------------------------
--  Anduin Wrynn
---------------------------
L= DBM:GetModLocalization(2469)

L:SetOptionLocalization({
	PairingBehavior		= "設置褻瀆的模組行為。 團長的設定將覆蓋全團DBM設定",
	Auto				      = "'點名你'警告自動配對玩家。聊天泡泡顯示配對者的獨特符號",
	Generic				    = "'點名你'警告不配對玩家。聊天泡泡顯示兩個減益的通用符號",--預設
	None				      = "'點名你'警告不配對玩家。也無聊天泡泡"
})

---------------------------
--  Lords of Dread
---------------------------
--L= DBM:GetModLocalization(2457)

---------------------------
--  Rygelon
---------------------------
--L= DBM:GetModLocalization(2467)

---------------------------
--  The Jailer
---------------------------
--L= DBM:GetModLocalization(2464)

L:SetMiscLocalization({
	Pylon		= "高塔"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("SepulcherTrash")

L:SetGeneralLocalization({
	name =	"首創者墓穴小怪"
})
