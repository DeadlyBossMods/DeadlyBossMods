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

---------------------------
-- War Council --
---------------------------
L= DBM:GetModLocalization(1997)

---------------------------
-- Eonar, the Lifebinder --
---------------------------
L= DBM:GetModLocalization(2025)

---------------------------
-- Portal Keeper Hasabel --
---------------------------
L= DBM:GetModLocalization(1985)

L:SetOptionLocalization({
	ShowAllPlatforms =	"不管玩家平台位置顯示所有提示"
})

L:SetMiscLocalization({
	Xoroth = "Witness Xoroth, a world of infernal heat and scorched bones!",
	Rancora = "Gaze upon Rancora, a landscape of festering pools and skittering death!",
	Nathreza = "Nathreza... once a world of magic and knowledge, now a twisted landscape from which none escape."
})

---------------------------
-- Imonar the Soulhunter --
---------------------------
L= DBM:GetModLocalization(2009)

---------------------------
-- Kin'garoth --
---------------------------
L= DBM:GetModLocalization(2004)

L:SetOptionLocalization({
	InfoFrame =	"為戰鬥總覽顯示訊息框架"
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
	timerBossIncoming		= "Show timer for next boss swap"
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