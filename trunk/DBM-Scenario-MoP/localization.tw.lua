if GetLocale() ~= "zhTW" then return end
local L

----------------------
-- Theramore's Fall --
----------------------

L= DBM:GetModLocalization("TheramoreFall")

L:SetGeneralLocalization{
	name = "賽拉摩攻防戰"
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

--------------------------------
-- Troves of the Thunder King --
--------------------------------

L= DBM:GetModLocalization("Troves")

L:SetGeneralLocalization{
	name = "Troves of the Thunder King"
}

------------------------
-- Warlock Green Fire --
------------------------

L= DBM:GetModLocalization("GreenFire")

L:SetGeneralLocalization{
	name = "Warlock Green Fire"--No idea what real name is. It's not something i can test or verify.
}

L:SetWarningLocalization({
	specWarnLostSouls		= "Lost Souls!",
	specWarnEnslavePitLord	= "Pit Lord - Enslave Now!"
})

L:SetTimerLocalization({
	timerLostSoulsCD		= "Lost Souls CD"
})

L:SetOptionLocalization({
	specWarnLostSouls		= "Show special warning when Lost Souls spawn",
	specWarnEnslavePitLord	= "Show special warning to enslave demon when Pit Lord activates/breaks free",
	timerLostSoulsCD		= "Show cooldown timer for next Lost Souls spawn"
})

L:SetMiscLocalization({
	LostSouls				= "Face the souls of those your kind doomed to perish, Warlock!"
})
