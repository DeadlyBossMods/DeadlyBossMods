if GetLocale() ~= "zhTW" then return end
local L

---------------------------
--  Eranog --
---------------------------
--L= DBM:GetModLocalization(2480)

--L:SetWarningLocalization({
--})
--
--L:SetTimerLocalization{
--}
--
--L:SetOptionLocalization({
--})
--
--L:SetMiscLocalization({
--})

---------------------------
--  Terros --
---------------------------
--L= DBM:GetModLocalization(2500)

---------------------------
--  The Primalist Council --
---------------------------
--L= DBM:GetModLocalization(2486)

---------------------------
--  Sennarth, The Cold Breath --
---------------------------
--L= DBM:GetModLocalization(2482)

---------------------------
--  Dathea, Ascended --
---------------------------
--L= DBM:GetModLocalization(2502)

---------------------------
--  Kurog Grimtotem --
---------------------------
L= DBM:GetModLocalization(2491)

L:SetTimerLocalization({
	timerDamageCD = "攻擊 (%s)",
	timerAvoidCD = "屏障 (%s)",
	timerUltimateCD = "洪荒之終 (%s)",
	timerAddEnrageCD = "激怒 (%s)"
})

L:SetOptionLocalization({
	timerDamageCD = "顯示針對目標攻擊：$spell:382563, $spell:373678, $spell:391055, $spell:373487 的計時器",
	timerAvoidCD = "顯示屏障階段：$spell:373329, $spell:391019, $spell:395893, $spell:390920 的計時器",
	timerUltimateCD = "顯示洪荒之終：$spell:374022, $spell:372456, $spell:374691, $spell:374215 的計時器",
	timerAddEnrageCD = "顯示在傳奇難度上增加的激怒計時器"
})

L:SetMiscLocalization({
	Fire	= "烈焰",
	Frost	= "冰霜",
	Earth	= "大地",
	Storm	= "風暴"
})

---------------------------
--  Broodkeeper Diurna --
---------------------------
L= DBM:GetModLocalization(2493)

L:SetMiscLocalization({
	staff		= "巨杖",
	eStaff	= "強化巨杖"
})

---------------------------
--  Raszageth the Storm-Eater --
---------------------------
L= DBM:GetModLocalization(2499)

L:SetMiscLocalization({
	negative = "負極",
	positive = "正極"
	--BreathEmote	= "菈薩葛絲開始深呼吸..."
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("VaultoftheIncarnatesTrash")

L:SetGeneralLocalization({
	name =	"洪荒化身牢獄小怪"
})
