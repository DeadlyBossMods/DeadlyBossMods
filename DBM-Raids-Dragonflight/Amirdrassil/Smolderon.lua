local wowToc, testBuild = DBM:GetTOC()
if (wowToc < 100200) and not testBuild then return end
local mod	= DBM:NewMod(2563, "DBM-Raids-Dragonflight", 1, 1207)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(200927)--Iffy
mod:SetEncounterID(2824)
--mod:SetUsedIcons(1, 2, 3)
--mod:SetHotfixNoticeRev(20210126000000)
--mod:SetMinSyncRevision(20210126000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 421343 422691 426725 422172",
	"SPELL_CAST_SUCCESS 421455 422277",
	"SPELL_AURA_APPLIED 421656 422577 421455 422067",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 421656 422577 421455 422067",
--	"SPELL_AURA_REMOVED_DOSE",
	"SPELL_PERIODIC_DAMAGE 421532",
	"SPELL_PERIODIC_MISSED 421532"
--	"UNIT_DIED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[

--]]
--TODO, add https://www.wowhead.com/ptr-2/spell=426018/seeking-inferno later
--TODO, better tracking of personal dps buffs in P2?
--general
local warnPhase										= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)

local specWarnGTFO									= mod:NewSpecialWarningGTFO(421532, nil, nil, nil, 1, 8)

--local berserkTimer								= mod:NewBerserkTimer(600)
--Stage One: The Firelord's Fury
mod:AddTimerLine(DBM:EJ_GetSectionInfo(27637))
local warnCauterizingWound							= mod:NewYouAnnounce(421656, 3)
local warnCauterizingWoundOver						= mod:NewFadesAnnounce(421656, 1)
local warnSearingAftermath							= mod:NewTargetNoFilterAnnounce(422577, 2, nil, "Healer")
local warnOverheated								= mod:NewTargetCountAnnounce(421455, 3, nil, nil, nil, nil, nil, nil, true)

local specWarnBrandofDamnation						= mod:NewSpecialWarningCount(421343, nil, nil, nil, 2, 2)
local specWarnSearingAftermath						= mod:NewSpecialWarningMoveAway(422577, nil, nil, nil, 1, 2)
local yellSearingAftermath							= mod:NewShortYell(422577)
local yellSearingAftermathFades						= mod:NewShortFadesYell(422577)
local specWarnSearingAftermathOther					= mod:NewSpecialWarningTaunt(422577, nil, nil, nil, 1, 2)
local specWarnOverheated							= mod:NewSpecialWarningMoveAway(421455, nil, nil, nil, 1, 2)
local yellOverheated								= mod:NewShortYell(421455)
local yellOverheatedFades							= mod:NewShortFadesYell(421455)
local specWarnLavaGeysers							= mod:NewSpecialWarningCount(422691, nil, nil, nil, 2, 2)

local timerBrandofDamnationCD						= mod:NewAITimer(49, 421343, nil, nil, nil, 5)
local timerSearingAftermathCD						= mod:NewTargetTimer(6, 422577, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerOverheatedCD								= mod:NewAITimer(49, 421455, nil, nil, nil, 5)
local timerLavaGeysersCD							= mod:NewAITimer(49, 422691, nil, nil, nil, 3)
--Stage Two: World In Flames
mod:AddTimerLine(DBM:EJ_GetSectionInfo(27649))
local warnWorldinFlames								= mod:NewCountAnnounce(422172, 4)

local specWarnEncroachingDestruction				= mod:NewSpecialWarningSpell(426725, nil, nil, nil, 3, 2)

local timerEncroachingDestructionCD					= mod:NewAITimer(6, 426725, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local specWarnDevourEssence							= mod:NewSpecialWarningDodgeCount(422277, nil, nil, nil, 2, 2)
local specWarnWorldinFlames							= mod:NewSpecialWarningDodgeCount(422172, nil, nil, nil, 2, 2)

local timerDevourEssenceCD							= mod:NewAITimer(49, 422277, nil, nil, nil, 3)
local timerWorldinFlamesCD							= mod:NewAITimer(49, 422172, nil, nil, nil, 3)

--mod:AddRangeFrameOption("5/6/10")
--mod:AddInfoFrameOption(407919, true)
--mod:AddSetIconOption("SetIconOnSinSeeker", 335114, true, false, {1, 2, 3})

mod.vb.brandCount = 0
mod.vb.overheatedCount = 0
mod.vb.geyserCount = 0
mod.vb.encroached = false

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.brandCount = 0
	self.vb.overheatedCount = 0
	self.vb.geyserCount = 0
	self.vb.encroached = false
	timerBrandofDamnationCD:Start(1-delay)
	timerOverheatedCD:Start(1-delay)
	timerLavaGeysersCD:Start(1-delay)
end

--function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 421343 then
		self.vb.brandCount = self.vb.brandCount + 1
		specWarnBrandofDamnation:Show(self.vb.brandCount)
		specWarnBrandofDamnation:Play("specialsoon")
		timerBrandofDamnationCD:Start()
	elseif spellId == 422691 then
		self.vb.geyserCount = self.vb.geyserCount + 1
		specWarnLavaGeysers:Show()
		specWarnLavaGeysers:Play("watchstep")
		timerLavaGeysersCD:Start()
	elseif spellId == 426725 then
		self.vb.encroached = true
		specWarnEncroachingDestruction:Show()
		specWarnEncroachingDestruction:Play("stilldanger")
	elseif spellId == 422172 and not self.vb.encroached then
		self.vb.geyserCount = self.vb.geyserCount + 1
		if self:AntiSpam(10, 1) then--In case it's sets of 2 or 3 like ragnaros version
			specWarnWorldinFlames:Show(self.vb.geyserCount)
			specWarnWorldinFlames:Play("watchstep")
			timerWorldinFlamesCD:Start()
		else
			warnWorldinFlames:Show(self.vb.geyserCount)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 421455 then
		self.vb.overheatedCount = self.vb.overheatedCount + 1
		timerOverheatedCD:Start()
	elseif spellId == 422277 then
		self.vb.overheatedCount = self.vb.overheatedCount + 1
		specWarnDevourEssence:Show(self.vb.overheatedCount)
		specWarnDevourEssence:Play("watchstep")
		timerDevourEssenceCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 421656 and args:IsPlayer() then
		warnCauterizingWound:Show()
	elseif spellId == 422577 then
		if args:IsPlayer() then
			specWarnSearingAftermath:Show()
			specWarnSearingAftermath:Play("runout")
			yellSearingAftermath:Yell()
			yellSearingAftermathFades:Countdown(spellId)
		elseif self:IsTank() then
			specWarnSearingAftermathOther:Show(args.destName)
			specWarnSearingAftermathOther:Play("tauntboss")
		else
			warnSearingAftermath:Show(args.destName)
		end
	elseif spellId == 421455 then
		warnOverheated:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnOverheated:Show()
			specWarnOverheated:Play("targetyou")
			yellOverheated:Yell()
			yellOverheatedFades:Countdown(spellId)
		end
	elseif spellId == 422067 then
		self:SetStage(2)
		self.vb.overheatedCount = 0--Reused for Devour Essence
		self.vb.geyserCount = 0--Reused for World in Flame
		self.vb.encroached = false
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2))
		warnPhase:Play("phasechange")
		timerBrandofDamnationCD:Stop()
		timerOverheatedCD:Stop()
		timerLavaGeysersCD:Stop()
		timerEncroachingDestructionCD:Start(2)
		timerDevourEssenceCD:Start(2)
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 421656 and args:IsPlayer() then
		warnCauterizingWoundOver:Show()
	elseif spellId == 422577 then
		if args:IsPlayer() then
			yellSearingAftermathFades:Cancel()
		end
	elseif spellId == 421455 then
		if args:IsPlayer() then
			yellOverheatedFades:Cancel()
		end
	elseif spellId == 422067 then
		self:SetStage(1)
		self.vb.brandCount = 0
		self.vb.overheatedCount = 0
		self.vb.geyserCount = 0
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(1))
		warnPhase:Play("phasechange")
		timerEncroachingDestructionCD:Stop()
		timerDevourEssenceCD:Stop()
		timerBrandofDamnationCD:Start(2)
		timerOverheatedCD:Start(2)
		timerLavaGeysersCD:Start(2)
	end
end
--mod.SPELL_AURA_REMOVED_DOSE = mod.SPELL_AURA_REMOVED

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 421532 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 165067 then

	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 405814 then

	end
end
--]]
