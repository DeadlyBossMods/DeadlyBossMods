local mod	= DBM:NewMod(2645, "DBM-Raids-WarWithin", 2, 1296)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(229953)
mod:SetEncounterID(3015)
mod:SetUsedIcons(6, 4, 3, 2)
mod:SetHotfixNoticeRev(20250321000000)
mod:SetMinSyncRevision(20250209000000)
mod:SetZone(2769)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 1216142 474461 472659 472782 470910 466470 466509 1221302 466518 472458 466545 1221299 469491 1217791 1215953 1216142 1215481 463967",--1214991
	"SPELL_CAST_SUCCESS 467380 468728 468794 467379",
	"SPELL_AURA_APPLIED 472631 466476 467202 467225 467380 469369 1215591 1222948 469490 469601 1215898 471419 1219283",--1222408
	"SPELL_AURA_APPLIED_DOSE 466385",--469391
	"SPELL_AURA_REMOVED 466459 466460 467202 467380 469369 1222948 469490 1215898 472631",
	"SPELL_PERIODIC_DAMAGE 474554 470089 472057",
	"SPELL_PERIODIC_MISSED 474554 470089 472057",
	"RAID_BOSS_WHISPER",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, if blizzard doesn't fix being able to detect fixate targets using target scanning, create a nameplate iterator to track fixate targets
--[[
(ability.id = 463967 or ability.id = 1215953 or ability.id = 1216142) and type = "begincast"
or (ability.id = 468728 or ability.id = 468794) and type = "cast"
or ability.id = 1222408 and type = "applybuff"
or (ability.id = 466459 or ability.id = 466460) and type = "removebuff"
--]]
--Stage One: The Heads of Security
mod:AddTimerLine(DBM:EJ_GetSectionInfo(31662))
local warnHHMug										= mod:NewSpellAnnounce(466459, 3)
local warnHHZee										= mod:NewSpellAnnounce(466460, 3)
local warnHHMugZee									= mod:NewSpellAnnounce(1222408, 2)
local warnMoxie										= mod:NewStackAnnounce(466385, 2)

local specWarnDoubleMindedFury						= mod:NewSpecialWarningSpell(1216142, nil, nil, nil, 3, 2)
local specWarnGTFO									= mod:NewSpecialWarningGTFO(474554, nil, nil, nil, 1, 8)

local timerDoubleMindedFuryCD						= mod:NewNextTimer(97.3, 1216142, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
--Mug
mod:AddTimerLine(DBM:EJ_GetSectionInfo(31677))
local warnSolidGold									= mod:NewTargetNoFilterAnnounce(467225, 2)
local warnEarthshakerGaol							= mod:NewTargetCountAnnounce(474461, 3, nil, nil, nil, nil, nil, nil, true)

local specWarnEarthshakerGaol						= mod:NewSpecialWarningYou(474461, nil, nil, nil, 1, 2)
local yellEarthshakerGaol							= mod:NewShortPosYell(474461, nil, nil, nil, "YELL")
local yellEarthshakerGaolFades						= mod:NewIconFadesYell(474461, nil, nil, nil, "YELL")
local specWarnFrostshatterBoots						= mod:NewSpecialWarningYou(466476, nil, nil, nil, 1, 2)
local specWarnStormfuryFingerGunYou					= mod:NewSpecialWarningYouCount(466509, nil, nil, nil, 2, 15)
local specWarnStormfuryFingerGun					= mod:NewSpecialWarningDodgeCount(466509, nil, nil, nil, 2, 15)
local specWarnMoltenGoldKnuckles					= mod:NewSpecialWarningDefensive(466518, nil, nil, nil, 1, 2)
local specWarnGoldenDripTaunt						= mod:NewSpecialWarningTaunt(467202, nil, nil, nil, 1, 2)
local specWarnGoldenDripMove						= mod:NewSpecialWarningKeepMove(467202, nil, nil, nil, 1, 2)

local timerEarthshakerGaolCD						= mod:NewCDCountTimer(35, 474461, nil, nil, nil, 3)
local timerFrostshatterBootsCD						= mod:NewCDCountTimer(30, 466476, nil, nil, nil, 3)
local timerSpearCast								= mod:NewCastTimer(8, 466480, nil, nil, nil, 5)
local timerStormfuryFingerGunCD						= mod:NewCDCountTimer(29, 466509, nil, nil, nil, 3)
local timerMoltenGoldKnucklesCD						= mod:NewVarCountTimer(40, 466518, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)

mod:AddSetIconOption("SetIconOnGaol", 474461, true, 4, {6, 4, 3, 2})
--Gallagio Goon
mod:AddTimerLine(DBM:EJ_GetSectionInfo(31679))
--local warnEnraged									= mod:NewTargetNoFilterAnnounce(1214623, 2)--Requires unfiltered unit events, so not doing unless required/requested

local specWarnShakedown								= mod:NewSpecialWarningDodge(472659, nil, nil, nil, 2, 15)
local specWarnPayRespects							= mod:NewSpecialWarningInterruptCount(472782, "HasInterrupt", nil, nil, 1, 2)
local specWarnGaolBreak								= mod:NewSpecialWarningSpell(470910, nil, nil, nil, 2, 2)

local timerShakedownCD								= mod:NewCDNPTimer(3, 472659, nil, false, nil, 3)
local timerPayRespectsCD							= mod:NewCDNPTimer(9.8, 472782, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)--9.8-13.3
--Zee
mod:AddTimerLine(DBM:EJ_GetSectionInfo(31693))
local warnUnstableCrawlerMines						= mod:NewCountAnnounce(466539, 2)
local warnSprayandPray								= mod:NewTargetNoFilterAnnounce(466545, 2)
--local warnSurgingArc								= mod:NewTargetAnnounce(1214991, 2)
local warnElectroShocker							= mod:NewCountAnnounce(-31766, 1, 1215591)
local warnDisintegrationBeam						= mod:NewTargetNoFilterAnnounce(1215481, 2)--Might be spammy
local warnDoubleWhammy								= mod:NewTargetNoFilterAnnounce(469491, 2, nil, "Tank")

local specWarnGoblinGuidedRocket					= mod:NewSpecialWarningMoveTo(467380, nil, nil, nil, 1, 2)
local yellGoblinGuidedRocket						= mod:NewYell(467380, DBM_COMMON_L.GROUPSOAK, nil, nil, "YELL")
local yellGoblinGuidedRocketFades					= mod:NewShortFadesYell(467380, nil, nil, nil, "YELL")
local specWarnSprayandPray							= mod:NewSpecialWarningMoveAway(466545, nil, nil, nil, 1, 2)
local yellSprayandPray								= mod:NewYell(466545)
local yellSprayandPrayFades							= mod:NewShortFadesYell(466545)
--local specWarnSurgingArc							= mod:NewSpecialWarningYou(1214991, nil, nil, nil, 1, 2)
--local yellSurgingArc								= mod:NewYell(1214991, nil, false, 2)
local specWarnDoubleWhammy							= mod:NewSpecialWarningSoak(469491, nil, nil, nil, 1, 2)
local specWarnDoubleWhammyVictim					= mod:NewSpecialWarningYou(469491, nil, nil, nil, 1, 17)
local yellDoubleWhammy								= mod:NewYell(469491, DBM_COMMON_L.TANK.." "..DBM_COMMON_L.GROUPSOAK, nil, nil, "YELL")
local yellDoubleWhammyFades							= mod:NewShortFadesYell(469491, nil, nil, nil, "YELL")
local specWarnDoubleWhammyTaunt						= mod:NewSpecialWarningTaunt(469391, nil, nil, nil, 1, 2)--Perforating wound is debuff name

local timerUnstableCrawlerMinesCD					= mod:NewCDCountTimer(44.0, 466539, nil, nil, nil, 1)
local timerGoblinGuidedRocketCD						= mod:NewCDCountTimer(41.9, 467380, nil, nil, nil, 3)
local timerSprayandPrayCD							= mod:NewCDCountTimer(70, 466545, nil, nil, nil, 3)
--local timerSurgingArcCD							= mod:NewCDNPTimer(20.5, 1214991, nil, nil, nil, 3)
local timerDoubleWhammyCD							= mod:NewCDCountTimer(70, 469491, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerElectroShockerCD							= mod:NewCDCountTimer(30, -31766, 1215591, nil, nil, 1)

mod:AddPrivateAuraSoundOption(472354, true, 466539, 1)--Fixate debuff linked to unstable crawler mines
mod:AddNamePlateOption("NPAuraOnChargedShield", 1222948)
mod:AddSetIconOption("SetIconOnMines", 466539, false, 5, {1, 2, 3, 4, 5, 6, 7, 8}, true)
--Intermission: Bulletstorm
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30517))
local specWarnElectrocutionMatrix					= mod:NewSpecialWarningDodge(1216495, nil, nil, nil, 3, 2)
local specWarnStaticCharge							= mod:NewSpecialWarningYou(1215953, nil, nil, nil, 2, 2)
local yellStaticCharge								= mod:NewYell(1215953)
local yellStaticChargeFades							= mod:NewShortFadesYell(1215953)
local specWarnStaticChargeOther						= mod:NewSpecialWarningMoveTo(1215953, nil, nil, nil, 1, 2)
local specWarnBulletstorm							= mod:NewSpecialWarningDodgeCount(471419, nil, nil, nil, 2, 2)

local timerStaticChargeCD							= mod:NewCDCountTimer(14, 1215953, nil, nil, nil, 3)
local timerBulletstormCD							= mod:NewCDCountTimer(14, 471419, nil, nil, nil, 3)
local timerIntermission								= mod:NewIntermissionTimer(20.5, 471419, nil, nil, nil, 6)
--Stage Two: The Head Honcho
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30510))
local warnPhase										= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)

mod.vb.gaolCount = 0
mod.vb.frostShatterCount = 0
mod.vb.fingerGunCount = 0
mod.vb.knucklesCount = 0
mod.vb.crawlerMinesCount = 0
mod.vb.goblinGuidedRocketCount = 0
mod.vb.sprayPrayCount = 0
mod.vb.whammyCount = 0
mod.vb.chargeCount = 0
mod.vb.bulletCount = 0
mod.vb.mineIcon = 1
mod.vb.addCount = 0
local castsPerGUID = {}
local GaolIcons = {}

--[[
function mod:ArcTarget(targetname)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnSurgingArc:Show()
		specWarnSurgingArc:Play("targetyou")
		yellSurgingArc:Yell()
--	else
--		warnSurgingArc:Show(targetname)
	end
end
--]]

function mod:SprayTarget(targetname)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnSprayandPray:Show()
		specWarnSprayandPray:Play("runout")
		yellSprayandPray:Yell()
	else
		warnSprayandPray:Show(targetname)
	end
end

function mod:FingerTarget(targetname)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnStormfuryFingerGunYou:Show(self.vb.fingerGunCount)
		specWarnStormfuryFingerGunYou:Play("frontal")
	else
		specWarnStormfuryFingerGun:Show(self.vb.fingerGunCount)
		specWarnStormfuryFingerGun:Play("frontal")
	end
end

function mod:BeamTarget(targetname)
	if not targetname then return end
	warnDisintegrationBeam:Show(targetname)
end

function mod:OnCombatStart(delay)
	self.vb.gaolCount = 0
	self.vb.frostShatterCount = 0
	self.vb.fingerGunCount = 0
	self.vb.knucklesCount = 0
	self.vb.crawlerMinesCount = 0
	self.vb.goblinGuidedRocketCount = 0
	self.vb.sprayPrayCount = 0
	self.vb.whammyCount = 0
	self.vb.chargeCount = 0
	self.vb.bulletCount = 0
	self.vb.addCount = 0
	table.wipe(castsPerGUID)
	self:EnablePrivateAuraSound(472354, "bombyou", 12)
	if self.Options.NPAuraOnChargedShield then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.NPAuraOnChargedShield then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 1216142 then
		specWarnDoubleMindedFury:Show()
		specWarnDoubleMindedFury:Play("stilldanger")
	elseif spellId == 474461 then
		table.wipe(GaolIcons)
		self.vb.gaolCount = self.vb.gaolCount + 1
	elseif spellId == 472659 then
		--timerShakedownCD:Start(nil, args.sourceGUID)
		if self:CheckBossDistance(args.sourceGUID, false, 8149, 8) and self:AntiSpam(3, 4) then
			specWarnShakedown:Show()
			specWarnShakedown:Play("frontal")
		end
	elseif spellId == 470910 then
		if self:CheckBossDistance(args.sourceGUID, false, 8149, 8) and self:AntiSpam(3, 5) then
			specWarnGaolBreak:Show()
			specWarnGaolBreak:Play("carefly")
		end
	elseif spellId == 472782 then
		timerPayRespectsCD:Start(nil, args.sourceGUID)
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnPayRespects:Show(args.sourceName, count)
			if count == 1 then
				specWarnPayRespects:Play("kick1r")
			elseif count == 2 then
				specWarnPayRespects:Play("kick2r")
			elseif count == 3 then
				specWarnPayRespects:Play("kick3r")
			elseif count == 4 then
				specWarnPayRespects:Play("kick4r")
			elseif count == 5 then
				specWarnPayRespects:Play("kick5r")
			else
				specWarnPayRespects:Play("kickcast")
			end
		end
	elseif spellId == 466470 then
		self.vb.frostShatterCount = self.vb.frostShatterCount + 1
		if self:IsHeroic() and self:GetStage(3) and self.vb.frostShatterCount == 1 then
			--Two casts on heroic and normal (not anymore on normal?)
			timerFrostshatterBootsCD:Start(86.2, self.vb.frostShatterCount+1)
		end
	elseif spellId == 466509 or spellId == 1221302 then
		self.vb.fingerGunCount = self.vb.fingerGunCount + 1
		--Not cast twice on any difficulty anymore (unless changed on mythic
		--"<50.04 19:08:54> [CLEU] SPELL_CAST_START#Creature-0-3891-2769-17440-229953-0000530C76#Mug'Zee(86.7%-79.0%)##nil#466509#Stormfury Finger Gun#nil#nil#nil#nil#nil#nil",
		--"<50.04 19:08:54> [UNIT_SPELLCAST_SUCCEEDED] Mug'Zee(86.7%-79.0%){Target:Meêres} -Stormfury Finger Gun- [[boss1:Cast-3-3891-2769-17440-1225933-000E531F36:1225933]]",
		--"<50.04 19:08:54> [UNIT_SPELLCAST_SUCCEEDED] Mug'Zee(86.7%-79.0%){Target:Meêres} -Stormfury Finger Gun- [[boss1:Cast-3-3891-2769-17440-466508-000D531F36:466508]]",
		--"<50.06 19:08:54> [UNIT_TARGET] boss1#Mug'Zee#Target: Wallifexd#TargetOfTarget: Mug'Zee",
		self:ScheduleMethod(0.1, "BossTargetScanner", args.sourceGUID, "FingerTarget", 0.1, 8)
	elseif spellId == 466518 then
		self.vb.knucklesCount = self.vb.knucklesCount + 1
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnMoltenGoldKnuckles:Show()
			specWarnMoltenGoldKnuckles:Play("carefly")
		end
	elseif spellId == 472458 then
		self.vb.crawlerMinesCount = self.vb.crawlerMinesCount + 1
		self.vb.mineIcon = 1
		warnUnstableCrawlerMines:Show(self.vb.crawlerMinesCount)
		--Same on normal, heroic, and mythic
		if self:GetStage(3) and self.vb.crawlerMinesCount == 1 then
			timerUnstableCrawlerMinesCD:Start(88.7, self.vb.crawlerMinesCount+1)
		end
	elseif spellId == 466545 or spellId == 1221299 then
		self.vb.sprayPrayCount = self.vb.sprayPrayCount + 1
		--if self:GetStage(3) then
		--	timerSprayandPrayCD:Start("v62-68.1", self.vb.sprayPrayCount+1)--Not recast in stage 1 after initial
		--end
		--"<110.48 19:09:54> [CLEU] SPELL_CAST_START#Creature-0-3891-2769-17440-229953-0000530C76#Mug'Zee(75.9%-79.0%)##nil#466545#Spray and Pray#nil#nil#nil#nil#nil#nil",
		--"<110.48 19:09:54> [UNIT_SPELLCAST_SUCCEEDED] Mug'Zee(75.9%-79.0%){Target:Meêres} -Spray and Pray- [[boss1:Cast-3-3891-2769-17440-469369-005BD31F72:469369]]",
		--"<110.48 19:09:54> [UNIT_SPELLCAST_SUCCEEDED] Mug'Zee(75.9%-79.0%){Target:Meêres} -Spray and Pray- [[boss1:Cast-3-3891-2769-17440-466544-005AD31F72:466544]]",
		--"<110.52 19:09:54> [UNIT_TARGET] boss1#Mug'Zee#Target: Hopefulgg#TargetOfTarget: Mug'Zee",
		self:ScheduleMethod(0.1, "BossTargetScanner", args.sourceGUID, "SprayTarget", 0.1, 8)
--	elseif spellId == 1214991 then
		--timerSurgingArcCD:Start(nil, args.sourceGUID)
		--self:ScheduleMethod(0.1, "BossTargetScanner", args.sourceGUID, "ArcTarget", 0.1, 8)
--	elseif spellId == 469491 or spellId == 1223085 then--Early PTR, late PTR/Live
--		self.vb.whammyCount = self.vb.whammyCount + 1
	elseif spellId == 1217791 then
		specWarnElectrocutionMatrix:Show()
		specWarnElectrocutionMatrix:Play("watchstep")
	elseif spellId == 1215953 then
		self.vb.chargeCount = self.vb.chargeCount + 1
		if self.vb.chargeCount < 3 then
			timerStaticChargeCD:Start(nil, self.vb.chargeCount+1)
		end
		if self:GetStage(2.5, 1) then
			self:SetStage(2.5)
			warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2.5))
			warnPhase:Play("phasechange")
			timerBulletstormCD:Start(3.4, 1)
			timerIntermission:Start(52.9)
		end
	elseif spellId == 1215481 then
		self:ScheduleMethod(0.1, "BossTargetScanner", args.sourceGUID, "BeamTarget", 0.1, 8)
	elseif spellId == 463967 then--Bloodlust
		self:SetStage(3)
		--Reset Counts
		self.vb.gaolCount = 0
		self.vb.frostShatterCount = 0
		self.vb.fingerGunCount = 0
		self.vb.knucklesCount = 0
		self.vb.crawlerMinesCount = 0
		self.vb.goblinGuidedRocketCount = 0
		self.vb.sprayPrayCount = 0
		self.vb.whammyCount = 0
		self.vb.addCount = 0
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(3))
		warnPhase:Play("ptwo")
		warnHHMugZee:Show()
		timerEarthshakerGaolCD:Stop()
		timerFrostshatterBootsCD:Stop()
		timerStormfuryFingerGunCD:Stop()
		timerMoltenGoldKnucklesCD:Stop()
		timerUnstableCrawlerMinesCD:Stop()
		timerGoblinGuidedRocketCD:Stop()
		timerSprayandPrayCD:Stop()
		timerDoubleWhammyCD:Stop()
		timerStaticChargeCD:Stop()
		timerBulletstormCD:Stop()
		timerElectroShockerCD:Stop()
		--Restart all timers
		--Timers same in all
		timerUnstableCrawlerMinesCD:Start(3.7, 1)
		timerFrostshatterBootsCD:Start(16.2, 1)
		timerEarthshakerGaolCD:Start(self:IsMythic() and 32.2 or 32.8, 1)
		timerGoblinGuidedRocketCD:Start(40, 1)
		timerElectroShockerCD:Start(47.5, 1)--Only place it has timer, otherwise they just spawn when mug loses control
		timerMoltenGoldKnucklesCD:Start(50, 1)
		timerStormfuryFingerGunCD:Start(62.4, 1)
		timerDoubleWhammyCD:Start(self:IsMythic() and 71.2 or 71.8, 1)
		timerSprayandPrayCD:Start(81.2, 1)
		timerDoubleMindedFuryCD:Start(118)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 468728 then--Mug Taking Charge
		self:SetStage(1)--Match BW odd behavior
		warnHHMug:Show()
		timerEarthshakerGaolCD:Start(17.4, self.vb.gaolCount+1)
		if self:IsMythic() then
			timerMoltenGoldKnucklesCD:Start(27.8, self.vb.knucklesCount+1)
			timerFrostshatterBootsCD:Start(34.7, self.vb.frostShatterCount+1)
			timerStormfuryFingerGunCD:Start(50, self.vb.fingerGunCount+1)
		elseif self:IsHeroic() then
			timerMoltenGoldKnucklesCD:Start(30.5, self.vb.knucklesCount+1)
			timerFrostshatterBootsCD:Start(42.8, self.vb.frostShatterCount+1)
			timerStormfuryFingerGunCD:Start(55, self.vb.fingerGunCount+1)
		else
			timerMoltenGoldKnucklesCD:Start(34.7, self.vb.knucklesCount+1)
			timerFrostshatterBootsCD:Start(46.6, self.vb.frostShatterCount+1)
			timerStormfuryFingerGunCD:Start(60, self.vb.fingerGunCount+1)
		end
	elseif spellId == 468794 then--Zee Taking Charge
		self:SetStage(2)
		warnHHZee:Show()
		--Shared timers
		timerUnstableCrawlerMinesCD:Start(13.9, self.vb.crawlerMinesCount+1)
		if self:IsMythic() then
			timerGoblinGuidedRocketCD:Start(29.8, self.vb.goblinGuidedRocketCount+1)--SUCCESS
			timerDoubleWhammyCD:Start(38.9, self.vb.whammyCount+1)
			timerSprayandPrayCD:Start(50, self.vb.sprayPrayCount+1)
		elseif self:IsHeroic() then
			timerGoblinGuidedRocketCD:Start(32.6, self.vb.goblinGuidedRocketCount+1)--SUCCESS
			timerDoubleWhammyCD:Start(42.8, self.vb.whammyCount+1)
			timerSprayandPrayCD:Start(55, self.vb.sprayPrayCount+1)
		else
			timerGoblinGuidedRocketCD:Start(35, self.vb.goblinGuidedRocketCount+1)--SUCCESS
			timerDoubleWhammyCD:Start(46.5, self.vb.whammyCount+1)
			timerSprayandPrayCD:Start(60, self.vb.sprayPrayCount+1)
		end
	--elseif spellId == 467380 or spellId == 467379 then
	--	self.vb.goblinGuidedRocketCount = self.vb.goblinGuidedRocketCount + 1
	end
end

local useIcons = {4, 6, 3, 2} -- 4 in mythic?
---@param self DBMMod
local function sortGaol(self)
	table.sort(GaolIcons, DBM.SortByRangedRoster)
	for i = 1, #GaolIcons do
		local name = GaolIcons[i]
		local icon = useIcons[i]
		if self.Options.SetIconOnGaol then
			--Mythic uses same icons in pairs, so people are paired up with same mark, can't mark both so only marks 1 of them
			self:SetIcon(name, icon)
		end
		if name == DBM:GetMyPlayerInfo() then
			specWarnEarthshakerGaol:Show()
			specWarnEarthshakerGaol:Play("targetyou")
			yellEarthshakerGaol:Yell(icon)
			yellEarthshakerGaolFades:Countdown(472631, nil, icon)
		end
	end
	warnEarthshakerGaol:Show(self.vb.gaolCount+1, table.concat(GaolIcons, "<, >"))
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 466385 then
		local amount = args.amount or 1
		if amount % 10 == 0 then
			warnMoxie:Show(args.destName, amount)
		end
	elseif spellId == 472631 then
		GaolIcons[#GaolIcons+1] = args.destName
		local expectedTotal = self:IsMythic() and 4 or 2--Mythic assumed to be 4, but not confirmed yet
		local alivePlayers = DBM:NumRealAlivePlayers()
		--Auto scale expected if there aren't enough living players to meet it
		if expectedTotal > alivePlayers then
			expectedTotal = alivePlayers
		end
		self:Unschedule(sortGaol)
		if #GaolIcons == expectedTotal then
			sortGaol(self)
		else
			self:Schedule(0.5, sortGaol, self)--Fallback in case scaling targets for normal/heroic
		end
	elseif spellId == 466476 then
		if args:IsPlayer() then
			specWarnFrostshatterBoots:Show()
			specWarnFrostshatterBoots:Play("targetyou")
		end
		if self:AntiSpam(3, 1) then
			timerSpearCast:Start()
		end
	elseif spellId == 467202 then
		if args:IsPlayer() then
			specWarnGoldenDripMove:Show()
			specWarnGoldenDripMove:Play("keepmove")
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			if self:IsTanking(uId) then
				specWarnGoldenDripTaunt:Show(args.destName)
				specWarnGoldenDripTaunt:Play("tauntboss")
			end
		end
	elseif spellId == 467225 then
		warnSolidGold:Show(args.destName)
	elseif spellId == 467380 then
		self.vb.goblinGuidedRocketCount = self.vb.goblinGuidedRocketCount + 1
		if args:IsPlayer() then
			specWarnGoblinGuidedRocket:Show(DBM_COMMON_L.ALLIES)
			specWarnGoblinGuidedRocket:Play("gathershare")
			yellGoblinGuidedRocket:Yell()
			yellGoblinGuidedRocketFades:Countdown(spellId)
		else
			if self:IsHard() then
				--Split soaking due to https://www.wowhead.com/ptr-2/spell=469076/radiation-sickness
				if self.vb.goblinGuidedRocketCount % 2 == 1 then
					specWarnGoblinGuidedRocket:Play("shareone")
				else
					specWarnGoblinGuidedRocket:Play("sharetwo")
				end
			else
				specWarnGoblinGuidedRocket:Play("helpsoak")
			end
		end
	elseif spellId == 469369 then
		if args:IsPlayer() then
			yellSprayandPrayFades:Countdown(spellId)
		end
	elseif spellId == 1215591 and self:AntiSpam(3, 2) then
		self.vb.addCount = self.vb.addCount + 1
		warnElectroShocker:Show(self.vb.addCount)
	elseif spellId == 1222948 then
		if self.Options.NPAuraOnChargedShield then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	--elseif spellId == 469490 then--Pre target not in combatlog
	--	if args:IsPlayer() then
	--		specWarnDoubleWhammyVictim:Show()
	--		specWarnDoubleWhammyVictim:Play("lineyou")
	--		yellDoubleWhammy:Yell()
	--		yellDoubleWhammyFades:Countdown(spellId)
	--	end
	elseif spellId == 469601 and not args:IsPlayer() then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) and not DBM:UnitDebuff("player", spellId) then
			specWarnDoubleWhammyTaunt:Show(args.destName)
			specWarnDoubleWhammyTaunt:Play("tauntboss")
		end
	elseif spellId == 1215898 then
		if args:IsPlayer() then
			specWarnStaticCharge:Show()
			specWarnStaticCharge:Play("targetyou")
			yellStaticCharge:Yell()
			yellStaticChargeFades:Countdown(spellId)
		else
			specWarnStaticChargeOther:Show(args.destName)
			specWarnStaticChargeOther:Play("helpsoak")
		end
	elseif spellId == 471419 then
		self.vb.bulletCount = self.vb.bulletCount + 1
		specWarnBulletstorm:Show(self.vb.bulletCount)
		specWarnBulletstorm:Play("watchstep")
		timerBulletstormCD:Start(nil, self.vb.bulletCount+1)
	elseif spellId == 1219283 then
		if self.Options.SetIconOnMines then
			self:ScanForMobs(args.destGUID, 2, self.vb.mineIcon, 1, nil, 12, "SetIconOnMines")
		end
		self.vb.mineIcon = self.vb.mineIcon + 1
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 466459 then--Head Honcho: Mug
		timerEarthshakerGaolCD:Stop()
		timerFrostshatterBootsCD:Stop()
		timerStormfuryFingerGunCD:Stop()
		timerMoltenGoldKnucklesCD:Stop()
		timerElectroShockerCD:Stop()
	elseif spellId == 466460 then--Head Honcho: Zee
		timerUnstableCrawlerMinesCD:Stop()
		timerGoblinGuidedRocketCD:Stop()
		timerSprayandPrayCD:Stop()
		timerDoubleWhammyCD:Stop()
	elseif spellId == 472631 then
		if args:IsPlayer() then
			yellEarthshakerGaolFades:Cancel()
		end
		if self.Options.SetIconOnGaol then
			--Mythic uses same icons in pairs, so people are paired up with same mark, can't mark both so only marks 1 of them
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 467380 then
		if args:IsPlayer() then
			yellGoblinGuidedRocketFades:Cancel()
		end
	elseif spellId == 469369 then
		if args:IsPlayer() then
			yellSprayandPrayFades:Cancel()
		end
	elseif spellId == 1222948 then
		if self.Options.NPAuraOnChargedShield then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 469490 then
		if args:IsPlayer() then
			yellDoubleWhammyFades:Cancel()
		end
	elseif spellId == 1215898 then
		if args:IsPlayer() then
			yellStaticChargeFades:Cancel()
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if (spellId == 470089 or spellId == 474554 or spellId == 472057) and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 233474 then--gallagio goon
		timerShakedownCD:Stop(args.destGUID)
		timerPayRespectsCD:Stop(args.destGUID)
--	elseif cid == 231788 then--unstable-cluster-mine

--	elseif cid == 230316 then--mk-ii-electro-shocker
		--timerSurgingArcCD:Stop(args.destGUID)
--	elseif cid == 230312 then--Volunteer Rocketeer

	end
end

function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("spell:469490") then
		specWarnDoubleWhammyVictim:Show()
		specWarnDoubleWhammyVictim:Play("lineyou")
		yellDoubleWhammy:Yell()
		--"<99.66 19:09:44> [CHAT_MSG_ADDON] RAID_BOSS_WHISPER_SYNC#|TInterface\\ICONS\\Ability_Hunter_BurstingShot.blp:20|t Zee targets you with |cFFFF0000|Hspell:469490|h[Double Wh
		--"<105.40 19:09:49> [UNIT_SPELLCAST_STOP] Mug'Zee(77.3%-70.0%){Target:XXXXX} -Double Whammy Shot- [[boss1:Cast-3-3891-2769-17440-1223085-00A2D31F6A:1223085]]"
		yellDoubleWhammyFades:Countdown(5.7)
	end
end

function mod:OnTranscriptorSync(msg, targetName)
	if msg:find("spell:469490") then
		if targetName ~= UnitName("player") then
			warnDoubleWhammy:Show(targetName)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 469490 then
		self.vb.whammyCount = self.vb.whammyCount + 1
		if self:IsTanking("player", uId, nil, true) then
			specWarnDoubleWhammy:Show()
			specWarnDoubleWhammy:Play("helpsoak")
			specWarnDoubleWhammy:ScheduleVoice(2.5, "defensive")
		end
	end
end
