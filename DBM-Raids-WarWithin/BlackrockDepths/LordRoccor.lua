if DBM:GetTOC() < 110005 then return end
local mod	= DBM:NewMod(2663, "DBM-Raids-WarWithin", 2, 1301)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "lfr,normal,heroic"

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(226315)
mod:SetEncounterID(3042)
--mod:SetUsedIcons(8, 7, 6)
--mod:SetHotfixNoticeRev(20220322000000)
--mod:SetMinSyncRevision(20211203000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 462351 463674 462319 462320 462317",
--	"SPELL_SUMMON",
	"SPELL_AURA_APPLIED 462348",
	"SPELL_AURA_APPLIED_DOSE 462348",
	"SPELL_AURA_REMOVED 462348",
	"SPELL_PERIODIC_DAMAGE 462352",
	"SPELL_PERIODIC_MISSED 462352"
--	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[

--]]
--auto mark Living Magma using https://www.wowhead.com/ptr-2/spell=462357/eruption SPELL_SUMMON if it's not a lot
--auto mark igneous based on add power using https://www.wowhead.com/ptr-2/spell=462330/igneous-crystallization or https://www.wowhead.com/ptr-2/spell=462329/igneous-crystallization or https://www.wowhead.com/ptr-2/spell=462328/igneous-crystallization or https://www.wowhead.com/ptr-2/spell=462326/igneous-crystallization
--TODO, find out if big aoe is timer based or fuckup based
--TODO, determine what's actually a high stack count of LivingMagma
local warnRoilingMagma						= mod:NewCountAnnounce(462351, 3)
local warnCrystallize						= mod:NewCountAnnounce(463674, 2)

local specWarnEruption						= mod:NewSpecialWarningSwitchCount(462319, nil, nil, nil, 1, 2)
local specWarnVolcanicUpheaval				= mod:NewSpecialWarningCount(462317, nil, nil, nil, 2, 2)
--local specWarnLivingMagma					= mod:NewSpecialWarningStack(462348, nil, 12, nil, nil, 1, 6)
local specWarnGTFO							= mod:NewSpecialWarningGTFO(462352, nil, nil, nil, 1, 8)

local timerRoilingMagmaCD					= mod:NewAITimer(33, 462351, nil, nil, nil, 3)
local timerCrystallizeCD					= mod:NewAITimer(33, 463674, nil, nil, nil, 1)
local timerEruptionCD						= mod:NewAITimer(33, 462319, nil, nil, nil, 1)
local timerIgneousCrystallization			= mod:NewCastTimer(12, 462320, nil, nil, nil, 5)
local timerVolcanicUpheavalCD				= mod:NewAITimer(33, 462317, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON .. DBM_COMMON_L.DEADLY_ICON)

--mod:AddNamePlateOption("NPOnHoney", 443983)
--mod:AddSetIconOption("SetIconOnBees", 438025, true, 5, {8, 7, 6})
mod:AddInfoFrameOption(462348, true)

mod.vb.RoilingMagmaCount = 0
mod.vb.CrystallizeCount = 0
mod.vb.EruptionCount = 0
mod.vb.VolcanicUpheavalCount = 0
local MagmaStacks = {}

function mod:OnCombatStart(delay)
	self.vb.RoilingMagmaCount = 0
	self.vb.CrystallizeCount = 0
	self.vb.EruptionCount = 0
	self.vb.VolcanicUpheavalCount = 0
	table.wipe(MagmaStacks)
	timerRoilingMagmaCD:Start(1-delay)
	timerCrystallizeCD:Start(1-delay)
	timerEruptionCD:Start(1-delay)
	timerVolcanicUpheavalCD:Start(1-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellName(462348))
		DBM.InfoFrame:Show(10, "table", MagmaStacks, 1)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 462351 then
		self.vb.RoilingMagmaCount = self.vb.RoilingMagmaCount + 1
		warnRoilingMagma:Show(self.vb.RoilingMagmaCount)
		timerRoilingMagmaCD:Start()
	elseif spellId == 463674 then
		self.vb.CrystallizeCount = self.vb.CrystallizeCount + 1
		warnCrystallize:Show(self.vb.CrystallizeCount)
		timerCrystallizeCD:Start()
	elseif spellId == 462319 then
		self.vb.EruptionCount = self.vb.EruptionCount + 1
		specWarnEruption:Show(self.vb.EruptionCount)
		specWarnEruption:Play("mobsoon")--Changeme to new audio soon™
		timerEruptionCD:Start()
	elseif spellId == 462320 then
		timerIgneousCrystallization:Start()
	elseif spellId == 462317 then
		self.vb.VolcanicUpheavalCount = self.vb.VolcanicUpheavalCount + 1
		specWarnVolcanicUpheaval:Show(self.vb.VolcanicUpheavalCount)
		specWarnVolcanicUpheaval:Play("aesoon")
		timerVolcanicUpheavalCD:Start()
	end
end

--[[
function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 438665 then

	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 462348 then
		local amount = args.amount or 1
		MagmaStacks[args.destName] = amount
		--if args:IsPlayer() and (amount == 12 or amount >= 15 and amount % 2 == 1) then--12, 15, 17, 19
		--	specWarnLivingMagma:Show(amount)
		--	specWarnLivingMagma:Play("stackhigh")
		--end
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(MagmaStacks)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED


function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 462348 then
		MagmaStacks[args.destName] = nil
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(MagmaStacks)
		end
	end
end


function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 462352 and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 229444 then--Son of Roccor

	end
end
--]]

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 74859 then

	end
end
--]]
