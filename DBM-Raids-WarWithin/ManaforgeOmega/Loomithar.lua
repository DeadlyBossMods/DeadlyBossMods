local mod	= DBM:NewMod(2686, "DBM-Raids-WarWithin", 1, 1302)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(233815)
mod:SetEncounterID(3131)
mod:SetUsedIcons(1, 2)
mod:SetHotfixNoticeRev(20250817000000)
--mod:SetMinSyncRevision(20240921000000)
mod:SetZone(2810)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 1227263 1227782 1227226",
	"SPELL_CAST_SUCCESS 1226395 1237272",--1226315 1226867 1230115
	"SPELL_AURA_APPLIED 1226311 1238502 1237212 1228070 1227163",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 1226311 1238502",
	"SPELL_PERIODIC_DAMAGE 1243771",
	"SPELL_PERIODIC_MISSED 1243771",
	"CHAT_MSG_RAID_BOSS_WHISPER",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[
ability.id = 1228070 and type = "applybuff"
--]]
--Phase 1: The Silkbound Beast
mod:AddTimerLine(DBM:EJ_GetSectionInfo(32296))
local warnPrimalSpellstorm							= mod:NewCountAnnounce(1226867, 3)
local warnInfusionTether							= mod:NewTargetAnnounce(1226311, 2)
local warnInfusionTetherOver						= mod:NewFadesAnnounce(1226311, 1)
local warnInfusionPylon								= mod:NewCountAnnounce(1246921, 3)

local specWarnLairWeaving							= mod:NewSpecialWarningDodgeCount(1237272, nil, nil, nil, 2, 2)
local specWarnOverinfusionBurst						= mod:NewSpecialWarningDodge(1226395, nil, nil, nil, 3, 2)
local specWarnInfusionTether						= mod:NewSpecialWarningYou(1226311, nil, nil, nil, 1, 2)
local yellInfusionTether							= mod:NewShortYell(1226311, nil, false)
local specWarnPiercingStrands						= mod:NewSpecialWarningDefensive(1237212, nil, nil, nil, 1, 2)
local specWarnPiercingStrandsOther					= mod:NewSpecialWarningTaunt(1237212, nil, nil, nil, 1, 2)
local specWarnGTFO									= mod:NewSpecialWarningGTFO(1243771, nil, nil, nil, 1, 8)

local timerLairWeavingCD							= mod:NewNextCountTimer(85, 1237272, nil, nil, nil, 2)
local timerPrimalSpellstormCD						= mod:NewCDCountTimer(97.3, 1226867, nil, nil, nil, 3)
local timerOverinfusionBurstCD						= mod:NewNextCountTimer(85, 1226395, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)--???
local timerInfusionTetherCD							= mod:NewCDCountTimer(97.3, 1226311, nil, nil, nil, 3)
local timerPiercingStrandsCD						= mod:NewCDCountTimer(97.3, 1237212, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerInfusionPylonCD							= mod:NewCDCountTimer(97.3, 1246921, nil, nil, nil, 5, nil, DBM_COMMON_L.MYTHIC_ICON)

mod:AddNamePlateOption("NPAuraOnWovenWard", 1238502)
--Phase 2: The Deathbound Beast
mod:AddTimerLine(DBM:EJ_GetSectionInfo(32303))
local specWarnUnboundRage							= mod:NewSpecialWarningSpell(1228059, nil, nil, nil, 2, 2)
local warnArcaneOutrage								= mod:NewCountAnnounce(1227782, 3)

local specWarnWrithingWave							= mod:NewSpecialWarningCount(1227226, nil, nil, nil, 2, 2)
local specWarnWrithingWaveTaunt						= mod:NewSpecialWarningTaunt(1227226, nil, nil, nil, 1, 2)

local timerUnboundrageCast							= mod:NewCastTimer(5.8, 1228059, nil, nil, nil, 2)
local timerArcaneOutrageCD							= mod:NewNextCountTimer(20, 1227782, nil, nil, nil, 3)
local timerWrithingWaveCD							= mod:NewNextCountTimer(20, 1227226, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)

mod.vb.weavingCount = 0
mod.vb.primalSpellstormCount = 0
mod.vb.overinfusionBurstCount = 0--Stage 1 only
mod.vb.pylonCount = 0
mod.vb.infusionTetherCount = 0--Also used for Arcane Outrage (mechanic that replaces it)
mod.vb.piercingStrandsCount = 0--Also used for Writhing Wave (mechanic that replaces it)

--Echo swirl timers, shared by justwait
local stormP1TimersMythic = {12, 15, 13, 15, 16, 14}
local function SwirlTimer(self)
	warnPrimalSpellstorm:Show(self.vb.primalSpellstormCount)
	self.vb.primalSpellstormCount = self.vb.primalSpellstormCount + 1
	local cdCount = self.vb.primalSpellstormCount % 6 + 1
	local timer = self:GetStage(2) and 8 or stormP1TimersMythic[cdCount]
	timerPrimalSpellstormCD:Start(timer, self.vb.primalSpellstormCount)
	self:Schedule(timer, SwirlTimer, self)
end

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.weavingCount = 0
	self.vb.primalSpellstormCount = 1
	self.vb.overinfusionBurstCount = 0
	self.vb.pylonCount = 0
	self.vb.infusionTetherCount = 0
	self.vb.piercingStrandsCount = 0
	timerPiercingStrandsCD:Start((self:IsMythic() and 12.4 or 9.5)-delay, 1)
	timerInfusionTetherCD:Start(22-delay, 1)
	if self:IsEasy() then--Used instantly on pull for heroic and mythic
		timerLairWeavingCD:Start(44-delay, 1)
	end
	timerOverinfusionBurstCD:Start(76-delay, 1)
	if self:IsMythic() then
		timerInfusionPylonCD:Start(5-delay, 1)
		self:Schedule(14-delay, SwirlTimer, self)
		timerPrimalSpellstormCD:Start(14-delay, 1)--Mythic only, can't be bothered with doing all 4 difficulties
	end
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
		if self:IsLFR() then
			local timer = self.vb.piercingStrandsCount % 2 == 0 and 41.5 or 43.5
			timerPiercingStrandsCD:Start(timer, self.vb.piercingStrandsCount+1)
		else
			if self.vb.piercingStrandsCount % 4 == 0 then
				timerPiercingStrandsCD:Start(self:IsMythic() and 36.5 or 33.5, self.vb.piercingStrandsCount+1)
			elseif self.vb.piercingStrandsCount % 4 == 2 then
				timerPiercingStrandsCD:Start(39.4, self.vb.piercingStrandsCount+1)
			elseif self.vb.piercingStrandsCount % 4 == 1 then
				timerPiercingStrandsCD:Start(self:IsMythic() and 4 or 7, self.vb.piercingStrandsCount+1)
			else
				timerPiercingStrandsCD:Start(5, self.vb.piercingStrandsCount+1)
			end
		end
	elseif spellId == 1227782 then
		self.vb.infusionTetherCount = self.vb.infusionTetherCount + 1
		warnArcaneOutrage:Show(self.vb.infusionTetherCount)
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
		if self:IsMythic() then
			if self.vb.weavingCount % 2 == 1 then
				timerLairWeavingCD:Start(7, self.vb.weavingCount+1)
			else
				if self.vb.weavingCount % 4 == 0 then
					timerLairWeavingCD:Start(34.5, self.vb.weavingCount+1)
				else
					timerLairWeavingCD:Start(36.5, self.vb.weavingCount+1)
				end
			end
		elseif self:IsHeroic() then
			if self.vb.weavingCount % 2 == 0 then
				timerLairWeavingCD:Start(41.5, self.vb.weavingCount+1)
			else
				timerLairWeavingCD:Start(43.5, self.vb.weavingCount+1)
			end
		else
			timerLairWeavingCD:Start(85, self.vb.weavingCount+1)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 1226311 then
		if self:AntiSpam(10, 1) then
			self.vb.infusionTetherCount = self.vb.infusionTetherCount + 1
			--"Infusion Tether-1226311-npc:233815-000020CBF9 = pull:22.1[+3], 44.0[+3], 41.1[+3], 44.0[+3], 41.0[+3], 44.0[+3], 41.0[+3], Stage 2/7.6",
			local timer = self.vb.infusionTetherCount % 2 == 0 and 41 or 44
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
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			specWarnPiercingStrandsOther:Show(args.destName)
			specWarnPiercingStrandsOther:Play("tauntboss")
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
		timerPrimalSpellstormCD:Stop()
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

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 1243771 and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_WHISPER(msg)
	if msg:find("spell:1246921") and self:AntiSpam(5, 5) then--Antispam isn't needed for real mod, but DBM offline needs it since it converts syncs from other players to this event
		self.vb.pylonCount = self.vb.pylonCount + 1
		warnInfusionPylon:Show(self.vb.pylonCount)
		if self.vb.pylonCount % 2 == 0 then
			timerInfusionPylonCD:Start(49.9, self.vb.pylonCount+1)
		else
			timerInfusionPylonCD:Start(34.7, self.vb.pylonCount+1)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	--"<380.92 13:03:50> [UNIT_SPELLCAST_SUCCEEDED] Loom'ithar(49.7%-51.0%){Target:??} -Unbound Rage- [[boss1:Cast-3-5770-2810-2807-1228059-0010DFCC16:1228059]]",
	--"<386.71 13:03:56> [UNIT_SPELLCAST_SUCCEEDED] Loom'ithar(46.0%-0.0%){Target:??} -Unbound Rage- [[boss1:Cast-3-5770-2810-2807-1228069-00C15FCC1B
	if spellId == 1228059 and self:GetStage(1) then--Unbound Rage (comes 6 seconds sooner than CLEU
		self:SetStage(2)
		self.vb.weavingCount = 0
		self.vb.primalSpellstormCount = 0
		self.vb.infusionTetherCount = 0--Also used for Arcane Outrage (mechanic that replaces it)
		self.vb.piercingStrandsCount = 0--Also used for Writhing Wave (mechanic that replaces it)
		timerLairWeavingCD:Stop()
		timerPrimalSpellstormCD:Stop()
		timerOverinfusionBurstCD:Stop()
		timerInfusionTetherCD:Stop()
		timerPiercingStrandsCD:Stop()
		timerInfusionPylonCD:Stop()
		specWarnUnboundRage:Show()
		specWarnUnboundRage:Play("carefly")
		timerUnboundrageCast:Start()
		if self:IsMythic() then
			timerPrimalSpellstormCD:Stop()
			self:Unschedule(SwirlTimer)
			timerPrimalSpellstormCD:Start(13, 1)
			self:Schedule(13, SwirlTimer, self)
		end
		timerWrithingWaveCD:Start(16, 1)
		timerArcaneOutrageCD:Start(23, 1)
	elseif spellId == 1227775 then--Energy Controller 2 [DNT]
		timerWrithingWaveCD:Update(13, 16, 1)
		timerArcaneOutrageCD:Update(13, 23, 1)
	end
end
