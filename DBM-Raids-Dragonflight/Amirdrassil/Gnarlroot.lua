local wowToc, testBuild = DBM:GetTOC()
if (wowToc < 100200) and not testBuild then return end
local mod	= DBM:NewMod(2564, "DBM-Raids-Dragonflight", 1, 1207)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(209333)
mod:SetEncounterID(2820)
mod:SetUsedIcons(1, 2, 3, 4)
mod:SetHotfixNoticeRev(20230923000000)
mod:SetMinSyncRevision(20230923000000)
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
(ability.id = 421898 or ability.id = 421971 or ability.id = 424352 or ability.id = 422026 or ability.id = 422039 or ability.id = 421013) and type = "begincast"
 or ability.id = 421840
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

local timerFlamingPestilenceCD						= mod:NewCDCountTimer(34.7, 421898, nil, nil, nil, 1)
local timerControlledBurnCD							= mod:NewCDCountTimer(49, 421971, nil, nil, nil, 3)
local timerDreadfireBarrageCD						= mod:NewCDCountTimer(21.5, 424352, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerTorturedScreamCD							= mod:NewCDCountTimer(11.8, 422026, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerShadowflameCleaveCD						= mod:NewCDCountTimer(49, 422039, nil, nil, nil, 3)
--local berserkTimer								= mod:NewBerserkTimer(600)

mod:AddSetIconOption("SetIconOnControlledBurn", 421971, true, false, {1, 2, 3, 4})
--Intermission: Frenzied Growth
mod:AddTimerLine(DBM:EJ_GetSectionInfo(27475))
local warnPotentFertilization						= mod:NewCountAnnounce(421013, 3)
local warnEmberCharred								= mod:NewCountAnnounce(421038, 2, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(421038))
local warnUprootedAgony								= mod:NewSpellAnnounce(421840, 1)
local warnUprootedAgonyOver							= mod:NewEndAnnounce(421840, 2)

--local specWarnEmberCharred						= mod:NewSpecialWarningYou(421038, nil, nil, nil, 1, 2)

local timerUprootAgonyCD							= mod:NewBuffActiveTimer(20, 421840, nil, nil, nil, 5, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerPotentFertilizationCD					= mod:NewAITimer(49, 421013, nil, nil, nil, 6)

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
	if self:IsHard() then
		timerTorturedScreamCD:Start(3.6-delay, 1)
		timerDreadfireBarrageCD:Start(9.5-delay, 1)
		timerFlamingPestilenceCD:Start(17.2-delay, 1)
		timerShadowflameCleaveCD:Start(22-delay, 1)
		timerControlledBurnCD:Start(31.5-delay, 1)
		timerPotentFertilizationCD:Start(96.7-delay, 1)
	else
		timerTorturedScreamCD:Start(4.6-delay, 1)
		timerDreadfireBarrageCD:Start(12.4-delay, 1)
		timerFlamingPestilenceCD:Start(21.5-delay, 1)
		timerShadowflameCleaveCD:Start(27.6-delay, 1)
		timerControlledBurnCD:Start(40-delay, 1)
		timerPotentFertilizationCD:Start(98.9-delay, 1)
	end
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
		timerFlamingPestilenceCD:Start(self:IsHard() and 34.7 or 49.1, self.vb.pestilanceCount+1)
	elseif spellId == 421971 then
		self.vb.burnCount = 0
		self.vb.burnIcon = 1
		timerControlledBurnCD:Start(self:IsHard() and 32 or 43.0, self.vb.burnCount+1)
	elseif spellId == 424352 then
		self.vb.barrageCount = self.vb.barrageCount + 1
		timerDreadfireBarrageCD:Start(self:IsHard() and 21.5 or 29.1, self.vb.barrageCount+1)
	elseif spellId == 422026 then
		self.vb.screamCount = self.vb.screamCount + 1
		specWarnTorturedScream:Show(self.vb.screamCount)
		specWarnTorturedScream:Play("aesoon")
		timerTorturedScreamCD:Start(self:IsHard() and 18.9 or 23.1, self.vb.screamCount+1)
	elseif spellId == 422039 then
		self.vb.cleaveCount = self.vb.cleaveCount + 1
		specWarnShadowflameCleave:Show(self.vb.cleaveCount)
		specWarnShadowflameCleave:Play("shockwave")
		timerShadowflameCleaveCD:Start(self:IsHard() and 17.3 or 36.9, self.vb.cleaveCount+1)
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
		if args:IsPlayer() then--This basically can swap every 1-2 stacks based on it's cooldown.
			warnDreadfireBarrage:Show(args.destName, amount)
		else
			local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
			local remaining
			if expireTime then
				remaining = expireTime-GetTime()
			end
			if (not remaining or remaining and remaining < 22) and not UnitIsDeadOrGhost("player") and not self:IsHealer() then
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
		timerUprootAgonyCD:Start()
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
		timerUprootAgonyCD:Stop()
		if self:IsHard() then
			timerTorturedScreamCD:Start(4.6, 1)
			timerDreadfireBarrageCD:Start(9.5, 1)
			timerFlamingPestilenceCD:Start(21.5, 1)
			timerShadowflameCleaveCD:Start(27.6, 1)
			timerControlledBurnCD:Start(40, 1)
			timerPotentFertilizationCD:Start(98.9, self.vb.fertCount+1)
		else
			timerTorturedScreamCD:Start(6.1, 1)
			timerDreadfireBarrageCD:Start(13.8, 1)
			timerFlamingPestilenceCD:Start(23.1, 1)
			timerShadowflameCleaveCD:Start(29.2, 1)
			timerControlledBurnCD:Start(41.5, 1)
			timerPotentFertilizationCD:Start(98.5, self.vb.fertCount+1)
		end
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

