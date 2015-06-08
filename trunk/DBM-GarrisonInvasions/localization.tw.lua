if GetLocale() ~= "zhTW" then return end
local L

--------------------------
--  Garrison Invasions  --
--------------------------
L = DBM:GetModLocalization("GarrisonInvasions")

L:SetGeneralLocalization({
	name = "要塞入侵"
})

L:SetWarningLocalization({
	specWarnRylak	= "冰喉食腐者來了",
	specWarnWorker	= "害怕的工人在空地上",
	specWarnSpy		= "一個間諜闖入",
	specWarnBuilding= "建築物受到攻擊"
})

L:SetOptionLocalization({
	specWarnRylak	= "當萊拉克出現時顯示特別警告",
	specWarnWorker	= "當害怕的工人在空地上被抓住時顯示特別警告",
	specWarnSpy		= "當間諜闖入時顯示特別警告",
	specWarnBuilding= "當建築物受到攻擊時顯示特別警告"
})

L:SetMiscLocalization({
	--General
	preCombat			= "準備作戰！堅守崗位！",--Common in all yells, rest varies based on invasion
	preCombat2			= "我們走運了！再一次地，我們會讓惡魔見識一下真正的部落絕不動搖！",--Shadow Council doesn't follow format of others :\一群魔妾出現了！
	rylakSpawn			= "戰場上的騷動吸引了一隻萊拉克！",--Source npc Darkwing Scavenger, target playername
	terrifiedWorker		= "害怕的工人在空地上被抓住了！",
	sneakySpy			= "的間諜趁亂闖進了要塞！",--Shortened to cut out "horde/alliance"
	buildingAttack		= "%s受到攻擊了！",--Your Salvage Yard is under attack! 食腐骨蟲聞到牠的下一頓大餐了！
	--Ogre
	GorianwarCaller		= "一位戈利安戰鬥法師進入戰場！",--Maybe combined "add" special warning most adds?
	WildfireElemental	= "有個野火元素被召喚到大門前！",--Maybe combined "add" special warning most adds?
	--Iron Horde
	Assassin			= "有個刺客正在獵殺你的守衛！"--Maybe combined "add" special warning most adds? --攻城大砲接近了！
})

-----------------
--  Annihilon  --
-----------------
L = DBM:GetModLocalization("Annihilon")

L:SetGeneralLocalization({
	name = "災滅"
})

--------------
--  Teluur  --
--------------
L = DBM:GetModLocalization("Teluur")

L:SetGeneralLocalization({
	name = "泰魯爾"
})

----------------------
--  Lady Fleshsear  --
----------------------
L = DBM:GetModLocalization("LadyFleshsear")

L:SetGeneralLocalization({
	name = "灼焰女士"
})

----------------------
--  Commander Dro'gan  --
----------------------
L = DBM:GetModLocalization("Drogan")

L:SetGeneralLocalization({
	name = "指揮官德羅甘"
})

----------------------------
-- Mage Lord Gogg'nathog  --
----------------------------
L = DBM:GetModLocalization("Goggnathog")

L:SetGeneralLocalization({
	name = "法師領主勾那索格"
})
