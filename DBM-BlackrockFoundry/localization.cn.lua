-- Mini Dragon(projecteurs@gmail.com)
-- Yike Xia
-- Last update: Feb 3, 2015@12685

if GetLocale() ~= "zhCN" then return end
local L

---------------
-- Gruul --
---------------
L= DBM:GetModLocalization(1161)

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

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
	return1		= "Wait till they get a load of me.",--Not used yet but just in case my current hack to avoid localizing doesn't work
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
	--Might not even need to use yells if my npc target works in all languages.
	--depends on if "Train" is boss target in all languages and if that spellid hack also matches it in all languages.
	--At the very least this helps read transcriptor logs :)
	cannonTrain		= "火炮车",
	threeTrains		= "随机三轨道快车",
	helperMessage	= "建议你使用 'Thogar Assist' 索戈尔助手插件配合DBM作战。下载地址 http://wow.curseforge.com/addons/thogar-assist/",
	commandTrain1	= "指挥车到了",
	commandTrain2	= "老大来了",
	moreThanOne1	= "列车进站",
	moreThanOne2	= "快速前进",
	moreThanOne3	= "清理轨道",
	cannon1			= "那是火炮",
	cannon2			= "炸弹来了",
	driveBy1		= "快点！有多快跑多快！",
	driveBy2		= "快车，本站不停。",
	driveBy3		= "特快专列来了！",
	driveBy4		= "让它过去！",
	driveBy5		= "真呛人。",
	smallAdds1		= "他们来了——下车吧，伙计们！",
	smallAdds2		= "军列进站！",
	smallAdds3		= "Ah - reinforcements.", --PH
	--Some of these flamethrowers are iffy so verify flamethrower again in videos to be very sure.
	--These may also be something else entirely so going to only debug these right now
	flameThrower1	= "我在赶时间！",
	flameThrower2	= "你们没时间了",
	flameThrower3	= "没什么大不了的。进站的列车多的是！",
	flameThrower4	= "你们正巧赶上了高峰时间。",
	flameThrower5	= "让我们加快速度。"
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
