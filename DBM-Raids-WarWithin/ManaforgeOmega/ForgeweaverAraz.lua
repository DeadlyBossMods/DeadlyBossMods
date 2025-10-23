local mod	= DBM:NewMod(2687, "DBM-Raids-WarWithin", 1, 1302)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(233817)
mod:SetEncounterID(3132)
mod:SetHotfixNoticeRev(20250821000000)
mod:SetMinSyncRevision(20250821000000)
mod:SetZone(2810)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 1228502 1228216 1228161 1227631 1231720 1232221 1230529 1243887 1248133 1234328 1228213 1232590 1248009",
	"SPELL_AURA_APPLIED 1228188 1233979 1233415 1243873",--1228506
--	"SPELL_AURA_APPLIED_DOSE 1228506",
	"SPELL_AURA_REMOVED 1233979 1233415 1243873",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED"
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"UNIT_POWER_UPDATE boss1 boss2 boss3 boss4 boss5"
)

--TODO, tank stacks placeholder, or eliminate tank stacks if swaps just happen naturally with arcane obliteration
--TODO, see if https://www.wowhead.com/ptr-2/spell=1228220/arcane-echo spell summon logged?
--TODO, need a better understanding how echos work before implimenting their timer and alert handling correctly
--TODO, maybe announce people silenced by https://www.wowhead.com/ptr-2/spell=1228168/silencing-tempest
--TODO, better handling of arcane collector stuff
--TODO, detect intermission arcane collector spawns and initial timers ?
--TODO, https://www.wowhead.com/ptr-2/spell=1232590/arcane-convergence ?
--[[
(ability.id = 1230529 or ability.id = 1227631 or ability.id = 1248009) and type = "begincast"
 or ability.id = 1230231 and type = "cast"
 or ability.id = 1233415
--]]
--mod:AddTimerLine(DBM:EJ_GetSectionInfo(28754))
--local warnOverwhelmingPower						= mod:NewStackAnnounce(1228502, 2, nil, "Tank|Healer")
local warnVoidTear									= mod:NewCountAnnounce(1248171, 3)

--local specWarnOverwhelmingPower					= mod:NewSpecialWarningStack(1228502, nil, 10, nil, nil, 1, 6)
--local specWarnOverwhelmingPowerTaunt				= mod:NewSpecialWarningTaunt(1228502, false, nil, nil, 1, 2)
local specWarnArcaneObliteration					= mod:NewSpecialWarningCount(1228216, nil, nil, DBM_COMMON_L.GROUPSOAK, 2, 2)
local yellArcaneObliteration						= mod:NewShortYell(1228216, DBM_COMMON_L.GROUPSOAK, nil, nil, "YELL")
local yellArcaneObliterationFades					= mod:NewShortFadesYell(1228216, nil, nil, nil, "YELL")
local specWarnSilencingTempest						= mod:NewSpecialWarningDodgeCount(1228188, nil, nil, DBM_COMMON_L.POOLS, 2, 2)--Plural, player drops multiple Pools
local yellSilencingTempest							= mod:NewShortYell(1228188, DBM_COMMON_L.POOLS)
local specWarnArcaneExpulsion						= mod:NewSpecialWarningCount(1227631, nil, 28405, nil, 2, 2)
local specWarnInvokeCollector						= mod:NewSpecialWarningSwitchCount(1231720, "-Tank", nil, nil, 1, 2)--Tank should stay away
local specWarnAstralHarvest							= mod:NewSpecialWarningYou(1228214, nil, nil, nil, 1, 2)
local yellAstralHarvestFades						= mod:NewShortFadesYell(1228214, DBM_COMMON_L.ORBS)
local specWarnVoidTear								= mod:NewSpecialWarningCount(1248171, "Tank", nil, nil, 1, 2)
--local specWarnGTFO								= mod:NewSpecialWarningGTFO(459785, nil, nil, nil, 1, 8)

local timerOverwhelmingPowerCD						= mod:NewCDCountTimer(44, 1228502, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerArcaneObliterationCD						= mod:NewCDCountTimer(45, 1228216, DBM_COMMON_L.GROUPSOAK.." (%s)", nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerSilencingTempestCD						= mod:NewCDCountTimer(97.3, 1228188, DBM_COMMON_L.POOLS.." (%s)", nil, nil, 3)
local timerArcaneExpulsionCD						= mod:NewCDCountTimer(97.3, 1227631, 28405, nil, nil, 2)--Shortname "Knockback"
local timerInvokeCollectorCD						= mod:NewCDCountTimer(97.3, 1231720, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerVoidTearCD								= mod:NewCDCountTimer(97.3, 1248171, nil, nil, nil, 5, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerAstralHarvestCD							= mod:NewCDCountTimer(97.3, 1228214, DBM_COMMON_L.ADDS.." (%s)", nil, nil, 2)
local berserkTimer									= mod:NewBerserkTimer(600)
--Intermission: Priming the Forge
mod:AddTimerLine(DBM:EJ_GetSectionInfo(32397))
local warnManaSplinter								= mod:NewTargetNoFilterAnnounce(1233415, 1)
local warnManaSplinterFaded							= mod:NewFadesAnnounce(1233415, 2)
local specWarnPhotonBlast							= mod:NewSpecialWarningDodge(1234328, nil, nil, nil, 2, 15)
local specWarnArcaneConvergence						= mod:NewSpecialWarningSpell(1232590, nil, nil, DBM_COMMON_L.AOEDAMAGE, 2, 2)

local timerPhotonBlastCD							= mod:NewCDNPTimer(4, 1234328, nil, nil, nil, 3)--4 seconds except when delayed by astral harvest
--Intermission: The Iris Opens
--No new mechanics
--Stage Two: Darkness Hungers
mod:AddTimerLine(DBM:EJ_GetSectionInfo(32384))
local warnPhase2									= mod:NewPhaseAnnounce(2, 2, nil, nil, nil, nil, nil, 2)

local specWarnVoidHarvest							= mod:NewSpecialWarningYou(1243901, nil, nil, nil, 1, 2)
local yellVoidHarvestFades							= mod:NewShortFadesYell(1243901, DBM_COMMON_L.ADD)
local specWarnDeaththroes							= mod:NewSpecialWarningCount(1232221, nil, 28405, nil, 2, 2, 4)

local timerVoidHarvestCD							= mod:NewCDCountTimer(8, 1243901, DBM_COMMON_L.ADDS.." (%s)", nil, nil, 3)
local timerDeaththroesCD							= mod:NewCDCountTimer(97.3, 1232221, 28405, nil, nil, 2, nil, DBM_COMMON_L.MYTHIC_ICON)--Shortname "Knockback"

mod.vb.overwhelmingPowerCount = 0--Returns in stage 2
mod.vb.obliterationCount = 0
mod.vb.silencingTempestCount = 0--Returns in stage 2
mod.vb.arcaneExpulsionCount = 0
mod.vb.invokeCollectorCount = 0
mod.vb.voidTearCount = 0
mod.vb.astralharvestCount = 0
mod.vb.manaSacrificeCasts = 0
--Stage 2
mod.vb.voidHarvestCount = 0
mod.vb.deaththroesCount = 0

local seenGUID = {}
local savedDifficulty = "normal"
local allTimers = {
	["mythic"] = {
		[1] = {
			--Overwhelming Power
			[1228502] = {4, 22, 22, 22, 22, 22},
			--Arcane Obliteration
			[1228216] = {30.9, 45},
			--Silencing Tempest
			[1228161] = {63, 44, 23},--23 is diff from heroic
			--Arcane Expulsion
			[1227631] = {155},--5 second longer than heroic
			--Invoke Collector
			[1231720] = {9, 43.5, 41.9},
			--Void Tear
			[1248133] = {21.5, 45.5, 14.4, 28.5, 14.4, 15},--14.4s can sometimes be 15.5
			--Astral Harvest
			[1228213] = {23.4, 46, 14.5, 28.9, 14.5, 15.5},
		},
		[2] = {
			--Overwhelming Power
			[1228502] = {18.6, 22, 22},
			--Arcane Obliteration
			[1228216] = {45.6},
			--Silencing Tempest
			[1228161] = {67.7},
			--Arcane Expulsion
			[1227631] = {79.6},--MUCH shorter than heroic
			--Invoke Collector
			[1231720] = {0.000001},
			--Void Tear
			[1248133] = {36.2, 15, 14.4},
			--Astral Harvest
			[1228213] = {38.7, 15, 14.4},
		},
		[3] = {
			--Void Harvest
			[1243887] = {8, 8, 8, 28},
			--Deaththroes (mythic only)
			[1232221] = {12},
			--Overwhelming Power
			[1228502] = {4, 22, 22},
			--Silencing Tempest
			[1228161] = {36.4},
		},
	},
	["heroic"] = {
		[1] = {
			--Overwhelming Power
			[1228502] = {4, 22, 22, 22, 22, 22},
			--Arcane Obliteration
			[1228216] = {30.9, 45},
			--Silencing Tempest
			[1228161] = {63, 44, 23},
			--Arcane Expulsion
			[1227631] = {145},
			--Invoke Collector
			[1231720] = {9, 44, 44},
			--Astral Harvest
			[1228213] = {20, 46, 8, 36, 8, 8},
		},
		[2] = {
			--Overwhelming Power
			[1228502] = {18.6, 22, 22},
			--Arcane Obliteration
			[1228216] = {45.7},--Only 1 in second set
			--Silencing Tempest
			[1228161] = {67.7},
			--Arcane Expulsion
			[1227631] = {79.7},
			--Invoke Collector
			[1231720] = {0.000001},
			--Astral Harvest
			[1228213] = {34.6, 8, 8},
		},
		[3] = {
			--Void Harvest
			[1243887] = {8, 8, 36, 8, 36, 8},
			--Overwhelming Power
			[1228502] = {4, 22, 22, 22, 22, 22},
			--Silencing Tempest
			[1228161] = {12, 21},
		},
	},
	["normal"] = {--LFR confirmed same
		[1] = {
			--Overwhelming Power
			[1228502] = {4, 22, 22, 22, 22, 22},
			--Arcane Obliteration
			[1228216] = {30.9, 45},
			--Silencing Tempest
			[1228161] = {97.9},
			--Arcane Expulsion
			[1227631] = {125},
			--Invoke Collector
			[1231720] = {9, 44},
			--Astral Harvest
			[1228213] = {20, 44, 8, 23, 8},
		},
		[2] = {
			--Overwhelming Power
			[1228502] = {18.6, 22, 22},--Only 3 second time
			--Arcane Obliteration
			[1228216] = {45.6},
			--Silencing Tempest
			[1228161] = {67.6},
			--Arcane Expulsion
			[1227631] = {79.6},
			--Invoke Collector
			[1231720] = {0.000001},
			--Astral Harvest
			[1228213] = {34.5, 8},
		},
		[3] = {
			--Void Harvest
			[1243887] = {8, 8, 36, 8, 36, 8},
			--Overwhelming Power
			[1228502] = {4, 22, 22, 22, 22, 22},
			--Silencing Tempest
			[1228161] = {33, 43.9},
		},
	},
}

---@param self DBMMod
local function delayedTankCheck(self)
	local _, unitID = self:GetBossTarget(233817)
	if unitID and UnitIsUnit("player", unitID) then
		yellArcaneObliteration:Yell()
		yellArcaneObliterationFades:Countdown(4.7)
	end
	specWarnArcaneObliteration:Show(self.vb.obliterationCount)
	if self:IsTank() then
		specWarnArcaneObliteration:Play("changemt")
	else
		if self:IsMythic() then
			if self.vb.obliterationCount % 2 == 0 then
				specWarnArcaneObliteration:Play("sharetwo")
			else
				specWarnArcaneObliteration:Play("shareone")
			end
		else
			specWarnArcaneObliteration:Play("helpsoak")
		end
	end
end

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.overwhelmingPowerCount = 0
	self.vb.obliterationCount = 0
	self.vb.silencingTempestCount = 0
	self.vb.arcaneExpulsionCount = 0
	self.vb.invokeCollectorCount = 0
	self.vb.voidHarvestCount = 0
	self.vb.deaththroesCount = 0
	self.vb.voidTearCount = 0
	self.vb.astralharvestCount = 0
	self.vb.manaSacrificeCasts = 0
	if self:IsMythic() then
		savedDifficulty = "mythic"
		timerVoidTearCD:Start(allTimers[savedDifficulty][1][1248133][1]-delay, 1)
	elseif self:IsHeroic() then
		savedDifficulty = "heroic"
	else--Combine LFR and Normal
		savedDifficulty = "normal"
	end
	timerOverwhelmingPowerCD:Start(allTimers[savedDifficulty][1][1228502][1]-delay, 1)
	timerArcaneObliterationCD:Start(allTimers[savedDifficulty][1][1228216][1]-delay, 1)
	timerSilencingTempestCD:Start(allTimers[savedDifficulty][1][1228161][1]-delay, 1)
	timerArcaneExpulsionCD:Start(allTimers[savedDifficulty][1][1227631][1]-delay, 1)
	timerInvokeCollectorCD:Start(allTimers[savedDifficulty][1][1231720][1]-delay, 1)
	timerAstralHarvestCD:Start(allTimers[savedDifficulty][1][1228213][1]-delay, 1)
	berserkTimer:Start(600-delay)
end

function mod:OnCombatEnd()
	table.wipe(seenGUID)
end

function mod:OnTimerRecovery()
	if self:IsMythic() then
		savedDifficulty = "mythic"
	elseif self:IsHeroic() then
		savedDifficulty = "heroic"
	else--Combine LFR and Normal
		savedDifficulty = "normal"
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 1228502 then
		self.vb.overwhelmingPowerCount = self.vb.overwhelmingPowerCount + 1
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.manaSacrificeCasts+1, spellId, self.vb.overwhelmingPowerCount+1)
		if timer then
			timerOverwhelmingPowerCD:Start(timer, self.vb.overwhelmingPowerCount+1)
		end
	elseif spellId == 1228216 then
		self.vb.obliterationCount = self.vb.obliterationCount + 1
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.manaSacrificeCasts+1, spellId, self.vb.obliterationCount+1)
		if timer then
			timerArcaneObliterationCD:Start(timer, self.vb.obliterationCount+1)
		end
		--Delayed so it doesn't grab invalid target since boss might be looking at previous target on first frame
		self:Schedule(0.3, delayedTankCheck, self)
	elseif spellId == 1228161 then
		self.vb.silencingTempestCount = self.vb.silencingTempestCount + 1
		specWarnSilencingTempest:Show(self.vb.silencingTempestCount)
		specWarnSilencingTempest:Play("watchstep")
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.manaSacrificeCasts+1, spellId, self.vb.silencingTempestCount+1)
		if timer then
			timerSilencingTempestCD:Start(timer, self.vb.silencingTempestCount+1)
		end
	elseif spellId == 1227631 then
		self:SetStage(1.5)
		--Stop all timers
		timerOverwhelmingPowerCD:Stop()
		timerArcaneObliterationCD:Stop()
		timerSilencingTempestCD:Stop()
		timerArcaneExpulsionCD:Stop()
		timerInvokeCollectorCD:Stop()
		timerVoidTearCD:Stop()
		timerAstralHarvestCD:Stop()
		self.vb.arcaneExpulsionCount = self.vb.arcaneExpulsionCount + 1
		specWarnArcaneExpulsion:Show(self.vb.arcaneExpulsionCount)
		specWarnArcaneExpulsion:Play("carefly")
	elseif spellId == 1231720 then
		self.vb.invokeCollectorCount = self.vb.invokeCollectorCount + 1
		specWarnInvokeCollector:Show(self.vb.invokeCollectorCount)
		specWarnInvokeCollector:Play("killmob")
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.manaSacrificeCasts+1, spellId, self.vb.invokeCollectorCount+1)
		if timer then
			timerInvokeCollectorCD:Start(timer, self.vb.invokeCollectorCount+1)
		end
	elseif spellId == 1234328 then
		local uId = self:GetUnitIdFromGUID(args.sourceGUID)
		if not uId then return end--Won't happen but satisfies LuaLS
		if UnitPower(uId) > 70 then--Might need fine tuning
			timerPhotonBlastCD:Start(19, args.sourceGUID)
		else
			timerPhotonBlastCD:Start(4, args.sourceGUID)--3 seconds for first cast, then 4 seconds after that
		end
		if self:CheckBossDistance(args.sourceGUID, false, 10645, 23) and self:AntiSpam(3, 1) then
			specWarnPhotonBlast:Show()
			specWarnPhotonBlast:Play("frontal")
		end
	elseif spellId == 1232221 then--Deaththroes
		self.vb.deaththroesCount = self.vb.deaththroesCount + 1
		specWarnDeaththroes:Show(self.vb.deaththroesCount)
		specWarnDeaththroes:Play("specialsoon")
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.manaSacrificeCasts+1, spellId, self.vb.deaththroesCount+1)
		if timer then
			timerDeaththroesCD:Start(timer, self.vb.deaththroesCount+1)
		end
	elseif spellId == 1243887 then
		self.vb.voidHarvestCount = self.vb.voidHarvestCount + 1
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.manaSacrificeCasts+1, spellId, self.vb.voidHarvestCount+1)
		if timer then
			timerVoidHarvestCD:Start(timer, self.vb.voidHarvestCount+1)
		end
	elseif spellId == 1248133 then
		self.vb.voidTearCount = self.vb.voidTearCount + 1
		if self.Options.SpecWarn1248133count then
			specWarnVoidTear:Show(self.vb.voidTearCount)
			specWarnVoidTear:Play("moveboss")
		else
			warnVoidTear:Show(self.vb.voidTearCount)
		end
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.manaSacrificeCasts+1, spellId, self.vb.voidTearCount+1)
		if timer then
			timerVoidTearCD:Start(timer, self.vb.voidTearCount+1)
		end
	elseif spellId == 1228213 then
		self.vb.astralharvestCount = self.vb.astralharvestCount + 1
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.manaSacrificeCasts+1, spellId, self.vb.astralharvestCount+1)
		if timer then
			timerAstralHarvestCD:Start(timer, self.vb.astralharvestCount+1)
		end
	elseif spellId == 1232590 then
		specWarnArcaneConvergence:Show()
		specWarnArcaneConvergence:Play("aesoon")
	elseif spellId == 1230529 then--Mana Sacrifice
		self.vb.manaSacrificeCasts = self.vb.manaSacrificeCasts + 1
		self:SetStage(1)
		--Reset Counts
		self.vb.overwhelmingPowerCount = 0
		self.vb.obliterationCount = 0
		self.vb.silencingTempestCount = 0
		self.vb.invokeCollectorCount = 0
		self.vb.voidTearCount = 0
		self.vb.voidHarvestCount = 0
		self.vb.deaththroesCount = 0
		--Start all timers
		if self.vb.manaSacrificeCasts == 1 then
			timerOverwhelmingPowerCD:Start(allTimers[savedDifficulty][2][1228502][1], 1)
			timerArcaneObliterationCD:Start(allTimers[savedDifficulty][2][1228216][1], 1)
			timerSilencingTempestCD:Start(allTimers[savedDifficulty][2][1228161][1], 1)
			timerArcaneExpulsionCD:Start(allTimers[savedDifficulty][2][1227631][1], 2)--Only count not resetting since it's timer for actual phase changes
			timerInvokeCollectorCD:Start(allTimers[savedDifficulty][2][1231720][1], 1)
			timerAstralHarvestCD:Start(allTimers[savedDifficulty][2][1228213][1], 1)
			if self:IsMythic() then
				timerVoidTearCD:Start(allTimers[savedDifficulty][2][1248133][1], 1)
			end
		end
	elseif spellId == 1248009 then--Dark Terminus
		self.vb.manaSacrificeCasts = 2--Force set to 2 so staging is all sorted
		--Stop all timers
		timerOverwhelmingPowerCD:Stop()
		timerArcaneObliterationCD:Stop()
		timerSilencingTempestCD:Stop()
		timerArcaneExpulsionCD:Stop()
		timerInvokeCollectorCD:Stop()
		timerVoidTearCD:Stop()
		timerAstralHarvestCD:Stop()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 1228188 and args:IsPlayer() then
		yellSilencingTempest:Yell()
	elseif spellId == 1233979 then
		if args:IsPlayer() then
			specWarnAstralHarvest:Show()
			specWarnAstralHarvest:Play("runout")
			yellAstralHarvestFades:Countdown(spellId)
		end
	elseif spellId == 1243873 then
		if args:IsPlayer() then
			specWarnVoidHarvest:Show()
			specWarnVoidHarvest:Play("runout")
			yellVoidHarvestFades:Countdown(spellId)
		end
--	elseif spellId == 1240437 then--Volatile Surge
		--TODO, player stuffs
	elseif spellId == 1233415 then
		warnManaSplinter:Show(args.destName)
--	elseif spellId == 1228506 then
--		local amount = args.amount or 1
--		if amount % 4 == 0 then
		--if amount >= 10 then--placeholder
		--	if args:IsPlayer() then
		--		specWarnOverwhelmingPower:Show(amount)
		--		specWarnOverwhelmingPower:Play("stackhigh")
		--	else
		--		if not UnitIsDeadOrGhost("player") then
		--			specWarnOverwhelmingPowerTaunt:Show(args.destName)
		--			specWarnOverwhelmingPowerTaunt:Play("tauntboss")
		--		end
		--	end
		--else
--			warnOverwhelmingPower:Show(args.destName, amount)
		--end
--		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 1233979 then
		if args:IsPlayer() then
			yellAstralHarvestFades:Cancel()
		end
	elseif spellId == 1243873 then
		if args:IsPlayer() then
			yellVoidHarvestFades:Cancel()
		end
	elseif spellId == 1233415 then
		warnManaSplinterFaded:Show()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 240905 then--Arcane Collector
		timerPhotonBlastCD:Stop(args.destGUID)
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 459785 and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, spellId)
	if spellId == 1233072 then -- -Phase Transition P2 -> P3-
		self:SetStage(2)
		warnPhase2:Show()
		warnPhase2:Play("ptwo")
		timerOverwhelmingPowerCD:Start(allTimers[savedDifficulty][3][1228502][1], 1)
		timerSilencingTempestCD:Start(allTimers[savedDifficulty][3][1228161][1], 1)
		timerVoidHarvestCD:Start(allTimers[savedDifficulty][3][1243887][1], 1)
		if self:IsMythic() then
			timerDeaththroesCD:Start(allTimers[savedDifficulty][3][1232221][1], 1)
		end
	end
end

--"<164.08 16:35:58> [UNIT_POWER_UPDATE] boss3#Arcane Collector#TYPE:ENERGY/3#MAIN:5/100#ALT:0/0",
--"<167.06 16:36:01> [CLEU] SPELL_CAST_START#Creature-0-3893-2810-5344-240905-0000A1E7FD#Arcane Collector(95.3%-15.0%)##nil#1234328#Photon Blast#nil
function mod:UNIT_POWER_UPDATE(uId)
	local guid = UnitGUID(uId)
	if not guid or seenGUID[guid] then return end
	local cid = self:GetCIDFromGUID(guid)
	if cid == 240905 then--Arcane Collector
		seenGUID[guid] = true
		timerPhotonBlastCD:Start(3, guid)
	end
end
