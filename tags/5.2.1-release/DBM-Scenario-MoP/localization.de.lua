if GetLocale() ~= "deDE" then return end
local L

----------------------
-- Theramore's Fall --
----------------------

L= DBM:GetModLocalization("TheramoreFall")

L:SetGeneralLocalization{
	name = "Theramores Sturz"
}

L:SetMiscLocalization{
--	AllianceVictory = "All of you have my deepest thanks. With the Focusing Iris removed, this lifeless bomb is merely a sickening testament to Garrosh's brutality. The winds of change blow fiercely; Azeroth is on the brink of war. My apologies, but you must excuse me... I have much to consider. Farewell.", --translate (trigger)
--	HordeVictory	= "Danke! Sollen wir von dieser elenden kleinen Insel verschwinden?"
}

---------------------------
-- Arena Of Annihilation --
---------------------------

L= DBM:GetModLocalization("ArenaAnnihilation")

L:SetGeneralLocalization{
	name = "Arena der Auslöschung"
}

--------------
-- Landfall --
--------------

L = DBM:GetModLocalization("Landfall")

local landfall
if UnitFactionGroup("player") == "Alliance" then
	landfall = "Löwenlandung"
else
	landfall = "Herrschaftsfeste"
end

L:SetGeneralLocalization({
	name = landfall
})

L:SetWarningLocalization({
	WarnAchFiveAlive	= "Erfolg \"Nummer 5 lebt!\" fehlgeschlagen!"
})

L:SetOptionLocalization({
	WarnAchFiveAlive	= "Zeige Warnung bei Fehlschlag des Erfolgs \"Nummer 5 lebt!\""
})
