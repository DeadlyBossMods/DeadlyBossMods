if GetLocale() ~= "koKR" then return end
local L

---------------
-- Immerseus --
---------------
L= DBM:GetModLocalization(852)

---------------------------
-- The Fallen Protectors --
---------------------------
L= DBM:GetModLocalization(849)

---------------------------
-- Norushen --
---------------------------
L= DBM:GetModLocalization(866)

L:SetOptionLocalization({
	InfoFrame			= "$journal:8252에 대한 정보를 정보 창으로 보기"
})

L:SetMiscLocalization({
	wasteOfTime			= "그래, 좋다. 너희 타락을 가두어 둘 공간을 만들겠다."
})

------------------
-- Sha of Pride --
------------------
L= DBM:GetModLocalization(867)

L:SetOptionLocalization({
	InfoFrame			= "$journal:8255에 대한 정보를 정보 창으로 보기"
})

--------------
-- Galakras --
--------------
L= DBM:GetModLocalization(868)

L:SetTimerLocalization({
	timerTowerCD	= "다음 포탑"
})

L:SetOptionLocalization({
	timerTowerCD	= "다음 포탑 바 보기"--번역이 조금 다른데? 나중에 확인
})

L:SetMiscLocalization({
	newForces1		= "놈들이 와요!",--제이나 대사
	--newForces1H		= "",--Unconfirmed
	newForces2		= "용아귀 용사들아, 진격하라!",
	newForces3		= "헬스크림 님을 위하여!",
	newForces4		= "다음 분대, 진격!",
	tower			= "문이 뚫렸습니다!"--The door barring the South/North Tower has been breached!
})

--------------------
--Iron Juggernaut --
--------------------
L= DBM:GetModLocalization(864)

--------------------------
-- Kor'kron Dark Shaman --
--------------------------
L= DBM:GetModLocalization(856)

L:SetMiscLocalization({
	PrisonYell		= "%s 감옥 사라짐! (%d)"
})

---------------------
-- General Nazgrim --
---------------------
L= DBM:GetModLocalization(850)

L:SetWarningLocalization({
	warnDefensiveStanceSoon		= "%d초 후 방어 태세"
})

L:SetOptionLocalization({
	warnDefensiveStanceSoon		= "$spell:143593 이전에 초읽기 알림 보기(5초 전부터)"
})

L:SetMiscLocalization({
	newForces1	= "전사들이여! 이리로!",
	newForces2	= "놈들을 막아라!",
	newForces3	= "병력 집결!",
	newForces4	= "코르크론! 날 지원하라!",
	newForces5	= "다음 분대, 앞으로!",
	allForces	= "전 코르크론, 내 명령을 따르라. 모두 죽여!"
})

-----------------
-- Malkorok -----
-----------------
L= DBM:GetModLocalization(846)

------------------------
-- Spoils of Pandaria --
------------------------
L= DBM:GetModLocalization(870)

L:SetMiscLocalization({
	Module1 = "Module 1's all prepared for system reset.",
	Victory	= "Module 2's all prepared for system reset"
})

---------------------------
-- Thok the Bloodthirsty --
---------------------------
L= DBM:GetModLocalization(851)

L:SetOptionLocalization({
	RangeFrame	= "거리 창 보기(10m)<br/>(광기 경고 수치에 달한 공격대원만 보임)"
})

----------------------------
-- Siegecrafter Blackfuse --
----------------------------
L= DBM:GetModLocalization(865)

L:SetMiscLocalization({
	newWeapons	= "생산 설비에서 미완성 무기가 나오기 시작합니다.",
	newShredder	= "자동 분쇄기가 다가옵니다!"
})

----------------------------
-- Paragons of the Klaxxi --
----------------------------
L= DBM:GetModLocalization(853)

L:SetWarningLocalization({
	specWarnActivatedVulnerable		= "%s에 취약함 - 피하세요!!",
	specWarnCriteriaLinked			= "%s에 연결됨!"
})

L:SetOptionLocalization({
	specWarnActivatedVulnerable		= "활성화된 용장에게 취약할 경우 특수 경고 보기",
	specWarnCriteriaLinked			= "$spell:144095에 연결된 경우 특수 경고 보기"
})

L:SetMiscLocalization({
	--thanks to blizz, the only accurate way for this to work, is to translate 5 emotes in all languages
	one					= "One",
	two					= "Two",
	three				= "Three",
	four				= "Four",
	five				= "Five",
	hisekFlavor			= "Look who's quiet now",--http://ptr.wowhead.com/quest=31510
	KilrukFlavor		= "Just another day, culling the swarm",--http://ptr.wowhead.com/quest=31109
	XarilFlavor			= "I see only dark skies in your future",--http://ptr.wowhead.com/quest=31216
	KaztikFlavor		= "Reduced to mere kunchong treats",--http://ptr.wowhead.com/quest=31024
	KaztikFlavor2		= "1 Mantid down, only 199 to go",--http://ptr.wowhead.com/quest=31808
	KorvenFlavor		= "The end of an ancient empire",--http://ptr.wowhead.com/quest=31232
	KorvenFlavor2		= "Take your Gurthani Tablets and choke on them",--http://ptr.wowhead.com/quest=31232
	IyyokukFlavor		= "See opportunities. Exploit them!",--Does not have quests, http://ptr.wowhead.com/npc=65305
	KarozFlavor			= "You won't be leaping anymore!",---Does not have questst, http://ptr.wowhead.com/npc=65303
	SkeerFlavor			= "A bloody delight!",--http://ptr.wowhead.com/quest=31178
	RikkalFlavor		= "Specimen request fulfilled"--http://ptr.wowhead.com/quest=31508
})

------------------------
-- Garrosh Hellscream --
------------------------
L= DBM:GetModLocalization(869)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("SoOTrash")

L:SetGeneralLocalization({
	name =	"오그리마 공성전: 일반구간"
})
