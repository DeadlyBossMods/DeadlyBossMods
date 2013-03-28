if GetLocale() ~= "deDE" then return end
local L

----------------------
-- Theramore's Fall --
----------------------

L= DBM:GetModLocalization("TheramoreFall")

L:SetGeneralLocalization{
	name = "Theramores Sturz"
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
