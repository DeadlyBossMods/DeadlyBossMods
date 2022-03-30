if GetLocale() ~= "zhTW" then return end
local L

---------------------------
--  Vigilant Guardian --警戒守護者
---------------------------
--L= DBM:GetModLocalization(2458)

--L:SetOptionLocalization({

--})

--L:SetMiscLocalization({

--})

---------------------------
--  Dausegne, the Fallen Oracle --墮落神諭者達奧賽恩
---------------------------
--L= DBM:GetModLocalization(2459)

---------------------------
--  Artificer Xy'mox --工藝師西莫斯
---------------------------
--L= DBM:GetModLocalization(2470)

---------------------------
--  Prototype Pantheon --原型萬神殿
---------------------------
L= DBM:GetModLocalization(2460)

L:SetOptionLocalization({
	RitualistIconSetting	= "設置儀式的圖示行為。團長的設定將覆蓋全團DBM設定",
	SetOne					= "與種子/黑夜獵人不同 (無衝突) |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:16:32|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:16:32|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:16:32|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:48:64:16:32|t",--5-8 (Default)
	SetTwo					= "與種子/黑夜獵人配對 (如果種子與儀式同時出現則衝突) |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:0:16|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:0:16|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:48:64:0:16|t",-- 1-4
--	SetThree				= "與種子/黑夜獵人配對 (不衝突，但需要團隊成員安裝特殊擴展圖示來看見他們) |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:32:48|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:32:48|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:32:48|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:48:64:32:48|t"--9-12
})

L:SetMiscLocalization({
	Deathtouch		= "死亡之觸",
	Dispel			= "驅散",
	ExtendReset		= "由於您之前使用了擴展圖示，但已不再使用，因此您的儀式圖示下拉設定已被重置。"
})

---------------------------
--  Lihuvim, Principal Architect --首席設計者利胡敏
---------------------------
--L= DBM:GetModLocalization(2461)

---------------------------
--  Skolex, the Insatiable Ravener --貪婪掠食者史寇雷斯
---------------------------
--L= DBM:GetModLocalization(2465)

L:SetTimerLocalization{
	timerComboCD		= "~坦克連擊 (%d)"
}

L:SetOptionLocalization({
	timerComboCD		= "顯示坦克連擊冷卻的計時器"
})

---------------------------
--  Halondrus the Reclaimer --回收者哈隆德魯斯
---------------------------
L= DBM:GetModLocalization(2463)

L:SetMiscLocalization({
	Mote		= "微粒"
})

---------------------------
--  Anduin Wrynn --安杜因‧烏瑞恩
---------------------------
L= DBM:GetModLocalization(2469)

L:SetOptionLocalization({
	PairingBehavior			= "設置褻瀆的模組行為。 團長的設定將覆蓋全團DBM設定",
	Auto				    = "'點名你'警告自動配對玩家。聊天泡泡顯示配對者的獨特符號",
	Generic				    = "'點名你'警告不配對玩家。聊天泡泡顯示兩個減益的通用符號",--預設
	None				    = "'點名你'警告不配對玩家。也無聊天泡泡"
})

---------------------------
--  Lords of Dread --驚懼領主
---------------------------
--L= DBM:GetModLocalization(2457)

---------------------------
--  Rygelon --雷吉隆
---------------------------
--L= DBM:GetModLocalization(2467)

---------------------------
--  The Jailer --閻獄之主
---------------------------
--L= DBM:GetModLocalization(2464)

L:SetWarningLocalization({
	warnHealAzeroth		= "治療艾澤拉斯 (%s)",
	warnDispel			= "驅散 (%s)"
})

L:SetTimerLocalization{
	timerPits			= "坑洞開啟",
	timerHealAzeroth	= "治療艾澤拉斯 (%s)",
	timerDispels		= "驅散 (%s)"
}

L:SetOptionLocalization({
	timerPits			= "顯示計時器，以便在樓層坑洞打開並暴露時，您可以跳入。",
	warnHealAzeroth		= "顯示警告，在傳奇難度何時你需要治療艾澤拉斯(透由戰鬥機制)，基於Echo的策略",
	warnDispel			= "顯示警告，在傳奇難度何時你需要驅散死亡宣判，基於Echo的策略(暫譯)",
	timerHealAzeroth	= "顯示計時器，在傳奇難度何時你需要治療艾澤拉斯(透由戰鬥機制)，基於Echo的策略",
	timerDispels		= "顯示計時器，在傳奇難度何時你需要驅散死亡宣判，基於Echo的策略(暫譯)"
})

L:SetMiscLocalization({
	Pylon			= "水晶塔",
	AzerothSoak		= "艾澤拉斯分傷"--Short Text for Desolation
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("SepulcherTrash")

L:SetGeneralLocalization({
	name =	"首創者聖塚小怪"
})
