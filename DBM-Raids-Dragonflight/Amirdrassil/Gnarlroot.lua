local wowToc, testBuild = DBM:GetTOC()
if (wowToc < 100200) and not testBuild then return end
local mod	= DBM:NewMod(2564, "DBM-Raids-Dragonflight", 1, 1207)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(209333)--Likely ID, it's one with corrupted model, but needs confirmation
mod:SetEncounterID(2820)
--mod:SetUsedIcons(1, 2, 3)
--mod:SetHotfixNoticeRev(20210126000000)
--mod:SetMinSyncRevision(20210126000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 421898 421971 424352 422026 422039 421013",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 422466 421972 426106 421038 421840",
	"SPELL_AURA_APPLIED_DOSE 422466 426106 421038",
	"SPELL_AURA_REMOVED 421972 421840",
--	"SPELL_AURA_REMOVED_DOSE",
	"SPELL_PERIODIC_DAMAGE 422023 424970",
	"SPELL_PERIODIC_MISSED 422023 424970"
--	"UNIT_DIED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[

--]]
--TODO, maybe nameplate aura timers for https://www.wowhead.com/ptr-2/spell=422053/shadow-spines if it's not spam cast?
--TODO, add Tainted Treant mechanics for mythic
--Stage One: Garden of Despair
mod:AddTimerLine(DBM:EJ_GetSectionInfo(27467))
local warnFlamingPestilence							= mod:NewCountAnnounce(421898, 3)
local warnShadowSpines								= mod:NewCountAnnounce(422053, 2, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(422053))
local warnControlledBurn							= mod:NewTargetCountAnnounce(421971, 3, nil, nil, nil, nil, nil, nil, true)
local warnDreadfireBarrage							= mod:NewStackAnnounce(424352, 2, nil, "Tank|Healer")

local specWarnControlledBurn						= mod:NewSpecialWarningYou(421971, nil, nil, nil, 1, 2)
local yellControlledBurn							= mod:NewShortPosYell(421971)
local yellControlledBurnFades						= mod:NewIconFadesYell(421971)
--local specWarnPyroBlast							= mod:NewSpecialWarningInterrupt(396040, "HasInterrupt", nil, nil, 1, 2)
local specWarnDreadfireBarrage						= mod:NewSpecialWarningTaunt(424352, nil, nil, nil, 1, 2)
local specWarnTorturedScream						= mod:NewSpecialWarningCount(422026, nil, nil, nil, 2, 2)
local specWarnShadowflameCleave						= mod:NewSpecialWarningDodgeCount(422039, nil, nil, nil, 2, 2)
local specWarnGTFO									= mod:NewSpecialWarningGTFO(422023, nil, nil, nil, 1, 8)

local timerFlamingPestilenceCD						= mod:NewAITimer(49, 421898, nil, nil, nil, 1)
local timerControlledBurnCD							= mod:NewAITimer(49, 421971, nil, nil, nil, 3)
local timerDreadfireBarrageCD						= mod:NewAITimer(11.8, 424352, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerTorturedScreamCD							= mod:NewAITimer(11.8, 422026, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerShadowflameCleaveCD						= mod:NewAITimer(49, 422039, nil, nil, nil, 3)
--local berserkTimer								= mod:NewBerserkTimer(600)

mod:AddSetIconOption("SetIconOnControlledBurn", 421971, true, false, {1, 2, 3, 4})
--Intermission: Frenzied Growth
mod:AddTimerLine(DBM:EJ_GetSectionInfo(27475))
local warnPotentFertilization							= mod:NewCountAnnounce(421013, 3)
local warnEmberCharred									= mod:NewCountAnnounce(421038, 2, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(421038))
local warnUprootedAgony									= mod:NewSpellAnnounce(421840, 1)
local warnUprootedAgonyOver								= mod:NewEndAnnounce(421840, 2)

--local specWarnEmberCharred							= mod:NewSpecialWarningYou(421038, nil, nil, nil, 1, 2)

local timerPotentFertilizationCD						= mod:NewAITimer(49, 421013, nil, nil, nil, 6)

--p1
mod.vb.pestilanceCount = 0
mod.vb.burnCount = 0
mod.vb.burnIcon = 1
mod.vb.barrageCount = 0
mod.vb.screamCount = 0
mod.vb.cleaveCount = 0
--p2
mod.vb.fertCount = 0

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.pestilanceCount = 0
	self.vb.burnCount = 0
	self.vb.burnIcon = 1
	self.vb.barrageCount = 0
	self.vb.screamCount = 0
	self.vb.cleaveCount = 0
	self.vb.fertCount = 0
	timerFlamingPestilenceCD:Start(1-delay)
	timerControlledBurnCD:Start(1-delay)
	timerDreadfireBarrageCD:Start(1-delay)
	timerTorturedScreamCD:Start(1-delay)
	timerShadowflameCleaveCD:Start(1-delay)
	timerPotentFertilizationCD:Start(1-delay)
end

--function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 421898 then
		self.vb.pestilanceCount = self.vb.pestilanceCount + 1
		warnFlamingPestilence:Show(self.vb.pestilanceCount)
		timerFlamingPestilenceCD:Start()
	elseif spellId == 421971 then
		self.vb.burnCount = 0
		self.vb.burnIcon = 1
	elseif spellId == 424352 then
		self.vb.barrageCount = self.vb.barrageCount + 1
		timerDreadfireBarrageCD:Start()
	elseif spellId == 422026 then
		self.vb.screamCount = self.vb.screamCount + 1
		specWarnTorturedScream:Show(self.vb.screamCount)
		specWarnTorturedScream:Play("aesoon")
		timerTorturedScreamCD:Start()
	elseif spellId == 422039 then
		self.vb.cleaveCount = self.vb.cleaveCount + 1
		specWarnShadowflameCleave:Show(self.vb.cleaveCount)
		specWarnShadowflameCleave:Play("shockwave")
		timerShadowflameCleaveCD:Start()
	elseif spellId == 421013 then
		self:SetStage(2)
		self.vb.fertCount = self.vb.fertCount + 1
		timerFlamingPestilenceCD:Stop()
		timerControlledBurnCD:Stop()
		timerDreadfireBarrageCD:Stop()
		timerTorturedScreamCD:Stop()
		timerShadowflameCleaveCD:Stop()
--	elseif spellId == stuff then
--		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
--
--		end
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 334945 then

	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 422466 then
		if args:IsPlayer() and self:AntiSpam(3, 1) then
			warnShadowSpines:Show(args.amount or 1)
		end
	elseif spellId == 421972 then
		local icon = self.vb.burnIcon
		if self.Options.SetIconOnControlledBurn then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnControlledBurn:Show()
			specWarnControlledBurn:Play("targetyou")
			yellControlledBurn:Yell(icon, icon)
			yellControlledBurnFades:Countdown(spellId, nil, icon)
		end
		warnControlledBurn:CombinedShow(0.5, self.vb.burnCount, args.destName)
		self.vb.burnIcon = self.vb.burnIcon + 1
	elseif spellId == 426106 then
		local amount = args.amount or 1
		if args:IsPlayer() then--TODO, more with this if it needs to go to 2 stacks, if it's swapped at 1 this will likely not be needed
			warnDreadfireBarrage:Show(args.destName, amount)
		else
			local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
			local remaining
			if expireTime then
				remaining = expireTime-GetTime()
			end
			--TODO, CD needs to be known to optimize this
			if (not remaining or remaining and remaining < 6.1) and not UnitIsDeadOrGhost("player") and not self:IsHealer() then
				specWarnDreadfireBarrage:Show(args.destName)
				specWarnDreadfireBarrage:Play("tauntboss")
			else
				warnDreadfireBarrage:Show(args.destName, amount)
			end
		end
	elseif spellId == 421038 then
		if args:IsPlayer() then
			warnEmberCharred:Show(args.amount or 1)
		end
	elseif spellId == 421840 then
		warnUprootedAgony:Show()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 421972 then
		if self.Options.SetIconOnControlledBurn then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 421840 then
		self:SetStage(1)
		warnUprootedAgonyOver:Show()
		self.vb.pestilanceCount = 0
		self.vb.burnCount = 0
		self.vb.barrageCount = 0
		self.vb.screamCount = 0
		self.vb.cleaveCount = 0
		timerFlamingPestilenceCD:Start(2)
		timerControlledBurnCD:Start(2)
		timerDreadfireBarrageCD:Start(2)
		timerTorturedScreamCD:Start(2)
		timerShadowflameCleaveCD:Start(2)
		timerPotentFertilizationCD:Start(2)
	end
end
--mod.SPELL_AURA_REMOVED_DOSE = mod.SPELL_AURA_REMOVED

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 422023 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	elseif spellId == 424970 and not DBM:UnitDebuff("player", 421038) and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
--https://www.wowhead.com/ptr-2/npc=210231/tainted-lasher
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

