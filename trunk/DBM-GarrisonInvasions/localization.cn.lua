-- Diablohu(diablohudream@gmail.com)
-- yleaf(yaroot@gmail.com)
-- Mini_Dragon(projecteurs@gmail.com)
-- Yike Xia
-- Last update: Jan 22, 2015@12534

if GetLocale() ~= "zhCN" then return end

local L

--------------------------
--  Garrison Invasions  --
--------------------------
-- Thanks Blizzard Entertainment
L = DBM:GetModLocalization("GarrisonInvasions")

L:SetGeneralLocalization({
	name = "要塞入侵"
})

L:SetWarningLocalization({
	specWarnRylak	= "暗翼食腐者即将到来",
	specWarnWorker	= "一个惊恐的工人暴露在开阔地带",
	specWarnSpy		= "一个间谍混了进来",
	specWarnBuilding= "一座建筑正受到攻击"
})

L:SetOptionLocalization({
	specWarnRylak	= "当暗翼食腐者到来时发出特殊警报",
	specWarnWorker	= "当工人暴露在开阔地带时发出特殊警报",
	specWarnSpy		= "当间谍混进来时发出特殊警报",
	specWarnBuilding= "当建筑受到攻击时发出特殊警报"
})

L:SetMiscLocalization({
	--General
	preCombat			= "各就各位！准备战斗！",--Common in all yells, rest varies based on invasion
	preCombat2			= "空气开始变得污浊了……",--Shadow Council doesn't follow format of others :\
	rylakSpawn			= "战斗引发的骚乱引来了一头双头飞龙！",--Source npc Darkwing Scavenger, target playername
	terrifiedWorker		= "一个惊恐的工人在开阔地带被抓了！",
	sneakySpy			= "一个间谍趁乱混了进来！",--Shortened to cut out "horde/alliance"
	buildingAttack		= "你的%s正受到攻击！",--Your Salvage Yard is under attack!
    --Ogre
	GorianwarCaller		= "一名高里亚战争召唤者加入战斗，提升了士气！",--Maybe combined "add" special warning most adds?
	WildfireElemental	= "一个野火元素被召唤到了前门！",--Maybe combined "add" special warning most adds?
    --Iron Horde
	Assassin			= "一名刺客正在猎杀你的守卫！"--Maybe combined "add" special warning most adds?
})
