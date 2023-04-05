local mod	= DBM:NewMod(2530, "DBM-Aberrus", nil, 1208)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(200912, 200913, 200918)
mod:SetEncounterID(2693)
mod:SetUsedIcons(1, 2, 3)
mod:SetBossHPInfoToHighest()
mod:SetHotfixNoticeRev(20230404000000)
--mod:SetMinSyncRevision(20221215000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 406358 404472 407733 404713 405042 405492 405375 406227 407552 405391 407775",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 406313 407302 407327 407617 405392",
	"SPELL_AURA_APPLIED_DOSE 406313 407302",
	"SPELL_AURA_REMOVED 407327",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3"
)

--[[
(ability.id = 406358 or ability.id = 407733 or ability.id = 404472 or ability.id = 404713 or ability.id = 405042 or ability.id = 405492 or ability.id = 407775 or ability.id = 405375 or ability.id = 406227 or ability.id = 407552 or ability.id = 405391) and type  = "begincast"
 or (source.type = "NPC" and source.firstSeen = timestamp) and (source.id = 200912 or source.id = 200913 or source.id = 200918) or (target.type = "NPC" and target.firstSeen = timestamp) and (target.id = 200912 or target.id = 200913 or target.id = 200918)
--]]
--TODO, what do you actually do with Temporal Anomaly, soak it?
--NOTE, Rending Charge is a private aura
--General
--local specWarnGTFO								= mod:NewSpecialWarningGTFO(370648, nil, nil, nil, 1, 8)

local timerInfusedStrikes							= mod:NewBuffFadesTimer(20, 407302, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON..DBM_COMMON_L.HEALER_ICON)--Track the aura that needs to fall off before tanks "clear" again
--local berserkTimer								= mod:NewBerserkTimer(600)
--Neldris
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26001))
local warnInfusedStrikes							= mod:NewStackAnnounce(406313, 2, nil, "Tank|Healer")

local specWarnRendingCharge							= mod:NewSpecialWarningIncomingCount(406358, nil, nil, nil, 1, 14)
local specWarnMassiveSlam							= mod:NewSpecialWarningDodgeCount(404472, nil, nil, nil, 2, 2)
local specWarnBellowingRoar							= mod:NewSpecialWarningCount(404713, nil, nil, nil, 2, 2)

local timerRendingChargeCD							= mod:NewCDCountTimer(34.2, 406358, nil, nil, nil, 3)
local timerMassiveSlamCD							= mod:NewCDCountTimer(39, 404472, nil, nil, nil, 3)
local timerBellowingRoarCD							= mod:NewCDCountTimer(23.1, 404713, nil, nil, nil, 2)

--mod:AddInfoFrameOption(361651, true)
--mod:AddRangeFrameOption(5, 390715)
--mod:AddNamePlateOption("NPAuraOnAscension", 385541)
--Thadrion
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26322))
local warnUnstableEssence							= mod:NewCastAnnounce(405042, 3)
local warnUnstableEssenceTargets					= mod:NewTargetAnnounce(405042, 2)

local specWarnUnstableEssence						= mod:NewSpecialWarningYou(405042, nil, nil, nil, 1, 2)
local specWarnVolatileSpew							= mod:NewSpecialWarningDodgeCount(405492, nil, nil, nil, 2, 2)
local specWarnViolentEruption						= mod:NewSpecialWarningCount(405375, nil, nil, nil, 2, 2)

local timerUnstableEssenceCD						= mod:NewCDCountTimer(29.2, 405042, nil, nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)
local timerVolatileSpewCD							= mod:NewCDCountTimer(26, 405492, nil, nil, nil, 3)
local timerViolentEruptionCD						= mod:NewCDCountTimer(68.3, 405375, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)

mod:AddSetIconOption("SetIconOnEssence", 405042, false, 0, {1, 2, 3})
--Rionthus
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26329))
local warnTemporalAnomaly							= mod:NewCastAnnounce(407552, 3)
local warnTemporalAnomalyAbsorbed					= mod:NewTargetNoFilterAnnounce(407552, 2)
local warnDisintegrate								= mod:NewTargetAnnounce(405391, 2)

local specWarnDeepBreath							= mod:NewSpecialWarningDodgeCount(406227, nil, nil, nil, 2, 2)
local specWarnDisintegrate							= mod:NewSpecialWarningMoveAway(405392, nil, nil, nil, 1, 2)
local yellDisintegrate								= mod:NewShortYell(405392)

local timerDeepBreathCD								= mod:NewCDCountTimer(42.7, 406227, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerTemporalAnomalyCD						= mod:NewCDCountTimer(43.7, 407552, nil, nil, nil, 5)
local timerDisintegrateCD							= mod:NewCDCountTimer(43.7, 405391, nil, nil, nil, 3)

mod.vb.rendingCount = 0
mod.vb.massiveSlamCount = 0
mod.vb.roarCount = 0
mod.vb.essenceCount = 0
mod.vb.volatileSpewCount = 0
mod.vb.eruptionCount = 0
mod.vb.breathCount = 0
mod.vb.disintegrateCount = 0
mod.vb.anomalyCount = 0
local essenceMarks = {}
local bossActive = {}
local allTimers = {
	--Volatile Spew
	[405492] = {0, 26.8, 28.8, 25.6, 37.7, 25.6, 25.5},
	--Unstable Essence
	[405042] = {0, 52.4, 29.2, 31.6, 29.2, 34.0},
	--Rending Charge
--	[406358] = {14.4, 33.7, 44.2, 45.0, 46.3},
}

function mod:OnCombatStart(delay)
	table.wipe(bossActive)
	--Neldris
	self.vb.rendingCount = 0
	self.vb.massiveSlamCount = 0
	self.vb.roarCount = 0
	timerRendingChargeCD:Start(14.3-delay, 1)
	timerMassiveSlamCD:Start(30.2-delay, 1)
	timerBellowingRoarCD:Start(6.2-delay, 1)
	--Thadrion
	table.wipe(essenceMarks)
	self.vb.essenceCount = 0
	self.vb.volatileSpewCount = 0
	self.vb.eruptionCount = 0
	--Rionthus
	self.vb.breathCount = 0
	self.vb.disintegrateCount = 0
	self.vb.anomalyCount = 0
--	if self.Options.NPAuraOnAscension then
--		DBM:FireEvent("BossMod_EnableHostileNameplates")
--	end
end

--function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
--	if self.Options.NPAuraOnAscension then
--		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
--	end
--end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 406358 then
		self.vb.rendingCount = self.vb.rendingCount + 1
		specWarnRendingCharge:Show(self.vb.rendingCount)
		specWarnRendingCharge:Play("incomingdebuff")
		timerRendingChargeCD:Start(self.vb.rendingCount == 1 and 33.7 or 44.2, self.vb.rendingCount+1)
	elseif spellId == 407733 or spellId == 404472 then--2nd and later casts, first cast
		self.vb.massiveSlamCount = self.vb.massiveSlamCount + 1
		specWarnMassiveSlam:Show(self.vb.massiveSlamCount)
		specWarnMassiveSlam:Play("shockwave")
		--"Massive Slam-404472-npc:200912-00001E240E = pull:30.3",
		--"Massive Slam-407733-npc:200912-00001E240E = pull:69.3, 46.2, 46.2, 46.2",
		timerMassiveSlamCD:Start(spellId == 404472 and 38 or 46.2, self.vb.massiveSlamCount+1)
	elseif spellId == 404713 then
		self.vb.roarCount = self.vb.roarCount + 1
		specWarnBellowingRoar:Show(self.vb.roarCount)
		specWarnBellowingRoar:Play("carefly")
		--"Bellowing Roar-404713-npc:200912-00001E240E = pull:5.8, 35.5, 23.1, 23.0, 23.1, 23.1, 23.1, 23.2, 23.1",
		timerBellowingRoarCD:Start(self.vb.roarCount == 1 and 35 or 23, self.vb.roarCount+1)
	elseif spellId == 405042 then
		self.vb.essenceCount = self.vb.essenceCount + 1
		warnUnstableEssence:Show(self.vb.essenceCount)
		--"Unstable Essence-405042-npc:200913-00001E240E = pull:237.1, 52.4, 29.2, 31.6, 29.2, 34.0",
		local timer = self:GetFromTimersTable(allTimers, false, false, spellId, self.vb.essenceCount+1) or 29.2
		timerUnstableEssenceCD:Start(timer, self.vb.essenceCount+1)
	elseif spellId == 405492 then
		self.vb.volatileSpewCount = self.vb.volatileSpewCount + 1
		specWarnVolatileSpew:Show(self.vb.volatileSpewCount)
		local timer = self:GetFromTimersTable(allTimers, false, false, spellId, self.vb.volatileSpewCount+1) or 25.5
		timerVolatileSpewCD:Start(timer, self.vb.volatileSpewCount+1)
	elseif spellId == 405375 or spellId == 407775 then
		self.vb.eruptionCount = self.vb.eruptionCount + 1
		specWarnViolentEruption:Show(self.vb.eruptionCount)
		specWarnViolentEruption:Play("aesoon")
		timerViolentEruptionCD:Start(nil, self.vb.eruptionCount+1)
	elseif spellId == 406227 and self:AntiSpam(5, 2) then
		self.vb.breathCount = self.vb.breathCount + 1
		specWarnDeepBreath:Show(self.vb.breathCount)
		specWarnDeepBreath:Play("breathsoon")
		timerDeepBreathCD:Start(nil, self.vb.breathCount+1)
	elseif spellId == 407552 then
		self.vb.anomalyCount = self.vb.anomalyCount + 1
		warnTemporalAnomaly:Show(self.vb.anomalyCount)
		timerTemporalAnomalyCD:Start(nil, self.vb.anomalyCount+1)
	elseif spellId == 405391 then
		self.vb.disintegrateCount = self.vb.disintegrateCount + 1
		timerDisintegrateCD:Start(nil, self.vb.disintegrateCount+1)
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 394917 then

	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 406313 and not args:IsPlayer() then
		local amount = args.amount or 1
		if amount % 3 == 0 then--Guessed, Filler
			warnInfusedStrikes:Show(args.destName, amount)
		end
	elseif spellId == 407302 and self:AntiSpam(3, 1) then
		timerInfusedStrikes:Restart()
	elseif spellId == 407327 then
		warnUnstableEssenceTargets:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnUnstableEssence:Show()
			specWarnUnstableEssence:Play("targetyou")
		end
		if self.Options.SetIconOnEssence then
			for i = 1, 3, 1 do
				if not essenceMarks[i] then
					essenceMarks[i] = args.destGUID
					self:SetIcon(args.destName, i)
					return
				end
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
			for i = 1, 3, 1 do
				if essenceMarks[i] == args.destGUID then
					essenceMarks[i] = nil
					self:SetIcon(args.destName, 0)
					return
				end
			end
		end
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
				timerDisintegrateCD:Start(6.8, 1)
				timerTemporalAnomalyCD:Start(17.8, 1)
				timerDeepBreathCD:Start(30.4, 1)
			elseif cid == 200913 then--Thadrion
				timerVolatileSpewCD:Start(5.3, 1)
				timerUnstableEssenceCD:Start(17, 1)
				timerViolentEruptionCD:Start(44.3, 1)
			--elseif cid == 200912 then--Neldris (in case a diff boss can start)
			--	timerRendingChargeCD:Stop()
			--	timerMassiveSlamCD:Stop()
			--	timerBellowingRoarCD:Stop()
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
		timerDeepBreathCD:Start(nil, self.vb.breathCount+1)
	end
end
