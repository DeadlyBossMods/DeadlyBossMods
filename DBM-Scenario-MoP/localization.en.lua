local L

----------------------
-- Theramore's Fall --
----------------------

L= DBM:GetModLocalization("TheramoreFall")

L:SetGeneralLocalization{
	name = "Theramore's Fall"
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
	name = "Arena Of Annihilation"
}

--------------
-- Landfall --
--------------

L = DBM:GetModLocalization("Landfall")

local landfall
if UnitFactionGroup("player") == "Alliance" then
	landfall = "Lion's Landing"
else
	landfall = "Domination Point"
end

L:SetGeneralLocalization({
	name = landfall
})

L:SetWarningLocalization({
	WarnAchFiveAlive	= "Achievement \"Number Five Is Alive\" failed"
})

L:SetOptionLocalization({
	WarnAchFiveAlive	= "Show warning if achievement \"Number Five Is Alive\" failed."
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
	name = "Pursuing the Black Harvest"
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
