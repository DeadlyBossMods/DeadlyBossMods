if GetLocale() ~= "koKR" then return end
local L

-----------------------
-- Sha of Anger --
-----------------------
L= DBM:GetModLocalization(691)

L:SetOptionLocalization({
	RangeFrame			= "$spell:119622 상태에 따른 거리 창 보기"
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

---------------------------
-- Chi-ji, The Red Crane --
---------------------------
L= DBM:GetModLocalization(857)

L:SetOptionLocalization({
	BeaconArrow			= "$spell:144473 주문의 영향을 누군가 받은 경우 DBM 화살표 보기"
})

------------------------------
-- Yu'lon, The Jade Serpent --
------------------------------
L= DBM:GetModLocalization(858)

--------------------------
-- Niuzao, The Black Ox --
--------------------------
L= DBM:GetModLocalization(859)

---------------------------
-- Xuen, The White Tiger --
---------------------------
L= DBM:GetModLocalization(860)

------------------------------------
-- Ordos, Fire-God of the Yaungol --
------------------------------------
L= DBM:GetModLocalization(861)
