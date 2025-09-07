local mod	= DBM:NewMod(2747, "DBM-Raids-WarWithin", 1, 1302)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(237861)
mod:SetEncounterID(3133)
mod:SetHotfixNoticeRev(20250818000000)
--mod:SetMinSyncRevision(20240921000000)
mod:SetZone(2810)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 1220394 1231871 1225673",
	"SPELL_CAST_SUCCESS 1233411",
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
or (ability.id = 1233411 or ability.id = 1227367) and type = "cast"
--]]
--mod:AddTimerLine(DBM:EJ_GetSectionInfo(28754))
local warnCrystallineShockwave						= mod:NewTargetNoFilterAnnounce(1233416, 3, nil, nil, nil, nil, 189161)

local specWarnCrystallineShockwave					= mod:NewSpecialWarningYou(1233416, nil, 189161, nil, 1, 17)
--local yellCrystallineShockwave					= mod:NewShortYell(1233416)
--local yellCrystallineShockwaveFades				= mod:NewShortFadesYell(1233416)
local specWarnNullConsumption						= mod:NewSpecialWarningMoveAway(1247424, nil, 37859, nil, 1, 2, 3)--Shortname "Bomb"
local yellNullConsumption							= mod:NewShortYell(1247424, 37859, false)
local yellNullConsumptionFades						= mod:NewShortFadesYell(1247424, nil, false)
local specWarnShatteringBackhand					= mod:NewSpecialWarningCount(1220394, nil, nil, nil, 2, 2)
local specWarnShatterShell							= mod:NewSpecialWarningMoveTo(1227373, nil, nil, nil, 1, 13)
local specWarnCrystallized							= mod:NewSpecialWarningYou(1227378, nil, nil, nil, 1, 2)--Redundant to pre debuff already having warning
local specWarnShockwaveSlam							= mod:NewSpecialWarningDefensive(1231871, nil, nil, nil, 1, 2)
local specWarnShockwaveSlamTaunt					= mod:NewSpecialWarningTaunt(1231871, nil, nil, nil, 1, 2)
local specWarnEnragedShattering						= mod:NewSpecialWarningSpell(1225673, nil, nil, nil, 3, 2)--Fight failure, you're dead when cast finishes
--local specWarnGTFO								= mod:NewSpecialWarningGTFO(459785, nil, nil, nil, 1, 8)

local timerCrystallineShockwaveCD					= mod:NewVarCountTimer("v6.1-23.1", 1233416, 189161, nil, nil, 2)--Shortname "Walls"
local timerShatteringBackhandCD						= mod:NewVarCountTimer(39.3, 1220394, 28405, nil, nil, 2)--Shortname "Knockback" (matches BW but questionable, most players don't actually get knocked back, just debuffed ones
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
	timerCrystallineShockwaveCD:Start(7-delay, 1)
	if self:IsMythic() then
		timerShockwaveSlamCD:Start(14.3-delay, 1)
		timerShatterShellCD:Start(32.4-delay, 1)
		timerShatteringBackhandCD:Start(38.6-delay, 1)
	else
		timerShockwaveSlamCD:Start(18.1-delay, 1)
		timerShatterShellCD:Start(40.2-delay, 1)
		timerShatteringBackhandCD:Start(48.9-delay, 1)
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
		timerShatteringBackhandCD:Start(self:IsMythic() and 40 or "v49.9-51.5", self.vb.backhandCount+1)
	elseif spellId == 1231871 then
		self.vb.shockwaveSlamCount = self.vb.shockwaveSlamCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnShockwaveSlam:Show()
			specWarnShockwaveSlam:Play("defensive")
		end
		timerShockwaveSlamCD:Start(self:IsMythic() and 40 or "v49.9-51.5", self.vb.shockwaveSlamCount+1)
	elseif spellId == 1225673 then
		specWarnEnragedShattering:Show()
		specWarnEnragedShattering:Play("stilldanger")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 1233411 then--Much sooner than spell cast start event (when pre target debuffs go out)
		self.vb.eruptionCount = self.vb.eruptionCount + 1
		if self.vb.eruptionCount % 2 == 0 then
			timerCrystallineShockwaveCD:Start(self:IsMythic() and 25.5 or "v28.9-30.5", self.vb.eruptionCount+1)
		else
			timerCrystallineShockwaveCD:Start(self:IsMythic() and 14.6 or "v20.3-21.4", self.vb.eruptionCount+1)
		end
	end
end

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
		specWarnCrystallineShockwave:Show()
		specWarnCrystallineShockwave:Play("lineyou")
--		yellCrystallineShockwave:Yell()
--		yellCrystallineShockwaveFades:Countdown(3)
	end
end

function mod:OnTranscriptorSync(msg, targetName)
	if msg:find("spell:1233416") then
		warnCrystallineShockwave:CombinedShow(1, targetName)--Long aggregation since we collect targets via syncs
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, spellId)
	if spellId == 1227367 then--Cast not in combat log (debuff is though)
		self.vb.crystallizationCount = self.vb.crystallizationCount + 1
		timerShatterShellCD:Start(self:IsMythic() and 40 or "v49.9-51.5", self.vb.crystallizationCount+1)
	end
end
