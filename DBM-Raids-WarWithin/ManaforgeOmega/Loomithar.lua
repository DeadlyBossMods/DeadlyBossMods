if DBM:GetTOC() < 110200 then return end
local mod	= DBM:NewMod(2686, "DBM-Raids-WarWithin", 1, 1302)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(233815)
mod:SetEncounterID(3131)
mod:SetUsedIcons(1, 2)
mod:SetHotfixNoticeRev(20250629000000)
--mod:SetMinSyncRevision(20240921000000)
mod:SetZone(2810)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 1227263 1227782 1227226",
	"SPELL_CAST_SUCCESS 1226395 1237272",--1226315 1226867 1230115
	"SPELL_AURA_APPLIED 1226311 1238502 1237212 1228070 1227784 1227163",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 1226311 1238502",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED"
--	"CHAT_MSG_RAID_BOSS_WHISPER",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO add https://www.wowhead.com/ptr-2/spell=1247672/hyper-infusion stuff later for mythic
--TODO, alert rooted players? https://www.wowhead.com/ptr-2/spell=1237307/lair-weaving
--TODO, Infused Tangles spawns and auto marking?
--TODO, valid ID/event for primal spellstorm, current mod implimentedation is temporary
--TODO, do stuff with https://www.wowhead.com/ptr-2/spell=1226366/living-silk ?
--TODO, is https://www.wowhead.com/ptr-2/spell=1227689/silken-onslaught still used? it's not in journal
--TODO, does arcane outrage target everyone or just certain players? ladder is assumed for now
--[[
ability.id = 1228070 and type = "applybuff"
--]]
--Phase 1: The Silkbound Beast
mod:AddTimerLine(DBM:EJ_GetSectionInfo(32296))
local warnPrimalSpellstorm							= mod:NewCountAnnounce(1226867, 3)
local warnInfusionTether							= mod:NewTargetAnnounce(1226315, 2)
local warnInfusionTetherOver						= mod:NewFadesAnnounce(1226315, 1)

local specWarnLairWeaving							= mod:NewSpecialWarningDodgeCount(1237272, nil, nil, nil, 2, 2)
local specWarnOverinfusionBurst						= mod:NewSpecialWarningDodge(1226395, nil, nil, nil, 3, 2)
local specWarnInfusionTether						= mod:NewSpecialWarningYou(1226315, nil, nil, nil, 1, 2)
local yellInfusionTether							= mod:NewShortYell(1226315, nil, false)
local specWarnPiercingStrands						= mod:NewSpecialWarningDefensive(1227263, nil, nil, nil, 1, 2)
local specWarnPiercingStrandsOther					= mod:NewSpecialWarningTaunt(1227263, nil, nil, nil, 1, 2)
--local specWarnGTFO								= mod:NewSpecialWarningGTFO(459785, nil, nil, nil, 1, 8)

local timerLairWeavingCD							= mod:NewNextCountTimer(85, 1237272, nil, nil, nil, 2)
--local timerPrimalSpellstormCD						= mod:NewAITimer(97.3, 1226867, nil, nil, nil, 3)
local timerOverinfusionBurstCD						= mod:NewNextCountTimer(85, 1226395, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerInfusionTetherCD							= mod:NewCDCountTimer(97.3, 1226315, nil, nil, nil, 3)
local timerPiercingStrandsCD						= mod:NewCDCountTimer(97.3, 1227263, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)

mod:AddNamePlateOption("NPAuraOnWovenWard", 1238502)
--Phase 2: The Deathbound Beast
mod:AddTimerLine(DBM:EJ_GetSectionInfo(32303))
local specWarnUnboundRage							= mod:NewSpecialWarningSpell(1228059, nil, nil, nil, 2, 2)

local specWarnArcaneOutrage							= mod:NewSpecialWarningYou(1237307, nil, nil, nil, 1, 13)
local specWarnWrithingWave							= mod:NewSpecialWarningCount(1227226, nil, nil, nil, 2, 2)
local specWarnWrithingWaveTaunt						= mod:NewSpecialWarningTaunt(1227226, nil, nil, nil, 1, 2)

local timerUnboundrageCast							= mod:NewCastTimer(5.8, 1228059, nil, nil, nil, 2)
local timerArcaneOutrageCD							= mod:NewNextCountTimer(20, 1237307, nil, nil, nil, 3)
local timerWrithingWaveCD							= mod:NewNextCountTimer(20, 1227226, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)

mod.vb.weavingCount = 0
mod.vb.primalSpellstormCount = 0
mod.vb.overinfusionBurstCount = 0--Stage 1 only
mod.vb.infusionTetherCount = 0--Also used for Arcane Outrage (mechanic that replaces it)
mod.vb.piercingStrandsCount = 0--Also used for Writhing Wave (mechanic that replaces it)

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.weavingCount = 0
	self.vb.primalSpellstormCount = 0
	self.vb.overinfusionBurstCount = 0
	self.vb.infusionTetherCount = 0
	self.vb.piercingStrandsCount = 0
--	timerPrimalSpellstormCD:Start(1-delay)--Not logged, just damage
	timerPiercingStrandsCD:Start(9.5-delay, 1)
	timerInfusionTetherCD:Start(22-delay, 1)
	timerLairWeavingCD:Start(44-delay, 1)
	timerOverinfusionBurstCD:Start(76-delay, 1)
	if self.Options.NPAuraOnWovenWard then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.NPAuraOnWovenWard then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 1227263 then
		self.vb.piercingStrandsCount = self.vb.piercingStrandsCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnPiercingStrands:Show()
			specWarnPiercingStrands:Play("defensive")
		end
		--"Piercing Strand-1227263-npc:233815-00005FCA0D = pull:9.5, 6.0, 40.5, 4.0, 34.5, 6.0, 40.5, 4.0, 34.5, 6.0, 40.5, 4.0, 34.5, 6.0, 40.5, 4.0, 34.5, 6.0",
		if self.vb.piercingStrandsCount % 4 == 0 then
			timerPiercingStrandsCD:Start(34.5, self.vb.piercingStrandsCount+1)
		elseif self.vb.piercingStrandsCount % 4 == 2 then
			timerPiercingStrandsCD:Start(40.5, self.vb.piercingStrandsCount+1)
		elseif self.vb.piercingStrandsCount % 4 == 1 then
			timerPiercingStrandsCD:Start(6, self.vb.piercingStrandsCount+1)
		else
			timerPiercingStrandsCD:Start(4, self.vb.piercingStrandsCount+1)
		end
	elseif spellId == 1227782 then
		self.vb.infusionTetherCount = self.vb.infusionTetherCount + 1
		timerArcaneOutrageCD:Start(nil, self.vb.infusionTetherCount+1)
	elseif spellId == 1227226 then
		self.vb.piercingStrandsCount = self.vb.piercingStrandsCount + 1
		specWarnWrithingWave:Show(self.vb.piercingStrandsCount)
		timerWrithingWaveCD:Start(nil, self.vb.piercingStrandsCount+1)
		if self.vb.piercingStrandsCount % 2 == 0 then
			specWarnWrithingWave:Play("sharetwo")
		else
			specWarnWrithingWave:Play("shareone")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 1226395 then
		self.vb.overinfusionBurstCount = self.vb.overinfusionBurstCount + 1
		specWarnOverinfusionBurst:Show()
		specWarnOverinfusionBurst:Play("watchstep")
		timerOverinfusionBurstCD:Start(nil, self.vb.overinfusionBurstCount+1)
	elseif spellId == 1237272 then
		self.vb.weavingCount = self.vb.weavingCount + 1
		specWarnLairWeaving:Show(self.vb.weavingCount)
		specWarnLairWeaving:Play("specialsoon")--Generic for now
		timerLairWeavingCD:Start(nil, self.vb.weavingCount+1)
	--elseif spellId == 1226867 or spellId == 1230115 then
	--	self.vb.primalSpellstormCount = self.vb.primalSpellstormCount + 1
	--	warnPrimalSpellstorm:Show(self.vb.primalSpellstormCount)
	--	timerPrimalSpellstormCD:Start()--nil, self.vb.primalSpellstormCount+1
	--elseif spellId == 1226315 then
	--	self.vb.infusionTetherCount = self.vb.infusionTetherCount + 1
	--	timerInfusionTetherCD:Start()--nil, self.vb.infusionTetherCount+1
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 1226311 then
		if self:AntiSpam(10, 1) then
			self.vb.infusionTetherCount = self.vb.infusionTetherCount + 1
			--"Infusion Tether-1226311-npc:233815-00005FCA0D = pull:22.0[+3], 39.0[+3], 46.0[+3], 39.0[+3], 46.0[+3], 39.0[+3], 46.0[+3], 39.0[+3], 46.0[+3]",
			local timer = self.vb.infusionTetherCount % 2 == 0 and 46 or 39
			timerInfusionTetherCD:Start(timer, self.vb.infusionTetherCount+1)
		end
		warnInfusionTether:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnInfusionTether:Show()
			specWarnInfusionTether:Play("lineyou")
			yellInfusionTether:Yell()
		end
	elseif spellId == 1238502 then
		if self.Options.NPAuraOnWovenWard then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 1237212 and not args:IsPlayer() then
		specWarnPiercingStrandsOther:Show(args.destName)
		specWarnPiercingStrandsOther:Play("tauntboss")
	elseif spellId == 1227784 then
		if args:IsPlayer() then
			specWarnArcaneOutrage:Show()
			specWarnArcaneOutrage:Play("pushbackincoming")
			if self:IsMythic() then
				specWarnArcaneOutrage:ScheduleVoice(1.5, "scatter")
			end
		end
	elseif spellId == 1227163 and not args:IsPlayer() then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			specWarnWrithingWaveTaunt:Show(args.destName)
			specWarnWrithingWaveTaunt:Play("tauntboss")
		end
	elseif spellId == 1228070 and self:GetStage(1) then--Unbound Rage (backup)
		self:SetStage(1.5)
		timerLairWeavingCD:Stop()
		--timerPrimalSpellstormCD:Stop()
		timerOverinfusionBurstCD:Stop()
		timerInfusionTetherCD:Stop()
		timerPiercingStrandsCD:Stop()
		specWarnUnboundRage:Show()
		specWarnUnboundRage:Play("carefly")
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 1226311 then
		if args:IsPlayer() then
			warnInfusionTetherOver:Show()
		end
	elseif spellId == 1238502 then
		if self.Options.NPAuraOnWovenWard then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
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
	--"<380.92 13:03:50> [UNIT_SPELLCAST_SUCCEEDED] Loom'ithar(49.7%-51.0%){Target:??} -Unbound Rage- [[boss1:Cast-3-5770-2810-2807-1228059-0010DFCC16:1228059]]",
	--"<386.71 13:03:56> [UNIT_SPELLCAST_SUCCEEDED] Loom'ithar(46.0%-0.0%){Target:??} -Unbound Rage- [[boss1:Cast-3-5770-2810-2807-1228069-00C15FCC1B
	if spellId == 1228059 and self:GetStage(1) then--Unbound Rage (comes 6 seconds sooner than CLEU
		self:SetStage(1.5)
		timerLairWeavingCD:Stop()
		--timerPrimalSpellstormCD:Stop()
		timerOverinfusionBurstCD:Stop()
		timerInfusionTetherCD:Stop()
		timerPiercingStrandsCD:Stop()
		specWarnUnboundRage:Show()
		specWarnUnboundRage:Play("carefly")
		timerUnboundrageCast:Start()
		--timerPrimalSpellstormCD:Start(2)
		timerArcaneOutrageCD:Start(16, 1)
		timerWrithingWaveCD:Start(23, 1)
	elseif spellId == 1227775 then--Energy Controller 2 [DNT]
		self:SetStage(2)
		self.vb.weavingCount = 0
		self.vb.primalSpellstormCount = 0
		self.vb.infusionTetherCount = 0--Also used for Arcane Outrage (mechanic that replaces it)
		self.vb.piercingStrandsCount = 0--Also used for Writhing Wave (mechanic that replaces it)
		--timerPrimalSpellstormCD:Start(2)
		timerArcaneOutrageCD:Update(13, 16, 1)
		timerWrithingWaveCD:Update(13, 23, 1)
	end
end
