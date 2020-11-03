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
	SortDesc 				= "使用降序排列$spell:334755的減益層數訊息框架。",
	ShowTimeNotStacks		= "在$spell:334755上顯示剩餘時間代替層數。"
})

---------------------------
--  Artificer Xy'Mox --
---------------------------
--L= DBM:GetModLocalization(2418)

L:SetMiscLocalization({
	--Phase2			= "The anticipation to use this relic is killing me! Though, it will more likely kill you.",
	Phase2Demonic	= "Lok zennshinagas xi ril zila refir il rethule no Rakkas az alar alar archim maev shi ",--Boss has Curse of Tongues
	--Phase3			= "I hope this wondrous item is as lethal as it looks!",
	Phase3Demonic	= "X ante zila romathis alar il re thorje re az modas "--Boss has Curse of Tongues
})

---------------------------
--  Sun King's Salvation/Kael'thas --
---------------------------
--L= DBM:GetModLocalization(2422)

---------------------------
--  Lady Inerva Darkvein --
---------------------------
L= DBM:GetModLocalization(2420)

L:SetTimerLocalization{
	timerDesiresContainer		= "慾望滿",
	timerBottledContainer		= "瓶裝滿",
	timerSinsContainer			= "罪惡滿",
	timerConcentrateContainer	= "濃縮滿"
}

L:SetOptionLocalization({
	timerContainers				= "顯示容器填充進度和充滿剩餘時間的計時器"
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
