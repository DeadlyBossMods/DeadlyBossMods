if GetLocale() ~= "zhTW" then return end
local L

---------------------------
-- Garothi Worldbreaker --
---------------------------
L= DBM:GetModLocalization(1992)

---------------------------
-- Hounds of Sargeras --
---------------------------
L= DBM:GetModLocalization(1987)

L:SetOptionLocalization({
	SequenceTimers =	"在英雄/傳奇難度下序列的冷卻計時器關閉先前的技能施放而不是當前的技能，以減少計時器雜亂，這犧牲計時器的準確性。(快1-2秒)"
})

---------------------------
-- War Council --
---------------------------
L= DBM:GetModLocalization(1997)

---------------------------
-- Eonar, the Lifebinder --
---------------------------
L= DBM:GetModLocalization(2025)

L:SetTimerLocalization({
	timerObfuscator		=	"下一次魔能匿蹤者(%s)",
	timerDestructor 	=	"下一次魔能毀滅者(%s)",
	timerPurifier 		=	"下一次魔能淨化者(%s)",
	timerBats	 		=	"下一次風掣魔蝠(%s)"
})

L:SetMiscLocalization({
	Obfuscators =	"魔能匿蹤者",
	Destructors =	"魔能毀滅者",
	Purifiers 	=	"魔能淨化者",
	Bats 		=	"風掣魔蝠",
	EonarHealth	= 	"伊歐娜體力",
	EonarPower	= 	"伊歐娜能量"
})

---------------------------
-- Portal Keeper Hasabel --
---------------------------
L= DBM:GetModLocalization(1985)

L:SetOptionLocalization({
	ShowAllPlatforms =	"不管玩家平台位置顯示所有提示"
})

---------------------------
-- Imonar the Soulhunter --
---------------------------
L= DBM:GetModLocalization(2009)

L:SetMiscLocalization({
	DispelMe =		"快驅散我！"
})

---------------------------
-- Kin'garoth --
---------------------------
L= DBM:GetModLocalization(2004)

L:SetOptionLocalization({
	InfoFrame =	"為戰鬥總覽顯示訊息框架",
	UseAddTime = "當首領離開初始階段時總是顯示計時器而非隱藏計時器。(如停用，正確的計時器會在首領活動時恢復，但可能缺少剩餘1-2秒的警告)"
})

---------------------------
-- Varimathras --
---------------------------
L= DBM:GetModLocalization(1983)

---------------------------
-- The Coven of Shivarra --
---------------------------
L= DBM:GetModLocalization(1986)

L:SetOptionLocalization({
	timerBossIncoming		= "為下一次交換首領顯示計時器"
})

---------------------------
-- Aggramar --
---------------------------
L= DBM:GetModLocalization(1984)

---------------------------
-- Argus the Unmaker --
---------------------------
L= DBM:GetModLocalization(2031)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("AntorusTrash")

L:SetGeneralLocalization({
	name =	"安托洛斯小怪"
})