local mod	= DBM:NewMod(1497, "DBM-Party-Legion", 6, 726)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(98203)
mod:SetEncounterID(1827)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 196562 196805",
	"SPELL_AURA_REMOVED 196562",
	"SPELL_CAST_START 196549",
	"SPELL_CAST_SUCCESS 196562 196804 196877 196392",
	"SPELL_PERIODIC_DAMAGE 196824",
	"SPELL_PERIODIC_MISSED 196824"
)

--TODO, verify some of this is actually timer based and not just mana depletion related.
--TODO, verify first special timers some more
local warnVolatileMagic				= mod:NewTargetAnnounce(196562, 3)
local warnNetherLink				= mod:NewTargetAnnounce(196805, 4)
local warnPhase2					= mod:NewPhaseAnnounce(2, 2)
local warnConsumeEssence			= mod:NewSpellAnnounce(196877, 3)

local specWarnVolatileMagic			= mod:NewSpecialWarningMoveAway(196562, nil, nil, nil, 1, 2)
local yellVolatileMagic				= mod:NewYell(196562)
local specWarnNetherLink			= mod:NewSpecialWarningYou(196805, nil, nil, nil, 1, 2)
local specWarnNetherLinkGTFO		= mod:NewSpecialWarningMove(196805, nil, nil, nil, 1, 2)
local specWarnOverchargeMana		= mod:NewSpecialWarningInterrupt(196392, "HasInterrupt", nil, nil, 1, 2)

local timerVolatileMagicCD			= mod:NewCDTimer(22, 196562, nil, nil, nil, 3)--Review, might be 27 now
local timerNetherLinkCD				= mod:NewCDTimer(20.5, 196804, nil, nil, nil, 3)--Review. might be 37 now? Or maybe health based?
local timerOverchargeManaCD			= mod:NewCDTimer(21.5, 196392, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
local timerConsumeEssenceCD			= mod:NewNextTimer(18.2, 196877, nil, nil, nil, 2)

local voiceVolatileMagic			= mod:NewVoice(196562)--runout
local voiceNetherLink				= mod:NewVoice(196805)--targetyou/runaway
local voiceOverchargeMana			= mod:NewVoice(196392, "HasInterrupt")--kickcast
local voicePhaseChange				= mod:NewVoice(nil, nil, DBM_CORE_AUTO_VOICE2_OPTION_TEXT)

mod:AddRangeFrameOption(15, 196562)

function mod:OnCombatStart(delay)
	--Watch closely, review. He may be able to swap nether link and volatile magic?
	timerVolatileMagicCD:Start(9.5-delay)
	timerNetherLinkCD:Start(11.7-delay)--Check, always 18.9 now (applied)
	timerOverchargeManaCD:Start(18.4-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 196562 then
		warnVolatileMagic:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnVolatileMagic:Show()
			voiceVolatileMagic:Play("runout")
			yellVolatileMagic:Yell()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(15)
			end
		end
	elseif spellId == 196805 then
		warnNetherLink:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnNetherLink:Show()
			voiceNetherLink:Play("targetyou")
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 196562 and args:IsPlayer() and self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 196549 then--Withering Consumption
		warnPhase2:Show()
		voicePhaseChange:Play("ptwo")
		timerVolatileMagicCD:Stop()
		timerNetherLinkCD:Stop()
		timerOverchargeManaCD:Stop()
		timerConsumeEssenceCD:Start(10.5)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 196562 then
		timerVolatileMagicCD:Start()
	elseif spellId == 196804 then
		timerNetherLinkCD:Start()
	elseif spellId == 196877 then
		warnConsumeEssence:Show()
		timerConsumeEssenceCD:Start()
	elseif spellId == 196392 then
		specWarnOverchargeMana:Show(args.sourceName)
		voiceOverchargeMana:Play("kickcast")
		timerOverchargeManaCD:Start()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 196824 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnNetherLinkGTFO:Show()
		voiceNetherLink:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
