if GetLocale() ~= "koKR" then return end
local L

----------------------
-- Theramore's Fall --
----------------------

L= DBM:GetModLocalization("TheramoreFall")

L:SetGeneralLocalization{
	name = "테라모어의 몰락"
}

---------------------------
-- Arena Of Annihilation --
---------------------------

L= DBM:GetModLocalization("ArenaAnnihilation")

L:SetGeneralLocalization{
	name = "파멸의 투기장"
}

--------------
-- Landfall --
--------------

L = DBM:GetModLocalization("Landfall")

local landfall
if UnitFactionGroup("player") == "Alliance" then
	landfall = "사자의 상륙지"
else
	landfall = "지배령 거점"
end

L:SetGeneralLocalization{
	name = landfall
}
