local mod	= DBM:NewMod(2524, "DBM-Aberrus", nil, 1208)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(199659)--Warlord Kagni
mod:SetEncounterID(2682)
--mod:SetUsedIcons(1, 2, 3)
mod:SetHotfixNoticeRev(20230403000000)
--mod:SetMinSyncRevision(20221215000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 404585 401241 401258 401867 408959 397383 409271 401108 407009 410351",
	"SPELL_CAST_SUCCESS 401401 410351",
	"SPELL_AURA_APPLIED 401241 407024 401867 402066 401381 409242 409275 409359",
	"SPELL_AURA_APPLIED_DOSE 401241 409242",
	"SPELL_AURA_REMOVED 401867 402066 409242",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[

--]]
--TODO, refine slam and door aoe stack warnings for Barrier Backfire?
--TODO, is cudgel random direction or only on tank. It has tank only flag but that could be mis flag, cause molten swing is actual tank mechanic
--TODO, verify event for Sunder
--TODO, stop/restart boss timers on phase change?
--TODO, actually detect phase changes
--TODO, initial add timers (likely with IEEU)
--TODO, nameplate aura for https://www.wowhead.com/ptr/spell=410740/from-the-ashes ? need to make sure it actually has nameplate first
--TODO, can lava flow be dodged? if so probably should be emphasized, if not, cast alert should be removed
--TODO, blazing spear targets?
--TOOD, adds timers for wallclimbers and the like
--TODO, stage 3 https://www.wowhead.com/ptr/spell=406585/ignaras-fury fury timer?
--General
local warnBatteringSlam								= mod:NewCastAnnounce(404585, 3)

--local specWarnGTFO								= mod:NewSpecialWarningGTFO(370648, nil, nil, nil, 1, 8)

--local berserkTimer							= mod:NewBerserkTimer(600)
--Stage One: Warlord's Will
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26601))
----Warlord Kagni
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26209))
local warnMoltenSwing								= mod:NewStackAnnounce(401241, 2, nil, "Tank|Healer")

local specWarnMoltenSwing							= mod:NewSpecialWarningTaunt(401241, nil, nil, nil, 1, 2)
local specWarnHeavyCudgel							= mod:NewSpecialWarningCount(401258, nil, nil, nil, 2, 2)
--local yellFlamerift								= mod:NewShortYell(390715)
--local yellFlameriftFades							= mod:NewShortFadesYell(390715)
--local specWarnPyroBlast							= mod:NewSpecialWarningInterrupt(396040, "HasInterrupt", nil, nil, 1, 2)

local timerMoltenSwingCD							= mod:NewAITimer(28.9, 401241, nil, nil, nil, 3, nil, DBM_COMMON_L.TANK_ICON)
local timerHeavyCudgelCD							= mod:NewAITimer(29.9, 401258, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)

--Stage Two: The Zaqali Forces
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26604))
----Warlord Kagni
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26209))
local warnZaqaliAide								= mod:NewCastAnnounce(404382, 3)

local specWarnDevastatingLeap						= mod:NewSpecialWarningDodgeCount(408959, nil, nil, nil, 2, 2)

local timerZaqaliAideCD								= mod:NewAITimer(29.9, 404382, nil, nil, nil, 1)
local timerDevastatingLeapCD						= mod:NewAITimer(29.9, 408959, nil, nil, nil, 3)

--mod:AddNamePlateOption("NPAuraOnLeap", 408959)
----Ignara
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26737))
local specWarnFirestorm								= mod:NewSpecialWarningDodgeCount(407024, nil, nil, nil, 2, 2)
local warnPhoenixRush								= mod:NewCountAnnounce(401108, 3)

local specWarnAwakenedFocus							= mod:NewSpecialWarningRun(401381, nil, nil, nil, 4, 2, 4)
local specWarnVigorousGale							= mod:NewSpecialWarningCount(407009, nil, nil, nil, 2, 13, 4)

local timerFirestormCD								= mod:NewAITimer(29.9, 407024, nil, nil, nil, 3)
local timerFirestorm								= mod:NewBuffActiveTimer(29.9, 407024, nil, nil, nil, 5)
local timerPhoenixRushCD							= mod:NewAITimer(29.9, 401108, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerVigorousGaleCD							= mod:NewAITimer(29.9, 407009, nil, nil, nil, 2, nil, DBM_COMMON_L.MYTHIC_ICON)
----Magma Mystic
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26217))
local warnMoltenhavoc								= mod:NewCastAnnounce(397383, 4)
local warnLavaFlowCast								= mod:NewCastAnnounce(409271, 2)
local warnLavaFlow									= mod:NewTargetNoFilterAnnounce(409271, 2, nil, "RemoveMagic")

local timerMoltenhavocCD							= mod:NewAITimer(29.9, 397383, nil, nil, nil, 2)
local timerLavaFlowCD								= mod:NewAITimer(29.9, 409271, nil, nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)
local timerMoltenBurn								= mod:NewBuffActiveTimer(12, 409242, nil, false, nil, 5)
----Obsidian Guard
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26210))
local warnVolcanicShield							= mod:NewTargetNoFilterAnnounce(401867, 4)

local specWarnVolcanicShield						= mod:NewSpecialWarningYou(401867, nil, nil, nil, 2, 2)
local yellVolcanicShield							= mod:NewShortYell(401867)
local yellVolcanicShieldFades						= mod:NewShortFadesYell(401867)

local timerVolcanicShieldCD							= mod:NewAITimer(29.9, 401867, nil, nil, nil, 3)
----Flamebound Huntsman
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26213))
local warnBlazingSpear								= mod:NewSpellAnnounce(401401, 3)

local timerBlazingSpearCD							= mod:NewAITimer(29.9, 401401, nil, nil, nil, 3)
--Stage Three: Flaming Desperation
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26683))
local warnDesperateImmo								= mod:NewSpellAnnounce(409359, 3)

local specWarnDemolishingSlam						= mod:NewSpecialWarningCount(410535, nil, nil, nil, 2, 2)
local specWarnFlamingCudgel							= mod:NewSpecialWarningCount(410351, nil, nil, nil, 2, 2)

--local timerIgnarasFuryCD							= mod:NewAITimer(29.9, 406585, nil, nil, nil, 2)
local timerDemolishingSlamCD						= mod:NewAITimer(29.9, 410535, nil, nil, nil, 5)
local timerFlamingCudgelCD							= mod:NewAITimer(29.9, 410351, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)

--mod:AddInfoFrameOption(361651, true)
--mod:AddRangeFrameOption(5, 390715)
--mod:AddSetIconOption("SetIconOnMagneticCharge", 399713, true, 0, {4})
--mod:GroupSpells(390715, 396094)

mod.vb.cudgelCount = 0
mod.vb.leapCount = 0
mod.vb.firestormCount = 0
mod.vb.rushCount = 0
mod.vb.galeCount = 0

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.cudgelCount = 0
	self.vb.leapCount = 0
	self.vb.firestormCount = 0
	self.vb.rushCount = 0
	self.vb.galeCount = 0
	timerMoltenSwingCD:Start(1-delay)
	timerHeavyCudgelCD:Start(1-delay)
--	timerDevastatingLeapCD:Start(1-delay)
--	timerFirestormCD:Start(1-delay)
--	if self.Options.NPAuraOnLeap then
--		DBM:FireEvent("BossMod_EnableHostileNameplates")
--	end
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
--	if self.Options.NPAuraOnLeap then
--		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
--	end
end


function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 404585 then
		warnBatteringSlam:Show()
	elseif spellId == 401241 then
		timerMoltenSwingCD:Start()
	elseif spellId == 401258 then
		self.vb.cudgelCount = self.vb.cudgelCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnHeavyCudgel:Show(self.vb.cudgelCount)
			specWarnHeavyCudgel:Play("shockwave")
		end
		timerHeavyCudgelCD:Start()
	elseif spellId == 404382 then
		warnZaqaliAide:Show()
		timerZaqaliAideCD:Start()
	elseif spellId == 401867 then
		timerVolcanicShieldCD:Start(nil, args.sourceGUID)
	elseif spellId == 408959 then
		self.vb.leapCount = self.vb.leapCount + 1
		specWarnDevastatingLeap:Show(self.vb.leapCount)
		specWarnDevastatingLeap:Play("shockwave")
		timerDevastatingLeapCD:Start()
	elseif spellId == 397383 then
		warnMoltenhavoc:Show()
		timerMoltenhavocCD:Start(nil, args.sourceGUID)
	elseif spellId == 409271 then
		warnLavaFlowCast:Show()
		timerLavaFlowCD:Start(nil, args.sourceGUID)
	elseif spellId == 401108 then
		self.vb.rushCount = self.vb.rushCount + 1
		warnPhoenixRush:Show(self.vb.rushCount)
		timerPhoenixRushCD:Start()
	elseif spellId == 407009 then
		self.vb.galeCount = self.vb.galeCount + 1
		specWarnVigorousGale:Show(self.vb.galeCount)
		specWarnVigorousGale:Play("pushbackincoming")
		timerVigorousGaleCD:Start()
	elseif spellId == 410351 then
		self.vb.cudgelCount = self.vb.cudgelCount + 1
		specWarnFlamingCudgel:Show(self.vb.cudgelCount)
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnFlamingCudgel:Play("shockwave")
		else
			specWarnFlamingCudgel:Play("scatter")
		end
		timerFlamingCudgelCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 401401 then
		warnBlazingSpear:Show()
		timerBlazingSpearCD:Start(nil, args.sourceGUID)
	elseif spellId == 410351 then

	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 401241 and not args:IsPlayer() then
		local amount = args.amount or 1
		if amount >= 3 and not DBM:UnitDebuff("player", spellId) and not UnitIsDeadOrGhost("player") and not self:IsHealer() then
			specWarnMoltenSwing:Show(args.destName)
			specWarnMoltenSwing:Play("tauntboss")
		else
			warnMoltenSwing:Show(args.destName, amount)
		end
--	elseif spellId == 398938 or spellId == 398829 then
--		if self.Options.NPAuraOnLeap then
--			DBM.Nameplate:Show(true, args.destGUID, spellId)
--		end
	elseif spellId == 407024 then
		self.vb.firestormCount = self.vb.firestormCount + 1
		specWarnFirestorm:Show(self.vb.firestormCount)
		specWarnFirestorm:Play("watchstep")
		timerFirestormCD:Start()
		timerFirestorm:Start()
	elseif spellId == 401867 or spellId == 402066 then
		if args:IsPlayer() then
			specWarnVolcanicShield:Show()
			specWarnVolcanicShield:Play("targetyou")
			yellVolcanicShield:Yell()
			yellVolcanicShieldFades:Countdown(spellId)
		else
			warnVolcanicShield:Show(args.destName)
		end
	elseif spellId == 401381 and args:IsPlayer() and self:AntiSpam(3, 1) then
		specWarnAwakenedFocus:Show()
		specWarnAwakenedFocus:Play("justrun")
	elseif spellId == 409242 and args:IsPlayer() then
		timerMoltenBurn:Restart()
	elseif spellId == 409275 then
		warnLavaFlow:CombinedShow(0.3, args.destName)
	elseif spellId == 409359 then--Desperate Immolation
		self.vb.cudgelCount = 0
		self.vb.leapCount = 0--Reused with demo slam
		self:SetStage(3)
		warnDesperateImmo:Show()
		timerMoltenSwingCD:Stop()
		timerHeavyCudgelCD:Stop()
		timerFirestormCD:Stop()
		timerPhoenixRushCD:Stop()
		timerVigorousGaleCD:Stop()
		timerDemolishingSlamCD:Start(3)
		timerFlamingCudgelCD:Start(3)
		timerMoltenSwingCD:Start(3)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 401867 or spellId == 402066 then
		if args:IsPlayer() then
			yellVolcanicShieldFades:Cancel()
		end
	elseif spellId == 409242 and args:IsPlayer() then
		timerMoltenBurn:Stop()
--	elseif spellId == 398938 or spellId == 398829 then
--		if self.Options.NPAuraOnLeap then
--			DBM.Nameplate:Hide(true, args.destGUID, spellId)
--		end
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
	if cid == 200836 or cid == 202937 then--obsidian-guard
		timerVolcanicShieldCD:Stop(args.destGUID)
	elseif cid == 200840 then--flamebound-huntsman
		timerBlazingSpearCD:Stop(args.destGUID)
	elseif cid == 199703 then--magma-mystic
		timerMoltenhavocCD:Stop(args.destGUID)
		timerLavaFlowCD:Stop(args.destGUID)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 410540 then--Demolishg Slam
		self.vb.leapCount = self.vb.leapCount + 1
		specWarnDemolishingSlam:Show(self.vb.leapCount)
		specWarnDemolishingSlam:Play("helpsoak")
		timerDemolishingSlamCD:Start()
	end
end
