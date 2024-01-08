local mod	= DBM:NewMod(2529, "DBM-Raids-Dragonflight", 2, 1208)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(201774, 201773, 201934)--Krozgoth, Moltannia, Molgoth
mod:SetEncounterID(2687)
mod:SetUsedIcons(1, 2, 3, 4)
mod:SetBossHPInfoToHighest()
mod:SetHotfixNoticeRev(20230626000000)
mod:SetMinSyncRevision(20230626000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 403459 405016 407640 403699 404732 403101 404896 405437 405641 408193 405914 406783 403203 409385",
	"SPELL_CAST_SUCCESS 406730",
	"SPELL_AURA_APPLIED 401809 402617 405036 405394 405642 405914 413597",
	"SPELL_AURA_APPLIED_DOSE 401809 402617 405394",
	"SPELL_AURA_REMOVED 401809 402617 405036 405642",
	"SPELL_PERIODIC_DAMAGE 405084 405645",
	"SPELL_PERIODIC_MISSED 405084 405645"
)

--[[
(ability.id = 409385 or ability.id = 403459 or ability.id = 405016 or ability.id = 407640 or ability.id = 403699 or ability.id = 404732 or ability.id = 403101 or ability.id = 404896 or ability.id = 403203 or ability.id = 405437 or ability.id = 405641 or ability.id = 408193 or ability.id = 405914 or ability.id = 406783) and type = "begincast"
 or (ability.id = 406730 or ability.id = 406780) and type = "cast"
 or (target.id = 201774 or target.id = 201773) and type = "death"
--]]
--TODO, also target scan Swirling Flame?
--TODO, secondary alert for Swirling Shadowflame ?
--TODO, if both tank abilities in P2 are a combo, just use generic tank combo timer
--General
local specWarnGTFO								= mod:NewSpecialWarningGTFO(405084, nil, nil, nil, 1, 8)

mod:AddBoolOption("AdvancedBossFiltering", true, "misc")--May be default to off on live, but for testing purposes it needs to be forced
--Krozgoth
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26336))
local warnCorruptingShadow						= mod:NewCountAnnounce(401809, 2, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(401809))
local warnCorruptingShadowFades					= mod:NewFadesAnnounce(401809, 1)
local warnUmbralDetonation						= mod:NewTargetCountAnnounce(405036, 3, nil, nil, 167180, nil, nil, nil, true)

local specWarnCoalescingVoid					= mod:NewSpecialWarningCount(403459, nil, nil, nil, 2, 2)--Possibly use a run away warning if idea is to actualy move away? Something tells me falloff is just designed to scope damage to players on THIS boss only
local specWarnUmbralDetonation					= mod:NewSpecialWarningYou(405036, nil, 49685, nil, 1, 2)
local yellUmbralDetonation						= mod:NewShortYell(405036, 49685)--"Bomb"
local yellUmbralDetonationFades					= mod:NewShortFadesYell(405036)
local specWarnShadowsConvergence				= mod:NewSpecialWarningDodgeCount(407640, nil, nil, nil, 2, 2, 3)

local timerCoalescingVoidCD						= mod:NewCDCountTimer(21.9, 403459, nil, nil, nil, 2)
local timerUmbralDetonationCD					= mod:NewCDCountTimer(21.9, 405036, 167180, nil, nil, 3)--"Bombs"
local timerShadowsConvergenceCD					= mod:NewCDCountTimer(20.7, 407640, nil, nil, nil, 3, nil, DBM_COMMON_L.HEROIC_ICON)
local timerShadowSpikeCD						= mod:NewCDCountTimer(11, 403699, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--local berserkTimer							= mod:NewBerserkTimer(600)

mod:AddSetIconOption("SetIconOnUmbral", 405036, false, 0, {1, 2, 3})
--Moltannia
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26337))
local warnBlazingHeat							= mod:NewCountAnnounce(402617, 2, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(402617))
local warnBlazingHeatFades						= mod:NewFadesAnnounce(402617, 1)

local specWarnFieryMeteor						= mod:NewSpecialWarningCount(404732, nil, nil, nil, 2, 2)
local specWarnMoltenEruption					= mod:NewSpecialWarningCount(403101, nil, nil, nil, 2, 2, 3)
local specWarnSwirlingFlame						= mod:NewSpecialWarningDodgeCount(404896, nil, 86189, nil, 2, 2)

local timerFieryMeteorCD						= mod:NewCDCountTimer(31.7, 404732, nil, nil, nil, 3)
local timerMoltenEruptionCD						= mod:NewCDCountTimer(22.3, 403101, nil, nil, nil, 5, nil, DBM_COMMON_L.HEROIC_ICON)
local timerSwirlingFlameCD						= mod:NewCDCountTimer(20.7, 404896, 86189, nil, nil, 3)--"Tornados"
local timerFlameSlashCD							= mod:NewCDCountTimer(11, 403203, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--Molgoth
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26338))
local warnPhase2								= mod:NewPhaseAnnounce(2, 2, nil, nil, nil, nil, nil, 2)
local warnShadowandFlame						= mod:NewCastAnnounce(409385, 4)
local warnShadowflame							= mod:NewCountAnnounce(405394, 2, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(405394))
local warnBlisteringTwilight					= mod:NewTargetCountAnnounce(405641, 3, nil, nil, 167180, nil, nil, nil, true)
local warnShadowflameBurst						= mod:NewCountAnnounce(406783, 3)

local specWarnGloomConflag						= mod:NewSpecialWarningCount(405437, nil, nil, nil, 2, 2)
local specWarnBlisteringTwilight				= mod:NewSpecialWarningYou(405642, nil, 49685, nil, 1, 2)
local yellBlisteringTwilight					= mod:NewShortYell(405642, 49685)
local yellBlisteringTwilightFades				= mod:NewShortFadesYell(405642)
local specWarnConvergentEruption				= mod:NewSpecialWarningCount(408193, nil, nil, nil, 2, 2)
local specWarnWitheringVulnerability			= mod:NewSpecialWarningDefensive(405914, nil, nil, nil, 1, 2)
local specWarnWitheringVulnerabilityTaunt		= mod:NewSpecialWarningTaunt(405914, nil, nil, nil, 1, 2)
local yellShadowandFlameRepeat					= mod:NewIconRepeatYell(409385, nil, false, 2)

local timerPhaseCD								= mod:NewPhaseTimer(30)
local timerShadowandFlameCD						= mod:NewCDCountTimer(47.4, 409385, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerGloomConflagCD						= mod:NewCDCountTimer(40, 405437, nil, nil, nil, 3)
local timerBlisteringTwilightCD					= mod:NewCDCountTimer(40, 405642, 167180, nil, nil, 3)--"Bombs"
local timerConvergentEruptionCD					= mod:NewCDCountTimer(40, 408193, nil, nil, nil, 5)
local timerWitheringVulnerabilityCD				= mod:NewCDCountTimer(35.3, 405914, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)--35-40
local timerShadowflameBurstCD					= mod:NewCDCountTimer(35.3, 406783, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)--Might be redundant if always after crushing

mod:AddSetIconOption("SetIconOnBlistering", 405642, false, 0, {1, 2, 3, 4})

local nearKroz, nearMolt = true, true
mod.vb.coalescingCount = 0
mod.vb.umbralCount = 0
mod.vb.umbralIcon = 1
mod.vb.shadowConvergeCount = 0
mod.vb.shadowStrikeCount = 0

mod.vb.meteorCast = 0
mod.vb.swirlingCount = 0
mod.vb.moltenEruptionCast = 0
mod.vb.flameSlashCast = 0

mod.vb.witheringVulnCount = 0
mod.vb.shadowflameBurstCount = 0
mod.vb.SandFCount = 0

local difficultyName = "easy"
local altTimers = {--Table of lowest averages for timers that are at least somewhat consistent
	["hard"] = {
		----Fire Duder
		--Flame Slash
		[403203] = false,--Too variable
		--Swirling Flame
		[404896] = false,--Too variable
		--Fiery Meteor
		[404732] = 35.3,
		--Molten Eruption
		[403101] = 34,
		----Shadow Duder
		--Shadow Spike
		[403699] = false,--Too variable
		--Umbral Detonation
		[405016] = 34.5,
		--Coalescing Void
		[403459] = 35.3,
		--Shadows Convergence
		[407640] = 35.3,
		----Phase 2
		--Shadow and Flame (mythic Only)
		[409385] = 47.3,
		--Gloom Conflag
		[405437] = 47.4,
		--Blistering Twilight
		[405641] = 47.4,
		--Convergent Eruption (Heroic+)
		[408193] = 47.3,
		--Withering Vulnerability
		[405914] = 23.1,
		--Shadowflame Burst
		[406783] = 23.1,
	},
	["easy"] = {
		----Fire Duder
		--Flame Slash
		[403203] = false,--Too variable
		--Swirling Flame
		[404896] = false,--Too variable
		--Fiery Meteor
		[404732] = 35.1,
		--Molten Eruption (Heroic+)
--		[403101] = {},
		----Shadow Duder
		--Shadow Spike
		[403699] = false,--Too variable
		--Umbral Detonation
		[405016] = false,--Too variable
		--Coalescing Void
		[403459] = 35.1,
		--Shadows Convergence (Heroic+)
--		[407640] = {},
		----Phase 2
		--Shadow and Flame (mythic Only)
--		[409385] = {},
		--Gloom Conflag
		[405437] = 44.9,
		--Blistering Twilight
		[405641] = false,--Too variable
		--Convergent Eruption (Heroic+)
--		[408193] = {},
		--Withering Vulnerability
		[405914] = 23.1,
		--Shadowflame Burst
		[406783] = 23.1,
	},
}
local allTimers = {
	["hard"] = {
		----Fire Duder
		--Flame Slash
		[403203] = {7, 15.7, 26.7, 15.3, 19.4, 15.8, 18.2, 15.7, 18.6},
		--Swirling Flame
		[404896] = {10.6, 14.5, 25.8, 14.1, 20.3, 14.6, 18.2, 14.6, 20.7},
		--Fiery Meteor
		[404732] = {35.2, 35.2, 35.3, 35.3},
		--Molten Eruption
		[403101] = {16.7, 40.5, 34.5, 34},
		----Shadow Duder
		--Shadow Spike
		[403699] = {9.5, 15.8, 15.8, 10.1, 15.8, 19.5, 15.7, 19.4, 15.8, 19.4},
		--Umbral Detonation
		[405016] = {14.2, 41.7, 34.5, 35.2},
		--Coalescing Void
		[403459] = {35.2, 35.2, 35.3, 35.3},
		--Shadows Convergence
		[407640] = {22.7, 41.3, 35.3, 35.2},
		----Phase 2
		--Shadow and Flame (mythic Only)
		[409385] = {29.5, 51, 47.4, 47.3, 47.3, 47.3},
		--Gloom Conflag
		[405437] = {50.4, 47.5, 47.6, 47.5, 47.4, 47.4},
		--Blistering Twilight
		[405641] = {21.4, 51.3, 47.5, 47.6, 47.5, 47.4},
		--Convergent Eruption (Heroic+)
		[408193] = {33.6, 51, 47.4, 47.3, 47.5, 47.4},
		--Withering Vulnerability
		[405914] = {16.6, 24.3, 26.8, 24.3, 23.1, 24.2, 23.1, 24.2, 23.1, 24.3, 23.1, 24.3},
		--Shadowflame Burst
		[406783] = {19.4, 24.4, 26.8, 24.3, 23.2, 24.3, 23.2, 24.3, 23.1, 24.3, 23.1, 24.3},
	},
	["easy"] = {
		----Fire Duder
		--Flame Slash
		[403203] = {9.3, 15.7, 25.4, 15.7, 18.3, 15.8, 19.4, 16.2, 19.5, 15.8},
		--Swirling Flame
		[404896] = {10.9, 14.6, 25.5, 14.5, 18.3, 15.8, 19.4, 15.8, 20.4, 15.0},
		--Fiery Meteor
		[404732] = {35.2, 35.1, 35.2, 35.2, 35.4},
		--Molten Eruption (Heroic+)
--		[403101] = {},
		----Shadow Duder
		--Shadow Spike
		[403699] = {9.3, 15.7, 15.7, 10.9, 15.7, 19.5, 16.2, 19.4, 15.8, 19.5, 15.9},
		--Umbral Detonation
		[405016] = {16.6, 21.9, 18.3, 36.9, 34.0, 35.3},
		--Coalescing Void
		[403459] = {35.2, 35.1, 35.3, 35.2, 35.4},
		--Shadows Convergence (Heroic+)
--		[407640] = {},
		----Phase 2
		--Shadow and Flame (mythic Only)
--		[409385] = {},
		--Gloom Conflag
		[405437] = {50.3, 44.9, 45.2, 44.9, 46.2},
		--Blistering Twilight
		[405641] = {20.2, 15.7, 36.4, 15.7, 31.6},
		--Convergent Eruption (Heroic+)
--		[408193] = {},
		--Withering Vulnerability
		[405914] = {15.8, 24.2, 28.1, 24.2, 23.1},
		--Shadowflame Burst
		[406783] = {18.5, 24.2, 28.1, 24.2, 23.1},
	},
}

--As computational as this looks, it's purpose is to just filter information overload.
--Basically, it solves for what should or shouldn't be shown, not what a player should or shouldn't do.
local function updateBossDistance(self)
	if not self.Options.AdvancedBossFiltering then return end
	--Check if near or far from Krozgoth
	if self:CheckBossDistance(201774, true, 32698, 48) then
		if not nearKroz then
			nearKroz = true
			timerCoalescingVoidCD:SetFade(false, self.vb.coalescingCount+1)
			timerUmbralDetonationCD:SetFade(false, self.vb.umbralCount+1)
			timerShadowsConvergenceCD:SetFade(false, self.vb.shadowConvergeCount+1)
			timerShadowSpikeCD:SetFade(false, self.vb.shadowStrikeCount+1)
		end
	else
		if nearKroz then
			nearKroz = false
			timerCoalescingVoidCD:SetFade(true, self.vb.coalescingCount+1)
			timerUmbralDetonationCD:SetFade(true, self.vb.umbralCount+1)
			timerShadowsConvergenceCD:SetFade(true, self.vb.shadowConvergeCount+1)
			timerShadowSpikeCD:SetFade(true, self.vb.shadowStrikeCount+1)
		end
	end
	--Check if near or far from Moltannia
	if self:CheckBossDistance(201773, true, 32698, 48) then
		if not nearMolt then
			nearMolt = true
			timerFieryMeteorCD:SetFade(false, self.vb.meteorCast+1)
			timerMoltenEruptionCD:SetFade(false, self.vb.moltenEruptionCast+1)
			timerSwirlingFlameCD:SetFade(false, self.vb.swirlingCount+1)
			timerFlameSlashCD:SetFade(false, self.vb.flameSlashCast+1)
		end
	else
		if nearMolt then
			nearMolt = false
			timerFieryMeteorCD:SetFade(true, self.vb.meteorCast+1)
			timerMoltenEruptionCD:SetFade(true, self.vb.moltenEruptionCast+1)
			timerSwirlingFlameCD:SetFade(true, self.vb.swirlingCount+1)
			timerFlameSlashCD:SetFade(true, self.vb.flameSlashCast+1)
		end
	end
	self:Schedule(2, updateBossDistance, self)
end

local function yellRepeater(self, text)
	yellShadowandFlameRepeat:Yell(text)
	self:Schedule(1.5, yellRepeater, self, text)
end

function mod:OnCombatStart(delay)
	nearKroz, nearMolt = true, true
	self:SetStage(1)
	--Krozgoth
	self.vb.coalescingCount = 0
	self.vb.umbralCount = 0
	self.vb.umbralIcon = 1
	self.vb.shadowConvergeCount = 0
	self.vb.shadowStrikeCount = 0
	if self:IsHard() then
		difficultyName = "hard"
		timerShadowSpikeCD:Start(9.3-delay, 1)
		timerUmbralDetonationCD:Start(14.2-delay, 1)
		timerShadowsConvergenceCD:Start(22.7-delay, 1)
		timerCoalescingVoidCD:Start(35.2-delay, 1)
	else--LFR and normal confirmed same, and heroic and mythic posibly also same
		difficultyName = "easy"
		timerShadowSpikeCD:Start(9.3-delay, 1)
		timerUmbralDetonationCD:Start(14.2-delay, 1)
		--timerShadowsConvergenceCD:Start(22.8-delay, 1)
		timerCoalescingVoidCD:Start(35.2-delay, 1)
	end
	--Reset Fades
	timerCoalescingVoidCD:SetFade(false, 1)
	timerUmbralDetonationCD:SetFade(false, 1)
	timerShadowsConvergenceCD:SetFade(false, 1)
	timerShadowSpikeCD:SetFade(false, 1)
	--Moltannia
	self.vb.meteorCast = 0
	self.vb.moltenEruptionCast = 0
	self.vb.swirlingCount = 0
	self.vb.SandFCount = 0
	self.vb.flameSlashCast = 0
	if self:IsHard() then
		timerFlameSlashCD:Start(7-delay, 1)
		timerSwirlingFlameCD:Start(10.7-delay, 1)
		timerMoltenEruptionCD:Start(16.7-delay, 1)
		timerFieryMeteorCD:Start(35.2-delay, 1)
	else--Normal and LFR confirmed
		timerFlameSlashCD:Start(9.3-delay, 1)
		timerSwirlingFlameCD:Start(10.5-delay, 1)
		--timerMoltenEruptionCD:Start(23-delay, 1)
		timerFieryMeteorCD:Start(35.2-delay, 1)
	end
	--Reset Fades
	timerFieryMeteorCD:SetFade(false, 1)
	timerMoltenEruptionCD:SetFade(false, 1)
	timerSwirlingFlameCD:SetFade(false, 1)
	timerFlameSlashCD:SetFade(false, 1)
	self:Schedule(2, updateBossDistance, self)
end

function mod:OnTimerRecovery()
	if self:IsHard() then
		difficultyName = "hard"
	else
		difficultyName = "easy"
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	--Krozgoth Spells
	if spellId == 403459 then
		self.vb.coalescingCount = self.vb.coalescingCount + 1
		if nearKroz then
			specWarnCoalescingVoid:Show(self.vb.coalescingCount)
			specWarnCoalescingVoid:Play("aesoon")
		end
		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.coalescingCount+1) or altTimers[difficultyName][spellId]
		if timer then
			timerCoalescingVoidCD:Start(timer, self.vb.coalescingCount+1)
		end
	elseif spellId == 405016 then
		self.vb.umbralCount = self.vb.umbralCount + 1
		self.vb.umbralIcon = 1
		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.umbralCount+1) or altTimers[difficultyName][spellId]
		if timer then
			timerUmbralDetonationCD:Start(timer, self.vb.umbralCount+1)
		end
	elseif spellId == 407640 then
		self.vb.shadowConvergeCount = self.vb.shadowConvergeCount + 1
		if nearKroz then
			specWarnShadowsConvergence:Show(self.vb.shadowConvergeCount)
			specWarnShadowsConvergence:Play("watchorb")
		end
		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.shadowConvergeCount+1) or altTimers[difficultyName][spellId]
		if timer then
			timerShadowsConvergenceCD:Start(timer, self.vb.shadowConvergeCount+1)
		end
	elseif spellId == 403699 then
		self.vb.shadowStrikeCount = self.vb.shadowStrikeCount + 1
		--if self:IsTanking("player", nil, nil, true, args.sourceGUID) then

		--end
		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.shadowStrikeCount+1) or altTimers[difficultyName][spellId]
		if timer then
			timerShadowSpikeCD:Start(timer, self.vb.shadowStrikeCount+1)
		end
	--Moltannia Spells
	elseif spellId == 404732 then
		self.vb.meteorCast = self.vb.meteorCast + 1
		if nearMolt then
			specWarnFieryMeteor:Show(self.vb.meteorCast)
			specWarnFieryMeteor:Play("helpsoak")
		end
		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.meteorCast+1) or altTimers[difficultyName][spellId]
		if timer then
			timerFieryMeteorCD:Start(timer, self.vb.meteorCast+1)
		end
	elseif spellId == 403101 then
		self.vb.moltenEruptionCast = self.vb.moltenEruptionCast + 1
		if nearMolt then
			specWarnMoltenEruption:Show(self.vb.moltenEruptionCast)
			specWarnMoltenEruption:Play("helpsoak")
		end
		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.moltenEruptionCast+1) or altTimers[difficultyName][spellId]
		if timer then
			timerMoltenEruptionCD:Start(timer, self.vb.moltenEruptionCast+1)
		end
	elseif spellId == 404896 then
		self.vb.swirlingCount = self.vb.swirlingCount + 1
		if nearMolt then
			specWarnSwirlingFlame:Show(self.vb.swirlingCount)
			specWarnSwirlingFlame:Play("watchwave")
		end
		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.swirlingCount+1) or altTimers[difficultyName][spellId]
		if timer then
			timerSwirlingFlameCD:Start(timer, self.vb.swirlingCount+1)
		end
	elseif spellId == 403203 then
		self.vb.flameSlashCast = self.vb.flameSlashCast + 1
		--if self:IsTanking("player", nil, nil, true, args.sourceGUID) then

		--end
		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.flameSlashCast+1) or altTimers[difficultyName][spellId]
		if timer then
			timerFlameSlashCD:Start(timer, self.vb.flameSlashCast+1)
		end
	--Molgoth
	elseif spellId == 405437 then
		self.vb.meteorCast = self.vb.meteorCast + 1
		specWarnGloomConflag:Show(self.vb.meteorCast)
		specWarnGloomConflag:Play("helpsoak")
		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.meteorCast+1) or altTimers[difficultyName][spellId]
		if timer then
			timerGloomConflagCD:Start(timer, self.vb.meteorCast+1)
		end
	elseif spellId == 405641 then
		self.vb.umbralCount = self.vb.umbralCount + 1
		self.vb.umbralIcon = 1
		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.umbralCount+1) or altTimers[difficultyName][spellId]
		if timer then
			timerBlisteringTwilightCD:Start(timer, self.vb.umbralCount+1)
		end
	elseif spellId == 408193 then
		self.vb.moltenEruptionCast = self.vb.moltenEruptionCast + 1
		specWarnConvergentEruption:Show(self.vb.moltenEruptionCast)
		specWarnConvergentEruption:Play("helpsoak")
		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.moltenEruptionCast+1) or altTimers[difficultyName][spellId]
		if timer then
			timerConvergentEruptionCD:Start(timer, self.vb.moltenEruptionCast+1)
		end
	elseif spellId == 405914 then
		self.vb.witheringVulnCount = self.vb.witheringVulnCount + 1
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnWitheringVulnerability:Show()
			specWarnWitheringVulnerability:Play("defensive")
		end
		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.witheringVulnCount+1) or altTimers[difficultyName][spellId]
		if timer then
			timerWitheringVulnerabilityCD:Start(timer, self.vb.witheringVulnCount+1)
		end
	elseif spellId == 406783 then
		self.vb.shadowflameBurstCount = self.vb.shadowflameBurstCount + 1
		warnShadowflameBurst:Show(self.vb.shadowflameBurstCount)
		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.shadowflameBurstCount+1) or altTimers[difficultyName][spellId]
		if timer then
			timerShadowflameBurstCD:Start(timer, self.vb.shadowflameBurstCount+1)
		end
	elseif spellId == 409385 then
		self.vb.SandFCount = self.vb.SandFCount + 1
		warnShadowandFlame:Show(self.vb.SandFCount)
		timerShadowandFlameCD:Start(self.vb.SandFCount == 1 and 52 or 47, self.vb.SandFCount+1)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 406730 and self:GetStage(2, 1) then--Crucible Instability
		self:SetStage(2)
		warnPhase2:Show()
		warnPhase2:Play("ptwo")
		self.vb.meteorCast = 0--Reused for Gloom Conflagration
		self.vb.umbralCount = 0--Reused for Blistering Twilight
		self.vb.moltenEruptionCast = 0--Reused for Converging Eruption
		self.vb.witheringVulnCount = 0
		self.vb.shadowflameBurstCount = 0
		self:Unschedule(updateBossDistance)
		timerCoalescingVoidCD:Stop()
		timerUmbralDetonationCD:Stop()
		timerShadowsConvergenceCD:Stop()
		timerShadowSpikeCD:Stop()
		timerFieryMeteorCD:Stop()
		timerMoltenEruptionCD:Stop()
		timerSwirlingFlameCD:Stop()
		timerFlameSlashCD:Stop()
		timerPhaseCD:Start(11.7)
		if self:IsMythic() then
			timerShadowandFlameCD:Start(29, 1)
			timerConvergentEruptionCD:Start(35.7, 1)
		elseif self:IsHeroic() then
			timerConvergentEruptionCD:Start(32.4, 1)
		end
		--Same in all
		timerWitheringVulnerabilityCD:Start(15.8, 1)
		timerShadowflameBurstCD:Start(18.5, 1)
		timerBlisteringTwilightCD:Start(20.2, 1)
		timerGloomConflagCD:Start(50, 1)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 401809 and args:IsPlayer() then
		local amount = args.amount or 1
		if (amount % 3 == 0) and amount >= 18 then--Adjust as needed
			warnCorruptingShadow:Show(amount)
		end
		if self:IsMythic() and self:GetStage(2) and amount == 1 then
			self:Unschedule(yellRepeater)
			yellRepeater(self, 3)
		end
	elseif spellId == 402617 and args:IsPlayer() then
		local amount = args.amount or 1
		if (amount % 3 == 0) and amount >= 18 then--Adjust as needed
			warnBlazingHeat:Show(amount)
		end
		if self:IsMythic() and self:GetStage(2) and amount == 1 then
			self:Unschedule(yellRepeater)
			yellRepeater(self, 2)
		end
	elseif spellId == 405394 and args:IsPlayer() then
		local amount = args.amount or 1
		if (amount % 3 == 0) and amount >= 18 then--Adjust as needed
			warnShadowflame:Show(amount)
		end
	elseif spellId == 405036 then
		local icon = self.vb.umbralIcon
		if self.Options.SetIconOnUmbral then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnUmbralDetonation:Show()
			specWarnUmbralDetonation:Play("targetyou")
			yellUmbralDetonation:Yell()
			yellUmbralDetonationFades:Countdown(spellId)
		end
		if nearKroz then
			warnUmbralDetonation:CombinedShow(0.5, self.vb.umbralCount, args.destName)
		end
		self.vb.umbralIcon = self.vb.umbralIcon + 1
	elseif spellId == 405642 then
		local icon = self.vb.umbralIcon
		if self.Options.SetIconOnBlistering then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnBlisteringTwilight:Show()
			specWarnBlisteringTwilight:Play("targetyou")
			yellBlisteringTwilight:Yell()
			yellBlisteringTwilightFades:Countdown(spellId)
		end
		warnBlisteringTwilight:CombinedShow(0.5, self.vb.umbralCount, args.destName)
		self.vb.umbralIcon = self.vb.umbralIcon + 1
	elseif (spellId == 413597 or spellId == 405914) and not args:IsPlayer() then
		specWarnWitheringVulnerabilityTaunt:Show(args.destName)
		specWarnWitheringVulnerabilityTaunt:Play("tauntboss")
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 401809 and args:IsPlayer() then
		warnCorruptingShadowFades:Show()
		if self:IsMythic() then
			self:Unschedule(yellRepeater)
		end
	elseif spellId == 402617 and args:IsPlayer() then
		warnBlazingHeatFades:Show()
		if self:IsMythic() then
			self:Unschedule(yellRepeater)
		end
	elseif spellId == 405036 then
		if self.Options.SetIconOnUmbral then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellUmbralDetonationFades:Cancel()
		end
	elseif spellId == 405642 then
		if self.Options.SetIconOnBlistering then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellBlisteringTwilightFades:Cancel()
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if (spellId == 405084 or spellId == 405645) and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
