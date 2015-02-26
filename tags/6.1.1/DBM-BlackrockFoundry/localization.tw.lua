if GetLocale() ~= "zhTW" then return end
local L

---------------
-- Gruul --
---------------
L= DBM:GetModLocalization(1161)

---------------------------
-- Oregorger, The Devourer --
---------------------------
L= DBM:GetModLocalization(1202)

---------------------------
-- The Blast Furnace --
---------------------------
L= DBM:GetModLocalization(1154)

L:SetWarningLocalization({
	warnRegulators		= "熱能調節閥剩餘:%d",
	warnBlastFrequency	= "爆炸施放頻率增加：大約每%d秒一次"
})

L:SetOptionLocalization({
	warnRegulators		= "提示熱能調節閥還剩多少體力",
	warnBlastFrequency	= "提示$spell:155209施放頻率增加",
	VFYellType			= "設定烈性之火的大喊方式 (只有傳奇模式)",
	Countdown			= "倒數直到消失",
	Apply				= "只有中了時候"
})

L:SetMiscLocalization({
	heatRegulator		= "熱能調節閥"
})

------------------
-- Hans'gar And Franzok --
------------------
L= DBM:GetModLocalization(1155)

--------------
-- Flamebender Ka'graz --
--------------
L= DBM:GetModLocalization(1123)

--------------------
--Kromog, Legend of the Mountain --
--------------------
L= DBM:GetModLocalization(1162)

--------------------------
-- Beastlord Darmac --
--------------------------
L= DBM:GetModLocalization(1122)

--------------------------
-- Operator Thogar --
--------------------------
L= DBM:GetModLocalization(1147)

L:SetWarningLocalization({
	specWarnSplitSoon	= "10秒後團隊分開"
})

L:SetOptionLocalization({
	specWarnSplitSoon	= "團隊分開10秒前顯示特別警告"
})

L:SetMiscLocalization({
	Train			= GetSpellInfo(174806),
	lane			= "車道",
	oneTrain		= "一個隨機列車道",
	oneRandom		= "出現一個隨機列車道",
	threeTrains		= "三個隨機列車道",
	threeRandom		= "出現三個隨機列車道",
	helperMessage	= "在這戰鬥推薦搭配協力插件'Thogar Assist'或是新版本的DBM語音包。可從Curse下載 "
})

--------------------------
-- The Iron Maidens --
--------------------------
L= DBM:GetModLocalization(1203)

L:SetWarningLocalization({
	specWarnReturnBase	= "快回到碼頭！"
})

L:SetOptionLocalization({
	specWarnReturnBase	= "當船上玩家可以安全回到碼頭時顯示特別警告"
})

L:SetMiscLocalization({
	shipMessage		= "準備裝填無畏號的主炮了！"
})

--------------------------
-- Blackhand --
--------------------------
L= DBM:GetModLocalization(959)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("BlackrockFoundryTrash")

L:SetGeneralLocalization({
	name =	"黑石鑄造場小怪"
})
