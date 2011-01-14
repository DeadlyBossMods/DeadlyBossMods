local mod	= DBM:NewMod("AlAkir", "DBM-ThroneFourWinds", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(46753)
mod:SetZone()
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_DAMAGE",
	"CHAT_MSG_MONSTER_YELL"
)

local warnWindBurst		= mod:NewSpellAnnounce(87770, 3)
--local warnSquallLine	= mod:NewSpellAnnounce(87856, 2)
local warnPhase2		= mod:NewPhaseAnnounce(2)
local warnFeedback		= mod:NewAnnounce("WarnFeedback", 2, 87904)
local warnPhase3		= mod:NewPhaseAnnounce(3)
local warnLightingRod	= mod:NewTargetAnnounce(89668, 4)

local specWarnLightningRod	= mod:NewSpecialWarningYou(89668)

local timerWindBurst		= mod:NewCastTimer(5, 87770)
local timerWindBurstCD		= mod:NewCDTimer(25, 87770)		-- 25-30 Variation
--local timerSquallLineCD		= mod:NewCDTimer(20, 87856)
local timerFeedback			= mod:NewTimer(20, "TimerFeedback", 87904)
local timerLightningRod		= mod:NewTargetTimer(5, 89668)
local timerLightningRodCD	= mod:NewNextTimer(15, 89668)

mod:AddBoolOption("LightningRodIcon")

local lastWindburst = 0
local phase2Started = false

function mod:OnCombatStart(delay)
	timerWindBurstCD:Start(20-delay)
	lastWindburst = 0
	phase2Started = false
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(87904) then
		warnFeedback:Show(args.spellName, args.destName, args.amount or 1)
		timerFeedback:Cancel()--prevent multiple timers spawning with diff args.
		timerFeedback:Start(20, args.amount or 1)
	elseif args:IsSpellID(88301, 93279, 93280, 93281) and not phase2Started then--Acid Rain (phase 2 debuff)
		phase2Started = true
		warnPhase2:Show()
		timerWindBurstCD:Cancel()
	elseif args:IsSpellID(89668) then
		warnLightingRod:Show(args.destName)
		timerLightningRod:Show(args.destName)
		timerLightningRodCD:Start()
		if args:IsPlayer() then
			specWarnLightningRod:Show()
		end
		if self.Options.LightningRodIcon then
			self:SetIcon(args.destName, 8)
		end
	end
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(89668) then
		timerLightningRod:Cancel(args.destName)
		if self.Options.LightningRodIcon then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(87770, 93261, 93262, 93263) then--Phase 1 wind burst
		warnWindBurst:Show()
		timerWindBurstCD:Start()
		if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
			timerWindBurst:Start(4)--4 second cast on heroic according to wowhead.
		else
			timerWindBurst:Start()
		end
	end
end

function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(88858, 93286, 93287, 93288) and GetTime() - lastWindburst > 5 then--Phase 3 wind burst, does not use cast success :(
		warnWindBurst:Show()
		timerWindBurstCD:Start(20)
		lastWindburst = GetTime()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.summonSquall or msg:find(L.summonSquall) then--not sure this is the yell used for it so disabled for now.
		--warnWindBurst:Show()
		--timerSquallLineCD:Start()
	elseif msg == L.phase3 or msg:find(L.phase3) then
		warnPhase3:Show()
		timerWindBurstCD:Start(25)
		timerLightningRodCD:Start(20)
		--timerSquallLineCD:Cancel()
	end
end