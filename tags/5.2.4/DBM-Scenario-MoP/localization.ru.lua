if GetLocale() ~= "ruRU" then return end
local L

--------------------------------
-- A Brewing Storm --
--------------------------------
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

--------------------------------
-- Crypt of Forgotten Kings --
--------------------------------
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

L:SetWarningLocalization({
	WarnAchFiveAlive	= "Достижение \"Неубиваемая пятерка\" провалено"
})

L:SetOptionLocalization({
	WarnAchFiveAlive	= "Показывать предупреждение, если достижение \"Неубиваемая пятерка\" провалено."
})

--------------------------------
-- Troves of the Thunder King --
--------------------------------
L= DBM:GetModLocalization("d620")

------------------------
-- Warlock Green Fire --
------------------------
L= DBM:GetModLocalization("d594")

L:SetWarningLocalization({
	specWarnLostSouls		= "Заблудшие души!",
	specWarnEnslavePitLord	= "Властитель преисподней - Поработите демона!"
})

L:SetTimerLocalization({
	timerCombatStarts		= "Бой начинается",
	timerLostSoulsCD		= "Восст. Заблудшие души"
})

L:SetOptionLocalization({
	specWarnLostSouls		= "Спец-предупреждение, когда появляются Заблудшие души",
	specWarnEnslavePitLord	= "Спец-предупреждение поработить демона, когда Властитель преисподней активируется/освобождается",
	timerCombatStarts		= "Отсчет времени до начала боя",
	timerLostSoulsCD		= "Отсчет времени до появления следующих Заблудших душ"
})

L:SetMiscLocalization({
	LostSouls				= "Face the souls of those your kind doomed to perish, Warlock!"
})