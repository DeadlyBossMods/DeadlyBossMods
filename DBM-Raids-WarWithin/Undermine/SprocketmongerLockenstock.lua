if DBM:GetTOC() < 110100 then return end
local mod	= DBM:NewMod(2653, "DBM-Raids-WarWithin", 1, 1296)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(214503)
mod:SetEncounterID(3013)
--mod:SetHotfixNoticeRev(20240921000000)
--mod:SetMinSyncRevision(20240921000000)
mod:SetZone(2769)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 473276 1217231 1214872 1216508 465232 1218418 1216525 1216414 1215858 466765 1216674 1216699",
	"SPELL_CAST_SUCCESS 1216802 1216887",
	"SPELL_AURA_APPLIED 1216934 1216911 465917 1214878 1216509 1217261 466860 1218344",
	"SPELL_AURA_APPLIED_DOSE 465917 1218344",
	"SPELL_AURA_REMOVED 1216934 1216911 465917 1214878 1216509 466860",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED"
--	"CHAT_MSG_RAID_BOSS_WHISPER",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO: figure out how staging actually works. it looks like siegecrafter blackfuse 2.0
--TODO, actual cast event for Polarization
--TODO, detect polarization of bombs and nameplate aura them if possible
--TODO, verify tank logic should work like Volcoross
--TOOD, GTFO for https://www.wowhead.com/ptr-2/spell=466235/wire-transfer ?
--TODO, detect when weapons activate and properly start timers in right place
--TODO, verify firecracker trap spawn trigger
--TODO, see if https://www.wowhead.com/ptr-2/spell=1215218/bleeding-edge still used
--TODO, maybe also add a repeating voidsplosion timer
--Stage One: Alpha Test
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30425))
local warnPolarizationGenerator						= mod:NewIncomingCountAnnounce(1216802, 3)
local warnNegativeRemoved							= mod:NewFadesAnnounce(1216934, 1)
local warnPositiveRemoved							= mod:NewFadesAnnounce(1216911, 1)
local warnAlphaTesting								= mod:NewCountAnnounce(473276, 2)
local warnGunkStacks								= mod:NewStackAnnounce(465917, 2, nil, "Tank|Healer")
local warnScrewUp									= mod:NewTargetNoFilterAnnounce(1216508, 2)
local warnScrewUpOver								= mod:NewFadesAnnounce(1216509, 1, nil, nil, nil, nil, nil, 2)
local warnScrewedUp									= mod:NewTargetNoFilterAnnounce(1217261, 4, nil, false)
local warnSonicBoom									= mod:NewCountAnnounce(465232, 2, nil, "Healer")

local specWarnNegative								= mod:NewSpecialWarningYou(1216934, nil, nil, nil, 1, 13)
local specWarnPositive								= mod:NewSpecialWarningYou(1216911, nil, nil, nil, 1, 13)
local yellPolarizationGenerator						= mod:NewIconTargetYell(1216802, DBM_CORE_L.AUTO_YELL_ANNOUNCE_TEXT.repeaticon)
local specWarnProductDeployment						= mod:NewSpecialWarningCount(1217231, nil, nil, nil, 2, 2)
local specWarnPyroPartyPack							= mod:NewSpecialWarningDefensive(1214872, nil, nil, nil, 1, 2)--Possibly cull or disable by default
local specWarnPyroPartyPackTaunt					= mod:NewSpecialWarningTaunt(1214872, nil, nil, nil, 1, 2)
local specWarnPyroPartyPackRunOut					= mod:NewSpecialWarningMoveAway(1214872, nil, nil, nil, 3, 2)
local yellPyroPartyPack								= mod:NewYell(1214872)
local yellPyroPartyPackFades						= mod:NewShortFadesYell(1214872)
local specWarnScrewUp								= mod:NewSpecialWarningRun(1216508, nil, nil, nil, 4, 2)
local yellScrewUp									= mod:NewYell(1216508)
local specWarnWireTransfer							= mod:NewSpecialWarningDodgeCount(1218418, nil, nil, nil, 2, 2)
--local specWarnGTFO								= mod:NewSpecialWarningGTFO(459785, nil, nil, nil, 1, 8)

local timerPolarizationGeneratorCD					= mod:NewAITimer(97.3, 1216802, nil, nil, nil, 2, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerAlphatestCD								= mod:NewAITimer(97.3, 473276, nil, nil, nil, 5)--Change to phase color if it's the phasing spell
local timerProductDeploymentCD						= mod:NewAITimer(97.3, 1217231, nil, nil, nil, 5, nil, DBM_COMMON_L.HEROIC_ICON)
local timerPyroPartyPackCD							= mod:NewAITimer(97.3, 1214872, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerScrewUpCD								= mod:NewAITimer(97.3, 1216508, nil, nil, nil, 3)
local timerSonicBoomCD								= mod:NewAITimer(97.3, 465232, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerWireTransferCD							= mod:NewAITimer(97.3, 1218418, nil, nil, nil, 3)
--Base Model Goblin Weaponry
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30518))
local warnFirecrackerTrap							= mod:NewCountAnnounce(471308, 2)

local specWarnRocketHell							= mod:NewSpecialWarningDodgeCount(1216525, nil, nil, nil, 2, 2)
local specWarnFireLaser								= mod:NewSpecialWarningDodgeCount(1216414, nil, nil, nil, 2, 2)
local specWarnMegaMagnet							= mod:NewSpecialWarningDodgeCount(1215858, nil, nil, nil, 2, 12)

local timerRocketHellCD								= mod:NewAITimer(97.3, 1216525, nil, nil, nil, 3)
local timerFireLaserCD								= mod:NewAITimer(97.3, 1216414, nil, nil, nil, 3)
local timerMegaMagnetCD								= mod:NewAITimer(97.3, 1215858, nil, nil, nil, 3)
local timerFirecrackerTrapCD						= mod:NewAITimer(97.3, 471308, nil, nil, nil, 3)
--Stage Two: System Update
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30427))
local warnBetaLaunch								= mod:NewSpellAnnounce(466765, 2, nil, nil, nil, nil, nil, 2)
local warnUpgradedBloodTech							= mod:NewStackAnnounce(1218344, 2)

local timerBleedingEdge								= mod:NewBuffActiveTimer(20, 1215218, nil, nil, nil, 6)
--Stage Three: Beta Launch
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30579))
local specWarnVoidLaser								= mod:NewSpecialWarningDodgeCount(1216674, nil, nil, nil, 2, 2)
local specWarnVoidHell								= mod:NewSpecialWarningDodgeCount(1216699, nil, nil, nil, 2, 2)

local timerVoidLaserCD								= mod:NewAITimer(97.3, 1216674, nil, nil, nil, 3)
local timerVoidHellCD								= mod:NewAITimer(97.3, 1216699, nil, nil, nil, 3)

--basic
mod.vb.thadiusCount = 0
mod.vb.alphaTestCount = 0
mod.vb.deploymentCount = 0
mod.vb.tankExplosionCount = 0
mod.vb.screwUpCount = 0
mod.vb.sonicBoomCount = 0
mod.vb.wireTransferCount = 0
local playerStacks = 0
--Weapons
mod.vb.rocketHellCount = 0--Also used for void variant
mod.vb.fireLaserCount = 0--Also used for void variant
mod.vb.megaMagnetCount = 0
mod.vb.trapCount = 0

function mod:OnCombatStart(delay)
	self.vb.thadiusCount = 0
	self.vb.alphaTestCount = 0
	self.vb.deploymentCount = 0
	self.vb.tankExplosionCount = 0
	self.vb.screwUpCount = 0
	self.vb.sonicBoomCount = 0
	self.vb.wireTransferCount = 0
	playerStacks = 0
	--Weapons
	self.vb.rocketHellCount = 0
	self.vb.fireLaserCount = 0
	self.vb.megaMagnetCount = 0
	self.vb.trapCount = 0
	--self:EnablePrivateAuraSound(433517, "runout", 2)
	timerAlphatestCD:Start(1-delay)
	timerProductDeploymentCD:Start(1-delay)
	timerPyroPartyPackCD:Start(1-delay)
	timerScrewUpCD:Start(1-delay)
	timerSonicBoomCD:Start(1-delay)
	timerWireTransferCD:Start(1-delay)
	--weapons (probably doesn't actually start here)
	timerRocketHellCD:Start(1-delay)
	timerFireLaserCD:Start(1-delay)
	timerMegaMagnetCD:Start(1-delay)
	timerFirecrackerTrapCD:Start(1-delay)
	if self:IsMythic() then
		timerPolarizationGeneratorCD:Start(1-delay)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 473276 then
		self.vb.alphaTestCount = self.vb.alphaTestCount + 1
		warnAlphaTesting:Show(self.vb.alphaTestCount)
		timerAlphatestCD:Start()
	elseif spellId == 1217231 then
		self.vb.deploymentCount = self.vb.deploymentCount + 1
		specWarnProductDeployment:Show(self.vb.deploymentCount)
		specWarnProductDeployment:Play("bombsoon")
		timerProductDeploymentCD:Start()
	elseif spellId == 1214872 then
		self.vb.tankExplosionCount = self.vb.tankExplosionCount + 1
		timerPyroPartyPackCD:Start()
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnPyroPartyPack:Show()
			specWarnPyroPartyPack:Play("defensive")
		elseif playerStacks < 3 then
			local bossTarget = UnitName("boss1target") or DBM_COMMON_L.UNKNOWN
			specWarnPyroPartyPackTaunt:Show(bossTarget)
			specWarnPyroPartyPackTaunt:Play("tauntboss")
		end
	elseif spellId == 1216508 then
		self.vb.screwUpCount = self.vb.screwUpCount + 1
		timerScrewUpCD:Start()
	elseif spellId == 465232 then
		self.vb.sonicBoomCount = self.vb.sonicBoomCount + 1
		warnSonicBoom:Show(self.vb.sonicBoomCount)
		timerSonicBoomCD:Start()
	elseif spellId == 1218418 then
		self.vb.wireTransferCount = self.vb.wireTransferCount + 1
		specWarnWireTransfer:Show(self.vb.wireTransferCount)
		specWarnWireTransfer:Play("watchstep")
		timerWireTransferCD:Start()
	elseif spellId == 1216525 then
		self.vb.rocketHellCount = self.vb.rocketHellCount + 1
		specWarnRocketHell:Show(self.vb.rocketHellCount)
		specWarnRocketHell:Play("watchstep")
		timerRocketHellCD:Start()
	elseif spellId == 1216699 then
		self.vb.rocketHellCount = self.vb.rocketHellCount + 1
		specWarnVoidHell:Show(self.vb.rocketHellCount)
		specWarnVoidHell:Play("watchstep")
		timerRocketHellCD:Start()
	elseif spellId == 1216414 then
		self.vb.fireLaserCount = self.vb.fireLaserCount + 1
		specWarnFireLaser:Show(self.vb.fireLaserCount)
		specWarnFireLaser:Play("watchstep")
		timerFireLaserCD:Start()
	elseif spellId == 1216674 then
		self.vb.fireLaserCount = self.vb.fireLaserCount + 1
		specWarnVoidLaser:Show(self.vb.fireLaserCount)
		specWarnVoidLaser:Play("watchstep")
		timerVoidLaserCD:Start()
	elseif spellId == 1215858 then
		self.vb.megaMagnetCount = self.vb.megaMagnetCount + 1
		specWarnMegaMagnet:Show(self.vb.megaMagnetCount)
		specWarnMegaMagnet:Play("pullin")
		timerMegaMagnetCD:Start()
	elseif spellId == 466765 then
		--Stop All timers?
		timerAlphatestCD:Stop()
		timerProductDeploymentCD:Stop()
		timerPyroPartyPackCD:Stop()
		timerScrewUpCD:Stop()
		timerSonicBoomCD:Stop()
		timerWireTransferCD:Stop()
		timerRocketHellCD:Stop()
		timerFireLaserCD:Stop()
		timerMegaMagnetCD:Stop()
		timerFirecrackerTrapCD:Stop()
		--Start new timers?
		warnBetaLaunch:Show()
		warnBetaLaunch:Play("phasechange")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 1216802 or spellId == 1216887 then
		self.vb.thadiusCount = self.vb.thadiusCount + 1
		warnPolarizationGenerator:Show(self.vb.thadiusCount)
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
	elseif spellId == 466860 then
		timerBleedingEdge:Start()
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
	elseif spellId == 466860 then
		timerBleedingEdge:Stop()
		--Restart P1 timers?
		timerAlphatestCD:Start(1)
		timerProductDeploymentCD:Start(1)
		timerPyroPartyPackCD:Start(1)
		timerScrewUpCD:Start(1)
		timerSonicBoomCD:Start(1)
		timerWireTransferCD:Start(1)
		--weapons (TODO, detect which ones got empowered and start empowered version timers)
		timerRocketHellCD:Start(1)--Can empower
		timerFireLaserCD:Start(1)--Can empower
		timerMegaMagnetCD:Start(1)--No Empowerment
		timerFirecrackerTrapCD:Start(1)--No Empowerment
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

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 471299 then
		self.vb.trapCount = self.vb.trapCount + 1
		warnFirecrackerTrap:Show(self.vb.trapCount)
		timerFirecrackerTrapCD:Start()
	end
end
