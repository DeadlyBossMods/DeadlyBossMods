if GetLocale() ~= "zhTW" then return end
local L

----------------------
-- Theramore's Fall --
----------------------

L= DBM:GetModLocalization("TheramoreFall")

L:SetGeneralLocalization{
	name = "賽拉摩攻防戰"
}

L:SetMiscLocalization{
--	AllianceVictory = "All of you have my deepest thanks. With the Focusing Iris removed, this lifeless bomb is merely a sickening testament to Garrosh's brutality. The winds of change blow fiercely; Azeroth is on the brink of war. My apologies, but you must excuse me... I have much to consider. Farewell.",
--	HordeVictory	= "My thanks! Shall we make our way off this miserable little island?"
}

---------------------------
-- Arena Of Annihilation --
---------------------------

L= DBM:GetModLocalization("ArenaAnnihilation")

L:SetGeneralLocalization{
	name = "殲滅競技場"
}

--------------
-- Landfall --
--------------

L = DBM:GetModLocalization("Landfall")

local landfall
if UnitFactionGroup("player") == "Alliance" then
	landfall = "雄獅灘"
else
	landfall = "制霸岬"
end

L:SetGeneralLocalization({
	name = landfall
})

L:SetWarningLocalization({
	WarnAchFiveAlive	= "成就\"五小福\"失敗"
})

L:SetOptionLocalization({
	WarnAchFiveAlive	= "為成就\"五小福\"失敗顯示警告."
})
