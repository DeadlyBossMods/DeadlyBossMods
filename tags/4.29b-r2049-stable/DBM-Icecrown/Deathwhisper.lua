local mod = DBM:NewMod("Deathwhisper", "DBM-Icecrown")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1799 $"):sub(12, -3))
mod:SetCreatureID(36855)
--mod:SetUsedIcons(3, 4, 5, 6, 7, 8)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED"
)

local enrageTimer				= mod:NewEnrageTimer(600)

function mod:OnCombatStart(delay)
	enrageTimer:Start(-delay)
end