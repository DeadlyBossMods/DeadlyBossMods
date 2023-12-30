local mod	= DBM:NewMod(2524, "DBM-Raids-Dragonflight", 2, 1208)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(199659)--Warlord Kagni
mod:SetEncounterID(2682)
mod:SetHotfixNoticeRev(20230619000000)
--mod:SetMinSyncRevision(20221215000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 401258 401867 408959 397383 409271 401108 407009 410351 397386 408620",
	"SPELL_CAST_SUCCESS 397514 401258 410351",
	"SPELL_AURA_APPLIED 401867 402066 401381 409275 408873 410353 401452",
	"SPELL_AURA_APPLIED_DOSE 408873 410353",
	"SPELL_AURA_REMOVED 401867 402066 401452",
	"UNIT_DIED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_AURA player",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[
(ability.id = 410516 or ability.id = 401258 or ability.id = 408959 or ability.id = 401108 or ability.id = 407009 or ability.id = 410351 or ability.id = 397514) and type = "begincast"
 or (ability.id = 397514 or ability.id = 412818 or ability.id = 412820) and type = "cast"
 or (source.type = "NPC" and source.firstSeen = timestamp) and (source.id = 199703 or source.id = 204505 or source.id = 199812) or (target.type = "NPC" and target.firstSeen = timestamp) and (target.id = 199703 or target.id = 204505 or target.id = 199812)
 or (ability.id = 404585 or ability.id = 397386 or ability.id = 397383 or ability.id = 401867 or ability.id = 409271) and type = "begincast"
--]]
--TODO, refine slam and door aoe stack warnings for Barrier Backfire?
--TODO, nameplate aura for https://www.wowhead.com/ptr/spell=410740/from-the-ashes ? need to make sure it actually has nameplate first
--TODO, can lava flow be dodged? if so probably should be emphasized, if not, cast alert should be removed
--TODO, stage 2 https://www.wowhead.com/ptr/spell=406585/ignaras-fury fury timer?
--General

--local specWarnGTFO								= mod:NewSpecialWarningGTFO(370648, nil, nil, nil, 1, 8)

--local berserkTimer								= mod:NewBerserkTimer(600)
--Stage One: The Zaqali Forces
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26604))
----Ignara (Mythic Only)
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26737))
local warnPhoenixRush								= mod:NewCountAnnounce(401108, 3)

local specWarnAwakenedFocus							= mod:NewSpecialWarningRun(401381, nil, 374610, nil, 4, 2, 4)--"Fixate"
local specWarnVigorousGale							= mod:NewSpecialWarningCount(407009, nil, nil, nil, 2, 13, 4)

local timerPhoenixRushCD							= mod:NewCDCountTimer(29.9, 401108, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerVigorousGaleCD							= mod:NewCDCountTimer(29.9, 407009, nil, nil, nil, 2, nil, DBM_COMMON_L.MYTHIC_ICON)
----Warlord Kagni
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26209))
local warnHeavyCudgel								= mod:NewStackAnnounce(401258, 2, nil, "Tank|Healer")
local warnMagmaMystic								= mod:NewCountAnnounce(397383, 3)
local warnWallClimber								= mod:NewCountAnnounce("ej26221", 2, 163789, false, 2)

local specWarnHeavyCudgel							= mod:NewSpecialWarningDefensive(401258, nil, nil, nil, 1, 2)
local specWarnHeavyCudgelStack						= mod:NewSpecialWarningStack(401258, nil, 2, nil, nil, 1, 6)
local specWarnHeavyCudgelSwap						= mod:NewSpecialWarningTaunt(401258, nil, nil, nil, 1, 2)
local specWarnDevastatingLeap						= mod:NewSpecialWarningDodgeCount(408959, nil, 67382, nil, 2, 2)
local specWarnAdds									= mod:NewSpecialWarningAddsCustom(285849, "-Healer", nil, nil, 1, 2)

local timerHeavyCudgelCD							= mod:NewCDCountTimer(21.0, 401258, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerDevastatingLeapCD						= mod:NewCDCountTimer(29.9, 408959, 67382, nil, nil, 3)--"Leap"
local timerMagmaMysticCD							= mod:NewCDCountTimer(29.9, 397383, nil, nil, nil, 1)--Molten Barrier Icon
local timerWallClimberCD							= mod:NewCDCountTimer(29.9, "ej26221", nil, false, 2, 1, 163789)--Ladder Icon
local timerGuardsandHuntsmanCD						= mod:NewTimer(30, "timerGuardsandHuntsmanCD", 285849, nil, nil, 1, nil, nil, nil, nil, nil, nil, nil, 404382)--Random guard banner
----Magma Mystic
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26217))
local warnMoltenBarrier								= mod:NewCastAnnounce(397383, 4)
local warnMagmaFlowCast								= mod:NewCastAnnounce(409271, 2)
local warnMagmaFlow									= mod:NewTargetNoFilterAnnounce(409271, 2, nil, "RemoveMagic")

local specWarnLavaBolt								= mod:NewSpecialWarningInterruptCount(397386, "HasInterrupt", nil, nil, 1, 2)--3.7 CD

--local timerMoltenBarrierCD						= mod:NewAITimer(29.9, 397383, nil, nil, nil, 2)
--local timerMagmaFlowCD							= mod:NewCDTimer(20.7, 409271, nil, nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)
----Obsidian Guard
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26210))
local warnScorchingRoar								= mod:NewCastAnnounce(408620, 4)
local warnVolcanicShield							= mod:NewCastAnnounce(401867, 4)

local specWarnVolcanicShield						= mod:NewSpecialWarningYou(401867, nil, nil, nil, 2, 2)
local yellVolcanicShield							= mod:NewShortYell(401867)
local yellVolcanicShieldFades						= mod:NewShortFadesYell(401867)

local timerScorchingRoarCD							= mod:NewCDTimer(9.7, 408620, nil, nil, nil, 2)
local timerVolcanicShieldCD							= mod:NewCDTimer(30.3, 401867, nil, nil, nil, 3)--30-40
----Flamebound Huntsman
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26213))
local warnBlazingSpear								= mod:NewTargetAnnounce(401401, 3)

local specWarnBlazingSpear							= mod:NewSpecialWarningMoveAway(401401, nil, nil, nil, 1, 2)
local yellBlazingSpear								= mod:NewShortYell(401401)
local yellBlazingSpearFades							= mod:NewShortFadesYell(401401)

--local timerBlazingSpearCD							= mod:NewAITimer(29.9, 401401, nil, nil, nil, 3)
--Stage Two: Warlord's Will
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26683))
local warnDesperateImmo								= mod:NewSpellAnnounce(409359, 3, nil, nil, nil, nil, nil, 2)
local warnFlamingCudgel								= mod:NewStackAnnounce(410351, 2, nil, "Tank|Healer")

local specWarnCatastrophicSlam						= mod:NewSpecialWarningCount(410516, nil, nil, nil, 2, 2)
local specWarnFlamingCudgel							= mod:NewSpecialWarningCount(410351, nil, nil, nil, 2, 2)--Count because it's hybrid warning
local specWarnFlamingCudgelStack					= mod:NewSpecialWarningStack(410351, nil, 2, nil, nil, 1, 6)
local specWarnFlamingCudgelSwap						= mod:NewSpecialWarningTaunt(410351, nil, nil, nil, 1, 2)

--local timerIgnarasFuryCD							= mod:NewAITimer(29.9, 406585, nil, nil, nil, 2)
local timerCatastrophicSlamCD						= mod:NewCDCountTimer(26.7, 410516, nil, nil, nil, 5)
local timerFlamingCudgelCD							= mod:NewCDCountTimer(34, 410351, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)

--mod:AddInfoFrameOption(361651, true)
--mod:AddSetIconOption("SetIconOnMagneticCharge", 399713, true, 0, {4})
--mod:GroupSpells(390715, 396094)

local castsPerGUID = {}
mod.vb.cudgelCount = 0
mod.vb.leapCount = 0
mod.vb.rushCount = 0
mod.vb.galeCount = 0
mod.vb.bigAdds = 0
mod.vb.magmaMysticCount = 0
mod.vb.wallClimberCount = 0
--CLEU data pulling is not fully accurate since first hits doesn't mean first seen accuracy.
--However, based on the way the boss patterns typically being initial, one off, then repeating pattern.
--The timer assumptions below follow pattern perfectly and should be pretty dang close if not dead on
--local magmaTimers = {21.7, 80, 135, 180, 235, 280, 335, 380}--21.7, 78.3, 131.9, 178.1, 232.6, 277.5, 334.4, 381.4
--local climbersTimers = {31.6, 80, 140, 180, 240, 280, 340}--34.3, 82.5, 141.9, 180.1, 242.9, 281.6, 341.7

local function magmaLoop(self)
	self.vb.magmaMysticCount = self.vb.magmaMysticCount + 1
	warnMagmaMystic:Show(self.vb.magmaMysticCount)
	local timer
	if self.vb.magmaMysticCount == 1 then
		timer = 58--Think it's techincally 55 still, but this offsets the landing/attackable for rest of fight
	elseif self.vb.magmaMysticCount % 2 == 0 then
		timer = 55
	else
		timer = 45
	end
	timerMagmaMysticCD:Start(timer, self.vb.magmaMysticCount+1)
	self:Schedule(timer, magmaLoop, self)
end

local function climberLoop(self)
	self.vb.wallClimberCount = self.vb.wallClimberCount + 1
	warnWallClimber:Show(self.vb.wallClimberCount)
	local timer
	if self.vb.wallClimberCount == 1 then
		timer = 50
	elseif self.vb.wallClimberCount % 2 == 0 then
		timer = 60
	else
		timer = 40
	end
	timerWallClimberCD:Start(timer, self.vb.wallClimberCount+1)
	self:Schedule(timer, climberLoop, self)
end

function mod:OnCombatStart(delay)
	table.wipe(castsPerGUID)
	self:SetStage(1)
	self.vb.cudgelCount = 0
	self.vb.leapCount = 0
	self.vb.rushCount = 0
	self.vb.galeCount = 0
	self.vb.bigAdds = 0
	self.vb.magmaMysticCount = 0
	self.vb.wallClimberCount = 0
	timerHeavyCudgelCD:Start(11.9-delay, 1)
	timerMagmaMysticCD:Start(20-delay, 1)
	self:Schedule(20-delay, magmaLoop, self)
	timerWallClimberCD:Start(30, 1)
	self:Schedule(30, climberLoop, self)
	timerGuardsandHuntsmanCD:Start(40-delay, 1 .. "-" .. DBM_COMMON_L.SOUTH)
	timerDevastatingLeapCD:Start(95.9-delay, 1)
	if self:IsMythic() then
		timerVigorousGaleCD:Start(71.3, 1)--71-75
		timerPhoenixRushCD:Start(89.7, 1)--90-94
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 401258 then
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnHeavyCudgel:Show(self.vb.cudgelCount+1)
			specWarnHeavyCudgel:Play("defensive")
		end
		--Timers moved to success event
	elseif spellId == 401867 and self:CheckBossDistance(args.sourceGUID, true, 32698, 48) then
		warnVolcanicShield:Show()
		timerVolcanicShieldCD:Start(nil, args.sourceGUID)
	elseif spellId == 408959 then
		self.vb.leapCount = self.vb.leapCount + 1
		specWarnDevastatingLeap:Show(self.vb.leapCount)
		specWarnDevastatingLeap:Play("watchstep")
		--98.4, 47.5, 52.3, 47.6, 52.3
		--98.6, 46.2, 53.7, 47.4, 52.4
		--98.2, 47.4, 52.2, 47.3, 53.5
		if self.vb.leapCount % 2 == 0 then
			timerDevastatingLeapCD:Start(52.1, self.vb.leapCount+1)
		else
			timerDevastatingLeapCD:Start(46.2, self.vb.leapCount+1)
		end
--	elseif spellId == 397383 then
--		warnMoltenBarrier:Show()
--		timerMoltenBarrierCD:Start(nil, args.sourceGUID)
	elseif spellId == 409271 and self:CheckBossDistance(args.sourceGUID, true, 32698, 48) then
		warnMagmaFlowCast:Show()
--		timerMagmaFlowCD:Start(nil, args.sourceGUID)
	elseif spellId == 401108 then
		self.vb.rushCount = self.vb.rushCount + 1
		warnPhoenixRush:Show(self.vb.rushCount)
		--91.1, 23.1, 76.5, 26.7, 74.1, 28.0
		--93.4, 19.8, 77.7, 26.8, 74.0, 21.9
		--90.1, 23.1, 80.2, 24.3, 72.9
		--93.6, 19.5, 79.2, 24.4"
		--90.3, 25.6, 79.2, 20.7, 75.4, 25.5
		--90.5, 24.6, 75.7
		--91.2, 24.2, 74.9, 27
		--91.4, 20.2, 79.4
		if self.vb.rushCount % 2 == 0 then
			timerPhoenixRushCD:Start(71.7, self.vb.rushCount+1)--71.7-80.2
		else
			timerPhoenixRushCD:Start(19.8, self.vb.rushCount+1)--19-27.9
		end
	elseif spellId == 407009 then
		self.vb.galeCount = self.vb.galeCount + 1
		specWarnVigorousGale:Show(self.vb.galeCount)
		specWarnVigorousGale:Play("pushbackincoming")
		--74, 64.7, 32
		--72.9, 65.5, 35.2
		--74.2, 64.4, 35.2
		if self.vb.galeCount % 2 == 0 then
			timerVigorousGaleCD:Start(32, self.vb.galeCount+1)--32-35.2
		else
			timerVigorousGaleCD:Start(63.1, self.vb.galeCount+1)--63.1-65.5
		end
	elseif spellId == 410351 then
		specWarnFlamingCudgel:Show(self.vb.cudgelCount+1)
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnFlamingCudgel:Play("defensive")
		else
			specWarnFlamingCudgel:Play("scatter")
		end
		--Timers moved to success event
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
	elseif spellId == 408620 and self:CheckBossDistance(args.sourceGUID, true, 32698, 48) then
		warnScorchingRoar:Show()
		timerScorchingRoarCD:Start(nil, args.sourceGUID)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 397514 then--Desperate Immolation
		self.vb.cudgelCount = 0
		self.vb.leapCount = 0--Reused with demo slam
		self:SetStage(2)
		warnDesperateImmo:Show()
		warnDesperateImmo:Play("ptwo")
		timerHeavyCudgelCD:Stop()
		timerDevastatingLeapCD:Stop()
		timerPhoenixRushCD:Stop()
		timerVigorousGaleCD:Stop()
		self:Unschedule(magmaLoop)
		self:Unschedule(climberLoop)
		timerMagmaMysticCD:Stop()
		timerWallClimberCD:Stop()
		timerGuardsandHuntsmanCD:Stop()
		timerFlamingCudgelCD:Start(18.7, 1)
		timerCatastrophicSlamCD:Start(25.6, 1)
	elseif spellId == 401258 then
		--Only increment and start timer on success, if tank dies during cast, it triggers a recast and can break all timers if started in START
		self.vb.cudgelCount = self.vb.cudgelCount + 1
		--12.0, 59.7, 21.0, 26.0, 22.0, 31.0, 21.0, 26.0, 22.0, 31.0, 21.0, 26.0
		--11.9, 59.5, 21.0, 26.0, 22.0, 31.0, 21.0, 26.0",
		--11.9, 59.8, 21.0, 26.0, 22.0, 31.0, 21.0, 26.0, 22.0, 31.0, 21.0, 26.0"
		--12.0, 59.5, 21.0, 26.0, 22.0, 31.0, 21.0, 26.0, 22.0, 31.0, 21.0, 26.0
		local timer
		if self.vb.cudgelCount == 1 then--One off
			timer = 58.4
		elseif self.vb.cudgelCount % 4 == 2 then--2, 6, 10, 14, etc
			timer = 20.9
		elseif self.vb.cudgelCount % 4 == 3 then--3, 7, 11, 15, etc
			timer = 25.9
		elseif self.vb.cudgelCount % 4 == 0 then--4, 8, 12, 16, etc
			timer = 22
		elseif self.vb.cudgelCount % 4 == 1 then--5, 9, 13, 17, etc
			timer = 31
		end
		timerHeavyCudgelCD:Start(timer - 3, self.vb.cudgelCount+1)--Timer minus cast time
	elseif spellId == 410351 then
		self.vb.cudgelCount = self.vb.cudgelCount + 1
		--18, 23, 19, 11.9,
		--18, 23, 19, 12
		--18, 23, 19, 12, 23, 19
		local timer
		if self.vb.cudgelCount % 3 == 2 then
			timer = 19
		elseif self.vb.cudgelCount % 3 == 0 then
			timer = 12
		elseif self.vb.cudgelCount % 3 == 1 then
			timer = 23
		end
		timerFlamingCudgelCD:Start(timer - 3, self.vb.cudgelCount+1)--Timer minus cast time
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 401381 and args:IsPlayer() and self:AntiSpam(3, 1) then
--		specWarnAwakenedFocus:Show()
--		specWarnAwakenedFocus:Play("justrun")
	elseif spellId == 409275 then
		warnMagmaFlow:CombinedShow(0.3, args.destName)
	elseif spellId == 408873 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
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
		if args:IsPlayer() and self:AntiSpam(3, 2) then
			specWarnBlazingSpear:Show()
			specWarnBlazingSpear:Play("runout")
			yellBlazingSpear:Yell()
			yellBlazingSpearFades:Countdown(spellId)
		end
		warnBlazingSpear:CombinedShow(1, args.destName)
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

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 200836 or cid == 202937 then--obsidian-guard
		timerVolcanicShieldCD:Stop(args.destGUID)
		timerScorchingRoarCD:Stop(args.destGUID)
--	elseif cid == 200840 then--flamebound-huntsman
--		timerBlazingSpearCD:Stop(args.destGUID)
	elseif cid == 199703 then--magma-mystic
		castsPerGUID[args.destGUID] = nil
--		timerMoltenBarrierCD:Stop(args.destGUID)
--		timerMagmaFlowCD:Stop(args.destGUID)
	end
end

do
	local warnedFixate, warnedShield = false, false
	function mod:UNIT_AURA(uId)
		local hasFixate = DBM:UnitDebuff("player", 401381)
		if hasFixate and not warnedFixate then
			warnedFixate = true
			specWarnAwakenedFocus:Show()
			specWarnAwakenedFocus:Play("justrun")
		elseif not hasFixate and warnedFixate then
			warnedFixate = false
		end

		local hasShield = DBM:UnitDebuff("player", 401867)
		if hasShield and not warnedShield then
			warnedShield = true
			specWarnVolcanicShield:Show()
			specWarnVolcanicShield:Play("targetyou")
			yellVolcanicShield:Yell()
			yellVolcanicShieldFades:Countdown(5)
		elseif not hasShield and warnedShield then
			warnedShield = false
			yellVolcanicShieldFades:Cancel()
		end
	end
end

--"<2.20 22:31:24> [ENCOUNTER_START] 2682#Assault of the Zaqali#16#20", -- [6]
--"<42.03 22:32:04> [CHAT_MSG_RAID_BOSS_EMOTE] |TInterface\\ICONS\\Ability_Hunter_KillCommand.blp:20|t Commanders ascend the southern battlement!#Warlord Kagni#####0#0##0#939#nil#0#false#false#false#false", -- [1756]
--"<76.46 22:32:39> [CHAT_MSG_RAID_BOSS_EMOTE] |TInterface\\ICONS\\Ability_Hunter_KillCommand.blp:20|t Commanders ascend the northern battlement!#Warlord Kagni#####0#0##0#941#nil#0#false#false#false#false", -- [4305]
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find("Ability_Hunter_KillCommand.blp") then
		self.vb.bigAdds = self.vb.bigAdds + 1
		local timer, wallText, nextWallText = nil, "", ""
		--First live parse, in case it differs on other difficulties or changes on live, this ensures live parse accuracy
		if msg:find(L.northWall) then
			wallText = DBM_COMMON_L.NORTH
		elseif msg:find(L.southWall) then
			wallText = DBM_COMMON_L.SOUTH
		end
		if self.vb.bigAdds % 5 == 1 then--1, 6, 11, 16, etc
			timer = self.vb.bigAdds == 1 and 33.7 or 23--First one is 1 off
			nextWallText = "-"..DBM_COMMON_L.NORTH
			if wallText == "" then--Hard code backup if live parse fails
				wallText = DBM_COMMON_L.SOUTH
			end
		elseif self.vb.bigAdds % 5 == 2 then--2, 7, 12, 17, etc
			timer = 21
			nextWallText = "-"..DBM_COMMON_L.NORTH
			if wallText == "" then--Hard code backup if live parse fails
				wallText = DBM_COMMON_L.NORTH
			end
		elseif self.vb.bigAdds % 5 == 3 then--3, 8, 13, 18, etc
			timer = 5
			nextWallText = "-"..DBM_COMMON_L.NORTH
			if wallText == "" then--Hard code backup if live parse fails
				wallText = DBM_COMMON_L.NORTH
			end
		elseif self.vb.bigAdds % 5 == 4 then--4, 9, 14, 19, etc
			timer = 21.9
			nextWallText = "-"..DBM_COMMON_L.SOUTH
			if wallText == "" then--Hard code backup if live parse fails
				wallText = DBM_COMMON_L.NORTH
			end
		elseif self.vb.bigAdds % 5 == 0 then--5, 10, 15, 20, etc
			timer = 29
			nextWallText = "-"..DBM_COMMON_L.SOUTH
			if wallText == "" then--Hard code backup if live parse fails
				wallText = DBM_COMMON_L.SOUTH
			end
		end
		timerGuardsandHuntsmanCD:Start(timer, self.vb.bigAdds+1 .. nextWallText)
		specWarnAdds:Show(wallText)
		specWarnAdds:Play("bigmob")
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 410540 then--Catastrophic Slam
		self.vb.leapCount = self.vb.leapCount + 1
		specWarnCatastrophicSlam:Show(self.vb.leapCount)
		specWarnCatastrophicSlam:Play("helpsoak")
		--25.6, 26.7, 26.7, 26.7 (new heroic/normal timers)
		timerCatastrophicSlamCD:Start(26.7, self.vb.leapCount+1)
	end
end
