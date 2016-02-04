if GetLocale() ~= "koKR" then return end
local L

--------------------------
--  Garrison Invasions  --
--------------------------
L = DBM:GetModLocalization("GarrisonInvasions")

L:SetGeneralLocalization({
	name = "주둔지 방어"
})

L:SetWarningLocalization({
	specWarnRylak	= "라일라크 등장!",
	specWarnWorker	= "겁먹은 일꾼 등장!",
	specWarnSpy		= "상대진영 침투요원 등장!",
	specWarnBuilding= "건물이 공격받고 있습니다!"
})

L:SetOptionLocalization({
	specWarnRylak	= "라이라크 등장시 특수 경고 보기",
	specWarnWorker	= "겁먹은 일꾼 등장시 특수 경고 보기",
	specWarnSpy		= "상대진영 침투요원 등장시 특수 경고 보기",
	specWarnBuilding= "건물이 공격 받을시 특수 경고 보기"
})

L:SetMiscLocalization({
	--General
	preCombat			= "To arms! To your posts!",--Common in all yells, rest varies based on invasion
	preCombat2			= "The air has taken a turn for the foul...",--Shadow Council doesn't follow format of others :\
	rylakSpawn			= "The commotion of the battle attracts a rylak!",--Source npc Darkwing Scavenger, target playername
	terrifiedWorker		= "겁먹은 일꾼이 바깥에서 발이 묶였습니다!",
	sneakySpy			= "혼란을 틈타",--Shortened to cut out "horde/alliance"
	buildingAttack		= "is under attack!",--Your Salvage Yard is under attack!
	--Ogre
	GorianwarCaller		= "A Gorian Warcaller joins the battle to raise morale!",--Maybe combined "add" special warning most adds?
	WildfireElemental	= "A Wildfire Elemental is being summoned at the front gates!",--Maybe combined "add" special warning most adds?
	--Iron Horde
	Assassin			= "An Assassin is hunting your guards!"--Maybe combined "add" special warning most adds?
})


-----------------
--  Annihilon  --
-----------------
L = DBM:GetModLocalization("Annihilon")

L:SetGeneralLocalization({
	name = "파멸혼"
})

--------------
--  Teluur  --
--------------
L = DBM:GetModLocalization("Teluur")

L:SetGeneralLocalization({
	name = "텔루어"
})

----------------------
--  Lady Fleshsear  --
----------------------
L = DBM:GetModLocalization("LadyFleshsear")

L:SetGeneralLocalization({
	name = "여군주 살점소각"
})

-------------------------
--  Commander Dro'gan  --
-------------------------
L = DBM:GetModLocalization("Drogan")

L:SetGeneralLocalization({
	name = "사령관 드로관"
})

-----------------------------
--  Mage Lord Gogg'nathog  --
-----------------------------
L = DBM:GetModLocalization("Goggnathog")

L:SetGeneralLocalization({
	name = "마법사 군주 고그나토그"
})

------------
--  Gaur  --
------------
L = DBM:GetModLocalization("Gaur")

L:SetGeneralLocalization({
	name = "가우르"
})
