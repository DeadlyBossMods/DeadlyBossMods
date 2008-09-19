local mod = DBM:NewMod("Malygos", "DBM-EyeOfEternity")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(28859)
mod:SetZone()

mod:SetModelScale(0.25)

mod:RegisterCombat("yell", L.Yell1, L.Yell2)

mod:RegisterEvents(
)

function mod:OnCombatStart(delay)
end
