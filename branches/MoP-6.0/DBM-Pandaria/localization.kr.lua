if GetLocale() ~= "koKR" then return end
local L

-----------------------
-- Sha of Anger --
-----------------------
L= DBM:GetModLocalization(691)

L:SetOptionLocalization({
	RangeFrame			= "$spell:119622 효과에 맞추어 거리 창 보기"
})

L:SetMiscLocalization({
	Pull				= "그래... 그래! 네 분노를 행동으로 보여줘! 덤벼봐!"
})

-----------------------
-- Salyis --
-----------------------
L= DBM:GetModLocalization(725)

L:SetMiscLocalization({
	Pull				= "놈들의 시체를 가져와라!"
})

--------------
-- Oondasta --
--------------
L= DBM:GetModLocalization(826)

L:SetMiscLocalization({
	Pull				= "감히 우릴 막겠다고? 잔달라 부족을 막을 순 없다! 이번엔 안 돼!"
})

---------------------------
-- Nalak, The Storm Lord --
---------------------------
L= DBM:GetModLocalization(814)

L:SetMiscLocalization({
	Pull				= "한기어린 바람이 느껴지느냐? 곧 폭풍이 몰아칠 것이다..."
})

---------------------------
-- Chi-ji, The Red Crane --
---------------------------
L= DBM:GetModLocalization(857)

L:SetOptionLocalization({
	BeaconArrow			= "$spell:144473 대상이 정해진 경우 DBM 화살표 보기"
})

L:SetMiscLocalization({
	Pull				= "자, 시작하자.",
	Victory				= "너희의 희망은 밝게 빛나고, 역경을 극복하려고 힘을 합치면 더욱 밝게 빛난다. 가장 어두운 곳에서도, 희망이 너희의 길을 밝혀줄 것이다."
})

------------------------------
-- Yu'lon, The Jade Serpent --
------------------------------
L= DBM:GetModLocalization(858)

L:SetMiscLocalization({
	Pull				= "시험을 시작하자!",
	Wave1				= "시련 때문에 판단력이 흐려져선 안 된다!",
	Wave2				= "내면의 목소리에 귀를 기울이고, 진실을 찾아라!",
	Wave3				= "너희 행동이 어떤 결과를 낳을지 생각해라!",
	Victory				= "이 시험에서 너희의 지혜가 빛을 발했다. 그 지혜가 어두운 곳에서 항상 너희의 등불이 되길."
})

--------------------------
-- Niuzao, The Black Ox --
--------------------------
L= DBM:GetModLocalization(859)

L:SetMiscLocalization({
	Pull				= "지금 확인해 보지.",
	Victory				= "상상도 할 수 없는 강력한 적들에게 둘러싸여 있는 그런 때에도, 인내가 너희를 굳건히 지탱할 것이다. 다가오는 시간에 이 교훈을 반드시 기억해라.",
	VictoryDem			= "Rakkas shi alar re pathrebosh il zila rethule kiel shi shi belaros rikk kanrethad adare revos shi xi thorje Rukadare zila te lok zekul melar "--Cover all bases and all
})

---------------------------
-- Xuen, The White Tiger --
---------------------------
L= DBM:GetModLocalization(860)

L:SetMiscLocalization({
	Pull				= "하하! 시험을 시작하자!",
	Victory				= "너흰 강하다. 너희 생각보다 훨씬. 앞에 놓인 어둠 속으로 들어갈 때 이것을 기억하고, 방패로 삼아라."
})

------------------------------------
-- Ordos, Fire-God of the Yaungol --
------------------------------------
L= DBM:GetModLocalization(861)

L:SetMiscLocalization({
	Pull					= "영원한 화로에서 내 자리를 대신해라."
})

-----------------
--  Zandalari  --
-----------------
L = DBM:GetModLocalization("Zandalari")

L:SetGeneralLocalization({
	name =	"잔달라 부족"
})
