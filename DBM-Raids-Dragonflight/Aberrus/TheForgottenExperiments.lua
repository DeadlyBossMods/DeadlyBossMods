local mod	= DBM:NewMod(2530, "DBM-Raids-Dragonflight", 2, 1208)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(200912, 200913, 200918)
mod:SetEncounterID(2693)
mod:SetUsedIcons(1, 2, 3)
mod:SetBossHPInfoToHighest()
mod:SetHotfixNoticeRev(20230619000000)
mod:SetMinSyncRevision(20230512000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")
mod:SetWipeTime(25)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 406358 404472 407733 404713 405042 405492 405375 406227 407552 405391 407775 412117",
	"SPELL_AURA_APPLIED 406313 407302 407327 407617 405392",
	"SPELL_AURA_APPLIED_DOSE 406313 407302 407327",
	"SPELL_AURA_REMOVED 407327 406313",
	"UNIT_DIED",
	"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3"
)

--[[
(ability.id = 412117 or ability.id = 406358 or ability.id = 407733 or ability.id = 404472 or ability.id = 404713 or ability.id = 405042 or ability.id = 405492 or ability.id = 407775 or ability.id = 405375 or ability.id = 406227 or ability.id = 407552 or ability.id = 405391) and type  = "begincast"
 or (source.type = "NPC" and source.firstSeen = timestamp) and (source.id = 200912 or source.id = 200913 or source.id = 200918) or (target.type = "NPC" and target.firstSeen = timestamp) and (target.id = 200912 or target.id = 200913 or target.id = 200918)
--]]
--TODO, what do you actually do with Temporal Anomaly, soak it?
--NOTE, Rending Charge is a private aura
--General
local warnInfusedStrikes							= mod:NewStackAnnounce(406311, 2, nil, "Tank|Healer")
local warnInfusedExplosion							= mod:NewCountAnnounce(407302, 4, nil, "Tank|Healer")

local specWarnInfusedStrikesSelf					= mod:NewSpecialWarningStack(406311, nil, 6, nil, nil, 1, 6)
local specWarnInfusedStrikesTaunt					= mod:NewSpecialWarningTaunt(406311, nil, nil, nil, 1, 2)
local specWarnInfusedStrikesHug						= mod:NewSpecialWarningMoveTo(406311, nil, nil, nil, 1, 2)
--local specWarnGTFO								= mod:NewSpecialWarningGTFO(370648, nil, nil, nil, 1, 8)

local timerInfusedExplosion							= mod:NewBuffFadesTimer(20, 407302, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON..DBM_COMMON_L.HEALER_ICON)--Track the aura that needs to fall off before tanks "clear" again
--local berserkTimer								= mod:NewBerserkTimer(600)

mod:AddInfoFrameOption(406311, "Tank")
--Neldris
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26001))

local warnRendingCharge								= mod:NewIncomingCountAnnounce(406358, 3)

local specWarnMassiveSlam							= mod:NewSpecialWarningDodgeCount(404472, nil, nil, nil, 2, 2)
local specWarnBellowingRoar							= mod:NewSpecialWarningCount(404713, nil, nil, nil, 2, 2)

local timerRendingChargeCD							= mod:NewCDCountTimer(34.2, 406358, nil, nil, nil, 3, nil, DBM_COMMON_L.BLEED_ICON)
local timerMassiveSlamCD							= mod:NewCDCountTimer(39, 404472, nil, nil, nil, 3)
local timerBellowingRoarCD							= mod:NewCDCountTimer(23.1, 404713, nil, nil, nil, 2)

mod:AddPrivateAuraSoundOption(406317, true, 406358, 1)
--Thadrion
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26322))
local warnUnstableEssence							= mod:NewCastAnnounce(407327, 3)
local warnUnstableEssenceTargets					= mod:NewTargetAnnounce(407327, 2)

local specWarnUnstableEssence						= mod:NewSpecialWarningYou(407327, nil, nil, nil, 1, 2)
local yellUnstableEssence							= mod:NewShortYell(407327, DBM_CORE_L.AUTO_YELL_ANNOUNCE_TEXT.shortyell)
local specWarnVolatileSpew							= mod:NewSpecialWarningDodgeCount(405492, nil, nil, nil, 2, 2)
local specWarnViolentEruption						= mod:NewSpecialWarningCount(405375, nil, nil, nil, 2, 2)

local timerUnstableEssenceCD						= mod:NewCDCountTimer(29.2, 407327, nil, nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)
local timerVolatileSpewCD							= mod:NewCDCountTimer(26, 405492, nil, nil, nil, 3)
local timerViolentEruptionCD						= mod:NewCDCountTimer(68.3, 405375, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)

mod:AddSetIconOption("SetIconOnEssence", 407327, false, 0, {1, 2, 3, 4, 5, 6, 7, 8})
--Rionthus
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26329))
local warnTemporalAnomaly							= mod:NewCastAnnounce(407552, 3)
local warnTemporalAnomalyAbsorbed					= mod:NewTargetNoFilterAnnounce(407552, 2)
local warnDisintegrate								= mod:NewTargetAnnounce(405392, 2)

local specWarnDeepBreath							= mod:NewSpecialWarningDodgeCount(406227, nil, 18357, nil, 2, 2)
local specWarnDisintegrate							= mod:NewSpecialWarningMoveAway(405392, nil, nil, nil, 1, 2)
local yellDisintegrate								= mod:NewShortYell(405392)

local timerDeepBreathCD								= mod:NewCDCountTimer(42.7, 406227, 18357, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)--"Breath"
local timerTemporalAnomalyCD						= mod:NewCDCountTimer(43.7, 407552, nil, nil, nil, 5)
local timerDisintegrateCD							= mod:NewCDCountTimer(43.7, 405392, nil, nil, nil, 3)

mod.vb.rendingCount = 0
mod.vb.massiveSlamCount = 0
mod.vb.roarCount = 0
mod.vb.essenceCount = 0
mod.vb.volatileSpewCount = 0
mod.vb.eruptionCount = 0
mod.vb.breathCount = 0
mod.vb.disintegrateCount = 0
mod.vb.anomalyCount = 0
mod.vb.tankSafeClear = true
local tankStacks = {}
local essenceMarks = {}
local bossActive = {}
local allTimers = {
	--Volatile Spew
	[405492] = {5.6, 21.8, 36.4, 30.3, 30, 30.4, 33.2, 31.1, 35.2, 30.4},--Confirmed up to 5th cast
	--Unstable Essence
	[405042] = {16.5, 37.6, 27.5, 35.2, 27.9, 38, 27.5, 38.9, 28},
}

local updateInfoFrame
do
	local twipe, tsort = table.wipe, table.sort
	local lines = {}
	local sortedLines = {}
	local function addLine(key, value)
		-- sort by insertion order
		lines[key] = value
		sortedLines[#sortedLines + 1] = key
	end
	updateInfoFrame = function()
		twipe(lines)
		twipe(sortedLines)
		--Show tank names and their current stacks
		for name, count in pairs(tankStacks) do
			addLine(name, count)
		end
		--Show a clear yes or no (also green or red) on whether it's safe to clear said stacks
		if mod.vb.tankSafeClear then
			addLine(L.SafeClear, "|cFF088A08"..YES.."|r")
		else
			addLine(L.SafeClear, "|cffff0000"..NO.."|r")
		end
		return lines, sortedLines
	end
end

local function resetRaidDebuff(self)
	self.vb.tankSafeClear = true
end

function mod:OnCombatStart(delay)
	self:SetStage(1)
	table.wipe(bossActive)
	tankStacks = {}
	--Neldris
	self.vb.rendingCount = 0
	self.vb.massiveSlamCount = 0
	self.vb.roarCount = 0
	self.vb.tankSafeClear = true
	if self:IsMythic() then
		timerBellowingRoarCD:Start(6-delay, 1)
		timerRendingChargeCD:Start(14-delay, 1)
		timerMassiveSlamCD:Start(24-delay, 1)
	else
		timerBellowingRoarCD:Start(10.6-delay, 1)
		timerRendingChargeCD:Start(19-delay, 1)
		timerMassiveSlamCD:Start(35.2-delay, 1)
	end
	--Thadrion
	table.wipe(essenceMarks)
	self.vb.essenceCount = 0
	self.vb.volatileSpewCount = 0
	self.vb.eruptionCount = 0
	--Rionthus
	self.vb.breathCount = 0
	self.vb.disintegrateCount = 0
	self.vb.anomalyCount = 0
	self:EnablePrivateAuraSound(406317, "targetyou", 2)--Rending Charge
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(406313))
		DBM.InfoFrame:Show(5, "function", updateInfoFrame, false, true)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 406358 then
		self.vb.rendingCount = self.vb.rendingCount + 1
		warnRendingCharge:Show(self.vb.rendingCount)
		local timer
		if self:IsMythic() then
			--14, 37, 18, 37, 18
			if self.vb.rendingCount % 2 == 0 then
				timer = 18
			else
				timer = 37
			end
		else
			timer = self.vb.rendingCount == 1 and 33.7 or 38.2
		end
		timerRendingChargeCD:Start(timer, self.vb.rendingCount+1)
	elseif spellId == 407733 or spellId == 404472 or spellId == 412117 then--2nd and later casts, first cast
		self.vb.massiveSlamCount = self.vb.massiveSlamCount + 1
		specWarnMassiveSlam:Show(self.vb.massiveSlamCount)
		specWarnMassiveSlam:Play("shockwave")
		local timer
		if self:IsMythic() then
			--Mythic only uses 407733 and instead is simple alternation
			--24, 17.9, 37, 18, 36.9
			--Doesn't need energy calculation, it's always same rotation since it's engage boss
			if self.vb.massiveSlamCount % 2 == 0 then
				timer = 36.9
			else
				timer = 17.9
			end
		else
			--Every slam is two slams, where first one is 404472 or 412117 and secondary slam 9.7 seconds later is 407733
			--so if ID not secondary cast, start 9.7 timer, else start long timer for next set of two
			timer = spellId == 407733 and 29.1 or 9.7
		end
		timerMassiveSlamCD:Start(timer, self.vb.massiveSlamCount+1)
	elseif spellId == 404713 then
		self.vb.roarCount = self.vb.roarCount + 1
		specWarnBellowingRoar:Show(self.vb.roarCount)
		specWarnBellowingRoar:Play("carefly")
		local timer
		if self:IsMythic() then
			--Doesn't need energy calculation, it's always same rotation since it's engage boss
			if self.vb.roarCount % 2 == 0 then
				timer = 25
			else
				timer = 30
			end
		else
			timer = self.vb.roarCount == 1 and 57.1 or 38.9
		end
		timerBellowingRoarCD:Start(timer, self.vb.roarCount+1)
	elseif spellId == 405042 then
		self.vb.essenceCount = self.vb.essenceCount + 1
		warnUnstableEssence:Show(self.vb.essenceCount)
		local timer
		if self:IsMythic() then
			local unit = self:GetUnitIdFromGUID(args.sourceGUID)
			if UnitPower(unit) < 30 then--It's 7 energy cast
				timer = 20.9
			else--It's 55 Energy cast, so next one will be after full rotationof ultimate
				timer = 33.9
			end
		else
			timer = self:GetFromTimersTable(allTimers, false, false, spellId, self.vb.essenceCount+1) or 27.5
		end
		timerUnstableEssenceCD:Start(timer, self.vb.essenceCount+1)
	elseif spellId == 405492 then
		self.vb.volatileSpewCount = self.vb.volatileSpewCount + 1
		specWarnVolatileSpew:Show(self.vb.volatileSpewCount)
		specWarnVolatileSpew:Play("watchstep")
		local timer
		if self:IsMythic() then
			local unit = self:GetUnitIdFromGUID(args.sourceGUID)
			if UnitPower(unit) < 50 then--It's 30 energy cast
				timer = 19.9
			else--It's 75 Energy cast, so next one will be after full rotationof ultimate
				timer = 34.9
			end
		else
			timer = self:GetFromTimersTable(allTimers, false, false, spellId, self.vb.volatileSpewCount+1) or 30.3
		end
		timerVolatileSpewCD:Start(timer, self.vb.volatileSpewCount+1)
	elseif spellId == 405375 or spellId == 407775 then
		self.vb.eruptionCount = self.vb.eruptionCount + 1
		specWarnViolentEruption:Show(self.vb.eruptionCount)
		specWarnViolentEruption:Play("aesoon")
		timerViolentEruptionCD:Start(self:IsMythic() and 54.9 or 66, self.vb.eruptionCount+1)
	elseif spellId == 406227 and self:AntiSpam(5, 2) then
		self.vb.breathCount = self.vb.breathCount + 1
		specWarnDeepBreath:Show(self.vb.breathCount)
		specWarnDeepBreath:Play("breathsoon")
		timerDeepBreathCD:Start(self:IsMythic() and 55 or 43.7, self.vb.breathCount+1)
	elseif spellId == 407552 then
		self.vb.anomalyCount = self.vb.anomalyCount + 1
		warnTemporalAnomaly:Show(self.vb.anomalyCount)
		timerTemporalAnomalyCD:Start(self:IsMythic() and 55 or 43.7, self.vb.anomalyCount+1)
	elseif spellId == 405391 then
		self.vb.disintegrateCount = self.vb.disintegrateCount + 1
		timerDisintegrateCD:Start(self:IsMythic() and 55 or 43.3, self.vb.disintegrateCount+1)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 406313 then
		local amount = args.amount or 1
		tankStacks[args.destName] = amount
		if not args:IsPlayer() then
			if amount % 3 == 0 then
				if amount >= 6 then
					--If you have no debuff, and other tank is high, you need to get a stack so you can clear that tank
					if not DBM:UnitDebuff("player", spellId) then
						specWarnInfusedStrikesTaunt:Show(args.destName)
						specWarnInfusedStrikesTaunt:Play("tauntboss")
					elseif self.vb.tankSafeClear then--You do have stacks, and it's safe to clear them with other tank
						specWarnInfusedStrikesHug:Show(args.destName)
						specWarnInfusedStrikesHug:Play("gathershare")
					end
				else
					warnInfusedStrikes:Show(args.destName, amount)
				end
			end
		else
			--If it's safe for you to clear, and you're at 6 stacks, the warning should also be emphasized on self so you start looking for your co tank (and maybe glance at infoframe)
			if self.vb.tankSafeClear and amount >= 6 then
				specWarnInfusedStrikesSelf:Show(amount)
				specWarnInfusedStrikesSelf:Play("stackhigh")
			else
				warnInfusedStrikes:Show(args.destName, amount)
			end
		end
	elseif spellId == 407302 and self:AntiSpam(3, 1) then
		self.vb.tankSafeClear = false
		local amount = args.amount or 1
		warnInfusedExplosion:Show(args.amount or 1)
		timerInfusedExplosion:Restart()
		self:Unschedule(resetRaidDebuff)
		self:Schedule(21, resetRaidDebuff, self)--1 extra second for good measure
	elseif spellId == 407327 then
		local amount = args.amount or 1
		if amount == 1 then
			warnUnstableEssenceTargets:CombinedShow(1, args.destName)
			if args:IsPlayer() then
				specWarnUnstableEssence:Show()
				specWarnUnstableEssence:Play("targetyou")
			end
			if self.Options.SetIconOnEssence then
				for i = 1, 8, 1 do
					if not essenceMarks[i] then
						essenceMarks[i] = args.destGUID
						self:SetIcon(args.destName, i)
						return
					end
				end
			end
		else
			if args:IsPlayer() and amount > 10 then
				local icon = GetRaidTargetIndex("player")
				local text = tostring(amount)
				if icon then
					text = "{rt"..icon.."} "..amount.." {rt"..icon.."}"
				end
				yellUnstableEssence:Yell(text)
			end
		end
	elseif spellId == 407617 then
		warnTemporalAnomalyAbsorbed:Show(args.destName)
	elseif spellId == 405392 then
		warnDisintegrate:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnDisintegrate:Show()
			specWarnDisintegrate:Play("range5")
			yellDisintegrate:Yell()
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 407327 then
		if self.Options.SetIconOnEssence then
			for i = 1, 8, 1 do
				if essenceMarks[i] == args.destGUID then
					essenceMarks[i] = nil
					self:SetIcon(args.destName, 0)
					return
				end
			end
		end
	elseif spellId == 406313 then
		tankStacks[args.destName] = nil
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 200912 then--Neldris
		timerRendingChargeCD:Stop()
		timerMassiveSlamCD:Stop()
		timerBellowingRoarCD:Stop()
	elseif cid == 200918 then--Rionthus
		timerDeepBreathCD:Stop()
		timerTemporalAnomalyCD:Stop()
		timerDisintegrateCD:Stop()
	elseif cid == 200913 then--Thadrion
		timerUnstableEssenceCD:Stop()
		timerVolatileSpewCD:Stop()
		timerViolentEruptionCD:Stop()
	end
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	for i = 1, 3 do
		local unitID = "boss"..i
		local GUID = UnitGUID(unitID)
		if GUID and not bossActive[GUID] then
			bossActive[GUID] = true
			local cid = self:GetCIDFromGUID(GUID)
			if cid == 200918 then--Rionthus
				self:SetStage(3)--Rare exception of stage not matching journal but it should have
				if self:IsMythic() then
					--Boss gains 2 energy per second, but +5 seconds after hitting 100 before restarting
					--Temporal Anomaly is cast at 17 mythic
					--Disintegrate is cast at 41 mythic
					--Only acception for energy rules for casts is if the cast is within first 5 seconds of spawn
					--it'll be delayed and cast after 5 second no cast window, as long as a new spells energy window hasn't activated (else cast is skipped)
					--(this exception is not really coded in at moment)
					local bossPower = UnitPower(unitID)
					if bossPower < 17 then--Temporal Anomaly first
						--Next cast at 17 energy
						local tempTimer = (17 - bossPower) / 2
						timerTemporalAnomalyCD:Start(tempTimer, 1)
						--Next cast at 41 energy
						local disTimer = (41 - bossPower) / 2
						timerDisintegrateCD:Start(disTimer, 1)
						--Next cast at 100 energy
						local deepTimer = (100 - bossPower) / 2
						timerDeepBreathCD:Start(deepTimer, 1)
					elseif bossPower < 41 then--Disintegrate first
						--Next cast at 41 energy
						local disTimer = (41 - bossPower) / 2
						timerDisintegrateCD:Start(disTimer, 1)
						--Next cast at 100 energy
						local deepTimer = (100 - bossPower) / 2
						timerDeepBreathCD:Start(deepTimer, 1)
						--Next cast at 17 energy after energy reset
						local tempTimer = (117 - bossPower) / 2
						timerTemporalAnomalyCD:Start(tempTimer + 5, 1)
					else--Deep Breath first
						--Next cast at 100 energy
						local deepTimer = (100 - bossPower) / 2
						timerDeepBreathCD:Start(deepTimer, 1)
						--Next cast at 17 energy after energy reset
						local tempTimer = (117 - bossPower) / 2
						timerTemporalAnomalyCD:Start(tempTimer + 5, 1)
						--Next cast at 41 energy after energy reset
						local disTimer = (141 - bossPower) / 2
						timerDisintegrateCD:Start(disTimer + 5, 1)
					end
				else
					timerDisintegrateCD:Start(6.2, 1)
					timerTemporalAnomalyCD:Start(16.8, 1)
					timerDeepBreathCD:Start(30.4, 1)
				end
			elseif cid == 200913 then--Thadrion
				self:SetStage(2)--Rare exception of stage not matching journal but it should have
				if self:IsMythic() then
					--Boss gains 2 energy per second, but +5 seconds after hitting 100 before restarting
					--Volatile Spew is cast at 30 and 75 Energy on mythic
					--Unstable Essence is cast at 7 energy and 55 Energy on Mythic
					--Only acception for energy rules for casts is if the cast is within first 5 seconds of spawn
					--it'll be delayed and cast after 5 second no cast window, as long as a new spells energy window hasn't activated (else cast is skipped)
					--(this exception is not really coded in at moment)
					local bossPower = UnitPower(unitID)
					if bossPower < 7 then--Unstable might be first, but this probably won't happen until 11.x
						timerUnstableEssenceCD:Start(5, 1)--Min CD of 5 rule will be applied anyways so no need to calculate it
						--Next cast at 30 energy
						local spewTimer = (30 - bossPower) / 2
						timerVolatileSpewCD:Start(spewTimer, 1)
						--Next cast at 100 energy
						local violentTimer = (100 - bossPower) / 2
						timerViolentEruptionCD:Start(violentTimer, 1)
					elseif bossPower < 30 then--Volatile Spew will be first (and will be cast twice before special)
						--Next cast at 30 energy
						local spewTimer = (30 - bossPower) / 2
						timerVolatileSpewCD:Start(spewTimer, 1)
						--Next cast is at 55 energy
						local unstableTimer = (55 - bossPower) / 2
						timerUnstableEssenceCD:Start(unstableTimer, 1)
						--Next cast at 100 energy
						local violentTimer = (100 - bossPower) / 2
						timerViolentEruptionCD:Start(violentTimer, 1)
					elseif bossPower < 55 then--Unstable will be first
						--Next cast is at 55 energy
						local unstableTimer = (55 - bossPower) / 2
						timerUnstableEssenceCD:Start(unstableTimer, 1)
						--Next cast at 75 energy
						local spewTimer = (75 - bossPower) / 2
						timerVolatileSpewCD:Start(spewTimer, 1)
						--Next cast at 100 energy
						local violentTimer = (100 - bossPower) / 2
						timerViolentEruptionCD:Start(violentTimer, 1)
					elseif bossPower < 75 then--Volatile Spew will be first (but only cast once)
						--Next cast at 75 energy
						local spewTimer = (75 - bossPower) / 2
						timerVolatileSpewCD:Start(spewTimer, 1)
						--Next cast at 100 energy
						local violentTimer = (100 - bossPower) / 2
						timerViolentEruptionCD:Start(violentTimer, 1)
						--Next cast is at 7 energy so we have to calculate to (100 energy + 7) / 2 then + 5 seconds outside energy calculation
						local unstableTimer = (107 - bossPower) / 2
						timerUnstableEssenceCD:Start(unstableTimer + 5, 1)
					else--He's just gonna ultimate first
						--Next cast at 100 energy
						local violentTimer = (100 - bossPower) / 2
						timerViolentEruptionCD:Start(violentTimer, 1)
						--Next cast is at 7 energy so we have to calculate to (100 energy + 7) / 2 then + 5 seconds outside energy calculation
						local unstableTimer = (107 - bossPower) / 2
						timerUnstableEssenceCD:Start(unstableTimer + 5, 1)
						--Next cast at 30 energy
						local spewTimer = (130 - bossPower) / 2
						timerVolatileSpewCD:Start(spewTimer + 5, 1)
					end
				else
					--Always comes out at 29 power, first power update will fire at 31
					timerVolatileSpewCD:Start(5.3, 1)--Used at 41 and 80 Power first time (then after first rotation switches to 26/??)
					timerUnstableEssenceCD:Start(16.5, 1)--Used at 61-63 Power (also at 11 power but boss never starts at low)
					timerViolentEruptionCD:Start(38.4, 1)--Used at 100 Power (then can switch to cooldown code after)
				end
			end
		end
	end
end

--Slightly faster than CLEU
-- "<289.58 23:45:20> [UNIT_SPELLCAST_SUCCEEDED] Rionthus(80.8%-100.0%){Target:Andykay} -Deep Breath- [[boss2:Cast-3-2083-2569-2683-405814-01031E2802:405814]]",
-- "<289.62 23:45:20> [CHAT_MSG_RAID_BOSS_EMOTE] |TInterface\\\\Icons\\\\Ability_Evoker_DeepBreath.blp:20|tRionthus prepares to take in a |cFFFF0000|Hspell:406227|h[Deep Breath]|h|r!
-- "<290.65 23:45:21> [CLEU] SPELL_CAST_START#Creature-0-2083-2569-2683-200918-00001E266C#Rionthus(80.4%-100.0%)##nil#406227#Deep Breath#nil#nil",
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 405814 and self:AntiSpam(5, 2) then--Deep Breath
		self.vb.breathCount = self.vb.breathCount + 1
		specWarnDeepBreath:Show(self.vb.breathCount)
		specWarnDeepBreath:Play("breathsoon")
		timerDeepBreathCD:Start(self:IsMythic() and 55 or 43.1, self.vb.breathCount+1)
	end
end
