local L

---------------------
-- A Brewing Storm --
---------------------
L= DBM:GetModLocalization("d517")

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

------------------------------
-- Crypt of Forgotten Kings --
------------------------------
L= DBM:GetModLocalization("d504")

----------------------
-- Theramore's Fall --
----------------------
L= DBM:GetModLocalization("d566")

---------------------------
-- Arena Of Annihilation --
---------------------------
L= DBM:GetModLocalization("d511")

--------------
-- Landfall --
--------------
L = DBM:GetModLocalization("Landfall")

local landfall
if UnitFactionGroup("player") == "Alliance" then
	landfall = GetDungeonInfo(590)
else
	landfall = GetDungeonInfo(595)
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
L= DBM:GetModLocalization("d620")

------------------------
-- Warlock Green Fire --
------------------------
L= DBM:GetModLocalization("d594")

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
