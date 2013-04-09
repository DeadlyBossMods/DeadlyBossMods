if GetLocale() ~= "ruRU" then return end
local L

----------------------
-- Theramore's Fall --
----------------------

L= DBM:GetModLocalization("TheramoreFall")

L:SetGeneralLocalization{
	name = "Падение Терамора"
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
	name = "Арена испытаний"
}

--------------
-- Landfall --
--------------

L = DBM:GetModLocalization("Landfall")

local landfall
if UnitFactionGroup("player") == "Alliance" then
	landfall = "Львиный лагерь"
else
	landfall = "Крепость Покорителей"
end

L:SetGeneralLocalization({
	name = landfall
})

L:SetWarningLocalization({
	WarnAchFiveAlive	= "Достижение \"Неубиваемая пятерка\" провалено"
})

L:SetOptionLocalization({
	WarnAchFiveAlive	= "Показывать предупреждение, если достижение \"Неубиваемая пятерка\" провалено."
})

--------------------------------
-- Troves of the Thunder King --
--------------------------------

L= DBM:GetModLocalization("Troves")

L:SetGeneralLocalization{
	name = "Сокровищница Властелина Грома"
}

------------------------
-- Warlock Green Fire --
------------------------

L= DBM:GetModLocalization("GreenFire")

L:SetGeneralLocalization{
	name = "В погоне за Мрачной Жатвой"
}

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