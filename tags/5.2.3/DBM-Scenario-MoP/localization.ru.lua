if GetLocale() ~= "ruRU" then return end
local L
----------------------
-- Theramore's Fall --
----------------------

L= DBM:GetModLocalization("TheramoreFall")

L:SetGeneralLocalization{
	name = "Падение Терамора"
}

---------------------------
-- Arena Of Annihilation --
---------------------------

L= DBM:GetModLocalization("ArenaAnnihilation")

L:SetGeneralLocalization{
	name = "Арена испытаний"
}