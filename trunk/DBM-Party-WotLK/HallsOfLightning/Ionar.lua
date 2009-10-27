local mod = DBM:NewMod("Ionar", "DBM-Party-WotLK", 6)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(28546)
mod:SetZone()

mod:RegisterCombat("combat")

local warningOverload	= mod:NewTargetAnnounce(52658, 2)
local warningSplit	= mod:NewSpellAnnounce(52770, 3)
local timerOverload	= mod:NewTargetTimer(10, 52657)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START"
)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 52657 or args.spellId == 59795 then
		warningOverload:Show(args.spellName, args.destName)
		timerOverload:Start(args.spellName, args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 52770 then
		warningSplit:Show(args.spellName)
	end
end