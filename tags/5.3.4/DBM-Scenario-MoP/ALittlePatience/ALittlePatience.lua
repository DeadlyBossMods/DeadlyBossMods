local mod	= DBM:NewMod("d589", "DBM-Scenario-MoP")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetZone()

mod:RegisterCombat("scenario", 1104)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"UNIT_DIED"
)

--Todo, Add some more resource gathering warnings/timers? Unfortunately none of those events got recorded by transcriptor. it appears they are all UNIT_AURA only :\
--Commander Scargash
local warnBloodRage			= mod:NewTargetAnnounce(134974, 3)--15 second target fixate

--Commander Scargash
local specWarnBloodrage		= mod:NewSpecialWarningRun(134974)

--Commander Scargash
local timerBloodRage		= mod:NewTargetTimer(15, 134974)

local soundBloodRage		= mod:NewSound(134974)

mod:RemoveOption("HealthFrame")

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 134974 then
		warnBloodRage:Show(args.destName)
		timerBloodRage:Start(args.destName)
		if args:IsPlayer() then
			specWarnBloodrage:Show()
			soundBloodRage:Play()
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 134974 then
		timerBloodRage:Cancel(args.destname)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 68474 then--Commander Scargash

	end
end
