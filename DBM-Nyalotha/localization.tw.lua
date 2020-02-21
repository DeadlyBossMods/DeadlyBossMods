--2020/02/04
--三皈依-暗影之月

if GetLocale() ~= "zhTW" then return end
local L

---------------------------
--  Wrathion, the Black Emperor --
---------------------------
--L= DBM:GetModLocalization(2368)

---------------------------
--  Maut --
---------------------------
--L= DBM:GetModLocalization(2365)

---------------------------
--  The Prophet Skitra --
---------------------------
--L= DBM:GetModLocalization(2369)

---------------------------
--  Dark Inquisitor Xanesh --
---------------------------
L= DBM:GetModLocalization(2377)

L:SetMiscLocalization({
	ObeliskSpawn	= "出現吧，暗影方尖碑！"--Only as backup, in case the NPC target check stops working
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
--L= DBM:GetModLocalization(2367)

---------------------------
-- Drest'agath --
---------------------------
--L= DBM:GetModLocalization(2373)

---------------------------
--  Vexiona --
---------------------------
--L= DBM:GetModLocalization(2370)

---------------------------
--  Ra-den the Despoiled --
---------------------------
L= DBM:GetModLocalization(2364)

L:SetOptionLocalization({
	OnlyParentBondMoves		= "只有當你是帶電者時才顯示電鍊連結的特別警告"
})

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
	Two					= "2人輪流 ",--Default
	Three				= "3人輪流 ",
	Four				= "4人輪流 ",
	Five				= "5人輪流 "
})

---------------------------
--  Carapace of N'Zoth --
---------------------------
--L= DBM:GetModLocalization(2366)

---------------------------
--  N'Zoth, the Corruptor --
---------------------------
L= DBM:GetModLocalization(2375)

L:SetOptionLocalization({
	InterruptBehavior	= "設置心志破壞的打斷方式（團長的設置將覆蓋全團）",
	Four				= "4人輪流 ",
	Five				= "5人輪流 ",--Default
	Six					= "6人輪流 ",
	NoReset				= "無盡增長 ",
	ArrowOnGlare		= "為 $spell:317874 顯示左/右方向箭頭"
})

L:SetMiscLocalization({
	ExitMind		= "離開精神世界",
	Gate			= "心門"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("NyalothaTrash")

L:SetGeneralLocalization({
	name =	"奈奧羅薩小怪"
})
