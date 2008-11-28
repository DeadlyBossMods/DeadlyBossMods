local mod = DBM:NewMod("Ionar", "DBM-Party-WotLK", 6)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(28546)
mod:SetZone()

mod:RegisterCombat("combat")

local warningOverload	= mod:NewAnnounce("WarningOverload", 2, 52658)
local warningSplit	= mod:NewAnnounce("WarningSplit", 3, 52770)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_SUCCES"
)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 52658 or args.spellId == 59795 then
		warningOverload:Show(args.destName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 52770 then
		warningSplit:Show()
	end
end