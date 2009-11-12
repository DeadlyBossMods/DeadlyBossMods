local mod	= DBM:NewMod("Skarloc", "DBM-Party-BC", 11)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1 $"):sub(12, -3))
mod:SetCreatureID(17862)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_PERIODIC_DAMAGE"
)

local warnHeal                  = mod:NewSpellAnnounce(29427)
local warnHammer                = mod:NewTargetAnnounce(13005)
local timerHammer               = mod:NewTargetTimer(6, 13005)
local specWarnConsecration      = mod:NewSpecialWarning("specWarnConsecration")

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(29427) then
		warnHeal:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(13005) then
		warnHammer:Show(args.destName)
		timerHammer:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(13005) then
		timerHammer:Cancel(args.destName)
	end
end

do 
	local lastConsecration = 0
	function mod:SPELL_PERIODIC_DAMAGE(args)
		if args:IsSpellID(38385) and args:IsPlayer() and time() - lastConsecration > 2 then
			specWarnConsecration:Show()
			lastConsecration = time()
		end
	end
end