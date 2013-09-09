if GetLocale() ~= "koKR" then return end
local L

-----------------------
-- Sha of Anger --
-----------------------
L= DBM:GetModLocalization(691)

L:SetOptionLocalization({
	RangeFrame			= "$spell:119622 효과에 맞추어 거리 창 보기",
	ReadyCheck			= "우두머리 전투 시작시 전투 준비 소리 듣기(대상 선택 유무 무관)"
})

L:SetMiscLocalization({
	Pull				= "그래... 그래! 네 분노를 행동으로 보여줘! 덤벼봐!"
})

-----------------------
-- Salyis --
-----------------------
L= DBM:GetModLocalization(725)

L:SetOptionLocalization({
	ReadyCheck			= "우두머리 전투 시작시 전투 준비 소리 듣기(대상 선택 유무 무관)"
})

L:SetMiscLocalization({
	Pull				= "놈들의 시체를 가져와라!"
})

--------------
-- Oondasta --
--------------
L= DBM:GetModLocalization(826)

L:SetOptionLocalization({
	ReadyCheck			= "우두머리 전투 시작시 전투 준비 소리 듣기(대상 선택 유무 무관)"
})

L:SetMiscLocalization({
	Pull				= "감히 우릴 막겠다고? 잔달라 부족을 막을 순 없다! 이번엔 안 돼!"
})

---------------------------
-- Nalak, The Storm Lord --
---------------------------
L= DBM:GetModLocalization(814)

L:SetOptionLocalization({
	ReadyCheck			= "우두머리 전투 시작시 전투 준비 소리 듣기(대상 선택 유무 무관)"
})

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
	Pull				= "Then let us begin.",
	Victory				= "Your hope shines brightly, and even more brightly when you work together to overcome. It will ever light your way in even the darkest of places."
})

------------------------------
-- Yu'lon, The Jade Serpent --
------------------------------
L= DBM:GetModLocalization(858)

L:SetMiscLocalization({
	Pull				= "The trial begins!",
	Wave1				= "Do not let your judgement be clouded in trying times!",
	Wave2				= "Listen to your inner voice, and seek out the truth!",
	Victory				= "Your wisdom has seen you through this trial. May it ever light your way out of dark places."
})

--------------------------
-- Niuzao, The Black Ox --
--------------------------
L= DBM:GetModLocalization(859)

L:SetMiscLocalization({
	Pull				= "We shall see.",
--	Victory				= "",
	VictoryDem			= "Rakkas shi alar re pathrebosh il zila rethule kiel shi shi belaros rikk kanrethad adare revos shi xi thorje Rukadare zila te lok zekul melar "--Cover all bases and all
})

---------------------------
-- Xuen, The White Tiger --
---------------------------
L= DBM:GetModLocalization(860)

L:SetMiscLocalization({
	Pull				= "Ha ha! The trial commences",
	Victory				= "You are strong, stronger even than you realize. Carry this thought with you into the darkness ahead, and let it shield you."
})

------------------------------------
-- Ordos, Fire-God of the Yaungol --
------------------------------------
L= DBM:GetModLocalization(861)
