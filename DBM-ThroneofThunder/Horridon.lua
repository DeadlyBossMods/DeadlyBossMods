if select(4, GetBuildInfo()) < 50200 then return end--Don't load on live
local mod	= DBM:NewMod(819, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(68476)
--mod:SetModelID(42811)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

local warnCharge				= mod:NewTargetAnnounce(136769, 4)
local warnPuncture				= mod:NewStackAnnounce(136767, 3, nil, mod:IsTank() or mod:IsHealer())

local specWarnCharge			= mod:NewSpecialWarningYou(136769)--Maybe add a near warning later. person does have 3.4 seconds to react though and just move out of group.
local yellCharge				= mod:NewYell(136769)
local specWarnPuncture			= mod:NewSpecialWarningStack(136767, mod:IsTank(), 10)--10 seems like a good number, we'll start with that. Timing wise the swap typically comes when switching gates though.
local specWarnPunctureOther		= mod:NewSpecialWarningTarget(136767, mod:IsTank())

local timerAddsCD				= mod:NewTimer(114, "timerAddsCD")--They seem to be timed off last door start, not last door end. They MAY come earlier if you kill off all first doors adds though not sure yet. If they do, we'll just start new timer anyways
local timerCharge				= mod:NewCastTimer(3.4, 136769)
local timerChargeCD				= mod:NewCDTimer(50, 136769)--50-60 second depending on i he's casting other stuff or stunned
local timerPuncture				= mod:NewTargetTimer(90, 136767, nil, mod:IsTank() or mod:IsHealer())

function mod:OnCombatStart(delay)
	timerAddsCD:Start(17-delay)
	timerChargeCD:Start(31-delay)--31-35sec variation
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(136767) then
		warnPuncture:Show(args.destName, args.amount or 1)
		timerPuncture:Start(args.destName)
		if args:IsPlayer() then
			if (args.amount or 1) >= 10 then
				specWarnPuncture:Show(args.amount)
			end
		else
			if (args.amount or 1) >= 10 and not UnitDebuff("player", GetSpellInfo(136767)) and not UnitIsDeadOrGhost("player") then--Other tank has at least one stack and you have none
				specWarnPunctureOther:Show(args.destName)--So nudge you to taunt it off other tank already.
			end
		end
	--"<317.2 15:12:36> [CLEU] SPELL_AURA_APPLIED_DOSE#false#0xF1310B7C0000383C#Horridon#68168#0#0xF1310B7C0000383C#Horridon#68168#0#137240#Cracked Shell#1#BUFF#4", -- [21950]
	--"<327.0 15:12:46> [INSTANCE_ENCOUNTER_ENGAGE_UNIT] Fake Args:#1#1#Horridon#0xF1310B7C0000383C#elite#261178058#1#1#War-God Jalak <--War-God Jalak jumps down
	--Technically, he also jumps down if you burn dog to 30% before dealing with gates. A zerg strat seems like a very bad idea though so i'm not sure I'm gonna add code for that yet. Might want to log such a strat first
	elseif args:IsSpellID(137240) and (args.amount or 1) == 4 then--Phase 2
		
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(136767) then
		timerPuncture:Cancel(args.destName)
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:find(L.chargeTarget) then--Does not show in combat log except for after it hits. IT does fire a UNIT_SPELLCAST event but has no target info. You can get target 1 sec faster with UNIT_AURA but it's more cpu and not worth the trivial gain IMO
		warnCharge:Show(target)
		timerCharge:Start()
		timerChargeCD:Start()
		if target == UnitName("player") then
			specWarnCharge:Show()
			yellCharge:Yell()
		end
	elseif msg:find(L.newForces) then
		timerAddsCD:Start()
	end
end
