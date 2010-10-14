local mod	= DBM:NewMod("Keleseth", "DBM-Party-WotLK", 10)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(23953)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warningTomb	= mod:NewTargetAnnounce(48400, 4)
local timerTomb		= mod:NewTargetTimer(10, 48400)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(48400) then
		warningTomb:Show(args.destName)
		timerTomb:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(48400) then
		timerTomb:Cancel()
	end
end