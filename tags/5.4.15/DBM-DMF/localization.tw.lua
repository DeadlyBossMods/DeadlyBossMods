if GetLocale() ~= "zhTW" then return end
local L

--------------------------
--  Blastenheimer 5000  --
--------------------------
L = DBM:GetModLocalization("Cannon")

L:SetGeneralLocalization({
	name = "5000型超級大砲"
})

-------------
--  Gnoll  --
-------------
L = DBM:GetModLocalization("Gnoll")

L:SetGeneralLocalization({
	name = "痛扁豺狼人"
})

L:SetWarningLocalization({
	warnGameOverQuest	= "獲得%d點，此次最多可能取得%d點。",
	warnGameOverNoQuest	= "此次遊戲最多可能取得%d點。",
	warnGnoll			= "豺狼人出現",
	warnHogger			= "霍格出現",
	specWarnHogger		= "霍格出現!"
})

L:SetOptionLocalization({
	warnGameOver	= "當遊戲結束時顯示最多可能取得的點數",
	warnGnoll		= "為豺狼人出現顯示警告",
	warnHogger		= "為霍格出現顯示警告",
	specWarnHogger	= "為霍格出現顯示特別警告"
})

------------------------
--  Shooting Gallery  --
------------------------
L = DBM:GetModLocalization("Shot")

L:SetGeneralLocalization({
	name = "打靶場"
})

L:SetOptionLocalization({
	SetBubbles			= "自動地為$spell:101871關閉對話氣泡功能<br/>(當遊戲結束後還原功能)"
})

----------------------
--  Tonk Challenge  --
----------------------
L = DBM:GetModLocalization("Tonks")

L:SetGeneralLocalization({
	name = "坦克大戰"
})

-----------------------
--  Darkmoon Rabbit  --
-----------------------
L = DBM:GetModLocalization("Rabbit")

L:SetGeneralLocalization({
	name = "暗月小兔"
})

-----------------------
--  Darkmoon Moonfang  --
-----------------------
L = DBM:GetModLocalization("Moonfang")

L:SetGeneralLocalization({
	name = "月牙"
})

L:SetWarningLocalization({
	specWarnCallPack		= "呼叫狼群 - 跑離月牙超過40碼!",
	specWarnMoonfangCurse	= "月牙的詛咒- 跑離月牙超過10碼!"
})
