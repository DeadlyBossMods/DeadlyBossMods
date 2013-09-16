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
	newForces1H		= "저 계집을 당장 끌어내려라. 내가 친히 그녀의 목을 칠 것이다.",--실바나스 대사 (확인 필요)
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
	PrisonYell		= "%s의 강철 감옥 사라지기 직전! (%d초 남음)"
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
	newForces2	= "놈들을 막아라!",--확인 필요
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
	Module1 = "제1 모듈, 시스템 초기화 준비 완료.",
	Victory	= "제2 모듈, 시스템 초기화 준비 완료."
})

---------------------------
-- Thok the Bloodthirsty --
---------------------------
L= DBM:GetModLocalization(851)

L:SetOptionLocalization({
	RangeFrame	= "거리 창 보기(10m) (피의 광란이 가능한 경우에만 보임)"
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
	specWarnActivatedVulnerable		= "%s에게 취약함 - 주의!",
	specWarnCriteriaLinked			= "계산 완료 대상과 연결됨 : %s!"
})

L:SetOptionLocalization({
	specWarnActivatedVulnerable		= "활성화된 용장중 주의해야 할 용장이 있을 경우 특수 경고 보기",
	specWarnCriteriaLinked			= "$spell:144095 대상과 연결된 경우 특수 경고 보기"
})

L:SetMiscLocalization({
	--thanks to blizz, the only accurate way for this to work, is to translate 5 emotes in all languages
	one					= "가 1",
	two					= "가 2",
	three				= "가 3",
	four				= "가 4",
	five				= "가 5",
	hisekFlavor			= "누가 이제 조용한지 봐라.",
	KilrukFlavor		= "무리의 도태가 일어난 또 다른 날이 되었군.",
	XarilFlavor			= "너의 미래에 검은 하늘만 보일뿐.",
	KaztikFlavor		= "단지 쿤총 특식이 되어버렸군.",
	KaztikFlavor2		= "사마귀 한마리 처치. 199마리 남았음.",
	KorvenFlavor		= "고대 제국의 멸망.",
	KorvenFlavor2		= "구르다니 서판을 가져온 후 그들의 숨통을 끊어!",
	IyyokukFlavor		= "기회를 포착하고, 활용해라!",
	KarozFlavor			= "힘 안 들이고 잡아 없애면서도 명성이 높아지는데 뭘 그러나.",
	SkeerFlavor			= "피투성이의 즐거움!",
	RikkalFlavor		= "표본 요청 달성됨."
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
