if GetLocale() ~= "zhTW" then return end
local L

---------------------------
--  Shriekwing --
---------------------------
--L= DBM:GetModLocalization(2393)

---------------------------
--  Altimor the Huntsman --
---------------------------
--L= DBM:GetModLocalization(2429)

---------------------------
--  Hungering Destroyer --
---------------------------
L= DBM:GetModLocalization(2428)

L:SetOptionLocalization({
	SortDesc 				= "按最高減益堆疊來排序$spell:334755的訊息框架。（而不是最低）",
	ShowTimeNotStacks		= "在$spell:334755上顯示剩餘時間，而不是堆疊數。"
})

---------------------------
--  Artificer Xy'Mox --
---------------------------
--L= DBM:GetModLocalization(2418)

---------------------------
--  Sun King's Salvation/Kael'thas --
---------------------------
--L= DBM:GetModLocalization(2422)

---------------------------
--  Lady Inerva Darkvein --
---------------------------
L= DBM:GetModLocalization(2420)

L:SetTimerLocalization{
	timerDesiresContainer		= "慾望滿了",
	timerBottledContainer		= "瓶裝滿了",
	timerSinsContainer			= "罪孽滿了",
	timerConcentrateContainer	= "濃縮滿了"
}

L:SetOptionLocalization({
	timerContainers				= "顯示計時器，以顯示容器填充進度和直至充滿的剩餘時間"
})

---------------------------
--  The Council of Blood --
---------------------------
--L= DBM:GetModLocalization(2426)

---------------------------
--  Sludgefist --
---------------------------
--L= DBM:GetModLocalization(2394)

---------------------------
--  Stoneborne Generals --
---------------------------
--L= DBM:GetModLocalization(2425)

---------------------------
--  Sire Denathrius --
---------------------------
--L= DBM:GetModLocalization(2424)

L:SetMiscLocalization({
	--CrimsonSpawn	= "Crimson Cabalists answer the call of Denathrius."
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("CastleNathriaTrash")

L:SetGeneralLocalization({
	name =	"納撒亞城小怪"
})
