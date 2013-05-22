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
	BorokhulaPull		= "Last call, you fork-tongued dip-slithers!",
	BorokhulaAdds		= "calls out for reinforcements!"--In case useful/important on heroic. On normal just zerg boss and ignore these unless you want achievement.
}

-----------------------
-- A Little Patience --
-----------------------
L= DBM:GetModLocalization("d589")

L:SetMiscLocalization{
	ScargashPull		= "Your Alliance is WEAK!"--Not yet in use but could be with more logs and combat start timers
}

---------------------------
-- Arena Of Annihilation --
---------------------------
L= DBM:GetModLocalization("d511")

-------------------------
-- Assault of Zan'vess --
-------------------------
L= DBM:GetModLocalization("d593")

L:SetMiscLocalization{
	TelvrakPull			= "Zan'vess will never fall!"
}

-----------------------
-- Blood in the Snow --
-----------------------
L= DBM:GetModLocalization("d646")

-----------------------
-- Brewmoon Festival --
-----------------------
L= DBM:GetModLocalization("d539")

L:SetTimerLocalization{
	timerBossCD		= "%s Incoming"
}

L:SetOptionLocalization{
	timerBossCD		= "Show timer for next boss spawn"
}

L:SetMiscLocalization{
	RatEngage	= "It's the Den Mother! Look out",
	BeginAttack	= "We must defend the villagers!",
	Yeti		= "Bataari War Yeti",
	Qobi		= "Warbringer Qobi"
}

------------------------------
-- Crypt of Forgotten Kings --
------------------------------
L= DBM:GetModLocalization("d504")

-----------------------
-- Dagger in the Dark --
-----------------------
L= DBM:GetModLocalization("d616")

L:SetTimerLocalization{
	timerAddsCD		= "Summon Adds CD"
}

L:SetOptionLocalization{
	timerAddsCD		= "Show timer for Lizard-Lord's Summon Adds cooldown"
}

L:SetMiscLocalization{
	LizardLord		= "Dem Saurok be guardin de cave.  Let's take care of 'em."
}

------------------------
-- Greenstone Village --
------------------------
L= DBM:GetModLocalization("d492")

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
	WarnAchFiveAlive	= "Show warning if achievement \"Number Five Is Alive\" failed"
}

----------------------
-- Theramore's Fall --
----------------------
L= DBM:GetModLocalization("d566")

--------------------------------
-- Troves of the Thunder King --
--------------------------------
L= DBM:GetModLocalization("d620")

----------------
-- Unga Ingoo --
----------------
L= DBM:GetModLocalization("d499")

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