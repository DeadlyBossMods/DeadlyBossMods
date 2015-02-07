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


L:SetWarningLocalization({
	specWarnExpelMagicFelFades	= "5초 후 악마 사라짐 - 처음 지점으로 이동!"
})

L:SetOptionLocalization({
	specWarnExpelMagicFelFades	= "$spell:172895 주문이 사라지기 전에 처음 지점 이동 특수 경고 보기"
})

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

L:SetTimerLocalization({
	timerNightTwistedCD		= "다음 뒤틀린 밤의 신봉자"
})

L:SetOptionLocalization({
	GazeYellType		= "심연의 시선 대화 알림 방식 선택",
	Countdown			= "남은시간 초세기",
	Stacks				= "받을 때 중첩 수",
	timerNightTwistedCD	= "다음 뒤틀린 밤의 신봉자 바 보기"
})

L:SetMiscLocalization({
	BrandedYell			= "낙인(%d중첩): %dm",
	GazeYell			= "%d초 후 시선 사라짐!",
	GazeYell2			= "%2$s에게 시선! (%1$d)",
	PlayerDebuffs		= "광기의 눈길 가까움"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("HighmaulTrash")

L:SetGeneralLocalization({
	name =	"높은망치: 일반구간"
})
