if GetLocale() ~= "zhTW" then return end
local L

------------
--  Omen  --
------------
L = DBM:GetModLocalization("Omen")

L:SetGeneralLocalization({
	name = "年獸"
})

------------------------------
--  The Crown Chemical Co.  --
------------------------------
L = DBM:GetModLocalization("d288")

L:SetTimerLocalization({
	HummelActive		= "胡默爾開始活動",
	BaxterActive		= "巴克斯特開始活動",
	FryeActive			= "弗萊伊開始活動"
})

L:SetOptionLocalization({
	TrioActiveTimer		= "為藥劑師三人組開始活動顯示計時器"
})

L:SetMiscLocalization({
	SayCombatStart		= "他們有告訴你我是誰還有我為什麼這麼做嗎?"
})

----------------------------
--  The Frost Lord Ahune  --
----------------------------
L = DBM:GetModLocalization("d286")

L:SetWarningLocalization({
	Emerged				= "艾胡恩已現身",
	specWarnAttack		= "艾胡恩變得脆弱 - 現在攻擊!"
})

L:SetTimerLocalization({
	SubmergeTimer		= "隱沒",
	EmergeTimer			= "現身"
})

L:SetOptionLocalization({
	Emerged				= "當艾胡恩現身時顯示警告",
	specWarnAttack		= "當艾胡恩變得脆弱時顯示特別警告",
	SubmergeTimer		= "為隱沒顯示計時器",
	EmergeTimer			= "為現身顯示計時器"
})

L:SetMiscLocalization({
	Pull				= "冰石已經溶化了!"
})

----------------------
--  Coren Direbrew  --
----------------------
L = DBM:GetModLocalization("d287")

L:SetWarningLocalization({
	specWarnBrew		= "在他再丟你另一個前喝掉酒!",
	specWarnBrewStun	= "提示:你瘋狂了,記得下一次喝啤酒!"
})

L:SetOptionLocalization({
	specWarnBrew		= "為$spell:47376顯示特別警告",
	specWarnBrewStun	= "為$spell:47340顯示特別警告"
})

L:SetMiscLocalization({
	YellBarrel			= "我中了空桶(暈)"
})

----------------
--  Brewfest  --
----------------
L = DBM:GetModLocalization("Brew")

L:SetGeneralLocalization({
	name = "啤酒節"
})

L:SetOptionLocalization({
	NormalizeVolume			= "在啤酒節區域時，自動地調整對話聲道以匹配音樂聲道的音量。(如果音樂聲道沒有開啟，則會設成静音。)"
})

-----------------------------
--  The Headless Horseman  --
-----------------------------
L = DBM:GetModLocalization("d285")

L:SetWarningLocalization({
	WarnPhase				= "第%d階段",
	warnHorsemanSoldiers	= "跳動的南瓜出現了!",
	warnHorsemanHead		= "旋風斬 - 轉換目標!"
})

L:SetOptionLocalization({
	WarnPhase				= "為每個階段改變顯示警告",
	warnHorsemanSoldiers	= "為跳動的南瓜出現顯示警告",
	warnHorsemanHead		= "為旋風斬顯示特別警告 (第二次及最後的頭顱出現)"
})

L:SetMiscLocalization({
	HorsemanSummon			= "騎士甦醒...",
	HorsemanSoldiers		= "士兵們起立，挺身奮戰!讓這個位死去的騎士得到最後的勝利!"
})

------------------------------
--  The Abominable Greench  --
------------------------------
L = DBM:GetModLocalization("Greench")

L:SetGeneralLocalization({
	name = "可惡的格林奇"
})

--------------------------
--  Plants Vs. Zombies  --
--------------------------
L = DBM:GetModLocalization("PlantsVsZombies")

L:SetGeneralLocalization({
	name = "植物大戰僵屍"
})

L:SetWarningLocalization({
	warnTotalAdds	= "總共已進攻的殭屍群:%d",
	specWarnWave	= "大群的殭屍!"
})

L:SetTimerLocalization{
	timerWave		= "下一次大群的殭屍"
}

L:SetOptionLocalization({
	warnTotalAdds	= "提示大群的殭屍的總數量",
	specWarnWave	= "為大群的殭屍顯示特別警告",
	timerWave		= "為下一次大群的殭屍顯示計時器"
})

L:SetMiscLocalization({
	MassiveWave		= "大群的殭屍要來啦!"
})

--------------------------
--  Demonic Invasions  --
--------------------------
L = DBM:GetModLocalization("DemonInvasions")

L:SetGeneralLocalization({
	name = "惡魔入侵"
})

--------------------------
--  Memories of Azeroth: Burning Crusade  --
--------------------------
L = DBM:GetModLocalization("BCEvent")

L:SetGeneralLocalization({
	name = "MoA: Burning Crusade"
})

--------------------------
--  Memories of Azeroth: Wrath of the Lich King  --
--------------------------
L = DBM:GetModLocalization("WrathEvent")

L:SetGeneralLocalization({
	name = "MoA: WotLK"
})

L:SetMiscLocalization{
	Emerge				= "從地底鑽出!",
	Burrow				= "鑽進地裡!"
}

--------------------------
--  Memories of Azeroth: Cataclysm  --
--------------------------
L = DBM:GetModLocalization("CataEvent")

L:SetGeneralLocalization({
	name = "MoA: Cataclysm"
})

----------------------------------
--  Azeroth Event World Bosses  --
----------------------------------

-- Lord Kazzak (Badlands)
L = DBM:GetModLocalization("KazzakClassic")

L:SetGeneralLocalization{
	name = "卡札克領主"
}

L:SetMiscLocalization({
	Pull		= "為了軍團!為了基爾加德!"
})

-- Azuregos (Azshara)
L = DBM:GetModLocalization("Azuregos")

L:SetGeneralLocalization{
	name = "艾索雷苟斯"
}

L:SetMiscLocalization({
	Pull		= "我保護著這個地方。神秘的秘法不能受到褻瀆。"
})

-- Taerar (Ashenvale)
L = DBM:GetModLocalization("Taerar")

L:SetGeneralLocalization{
	name = "泰拉爾"
}

L:SetMiscLocalization({
	Pull		= "和平不過是短暫的夢想!讓夢魘統治整個世界吧!"
})

-- Ysondre (Feralas)
L = DBM:GetModLocalization("Ysondre")

L:SetGeneralLocalization{
	name = "伊索德雷"
}

L:SetMiscLocalization({
	Pull		= "生命的希冀已被切斷!夢遊者要展開報復!"
})

-- Lethon (Hinterlands)
L = DBM:GetModLocalization("Lethon")

L:SetGeneralLocalization{
	name = "雷索"
}

-- Emeriss (Duskwood)
L = DBM:GetModLocalization("Emeriss")

L:SetGeneralLocalization{
	name = "艾莫莉絲"
}

L:SetMiscLocalization({
	Pull		= "希望是靈魂染上的疾病!這片土地應該枯竭，從此死氣騰騰!"
})

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

---------------------------
--  Fire Ring Challenge  --
---------------------------
L = DBM:GetModLocalization("Rings")

L:SetGeneralLocalization({
	name = "火鳥的挑戰"
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
