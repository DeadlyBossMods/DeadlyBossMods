local mod	= DBM:NewMod("GreenFire", "DBM-Scenario-MoP")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetZone(919)

mod:RegisterCombat("scenario", 919)

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"UNIT_DIED"
)

--Kanrethad Ebonlocke
local warnSummonPitLord			= mod:NewCastAnnounce(138789, 4, 10)

local specWarnEnslavePitLord	= mod:NewSpecialWarning("specWarnEnslavePitLord")

local timerPitLordCast			= mod:NewCastTimer(10, 138789)
local timerEnslaveDemon			= mod:NewTargetTimer(300, 1098)

mod:RemoveOption("HealthFrame")

local kanrathadAlive = true

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 138789 then
		kanrathadAlive = true--Reset this here
		warnSummonPitLord:Show()
		timerPitLordCast:Start()
		specWarnEnslavePitLord:Schedule(10)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 1098 and args:GetDestCreatureID() == 70075 then
		timerEnslaveDemon:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 1098 and args:GetDestCreatureID() == 70075 and kanrathadAlive then
		timerEnslaveDemon:Cancel(args.destName)
		specWarnEnslavePitLord:Show()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 69964 then--Kanrethad Ebonlocke
		timerEnslaveDemon:Cancel()
		kanrathadAlive = false
	end
end
