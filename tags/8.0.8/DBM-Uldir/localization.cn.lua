-- Mini Dragon(projecteurs@gmail.com)
-- 夏一可
-- Blizzard Entertainment
-- Last update: 2018/09/07

if GetLocale() ~= "zhCN" then return end
local L

---------------------------
-- Taloc the Corrupted --
---------------------------
L= DBM:GetModLocalization(2168)

L:SetMiscLocalization({
	Aggro	 =	"有仇恨"
})

---------------------------
-- MOTHER --
---------------------------
L= DBM:GetModLocalization(2167)

---------------------------
-- Fetid Devourer --
---------------------------
L= DBM:GetModLocalization(2146)

---------------------------
-- Zek'vhozj --
---------------------------
L= DBM:GetModLocalization(2169)

L:SetMiscLocalization({
	CThunDisc 			= 	"检索圆盘成功。正在读取克苏恩数据。",
	YoggDisc 			= 	"检索圆盘成功。正在读取尤格-萨隆数据。",
	CorruptedDisc 		= 	"检索圆盘成功。正在读取损坏数据。"  --official
})

---------------------------
-- Vectis --
---------------------------
L= DBM:GetModLocalization(2166)

L:SetOptionLocalization({
	ShowHighestFirst	 =	"将信息窗中持续感染的层数从高往低显示(默认从低到高)"
})

---------------
-- Mythrax the Unraveler --
---------------
L= DBM:GetModLocalization(2194)

---------------------------
-- Zul --
---------------------------
L= DBM:GetModLocalization(2195)

L:SetTimerLocalization({
	timerCallofCrawgCD		= "下一个嗜血抱齿兽池 (%s)",
	timerCallofHexerCD 		= "下一个鲜血妖术师池 (%s)",
	timerCallofCrusherCD	= "下一个碾压者池 (%s)",
	timerAddIncoming		= DBM_INCOMING
})

L:SetOptionLocalization({
	timerCallofCrawgCD		= "计时条：嗜血抱齿兽池开始生成时",
	timerCallofHexerCD 		= "计时条：鲜血妖术师池开始生成时",
	timerCallofCrusherCD	= "计时条：碾压者池开始生成时",
	timerAddIncoming		= "计时条：当小怪可以进攻时",
	TauntBehavior			= "设置换坦嘲讽规则",
	TwoHardThreeEasy		= "英雄/神话模式2层换，其他模式3层换",--Default
	TwoAlways				= "总是2层换",
	ThreeAlways				= "总是3层换"
})

L:SetMiscLocalization({
	Crusher			=	"碾压者",
	Bloodhexer		=	"鲜血妖术师",
	Crawg			=	"嗜血抱齿兽"
})

------------------
-- G'huun --
------------------
L= DBM:GetModLocalization(2147)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("UldirTrash")

L:SetGeneralLocalization({
	name =	"奥迪尔小怪"
})
