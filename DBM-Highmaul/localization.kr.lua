if GetLocale() ~= "koKR" then return end
local L

---------------
-- Kargath Bladefist --
---------------
L= DBM:GetModLocalization(1128)

L:SetTimerLocalization({
	timerSweeperCD			= DBM_CORE_AUTO_TIMER_TEXTS.next:format("높은망치 난동꾼")
})

L:SetOptionLocalization({
	timerSweeperCD			= "다음 높은망치 난동꾼 바 보기",
	countdownSweeper		= "높은망치 난동꾼 이전에 초읽기 듣기"
})

---------------------------
-- The Butcher --
---------------------------
L= DBM:GetModLocalization(971)

---------------------------
-- Tectus, the Living Mountain --
---------------------------
L= DBM:GetModLocalization(1195)

L:SetMiscLocalization({
	pillarSpawn	= "산이여, 솟아라!"
})

------------------
-- Brackenspore, Walker of the Deep --
------------------
L= DBM:GetModLocalization(1196)

L:SetOptionLocalization({
	InterruptCounter	= "부패 시전 횟수 초기화",
	Two					= "2회 시전 후",
	Three				= "3회 시전 후",
	Four				= "4회 시전 후"
})

--------------
-- Twin Ogron --
--------------
L= DBM:GetModLocalization(1148)

L:SetOptionLocalization({
	PhemosSpecial	= "페모스의 대기시간 초읽기 듣기",
	PolSpecial		= "폴의 대기시간 초읽기 듣기",
	PhemosSpecialVoice	= "펠모스의 주문을 선택한 음성안내 소리로 듣기",
	PolSpecialVoice		= "폴의 주문을 선택한 음성안내 소리로 듣기"
})

--------------------
--Koragh --
--------------------
L= DBM:GetModLocalization(1153)

L:SetMiscLocalization({
	supressionTarget1	= "박살내주마!",
	supressionTarget2	= "침묵!",
	supressionTarget3	= "닥쳐라!",
	supressionTarget4	= "으허허허, 반으로 찢어주마!"
})

--------------------------
-- Imperator Mar'gok --
--------------------------
L= DBM:GetModLocalization(1197)

L:SetMiscLocalization({
	BrandedYell			= "%2$s 에게 낙인! (%1$s)",
	GazeYell			= "%d초 후 시선 사라짐!"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("HighmaulTrash")

L:SetGeneralLocalization({
	name =	"높은망치: 일반구간"
})
