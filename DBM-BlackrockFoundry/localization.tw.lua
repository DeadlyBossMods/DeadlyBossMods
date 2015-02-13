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
	warnBlastFrequency	= "爆炸施放頻率增加：大約每%d秒一次"
})

L:SetOptionLocalization({
	warnBlastFrequency	= "提示$spell:155209施放頻率增加"
})

------------------
-- Hans'gar And Franzok --
------------------
L= DBM:GetModLocalization(1155)

--------------
-- Flamebender Ka'graz --
--------------
L= DBM:GetModLocalization(1123)

L:SetMiscLocalization({
	TorrentYell	= "%d秒後熔岩灼流"
})

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
