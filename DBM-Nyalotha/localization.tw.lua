--2020/01/22
--三皈依-暗影之月

if GetLocale() ~= "zhTW" then return end
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
	--ObeliskSpawn	= "暗影之碑，起來吧！"--Only as backup, in case the NPC target check stops working
})

---------------------------
--  The Hivemind --
---------------------------
L= DBM:GetModLocalization(2372)

L:SetMiscLocalization({
	Together	= "首領靠近",
	Apart		= "首領分開"
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
	Furthest	= "最遠的目標",
	Closest		= "最近的目標"
})

---------------------------
--  Il'gynoth, Corruption Reborn --
---------------------------
L= DBM:GetModLocalization(2374)

L:SetOptionLocalization({
	SetIconOnlyOnce		= "僅設置一次圖示，除非一個淤泥死亡，否則不刷新標記圖示",
	InterruptBehavior	= "設置脈動之血的打斷方式（團長的設置將覆蓋全團）",
	Two					= "2人輪流",--Default
	Three				= "3人輪流",
	Four				= "4人輪流",
	Five				= "5人輪流"
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
	ExitMind		= "離開神思",
	Away			  = "遠離",
	Toward			= "向前"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("NyalothaTrash")

L:SetGeneralLocalization({
	name =	"奈奧羅薩小怪"
})
