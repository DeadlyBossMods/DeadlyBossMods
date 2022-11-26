local mod	= DBM:NewMod(2459, "DBM-Sepulcher", nil, 1195)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(181224)
mod:SetEncounterID(2540)
mod:SetUsedIcons(1, 2, 3)
mod:SetHotfixNoticeRev(20220322000000)
mod:SetMinSyncRevision(20211203000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 359483 363607 361513 361630 365418 360960",
	"SPELL_CAST_SUCCESS 362805 361750",
	"SPELL_AURA_APPLIED 361966 361018 361651",
	"SPELL_AURA_APPLIED_DOSE 361966",
	"SPELL_AURA_REMOVED 361966 361018 361651"
)

--TODO, exact stack count optimal of tanks swaps of 361966, for now most warnings are silent or way overtuned
--TODO, use https://ptr.wowhead.com/spell=359481/domination-core for auto marking domination ores maybe, if more than 1 to mark on mythic
--[[
(ability.id = 359483 or ability.id = 361513 or ability.id = 361630 or ability.id = 365418 or ability.id = 360960) and type = "begincast"
 or ability.id = 362805 and type = "cast"
 or ability.id = 361750
 or ability.id = 361651 and (type = "applybuff" or type = "removebuff")
--]]
--The Fallen Oracle
local warnInfusedStrikes						= mod:NewStackAnnounce(361966, 2, nil, "Tank|Healer")
local warnStaggeringBarrage						= mod:NewTargetCountAnnounce(361018, 3, nil, nil, nil, nil, nil, nil, true)
local warnDominationCore						= mod:NewCountAnnounce(359483, 3)
local warnDisintegrationHalo					= mod:NewCountAnnounce(365373, 4, nil, nil, 161172)
--Inevitable Dominion
local warnSiphonReservoir						= mod:NewCountAnnounce(361643, 2)

--The Fallen Oracle
local specWarnInfusedStrikes					= mod:NewSpecialWarningStack(361966, nil, 8, nil, nil, 1, 6)
local specWarnInfusedStrikesTaunt				= mod:NewSpecialWarningTaunt(361966, nil, nil, nil, 1, 2)
local yellInfusedStrikes						= mod:NewShortFadesYell(361966)
local specWarnStaggeringBarrage					= mod:NewSpecialWarningYouPosCount(361018, nil, nil, nil, 1, 2)
local yellStaggeringBarrage						= mod:NewShortPosYell(361018)
local yellStaggeringBarrageFades				= mod:NewIconFadesYell(361018)
local specWarnStaggeringBarrageTarget			= mod:NewSpecialWarningTargetCount(361018, false, nil, nil, 1, 2, 3)--Optional Soak special warning that auto checks no soak debuff
local specWarnDominationBolt					= mod:NewSpecialWarningInterruptCount(363607, "HasInterrupt", nil, nil, 1, 2)
local specWarnObliterationArc					= mod:NewSpecialWarningDodgeCount(361513, nil, nil, nil, 2, 2)
local specWarnDisintegrationHalo				= mod:NewSpecialWarningCount(365373, nil, 161172, nil, 2, 2)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)
--Inevitable Dominion
local specWarnTotalDominion						= mod:NewSpecialWarningSpell(365418, nil, nil, nil, 3, 2)--Basically soft enrage/wipe mechanic

--The Fallen Oracle
local timerUnleashedInfusion					= mod:NewTargetTimer(20, 361967, nil, nil, nil, 2)
local timerStaggeringBarrageCD					= mod:NewCDCountTimer(35, 361018, nil, nil, nil, 3)
local timerDominationCoreCD						= mod:NewCDCountTimer(33.5, 359483, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerObliterationArcCD					= mod:NewCDCountTimer(35, 361513, nil, nil, nil, 3)
local timerDisintegrationHaloCD					= mod:NewCDCountTimer(70, 365373, 161172, nil, nil, 3)
local timerDisintegrationHalo					= mod:NewCastCountTimer(5, 365373, 161172, nil, nil, 5)
--Inevitable Dominion
local timerSiphonReservoirCD					= mod:NewCDCountTimer(28.8, 361643, nil, nil, nil, 6)

mod:AddInfoFrameOption(361651, true)
mod:AddSetIconOption("SetIconOnStaggeringBarrage", 361018, true, false, {1, 2, 3})--Only one was happening on heroic, is 3 mythic only?

mod.vb.DebuffIcon = 1
mod.vb.barrageCount = 0
mod.vb.ReservoirCount = 0
mod.vb.arcCount = 0
mod.vb.coreCount = 0
mod.vb.haloCount = 0--Activation count
mod.vb.ringCount = 0--Ring total count
mod.vb.softEnrage = false
local castsPerGUID = {}

function mod:OnCombatStart(delay)
	self.vb.DebuffIcon = 1
	self.vb.barrageCount = 0
	self.vb.ReservoirCount = 0
	self.vb.arcCount = 0
	self.vb.coreCount = 0
	self.vb.haloCount = 0
	self.vb.softEnrage = false
	if self:IsHard() then--Mythic and heroic have same timers
		timerDisintegrationHaloCD:Start(4.9-delay, 1)
		timerDominationCoreCD:Start(6.4-delay, 1)
		timerObliterationArcCD:Start(14.9-delay, 1)
		timerStaggeringBarrageCD:Start(29-delay, 1)
		timerSiphonReservoirCD:Start(72.1-delay, 1)
	elseif self:IsNormal() then
		timerDisintegrationHaloCD:Start(5.5-delay, 1)
		timerDominationCoreCD:Start(7.2-delay, 1)
		timerObliterationArcCD:Start(16.7-delay, 1)
		timerStaggeringBarrageCD:Start(32.2-delay, 1)
		timerSiphonReservoirCD:Start(80.2-delay, 1)
	else--LFR is even sloweer
		timerDisintegrationHaloCD:Start(6.2-delay, 1)
		timerDominationCoreCD:Start(8.1-delay, 1)
		timerObliterationArcCD:Start(18.7-delay, 1)
		timerStaggeringBarrageCD:Start(36.2-delay, 1)
		timerSiphonReservoirCD:Start(88.8-delay, 1)
	end
end

function mod:OnCombatEnd()
	table.wipe(castsPerGUID)
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 359483 then
		self.vb.coreCount = self.vb.coreCount + 1
		warnDominationCore:Show(self.vb.coreCount)
		timerDominationCoreCD:Start(self:IsHard() and 33.5 or self:IsNormal() and 37.2 or 41.8, self.vb.coreCount+1)
	elseif spellId == 363607 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then
			specWarnDominationBolt:Show(args.sourceName, count)
			if count < 6 then
				specWarnDominationBolt:Play("kick"..count.."r")
			else
				specWarnDominationBolt:Play("kickcast")
			end
		end
	elseif spellId == 361513 then
		self.vb.arcCount = self.vb.arcCount + 1
		specWarnObliterationArc:Show(self.vb.arcCount)
		specWarnObliterationArc:Play("shockwave")
		timerObliterationArcCD:Start(self:IsHard() and 35 or self:IsNormal() and 38.8 or 43.7, self.vb.arcCount+1)
	elseif spellId == 361630 then--Teleport
		self.vb.ReservoirCount = self.vb.ReservoirCount + 1
		warnSiphonReservoir:Show(self.vb.ReservoirCount)
		timerStaggeringBarrageCD:Stop()
		timerDominationCoreCD:Stop()
		timerObliterationArcCD:Stop()
		timerDisintegrationHaloCD:Stop()
	elseif spellId == 365418 then
		self.vb.softEnrage = true
		specWarnTotalDominion:Show()
		specWarnTotalDominion:Play("stilldanger")
	elseif spellId == 360960 then
		self.vb.DebuffIcon = 1
		self.vb.barrageCount = self.vb.barrageCount + 1
		timerStaggeringBarrageCD:Start(self:IsHard() and 35 or self:IsNormal() and 38.8 or 43.7, self.vb.barrageCount+1)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 362805 then
		self.vb.haloCount = self.vb.haloCount + 1
		self.vb.ringCount = 0
		specWarnDisintegrationHalo:Show(self.vb.haloCount)
		specWarnDisintegrationHalo:Play("watchwave")
		if not self.vb.softEnrage then
			timerDisintegrationHaloCD:Start(self:IsHard() and 70 or self:IsNormal() and 77.7 or 87.4, self.vb.haloCount+1)
		end
		timerDisintegrationHalo:Start(8, 1)
	elseif spellId == 361750 then
		self.vb.ringCount = self.vb.ringCount + 1
		warnDisintegrationHalo:Show(self.vb.ringCount)
		--Each teleport instance is one additional ring
		if self.vb.ringCount <= self.vb.ReservoirCount then
			timerDisintegrationHalo:Start(5, self.vb.ringCount+1)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 361966 then
		local amount = args.amount or 1
		if args:IsPlayer() then
			yellInfusedStrikes:Cancel()
			yellInfusedStrikes:Countdown(spellId, 5)
			if amount % 2 == 0 then
				if amount >= 4 then
					specWarnInfusedStrikes:Show(amount)
					specWarnInfusedStrikes:Play("stackhigh")
				else
					warnInfusedStrikes:Show(args.destName, amount)
				end
			end
		else
			if amount % 2 == 0 then
				if (amount >= 4) and not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", spellId) then
					specWarnInfusedStrikesTaunt:Show(args.destName)
					specWarnInfusedStrikesTaunt:Play("tauntboss")
				else
					warnInfusedStrikes:Show(args.destName, amount)
				end
			end
		end
		timerUnleashedInfusion:Stop(args.destName)
		timerUnleashedInfusion:Start(20, args.destName)
	elseif spellId == 361018 then
		local icon = self.vb.DebuffIcon
		if self.Options.SetIconOnStaggeringBarrage then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			--Unschedule target warning if you've become one of victims
			specWarnStaggeringBarrageTarget:Cancel()
			specWarnStaggeringBarrageTarget:CancelVoice()
			--Now show your warnings
			specWarnStaggeringBarrage:Show(self.vb.barrageCount, self:IconNumToTexture(icon))
			specWarnStaggeringBarrage:Play("mm"..icon)
			yellStaggeringBarrage:Yell(icon, icon)
			yellStaggeringBarrageFades:Countdown(spellId, nil, icon)
		elseif self.Options.SpecWarn361018target and not DBM:UnitDebuff("player", 364289) then
			--Don't show special warning if you're one of victims
			specWarnStaggeringBarrageTarget:CombinedShow(0.5, self.vb.barrageCount, args.destName)
			specWarnStaggeringBarrageTarget:ScheduleVoice(0.5, "helpsoak")
		else
			warnStaggeringBarrage:CombinedShow(0.5, self.vb.barrageCount, args.destName)
		end
		self.vb.DebuffIcon = self.vb.DebuffIcon + 1
	elseif spellId == 361651 then
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(2, "enemyabsorb", nil, args.amount, "boss1")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 361966 then
		if args:IsPlayer() then
			yellInfusedStrikes:Cancel()
		end
		timerUnleashedInfusion:Stop(args.destName)
	elseif spellId == 361018 then
		if self.Options.SetIconOnStaggeringBarrage then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellStaggeringBarrageFades:Cancel()
		end
	elseif spellId == 361651 then--Siphoned Barrier
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
		if self:IsHard() then
			if not self.vb.softEnrage then
				timerDisintegrationHaloCD:Start(6.7, self.vb.haloCount+1)
			end
			timerDominationCoreCD:Start(8.2, self.vb.coreCount+1)
			timerObliterationArcCD:Start(16.7, self.vb.arcCount+1)
			timerStaggeringBarrageCD:Start(30.7, self.vb.barrageCount+1)
			timerSiphonReservoirCD:Start(109.6, self.vb.ReservoirCount+1)--108-110, closer here than teleport to teleport.
		elseif self:IsNormal() then
			if not self.vb.softEnrage then
				timerDisintegrationHaloCD:Start(6.9, self.vb.haloCount+1)
			end
			timerDominationCoreCD:Start(8.6, self.vb.coreCount+1)
			timerObliterationArcCD:Start(18.1, self.vb.arcCount+1)
			timerStaggeringBarrageCD:Start(33.6, self.vb.barrageCount+1)
			timerSiphonReservoirCD:Start(120.4, self.vb.ReservoirCount+1)--Closer here than teleport to teleport.
		else
			if not self.vb.softEnrage then
				timerDisintegrationHaloCD:Start(8.1, self.vb.haloCount+1)
			end
			timerDominationCoreCD:Start(9.9, self.vb.coreCount+1)
			timerObliterationArcCD:Start(20.6, self.vb.arcCount+1)
			timerStaggeringBarrageCD:Start(38.1, self.vb.barrageCount+1)
			timerSiphonReservoirCD:Start(134.3, self.vb.ReservoirCount+1)--Closer here than teleport to teleport.
		end
	end
end
