if GetLocale() ~= "koKR" then return end
local L

---------------
-- Immerseus --
---------------
L= DBM:GetModLocalization(852)

L:SetMiscLocalization({
	Victory			= "아, 역시 해냈군! 골짜기의 물이 다시 깨끗해졌네."
})

---------------------------
-- The Fallen Protectors --
---------------------------
L= DBM:GetModLocalization(849)

L:SetWarningLocalization({
	warnCalamity		= "%s",
	specWarnCalamity	= "%s",
	specWarnMeasures	= "곧 궁책 (%s)!"
})

---------------------------
-- Norushen --
---------------------------
L= DBM:GetModLocalization(866)

L:SetMiscLocalization({
	wasteOfTime			= "그래, 좋다. 너희 타락을 가두어 둘 공간을 만들겠다."
})

------------------
-- Sha of Pride --
------------------
L= DBM:GetModLocalization(867)

L:SetOptionLocalization({
	SetIconOnFragment	= "타락한 조각 에게 전술 목표 아이콘 설정"
})

--------------
-- Galakras --
--------------
L= DBM:GetModLocalization(868)

L:SetWarningLocalization({
	warnTowerOpen	= "탑문 열림",
	warnTowerGrunt	= "폭파조 등장"
})

L:SetTimerLocalization({
	timerTowerCD		= "다음 탑문 열림",
	timerTowerGruntCD	= "다음 폭파조"
})

L:SetOptionLocalization({
	warnTowerOpen		= "탑문 열림 알림 보기",
	warnTowerGrunt		= "폭파조 등장 알림 보기",
	timerTowerCD		= "다음 탑문 열림 바 보기",
	timerTowerGruntCD	= "다음 폭파조 바 보기"
})

L:SetMiscLocalization({
	wasteOfTime		= "잘했다! 상륙 부대, 정렬! 보병대, 앞으로!",--Alliance Version
	wasteOfTime2	= "잘 했소. 선봉대가 성공적으로 상륙했군.",--Horde Version
	Pull			= "용아귀 부족 용사들이여! 항구를 탈환하고 적을 바다로 몰아내라! 헬스크림 님과 진정한 호드를 위하여!",
	newForces1		= "놈들이 와요!",--제이나 대사
	newForces1H		= "저 계집을 당장 끌어내려라. 내가 친히 그녀의 목을 죌 것이다.",--실바나스 대사 (확인 필요)
	newForces2		= "용아귀 용사들아, 진격하라!",
	newForces3		= "헬스크림 님을 위하여!",
	newForces4		= "다음 분대, 진격!",
	tower			= "문이 뚫렸습니다!"
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
	PrisonYell		= "%s의 강철 감옥 %d초 남음!"
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
	allForces	= "전 코르크론, 내 명령을 따르라. 모두 죽여!",
	nextAdds	= "다음 병력: "
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
	wasteOfTime	= "녹음되고 있는 건가? 응? 좋아. 고블린 티탄 제어 모듈 시동 중. 물러서라고.",
	Module1 	= "제1 모듈, 시스템 초기화 준비 완료.",
	Victory		= "제2 모듈, 시스템 초기화 준비 완료."
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

L:SetOptionLocalization({
	InfoFrame	= "$journal:8202 정보를 정보 창으로 보기"
})

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
	specWarnMoreParasites			= "기생충이 더 필요합니다 - 막지마세요!"
})

L:SetOptionLocalization({
	specWarnActivatedVulnerable		= "활성화된 용장중 주의해야 할 용장이 있을 경우 특수 경고 보기",
	specWarnMoreParasites			= "기생충이 더 필요할 때 특수 경고 보기"
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

L:SetTimerLocalization({
	timerRoleplay		= "이벤트 진행"
})

L:SetOptionLocalization({
	timerRoleplay		= "가로쉬/스랄 이벤트 진행 바 보기",
	RangeFrame			= "거리 창 보기(8m)($spell:147126 주문의 경고 수치에 도달한 경우에만 보임)",
	InfoFrame			= "사잇단계에서 피해 감소가 없는 대상을 정보 창으로 보기",
	yellMaliceFading	= "$spell:147209 가 사라지기 전에 대화로 알리기"
})

L:SetMiscLocalization({
	wasteOfTime			= "아직 늦지 않았다, 가로쉬. 대족장이라는 짐을 내려놓거라. 지금, 여기서 끝내자. 피를 흘릴 필요는 없다.",
	NoReduce			= "피해 감소 없음",
	MaliceFadeYell		= "%s의 악의 %d초 남음!"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("SoOTrash")

L:SetGeneralLocalization({
	name =	"오그리마 공성전: 일반구간"
})
