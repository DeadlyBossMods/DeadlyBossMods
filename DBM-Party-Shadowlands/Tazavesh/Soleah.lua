local mod	= DBM:NewMod(2455, "DBM-Party-Shadowlands", 9, 1194)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(180863)
mod:SetEncounterID(2442)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 350796 355922 353635 351119 350875 351096 351646",
	"SPELL_CAST_SUCCESS 181089 351124",
	"SPELL_AURA_APPLIED 357190 350804 351086"
	"SPELL_AURA_APPLIED_DOSE 350804",
	"SPELL_AURA_REMOVED 350804 351086"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, figure out right P1 hyperlight id
--TODO, verify the kind of mechanics that nova and fragmentation are
--Stage One: Final Preparations
mod:AddTimerLine(DBM:EJ_GetSectionInfo(23344))
local warnCollapsingStar			= mod:NewCountAnnounce(353635, 3)
local warnCollapsingEnergy			= mod:NewStackAnnounce(353635, 2)
local warnCollapsingEnergyOver		= mod:NewFadesAnnounce(353635, 1)

local specWarnHyperlightSpark		= mod:NewSpecialWarningCount(350796, nil, nil, nil, 2, 2)
local specWarnSummonAssassins		= mod:NewSpecialWarningSwitch(351124, "Dps", nil, nil, 1, 2)
local specWarnShurikenBlitz			= mod:NewSpecialWarningInterruptCount(351119, "HasInterrupt", nil, nil, 1, 2)

local timerHyperlightSparkCD		= mod:NewAITimer(11, 350796, nil, nil, nil, 3)
local timerCollapsingStarCD			= mod:NewAITimer(11, 353635, nil, nil, nil, 5)
local timerSummonAssassinsCD		= mod:NewAITimer(15.8, 351124, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)

mod:AddInfoFrameOption(357190, true)
--Stage Two: Power Overwhelming
mod:AddTimerLine(DBM:EJ_GetSectionInfo(23340))
local warnPhase2					= mod:NewPhaseAnnounce(2, 2, nil, nil, nil, nil, nil, 2)
local warnPowerOverwhelming			= mod:NewSpellAnnounce(351086, 3)
local warnPowerOverwhelmingEnded	= mod:NewEndAnnounce(351086, 1)

local specWarnHyperlightJolt		= mod:NewSpecialWarningCount(350875, nil, nil, nil, 2, 2)
local specWarnEnergyFragmentation	= mod:NewSpecialWarningDodge(351096, nil, nil, nil, 2, 2)
local specWarnHyperlightNova		= mod:NewSpecialWarningDodge(351646, nil, nil, nil, 2, 2)

local timerPowerOverwhelmingCD		= mod:NewAITimer(11, 351086, nil, nil, nil, 6)
local timerHyperlightJoltCD			= mod:NewAITimer(11, 350875, nil, nil, nil, 3)
local timerEnergyFragmentationCD	= mod:NewAITimer(11, 351096, nil, nil, nil, 3)
local timerHyperlightNovaCD			= mod:NewAITimer(11, 351646, nil, nil, nil, 3)

mod.vb.hyperlightCount = 0
mod.vb.starCount = 0
local castsPerGUID = {}

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.hyperlightCount = 0
	self.vb.starCount = 0
	table.wipe(castsPerGUID)
	timerHyperlightSparkCD:Start(1-delay)
	timerCollapsingStarCD:Start(1-delay)
	timerSummonAssassinsCD:Start(1-delay)
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 350796 or spellId == 355922 then--TODO, figure out which one
		self.vb.hyperlightCount = self.vb.hyperlightCount + 1
		specWarnHyperlightSpark:Show(self.vb.hyperlightCount)
		specWarnHyperlightSpark:Play("specialsoon")
		timerHyperlightSparkCD:Start()
	elseif spellId == 353635 then
		self.vb.starCount = self.vb.starCount + 1
		warnCollapsingStar:Show(self.vb.starCount)
		timerCollapsingStarCD:Start()
	elseif spellId == 351119 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then
			specWarnShurikenBlitz:Show(args.sourceName, count)
			if count == 1 then
				specWarnShurikenBlitz:Play("kick1r")
			elseif count == 2 then
				specWarnShurikenBlitz:Play("kick2r")
			elseif count == 3 then
				specWarnShurikenBlitz:Play("kick3r")
			elseif count == 4 then
				specWarnShurikenBlitz:Play("kick4r")
			elseif count == 5 then
				specWarnShurikenBlitz:Play("kick5r")
			else
				specWarnShurikenBlitz:Play("kickcast")
			end
		end
	elseif spellId == 350875 then
		self.vb.hyperlightCount = self.vb.hyperlightCount + 1
		specWarnHyperlightJolt:Show(self.vb.hyperlightCount)
		specWarnHyperlightJolt:Play("specialsoon")
		timerHyperlightJoltCD:Start()
	elseif spellId == 351096 then
		specWarnEnergyFragmentation:Show()
		specWarnEnergyFragmentation:Play("watchwave")--wave or orb?
		timerEnergyFragmentationCD:Start()
	elseif spellId == 351646 then
		specWarnHyperlightNova:Show()
		specWarnHyperlightNova:Play("watchstep")
		timerHyperlightNovaCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 181089 then
		self:SetStage(2)
		self.vb.hyperlightCount = 0
		self.vb.starCount = 0
		warnPhase2:Show()
		warnPhase2:Play("ptwo")
		timerHyperlightSparkCD:Stop()
		timerCollapsingStarCD:Stop()
		timerSummonAssassinsCD:Stop()
		timerPowerOverwhelmingCD:Start(2)
		timerHyperlightJoltCD:Start(2)
		timerCollapsingStarCD:Start(2)
		timerEnergyFragmentationCD:Start(2)
		timerHyperlightNovaCD:Start(2)
	elseif spellId == 351124 then
		specWarnSummonAssassins:Show()
		specWarnSummonAssassins:Play("mobsoon")
		timerSummonAssassinsCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 357190 then
		if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() then
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(5, "playerbaddebuff", 357190)
		end
	elseif spellId == 350804 then
		if args:IsPlayer() then
			warnCollapsingEnergy:Show(args.destName, args.amount or 1)
		end
	elseif spellId == 351086 then
		warnPowerOverwhelming:Show()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 322681 and args:IsPlayer() then
		warnCollapsingEnergyOver:Show()
	elseif spellId == 351086 then
		warnPowerOverwhelmingEnded:Show()
--		timerPowerOverwhelmingCD:Start(3)
	end
end

--[[--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 320366 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 164578 then

	end
end


function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257453  then

	end
end
--]]
