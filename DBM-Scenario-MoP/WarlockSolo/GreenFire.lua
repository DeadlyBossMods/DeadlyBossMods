local mod	= DBM:NewMod("GreenFire", "DBM-Scenario-MoP")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetZone(919)

mod:RegisterCombat("scenario", 919)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_DIED"
)

--Essence of Order
local warnSpellFlame			= mod:NewSpellAnnounce(134234, 3)
local warnHellfire				= mod:NewSpellAnnounce(134225, 3)
--Kanrethad Ebonlocke
local warnSummonPitLord			= mod:NewCastAnnounce(138789, 4, 10)

--Essence of Order
local specWarnSpellFlame		= mod:NewSpecialWarningMove(134234)
local specWarnHellfire			= mod:NewSpecialWarningInterrupt(134225)
local specWarnLostSouls			= mod:NewSpecialWarning("specWarnLostSouls", nil, nil, nil, 2)
--Kanrethad Ebonlocke
local specWarnEnslavePitLord	= mod:NewSpecialWarning("specWarnEnslavePitLord")

--Essence of Order
--Todo, maybe register COMBAT_REGEN_DISABLED and check warlocks target (basically what dbm core normally does) for combat start timers?
local timerSpellFlameCD			= mod:NewNextTimer(11, 134234)--(6 seconds after engage)
local timerHellfireCD			= mod:NewNextTimer(33, 134225)--(15 after engage)
local timerLostSoulsCD			= mod:NewTimer(43, "timerLostSoulsCD", 51788)--43-50 second variation. (engage is same as cd, 43)
--Kanrethad Ebonlocke
local timerPitLordCast			= mod:NewCastTimer(10, 138789)
local timerEnslaveDemon			= mod:NewTargetTimer(300, 1098)

mod:RemoveOption("HealthFrame")

local kanrathadAlive = true--So we don't warn to enslave pit lord when he dies and enslave fades.

function mod:SPELL_CAST_START(args)
	if args.spellId == 134234 then
		warnSpellFlame:Show()
		specWarnSpellFlame:Show()
		timerSpellFlameCD:Start()
	elseif args.spellId == 134225 then
		warnHellfire:Show()
		specWarnHellfire:Show(args.sourceName)
		timerHellfireCD:Start()
	end
end

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

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.LostSouls then
		specWarnLostSouls:Show()
		timerLostSoulsCD:Start()
	end
end

function mod:UNIT_DIED(args)
	--TODO, verify this. Do bosses reset on player death if warlock uses soulstone and pops right away?
	if args.destGUID == UnitGUID("player") then--Solo scenario, a player death is a wipe
		timerSpellFlameCD:Cancel()
		timerHellfireCD:Cancel()
		timerLostSoulsCD:Cancel()
		timerEnslaveDemon:Cancel()
	end
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 68151 then--Essence of Order
		timerSpellFlameCD:Cancel()
		timerHellfireCD:Cancel()
		timerLostSoulsCD:Cancel()
	elseif cid == 69964 then--Kanrethad Ebonlocke
		timerEnslaveDemon:Cancel()
		kanrathadAlive = false
	end
end
