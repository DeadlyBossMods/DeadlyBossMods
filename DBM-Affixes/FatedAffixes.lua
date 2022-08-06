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
 or ability.id = 372638 and type = "begincast" or ability.id = 371254
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

local timerChaoticEssenceCD						= mod:NewCDTimer(58.8, 372634, nil, nil, nil, 1)--Consistent
local timerCreationSparkCD						= mod:NewCDTimer(44.9, 369505, nil, nil, nil, 3)--Consistent
local timerProtoformBarrierCD					= mod:NewCDTimer(50, 371447, nil, nil, nil, 5)--50-65
local timerReconfigurationEmitterCD				= mod:NewCDTimer(55, 371254, nil, nil, nil, 1)--55-75
local timerReplicatingEssenceCD					= mod:NewAITimer(44.9, 372286, nil, nil, nil, 3)--Not Active week 1

local activeBosses = {}
local activeAffixes = {}
local borrowedTime = {}
local specialTimers = {
	[372419] = {--Emitter
		[0] = {--Repeating Timer
			--Castle Nathria
			[2407] = {60, 79, 70},--Sire Denathrius (can spell queue higher like 79-84 for Stage 2 if hand of destruction cast pushes it back
			[2418] = {75},--Huntsman Altimor
			[2412] = {75},--Council of Blood (always 75, but restarts after dances)
			[2402] = {},--Kael
			[2398] = {},--Shriekwing
			[2405] = {},--Artificer XyMox
			[2383] = {},--Hungering Destroyer
			[2406] = {},--Lady Inerva Darkvein
			[2399] = {},--Sludgefist
			[2417] = {},--Stoneborne Generals
		},
		[1] = {--Initial pull/new phases (pull count reduced by 1 due to delayed start)
			--Castle Nathria
			[2407] = {23.9, 10.5, 29.5},--Sire Denathrius (sometimes sire will skip first cast in stage 2)
			[2418] = {3.9},--Huntsman Altimor
			[2412] = {3.9, 3.2},--Council of Blood
			[2402] = {},--Kael
			[2398] = {},--Shriekwing
			[2405] = {},--Artificer XyMox
			[2383] = {},--Hungering Destroyer
			[2406] = {},--Lady Inerva Darkvein
			[2399] = {},--Sludgefist
			[2417] = {},--Stoneborne Generals
		},
	},
	[372642] = {-- Chaotic Essence
		[0] = {--Repeating Timer
			--Castle Nathria
			[2407] = {},--Sire Denathrius
			[2418] = {},--Huntsman Altimor
			[2412] = {},--Council of Blood
			[2402] = {},--Kael
			[2398] = {},--Shriekwing
			[2405] = {58.8},--Artificer XyMox
			[2383] = {},--Hungering Destroyer
			[2406] = {},--Lady Inerva Darkvein
			[2399] = {58.8},--Sludgefist
			[2417] = {},--Stoneborne Generals
		},
		[1] = {--Initial pull/new phases (pull count reduced by 1 due to delayed start)
			--Castle Nathria
			[2407] = {},--Sire Denathrius
			[2418] = {},--Huntsman Altimor
			[2412] = {},--Council of Blood
			[2402] = {},--Kael
			[2398] = {},--Shriekwing
			[2405] = {10.2},--Artificer XyMox
			[2383] = {},--Hungering Destroyer
			[2406] = {},--Lady Inerva Darkvein
			[2399] = {10.2},--Sludgefist
			[2417] = {},--Stoneborne Generals
		},

	},
	[372418] = {--Barrier
		[0] = {--Repeating Timer
			--Castle Nathria
			[2407] = {},--Sire Denathrius
			[2418] = {},--Huntsman Altimor
			[2412] = {},--Council of Blood
			[2402] = {60},--Kael (always 60 but reflection of guilt fading causes an ICD that delays current cast, but not one after it)
			[2398] = {},--Shriekwing
			[2405] = {},--Artificer XyMox
			[2383] = {60},--Hungering Destroyer
			[2406] = {},--Lady Inerva Darkvein
			[2399] = {},--Sludgefist
			[2417] = {},--Stoneborne Generals
		},
		[1] = {--Initial pull/new phases (pull count reduced by 1 due to delayed start)
			--Castle Nathria
			[2407] = {},--Sire Denathrius
			[2418] = {},--Huntsman Altimor
			[2412] = {},--Council of Blood
			[2402] = {13.9},--Kael
			[2398] = {},--Shriekwing
			[2405] = {},--Artificer XyMox
			[2383] = {13.9},--Hungering Destroyer
			[2406] = {},--Lady Inerva Darkvein
			[2399] = {},--Sludgefist
			[2417] = {},--Stoneborne Generals
		},

	},
	[372647] = {-- Creation Spark
		[0] = {--Repeating Timer
			--Castle Nathria
			[2407] = {},--Sire Denathrius
			[2418] = {},--Huntsman Altimor
			[2412] = {},--Council of Blood
			[2402] = {},--Kael
			[2398] = {44.9},--Shriekwing
			[2405] = {},--Artificer XyMox
			[2383] = {},--Hungering Destroyer
			[2406] = {44.9},--Lady Inerva Darkvein
			[2399] = {},--Sludgefist
			[2417] = {44.9},--Stoneborne Generals
		},
		[1] = {--Initial pull/new phases (pull count reduced by 1 due to delayed start)
			--Castle Nathria
			[2407] = {},--Sire Denathrius
			[2418] = {},--Huntsman Altimor
			[2412] = {},--Council of Blood
			[2402] = {},--Kael
			[2398] = {18.9, 20},--Shriekwing
			[2405] = {},--Artificer XyMox
			[2383] = {},--Hungering Destroyer
			[2406] = {18.9},--Lady Inerva Darkvein
			[2399] = {},--Sludgefist
			[2417] = {18.9},--Stoneborne Generals
		},

	},
	[372424] = {-- Replicating Essence
		[0] = {--Repeating Timer
			--Castle Nathria
			[2407] = {},--Sire Denathrius
			[2418] = {},--Huntsman Altimor
			[2412] = {},--Council of Blood
			[2402] = {},--Kael
			[2398] = {},--Shriekwing
			[2405] = {},--Artificer XyMox
			[2383] = {},--Hungering Destroyer
			[2406] = {},--Lady Inerva Darkvein
			[2399] = {},--Sludgefist
			[2417] = {},--Stoneborne Generals
		},
		[1] = {--Initial pull/new phases (pull count reduced by 1 due to delayed start)
			--Castle Nathria
			[2407] = {},--Sire Denathrius
			[2418] = {},--Huntsman Altimor
			[2412] = {},--Council of Blood
			[2402] = {},--Kael
			[2398] = {},--Shriekwing
			[2405] = {},--Artificer XyMox
			[2383] = {},--Hungering Destroyer
			[2406] = {},--Lady Inerva Darkvein
			[2399] = {},--Sludgefist
			[2417] = {},--Stoneborne Generals
		},

	},
}

do
	--Callback handler too update timers without registering duplicate CLEU events in affixes mod.
	local function dbmEventCallback(event, ...)
		if event == "DBM_AffixEvent" then
			--eventType 0 = Stop, eventType 1 = Start, eventType 2 = extend due to spell queue/delay
			local _, _, eventType, encounterID, stage, timeAdjust, spellDebit = ...
			if activeBosses[encounterID] then
				stage = stage or 1
				activeBosses[encounterID] = stage
				if activeAffixes[372419] then--Fated Power: Reconfiguration Emitter
					if eventType == 0 then
						timerReconfigurationEmitterCD:Stop()
					elseif eventType == 1 and specialTimers[372419][1][encounterID][stage] then
						timerReconfigurationEmitterCD:Restart(specialTimers[372419][1][encounterID][stage])
					elseif timeAdjust and eventType == 2 then
						if timerReconfigurationEmitterCD:GetRemaining() < timeAdjust then
							local elapsed, total = timerReconfigurationEmitterCD:GetTime()
							local extend = timeAdjust - (total-elapsed)
							DBM:Debug("timerReconfigurationEmitterCD extended by: "..extend, 2)
							timerReconfigurationEmitterCD:Update(elapsed, total+extend)
							if spellDebit then--The extended timer is debited from next cast
								borrowedTime[372419] = extend
							end
						end
					end
				end
				if activeAffixes[372642] then--Fated Power: Chaotic Essence
					if eventType == 0 then
						timerChaoticEssenceCD:Stop()
					elseif eventType == 1 and specialTimers[372642][1][encounterID][stage] then
						timerChaoticEssenceCD:Restart(specialTimers[372642][1][encounterID][stage])
					elseif timeAdjust and eventType == 2 then
						if timerChaoticEssenceCD:GetRemaining() < timeAdjust then
							local elapsed, total = timerChaoticEssenceCD:GetTime()
							local extend = timeAdjust - (total-elapsed)
							DBM:Debug("timerChaoticEssenceCD extended by: "..extend, 2)
							timerChaoticEssenceCD:Update(elapsed, total+extend)
							if spellDebit then--The extended timer is debited from next cast
								borrowedTime[372642] = extend
							end
						end
					end
				end
				if activeAffixes[372418] then--Fated Power: Protoform Barrier
					if eventType == 0 then
						timerProtoformBarrierCD:Stop()
					elseif eventType == 1 and specialTimers[372418][1][encounterID][stage] then
						timerProtoformBarrierCD:Restart(specialTimers[372418][1][encounterID][stage])
					elseif timeAdjust and eventType == 2 then
						if timerProtoformBarrierCD:GetRemaining() < timeAdjust then
							local elapsed, total = timerProtoformBarrierCD:GetTime()
							local extend = timeAdjust - (total-elapsed)
							DBM:Debug("timerProtoformBarrierCD extended by: "..extend, 2)
							timerProtoformBarrierCD:Update(elapsed, total+extend)
							if spellDebit then--The extended timer is debited from next cast
								borrowedTime[372418] = extend
							end
						end
					end
				end
				if activeAffixes[372647] then--Fated Power: Creation Spark
					if eventType == 0 then
						timerCreationSparkCD:Stop()
					elseif eventType == 1 and specialTimers[372647][1][encounterID][stage] then
						timerCreationSparkCD:Restart(specialTimers[372647][1][encounterID][stage])
					elseif timeAdjust and eventType == 2 then
						if timerCreationSparkCD:GetRemaining() < timeAdjust then
							local elapsed, total = timerCreationSparkCD:GetTime()
							local extend = timeAdjust - (total-elapsed)
							DBM:Debug("timerCreationSparkCD extended by: "..extend, 2)
							timerCreationSparkCD:Update(elapsed, total+extend)
							if spellDebit then--The extended timer is debited from next cast
								borrowedTime[372647] = extend
							end
						end
					end
				end
				if activeAffixes[372424] then--Fated Power: Replicating Essence
					if eventType == 0 then
						timerReplicatingEssenceCD:Stop()
					elseif eventType == 1 and specialTimers[372424][1][encounterID][stage] then
					--	timerReplicatingEssenceCD:Restart(specialTimers[372424][1][encounterID][stage])
						timerReplicatingEssenceCD:Start(stage)--AI timer tech for now
					--elseif timeAdjust and eventType == 2 then
					--	if timerReplicatingEssenceCD:GetRemaining() < timeAdjust then
					--		local elapsed, total = timerReplicatingEssenceCD:GetTime()
					--		local extend = timeAdjust - (total-elapsed)
					--		DBM:Debug("timerReplicatingEssenceCD extended by: "..extend, 2)
					--		timerReplicatingEssenceCD:Update(elapsed, total+extend)
					--		if spellDebit then--The extended timer is debited from next cast
					--			borrowedTime[372424] = extend
					--		end
					--	end
					end
				end
			end
		end
	end
	DBM:RegisterCallback("DBM_AffixEvent", dbmEventCallback)
end

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 372638 and self:AntiSpam(3, 1) then
		warnChaoticDestruction:Show()
		local encounterID = activeAffixes[372642]
		local phase = activeBosses[encounterID] or 1
		local timer = encounterID and specialTimers[372642][0][encounterID][phase] or 58.8
		if borrowedTime[372642] then
			timerChaoticEssenceCD:Start(timer-borrowedTime[372642])
			borrowedTime[372642] = nil
		else
			timerChaoticEssenceCD:Start(timer)
		end
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
		local encounterID = activeAffixes[372419]
		local phase = activeBosses[encounterID] or 1
		local timer = encounterID and specialTimers[372419][0][encounterID][phase]--No or rule for now since no fights are agreeable on good base
		if timer then
			if borrowedTime[372419] then
				timerReconfigurationEmitterCD:Start(timer-borrowedTime[372419])
				borrowedTime[372419] = nil
			else
				timerReconfigurationEmitterCD:Start(timer)
			end
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 369505 then
		warnCreationSpark:CombinedShow(0.3, args.destName)
		if self:AntiSpam(3, 3) then
			local encounterID = activeAffixes[372647]
			local phase = activeBosses[encounterID] or 1
			local timer = encounterID and specialTimers[372647][0][encounterID][phase] or 44.9
			if borrowedTime[372647] then
				timerCreationSparkCD:Start(timer-borrowedTime[372647])
				borrowedTime[372647] = nil
			else
				timerCreationSparkCD:Start(timer)
			end
		end
		if args:IsPlayer() then
			specWarnCreationSpark:Show()
			specWarnCreationSpark:Play("targetyou")
		end
	elseif spellId == 371447 and args:IsDestTypeHostile() then
		warnProtoformBarrier:Show(args.destName)
		local encounterID = activeAffixes[372418]
		local phase = activeBosses[encounterID] or 1
		local timer = encounterID and specialTimers[372418][0][encounterID][phase]--No or rule for now since no fights are agreeable on good base
		if timer then
			if borrowedTime[372418] then
				timerProtoformBarrierCD:Start(timer-borrowedTime[372418])
				borrowedTime[372418] = nil
			else
				timerProtoformBarrierCD:Start(timer)
			end
		end
--	elseif (spellId == 371597) and self:AntiSpam(3, 6) then
--		warnProtoformBarrier:Show(DBM_COMMON_L.ENEMIES)
	elseif spellId == 372286 then
		warnReplicatingEssence:CombinedShow(0.3, args.destName)--Multiple?
		if self:AntiSpam(3, 4) then
			timerReplicatingEssenceCD:Start()--Temp handling for now using AI
			--local encounterID = activeAffixes[372424]
			--local phase = activeBosses[encounterID] or 1
			--local timer = encounterID and specialTimers[372424][0][encounterID][phase] or 44.9
			--if borrowedTime[372424] then
			--	timerReplicatingEssenceCD:Start(timer-borrowedTime[372424])
			--	borrowedTime[372424] = nil
			--else
			--	timerReplicatingEssenceCD:Start(timer)
			--end
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
	local function CheckBosses(eID)
		local vulnerable = false
		for i = 1, 5 do
			local unitID = "boss"..i
			local unitGUID = UnitGUID(unitID)
			if UnitExists(unitID) and not activeBosses[eID] then
				activeBosses[eID] = 1
				--Currently it's only possible for bosses to have one of them
				--However, we don't elseif rule it because it future proofs support for a case boss might later support 2+
				--Code will break if more than one boss pulled at same time with same affix though
				--All timers are minus 1
				if DBM:UnitBuff(unitID, 372419) then--Fated Power: Reconfiguration Emitter
					activeAffixes[372419] = eID
					borrowedTime[372419] = nil
					timerReconfigurationEmitterCD:Start(specialTimers[372419][1][eID][1] or 3.9)
				end
				if DBM:UnitBuff(unitID, 372642) then--Fated Power: Chaotic Essence
					activeAffixes[372642] = eID
					borrowedTime[372642] = nil
					timerChaoticEssenceCD:Start(specialTimers[372642][1][eID][1] or 10.1)
				end
				if DBM:UnitBuff(unitID, 372418) then--Fated Power: Protoform Barrier
					activeAffixes[372418] = eID
					borrowedTime[372418] = nil
					timerProtoformBarrierCD:Start(specialTimers[372418][1][eID][1] or 14)
				end
				if DBM:UnitBuff(unitID, 372647) then--Fated Power: Creation Spark
					activeAffixes[372647] = eID
					borrowedTime[372647] = nil
					timerCreationSparkCD:Start(specialTimers[372647][1][eID][1] or 18.9)
				end
				if DBM:UnitBuff(unitID, 372424) then--Fated Power: Replicating Essence
					activeAffixes[372424] = eID
					borrowedTime[372424] = nil
					timerReplicatingEssenceCD:Start(1)--specialTimers[372424][1][eID][1] or
				end
			end
		end
	end

	function mod:ENCOUNTER_START(eID)
		if not self:IsFated() then return end
		--Delay check to make sure INSTANCE_ENCOUNTER_ENGAGE_UNIT has fired and boss unit Ids are valid
		--Yet we avoid using INSTANCE_ENCOUNTER_ENGAGE_UNIT directly since that increases timer start variation versus ENCOUNTER_START by a few milliseconds
		self:Unschedule(CheckBosses, eID)
		self:Schedule(1, CheckBosses, eID)
	end

	function mod:ENCOUNTER_END(eID)
		--Carefully only terminate fated timers if fated was active for fight and specific affix was active for fight
		--This way we can try to avoid canceling timers for other fights that might be engaged at same time
		if activeBosses[eID] then
			if activeAffixes[372419] then--Fated Power: Reconfiguration Emitter
				activeAffixes[372419] = nil
				borrowedTime[372419] = nil
				timerReconfigurationEmitterCD:Stop()
			end
			if activeAffixes[372642] then--Fated Power: Chaotic Essence
				activeAffixes[372642] = nil
				borrowedTime[372642] = nil
				timerChaoticEssenceCD:Stop()
			end
			if activeAffixes[372418] then--Fated Power: Protoform Barrier
				activeAffixes[372418] = nil
				borrowedTime[372418] = nil
				timerProtoformBarrierCD:Stop()
			end
			if activeAffixes[372647] then--Fated Power: Creation Spark
				activeAffixes[372647] = nil
				borrowedTime[372647] = nil
				timerCreationSparkCD:Stop()
			end
			if activeAffixes[372424] then--Fated Power: Replicating Essence
				activeAffixes[372424] = nil
				borrowedTime[372424] = nil
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
