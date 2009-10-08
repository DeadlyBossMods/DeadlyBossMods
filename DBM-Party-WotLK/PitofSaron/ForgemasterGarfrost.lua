local mod = DBM:NewMod("ForgemasterGarfrost", "DBM-Party-WotLK", 15)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1665 $"):sub(12, -3))
mod:SetCreatureID(36352)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CREATE",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE"
)

local warnSaroniteRock				= mod:NewAnnounce("warnSaroniteRock")
local specWarnPermafrost	= mod:NewSpecialWarning("specWarnPermafrost", false)

function mod:SPELL_CREATE(args)
	if args:IsSpellID(68789) then							-- Saronite Rock
		warnSaroniteRock:Show(args.spellName)
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if (args.spellId == 68786) and args.destName == UnitName("player") then
		if args.amount >= 20 then --Unsure of a good amount, this is currently undertuned on ptr and right now. This value is not 
			specWarnPermafrost:Show(args.spellName, args.amount)
		end
	end
end