if DBM:GetTOC() < 110100 then return end
local mod	= DBM:NewMod(2646, "DBM-Raids-WarWithin", 1, 1296)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(237194)--TODO, verify ID
mod:SetEncounterID(3016)
mod:SetHotfixNoticeRev(20250215000000)
--mod:SetMinSyncRevision(20250215000000)
mod:SetZone(2769)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 466340 467182 466751 469286 469327 466341 466834 1216845 1216852 1214607 466342 466958 1217987 1219041 1219039",--465952
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 1216846 1216852 1214229 1214369 466165 1216444 1218504 1219039 1220784 469362 1218992 1218991 1220846 1220761 466246 469404",
	"SPELL_AURA_APPLIED_DOSE 466246",
	"SPELL_AURA_REMOVED 1214229 1214369 466165 466246 1220290",
	"SPELL_INTERRUPT",
	"SPELL_PERIODIC_DAMAGE 1215209",
	"SPELL_PERIODIC_MISSED 1215209",
	"UNIT_DIED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_START boss1"
)

--TODO: Possibly add a bombs remaining infoframe similar to hellfire citadel 2nd boss
--TODO, possible infoframe for the heal absorb mechanic from soaking (https://www.wowhead.com/ptr-2/spell=1220761/mechengineers-canisters)
--TODO, more context for suppression (personal alerts?)
--TODO, maybe nameplate timers for https://www.wowhead.com/ptr-2/spell=466751/venting-heat that apply directly to the machines applying it
--TODO, assumed tanks will just tank swap on canisters and nothing else but we'll see
--TODO, stuff with Greedy Goblin's Armaments ?
--TODO, figure out phase change detection
--TODO, target scan giga blast?
--TODO, basically all the things for Giga Coils
--TODO, VERIFY when a player is carrying a Gigabomb, use https://www.wowhead.com/ptr-2/spell=469361/giga-bomb too?
--TODO, add stack announce for https://www.wowhead.com/ptr-2/spell=471352/juice-it when frequency of stacks is known
--TODO, detect darkfuse cronies spawn, maybe https://www.wowhead.com/ptr-2/spell=462416/signal-flare ?
--TODO, auto mark hob goblins? https://www.wowhead.com/ptr-2/spell=1216846/holding-a-wrench
--TODO, detect cratering cast start
--TODO, ego swapping? it'll need fancy checked ego amount checks https://www.wowhead.com/ptr-2/spell=467064/checked-ego
--TODO, if bomb blast can switch targets MID cast, change taunt warning to only fire during cast not after, then rework ego swap mechanics
--TODO, announce https://www.wowhead.com/ptr-2/spell=469363/fling-giga-bomb flings?
--TODO, track trick shots? (1220290)
--[[
stoppedAbility.id = 1214369 or ability.id = 1214229 and (type = "applydebuff" or type = "removedebuff") or ability.id = 1220290 and type = "removebuff" or ability.id = 469293 and (type = "applybuff" or type = "removebuff")
--]]
local timerPhaseTransition							= mod:NewStageCountTimer(33, 66911)

mod:AddInfoFrameOption(nil, true)
--Stage One: The House of Chrome
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30490))
local warnSuppression								= mod:NewCountAnnounce(467182, 3)
local warnVentingHeat								= mod:NewCountAnnounce(466751, 2, nil, false)
local warnFocusedDetonation							= mod:NewCountAnnounce(466246, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(466246))

local specWarnScatterblastCanisters					= mod:NewSpecialWarningCount(466340, nil, nil, nil, 2, 2)
local specWarnBBBBombs								= mod:NewSpecialWarningCount(465952, nil, nil, nil, 2, 2)

local timerScatterblastCanistersCD					= mod:NewAITimer(97.3, 466340, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerBBBBombsCD								= mod:NewAITimer(97.3, 465952, nil, nil, nil, 3)
local timerSuppressionCD							= mod:NewAITimer(97.3, 467182, nil, nil, nil, 3)
local timerVentingHeatCD							= mod:NewAITimer(97.3, 466751, nil, nil, nil, 2)
local timer1500PoundDudCast							= mod:NewCastNPTimer(15, 466165, nil, nil, nil, 2)
local timerTimeReleasedCackler						= mod:NewTargetTimer(10, 1217292, nil, nil, nil, 2)

mod:AddPrivateAuraSoundOption(466155, true, 466155, 1)--Sapper's Satchel (sub mechanic to BBBBombs)
--Stage Two: Mechanical Maniac
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30497))
----Gallywix
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30555))
local warnGigaCoils									= mod:NewCountAnnounce(469286, 2)
local warnChargedGigaBomb							= mod:NewTargetNoFilterAnnounce(469362, 2)
local warnGigaBlast									= mod:NewCountAnnounce(469327, 3, nil, false)
local warnFusedCanisters							= mod:NewIncomingCountAnnounce(466341, 3)

local specChargedGigaBomb							= mod:NewSpecialWarningYou(469362, false, nil, nil, 1, 12)
local specWarnGigaBoomer							= mod:NewSpecialWarningYou(469404, nil, nil, nil, 1, 2)
local specWarnGTFO									= mod:NewSpecialWarningGTFO(1215209, nil, nil, nil, 1, 8)

local timerGigaCoilsCD								= mod:NewAITimer(97.3, 469286, nil, nil, nil, 5)
local timerGigaBlastCD								= mod:NewAITimer(97.3, 469327, nil, nil, nil, 3)
local timerFusedCanistersCD							= mod:NewAITimer(97.3, 466341, nil, nil, nil, 3)
local timerControlMeltdownCD						= mod:NewCastCountTimer(15, 1220846, nil, nil, nil, 2)

mod:AddPrivateAuraSoundOption(466344, true, 466341, 2)--Fused Canister
----Darkfuse Cronies
mod:AddTimerLine(DBM:EJ_GetSectionInfo(31028))
local warnEnrage									= mod:NewTargetNoFilterAnnounce(1216852, 2, nil, "Tank|Healer|RemoveEnrage")

local specWarnShockBarrage							= mod:NewSpecialWarningInterruptCount(466834, false, nil, nil, 1, 2)--REVISIT enabling by default based on player behavior
local specWarnWrench								= mod:NewSpecialWarningDefensive(1216845, nil, nil, nil, 1, 2)

local timerShockBarrageCast							= mod:NewCastNPTimer(10, 466834, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)
--local timerWrenchCD								= mod:NewCDNPTimer(97.3, 1216845, nil, nil, nil, 5)
--local timerEnrageCD								= mod:NewCDNPTimer(97.3, 1216852, nil, nil, nil, 5)

mod:AddSetIconOption("SetIconOnSentry", -31487, false, 5, {8, 7, 6}, true)
--mod:AddSetIconOption("SetIconOnHobb", -31489, false, 5, {7, 8}, true)
--Intermission: Docked and Loaded
mod:AddTimerLine(DBM:EJ_GetSectionInfo(31558))

local specWarnCratering								= mod:NewSpecialWarningDodge(1214226, nil, nil, nil, 3, 2)
local specWarnTotalDestructionInterrupt				= mod:NewSpecialWarningInterrupt(1214369, "HasInterrupt", nil, nil, 1, 2)

local timerTotalDestruction							= mod:NewCastTimer(25, 1214369, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)

mod:AddPrivateAuraSoundOption(1219279, true, 1219279, 2)--Gallybux Pest Eliminator (Mythic only)
--Stage Three: What an Arsenal!
mod:AddTimerLine(DBM:EJ_GetSectionInfo(31445))

local specWarnBBBBlast								= mod:NewSpecialWarningCount(1214607, nil, nil, nil, 2, 2)
local specWarnBBBBlastTaunt							= mod:NewSpecialWarningTaunt(1214607, nil, nil, nil, 1, 2)
local specWarnTickTockCanisters						= mod:NewSpecialWarningSoakCount(466342, nil, nil, nil, 2, 2)
local specWarnEgoCheck								= mod:NewSpecialWarningDefensive(466958, nil, nil, nil, 1, 2)

local timerBBBBlastCD								= mod:NewAITimer(97.3, 1214607, nil, nil, nil, 5)
local timerTickTockCanistersCD						= mod:NewAITimer(97.3, 466342, nil, nil, nil, 3)
local timerEgoCheckCD								= mod:NewAITimer(97.3, 466958, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)

mod:AddPrivateAuraSoundOption(1226489, true, 1226489, 2)--Overloaded Rockets (sub mechanic to BBBBlast)
--Mythic
mod:AddTimerLine(PLAYER_DIFFICULTY6)
local warnGigaBlastResidue							= mod:NewTargetNoFilterAnnounce(1218504, 2, nil, false)
local warnDischargedGigaBomb						= mod:NewTargetNoFilterAnnounce(1218992, 2)
local warnAutoLockingCuffBomb						= mod:NewTargetNoFilterAnnounce(1220784, 4)

local specWarnCombinationCanisters					= mod:NewSpecialWarningSoakCount(1217987, nil, nil, nil, 2, 2, 4)
local specWarnStaticZap								= mod:NewSpecialWarningInterruptCount(1219041, "HasInterrupt", nil, nil, 1, 2)
local specWarnIonizationDispel						= mod:NewSpecialWarningDispel(1219039, "RemoveMagic", nil, nil, 1, 2)

local timerCombinationCanistersCD					= mod:NewAITimer(97.3, 1217987, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
--local timerIonizationCD							= mod:NewCDNPTimer(97.3, 1219039, nil, nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)

mod:AddSetIconOption("SetIconOnGigaJuiced", -31029, false, 5, {1, 2, 3, 4, 5, 6}, true)

--S1
mod.vb.canisterCount = 0
mod.vb.bombsCount = 0
mod.vb.suppressionCount = 0
mod.vb.heatCount = 0
--S2
mod.vb.coilsCount = 0
mod.vb.gigaBlastCount = 0
mod.vb.meltdownCount = 0
local castsPerGUID = {}
local addUsedMarks = {}
--S3
mod.vb.egoCheckCount = 0

local savedDifficulty = "normal"
local allTimers = {
	["mythic"] = {
		[1] = {--TODO, verify this is right way
			[1217987] = {0},--Combination Canisters
			[1214607] = {0},--BBBBlast
--			[469327] = {0},--Giga Blast
			[469286] = {0},--Giga Coils
			[467182] = {0},--Suppression
			[466751] = {0},--Venting Heat
		},
	},
	["heroic"] = {
		[1] = {
			[466340] = {6.5, 17.0, 18.3, 18.9, 16.5, 20.5},--Scatterblast Canisters
			[465952] = {20.1, 35.4, 35.4},--BBBBombs
			[467182] = {31.4, 39.0, 33.6},--Suppression
			[466751] = {12.5, 25.8, 28.4, 27.5},--Venting Heat
		},
		[2.1] = {
			[469286] = {54.3},--Giga Coils
--			[469327] = {},--Giga Blast
			[466341] = {},--Fused Canisters
			[465952] = {36.6},--BBBBombs
			[467182] = {24},--Suppression
			[466751] = {20.5},--Venting Heat
		},
		[2.2] = {
			[469286] = {54.3},--Giga Coils
--			[469327] = {},--Giga Blast
			[466341] = {},--Fused Canisters
			[465952] = {},--BBBBombs
			[467182] = {},--Suppression
			[466751] = {17.2},--Venting Heat
		},
		[3] = {
			[469286] = {},--Giga Coils
--			[469327] = {},--Giga Blast
			[467182] = {},--Suppression
			[466751] = {},--Venting Heat
			[1214607] = {},--BBBBlast
			[466342] = {},--Tick Tock Canisters
		},
	},
	["normal"] = {
		[1] = {
			[466340] = {7.3, 19, 20.3, 20.9, 18.4, 22.9},--Scatterblast Canisters
			[465952] = {22.4, 39.4, 39.3},--BBBBombs
			[467182] = {34.8, 43.3, 37.4},--Suppression
			[466751] = {13.9, 28.7, 31.5, 30.6},--Venting Heat
		},
		[2.1] = {
			[469286] = {70},--Giga Coils
--			[469327] = {},--Giga Blast
			[466341] = {},--Fused Canisters
			[465952] = {44},--BBBBombs
			[467182] = {30},--Suppression
			[466751] = {25.5},--Venting Heat
		},
		[2.2] = {
			[469286] = {70},--Giga Coils
--			[469327] = {},--Giga Blast
			[466341] = {},--Fused Canisters
			[465952] = {},--BBBBombs
			[467182] = {},--Suppression
			[466751] = {},--Venting Heat
		},
		[3] = {
			[469286] = {},--Giga Coils
			[467182] = {},--Suppression
			[466751] = {},--Venting Heat
			[1214607] = {},--BBBBlast
			[466342] = {},--Tick Tock Canisters
		},
	},
}

function mod:OnCombatStart(delay)
	self:SetStage(1)
	table.wipe(castsPerGUID)
	table.wipe(addUsedMarks)
	self.vb.canisterCount = 0
	self.vb.bombsCount = 0
	self.vb.suppressionCount = 0
	self.vb.heatCount = 0
	self.vb.coilsCount = 0
	self.vb.gigaBlastCount = 0
	self.vb.meltdownCount = 0
	self.vb.egoCheckCount = 0
	if self:IsMythic() then
		savedDifficulty = "mythic"
		timerCombinationCanistersCD(allTimers[savedDifficulty][1][1217987][1]-delay, 1)
		timerBBBBlastCD:Start(allTimers[savedDifficulty][1][1214607][1]-delay, 1)
		timerSuppressionCD:Start(allTimers[savedDifficulty][1][467182][1]-delay, 1)
		timerGigaBlastCD:Start(allTimers[savedDifficulty][1][469327][1]-delay, 1)
		timerGigaCoilsCD:Start(allTimers[savedDifficulty][1][469286][1]-delay, 1)
		--timerEgoCheckCD:Start(allTimers[savedDifficulty][1][466958][1]-delay, 1)
	else
		if self:IsHeroic() then
			savedDifficulty = "heroic"
			timerPhaseTransition:Start(111, 2)
		else
			savedDifficulty = "normal"
			timerPhaseTransition:Start(123, 2)
		end
		timerScatterblastCanistersCD:Start(allTimers[savedDifficulty][1][466340][1]-delay, 1)
		timerBBBBombsCD:Start(allTimers[savedDifficulty][1][465952][1]-delay, 1)
		timerSuppressionCD:Start(allTimers[savedDifficulty][1][467182][1]-delay, 1)
		timerVentingHeatCD:Start(allTimers[savedDifficulty][1][466751][1]-delay, 1)
	end
	self:EnablePrivateAuraSound(466155, "bombyou", 12)
	self:EnablePrivateAuraSound(466344, "gather", 2)
	self:EnablePrivateAuraSound(1219279, "lineyou", 17)
	self:EnablePrivateAuraSound(1226489, "lineyou", 17)
	self:EnablePrivateAuraSound(1214767, "lineyou", 17, 1226489)
	self:EnablePrivateAuraSound(1214750, "lineyou", 17, 1226489)
	self:EnablePrivateAuraSound(1214763, "lineyou", 17, 1226489)
	self:EnablePrivateAuraSound(1214758, "lineyou", 17, 1226489)
	self:EnablePrivateAuraSound(1214765, "lineyou", 17, 1226489)
	self:EnablePrivateAuraSound(1214761, "lineyou", 17, 1226489)
	self:EnablePrivateAuraSound(1214766, "lineyou", 17, 1226489)
	self:EnablePrivateAuraSound(1214749, "lineyou", 17, 1226489)
	self:EnablePrivateAuraSound(1214762, "lineyou", 17, 1226489)
	self:EnablePrivateAuraSound(1214759, "lineyou", 17, 1226489)
	self:EnablePrivateAuraSound(1214764, "lineyou", 17, 1226489)
	self:EnablePrivateAuraSound(1214760, "lineyou", 17, 1226489)
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:OnTimerRecovery()
	if self:IsMythic() then
		savedDifficulty = "mythic"
	elseif self:IsHeroic() then
		savedDifficulty = "heroic"
	else
		savedDifficulty = "normal"
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 466340 then
		self.vb.canisterCount = self.vb.canisterCount + 1
		specWarnScatterblastCanisters:Show(self.vb.canisterCount)
		if self.vb.canisterCount % 2 == 0 then
			specWarnScatterblastCanisters:Play("sharetwo")
		else
			specWarnScatterblastCanisters:Play("shareone")
		end
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.canisterCount+1)
		if timer then
			timerScatterblastCanistersCD:Start(timer, self.vb.canisterCount+1)
		end
	--elseif spellId == 465952 then
	--	self.vb.bombsCount = self.vb.bombsCount + 1
	--	specWarnBBBBombs:Show(self.vb.bombsCount)
	--	specWarnBBBBombs:Play("bombsoon")
	--	timerBBBBombsCD:Start()--nil, self.vb.bombsCount+1
	elseif spellId == 467182 then
		self.vb.suppressionCount = self.vb.suppressionCount + 1
		warnSuppression:Show(self.vb.suppressionCount)
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.suppressionCount+1)
		if timer then
			timerSuppressionCD:Start(timer, self.vb.suppressionCount+1)
		end
	elseif spellId == 466751 then
		self.vb.heatCount = self.vb.heatCount + 1
		warnVentingHeat:Show(self.vb.heatCount)
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.heatCount+1)
		if timer then
			timerVentingHeatCD:Start(timer, self.vb.heatCount+1)
		end
	elseif spellId == 469286 then
		DBM:AddMsg("Giga Coils added to combat log, please report to DBM authors")
		--self.vb.coilsCount = self.vb.coilsCount + 1
		--warnGigaCoils:Show(self.vb.coilsCount)
		--timerGigaCoilsCD:Start()--nil, self.vb.coilsCount+1
		--if self:GetStage(1) then
		--	self:SetStage(2)
		--	--Reset Counts
		--	self.vb.canisterCount = 0
		--	self.vb.bombsCount = 0
		--	self.vb.suppressionCount = 0
		--	self.vb.heatCount = 0
		--	timerScatterblastCanistersCD:Stop()
		--	timerBBBBombsCD:Stop()
		--	timerSuppressionCD:Stop()
		--	--Restart returning abilites
		--	timerBBBBombsCD:Start(2)--, 1
		--	timerSuppressionCD:Start(2)--, 1
		--	timerFusedCanistersCD:Start(2)--, 1
		--	timerGigaBlastCD:Start(2)--, 1
		--end
	elseif spellId == 469327 then
		self.vb.gigaBlastCount = self.vb.gigaBlastCount + 1
		warnGigaBlast:Show(self.vb.gigaBlastCount)
		--timerGigaBlastCD:Start()--nil, self.vb.gigaBlastCount+1
	elseif spellId == 466341 then
		self.vb.canisterCount = self.vb.canisterCount + 1
		warnFusedCanisters:Show(self.vb.canisterCount)
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.canisterCount+1)
		if timer then
			timerFusedCanistersCD:Start(timer, self.vb.canisterCount+1)
		end
	elseif spellId == 466834 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
			if self.Options.SetIconOnSentry then--Set only icons 8-6
				for i = 8, 6, -1 do
					if not addUsedMarks[i] then
						addUsedMarks[i] = args.sourceGUID
						self:ScanForMobs(args.sourceGUID, 2, i, 1, nil, 12, "SetIconOnSentry")
						break
					end
				end
			end
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnShockBarrage:Show(args.sourceName, count)
			if count == 1 then
				specWarnShockBarrage:Play("kick1r")
			elseif count == 2 then
				specWarnShockBarrage:Play("kick2r")
			elseif count == 3 then
				specWarnShockBarrage:Play("kick3r")
			elseif count == 4 then
				specWarnShockBarrage:Play("kick4r")
			elseif count == 5 then
				specWarnShockBarrage:Play("kick5r")
			else
				specWarnShockBarrage:Play("kickcast")
			end
		end
	elseif spellId == 1219041 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
			if self.Options.SetIconOnGigaJuiced then--Set only icons 8-6
				for i = 8, 6, -1 do
					if not addUsedMarks[i] then
						addUsedMarks[i] = args.sourceGUID
						self:ScanForMobs(args.sourceGUID, 2, i, 1, nil, 12, "SetIconOnSentry")
						break
					end
				end
			end
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnStaticZap:Show(args.sourceName, count)
			if count == 1 then
				specWarnStaticZap:Play("kick1r")
			elseif count == 2 then
				specWarnStaticZap:Play("kick2r")
			elseif count == 3 then
				specWarnStaticZap:Play("kick3r")
			elseif count == 4 then
				specWarnStaticZap:Play("kick4r")
			elseif count == 5 then
				specWarnStaticZap:Play("kick5r")
			else
				specWarnStaticZap:Play("kickcast")
			end
		end
	elseif spellId == 1216845 then
		if self:IsTanking("player",nil, nil, true, args.sourceGUID) then
			specWarnWrench:Show()
			specWarnWrench:Play("defensive")
		end
		--timerWrenchCD:Start(nil, args.sourceGUID)
	elseif spellId == 1216852 then
		--timerEnrageCD:Start(nil, args.destGUID)
	elseif spellId == 1214607 then
		self.vb.bombsCount = self.vb.bombsCount + 1
		specWarnBBBBlast:Show(self.vb.bombsCount)
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnBBBBlast:Play("defensive")
			specWarnBBBBlast:ScheduleVoice(1.5, "bombsoon")
		else
			specWarnBBBBlast:Play("bombsoon")
		end
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.bombsCount+1)
		if timer then
			timerBBBBlastCD:Start(timer, self.vb.bombsCount+1)
		end
	elseif spellId == 466342 then
		self.vb.canisterCount = self.vb.canisterCount + 1
		specWarnTickTockCanisters:Show(self.vb.canisterCount)
		specWarnTickTockCanisters:Play("helpsoak")
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.canisterCount+1)
		if timer then
			timerTickTockCanistersCD:Start(timer, self.vb.canisterCount+1)
		end
	elseif spellId == 466958 then
		self.vb.egoCheckCount = self.vb.egoCheckCount + 1
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnEgoCheck:Show()
			specWarnEgoCheck:Play("defensive")
		end
		--local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.egoCheckCount+1)
		--if timer then
		--	timerEgoCheckCD:Start(timer, self.vb.egoCheckCount+1)
		--end
		timerEgoCheckCD:Start()--nil, self.vb.egoCheckCount+1
	elseif spellId == 1217987 then
		self.vb.canisterCount = self.vb.canisterCount + 1
		specWarnCombinationCanisters:Show(self.vb.canisterCount)
		specWarnCombinationCanisters:Play("helpsoak")
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.canisterCount+1)
		if timer then
			timerCombinationCanistersCD:Start(timer, self.vb.canisterCount+1)
		end
	elseif spellId == 1219039 then
		--timerIonizationCD:Start(nil, args.sourceGUID)
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 439559 then

	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 1216846 then
		--timerWrenchCD:Start(nil, args.destGUID)
		--timerEnrageCD:Start(nil, args.destGUID)
		--if self.Options.SetIconOnHobb then
		--	for i = 7, 8, 1 do
		--		if not addUsedMarks[i] then
		--			addUsedMarks[i] = args.destGUID
		--			self:ScanForMobs(args.destGUID, 2, i, 1, nil, 12, "SetIconOnHobb")
		--			break
		--		end
		--	end
		--end
	elseif spellId == 1216852 then
		warnEnrage:Show(args.destName)
	elseif spellId == 1214229 then--Armageddon-class Plating
		local _, _, _, startTime, endTime = UnitChannelInfo("boss1")
		local time = ((endTime or 0) - (startTime or 0)) / 1000
		timerTotalDestruction:Start(time)
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(args.spellName)
			local uId = DBM:GetUnitIdFromGUID(args.destGUID, true)
			DBM.InfoFrame:Show(2, "enemyabsorb", nil, args.amount, uId)
		end
		if self:GetStage(2) then
			self:SetStage(2.5)
			--Stop Timers
			timerGigaCoilsCD:Stop()
			timerFusedCanistersCD:Stop()
			timerBBBBombsCD:Stop()
			timerSuppressionCD:Stop()
			timerGigaBlastCD:Stop()
			timerTickTockCanistersCD:Stop()
			timerVentingHeatCD:Stop()
		end
	elseif spellId == 1214369 then
		local _, _, _, startTime, endTime = UnitChannelInfo("boss1")
		local time = ((endTime or 0) - (startTime or 0)) / 1000
		timerTotalDestruction:Start(time)
	elseif spellId == 466165 then
		timer1500PoundDudCast:Start()
	elseif spellId == 1216444 and not args:IsPlayer() then
		specWarnBBBBlastTaunt:Show(args.destName)
		specWarnBBBBlastTaunt:Play("tauntboss")
	elseif spellId == 1218504 then
		warnGigaBlastResidue:CombinedShow(0.3, args.destName)
	elseif spellId == 1219039 and self:CheckDispelFilter("magic") then
		specWarnIonizationDispel:CombinedShow(0.5, args.destName)
		specWarnIonizationDispel:ScheduleVoice(0.5, "helpdispel")
	elseif spellId == 1220784 then
		warnAutoLockingCuffBomb:Show(args.destName)
	elseif spellId == 469362 then
		warnChargedGigaBomb:Show(args.destName)
		if args:IsPlayer() then
			specChargedGigaBomb:Show()
			specChargedGigaBomb:Play("targetyou")
		end
	elseif spellId == 1218992 or spellId == 1218991 then--Heroic vs non heroic probably
		warnDischargedGigaBomb:Show(args.destName)
	elseif spellId == 1220846 then
		self.vb.meltdownCount = self.vb.meltdownCount + 1
		timerControlMeltdownCD:Start(15, self.vb.meltdownCount)
	elseif spellId == 466246 then
		if args:IsPlayer() then
			warnFocusedDetonation:Show(args.amount or 1)
		end
		timerTimeReleasedCackler:Stop(args.destName)
		timerTimeReleasedCackler:Start(10, args.destName)
	elseif spellId == 469404 then
		if args:IsPlayer() then
			specWarnGigaBoomer:Show()
			specWarnGigaBoomer:Play("bombyou")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 1214229 then
		specWarnTotalDestructionInterrupt:Show(args.destName)
		specWarnTotalDestructionInterrupt:Play("kickcast")
		if self.Options.InfoFrame then--Armageddon-class Plating
			DBM.InfoFrame:Hide()
		end
--	elseif spellId == 1214369 then

	elseif spellId == 466165 then
		timer1500PoundDudCast:Stop()
	elseif spellId == 466246 then
		timerTimeReleasedCackler:Stop(args.destName)
	elseif spellId == 1220290 and self:IsInCombat() then--Trick shots falling off boss
		if self:GetStage(1) then
			self:SetStage(2)
			--Reset Counts
			self.vb.canisterCount = 0
			self.vb.bombsCount = 0
			self.vb.suppressionCount = 0
			self.vb.heatCount = 0
			timerScatterblastCanistersCD:Stop()
			timerBBBBombsCD:Stop()
			timerSuppressionCD:Stop()
			timerVentingHeatCD:Stop()
			--Restart returning abilites
			timerGigaCoilsCD:Start(9, 1)
			--timerBBBBombsCD:Start(allTimers[savedDifficulty][2][465952][1], 1)
			--timerSuppressionCD:Start(allTimers[savedDifficulty][2][467182][1], 1)
			--timerFusedCanistersCD:Start(allTimers[savedDifficulty][2][466341][1], 1)
			--timerVentingHeatCD:Start(allTimers[savedDifficulty][2][466751][1], 1)
		end
	end
end

function mod:SPELL_INTERRUPT(args)
	if args.extraSpellId == 466834 then
		timerShockBarrageCast:Stop(args.destGUID)
	elseif args.extraSpellId == 1214369 then
		timerTotalDestruction:Stop()
		self:SetStage(3)
		--Reset Counts
		self.vb.canisterCount = 0
		self.vb.bombsCount = 0
		self.vb.suppressionCount = 0
		self.vb.coilsCount = 0
		self.vb.heatCount = 0
		self.vb.gigaBlastCount = 0
		--Stage 3 timers
		timerGigaCoilsCD:Start(allTimers[savedDifficulty][3][469286][1], 1)
		timerSuppressionCD:Start(allTimers[savedDifficulty][3][467182][1], 1)
		timerBBBBlastCD:Start(allTimers[savedDifficulty][3][1214607][1], 1)
		timerTickTockCanistersCD:Start(allTimers[savedDifficulty][3][466342][1], 1)
		--timerEgoCheckCD:Start(allTimers[savedDifficulty][3][466958][1], 1)
		--timerGigaBlastCD:Start(allTimers[savedDifficulty][3][469327][1], 1)
		timerVentingHeatCD:Start(allTimers[savedDifficulty][3][466751][1], 1)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 1215209 and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 231977 or cid == 237192 then--Darkfuse Technician / Giga-Juiced Technician
		for i = 8, 6, -1 do
			if addUsedMarks[i] == args.destGUID then
				addUsedMarks[i] = nil
				return
			end
		end
		if cid == 237192 then--Giga-Juiced Technician
			--timerIonizationCD:Stop(args.destGUID)
		end
	elseif cid == 231978 then--Sharpshot Sentry
		timerShockBarrageCast:Stop(args.destGUID)
		--for i = 1, 6, 1 do
		--	if addUsedMarks[i] == args.destGUID then
		--		addUsedMarks[i] = nil
		--		return
		--	end
		--end
	elseif cid == 231939 then --Darkfuse Wrenchmonger
		--timerWrenchCD:Stop(args.destGUID)
		--timerEnrageCD:Stop(args.destGUID)
		--for i = 7, 8, 1 do
		--	if addUsedMarks[i] == args.destGUID then
		--		addUsedMarks[i] = nil
		--		return
		--	end
		--end
	end
end

--"<20.27 08:39:20> [CHAT_MSG_RAID_BOSS_EMOTE] |TInterface\\ICONS\\Ships_ABILITY_Bombers.BLP:20|t %s begins to cast |cFFFF0000|Hspell:465952|h[Big Bad Buncha Bombs]|h|r!#Chrome King Gallywix#####0#0##0#2735#nil#0#false#false#false#false",
--"<22.38 08:39:22> [CLEU] SPELL_CAST_START#Vehicle-0-3772-2769-360-231075-00004950E9#Chrome King Gallywix(91.1%-18.0%)##nil#465952#Big Bad Buncha Bombs#nil#nil#nil#nil#nil#nil",
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find("spell:1214222") or msg:find("spell:1214217") or msg:find("spell:1214226") then
		specWarnCratering:Show()
		specWarnCratering:Play("watchstep")
	elseif msg:find("spell:465952") then--Emote 2 seconds faster than CLEU
		self.vb.bombsCount = self.vb.bombsCount + 1
		specWarnBBBBombs:Show(self.vb.bombsCount)
		specWarnBBBBombs:Play("bombsoon")
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 465952, self.vb.bombsCount+1)
		if timer then
			timerBBBBombsCD:Start(timer, self.vb.bombsCount+1)
		end
	end
end

function mod:UNIT_SPELLCAST_START(uId, _, spellId)
	if spellId == 469286 then
		self.vb.coilsCount = self.vb.coilsCount + 1
		warnGigaCoils:Show(self.vb.coilsCount)
		timerGigaCoilsCD:Start()--nil, self.vb.coilsCount+1
	end
end
