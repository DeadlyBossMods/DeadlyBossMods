if DBM:GetTOC() < 110200 then return end
local mod	= DBM:NewMod(2687, "DBM-Raids-WarWithin", 1, 1302)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(247989)
mod:SetEncounterID(3132)
mod:SetHotfixNoticeRev(20250708000000)
mod:SetMinSyncRevision(20250708000000)
mod:SetZone(2810)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 1228502 1228216 1228161 1227631 1231720 1234328 1232221 1230529 1243887",
	"SPELL_CAST_SUCCESS 1230231",
	"SPELL_AURA_APPLIED 1228506 1228454 1228188 1233979 1233415 1243873",
	"SPELL_AURA_APPLIED_DOSE 1228506",
	"SPELL_AURA_REMOVED 1228454 1233979 1233415 1243873",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED"
	"UNIT_DIED"
--	"CHAT_MSG_RAID_BOSS_WHISPER",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, tank stacks placeholder, or eliminate tank stacks if swaps just happen naturally with arcane obliteration
--TODO, see if https://www.wowhead.com/ptr-2/spell=1228220/arcane-echo spell summon logged?
--TODO, need a better understanding how echos work before implimenting their timer and alert handling correctly
--TODO, maybe announce people silenced by https://www.wowhead.com/ptr-2/spell=1228168/silencing-tempest
--TODO, better handling of arcane collector stuff
--TODO, nameplate timer for https://www.wowhead.com/ptr-2/spell=1228213/astral-harvest ?
--TODO, detect intermission arcane collector spawns and initial timers ?
--TODO, https://www.wowhead.com/ptr-2/spell=1232590/arcane-convergence ?
--TODO, tank swaps for https://www.wowhead.com/ptr-2/spell=1238266/ramping-power on Shielded Attendant?
--[[
(ability.id = 1230529) and type = "begincast"
 or ability.id = 1230231 and type = "cast"
 or ability.id = 1233415
--]]
--mod:AddTimerLine(DBM:EJ_GetSectionInfo(28754))
local warnOverwhelmingPower							= mod:NewStackAnnounce(1228502, 2, nil, "Tank|Healer")

local specWarnOverwhelmingPower						= mod:NewSpecialWarningStack(1228502, nil, 10, nil, nil, 1, 6)
local specWarnOverwhelmingPowerTaunt				= mod:NewSpecialWarningTaunt(1228502, nil, nil, nil, 1, 2)
local specWarnArcaneObliteration					= mod:NewSpecialWarningCount(1228216, nil, nil, DBM_COMMON_L.GROUPSOAK, 2, 2)
local yellArcaneObliteration						= mod:NewShortYell(1228216, DBM_COMMON_L.GROUPSOAK, nil, nil, "YELL")
local yellArcaneObliterationFades					= mod:NewShortFadesYell(1228216, nil, nil, nil, "YELL")
local specWarnSilencingTempest						= mod:NewSpecialWarningDodgeCount(1228161, nil, nil, nil, 2, 2)
local yellSilencingTempest							= mod:NewShortYell(1228161)
local specWarnArcaneExpulsion						= mod:NewSpecialWarningCount(1227631, nil, nil, nil, 2, 2)
local specWarnInvokeCollector						= mod:NewSpecialWarningSwitchCount(1231720, "-Tank", nil, nil, 1, 2)--Tank should stay away
local specWarnAstralHarvest							= mod:NewSpecialWarningYou(1233979, nil, nil, nil, 1, 2)
local yellAstralHarvestFades						= mod:NewShortFadesYell(1233979)
--local specWarnGTFO								= mod:NewSpecialWarningGTFO(459785, nil, nil, nil, 1, 8)

local timerOverwhelmingPowerCD						= mod:NewCDCountTimer(44, 1228502, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerArcaneObliterationCD						= mod:NewCDCountTimer(45, 1228216, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerSilencingTempestCD						= mod:NewCDCountTimer(97.3, 1228161, nil, nil, nil, 3)
local timerArcaneExpulsionCD						= mod:NewCDCountTimer(97.3, 1227631, nil, nil, nil, 2)
local timerInvokeCollectorCD						= mod:NewAITimer(97.3, 1231720, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)
local berserkTimer									= mod:NewBerserkTimer(600)

mod:AddNamePlateOption("NPAuraOnMarkofPower", 1238502)
--Intermission: Priming the Forge
mod:AddTimerLine(DBM:EJ_GetSectionInfo(32397))
local warnManaSplinter								= mod:NewTargetNoFilterAnnounce(1233415, 1)
local warnManaSplinterFaded							= mod:NewFadesAnnounce(1233415, 2)
local specWarnPhotonBlast							= mod:NewSpecialWarningDodge(1234328, nil, nil, nil, 2, 15)--10 sec NP timers?
--Intermission: The Iris Opens
--No new mechanics
--Stage Two: Darkness Hungers
mod:AddTimerLine(DBM:EJ_GetSectionInfo(32384))
local warnPhase2									= mod:NewPhaseAnnounce(1248009, 2, nil, nil, nil, nil, nil, 2)

local specWarnVoidHarvest						= mod:NewSpecialWarningYou(1243873, nil, nil, nil, 1, 2)
local yellVoidHarvestFades						= mod:NewShortFadesYell(1243873)
local specWarnDeaththroes							= mod:NewSpecialWarningCount(1232221, nil, nil, nil, 2, 2, 4)

local timerVoidHarvestCD							= mod:NewAITimer(97.3, 1243873, nil, nil, nil, 3)
local timerDeaththroesCD							= mod:NewAITimer(97.3, 1232221, nil, nil, nil, 2, nil, DBM_COMMON_L.MYTHIC_ICON)

mod.vb.overwhelmingPowerCount = 0--Returns in stage 2
mod.vb.obliterationCount = 0
mod.vb.silencingTempestCount = 0--Returns in stage 2
mod.vb.arcaneExpulsionCount = 0
mod.vb.invokeCollectorCount = 0
--Stage 2
mod.vb.voidHarvestCount = 0
mod.vb.deaththroesCount = 0

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
			[1231720] = {9, 44, 44},
		},
		[2] = {
			--Overwhelming Power
			[1228502] = {18.6, 22, 22, 22, 22, 22},
			--Arcane Obliteration
			[1228216] = {68.7},
			--Silencing Tempest
			[1228161] = {57.6, 44, 21},
			--Arcane Expulsion
			[1227631] = {139.9},--10 seconds shorter than heroic
			--Invoke Collector
			[1231720] = {23.6, 22, 44},
		},
		[3] = {
			--Void Harvest
			[1243887] = {31.3, 8, 8, 28, 8, 8, 28},
			--Deaththroes (mythic only)
			[1232221] = {62.3, 44},
			--Overwhelming Power
			[1228502] = {27.3, 22, 22, 22, 22},
			--Silencing Tempest
			[1228161] = {35.3, 44},
		},
	},
	["heroic"] = {
		[1] = {
			--Overwhelming Power
			[1228502] = {4, 22, 22, 22, 22, 22},
			--Arcane Obliteration
			[1228216] = {30.9, 45},
			--Silencing Tempest
			[1228161] = {63, 44, 33},
			--Arcane Expulsion
			[1227631] = {149.9},
			--Invoke Collector
			[1231720] = {9, 44, 44},
		},
		[2] = {
			--Overwhelming Power
			[1228502] = {18.6, 22, 22, 22, 22, 22},
			--Arcane Obliteration
			[1228216] = {68.7},--Only 1 in second set
			--Silencing Tempest
			[1228161] = {57.6, 44, 21},
			--Arcane Expulsion
			[1227631] = {149.9},
			--Invoke Collector
			[1231720] = {23.6, 22, 44},
		},
		[3] = {
			--Void Harvest
			[1243887] = {39, 8, 80, 8, 46, 8},
			--Deaththroes (mythic only)
			[1232221] = {},
			--Overwhelming Power
			[1228502] = {31, 44, 44, 44, 10, 44},
			--Silencing Tempest
			[1228161] = {89, 46, 96},
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
			[1227631] = {129.9},
			--Invoke Collector
			[1231720] = {9, 44},
		},
		[2] = {
			--Overwhelming Power
			[1228502] = {18.6, 22, 22, 22, 22},--Only 5 second time
			--Arcane Obliteration
			[1228216] = {68.7},
			--Silencing Tempest
			[1228161] = {97.9},
			--Arcane Expulsion
			[1227631] = {129.9},
			--Invoke Collector
			[1231720] = {23.7, 22},
		},
		[3] = {
			--Void Harvest
			[1243887] = {39.2, 96, 46},
			--Overwhelming Power
			[1228502] = {31.2, 44, 44, 44, 10, 44},--Final 44 assumed by heroic
			--Silencing Tempest
			[1228161] = {47.2, 54},
		},
	},
}

---@param self DBMMod
local function delayedTankCheck(self)
	local _, unitID = self:GetBossTarget(247989)
	if unitID and UnitIsUnit("player", unitID) then
		yellArcaneObliteration:Yell()
		yellArcaneObliterationFades:Countdown(4.7)
	end
	specWarnArcaneObliteration:Show(self.vb.obliterationCount)
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

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.overwhelmingPowerCount = 0
	self.vb.obliterationCount = 0
	self.vb.silencingTempestCount = 0
	self.vb.arcaneExpulsionCount = 0
	self.vb.invokeCollectorCount = 0
	self.vb.voidHarvestCount = 0
	self.vb.deaththroesCount = 0
	if self:IsMythic() then
		savedDifficulty = "mythic"
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
	berserkTimer:Start(600-delay)
	if self.Options.NPAuraOnMarkofPower then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.NPAuraOnMarkofPower then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
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
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.overwhelmingPowerCount+1)
		if timer then
			timerOverwhelmingPowerCD:Start(timer, self.vb.overwhelmingPowerCount+1)
		end
	elseif spellId == 1228216 then
		self.vb.obliterationCount = self.vb.obliterationCount + 1
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.obliterationCount+1)
		if timer then
			timerArcaneObliterationCD:Start(timer, self.vb.obliterationCount+1)
		end
		--Delayed so it doesn't grab invalid target since boss might be looking at previous target on first frame
		self:Schedule(0.3, delayedTankCheck, self)
	elseif spellId == 1228161 then
		self.vb.silencingTempestCount = self.vb.silencingTempestCount + 1
		specWarnSilencingTempest:Show(self.vb.silencingTempestCount)
		specWarnSilencingTempest:Play("watchstep")
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.silencingTempestCount+1)
		if timer then
			timerSilencingTempestCD:Start(timer, self.vb.silencingTempestCount+1)
		end
	elseif spellId == 1227631 then
		self.vb.arcaneExpulsionCount = self.vb.arcaneExpulsionCount + 1
		specWarnArcaneExpulsion:Show(self.vb.arcaneExpulsionCount)
		specWarnArcaneExpulsion:Play("carefly")
		--local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.arcaneExpulsionCount+1)
		--if timer then
		--	timerArcaneExpulsionCD:Start(timer, self.vb.arcaneExpulsionCount+1)
		--end
	elseif spellId == 1231720 then
		self.vb.invokeCollectorCount = self.vb.invokeCollectorCount + 1
		specWarnInvokeCollector:Show(self.vb.invokeCollectorCount)
		specWarnInvokeCollector:Play("killmob")
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.invokeCollectorCount+1)
		if timer then
			timerInvokeCollectorCD:Start(timer, self.vb.invokeCollectorCount+1)
		end
	elseif spellId == 1234328 and self:AntiSpam(3, 1) then--antispam cause add count unknown
		specWarnPhotonBlast:Show()
		specWarnPhotonBlast:Play("frontal")
	elseif spellId == 1232221 then--Deaththroes
		self.vb.deaththroesCount = self.vb.deaththroesCount + 1
		specWarnDeaththroes:Show(self.vb.deaththroesCount)
		specWarnDeaththroes:Play("specialsoon")
		timerDeaththroesCD:Start()--TEMP til mythic table created
	elseif spellId == 1243887 then
		self.vb.voidHarvestCount = self.vb.voidHarvestCount + 1
		timerVoidHarvestCD:Start(nil, self.vb.voidHarvestCount+1)
	elseif spellId == 1230529 then--Mana Sacrifice
		self:SetStage(0.5)--Increases to stage 2 and stage 3
		--Reset Counts
		self.vb.overwhelmingPowerCount = 0
		self.vb.obliterationCount = 0
		self.vb.silencingTempestCount = 0
		self.vb.invokeCollectorCount = 0
		self.vb.voidHarvestCount = 0
		self.vb.deaththroesCount = 0
		--Start all timers
		if self:GetStage(2) then
			timerOverwhelmingPowerCD:Start(allTimers[savedDifficulty][2][1228502][1], 1)
			timerArcaneObliterationCD:Start(allTimers[savedDifficulty][2][1228216][1], 1)
			timerSilencingTempestCD:Start(allTimers[savedDifficulty][2][1228161][1], 1)
			timerArcaneExpulsionCD:Start(allTimers[savedDifficulty][2][1227631][1], 2)--Only count not resetting since it's timer for actual phase changes
			timerInvokeCollectorCD:Start(allTimers[savedDifficulty][2][1231720][1], 1)
		else--Stage 3
			warnPhase2:Show()
			warnPhase2:Play("ptwo")
			timerOverwhelmingPowerCD:Start(allTimers[savedDifficulty][3][1228502][1], 1)
			timerSilencingTempestCD:Start(allTimers[savedDifficulty][3][1228161][1], 1)
			timerVoidHarvestCD:Start(allTimers[savedDifficulty][3][1243887][1], 1)
			if self:IsMythic() then
				timerDeaththroesCD:Start(2)
			end
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 1230231 then--Phase Transition P1 -> P2
		self:SetStage(0.5)--Increases to stage 1.5 and 2.5
		--Stop all timers
		timerOverwhelmingPowerCD:Stop()
		timerArcaneObliterationCD:Stop()
		timerSilencingTempestCD:Stop()
		timerArcaneExpulsionCD:Stop()
		timerInvokeCollectorCD:Stop()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 1228506 then
		local amount = args.amount or 1
		if amount >= 10 then--placeholder
			if args:IsPlayer() then
				specWarnOverwhelmingPower:Show(amount)
				specWarnOverwhelmingPower:Play("stackhigh")
			else
				if not UnitIsDeadOrGhost("player") then
					specWarnOverwhelmingPowerTaunt:Show(args.destName)
					specWarnOverwhelmingPowerTaunt:Play("tauntboss")
				end
			end
		else
			warnOverwhelmingPower:Show(args.destName, amount)
		end
	elseif spellId == 1228454 then
		if self.Options.NPAuraOnMarkofPower then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 1228188 and args:IsPlayer() then
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
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 1228454 then
		if self.Options.NPAuraOnMarkofPower then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 1233979 then
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
	if cid == 241923 then--Arcane Echo

	elseif cid == 241832 then--Shielded Attendant

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

--[[
--Backup if using second sacrifice isn't accurate, but so far it seems to be
function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, spellId)
	if spellId == 1233072 then--Phase Transition P2 -> P3
		self:SetStage(3)
		warnPhase2:Show()
		warnPhase2:Play("ptwo")
		self.vb.overwhelmingPowerCount = 0
		self.vb.voidHarvestCount = 0
		self.vb.silencingTempestCount = 0
		self.vb.deaththroesCount = 0
		--Start p2 timers
		timerOverwhelmingPowerCD:Start(2)
		timerSilencingTempestCD:Start(2)
		timerVoidHarvestCD:Start(2)
		if self:IsMythic() then
			timerDeaththroesCD:Start(2)
		end
	end
end
--]]
