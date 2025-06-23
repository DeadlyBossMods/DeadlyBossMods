if DBM:GetTOC() < 110200 then return end
local mod	= DBM:NewMod(2747, "DBM-Raids-WarWithin", 1, 1302)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(237861)
mod:SetEncounterID(3133)
mod:SetHotfixNoticeRev(20250622000000)
--mod:SetMinSyncRevision(20240921000000)
mod:SetZone(2810)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 1233416 1230610 1225938 1220394 1227367 1231871",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 1227378 1227373 1231871"
--	"SPELL_AURA_APPLIED_DOSE",
--	"SPELL_AURA_REMOVED",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED"
--	"CHAT_MSG_RAID_BOSS_WHISPER",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, what do with https://www.wowhead.com/ptr-2/spell=1236784/brittle-nexus
--TODO, what do with https://www.wowhead.com/ptr-2/spell=1236785/void-infused-nexus
--TODO, use https://www.wowhead.com/ptr-2/spell=1246806/entropic-conjunction or https://www.wowhead.com/ptr-2/spell=1233411/entropic-conjunction ?
--mod:AddTimerLine(DBM:EJ_GetSectionInfo(28754))
--local warnDecimate								= mod:NewIncomingCountAnnounce(442428, 3)

local specWarnEntropicConjunction					= mod:NewSpecialWarningCount(1233416, nil, nil, nil, 2, 2)
local specWarnCrystallineBackhand					= mod:NewSpecialWarningCount(1220394, nil, nil, nil, 2, 2)
local specWarnNetherCrystallization					= mod:NewSpecialWarningMoveTo(1227373, nil, nil, nil, 1, 13)
--local specWartnCrystallized						= mod:NewSpecialWarningYou(1220394, nil, nil, nil, 1, 2)--Redundant to pre debuff already having warning
local specWarnShockwaveSlam							= mod:NewSpecialWarningDefensive(1231871, nil, nil, nil, 1, 2)
local specWarnShockwaveSlamTaunt					= mod:NewSpecialWarningTaunt(1231871, nil, nil, nil, 1, 2)
--local specWarnGTFO								= mod:NewSpecialWarningGTFO(459785, nil, nil, nil, 1, 8)

local timerEntropicConjunctionCD					= mod:NewAITimer(97.3, 1233416, nil, nil, nil, 2)
local timerCrystallineBackhandCD					= mod:NewAITimer(97.3, 1220394, nil, nil, nil, 2)
local timerNetherCrystallizationCD					= mod:NewAITimer(97.3, 1227373, nil, nil, nil, 3)
local timerShockwaveSlamCD							= mod:NewAITimer(97.3, 1231871, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)

mod.vb.conunctionCount = 0
mod.vb.backhandCount = 0
mod.vb.crystallizationCount = 0
mod.vb.shockwaveSlamCount = 0
local crystal = DBM:GetSpellInfo(1226089)

function mod:OnCombatStart(delay)
	self.vb.conunctionCount = 0
	self.vb.backhandCount = 0
	self.vb.crystallizationCount = 0
	self.vb.shockwaveSlamCount = 0
	timerEntropicConjunctionCD:Start(1-delay)
	timerCrystallineBackhandCD:Start(1-delay)
	timerNetherCrystallizationCD:Start(1-delay)
	timerShockwaveSlamCD:Start(1-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if (spellId == 1233416 or spellId == 1230610 or spellId == 1225938) and self:AntiSpam(5, 1) then
		self.vb.conunctionCount = self.vb.conunctionCount + 1
		specWarnEntropicConjunction:Show(self.vb.conunctionCount)
		specWarnEntropicConjunction:Play("specialsoon")
		timerEntropicConjunctionCD:Start()--nil, self.vb.conunctionCount+1
	elseif spellId == 1220394 then
		self.vb.backhandCount = self.vb.backhandCount + 1
		specWarnCrystallineBackhand:Show(self.vb.backhandCount)
		if DBM:UnitDebuff("player", 1227378) then
			specWarnCrystallineBackhand:Play("carefly")
		else
			specWarnCrystallineBackhand:Play("aesoon")
		end
		timerCrystallineBackhandCD:Start()--nil, self.vb.backhandCount
	elseif spellId == 1227367 then
		self.vb.crystallizationCount = self.vb.crystallizationCount + 1
		timerNetherCrystallizationCD:Start()--nil, self.vb.crystallizationCount
	elseif spellId == 1231871 then
		self.vb.shockwaveSlamCount = self.vb.shockwaveSlamCount + 1
		if self:IsTanking("player", nil, nil, true) then
			specWarnShockwaveSlam:Show()
			specWarnShockwaveSlam:Play("defensive")
		end
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 439559 then

	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 1227373 then
		if args:IsPlayer() then
			specWarnNetherCrystallization:Show(crystal)
			specWarnNetherCrystallization:Play("movetopillar")--Maybe customa audio for crystals
		end
	elseif spellId == 1231871 and not args:IsPlayer() then
		specWarnShockwaveSlamTaunt:Show(args.destName)
		specWarnShockwaveSlamTaunt:Play("tauntboss")
--	elseif spellId == 1227378 and args:IsPlayer() then
--		specWartnCrystallized:Show()
--		specWartnCrystallized:Play("targetyou")
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

--[[
function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 459273 then

	end
end
--]]

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 459785 and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 433475 then

	end
end
--]]
