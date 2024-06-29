local mod	= DBM:NewMod(2608, "DBM-Raids-WarWithin", 1, 1273)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(217489, 217491)--Anub'arash, Skeinspinner Takazj
mod:SetEncounterID(2921)
--mod:SetUsedIcons(1, 2, 3)
mod:SetBossHPInfoToHighest()
mod:SetHotfixNoticeRev(20240628000000)
mod:SetMinSyncRevision(20240628000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 438218 438801 440246 440504 438343 439838 450045 451016 438677 452231 441626 450129 441782 450483 438355 443068 451327 442994",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 455849 455850 438218 455080 449857 440001 450980 438708 456252 450728 451277 443598",--451611, 440503
	"SPELL_AURA_APPLIED_DOSE 438218",
	"SPELL_AURA_REMOVED 455080 450980 451277 440001"--451611, 440503
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2"
)

--TODO, target scan charge? ALsos tooltip unclear, should a player soak it to avoid him hitting a wall or is that purely about aiming charge nots soaking?
--TODO, add https://www.wowhead.com/beta/spell=438200/poison-bolt if it's not spammed. Right now I don't want to add it in case it's something boss just does in instead of melee
--TODO, binding webs multi target alerts to alert who you are bound to once it's clear how it's presented in combat log (if it's presented)
--TODO, stinging swarm seems to have two versions, complex one that reequires dispeling near other boss to interrupt it, and one that's just ordinary debuff (probably LFR version)
--TODO, if stringing swarm doesn't go private aura, add icons and icon based yells for dispel assignments. Not gonna waste time doing it now though when this fight hasn't had PA flagging done yet
--TODO, add https://www.wowhead.com/beta/spell=441775/void-blast if it's not spammed, similar boat to poison bolt
--TODO, maybe Entropic should be a run away warning instead for melee?
--TODO, lots of cleanup of boss mechanics that interrupt other boss mechanics with better clarity and voices
--TODO, change option keys to match BW for weak aura compatability before live
--NOTE, https://www.wowhead.com/beta/spell=440503/impaling-eruption was not exposed, re-add of that changes
--[[
(ability.id = 438218 or ability.id = 438801 or ability.id = 440246 or ability.id = 440504 or ability.id = 438343 or ability.id = 439838 or ability.id = 450045 or ability.id = 451016 or ability.id = 438677 or ability.id = 452231 or ability.id = 441626 or ability.id = 450129 or ability.id = 441782 or ability.id = 450483 or ability.id = 438355 or ability.id = 443068 or ability.id = 451327 or ability.id = 442994) and type = "begincast"
 or (ability.id = 451277 or ability.id = 450980) and (type = "applybuff" or type = "removebuff")
--]]
local anubarash, takazj = DBM:EJ_GetSectionInfo(29012), DBM:EJ_GetSectionInfo(29017)
--General Stuff
local specWarnMarkofParanoia					= mod:NewSpecialWarningYou(455849, nil, nil, nil, 1, 17, 4)
local specWarnMarkofRage						= mod:NewSpecialWarningYou(455850, nil, nil, nil, 1, 17, 4)

mod:AddInfoFrameOption(nil, true)--Absorb shield infoframe
--Stage One: Clash of Rivals
mod:AddTimerLine(DBM:EJ_GetSectionInfo(29011))
----Anub'arash
mod:AddTimerLine(anubarash)
local warnPiercingStrike						= mod:NewStackAnnounce(438218, 2)
local warnCalloftheSwarm						= mod:NewCountAnnounce(438801, 2)
local warnImpaled								= mod:NewTargetNoFilterAnnounce(449857, 4)

local specWarnPiercingStrike					= mod:NewSpecialWarningDefensive(438218, nil, nil, nil, 1, 2)
local specWarnRecklessCharge					= mod:NewSpecialWarningCount(440246, nil, nil, nil, 1, 2)--If we can get target, make dodge warning for non target and "move to web" for target
local specWarnImpalingEruption					= mod:NewSpecialWarningDodgeCount(440504, nil, nil, nil, 2, 2)
local yellImpaled								= mod:NewShortYell(449857, nil, false)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(421532, nil, nil, nil, 1, 8)

local timerPiercingStrikeCD						= mod:NewCDCountTimer(49, 438218, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerCalloftheSwarmCD						= mod:NewCDCountTimer(49, 438801, nil, nil, nil, 1)
local timerRecklessChargeCD						= mod:NewCDCountTimer(49, 440246, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerImpalingEruptionCD					= mod:NewCDCountTimer(49, 440504, nil, nil, nil, 3)

mod:AddNamePlateOption("NPAuraOnPerseverance", 455080, true)
--mod:AddInfoFrameOption(407919, true)
--mod:AddSetIconOption("SetIconOnSinSeeker", 335114, true, 0, {1, 2, 3})
--mod:AddPrivateAuraSoundOption(426010, true, 425885, 4)
----Skeinspinner Takazj
mod:AddTimerLine(takazj)
local warnVenomousRain						= mod:NewCountAnnounce(438343, 2)
local warnWebBomb							= mod:NewCountAnnounce(439838, 3)--General announce for everyone, personal special announce to target
local warnSkitteringLeap					= mod:NewCountAnnounce(450045, 2)
local warnBindingWeb						= mod:NewFadesAnnounce(440001, 1)

--local specWarnWebBomb						= mod:NewSpecialWarningYou(439838, nil, nil, nil, 1, 2)--Not exposed
--local yellWebBomb							= mod:NewShortYell(439838)
--local yellWebBombFades						= mod:NewShortFadesYell(439838)
local specWarnBindingWebs					= mod:NewSpecialWarningYou(440001, nil, nil, nil, 1, 2)

local timerVenomousRainCD					= mod:NewCDCountTimer(49, 438343, nil, nil, nil, 3)
local timerWebBombCD						= mod:NewCDCountTimer(49, 439838, nil, nil, nil, 3)
local timerSkitteringLeapCD					= mod:NewCDCountTimer(49, 450045, nil, nil, nil, 3)
local timerVoidAscensionCD					= mod:NewIntermissionCountTimer(100, 450483, nil, nil, nil, 6)
--Stage Two: Grasp of the Void
mod:AddTimerLine(DBM:EJ_GetSectionInfo(29021))
----Anub'arash
mod:AddTimerLine(anubarash)
local warnStingingSwarm						= mod:NewTargetNoFilterAnnounce(450045, 2)--No Filter because this is a raid wiping mechanic if the 3 players don't get to boss

local specWarnStingingSwarm					= mod:NewSpecialWarningMoveTo(438677, nil, nil, nil, 1, 2)
local yellStingingSwarm						= mod:NewShortYell(438677)

local timerStingingSwarmCD					= mod:NewCDCountTimer(49, 438677, nil, nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)
local timerRagingFuryIntermissionCD			= mod:NewIntermissionCountTimer(100, 451327, nil, nil, nil, 6)
----Skeinspinner Takazj
mod:AddTimerLine(takazj)
local warnVoidStep							= mod:NewCountAnnounce(450483, 2)
local warnEntropicDesolation				= mod:NewCastAnnounce(450129, 4)

local specWarnWebVortex						= mod:NewSpecialWarningCount(441626, nil, nil, nil, 2, 12)
--local specWarnEntropicDesolation			= mod:NewSpecialWarningRun(450129, nil, nil, nil, 4, 2)
local specWarnStrandsofReality				= mod:NewSpecialWarningDodgeCount(441782, nil, nil, nil, 2, 2)
local specWarnCataclysmicEntropy			= mod:NewSpecialWarningCount(438355, nil, nil, nil, 2, 2)

local timerWebVortexCD						= mod:NewCDCountTimer(49, 441626, nil, nil, nil, 2)
local timerEntropicDesolationCD				= mod:NewCDCountTimer(49, 450129, nil, nil, nil, 2)
local timerStrandsofRealityCD				= mod:NewCDCountTimer(49, 441782, nil, nil, nil, 3)
local timerVoidStepCD						= mod:NewCDCountTimer(49, 450483, nil, nil, nil, 3)
local timerCataclysmicEntropyCD				= mod:NewCDCountTimer(49, 438355, nil, nil, nil, 5, nil, DBM_COMMON_L.DEADLY_ICON)
--Stage Three: Unleashed Rage
mod:AddTimerLine(DBM:EJ_GetSectionInfo(29022))
local specWarnEnragedFerocity				= mod:NewSpecialWarningDispel(443598, "RemoveEnrage", nil, nil, 1, 2)
----Anub'arash
mod:AddTimerLine(anubarash)
local specWarnUnleashedSwarm				= mod:NewSpecialWarningCount(442994, nil, nil, nil, 2, 2)
local specWarnSpikeEruption					= mod:NewSpecialWarningDodgeCount(443068, nil, nil, nil, 2, 2)

local timerSpikeEruptionCD					= mod:NewCDCountTimer(49, 443068, nil, nil, nil, 3)
local timerUnleashedSwarmCD					= mod:NewCDCountTimer(49, 442994, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
--local timerRagingFuryCD					= mod:NewCDCountTimer(49, 451327, nil, nil, nil, 5, nil, DBM_COMMON_L.ENRAGE_ICON)

mod.vb.piercingCount = 0
mod.vb.swarmCount = 0--Call of the Swarm and Unleashed Swarm
mod.vb.chargeCount = 0
mod.vb.eruptionCount = 0--Impaling Eruption & Spike Eruption
mod.vb.rainCount = 0--Venomous Rain & Entropic Desolation
mod.vb.webBombCount = 0--Web Bomb & Web Vortex
mod.vb.leapCount = 0--Skittering Leap & Void Step
mod.vb.stingingCount = 0
mod.vb.strandsCount = 0
mod.vb.cataCount = 0
--mod.vb.rageCount = 0--Only cast once?

local savedDifficulty = "heroic"
local allTimers = {
	["normal"] = {
		[1] = {
			-- Piercing Strike
			[438218] = {18, 19.9, 20, 22.9, 38.0},
			-- Call of the Swarm
			[438801] = {13.1, 64.8},
			-- Reckless Charge
			[440246] = {43.9, 59.9},
			-- Impaling Eruption
			[440504] = {30, 32.9, 31.0},
			-- Venomous Rain
			[438343] = {7.7, 31.7, 30.2, 31.8},
			-- Web Bomb
			[439838] = {24.3, 33.2, 33.3},
			-- Skittering Leap
			[450045] = {17, 31.5, 28.7, 30.3},
		},
		[2] = {
			-- Call of the Swarm
			[438801] = {26.0, 51},
			-- Piercing Strike
			[438218] = {14.0, 20, 20, 20, 20, 20},
			-- Impaling Eruption
			[440504] = {9, 39.9, 40.0},
			-- Stinging Swarm
			[438677] = {46.0, 49.9},
			-- Web Vortex
			[441626] = {32.2, 49.7},--Sometimes boss skips 2nd cast then 3rd cast 73.4 after 1st cast
			-- Entropic Desolation
			[450129] = {35.0, 49.7},--Sometimes boss skips 2nd cast then 3rd cast 73.4 after 1st cast
			-- Strands of Reality
			[441782] = {18.1, 75.3},
			-- Void Step
			[450483] = {27.1, 26.7, 25.2, 23.4},
			-- Cataclysmic Entropy
			[438355] = {56.9, 48.6},
		},
		[3] = {
			-- Piercing Strike
			[438218] = {25.0, 23.0, 40, 22.9, 56.0, 20},
			-- Reckless Charge
			[440246] = {58.8, 75},
			-- Stinging Swarm
			[438677] = {75.0, 100.0},
			-- Web Vortex
			[441626] = {42.3, 73.8},
			-- Entropic Desolation
			[450129] = {45.1, 73.8},
			-- Strands of Reality
			[441782] = {26.3, 153.8},
			-- Void Step
			[450483] = {37.3, 26.6, 23.3, 25.9, 24.6, 25.2, 24.0},
			-- Cataclysmic Entropy
			[438355] = {90.1, 100.1},
			-- Spike Eruption
			[443068] = {45.0, 62.9, 63.0},
			-- Unleashed Swarm
			[442994] = {30.0, 118.9},
		}
	},
	["heroic"] = {
		[1] = {
			-- Piercing Strike
			[438218] = {15.1, 19.9, 27.0, 19.0},
			-- Call of the Swarm
			[438801] = {18.0, 65.0},
			-- Reckless Charge
			[440246] = {43.3, 59.5},
			-- Impaling Eruption
			[440504] = {21.1, 35.9, 30.0, 31.0},
			-- Venomous Rain
			[438343] = {7.7, 31.2, 31.7, 28.6},
			-- Web Bomb
			[439838] = {25.0, 36.2},
			-- Skittering Leap
			[450045] = {15.6, 30.9, 30.1, 15.0, 15.0},
		},
		[2] = {
			-- Call of the Swarm
			[438801] = {31.0, 37.0},
			-- Piercing Strike
			[438218] = {14.1, 20.0, 20.0, 20.0, 20.0},
			-- Impaling Eruption
			[440504] = {9.0, 40.0, 40.0},
			-- Stinging Swarm
			[438677] = {39.0, 37.0},
			-- Web Vortex
			[441626] = {32.2, 37.2, 36.2},--Sometimes boss skips 2nd cast then 3rd cast 73.4 after 1st cast
			-- Entropic Desolation
			[450129] = {35.0, 37.2, 36.2},--Sometimes boss skips 2nd cast then 3rd cast 73.4 after 1st cast
			-- Strands of Reality
			[441782] = {14.2, 33.2, 34.1},
			-- Void Step
			[450483] = {27.2, 25.2, 26.1, 24.2},
			-- Cataclysmic Entropy
			[438355] = {55.4, 59.4},
		},
		[3] = {
			-- Piercing Strike
			[438218] = {25.0, 20.0, 30.0, 21.0, 20.0, 20.0, 20.0},
			-- Reckless Charge
			[440246] = {59.0, 108.8},
			-- Stinging Swarm
			[438677] = {93.0, 69.0},
			-- Web Vortex
			[441626] = {42.4, 99.8},
			-- Entropic Desolation
			[450129] = {45.2, 99.8},
			-- Strands of Reality
			[441782] = {28.4, 64.5, 56.4},
			-- Void Step
			[450483] = {37.4, 50.4, 24.3, 25.1, 25.2, 9.1, 13.1, 3.0},
			-- Cataclysmic Entropy
			[438355] = {115.1, 75.5},
			-- Spike Eruption
			[443068] = {20.0, 111.0},
			-- Unleashed Swarm
			[442994] = {30.0, 89.0},
		}
	}
}

local function checkSkippedWebVortex(self)
	self.vb.webBombCount = self.vb.webBombCount + 1
	local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 441626, self.vb.webBombCount+1)
	if timer then
		timerWebVortexCD:Start(timer-8, self.vb.webBombCount+1)
		self:Schedule(timer, checkSkippedWebVortex, self)
	end
	DBM:Debug("checkSkippedWebVortex fired", 2)
end

local function checkSkippedEntropicDesolation(self)
	self.vb.rainCount = self.vb.rainCount + 1
	local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 450129, self.vb.rainCount+1)
	if timer then
		timerEntropicDesolationCD:Start(timer-8, self.vb.rainCount+1)
		self:Schedule(timer, checkSkippedEntropicDesolation, self)
	end
	DBM:Debug("checkSkippedEntropicDesolation fired", 2)
end

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.piercingCount = 0
	self.vb.swarmCount = 0
	self.vb.chargeCount = 0
	self.vb.eruptionCount = 0
	self.vb.rainCount = 0
	self.vb.webBombCount = 0
	self.vb.leapCount = 0
	self.vb.stingingCount = 0
	self.vb.strandsCount = 0
	self.vb.cataCount = 0
	--self.vb.rageCount = 0
	if self:IsMythic() then
		savedDifficulty = "heroic"--TEMP?
	elseif self:IsHeroic() then
		savedDifficulty = "heroic"
	else--Combine LFR and Normal
		savedDifficulty = "normal"
	end
	--Anub
	timerPiercingStrikeCD:Start(allTimers[savedDifficulty][1][438218][1]-delay, 1)--15.1
	timerCalloftheSwarmCD:Start(allTimers[savedDifficulty][1][438801][1]-delay, 1)--18.0
	timerImpalingEruptionCD:Start(allTimers[savedDifficulty][1][440504][1]-delay, 1)--21.1
	timerRecklessChargeCD:Start(allTimers[savedDifficulty][1][440246][1]-delay, 1)--43.3
	--Takazj
	timerVenomousRainCD:Start(allTimers[savedDifficulty][1][438343][1]-delay, 1)--7.7
	timerSkitteringLeapCD:Start(allTimers[savedDifficulty][1][450045][1]-delay, 1)--15.6
	timerWebBombCD:Start(allTimers[savedDifficulty][1][439838][1]-delay, 1)--25.0
	timerVoidAscensionCD:Start(self:IsEasy() and 131 or 126.6, 1.5)
	if self.Options.NPAuraOnPerseverance then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.NPAuraOnPerseverance then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:OnTimerRecovery()
	if self:IsMythic() then
		savedDifficulty = "heroic"--TEMP?
	elseif self:IsHeroic() then
		savedDifficulty = "heroic"
	else--Combine LFR and Normal
		savedDifficulty = "normal"
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 438218 then
		self.vb.piercingCount = self.vb.piercingCount + 1
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 438218, self.vb.piercingCount+1)
		if timer then
			timerPiercingStrikeCD:Start(timer, self.vb.piercingCount+1)
		end
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnPiercingStrike:Show()
			specWarnPiercingStrike:Play("defensive")
		end
	elseif spellId == 438801 then
		self.vb.swarmCount = self.vb.swarmCount + 1
		warnCalloftheSwarm:Show(self.vb.swarmCount)
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 438801, self.vb.swarmCount+1)
		if timer then
			timerCalloftheSwarmCD:Start(timer, self.vb.swarmCount+1)
		end
	elseif spellId == 440246 then
		self.vb.chargeCount = self.vb.chargeCount + 1
		specWarnRecklessCharge:Show(self.vb.chargeCount)
		specWarnRecklessCharge:Play("chargemove")
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 440246, self.vb.chargeCount+1)
		if timer then
			timerRecklessChargeCD:Start(timer, self.vb.chargeCount+1)
		end
	elseif spellId == 440504 then
		self.vb.eruptionCount = self.vb.eruptionCount + 1
		specWarnImpalingEruption:Show(self.vb.eruptionCount)
		specWarnImpalingEruption:Play("watchfeet")
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 440504, self.vb.eruptionCount+1)
		if timer then
			timerImpalingEruptionCD:Start(timer, self.vb.eruptionCount+1)
		end
	elseif spellId == 438343 then
		self.vb.rainCount = self.vb.rainCount + 1
		warnVenomousRain:Show(self.vb.rainCount)
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 438343, self.vb.rainCount+1)
		if timer then
			timerVenomousRainCD:Start(timer, self.vb.rainCount+1)
		end
	elseif spellId == 439838 then
		self.vb.webBombCount = self.vb.webBombCount + 1
		warnWebBomb:Show(self.vb.webBombCount)
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 439838, self.vb.webBombCount+1)
		if timer then
			timerWebBombCD:Start(timer, self.vb.webBombCount+1)
		end
	elseif spellId == 450045 then
		self.vb.leapCount = self.vb.leapCount + 1
		warnSkitteringLeap:Show(self.vb.leapCount)
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 450045, self.vb.leapCount+1)
		if timer then
			timerSkitteringLeapCD:Start(timer, self.vb.leapCount+1)
		end
	elseif spellId == 451016 and self:GetStage(1) then--Shatter Existence
		self:SetStage(1.5)
		self:Unschedule(checkSkippedWebVortex)
		self:Unschedule(checkSkippedEntropicDesolation)
		--We manually stop timers Mostly in case phases can push early with higher dps checks in future
		--Anub
		timerRecklessChargeCD:Stop()
		timerPiercingStrikeCD:Stop()
		timerCalloftheSwarmCD:Stop()
		timerImpalingEruptionCD:Stop()
		--Takazj
		timerVenomousRainCD:Stop()
		timerWebBombCD:Stop()
		timerSkitteringLeapCD:Stop()
	elseif spellId == 438677 or spellId == 452231 then--Hard difficulty, and second ID LFR assumed
		self.vb.stingingCount = self.vb.stingingCount + 1
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 438677, self.vb.stingingCount+1)
		if timer then
			timerStingingSwarmCD:Start(timer, self.vb.stingingCount+1)
		end
	elseif spellId == 441626 then
		self:Unschedule(checkSkippedWebVortex)
		self.vb.webBombCount = self.vb.webBombCount + 1
		specWarnWebVortex:Show(self.vb.webBombCount)
		specWarnWebVortex:Play("pullin")
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 441626, self.vb.webBombCount+1)
		if timer then
			timerWebVortexCD:Start(timer, self.vb.webBombCount+1)
			self:Schedule(timer+8, checkSkippedWebVortex, self)
		end
	elseif spellId == 450129 then
		self:Unschedule(checkSkippedEntropicDesolation)
		self.vb.rainCount = self.vb.rainCount + 1
		warnEntropicDesolation:Show()
--		specWarnEntropicDesolation:Show(self.vb.rainCount)
--		specWarnEntropicDesolation:Play("runout")
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 450129, self.vb.rainCount+1)
		if timer then
			timerEntropicDesolationCD:Start(timer, self.vb.rainCount+1)
			self:Schedule(timer+8, checkSkippedEntropicDesolation, self)
		end
	elseif spellId == 441782 then
		self.vb.strandsCount = self.vb.strandsCount + 1
		specWarnStrandsofReality:Show(self.vb.strandsCount)
		specWarnStrandsofReality:Play("shockwave")
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 441782, self.vb.strandsCount+1)
		if timer then
			timerStrandsofRealityCD:Start(timer, self.vb.strandsCount+1)
		end
	elseif spellId == 450483 then
		--"<128.45 21:38:32> [CLEU] SPELL_CAST_START#Creature-0-2085-2657-20809-217491-00007DBEE3#Skeinspinner Takazj(62.2%-0.0%)##nil#450483#Void Step#nil#nil",
		--"<131.92 21:38:36> [CLEU] SPELL_AURA_APPLIED#Creature-0-2085-2657-20809-217491-00007DBEE3#Skeinspinner Takazj#Creature-0-2085-2657-20809-217491-00007DBEE3#Skeinspinner Takazj#450980#Shatter Existence#BUFF#269896768",
		--Early phasing since boss does a void step before casting shatter existence
		if self:GetStage(1) then
			self:SetStage(1.5)
			self:Unschedule(checkSkippedWebVortex)
			self:Unschedule(checkSkippedEntropicDesolation)
			--We manually stop timers Mostly in case phases can push early with higher dps checks in future
			--Anub
			timerRecklessChargeCD:Stop()
			timerPiercingStrikeCD:Stop()
			timerCalloftheSwarmCD:Stop()
			timerImpalingEruptionCD:Stop()
			--Takazj
			timerVenomousRainCD:Stop()
			timerWebBombCD:Stop()
			timerSkitteringLeapCD:Stop()
		else
			self.vb.leapCount = self.vb.leapCount + 1
			warnVoidStep:Show(self.vb.leapCount)
			local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 450483, self.vb.leapCount+1)
			if timer then
				timerVoidStepCD:Start(timer, self.vb.leapCount+1)
			end
		end
	elseif spellId == 438355 then
		self.vb.cataCount = self.vb.cataCount + 1
		specWarnCataclysmicEntropy:Show(self.vb.cataCount)
		specWarnCataclysmicEntropy:Play("specialsoon")--Maybe custom sound?
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 438355, self.vb.cataCount+1)
		if timer then
			timerCataclysmicEntropyCD:Start(timer, self.vb.cataCount+1)
		end
	elseif spellId == 443068 then
		self.vb.eruptionCount = self.vb.eruptionCount + 1
		specWarnSpikeEruption:Show(self.vb.eruptionCount)
		specWarnSpikeEruption:Play("watchstep")
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 443068, self.vb.eruptionCount+1)
		if timer then
			timerSpikeEruptionCD:Start(timer, self.vb.eruptionCount+1)
		end
	elseif spellId == 451327 and self:GetStage(3) then--Raging Fury
		if self:GetStage(2) then
			self:SetStage(2.5)
			self:Unschedule(checkSkippedWebVortex)
			self:Unschedule(checkSkippedEntropicDesolation)
			--We manually stop timers Mostly in case phases can push early with higher dps checks in future
			--Anub
			timerPiercingStrikeCD:Stop()
			timerCalloftheSwarmCD:Stop()
			timerImpalingEruptionCD:Stop()
			timerStingingSwarmCD:Stop()
			--Takazj
			timerWebVortexCD:Stop()
			timerEntropicDesolationCD:Stop()
			timerStrandsofRealityCD:Stop()
			timerVoidStepCD:Stop()
			timerCataclysmicEntropyCD:Stop()
		--else
			--self.vb.rageCount = self.vb.rageCount + 1
			--timerRagingFuryCD:Start()
		end
	elseif spellId == 442994 then
		self.vb.swarmCount = self.vb.swarmCount + 1
		specWarnUnleashedSwarm:Show(self.vb.swarmCount)
		specWarnUnleashedSwarm:Play("aesoon")
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 442994, self.vb.swarmCount+1)
		if timer then
			timerUnleashedSwarmCD:Start(timer, self.vb.swarmCount+1)
		end
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 422277 then

	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 455849 and args:IsPlayer() then
		specWarnMarkofParanoia:Show()
		specWarnMarkofParanoia:Play("paranoiayou")
	elseif spellId == 455850 and args:IsPlayer() then
		specWarnMarkofRage:Show()
		specWarnMarkofRage:Play("rageyou")
	elseif spellId == 438218 then
		warnPiercingStrike:Show(args.destName, args.amount or 1)
	elseif spellId == 455080 then
		if self.Options.NPAuraOnPerseverance then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 449857 then
		warnImpaled:CombinedShow(1.5, args.destName)--Collects impaled targets over 1.5 seconds to reduce spam from bad dodging
		if args:IsPlayer() then
			yellImpaled:Yell()
		end
--	elseif spellId == 451611 then
--		if args:IsPlayer() then
--			specWarnWebBomb:Show()
--			specWarnWebBomb:Play("bombyou")
--			yellWebBomb:Yell()
--			yellWebBombFades:Countdown(spellId)
--		end
	elseif spellId == 440001 then
		if args:IsPlayer() and self:AntiSpam(3, 1) then
			specWarnBindingWebs:Show()
			specWarnBindingWebs:Play("lineapart")--Maybe use a diff sound during charge like "block charge"?
		end
	elseif spellId == 450980 then--Shatter Existence Absorb
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(args.spellName)
			local uId = DBM:GetUnitIdFromGUID(args.destGUID, true)
			DBM.InfoFrame:Show(2, "enemyabsorb", nil, args.amount, uId)
		end
	elseif spellId == 451277 and self:GetStage(2) then--Spike Storm Absorb
		self:SetStage(2.5)
		self:Unschedule(checkSkippedWebVortex)
		self:Unschedule(checkSkippedEntropicDesolation)
		--Anub
		timerPiercingStrikeCD:Stop()
		timerCalloftheSwarmCD:Stop()
		timerImpalingEruptionCD:Stop()
		timerStingingSwarmCD:Stop()
		--Takazj
		timerWebVortexCD:Stop()
		timerEntropicDesolationCD:Stop()
		timerStrandsofRealityCD:Stop()
		timerVoidStepCD:Stop()
		timerCataclysmicEntropyCD:Stop()
	elseif spellId == 438708 or spellId == 456252 or spellId == 450728 then--One is unlimited version one is 9 second. I suspect one is initial version and one is jump?
		warnStingingSwarm:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnStingingSwarm:Show(takazj)
			specWarnStingingSwarm:Play("movetoboss")
			yellStingingSwarm:Yell()
		end
	elseif spellId == 443598 then
		specWarnEnragedFerocity:Show(args.destName)
		specWarnEnragedFerocity:Play("enrage")
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 455080 then
		if self.Options.NPAuraOnPerseverance then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
--	elseif spellId == 451611 then
--		if args:IsPlayer() then
--			yellWebBombFades:Cancel()
--		end
	elseif spellId == 440001 then
		if args:IsPlayer() then
			warnBindingWeb:Show()
		end
	elseif spellId == 450980 then--Shatter Existence Absorb
		self:SetStage(2)
		self:Unschedule(checkSkippedWebVortex)
		self:Unschedule(checkSkippedEntropicDesolation)
		self.vb.piercingCount = 0
		self.vb.swarmCount = 0
		self.vb.eruptionCount = 0
		self.vb.rainCount = 0--Also used for Entropic Desolation
		self.vb.webBombCount = 0--Also web vortex
		self.vb.leapCount = 0--Also used for void step
		self.vb.strandsCount = 0
		self.vb.stingingCount = 0
		self.vb.cataCount = 0
		--Anub
		timerImpalingEruptionCD:Start(allTimers[savedDifficulty][2][440504][1], 1)
		timerPiercingStrikeCD:Start(allTimers[savedDifficulty][2][438218][1], 1)
		timerCalloftheSwarmCD:Start(allTimers[savedDifficulty][2][438801][1], 1)
		timerStingingSwarmCD:Start(allTimers[savedDifficulty][2][438677][1], 1)
		--Takazj
		timerStrandsofRealityCD:Start(allTimers[savedDifficulty][2][441782][1], 1)
		timerVoidStepCD:Start(allTimers[savedDifficulty][2][450483][1], 1)
		timerWebVortexCD:Start(allTimers[savedDifficulty][2][441626][1], 1)
		timerEntropicDesolationCD:Start(allTimers[savedDifficulty][2][450129][1], 1)
		timerCataclysmicEntropyCD:Start(allTimers[savedDifficulty][2][438355][1], 1)
		timerRagingFuryIntermissionCD:Start(self:IsEasy() and 128.7 or 132, 2.5)
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	elseif spellId == 451277 then--Spike Storm Absorb
		self:SetStage(3)
		self:Unschedule(checkSkippedWebVortex)
		self:Unschedule(checkSkippedEntropicDesolation)
		self.vb.piercingCount = 0
		self.vb.swarmCount = 0
		self.vb.chargeCount = 0
		self.vb.eruptionCount = 0
		self.vb.rainCount = 0--Also used for Entropic Desolation
		self.vb.webBombCount = 0--Also web vortex
		self.vb.leapCount = 0--Also used for void step
		self.vb.strandsCount = 0
		self.vb.stingingCount = 0
		self.vb.cataCount = 0
		--Anub
		timerSpikeEruptionCD:Start(allTimers[savedDifficulty][3][443068][1], 1)
		timerPiercingStrikeCD:Start(allTimers[savedDifficulty][3][438218][1], 1)
		timerUnleashedSwarmCD:Start(allTimers[savedDifficulty][3][442994][1], 1)
		timerRecklessChargeCD:Start(allTimers[savedDifficulty][3][440246][1], 1)
		timerStingingSwarmCD:Start(allTimers[savedDifficulty][3][438677][1], 1)
		--Takazj
		timerStrandsofRealityCD:Start(allTimers[savedDifficulty][3][441782][1], 1)
		timerVoidStepCD:Start(allTimers[savedDifficulty][3][450483][1], 1)
		timerWebVortexCD:Start(allTimers[savedDifficulty][3][441626][1], 1)
		timerEntropicDesolationCD:Start(allTimers[savedDifficulty][3][450129][1], 1)
		timerCataclysmicEntropyCD:Start(allTimers[savedDifficulty][3][438355][1], 1)
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
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

--[[
--https://www.wowhead.com/beta/npc=218884/shattershell-scarab
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 209800 then--cycle-warden

	end
end
--]]

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 426144 then

	end
end
--]]
