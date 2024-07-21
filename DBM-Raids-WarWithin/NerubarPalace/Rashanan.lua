local mod	= DBM:NewMod(2609, "DBM-Raids-WarWithin", 1, 1273)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(214504)
mod:SetEncounterID(2918)
--mod:SetUsedIcons(1, 2, 3)
mod:SetHotfixNoticeRev(20240720000000)
mod:SetMinSyncRevision(20240720000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 444687 439789 455373 439784 439795 439811 454989 452806 456853 456762",
	"SPELL_AURA_APPLIED 458067",
	"SPELL_AURA_APPLIED_DOSE 458067",
	"SPELL_INTERRUPT"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_SPELLCAST_START boss1"
)

--TODO, maybe auto mark https://www.wowhead.com/beta/spell=434579/corrosion so still assign clears by icon
--TODO, maybe use https://www.wowhead.com/beta/spell=455287/infested-bite to announce or mark infested spawns after the fact for healing?
--TODO, emphasize Enveloping webs cast itself? will probably only have a soon warning for it that's emphasized with a precise timer
--TODO, change option keys to match BW for weak aura compatability before live
--[[
(ability.id = 444687 or ability.id = 439789 or ability.id = 455373 or ability.id = 439784 or ability.id = 439795 or ability.id = 439811 or ability.id = 454989 or ability.id = 452806 or ability.id = 456853 or ability.id = 456841 or ability.id = 456762) and type = "begincast"
 or stoppedability.id = 452806
--]]
local warnSavageWound							= mod:NewStackAnnounce(458067, 2, nil, "Tank|Healer")
local warnRollingAcid							= mod:NewIncomingCountAnnounce(439789, 2)--General announce, private aura sound will be personal emphasis
local warnInfestedSpawn							= mod:NewIncomingCountAnnounce(455373, 2)
local warnSpinneretsStrands						= mod:NewIncomingCountAnnounce(439784, 3)--General announce, private aura sound will be personal emphasis
local warnErosiveSpray							= mod:NewCountAnnounce(439811, 2)
local warnEnvelopingWebs						= mod:NewCountAnnounce(454989, 4, nil, nil, 157317)--Shortname "Webs"
local warnAcidEruption							= mod:NewCastAnnounce(452806, 4)

local specWarnSavageAssault						= mod:NewSpecialWarningDefensive(444687, nil, nil, nil, 1, 2)
local specWarnSavageWoundSwap					= mod:NewSpecialWarningTaunt(458067, nil, nil, nil, 1, 2)
local specWarnWebReave							= mod:NewSpecialWarningCount(439795, nil, nil, nil, 2, 2)
--local yellWebReave							= mod:NewShortYell(439795, DBM_COMMON_L.GROUPSOAK, nil, nil, "YELL")
--local yellSearingAftermathFades				= mod:NewShortFadesYell(422577)
local specWarnAcidEruption						= mod:NewSpecialWarningInterrupt(452806, "HasInterrupt", nil, nil, 1, 2)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(421532, nil, nil, nil, 1, 8)

local timerSavageAssaultCD						= mod:NewCDCountTimer(49, 444687, DBM_COMMON_L.TANKDEBUFF.." (%s)", "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerRollingAcidCD						= mod:NewCDCountTimer(21.3, 439789, nil, nil, nil, 3)
local timerInfestedSpawnCD						= mod:NewCDCountTimer(21.3, 455373, nil, nil, nil, 1)
local timerSpinneretsStrandsCD					= mod:NewCDCountTimer(33.9, 439784, nil, nil, nil, 3)
local timerWebReaveCD							= mod:NewCDCountTimer(49, 439795, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerErosiveSprayCD						= mod:NewCDCountTimer(49, 439811, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerEnvelopingWebsCD						= mod:NewCDCountTimer(49, 454989, 157317, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)--Shortname "Webs"
local timerMovementCD							= mod:NewStageContextCountTimer(49, 334371, nil, nil, nil, 6, 178717)

mod:AddPrivateAuraSoundOption(439790, true, 439789, 1)--Rolling Acid target
mod:AddPrivateAuraSoundOption(455284, true, 455373, 1)--Infested Spawn target
mod:AddPrivateAuraSoundOption(439783, true, 439784, 1)--Spineret's Strands target

mod.vb.movementFinished = false
--Totals used for fight overall
mod.vb.assaultCountTotal = 0
mod.vb.rollingCountTotal = 0
mod.vb.spawnCountTotal = 0
mod.vb.strandsCountTotal = 0
mod.vb.sprayCountTotal = 0
mod.vb.envelopingCountTotal = 0
--Non totals used for phase counts
mod.vb.assaultCount = 0
mod.vb.rollingCount = 0
mod.vb.spawnCount = 0
mod.vb.strandsCount = 0
mod.vb.sprayCount = 0
mod.vb.envelopingCount = 0
--Totals that don't need phase counts
mod.vb.reaveCount = 0
mod.vb.movementCount = 0

local savedDifficulty = "heroic"
local allTimers = {
	["normal"] = {--Complete up to 6:44
		[1] = {
			--Erosive Spray
			[439811] = {3.0, 31.4, 47.0},
			--Infested Spawn
			[455373] = {62.4},
			--Rolling Acid
			[439789] = {43.3},
			--Savage Assault
			[444687] = {10.9, 15.6, 23.5, 7.8, 15.7},
			--Spinneret's Strands
			[439784] = {14.9, 52.9},
		},
		[2] = {
			--Erosive Spray
			[439811] = {35.0, 47.0},
			--Infested Spawn
			[455373] = {41.4},
			--Rolling Acid
			[439789] = {18.3, 52.9},
			--Savage Assault
			[444687] = {3.6, 7.8, 15.7, 23.5, 7.8, 15.7},
			--Spinneret's Strands
			[439784] = {62.4},
		},
		[3] = {
			--Erosive Spray
			[439811] = {35.0, 47.0},
			--Infested Spawn
			[455373] = {15.9, 52.9},
			--Rolling Acid
			[439789] = {65.4},
			--Savage Assault
			[444687] = {3.6, 7.9, 15.7, 23.5, 7.8, 15.7},
			--Spinneret's Strands
			[439784] = {40.9},
		},
		[4] = {
			--Erosive Spray
			[439811] = {35.0},
			--Infested Spawn
			[455373] = {41.4},
			--Rolling Acid
			[439789] = {65.4},
			--Savage Assault
			[444687] = {3.6, 7.8, 15.7, 23.5, 7.8, 15.7},
			--Spinneret's Strands
			[439784] = {15.3, 52.9},
		},
		[5] = {
			--Erosive Spray
			[439811] = {0},
			--Infested Spawn
			[455373] = {0},
			--Rolling Acid
			[439789] = {0},
			--Savage Assault
			[444687] = {0},
			--Spinneret's Strands
			[439784] = {0},
		},
		[6] = {
			--Erosive Spray
			[439811] = {0},
			--Infested Spawn
			[455373] = {0},
			--Rolling Acid
			[439789] = {0},
			--Savage Assault
			[444687] = {0},
			--Spinneret's Strands
			[439784] = {0},
		},
		[7] = {
			--Erosive Spray
			[439811] = {0},
			--Infested Spawn
			[455373] = {0},
			--Rolling Acid
			[439789] = {0},
			--Savage Assault
			[444687] = {0},
			--Spinneret's Strands
			[439784] = {0},
		},
	},
	["heroic"] = {--Complete up to 10:07
		[1] = {
			--Erosive Spray
			[439811] = {3.0, 29.6, 44.4},
			--Infested Spawn
			[455373] = {59.0},
			--Rolling Acid
			[439789] = {41.4},
			--Savage Assault
			[444687] = {10.5, 13.0, 23.0, 6.5, 14.9},
			--Spinneret's Strands
			[439784] = {14.1, 27.1, 20.2},
		},
		[2] = {
			--Erosive Spray
			[439811] = {33.3, 44.4},
			--Infested Spawn
			[455373] = {40.5},
			--Rolling Acid
			[439789] = {16.7, 30.2, 19.6},
			--Savage Assault
			[444687] = {11.0, 14.8, 23.6, 5.9, 14.8, 3.7},
			--Spinneret's Strands
			[439784] = {59.1},
		},
		[3] = {
			--Erosive Spray
			[439811] = {33.3, 44.4},
			--Infested Spawn
			[455373] = {15.2, 29.7, 20.2},
			--Rolling Acid
			[439789] = {61.2},
			--Savage Assault
			[444687] = {11.0, 14.8, 23.7, 5.9, 14.8, 3.5},
			--Spinneret's Strands
			[439784] = {40.0},
		},
		[4] = {
			--Erosive Spray
			[439811] = {33.2, 44.4},
			--Infested Spawn
			[455373] = {40.5},
			--Rolling Acid
			[439789] = {61.2},
			--Savage Assault
			[444687] = {11.0, 14.8, 23.7, 5.9, 14.9, 3.7},
			--Spinneret's Strands
			[439784] = {14.7, 30.3, 19.7},
		},
		[5] = {
			--Erosive Spray
			[439811] = {33.2, 44.4},
			--Infested Spawn
			[455373] = {59.6},
			--Rolling Acid
			[439789] = {16.7, 29.8, 20.2},
			--Savage Assault
			[444687] = {11.0, 14.8, 23.1, 6.5, 14.8, 3.7},
			--Spinneret's Strands
			[439784] = {39.9},
		},
		[6] = {
			--Erosive Spray
			[439811] = {33.2, 44.4},
			--Infested Spawn
			[455373] = {15.2, 29.8, 20.2},
			--Rolling Acid
			[439789] = {42.0},
			--Savage Assault
			[444687] = {11.0, 14.8, 23.8, 5.9, 14.8, 3.7},
			--Spinneret's Strands
			[439784] = {59.1},
		},
		[7] = {
			--Erosive Spray
			[439811] = {0},
			--Infested Spawn
			[455373] = {0},
			--Rolling Acid
			[439789] = {0},
			--Savage Assault
			[444687] = {0},
			--Spinneret's Strands
			[439784] = {0},
		},
	},
	["mythic"] = {--11:00
		[1] = {
			--Erosive Spray
			[439811] = {2.9, 29.6, 44.4},
			--Infested Spawn
			[455373] = {39.8},
			--Rolling Acid
			[439789] = {16.0, 30.3},
			--Savage Assault
			[444687] = {10.3, 14.8, 23.8, 9.0, 11.7},
			--Spinneret's Strands
			[439784] = {19.6, 45.0},
			--Enveloping Webs
			[454989] = {60.1},
		},
		[2] = {
			--Erosive Spray
			[439811] = {33.2, 44.4},
			--Infested Spawn
			[455373] = {20.8, 24.2},
			--Rolling Acid
			[439789] = {61.2},
			--Savage Assault
			[444687] = {11.0, 14.8, 23.7, 5.9, 14.8, 3.7},
			--Spinneret's Strands
			[439784] = {40.0},
			--Enveloping Webs
			[454989] = {14.7, 50.0},
		},
		[3] = {
			--Erosive Spray
			[439811] = {33.2, 44.4},
			--Infested Spawn
			[455373] = {20.8},
			--Rolling Acid
			[439789] = {16.7, 29.7, 14.7},
			--Savage Assault
			[444687] = {11.0, 14.8, 23.1, 6.4, 14.8, 3.7},
			--Spinneret's Strands
			[439784] = {40.0},
			--Enveloping Webs
			[454989] = {64.7},
		},
		[4] = {
			--Erosive Spray
			[439811] = {33.2, 44.4},
			--Infested Spawn
			[455373] = {15.2, 25.2},
			--Rolling Acid
			[439789] = {0},--Not cast on 4th area, bug?
			--Savage Assault
			[444687] = {11.0, 14.8, 23.6, 6.0, 14.8, 3.7},
			--Spinneret's Strands
			[439784] = {20.3, 38.9},
			--Enveloping Webs
			[454989] = {45.0, 19.7},
		},
		[5] = {
			--Erosive Spray
			[439811] = {33.2, 44.4},
			--Infested Spawn
			[455373] = {15.2, 29.7},
			--Rolling Acid
			[439789] = {22.3, 44.4},
			--Savage Assault
			[444687] = {11.0, 14.8, 23.7, 5.9, 14.8, 3.7},
			--Spinneret's Strands
			[439784] = {59.1},
			--Enveloping Webs
			[454989] = {40.0},
		},
		[6] = {
			--Erosive Spray
			[439811] = {33.2, 44.4},
			--Infested Spawn
			[455373] = {20.7},
			--Rolling Acid
			[439789] = {66.7},
			--Savage Assault
			[444687] = {11.0, 14.8, 23.1, 6.5, 14.8, 3.7},
			--Spinneret's Strands
			[439784] = {14.7, 25.3},
			--Enveloping Webs
			[454989] = {44.5, 14.6},
		},
		[7] = {--Not complete
			--Erosive Spray
			[439811] = {33.2, 44.4},--44.4 is assumed
			--Infested Spawn
			[455373] = {0},--Not enough data
			--Rolling Acid
			[439789] = {22.3},--Not enough data
			--Savage Assault
			[444687] = {11.0, 14.8, 23.1, 5.9, 14.8, 3.7},--23 + is assumed
			--Spinneret's Strands
			[439784] = {14.7},--Not enough data
			--Enveloping Webs
			[454989] = {0},--Not enough data
		},
	},
}

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.movementFinished = false
	self.vb.assaultCountTotal = 0
	self.vb.rollingCountTotal = 0
	self.vb.spawnCountTotal = 0
	self.vb.strandsCountTotal = 0
	self.vb.sprayCountTotal = 0
	self.vb.envelopingCountTotal = 0
	self.vb.assaultCount = 0
	self.vb.rollingCount = 0
	self.vb.spawnCount = 0
	self.vb.strandsCount = 0
	self.vb.sprayCount = 0
	self.vb.envelopingCount = 0
	self.vb.reaveCount = 0
	self.vb.movementCount = 0
	if self:IsMythic() then
		savedDifficulty = "mythic"
		timerWebReaveCD:Start(51.1-delay, 1)--Only mythic gets one before first movement, but heroic might now too, need to recheck heroic
		timerEnvelopingWebsCD:Start(60.1-delay, 1)
	elseif self:IsHeroic() then
		savedDifficulty = "heroic"
	else--Combine LFR and Normal
		savedDifficulty = "normal"
	end
	timerSavageAssaultCD:Start(allTimers[savedDifficulty][1][444687][1]-delay, 1)
	timerRollingAcidCD:Start(allTimers[savedDifficulty][1][439789][1]-delay, 1)
	timerInfestedSpawnCD:Start(allTimers[savedDifficulty][1][455373][1]-delay, 1)
	timerSpinneretsStrandsCD:Start(allTimers[savedDifficulty][1][439784][1]-delay, 1)
	timerErosiveSprayCD:Start(allTimers[savedDifficulty][1][439811][1]-delay, 1)
	timerMovementCD:Start(self:IsMythic() and 86.3 or 90, 1)
	self:EnablePrivateAuraSound(439790, "targetyou", 2)--Raid version, (434406 is in dungeon)
	--self:EnablePrivateAuraSound(434406, "targetyou", 2, 439790)--Likely dungeon version of Rolling Acid
	self:EnablePrivateAuraSound(455284, "mobout", 2)--Maybe better sound later, but this one does say "mob out" as in "mob on you, get out and spread" which is the mechanic
	self:EnablePrivateAuraSound(439815, "mobout", 2, 455284)--Secondary ID for Infested Spawn
	self:EnablePrivateAuraSound(439783, "pullin", 12)--Raid version of Spinneret's Strands
--	self:EnablePrivateAuraSound(434090, "pullin", 12, 439783)--Likely the Dungeon version of Spinneret's Strands
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
	if spellId == 444687 then
		self.vb.assaultCountTotal = self.vb.assaultCountTotal + 1
		self.vb.assaultCount = self.vb.assaultCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnSavageAssault:Show()
			specWarnSavageAssault:Play("defensive")
		end
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.assaultCount+1)
		if timer then
			timerSavageAssaultCD:Start(timer, self.vb.assaultCountTotal+1)
		end
	elseif spellId == 439789 then
		self.vb.rollingCountTotal = self.vb.rollingCountTotal + 1
		self.vb.rollingCount = self.vb.rollingCount + 1
		warnRollingAcid:Show(self.vb.rollingCountTotal)
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.rollingCount+1)
		if timer then
			timerRollingAcidCD:Start(timer, self.vb.rollingCountTotal+1)
		end
	elseif spellId == 455373 then
		self.vb.spawnCountTotal = self.vb.spawnCountTotal + 1
		self.vb.spawnCount = self.vb.spawnCount + 1
		warnInfestedSpawn:Show(self.vb.spawnCountTotal)
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.spawnCount+1)
		if timer then
			timerInfestedSpawnCD:Start(timer, self.vb.spawnCountTotal+1)
		end
	elseif spellId == 439784 then
		self.vb.strandsCountTotal = self.vb.strandsCountTotal + 1
		self.vb.strandsCount = self.vb.strandsCount + 1
		warnSpinneretsStrands:Show(self.vb.strandsCountTotal)
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.strandsCount+1)
		if timer then
			timerSpinneretsStrandsCD:Start(timer, self.vb.strandsCountTotal+1)
		end
	elseif spellId == 439795 then
		self.vb.reaveCount = self.vb.reaveCount + 1
		specWarnWebReave:Show(self.vb.reaveCount)
		specWarnWebReave:Play("gathershare")
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.reaveCount+1)
		if timer then
			timerWebReaveCD:Start(timer, self.vb.reaveCount+1)
		end
	elseif spellId == 439811 then
		self.vb.sprayCountTotal = self.vb.sprayCountTotal + 1
		self.vb.sprayCount = self.vb.sprayCount + 1
		warnErosiveSpray:Show(self.vb.sprayCountTotal)
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.sprayCount+1)
		if timer then
			timerErosiveSprayCD:Start(timer, self.vb.sprayCountTotal+1)
		end
	elseif spellId == 454989 then--Mythic
		self.vb.envelopingCountTotal = self.vb.envelopingCountTotal + 1
		self.vb.envelopingCount = self.vb.envelopingCount + 1
		warnEnvelopingWebs:Show(self.vb.envelopingCountTotal)
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.envelopingCount+1)
		if timer then
			timerEnvelopingWebsCD:Start(timer, self.vb.envelopingCountTotal+1)
		end
	elseif spellId == 452806 then
		if self.Options.SpecWarn452806Interrupt and self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnAcidEruption:Show(args.sourceName)
			specWarnAcidEruption:Play("kickcast")
		else
			warnAcidEruption:Show()
		end
	elseif spellId == 456853 then--Inital Rain
		self.vb.movementFinished = false
		self.vb.movementCount = self.vb.movementCount + 1
	elseif spellId == 456762 then--Secondary Rain
		self.vb.movementFinished = true
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 458067 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			if not DBM:UnitDebuff("player", spellId) and not UnitIsDeadOrGhost("player") then
				specWarnSavageWoundSwap:Show(args.destName)
				specWarnSavageWoundSwap:Play("tauntboss")
			else
				warnSavageWound:Show(args.destName, args.amount or 1)
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_INTERRUPT(args)
	if args.extraSpellId == 452806 and self.vb.movementFinished then
		self:SetStage(0)
		self.vb.assaultCount = 0
		self.vb.rollingCount = 0
		self.vb.spawnCount = 0
		self.vb.strandsCount = 0
		self.vb.sprayCount = 0
		self.vb.envelopingCount = 0
		if self:IsHard() then
			timerWebReaveCD:Start(3.6, self.vb.reaveCount+1)
		end
		if self:IsMythic() then
			timerEnvelopingWebsCD:Start(allTimers[savedDifficulty][self.vb.phase][454989][1], self.vb.envelopingCountTotal+1)
		end
		timerSavageAssaultCD:Start(allTimers[savedDifficulty][self.vb.phase][444687][1], self.vb.assaultCountTotal+1)
		timerRollingAcidCD:Start(allTimers[savedDifficulty][self.vb.phase][439789][1], self.vb.rollingCountTotal+1)
		timerInfestedSpawnCD:Start(allTimers[savedDifficulty][self.vb.phase][455373][1], self.vb.spawnCountTotal+1)
		timerSpinneretsStrandsCD:Start(allTimers[savedDifficulty][self.vb.phase][439784][1], self.vb.strandsCountTotal+1)
		timerErosiveSprayCD:Start(allTimers[savedDifficulty][self.vb.phase][439811][1], self.vb.sprayCountTotal+1)
		timerMovementCD:Start(self:IsHard() and (self.vb.movementCount == 5 and 115 or 86.3) or 90.5, self.vb.movementCount+1)--5th movement rule is confirmed on mythic but not on heroic
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 421532 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

--function mod:WebReaveTarget(targetname)
--	if not targetname then return end
--	if targetname == UnitName("player") then
--		yellWebReave:Yell()
--	end
--end

--function mod:UNIT_SPELLCAST_START(uId, _, spellId)
--	if spellId == 439795 then
--		self:BossUnitTargetScanner(uId, "WebReaveTarget")
--	end
--end
