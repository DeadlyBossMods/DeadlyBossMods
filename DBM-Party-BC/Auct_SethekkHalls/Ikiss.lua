local mod = DBM:NewMod("Ikiss", "DBM-Party-BC", 9)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7 $"):sub(12, -3))

mod:SetCreatureID(18473)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED"
)

local warnArcaneExplosion   = mod:NewCastAnnounce(38197)
local warnSheep             = mod:NewTargetAnnounce(12826)

function mod:SPELL_CAST_START(args)
	if args.spellId == 38197 or args.spellId == 40425 then
		warnArcaneExplosion:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 12826 then
		warnSheep:Show(args.destName)
	end
end