if GetLocale() ~= "zhTW" then return end
local L

---------------
-- Odyn --
---------------
L= DBM:GetModLocalization(1819)

---------------------------
-- 	--
---------------------------
L= DBM:GetModLocalization(1830)

L:SetOptionLocalization({
	YellActualRaidIcon		= "改變易變沫液的所有DBM大喊至說團隊圖示至玩家而非符合同顏色(需要團隊隊長)",
	FilterSameColor			= "如果易變沫液和玩家減益同顏色則不要為設置團隊圖示，大喊或是特別警告。"
})

---------------------------
-- Helya --
---------------------------
L= DBM:GetModLocalization(1829)

L:SetTimerLocalization({
	OrbsTimerText		= "下一個球(%d-%s)"
})

L:SetMiscLocalization({
	phaseThree =	"凡人，你們根本白費工夫！歐丁永遠別想自由！",
	near =			"近",
	far =			"遠",
	multiple =		"多"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("TrialofValorTrash")

L:SetGeneralLocalization({
	name =	"勇氣試煉小怪"
})
