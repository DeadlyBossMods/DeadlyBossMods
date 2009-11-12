local mod = DBM:NewMod("Soccothrates", "DBM-Party-BC", 15)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1 $"):sub(12, -3))

mod:SetCreatureID(20886)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS"
)

local warnKnockaway      = mod:NewSpellAnnounce(36512)

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(36512) then
		warnKnockaway:Show()
	end
end