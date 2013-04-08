if GetLocale() ~= "frFR" then return end
local L

----------------------
-- Theramore's Fall --
----------------------

L= DBM:GetModLocalization("TheramoreFall")

L:SetGeneralLocalization{
	name = "La chute de Theramore"
}

---------------------------
-- Arena Of Annihilation --
---------------------------

L= DBM:GetModLocalization("ArenaAnnihilation")

L:SetGeneralLocalization{
	name = "Arène de l'Annihilation"
}