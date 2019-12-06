--Mini Dragon
--2019/11/28

if GetLocale() ~= "zhCN" then return end
local L

---------------------------
--  Wrathion, the Black Emperor --
---------------------------
L= DBM:GetModLocalization(2368)

L:SetWarningLocalization({

})

L:SetTimerLocalization({

})

L:SetOptionLocalization({

})

L:SetMiscLocalization({
})

---------------------------
--  Maut --
---------------------------
L= DBM:GetModLocalization(2365)

---------------------------
--  The Prophet Skitra --
---------------------------
L= DBM:GetModLocalization(2369)

---------------------------
--  Dark Inquisitor Xanesh --
---------------------------
L= DBM:GetModLocalization(2377)

L:SetMiscLocalization({
	ObeliskSpawn	= "暗影之碑，起来吧！"--Only as backup, in case the NPC target check stops working
})

---------------------------
--  The Hivemind --
---------------------------
L= DBM:GetModLocalization(2372)

L:SetMiscLocalization({
	Together	= "Boss靠近",
	Apart		= "Boss分开"
})

---------------------------
--  Shad'har the Insatiable --
---------------------------
L= DBM:GetModLocalization(2367)

---------------------------
-- Drest'agath --
---------------------------
L= DBM:GetModLocalization(2373)

---------------------------
--  Vexiona --
---------------------------
L= DBM:GetModLocalization(2370)

---------------------------
--  Ra-den the Despoiled --
---------------------------
L= DBM:GetModLocalization(2364)

L:SetMiscLocalization({
	Furthest	= "Furthest Target",
	Closest		= "Closest Target"
})

---------------------------
--  Il'gynoth, Corruption Reborn --
---------------------------
L= DBM:GetModLocalization(2374)

L:SetOptionLocalization({
	SetIconOnlyOnce		= "除非一个淤泥死亡，否则不刷新标记图标",
	InterruptBehavior	= "设置脉动之血的打断方式（团长覆盖全团）",
	Two					= "2人轮流",--Default
	Three				= "3人轮流",
	Four				= "4人轮流",
	Five				= "5人轮流"
})

---------------------------
--  Carapace of N'Zoth --
---------------------------
L= DBM:GetModLocalization(2366)

---------------------------
--  N'Zoth, the Corruptor --
---------------------------
L= DBM:GetModLocalization(2375)

L:SetMiscLocalization({
	ExitMind		= "离开神思",
	Away			  = "远离",
	Toward			= "向前"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("NyalothaTrash")

L:SetGeneralLocalization({
	name =	"尼奥罗萨小怪"
})
