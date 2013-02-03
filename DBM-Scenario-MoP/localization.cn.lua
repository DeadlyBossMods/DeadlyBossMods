-- Simplified Chinese by Diablohu(diablohudream@gmail.com)
-- Last update: 2/4/2013

if GetLocale() ~= "zhCN" then return end
local L

----------------------
-- Theramore's Fall --
----------------------

L= DBM:GetModLocalization("TheramoreFall")

L:SetGeneralLocalization{
	name = "塞拉摩的沦陷"
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
	name = "破军比武场"
}

--------------
-- Landfall --
--------------

L = DBM:GetModLocalization("Landfall")

local landfall
if UnitFactionGroup("player") == "Alliance" then
	landfall = "雄狮港"
else
	landfall = "统御岗哨"
end

L:SetGeneralLocalization({
	name = landfall
})

L:SetWarningLocalization({
	WarnAchFiveAlive	= "成就“五号还活着”失败"
})

L:SetOptionLocalization({
	WarnAchFiveAlive	= "警报：成就“五号还活着”失败"
})