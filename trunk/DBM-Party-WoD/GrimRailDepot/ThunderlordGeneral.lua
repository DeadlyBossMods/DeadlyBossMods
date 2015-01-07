local mod	= DBM:NewMod(1133, "DBM-Party-WoD", 3, 536)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(80005)
mod:SetEncounterID(1736)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 163447 161588",
	"SPELL_AURA_APPLIED_DOSE 161588",
	"SPELL_AURA_REMOVED 163447",
	"SPELL_CAST_START 162066 162058"
)

local warnFreezingSnare			= mod:NewTargetAnnounce(162066, 3)
local warnSpinningSpear			= mod:NewSpellAnnounce(162058, 3)
local warnMark					= mod:NewTargetAnnounce(163447, 3)

local specWarnFreezingSnare		= mod:NewSpecialWarningYou(162066)
local specWarnFreezingSnareNear	= mod:NewSpecialWarningClose(162066)
local yellFreezingSnare			= mod:NewYell(162066)
local specWarnDiffusedEnergy	= mod:NewSpecialWarningMove(161588)
local specWarnSpinningSpear		= mod:NewSpecialWarningMove("OptionVersion2", 162058, mod:IsTank())
local specWarnMark				= mod:NewSpecialWarningMoveAway(163447)
local yellMark					= mod:NewYell(163447)

local timerFreezingSnareCD		= mod:NewNextTimer(20, 162066)
local timerSpinningSpearCD		= mod:NewNextTimer(20, 162058)
local timerMark					= mod:NewTargetTimer(5, 163447)
local timerMarkCD				= mod:NewNextTimer(20, 163447)

local voiceFreezingSnare		= mod:NewVoice(162066)
local voiceMark					= mod:NewVoice(163447)
local voiceDiffusedEnergy		= mod:NewVoice(161588)

mod:AddRangeFrameOption(8, 163447)

local debuffCheck = GetSpellInfo(163447)
local UnitDebuff = UnitDebuff
local debuffFilter
do
	debuffFilter = function(uId)
		return UnitDebuff(uId, debuffCheck)
	end
end

function mod:FreezingSnareTarget(targetname, uId)
	if not targetname then return end
	warnFreezingSnare:Show(targetname)
	if targetname == UnitName("player") then
		specWarnFreezingSnare:Show()
		yellFreezingSnare:Yell()
		voiceFreezingSnare:Play("runaway")
	elseif self:CheckNearby(8, targetname) then
		specWarnFreezingSnareNear:Show(targetname)
	end
end
  
function mod:OnCombatStart(delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 163447 then
		warnMark:Show(args.destName)
		timerMark:Start(args.destName)
		timerMarkCD:Start()
		if args:IsPlayer() then
			specWarnMark:Show()
			yellMark:Yell()
			voiceMark:Play("runout")
		end
		if self.Options.RangeFrame then
			if UnitDebuff("player", debuffCheck) then--You have debuff, show everyone
				DBM.RangeCheck:Show(8, nil)
			else--You do not have debuff, only show players who do
				DBM.RangeCheck:Show(8, debuffFilter)
			end
		end
	elseif args.spellId == 161588 and args:IsPlayer() and self:AntiSpam() then
		specWarnDiffusedEnergy:Show()
		voiceDiffusedEnergy:Play("runaway")
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 163447 then
		timerMark:Cancel(args.destName)
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 162066 then
		self:BossTargetScanner(80005, "FreezingSnareTarget", 0.04, 15)
		timerFreezingSnareCD:Start()
	elseif spellId == 162058 then
		warnSpinningSpear:Show()
		specWarnSpinningSpear:Show()
		timerSpinningSpearCD:Start()
	end
end
