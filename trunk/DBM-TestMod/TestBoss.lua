local mod = DBM:NewMod("The Test Mod")

local L = mod:GetLocalizedStrings()

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

function mod:SPELL_AURA_APPLIED(args)
--	48040
end

function mod:SPELL_AURA_REMOVED(args)
	
end