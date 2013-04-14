local L

--------------------------------
-- A Brewing Storm --
--------------------------------

L= DBM:GetModLocalization("BrewingStorm")

L:SetGeneralLocalization{
	name = "A Brewing Storm"
}

L:SetTimerLocalization{
	timerEvent			= "Brew Done (Aprox)"
}

L:SetOptionLocalization{
	timerEvent			= "Show timer for approximate brew completion"
}

L:SetMiscLocalization{
	BrewStart			= "The storm is starting! Get ready.",
	BrewFinish			= "You did it! Let's get this brew to the Monastery...",--Maybe switch to UPDATE_WORLD_STATES 100 progress instead in a more polished version of mod.
	BorokhulaPull		= "Last call, you fork-tongued dip-slithers!",
	BorokhulaAdds		= "calls out for reinforcements!"--In case useful/important on heroic. On normal just zerg boss and ignore these unless you want achievement.
}

--------------------------------
-- Crypt of Forgotten Kings --
--------------------------------

L= DBM:GetModLocalization("CryptofKings")

L:SetGeneralLocalization{
	name = "Crypt of Forgotten Kings"
}

----------------------
-- Theramore's Fall --
----------------------

L= DBM:GetModLocalization("TheramoreFall")

L:SetGeneralLocalization{
	name = "Theramore's Fall"
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

L:SetGeneralLocalization{
	name = landfall
}

L:SetWarningLocalization{
	WarnAchFiveAlive	= "Achievement \"Number Five Is Alive\" failed"
}

L:SetOptionLocalization{
	WarnAchFiveAlive	= "Show warning if achievement \"Number Five Is Alive\" failed."
}

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

L:SetWarningLocalization{
	specWarnLostSouls		= "Lost Souls!",
	specWarnEnslavePitLord	= "Pit Lord - Enslave Now!"
}

L:SetTimerLocalization{
	timerCombatStarts		= "Combat starts",
	timerLostSoulsCD		= "Lost Souls CD"
}

L:SetOptionLocalization{
	specWarnLostSouls		= "Show special warning when Lost Souls spawn",
	specWarnEnslavePitLord	= "Show special warning to enslave demon when Pit Lord activates/breaks free",
	timerCombatStarts		= "Show time for start of combat",
	timerLostSoulsCD		= "Show cooldown timer for next Lost Souls spawn"
}

L:SetMiscLocalization{
	LostSouls				= "Face the souls of those your kind doomed to perish, Warlock!"
}
