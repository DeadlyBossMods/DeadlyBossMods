if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

----------------------
-- Theramore's Fall --
----------------------

L= DBM:GetModLocalization("TheramoreFall")

L:SetGeneralLocalization{
	name = "Caída de Theramore"
}

L:SetMiscLocalization{
	--AllianceVictory = "All of you have my deepest thanks. With the Focusing Iris removed, this lifeless bomb is merely a sickening testament to Garrosh's brutality. The winds of change blow fiercely; Azeroth is on the brink of war. My apologies, but you must excuse me... I have much to consider. Farewell.",--translate
	--HordeVictory	= "My thanks! Shall we make our way off this miserable little island?"--translate
}

---------------------------
-- Arena Of Annihilation --
---------------------------

L= DBM:GetModLocalization("ArenaAnnihilation")

L:SetGeneralLocalization{
	name = "Arena de la Aniquilación"
}