local mod	= DBM:NewMod(2524, "DBM-Aberrus", nil, 1208)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(199659)--Warlord Kagni
mod:SetEncounterID(2682)
--mod:SetUsedIcons(1, 2, 3)
mod:SetHotfixNoticeRev(20230406000000)
--mod:SetMinSyncRevision(20221215000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 404585 401258 401867 408959 397383 409271 401108 407009 410351 397386 397514",
	"SPELL_CAST_SUCCESS 401401",
	"SPELL_AURA_APPLIED 401867 402066 401381 409275 408873 410353 401452",
	"SPELL_AURA_APPLIED_DOSE 408873 410353",
	"SPELL_AURA_REMOVED 401867 402066 401452",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[
(ability.id = 410516 or ability.id = 401258 or ability.id = 408959 or ability.id = 409271 or ability.id = 401108 or ability.id = 407009 or ability.id = 410351 or ability.id = 397514) and type = "begincast"
  or (ability.id = 404585 or ability.id = 397386 or ability.id = 397383 or ability.id = 401867) and type = "begincast"
--]]
--TODO, refine slam and door aoe stack warnings for Barrier Backfire?
--TODO, nameplate aura for https://www.wowhead.com/ptr/spell=410740/from-the-ashes ? need to make sure it actually has nameplate first
--TODO, can lava flow be dodged? if so probably should be emphasized, if not, cast alert should be removed
--TOOD, adds timers when cleaner way to detect spawns, as well as timers for their initial casts
--TODO, stage 2 https://www.wowhead.com/ptr/spell=406585/ignaras-fury fury timer?
--TODO, Devastating Slam may be sequenced but needs bigger sample size
--General
local warnBatteringSlam								= mod:NewCastAnnounce(404585, 3)

--local specWarnGTFO								= mod:NewSpecialWarningGTFO(370648, nil, nil, nil, 1, 8)

--local berserkTimer								= mod:NewBerserkTimer(600)
--Stage One: The Zaqali Forces
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26604))
----Ignara (Mythic Only)
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26737))
local warnPhoenixRush								= mod:NewCountAnnounce(401108, 3)

local specWarnAwakenedFocus							= mod:NewSpecialWarningRun(401381, nil, nil, nil, 4, 2, 4)
local specWarnVigorousGale							= mod:NewSpecialWarningCount(407009, nil, nil, nil, 2, 13, 4)

local timerPhoenixRushCD							= mod:NewAITimer(29.9, 401108, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerVigorousGaleCD							= mod:NewAITimer(29.9, 407009, nil, nil, nil, 2, nil, DBM_COMMON_L.MYTHIC_ICON)
----Warlord Kagni
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26209))
local warnHeavyCudgel								= mod:NewStackAnnounce(401258, 2, nil, "Tank|Healer")

local specWarnHeavyCudgel							= mod:NewSpecialWarningDefensive(401258, nil, nil, nil, 1, 2)
local specWarnHeavyCudgelStack						= mod:NewSpecialWarningStack(401258, nil, 2, nil, nil, 1, 6)
local specWarnHeavyCudgelSwap						= mod:NewSpecialWarningTaunt(401258, nil, nil, nil, 1, 2)
local specWarnDevastatingLeap						= mod:NewSpecialWarningDodgeCount(408959, nil, nil, nil, 2, 2)

local timerHeavyCudgelCD							= mod:NewCDCountTimer(21.0, 401258, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerDevastatingLeapCD						= mod:NewCDCountTimer(29.9, 408959, nil, nil, nil, 3)
----Magma Mystic
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26217))
local warnMoltenBarrier								= mod:NewCastAnnounce(397383, 4)
local warnMagmaFlowCast								= mod:NewCastAnnounce(409271, 2)
local warnMagmaFlow									= mod:NewTargetNoFilterAnnounce(409271, 2, nil, "RemoveMagic")

local specWarnLavaBolt								= mod:NewSpecialWarningInterruptCount(397386, "HasInterrupt", nil, nil, 1, 2)--3.7 CD

local timerMoltenBarrierCD							= mod:NewAITimer(29.9, 397383, nil, nil, nil, 2)
local timerMagmaFlowCD								= mod:NewCDTimer(20.7, 409271, nil, nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)
----Obsidian Guard
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26210))
local warnVolcanicShield							= mod:NewCastAnnounce(401867, 4)

--local specWarnVolcanicShield						= mod:NewSpecialWarningYou(401867, nil, nil, nil, 2, 2)
--local yellVolcanicShield							= mod:NewShortYell(401867)
--local yellVolcanicShieldFades						= mod:NewShortFadesYell(401867)

local timerVolcanicShieldCD							= mod:NewAITimer(29.9, 401867, nil, nil, nil, 3)
----Flamebound Huntsman
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26213))
local warnBlazingSpear								= mod:NewTargetAnnounce(401401, 3)

local specWarnBlazingSpear							= mod:NewSpecialWarningMoveAway(401401, nil, nil, nil, 1, 2)
local yellBlazingSpear								= mod:NewShortYell(401401)
local yellBlazingSpearFades							= mod:NewShortFadesYell(401401)

--local timerBlazingSpearCD							= mod:NewAITimer(29.9, 401401, nil, nil, nil, 3)
--Stage Two: Warlord's Will
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26683))
local warnDesperateImmo								= mod:NewSpellAnnounce(409359, 3)
local warnFlamingCudgel								= mod:NewStackAnnounce(410351, 2, nil, "Tank|Healer")

local specWarnDevastatingSlam						= mod:NewSpecialWarningCount(410535, nil, nil, nil, 2, 2)
local specWarnFlamingCudgel							= mod:NewSpecialWarningCount(410351, nil, nil, nil, 2, 2)--Count because it's hybrid warning
local specWarnFlamingCudgelStack					= mod:NewSpecialWarningStack(410351, nil, 2, nil, nil, 1, 6)
local specWarnFlamingCudgelSwap						= mod:NewSpecialWarningTaunt(410351, nil, nil, nil, 1, 2)

--local timerIgnarasFuryCD							= mod:NewAITimer(29.9, 406585, nil, nil, nil, 2)
local timerDevastatingSlamCD						= mod:NewCDCountTimer(30.3, 410535, nil, nil, nil, 5)
local timerFlamingCudgelCD							= mod:NewCDCountTimer(34, 410351, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)

--mod:AddInfoFrameOption(361651, true)
--mod:AddRangeFrameOption(5, 390715)
--mod:AddSetIconOption("SetIconOnMagneticCharge", 399713, true, 0, {4})
--mod:GroupSpells(390715, 396094)

local castsPerGUID = {}
mod.vb.cudgelCount = 0
mod.vb.leapCount = 0
mod.vb.rushCount = 0
mod.vb.galeCount = 0

function mod:OnCombatStart(delay)
	table.wipe(castsPerGUID)
	self:SetStage(1)
	self.vb.cudgelCount = 0
	self.vb.leapCount = 0
	self.vb.rushCount = 0
	self.vb.galeCount = 0
	timerHeavyCudgelCD:Start(11.9-delay, 1)
	timerDevastatingLeapCD:Start(98.4-delay, 1)
--	if self.Options.NPAuraOnLeap then
--		DBM:FireEvent("BossMod_EnableHostileNameplates")
--	end
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
--	if self.Options.NPAuraOnLeap then
--		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 404585 then
		warnBatteringSlam:Show()
	elseif spellId == 401258 then
		self.vb.cudgelCount = self.vb.cudgelCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnHeavyCudgel:Show(self.vb.cudgelCount)
			specWarnHeavyCudgel:Play("defensive")
		end
		--12.0, 59.7, 21.0, 26.0, 22.0, 31.0, 21.0, 26.0, 22.0, 31.0, 21.0, 26.0
		--11.9, 59.5, 21.0, 26.0, 22.0, 31.0, 21.0, 26.0",
		local timer
		if self.vb.cudgelCount == 1 then--One off
			timer = 59.5
		elseif self.vb.cudgelCount % 4 == 2 then--2, 6, 10, 14, etc
			timer = 21
		elseif self.vb.cudgelCount % 4 == 3 then--3, 7, 11, 15, etc
			timer = 26
		elseif self.vb.cudgelCount % 4 == 0 then--4, 8, 12, 16, etc
			timer = 22
		elseif self.vb.cudgelCount % 4 == 1 then--5, 9, 13, 17, etc
			timer = 31
		end
		timerHeavyCudgelCD:Start(timer, self.vb.cudgelCount+1)
	elseif spellId == 401867 then
		warnVolcanicShield:Show()
		timerVolcanicShieldCD:Start(nil, args.sourceGUID)
	elseif spellId == 408959 then
		self.vb.leapCount = self.vb.leapCount + 1
		specWarnDevastatingLeap:Show(self.vb.leapCount)
		specWarnDevastatingLeap:Play("shockwave")
		--98.4, 47.5, 52.3, 47.6, 52.3
		if self.vb.leapCount % 2 == 0 then
			timerDevastatingLeapCD:Start(52.3, self.vb.leapCount+1)
		else
			timerDevastatingLeapCD:Start(47.5, self.vb.leapCount+1)
		end
	elseif spellId == 397383 then
		warnMoltenBarrier:Show()
		timerMoltenBarrierCD:Start(nil, args.sourceGUID)
	elseif spellId == 409271 then
		warnMagmaFlowCast:Show()
		timerMagmaFlowCD:Start(nil, args.sourceGUID)
	elseif spellId == 401108 then
		self.vb.rushCount = self.vb.rushCount + 1
		warnPhoenixRush:Show(self.vb.rushCount)
		timerPhoenixRushCD:Start()
	elseif spellId == 407009 then
		self.vb.galeCount = self.vb.galeCount + 1
		specWarnVigorousGale:Show(self.vb.galeCount)
		specWarnVigorousGale:Play("pushbackincoming")
		timerVigorousGaleCD:Start()
	elseif spellId == 410351 then
		self.vb.cudgelCount = self.vb.cudgelCount + 1
		specWarnFlamingCudgel:Show(self.vb.cudgelCount)
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnFlamingCudgel:Play("defensive")
		else
			specWarnFlamingCudgel:Play("scatter")
		end
		timerFlamingCudgelCD:Start(nil, self.vb.cudgelCount+1)
	elseif spellId == 397386 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then--Count interrupt, so cooldown is not checked
			specWarnLavaBolt:Show(args.sourceName, count)
			if count < 6 then
				specWarnLavaBolt:Play("kick"..count.."r")
			else
				specWarnLavaBolt:Play("kickcast")
			end
		end
	elseif spellId == 397514 then--Desperate Immolation
		self.vb.cudgelCount = 0
		self.vb.leapCount = 0--Reused with demo slam
		self:SetStage(2)
		warnDesperateImmo:Show()
		timerHeavyCudgelCD:Stop()
		timerDevastatingLeapCD:Stop()
		timerPhoenixRushCD:Stop()
		timerVigorousGaleCD:Stop()
		timerFlamingCudgelCD:Start(26.3, 1)
		timerDevastatingSlamCD:Start(38.2, 1)
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 401401 then
--		timerBlazingSpearCD:Start(nil, args.sourceGUID)
	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 401381 and args:IsPlayer() and self:AntiSpam(3, 1) then
		specWarnAwakenedFocus:Show()
		specWarnAwakenedFocus:Play("justrun")
	elseif spellId == 409275 then
		warnMagmaFlow:CombinedShow(0.3, args.destName)
	elseif spellId == 408873 then
		local amount = args.amount or 1
		if amount >= 2 then--And you pretty much swap every other cast
			if args:IsPlayer() then
				specWarnHeavyCudgelStack:Show(amount)
				specWarnHeavyCudgelStack:Play("stackhigh")
			else
				if not DBM:UnitDebuff("player", spellId) and not UnitIsDeadOrGhost("player") and not self:IsHealer() then
					specWarnHeavyCudgelSwap:Show(args.destName)
					specWarnHeavyCudgelSwap:Play("tauntboss")
				else
					warnHeavyCudgel:Show(args.destName, amount)
				end
			end
		else
			warnHeavyCudgel:Show(args.destName, amount)
		end
	elseif spellId == 410353 then
		local amount = args.amount or 1
		if amount >= 2 then--And you pretty much swap every other cast
			if args:IsPlayer() then
				specWarnFlamingCudgelStack:Show(amount)
				specWarnFlamingCudgelStack:Play("stackhigh")
			else
				if not DBM:UnitDebuff("player", spellId) and not UnitIsDeadOrGhost("player") and not self:IsHealer() then
					specWarnFlamingCudgelSwap:Show(args.destName)
					specWarnFlamingCudgelSwap:Play("tauntboss")
				else
					warnFlamingCudgel:Show(args.destName, amount)
				end
			end
		else
			warnFlamingCudgel:Show(args.destName, amount)
		end
	elseif spellId == 401452 then
		if args:IsPlayer() then
			specWarnBlazingSpear:Show()
			specWarnBlazingSpear:Play("runout")
			yellBlazingSpear:Yell()
			yellBlazingSpearFades:Countdown(spellId)
		else
			warnBlazingSpear:Show(args.destName)
		end
	--elseif spellId == 401867 or spellId == 402066 then
	--	if args:IsPlayer() then
	--		specWarnVolcanicShield:Show()
	--		specWarnVolcanicShield:Play("targetyou")
	--		yellVolcanicShield:Yell()
	--		yellVolcanicShieldFades:Countdown(spellId)
	--	else
	--		warnVolcanicShield:Show(args.destName)
	--	end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 401452 then
		if args:IsPlayer() then
			yellBlazingSpearFades:Cancel()
		end
--	elseif spellId == 398938 or spellId == 398829 then
--		if self.Options.NPAuraOnLeap then
--			DBM.Nameplate:Hide(true, args.destGUID, spellId)
--		end
--	elseif spellId == 401867 or spellId == 402066 then
--		if args:IsPlayer() then
--			yellVolcanicShieldFades:Cancel()
--		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 370648 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 200836 or cid == 202937 then--obsidian-guard
		timerVolcanicShieldCD:Stop(args.destGUID)
--	elseif cid == 200840 then--flamebound-huntsman
--		timerBlazingSpearCD:Stop(args.destGUID)
	elseif cid == 199703 then--magma-mystic
		castsPerGUID[args.destGUID] = nil
		timerMoltenBarrierCD:Stop(args.destGUID)
		timerMagmaFlowCD:Stop(args.destGUID)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 410540 then--Demolishg Slam
		self.vb.leapCount = self.vb.leapCount + 1
		specWarnDevastatingSlam:Show(self.vb.leapCount)
		specWarnDevastatingSlam:Play("helpsoak")
		--383.0, 32.8, 30.3, 34.0, 34.0, 35.2, 32.8, 35.2
		timerDevastatingSlamCD:Start(nil, self.vb.leapCount+1)
	end
end
