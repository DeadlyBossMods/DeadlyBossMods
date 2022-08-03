local mod	= DBM:NewMod("FatedAffixes", "DBM-Affixes")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(47785)
mod:SetZone(2296, 2450, 2481)--Shadowlands Raids

mod.isTrashMod = true
mod.isTrashModBossFightAllowed = true

mod:RegisterEvents(
	"SPELL_CAST_START 372638",
	"SPELL_CAST_SUCCESS 372634",
	"SPELL_SUMMON 371254",
	"SPELL_AURA_APPLIED 369505 371447 371597 372286",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 369505 372286",
--	"SPELL_DAMAGE",
--	"SPELL_MISSED",
	"ENCOUNTER_START",
	"ENCOUNTER_END"
)

--[[
(ability.id = 372419 or ability.id = 372642 or ability.id = 372418 or ability.id = 372647 or ability.id = 372424) and type = "applybuff"
 or ability.id = 372638 or ability.id = 371254
 or (ability.id = 369505 or ability.id = 371447 or ability.id = 372286) and (type = "applybuff" or type = "applydebuff")
 or ability.id = 371597 or ability.id = 372634
--]]
local warnChaoticDestruction					= mod:NewCastAnnounce(372638, 3)--Add activating
local warnChaoticEssence						= mod:NewSpellAnnounce(372634, 2)--Clicked add
local warnCreationSpark							= mod:NewTargetNoFilterAnnounce(369505, 3)
local warnProtoformBarrier						= mod:NewTargetNoFilterAnnounce(371447, 3)
local warnReconfigurationEmitter				= mod:NewSpellAnnounce(371254, 3)
local warnReplicatingEssence					= mod:NewTargetNoFilterAnnounce(372286, 3)

local specWarnCreationSpark						= mod:NewSpecialWarningYou(369505, nil, nil, nil, 1, 2)
local yellCreationSpark							= mod:NewYell(369505)
local specWarnCreationSparkSoak					= mod:NewSpecialWarningSoak(369505, nil, nil, nil, 2, 7)
local specWarnReplicatingEssence				= mod:NewSpecialWarningYou(372286, nil, nil, nil, 1, 2)
local yellReplicatingEssence					= mod:NewYell(372286)
local yellReplicatingEssenceFades				= mod:NewShortFadesYell(372286)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(209862, nil, nil, nil, 1, 8)

local timerChaoticEssenceCD						= mod:NewCDTimer(58.8, 372634, nil, nil, nil, 1)
local timerCreationSparkCD						= mod:NewCDTimer(44.9, 369505, nil, nil, nil, 3)
local timerProtoformBarrierCD					= mod:NewCDTimer(59.9, 371447, nil, nil, nil, 5)
--local timerReconfigurationEmitterCD				= mod:NewCDTimer(75, 371254, nil, nil, nil, 1)
local timerReplicatingEssenceCD					= mod:NewAITimer(44.9, 372286, nil, nil, nil, 3)--Not Active week 1

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 372638 and self:AntiSpam(3, 1) then
		warnChaoticDestruction:Show()
		timerChaoticEssenceCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 372634 then
		warnChaoticEssence:Show()
	end
end

function mod:SPELL_SUMMON(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 371254 and self:AntiSpam(3, 2) then
		warnReconfigurationEmitter:Show()
--		timerReconfigurationEmitterCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 369505 then
		warnCreationSpark:CombinedShow(0.3, args.destName)
		if self:AntiSpam(3, 3) then
			timerCreationSparkCD:Start()
		end
		if args:IsPlayer() then
			specWarnCreationSpark:Show()
			specWarnCreationSpark:Play("targetyou")
		end
	elseif spellId == 371447 and args:IsDestTypeHostile() then
		warnProtoformBarrier:Show(args.destName)
--	elseif (spellId == 371597) and self:AntiSpam(3, 6) then
--		warnProtoformBarrier:Show(DBM_COMMON_L.ENEMIES)
	elseif spellId == 372286 then
		warnReplicatingEssence:CombinedShow(0.3, args.destName)--Multiple?
		if self:AntiSpam(3, 4) then
			timerReplicatingEssenceCD:Start()
		end
		if args:IsPlayer() then
			specWarnReplicatingEssence:Show()
			specWarnReplicatingEssence:Play("targetyou")
			yellReplicatingEssence:Yell()
			yellReplicatingEssenceFades:Countdown(spellId)
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 369505 and self:AntiSpam(5, 2) then
		specWarnCreationSparkSoak:Show()
		specWarnCreationSparkSoak:Play("helpsoak")
	elseif spellId == 372286 then
		if args:IsPlayer() then
			yellReplicatingEssenceFades:Cancel()
		end
	end
end

do
	local activeBosses = {}
	local function CheckBosses(eID)
		local vulnerable = false
		for i = 1, 5 do
			local unitID = "boss"..i
			local unitGUID = UnitGUID(unitID)
			if UnitExists(unitID) and not activeBosses[eID] then
				activeBosses[eID] = {}
				--Currently it's only possible for bosses to have one of them
				--However, we don't elseif rule it because it future proofs support for a case boss might later support 2+
				--Also coded ugly to support mythic group pulling two bosses at once on LFR/Normal
				--All timers are minus 1
				if DBM:UnitBuff(unitID, 372419) then--Fated Power: Reconfiguration Emitter
					activeBosses[eID][372419] = true
--					timerReconfigurationEmitterCD:Start(3.9)
				end
				if DBM:UnitBuff(unitID, 372642) then--Fated Power: Chaotic Essence
					activeBosses[eID][372642] = true
					timerChaoticEssenceCD:Start(10.1)
				end
				if DBM:UnitBuff(unitID, 372418) then--Fated Power: Protoform Barrier
					activeBosses[eID][372418] = true
					timerProtoformBarrierCD:Start(14)
				end
				if DBM:UnitBuff(unitID, 372647) then--Fated Power: Creation Spark
					activeBosses[eID][372647] = true
					timerCreationSparkCD:Start(18.9)
				end
				if DBM:UnitBuff(unitID, 372424) then--Fated Power: Replicating Essence
					activeBosses[eID][372424] = true
					timerReplicatingEssenceCD:Start(1)
				end
			end
		end
	end

	function mod:ENCOUNTER_START(eID)
		--Delay check to make sure INSTANCE_ENCOUNTER_ENGAGE_UNIT has fired and boss unit Ids are valid
		--Yet we avoid using INSTANCE_ENCOUNTER_ENGAGE_UNIT directly since that increases timer start variation versus ENCOUNTER_START by a few milliseconds
		self:Unschedule(CheckBosses, eID)
		self:Schedule(1, CheckBosses, eID)
	end

	function mod:ENCOUNTER_END(eID)
		--Carefully only terminate fated timers if fated was active for fight and specific affix was active for fight
		--This way we can try to avoid canceling timers for other fights that might be engaged at same time
		if activeBosses[eID] then
			if activeBosses[eID][372419] then--Fated Power: Reconfiguration Emitter
				activeBosses[eID][372419] = true
--				timerReconfigurationEmitterCD:Stop()
			end
			if activeBosses[eID][372642] then--Fated Power: Chaotic Essence
				activeBosses[eID][372642] = true
				timerChaoticEssenceCD:Stop()
			end
			if activeBosses[eID][372418] then--Fated Power: Protoform Barrier
				activeBosses[eID][372418] = true
				timerProtoformBarrierCD:Stop()
			end
			if activeBosses[eID][372647] then--Fated Power: Creation Spark
				activeBosses[eID][372647] = true
				timerCreationSparkCD:Stop()
			end
			if activeBosses[eID][372424] then--Fated Power: Replicating Essence
				activeBosses[eID][372424] = false
				timerReplicatingEssenceCD:Stop()
			end
			activeBosses[eID] = nil
		end
	end
end


--[[
function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 209862 and destGUID == UnitGUID("player") and self:AntiSpam(3, 7) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE
--]]
