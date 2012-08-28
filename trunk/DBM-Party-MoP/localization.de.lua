if GetLocale() ~= "deDE" then return end
local L

--------------------
--  World Bosses  --
--------------------
-- Anger --
-----------
L = DBM:GetModLocalization("Anger")

L:SetGeneralLocalization{
	name = "Anger"
}

----------
-- Fear --
----------
L = DBM:GetModLocalization("Fear")

L:SetGeneralLocalization{
	name = "Fear"
}

