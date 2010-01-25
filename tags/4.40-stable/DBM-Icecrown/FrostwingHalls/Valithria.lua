local mod	= DBM:NewMod("Valithria", "DBM-Icecrown", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(36789, 37868, 36791, 37863, 37886)--All the add creatureids for now drycoded from mmo database. (37950 phased bossid?)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START"
)

local warnGutSpray		= mod:NewTargetAnnounce(71283)
local timerGutSpray		= mod:NewTargetTimer(12, 71283)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(70633, 71283, 72025, 72026) then
		warnGutSpray:Show(args.destName)
		timerGutSpray:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(70633, 71283, 72025, 72026) then
		timerGutSpray:Cancel(args.destName)
	end
end