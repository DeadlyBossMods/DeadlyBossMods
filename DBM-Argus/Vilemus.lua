local mod	= DBM:NewMod(2015, "DBM-Argus", nil, 959)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(124719)
--mod:SetEncounterID(1952)--Does not have one
--mod:SetReCombatTime(20)
mod:SetZone()
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat_yell", L.Pull)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 247731 247733",
	"SPELL_CAST_SUCCESS 247739",
	"SPELL_AURA_APPLIED 247742",
	"SPELL_AURA_APPLIED_DOSE 247742"
)

local warnDrain					= mod:NewStackAnnounce(247742, 2, nil, "Tank")
local warnFelBreath				= mod:NewSpellAnnounce(247731, 2)

local specWarnDrain				= mod:NewSpecialWarningStack(247742, nil, 6, nil, nil, 1, 2)--Tanking
local specWarnDrainTaunt		= mod:NewSpecialWarningTaunt(247742, nil, nil, nil, 1, 2)--Not tanking and clear
local specWarnStomp				= mod:NewSpecialWarningSpell(247733, nil, nil, nil, 2, 2)
--local specWarnGTFO			= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)

local timerDrainCD				= mod:NewCDTimer(15.9, 247739, nil, "Melee", nil, 5, nil, DBM_CORE_TANK_ICON)--15-20
local timerFelBreathCD			= mod:NewCDTimer(13.4, 247731, nil, nil, nil, 3)
local timerStompCD				= mod:NewCDTimer(15.8, 247733, nil, nil, nil, 2, nil, DBM_CORE_HEALER_ICON)--15-35?

local voiceDrain				= mod:NewVoice(247361)--tauntboss/runout/stackhigh
local voiceStomp				= mod:NewVoice(247733)--carefly
--local voiceGTFO				= mod:NewVoice(238028, nil, DBM_CORE_AUTO_VOICE4_OPTION_TEXT)--runaway

mod:AddReadyCheckOption(49196, false)
mod:AddRangeFrameOption(8, 247739)--Mainly to ensure tanks are far enough from eachother. any dumb melee don't matter.

local tankFilter
do
	tankFilter = function(uId)
		if mod:IsTanking(uId) then
			return true
		end
	end
end

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then

	end
	if self.Options.RangeFrame and self:IsTank() then
		DBM.RangeCheck:Show(8, tankFilter)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 247731 then
		warnFelBreath:Show()
		timerFelBreathCD:Start()
	elseif spellId == 247733 then
		specWarnStomp:Show()
		voiceStomp:Play("carefly")
		timerStompCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 247739 then
		timerDrainCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 247742 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 6 then--Fine Tune
				if args:IsPlayer() then--At this point the other tank SHOULD be clear.
					specWarnDrain:Show(amount)
					voiceDrain:Play("stackhigh")
				else--Taunt as soon as stacks are clear, regardless of stack count.
					if not UnitIsDeadOrGhost("player") and not UnitDebuff("player", args.spellName) and self:AntiSpam(5, 1) then
						specWarnDrainTaunt:Show(args.destName)
						voiceDrain:Play("tauntboss")
					else
						warnDrain:Cancel()
						warnDrain:Schedule(1.25, args.destName, amount)
					end
				end
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
