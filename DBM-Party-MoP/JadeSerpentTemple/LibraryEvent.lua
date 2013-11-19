local mod	= DBM:NewMod(664, "DBM-Party-MoP", 1, 313)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(59051, 59726, 58826)--59051 (Strife), 59726 (Anger), 58826 (Zao Sunseeker). This event has a random chance to be Zao (solo) or Anger and Strife (together)
mod:SetEncounterID(1417)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"UNIT_DIED"
)

--Stuff that might be used with more data--
--4/6 12:57:22.825  UNIT_DISSIPATES,0x0000000000000000,nil,0x80000000,0x80000000,0xF130DEF800005B63,"Corrupted Scroll",0xa48,0x0
-------------------------------------------
local warnIntensity			= mod:NewStackAnnounce(113315, 3)
local warnUltimatePower		= mod:NewTargetAnnounce(113309, 4)

local specWarnIntensity		= mod:NewSpecialWarning("SpecWarnIntensity")
local specWarnUltimatePower	= mod:NewSpecialWarningTarget(113309, nil, nil, nil, true)

local timerUltimatePower	= mod:NewTargetTimer(15, 113309)

local bossesDead = 0

function mod:OnCombatStart(delay)
	bossesDead = 0
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 113315 then
		warnIntensity:Show(args.destName, args.amount or 1)
	elseif args.spellId == 113309 then
		warnUltimatePower:Show(args.destName)
		specWarnUltimatePower:Show(args.destName)
		timerUltimatePower:Start(args.destName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 122714 then
		DBM:EndCombat(self)--Alternte win detection, UNIT_DIED not fire for 59051 (Strife), 59726 (Anger)
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args.spellId == 113315 then
		if args.amount % 2 == 0 then--only warn every 2
			warnIntensity:Show(args.destName, args.amount)
			if args.amount >= 6 then--Start point of special warnings subject to adjustment based on live tuning.
				specWarnIntensity:Show(args.spellName, args.destName, args.amount)
			end
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 59051 then--These 2 both have to die for fight to end
		bossesDead = bossesDead + 1
		if bossesDead == 2 then
			DBM:EndCombat(self)
		end
	elseif cid == 59726 then--These 2 both have to die for fight to end
		bossesDead = bossesDead + 1
		if bossesDead == 2 then
			DBM:EndCombat(self)
		end
	elseif cid == 58826 then--This one is by himself so we don't need special rules
		DBM:EndCombat(self)
	end
end
