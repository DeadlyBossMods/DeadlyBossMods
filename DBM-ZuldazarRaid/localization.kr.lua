if GetLocale() ~= "koKR" then return end
local L

---------------------------
--  Ra'wani Kanae/Frida Ironbellows (Both) --
-- Same exact enoucnter, diff names
---------------------------
--L= DBM:GetModLocalization(2344)--Ra'wani Kanae (Alliance)

--L= DBM:GetModLocalization(2333)--Frida Ironbellows (Horde)

---------------------------
--  King Grong/Grong the Revenant (Both) --
---------------------------
--L= DBM:GetModLocalization(2325)--King Grong (Horde)

--L= DBM:GetModLocalization(2340)--Grong the Revenant (Alliance)

---------------------------
--  Grimfang and Firecaller/Flamefist and the Illuminated (Both) --
-- Same exact enoucnter, diff names
---------------------------
--L= DBM:GetModLocalization(2323)--Grimfang and Firecaller (Alliance)

--L= DBM:GetModLocalization(2341)--Flamefist and the Illuminated (Horde)

---------------------------
--  Opulence (Alliance) --
---------------------------
L= DBM:GetModLocalization(2342)

L:SetMiscLocalization({
	Bulwark =	"보루",
	Hand	=	"손"
})

---------------------------
--  Loa Council (Alliance) --
---------------------------
L= DBM:GetModLocalization(2330)

L:SetMiscLocalization({
	BwonsamdiWrath =	"그렇게 죽고 싶었으면, 더 일찍 날 찾아왔어야지!",
	BwonsamdiWrath2 =	"히히, 어차피 언젠간... 모두 날 섬기게 돼 있지!",
	Bird			 =	"새"
})

---------------------------
--  King Rastakhan (Alliance) --
---------------------------
L= DBM:GetModLocalization(2335)

L:SetOptionLocalization({
	AnnounceAlternatePhase	= "다른 세계의 일반 경고도 같이 보기 (타이머는 이 옵션과 상관없이 항상 표시됩니다)"
})

---------------------------
-- High Tinker Mekkatorgue (Horde) --
---------------------------
--L= DBM:GetModLocalization(2332)

---------------------------
--  Sea Priest Blockade (Horde) --
---------------------------
--L= DBM:GetModLocalization(2337)

---------------------------
--  Jaina Proudmoore (Horde) --
---------------------------
L= DBM:GetModLocalization(2343)

L:SetOptionLocalization({
	ShowOnlySummary2	= "반전 거리 검사시 플레이어 이름을 숨기고 요약된 정보만 표시 (근처에 있는 플레이어의 수)",
	InterruptBehavior	= "물정령 차단 알림 설정 (공대장일 경우 다른 사람의 설정을 무시함)",
	Three				= "3인 로테이션 ",--Default
	Four				= "4인 로테이션 ",
	Five				= "5인 로테이션 ",
	SetWeather			= "보스 전투를 시작하면 자동으로 날씨 효과가 낮음으로 설정되고 전투가 끝나면 이전 설정으로 복구",
})

L:SetMiscLocalization({
	Port			=	"좌현",
	Starboard		=	"우현",
	Freezing		=	"얼음 %s초 전"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("ZuldazarRaidTrash")

L:SetGeneralLocalization({
	name =	"다자알로 전투 일반몹"
})
