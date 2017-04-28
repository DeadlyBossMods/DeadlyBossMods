local mod	= DBM:NewMod(1501, "DBM-Party-Legion", 6, 726)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(98208)
mod:SetEncounterID(1829)
mod:SetZone()

mod.noNormal = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 203957 220871",
	"SPELL_AURA_APPLIED_DOSE 203176",
	"SPELL_CAST_START 202974 203882 203176",
	"SPELL_DAMAGE 203833",
	"SPELL_MISSED 203833",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, it might be time to build an interrupt table ("hasInterrupt") for better option defaults for spammy interrupt warnings.
--Force bomb might be more consistent now, need more logs, last log was 35
local warnTimeLock					= mod:NewTargetAnnounce(203957, 4)
local warnUnstableMana				= mod:NewTargetAnnounce(203176, 2)

local specWarnTimeSplit				= mod:NewSpecialWarningMove(203833, nil, nil, nil, 1, 2)
local specWarnForceBomb				= mod:NewSpecialWarningSpell(202974, nil, nil, nil, 2, 2)
local specWarnBlast					= mod:NewSpecialWarningInterruptCount(203176, "HasInterrupt", nil, 2, 1, 2)
local specWarnBlastStacks			= mod:NewSpecialWarningDispel(203176, "MagicDispeller")
local specWarnTimeLock				= mod:NewSpecialWarningInterrupt(203957, "HasInterrupt", nil, 2, 1, 2)
local specWarnUnstableMana			= mod:NewSpecialWarningMove(203176, nil, nil, nil, 1, 2)

local timerForceBombD				= mod:NewCDTimer(31.8, 202974, nil, nil, nil, 2)
local timerEvent					= mod:NewBuffFadesTimer(124, 203914, nil, nil, nil, 6)

local voicetimeSplit				= mod:NewVoice(203833)--runaway
local voiceForceBomb				= mod:NewVoice(202974)--157349 (force nova)
local voiceBlast					= mod:NewVoice(203176, "HasInterrupt", nil, 2)--kickNr/dispelboss
local voicetimeLock					= mod:NewVoice(203957, "HasInterrupt", nil, 2)--kickcast
local voiceUnstableMana				= mod:NewVoice(203176)--runout/keepmove

local countdownEvent				= mod:NewCountdownFades(124, 203914, nil, nil, 10)

mod.vb.interruptCount = 0

function mod:OnCombatStart(delay)
	self.vb.interruptCount = 0
	timerForceBombD:Start(16.7-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 203957 then
		--if people run different directions 2-3 of these can activate at once.
		--So combined show and anti spam measures used.
		warnTimeLock:CombinedShow(0.5, args.destName)
		if self:AntiSpam(3, 2) then
			specWarnTimeLock:Show(args.sourceName)
			voicetimeLock:Play("kickcast")
		end
	elseif spellId == 220871 then
		if args:IsPlayer() then
			specWarnUnstableMana:Show()
			voiceUnstableMana:Play("runout")
			voiceUnstableMana:Schedule(1, "keepmove")
		else
			warnUnstableMana:Show(args.destName)
		end
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	local spellId = args.spellId
	if spellId == 203176 then
		if args.amount >= 5 then
			specWarnBlastStacks:Show(args.destName)
			voiceBlast:Play("dispelboss")
		end
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 202974 then
		specWarnForceBomb:Show()
		voiceForceBomb:Play("157349")
		timerForceBombD:Start()
	elseif spellId == 203882 then
		timerForceBombD:Cancel()
		timerEvent:Start()
		countdownEvent:Start()
	elseif spellId == 203176 then
		if self.vb.interruptCount == 3 then self.vb.interruptCount = 0 end
		self.vb.interruptCount = self.vb.interruptCount + 1
		local kickCount = self.vb.interruptCount
		specWarnBlast:Show(args.sourceName, kickCount)
		--Takes 3 to block all casts, it only takes 2 in a row to break his stacks though.
		--3 count still makes sense for 2 though because you know which cast to skip to maintain order. Kick 1-2, skip 3, easy
		--A group with only one interruptor won't be able to prevent his stacks and need to use dispels on boss instead
		if kickCount == 1 then
			voiceBlast:Play("kick1r")
		elseif kickCount == 2 then
			voiceBlast:Play("kick2r")
		elseif kickCount == 3 then
			voiceBlast:Play("kick3r")
		end
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 203833 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnTimeSplit:Show()
		voicetimeSplit:Play("runaway")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 147995 then--Interrupt Channeling
		self.vb.interruptCount = 0
		timerEvent:Cancel()
		countdownEvent:Cancel()
		timerForceBombD:Start(20)--20-23
	end
end
