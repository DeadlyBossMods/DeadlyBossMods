if DBM:GetTOC() < 110100 then return end
local mod	= DBM:NewMod(2653, "DBM-Raids-WarWithin", 1, 1296)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(230583)
mod:SetEncounterID(3013)
mod:SetHotfixNoticeRev(20250117000000)
mod:SetMinSyncRevision(20250117000000)
mod:SetZone(2769)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 473276 1217231 1214872 1216508 465232 1218418 1216525 1216414 1215858 466765 1216674 1216699 468791",
	"SPELL_CAST_SUCCESS 1216887 466860",
	"SPELL_AURA_APPLIED 1216934 1216911 465917 1214878 1216509 1217261 1218344",
	"SPELL_AURA_APPLIED_DOSE 465917 1218344",
	"SPELL_AURA_REMOVED 1216934 1216911 465917 1214878 1216509 466860"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED"
)

--TODO, actual cast event for Polarization
--TODO, detect polarization of bombs and nameplate aura them if possible
--TODO, verify tank logic should work like Volcoross
--TOOD, GTFO for https://www.wowhead.com/ptr-2/spell=466235/wire-transfer ?
--TODO, find firecracker trap spawn trigger
--TODO, see if https://www.wowhead.com/ptr-2/spell=1215218/bleeding-edge still used on other difficulties
--[[
(ability.id = 473276 or ability.id = 1217231 or ability.id = 1214872 or ability.id = 1216508 or ability.id = 465232 or ability.id = 1218418 or ability.id = 1216525 or ability.id = 1216414 or ability.id = 1215858 or ability.id = 466765 or ability.id = 1216674 or ability.id = 1216699) and type = "begincast"
or (ability.id = 1217355 or ability.id = 466860) and type = "cast"
or ability.id = 466860 and type = "removebuff"
--]]
--Stage One: Assembly Required
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30425))
local warnActivateInventions						= mod:NewCountAnnounce(473276, 2)

local timerActivateInventionsCD						= mod:NewNextCountTimer(30, 473276, nil, nil, nil, 5)--Change to phase color if it's the phasing spell
--Goblin Inventions
mod:AddTimerLine(DBM:EJ_GetSectionInfo(31725))
local specWarnRocketBarrage							= mod:NewSpecialWarningDodge(1216525, nil, nil, nil, 2, 2)
local specWarnBlazingbeam							= mod:NewSpecialWarningDodge(1216414, nil, nil, nil, 2, 2)
local specWarnMegaMagnet							= mod:NewSpecialWarningDodge(1215858, nil, nil, nil, 2, 12)
--Empowered Inventions
mod:AddTimerLine(DBM:EJ_GetSectionInfo(31726))
local specWarnVoidLaser								= mod:NewSpecialWarningDodge(1216674, nil, nil, nil, 2, 2)
local specWarnVoidBarrage							= mod:NewSpecialWarningDodge(1216699, nil, nil, nil, 2, 2)
----Polarization Generator
mod:AddTimerLine(DBM:GetSpellName(1216802))
local warnPolarizationGenerator						= mod:NewIncomingCountAnnounce(1216802, 3)
local warnNegativeRemoved							= mod:NewFadesAnnounce(1216934, 1)
local warnPositiveRemoved							= mod:NewFadesAnnounce(1216911, 1)

local specWarnNegative								= mod:NewSpecialWarningYou(1216934, nil, nil, nil, 1, 13)
local specWarnPositive								= mod:NewSpecialWarningYou(1216911, nil, nil, nil, 1, 13)
local yellPolarizationGenerator						= mod:NewIconTargetYell(1216802, DBM_CORE_L.AUTO_YELL_ANNOUNCE_TEXT.repeaticon)

local timerPolarizationGeneratorCD					= mod:NewNextCountTimer(97.3, 1216802, nil, nil, nil, 2, nil, DBM_COMMON_L.MYTHIC_ICON)
--Main Boss
mod:AddTimerLine(DBM_COMMON_L.BOSS)
local warnScrewUp									= mod:NewTargetNoFilterAnnounce(1216508, 2)
local warnScrewUpOver								= mod:NewFadesAnnounce(1216508, 1, nil, nil, nil, nil, nil, 2)
local warnScrewedUp									= mod:NewTargetNoFilterAnnounce(1217261, 4, nil, false)
local warnSonicBoom									= mod:NewCountAnnounce(465232, 2, nil, "Healer")
--local warnFirecrackerTrap							= mod:NewSpellAnnounce(471308, 2)
local warnGunkStacks								= mod:NewStackAnnounce(465917, 2, nil, "Tank|Healer")

local specWarnFootBlasters							= mod:NewSpecialWarningCount(1217231, nil, nil, nil, 2, 2)
local specWarnWireTransfer							= mod:NewSpecialWarningDodgeCount(1218418, nil, nil, nil, 2, 2)
local specWarnScrewUp								= mod:NewSpecialWarningRun(1216508, nil, nil, nil, 4, 2)
local yellScrewUp									= mod:NewYell(1216508)
local specWarnPyroPartyPack							= mod:NewSpecialWarningDefensive(1214872, nil, nil, nil, 1, 2)--Possibly cull or disable by default
local specWarnPyroPartyPackTaunt					= mod:NewSpecialWarningTaunt(1214872, nil, nil, nil, 1, 2)
local specWarnPyroPartyPackRunOut					= mod:NewSpecialWarningMoveAway(1214872, nil, nil, nil, 3, 2)
local yellPyroPartyPack								= mod:NewYell(1214872)
local yellPyroPartyPackFades						= mod:NewShortFadesYell(1214872)
--local specWarnGTFO								= mod:NewSpecialWarningGTFO(459785, nil, nil, nil, 1, 8)

local timerFootBlastersCD							= mod:NewNextCountTimer(97.3, 1217231, nil, nil, nil, 5, nil, DBM_COMMON_L.HEROIC_ICON)
local timerWireTransferCD							= mod:NewNextCountTimer(97.3, 1218418, nil, nil, nil, 3)
local timerScrewUpCD								= mod:NewNextCountTimer(97.3, 1216508, nil, nil, nil, 3)
local timerSonicBoomCD								= mod:NewNextCountTimer(97.3, 465232, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
--local timerFirecrackerTrapCD						= mod:NewAITimer(97.3, 471308, nil, nil, nil, 3)
local timerPyroPartyPackCD							= mod:NewNextCountTimer(97.3, 1214872, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--Stage Two: Research and Destruction
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30427))
local warnBetaLaunch								= mod:NewSpellAnnounce(466765, 2, nil, nil, nil, nil, nil, 2)
local warnUpgradedBloodTech							= mod:NewStackAnnounce(1218344, 2)

local specWarnGigaDeath								= mod:NewSpecialWarningSpell(468791, nil, nil, nil, 3, 2)--Berserk

local timerBetaLaunchCD								= mod:NewNextCountTimer(97.3, 466765, nil, nil, nil, 6)
local timerGigaDeathCD								= mod:NewNextTimer(97.3, 468791, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)--Berserk
local timerBleedingEdge								= mod:NewBuffActiveTimer(20, 1215218, nil, nil, nil, 6)

--basic
mod.vb.ActivateInventionsCount = 0
mod.vb.thadiusCount = 0
mod.vb.footBlasterCount = 0
mod.vb.tankExplosionCount = 0
mod.vb.screwUpCount = 0
mod.vb.sonicBoomCount = 0
mod.vb.wireTransferCount = 0
mod.vb.betaCount = 0
local playerStacks = 0
local savedDifficulty = "normal"
local allTimers = {
	["mythic"] = {
		--Foot Blasters
		[1217231] = {12.1, 33.0, 30.0, 30.0},
		--Wire Transfer
		[1218418] = {0, 40.9, 69.9},
		--Screw Up
		[1216508] = {18.0, 30.0, 32.0, 27.0},
		--Sonic Boom
		[465232] = {8.9, 25.0, 27.0, 31.9, 17.9},
		--Pyro Party Pack
		[1214872] = {23.0, 33.0, 30.0},
		--Polarization
		[1217355] = {4, 66.9, 46.0},
	},
	["heroic"] = {
		--Foot Blasters
		[1217231] = {12.1, 62.0, 31.0},
		--Wire Transfer
		[1218418] = {0, 40.9, 28.0, 28.0},
		--Screw Up
		[1216508] = {47.1, 33.0, 32.0},
		--Sonic Boom
		[465232] = {6.0, 28.0, 29.0, 30.0},
		--Pyro Party Pack
		[1214872] = {20.1, 34.0, 30.0},
	},
	["normal"] = {
		--Wire Transfer
		[1218418] = {0, 41.0, 30.0, 30.0},
		--Screw Up
		[1216508] = {47.0, 33.0, 32.0},
		--Sonic Boom
		[465232] = {6.1, 29.9, 30.0, 30.0},
		--Pyro Party Pack
		[1214872] = {23.1, 32.0, 30.0, 23.0},
	},
}

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.ActivateInventionsCount = 0
	self.vb.thadiusCount = 0
	self.vb.footBlasterCount = 0
	self.vb.tankExplosionCount = 0
	self.vb.screwUpCount = 0
	self.vb.sonicBoomCount = 0
	self.vb.wireTransferCount = 0
	self.vb.betaCount = 0
	playerStacks = 0
	if self:IsMythic() then
		savedDifficulty = "mythic"
		timerPolarizationGeneratorCD:Start(4-delay)
	elseif self:IsHeroic() then
		savedDifficulty = "heroic"
	else--Combine LFR and Normal
		savedDifficulty = "normal"
	end
	--self:EnablePrivateAuraSound(433517, "runout", 2)
--	timerWireTransferCD:Start(1-delay)--Used instantly on pull
	timerSonicBoomCD:Start(allTimers[savedDifficulty][465232][1]-delay, 1)
	if self:IsHard() then
		timerFootBlastersCD:Start(allTimers[savedDifficulty][1217231][1]-delay, 1)
	end
	timerPyroPartyPackCD:Start(allTimers[savedDifficulty][1214872][1]-delay, 1)
	timerActivateInventionsCD:Start(30-delay, 1)
	timerScrewUpCD:Start(allTimers[savedDifficulty][1216508][1]-delay, 1)
	timerBetaLaunchCD:Start(120-delay, 11)
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
	if spellId == 473276 then
		self.vb.ActivateInventionsCount = self.vb.ActivateInventionsCount + 1
		warnActivateInventions:Show(self.vb.ActivateInventionsCount)
		if self.vb.ActivateInventionsCount < 3 then
			timerActivateInventionsCD:Start(nil, self.vb.ActivateInventionsCount+1)
		end
	elseif spellId == 1217231 then
		self.vb.footBlasterCount = self.vb.footBlasterCount + 1
		specWarnFootBlasters:Show(self.vb.footBlasterCount)
		specWarnFootBlasters:Play("bombsoon")
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, false, spellId, self.vb.footBlasterCount+1)
		if timer then
			timerFootBlastersCD:Start(timer, self.vb.footBlasterCount+1)
		end
	elseif spellId == 1214872 then
		self.vb.tankExplosionCount = self.vb.tankExplosionCount + 1
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, false, spellId, self.vb.tankExplosionCount+1)
		if timer then
			timerPyroPartyPackCD:Start(timer, self.vb.tankExplosionCount+1)
		end
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnPyroPartyPack:Show()
			specWarnPyroPartyPack:Play("defensive")
		elseif playerStacks < 3 then
			local bossTarget = self:GetBossTarget(args.sourceGUID, true) or DBM_COMMON_L.UNKNOWN
			specWarnPyroPartyPackTaunt:Show(bossTarget)
			specWarnPyroPartyPackTaunt:Play("tauntboss")
		end
	elseif spellId == 1216508 then
		self.vb.screwUpCount = self.vb.screwUpCount + 1
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, false, spellId, self.vb.screwUpCount+1)
		if timer then
			timerScrewUpCD:Start(timer, self.vb.screwUpCount+1)
		end
	elseif spellId == 465232 then
		self.vb.sonicBoomCount = self.vb.sonicBoomCount + 1
		warnSonicBoom:Show(self.vb.sonicBoomCount)
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, false, spellId, self.vb.sonicBoomCount+1)
		if timer then
			timerSonicBoomCD:Start(timer, self.vb.sonicBoomCount+1)
		end
	elseif spellId == 1218418 then
		self.vb.wireTransferCount = self.vb.wireTransferCount + 1
		specWarnWireTransfer:Show(self.vb.wireTransferCount)
		specWarnWireTransfer:Play("watchstep")
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, false, spellId, self.vb.wireTransferCount+1)
		if timer then
			timerWireTransferCD:Start(timer, self.vb.wireTransferCount+1)
		end
		--Backup return to stage 1 if the other events vanish
		if self:GetStage(2) then--Bleeding Edge ending (beta launch over) (will likely be removed as visible event, it's only showing on script bunnies
			--can also use [DNT] Intermission Cleanup
			self:SetStage(1)
			timerBleedingEdge:Stop()
			--Reset counts
			self.vb.ActivateInventionsCount = 0
			self.vb.thadiusCount = 0
			self.vb.footBlasterCount = 0
			self.vb.tankExplosionCount = 0
			self.vb.screwUpCount = 0
			self.vb.sonicBoomCount = 0
			self.vb.wireTransferCount = 0
			--Restart timers
			timerSonicBoomCD:Start(allTimers[savedDifficulty][465232][1], 1)
			if self:IsHard() then
				timerFootBlastersCD:Start(allTimers[savedDifficulty][1217231][1], 1)
			end
			timerPyroPartyPackCD:Start(allTimers[savedDifficulty][1214872][1], 1)
			timerActivateInventionsCD:Start(30, 1)
			timerScrewUpCD:Start(allTimers[savedDifficulty][1216508][1], 1)
			if self.vb.betaCount == 2 then
				timerGigaDeathCD:Start(120)
			else
				timerBetaLaunchCD:Start(120, self.vb.betaCount+1)
			end
	--		timerWireTransferCD:Start(1)--Used instantly
		end
	elseif spellId == 1216525 and self:AntiSpam(5, 1) then
		specWarnRocketBarrage:Show()
		specWarnRocketBarrage:Play("watchstep")
	elseif spellId == 1216699 and self:AntiSpam(5, 1) then
		specWarnVoidBarrage:Show()
		specWarnVoidBarrage:Play("watchstep")
	elseif spellId == 1216414 and self:AntiSpam(5, 2) then
		specWarnBlazingbeam:Show()
		specWarnBlazingbeam:Play("farfromline")
	elseif spellId == 1216674 and self:AntiSpam(5, 2) then
		specWarnVoidLaser:Show()
		specWarnVoidLaser:Play("farfromline")
	elseif spellId == 1215858 and self:AntiSpam(5, 3) then
		specWarnMegaMagnet:Show()
		specWarnMegaMagnet:Play("pullin")
	elseif spellId == 468791 then
		specWarnGigaDeath:Show()
		specWarnGigaDeath:Play("stilldanger")
	elseif spellId == 466765 then--Beta Launch
		self:SetStage(2)
		self.vb.betaCount = self.vb.betaCount + 1
		timerActivateInventionsCD:Stop()
		timerFootBlastersCD:Stop()
		timerPyroPartyPackCD:Stop()
		timerScrewUpCD:Stop()
		timerSonicBoomCD:Stop()
		timerWireTransferCD:Stop()
		warnBetaLaunch:Show()
		warnBetaLaunch:Play("phasechange")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 1216887 then
		self.vb.thadiusCount = self.vb.thadiusCount + 1
		warnPolarizationGenerator:Show(self.vb.thadiusCount)
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, false, spellId, self.vb.thadiusCount+1)
		if timer then
			timerPolarizationGeneratorCD:Start(timer, self.vb.thadiusCount+1)
		end
	elseif spellId == 466860 then
		timerBleedingEdge:Start()--20
		--Start reset timers here instead?
		timerWireTransferCD:Start(20, 1)--Starte here because it's used instantly on stage end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 1216934 then
		if args:IsPlayer() then
			specWarnNegative:Show()
			specWarnNegative:Play("negative")
			yellPolarizationGenerator:Yell(7, "")--Red X
		end
	elseif spellId == 1216911 then
		if args:IsPlayer() then
			specWarnPositive:Show()
			specWarnPositive:Play("positive")
			yellPolarizationGenerator:Yell(6, "")--Blue Square
		end
	elseif spellId == 465917 then
		local amount = args.amount or 1
		if args:IsPlayer() then
			playerStacks = amount
		end
		if amount % 2 == 0 then--TODO, fine tune
			warnGunkStacks:Show(args.destName, amount)
		end
	elseif spellId == 1214878 then
		if args:IsPlayer() then
			specWarnPyroPartyPackRunOut:Show()
			specWarnPyroPartyPackRunOut:Play("runout")
			yellPyroPartyPack:Yell()
			yellPyroPartyPackFades:Countdown(spellId)
		end
	elseif spellId == 1216509 then
		if args:IsPlayer() then
			warnScrewUp:PreciseShow(4, args.destName)
			if args:IsPlayer() then
				specWarnScrewUp:Show()
				specWarnScrewUp:Play("runout")
				specWarnScrewUp:ScheduleVoice(1, "keepmove")
				yellScrewUp:Yell()
			end
		end
	elseif spellId == 1217261 then
		warnScrewedUp:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			specWarnScrewUp:Play("screwup")
		end
	elseif spellId == 1218344 then
		local amount = args.amount or 1
		warnUpgradedBloodTech:Show(args.destName, amount)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 1216934 then
		if args:IsPlayer() then
			warnNegativeRemoved:Show()
		end
	elseif spellId == 1216911 then
		if args:IsPlayer() then
			warnPositiveRemoved:Show()
		end
	elseif spellId == 465917 then
		if args:IsPlayer() then
			playerStacks = 0
		end
	elseif spellId == 1214878 then
		if args:IsPlayer() then
			yellPyroPartyPackFades:Cancel()
		end
	elseif spellId == 1216509 then
		if args:IsPlayer() then
			warnScrewUpOver:Show()
			warnScrewUpOver:Play("safenow")
		end
	elseif spellId == 466860 and self:GetStage(2) then--Bleeding Edge ending (beta launch over) (will likely be removed as visible event, it's only showing on script bunnies
		--can also use [DNT] Intermission Cleanup
		self:SetStage(1)
		timerBleedingEdge:Stop()
		--Reset counts
		self.vb.ActivateInventionsCount = 0
		self.vb.thadiusCount = 0
		self.vb.footBlasterCount = 0
		self.vb.tankExplosionCount = 0
		self.vb.screwUpCount = 0
		self.vb.sonicBoomCount = 0
		self.vb.wireTransferCount = 0
		--Restart timers
		timerSonicBoomCD:Start(allTimers[savedDifficulty][465232][1], 1)
		if self:IsHard() then
			timerFootBlastersCD:Start(allTimers[savedDifficulty][1217231][1], 1)
			if self:IsMythic() then
				timerPolarizationGeneratorCD(allTimers[savedDifficulty][1217231][1], 1)
			end
		end
		timerPyroPartyPackCD:Start(allTimers[savedDifficulty][1214872][1], 1)
		timerActivateInventionsCD:Start(30, 1)
		timerScrewUpCD:Start(allTimers[savedDifficulty][1216508][1], 1)

		timerBetaLaunchCD:Start(120, self.vb.betaCount+1)
--		timerWireTransferCD:Start(1)--Used instantly
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
