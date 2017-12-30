local mod	= DBM:NewMod(1826, "DBM-Party-Legion", 11, 860)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(114261, 114260, 999999)--Remove 9s if phase 1 and 2 don't fire UNIT_DIED events
mod:SetEncounterID(1957)--Shared (so not used for encounter START since it'd fire 3 mods)
mod:DisableESCombatDetection()--However, with ES disabled, EncounterID can be used for BOSS_KILL/ENCOUNTER_END
mod:SetZone()
--mod:SetUsedIcons(1)
--mod:SetHotfixNoticeRev(14922)
mod:SetBossHPInfoToHighest()
--mod.respawnTime = 30

mod.noNormal = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 227568 227420 227783",
	"SPELL_CAST_SUCCESS 227777",
	"SPELL_AURA_APPLIED 227777",
	"SPELL_AURA_REMOVED 227777"
)

--TODO: phase detection
--TODO: Timers
--Stage One: Defias Brotherhood
local specWarnLegSweep				= mod:NewSpecialWarningRun(227568, "Melee", nil, nil, 4, 2)
--Stage Two: The Fins
local specWarnThunderRitual			= mod:NewSpecialWarningMoveAway(227777, nil, nil, nil, 1, 2)
local yellThunderRitual				= mod:NewYell(227777)
local specWarnBubbleBlast			= mod:NewSpecialWarningInterrupt(227420, "HasInterrupt", nil, nil, 1, 2)
local specWarnWashAway				= mod:NewSpecialWarningDodge(227783, nil, nil, nil, 1, 2)

--Stage One: Defias Brotherhood
local timerLegSweepCD				= mod:NewAITimer(40, 227568, nil, "Melee", nil, 2)
--Stage Two: The Fins
local timerThunderRitualCD			= mod:NewAITimer(40, 227777, nil, nil, nil, 3)
local timerWashAwayCD				= mod:NewAITimer(40, 227783, nil, nil, nil, 3)

--local berserkTimer				= mod:NewBerserkTimer(300)

--local countdownFocusedGazeCD		= mod:NewCountdown(40, 198006)

--mod:AddSetIconOption("SetIconOnCharge", 198006, true)
--mod:AddInfoFrameOption(198108, false)
mod:AddRangeFrameOption(5, 227777)

mod.vb.phase = 1

function mod:OnCombatStart(delay)
	self.vb.phase = 1
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 227568 then
		specWarnLegSweep:Show()
		specWarnLegSweep:Play("runout")
	elseif spellId == 227420 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnBubbleBlast:Show(args.sourceName)
		specWarnBubbleBlast:Play("kickcast")
	elseif spellId == 227783 then
		specWarnWashAway:Show()
		specWarnWashAway:Play("watchwave")
		timerWashAwayCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 227777 then
		timerThunderRitualCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 227777 then
		if args:IsPlayer() then
			specWarnThunderRitual:Show()
			specWarnThunderRitual:Play("range5")
			yellThunderRitual:Yell()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(5)
			end
		end
	end
end
