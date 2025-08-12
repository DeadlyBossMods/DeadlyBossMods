local mod	= DBM:NewMod(2747, "DBM-Raids-WarWithin", 1, 1302)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(237861)
mod:SetEncounterID(3133)
mod:SetHotfixNoticeRev(20250712000000)
--mod:SetMinSyncRevision(20240921000000)
mod:SetZone(2810)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 1220394 1231871 1225673",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 1227378 1227373 1231871 1247424",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 1247424",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED"
	"RAID_BOSS_WHISPER",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, what do with https://www.wowhead.com/ptr-2/spell=1236784/brittle-nexus
--TODO, what do with https://www.wowhead.com/ptr-2/spell=1236785/void-infused-nexus
--NOTE: Conjunction debuff not in combat log, have to use UNIT_AURA or RBW, using RBW for now
--[[
(ability.id = 1220394 or ability.id = 1227367 or ability.id = 1231871 or ability.id = 1225673) and type = "begincast"
or ability.id = 1227367 and type = "cast"
or ability.id = 1233416 and type = "begincast"
--]]
--mod:AddTimerLine(DBM:EJ_GetSectionInfo(28754))
local warnCrystallineEruption						= mod:NewTargetNoFilterAnnounce(1233416, 3)

local specWarnCrystallineEruption					= mod:NewSpecialWarningYou(1233416, nil, nil, nil, 1, 17)
--local yellCrystallineEruption						= mod:NewShortYell(1233416)
--local yellCrystallineEruptionFades				= mod:NewShortFadesYell(1233416)
local specWarnNullConsumption						= mod:NewSpecialWarningMoveAway(1247424, nil, nil, nil, 1, 2, 3)
local yellNullConsumption							= mod:NewShortYell(1247424, nil, false)
local yellNullConsumptionFades						= mod:NewShortFadesYell(1247424, nil, false)
local specWarnShatteringBackhand					= mod:NewSpecialWarningCount(1220394, nil, nil, nil, 2, 2)
local specWarnShatterShell							= mod:NewSpecialWarningMoveTo(1227373, nil, nil, nil, 1, 13)
local specWarnCrystallized							= mod:NewSpecialWarningYou(1227378, nil, nil, nil, 1, 2)--Redundant to pre debuff already having warning
local specWarnShockwaveSlam							= mod:NewSpecialWarningDefensive(1231871, nil, nil, nil, 1, 2)
local specWarnShockwaveSlamTaunt					= mod:NewSpecialWarningTaunt(1231871, nil, nil, nil, 1, 2)
local specWarnEnragedShattering						= mod:NewSpecialWarningSpell(1225673, nil, nil, nil, 3, 2)--Fight failure, you're dead when cast finishes
--local specWarnGTFO								= mod:NewSpecialWarningGTFO(459785, nil, nil, nil, 1, 8)

local timerCrystallineEruptionCD					= mod:NewVarCountTimer("v6.1-23.1", 1233416, nil, nil, nil, 2)--Can't be cast during other spells so it gets radically spell queued (hopefully blizzard fixes this)
local timerShatteringBackhandCD						= mod:NewCDCountTimer(39.3, 1220394, nil, nil, nil, 2)
local timerShatterShellCD							= mod:NewVarCountTimer("v38.5-40.5", 1227373, nil, nil, nil, 3)
local timerShockwaveSlamCD							= mod:NewVarCountTimer("v38.9-41.3", 1231871, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)

mod.vb.eruptionCount = 0
mod.vb.backhandCount = 0
mod.vb.crystallizationCount = 0
mod.vb.shockwaveSlamCount = 0
local crystal = DBM:GetSpellInfo(1226089)

function mod:OnCombatStart(delay)
	self.vb.eruptionCount = 0
	self.vb.backhandCount = 0
	self.vb.crystallizationCount = 0
	self.vb.shockwaveSlamCount = 0
	if self:IsMythic() then
		timerCrystallineEruptionCD:Start(6.1-delay, 1)
		timerShockwaveSlamCD:Start(19.5-delay, 1)
		timerShatterShellCD:Start(40.8-delay, 1)
		timerShatteringBackhandCD:Start(48.3-delay, 1)
	else
		timerCrystallineEruptionCD:Start(3.7-delay, 1)
		timerShockwaveSlamCD:Start(15.9-delay, 1)
		timerShatterShellCD:Start(31.5-delay, 1)
		timerShatteringBackhandCD:Start(37.8-delay, 1)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 1220394 then
		self.vb.backhandCount = self.vb.backhandCount + 1
		specWarnShatteringBackhand:Show(self.vb.backhandCount)
		if DBM:UnitDebuff("player", 1227378) then
			specWarnShatteringBackhand:Play("carefly")
		else
			specWarnShatteringBackhand:Play("aesoon")
		end
		timerShatteringBackhandCD:Start(self:IsMythic() and 50 or 39.3, self.vb.backhandCount+1)
	elseif spellId == 1231871 then
		self.vb.shockwaveSlamCount = self.vb.shockwaveSlamCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnShockwaveSlam:Show()
			specWarnShockwaveSlam:Play("defensive")
		end
		timerShockwaveSlamCD:Start(self:IsMythic() and 50 or "v38.9-41.3", self.vb.shockwaveSlamCount+1)
	elseif spellId == 1225673 then
		specWarnEnragedShattering:Show()
		specWarnEnragedShattering:Play("stilldanger")
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 1227367 then
		self.vb.crystallizationCount = self.vb.crystallizationCount + 1
		timerShatterShellCD:Start(nil, self.vb.crystallizationCount)
	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 1227373 then
		if args:IsPlayer() then
			specWarnShatterShell:Show(crystal)
			specWarnShatterShell:Play("movetopillar")--Maybe customa audio for crystals
		end
	elseif spellId == 1231871 and not args:IsPlayer() then
		specWarnShockwaveSlamTaunt:Show(args.destName)
		specWarnShockwaveSlamTaunt:Play("tauntboss")
	elseif spellId == 1247424 then
		if args:IsPlayer() then
			specWarnNullConsumption:Show()
			specWarnNullConsumption:Play("runout")
			yellNullConsumption:Yell()
			yellNullConsumptionFades:Countdown(1247424)
		end
	elseif spellId == 1227378 and args:IsPlayer() then
		specWarnCrystallized:Show()
		specWarnCrystallized:Play("targetyou")
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 1247424 then
		if args:IsPlayer() then
			yellNullConsumptionFades:Cancel()
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

function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("spell:1233416") then
		specWarnCrystallineEruption:Show()
		specWarnCrystallineEruption:Play("lineyou")
--		yellCrystallineEruption:Yell()
--		yellCrystallineEruptionFades:Countdown(3)
	end
end

function mod:OnTranscriptorSync(msg, targetName)
	if msg:find("spell:1233416") then
		warnCrystallineEruption:CombinedShow(1, targetName)--Long aggregation since we collect targets via syncs
	end
end

--"<5.73 22:49:09> [UNIT_SPELLCAST_SUCCEEDED] Fractillus(99.1%-9.0%){Target:Tiefpal-Fyrakk} -Entropic Conjunction- [[boss1:Cast-3-5770-2810-337-1233411-001EDF03C6:1233411]]",
--"<12.74 22:49:16> [CLEU] SPELL_CAST_START#Creature-0-5770-2810-337-237861-00005F0369#Fractillus(94.4%-30.0%)##nil#1233416#Entropic Conjunction#nil#nil#nil#nil#nil#nil",
function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, spellId)
	if spellId == 1233411 then--Much sooner than spell cast start event (when pre target debuffs go out)
		self.vb.eruptionCount = self.vb.eruptionCount + 1
		--"Entropic Conjunction-1233411-npc:237861-00005F0369 = pull:3.7, 17.0, 23.1, 17.1, 22.3, 17.1, 16.5, 6.1, 17.0, 23.1, 17.0, 21.9, 17.0, 23.1, 17.0, 22.8, 16.2, 17.0, 8.5",
		--"Crystalline Eruption-1233416-npc:237861-0000717142 = pull:14.1, 20.3, 30.5, 20.7, 29.4, 21.1, 29.1, 20.9, 29.4, 21.1, 28.9, 20.7",
		if self:IsMythic() then
			if self.vb.eruptionCount % 2 == 0 then
				timerCrystallineEruptionCD:Start("v28.9-30.5", self.vb.eruptionCount+1)
			else
				timerCrystallineEruptionCD:Start(20.3, self.vb.eruptionCount+1)--20.3-20.7 (not big enough window for full variance timer
			end
		else--Likely also fixed but leaving until vetted
			timerCrystallineEruptionCD:Start("v6.1-23.1", self.vb.eruptionCount+1)
		end
	elseif spellId == 1227367 then--Cast not in combat log (debuff is though)
		self.vb.crystallizationCount = self.vb.crystallizationCount + 1
		timerShatterShellCD:Start(self:IsMythic() and 50 or "v38.5-40.5", self.vb.crystallizationCount+1)
	end
end
