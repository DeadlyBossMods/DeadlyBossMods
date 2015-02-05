-- Mini Dragon(projecteurs@gmail.com)
-- Yike Xia
-- Last update: Feb 5, 2015@12715

if GetLocale() ~= "zhCN" then return end
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

------------------
-- Hans'gar And Franzok --
------------------
L= DBM:GetModLocalization(1155)

--------------
-- Flamebender Ka'graz -- 
--------------
L= DBM:GetModLocalization(1123)

L:SetMiscLocalization({
	TorrentYell	= "%d秒后熔岩激流"
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
	lane			= "轨道",
	oneTrain		= "随机单轨道快车",
	oneRandom		= "随机出现在一个轨道上",
	threeTrains		= "随机三轨道快车",
	threeRandom		= "随机出现在三个轨道上",
	helperMessage	= "建议你使用 'Thogar Assist' 索戈尔助手插件配合DBM作战。下载地址 http://wow.curseforge.com/addons/thogar-assist/"
})

--------------------------
-- The Iron Maidens --
--------------------------
L= DBM:GetModLocalization(1203)

L:SetMiscLocalization({
	shipMessage		= "准备操纵无畏舰的主炮"
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
	name =	"黑石铸造厂小怪"
})
