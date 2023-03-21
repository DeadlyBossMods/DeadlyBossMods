local mod	= DBM:NewMod(2530, "DBM-Aberrus", nil, 1208)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(200912, 200913, 200918)
mod:SetEncounterID(2693)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6)
mod:SetBossHPInfoToHighest()
mod:SetHotfixNoticeRev(20230320000000)
--mod:SetMinSyncRevision(20221215000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 406358 404472 407733 404713 405042 405492 405375 406227 407552 405391",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 406317 406313 407302 407327 407617 405392",
	"SPELL_AURA_APPLIED_DOSE 406313 407302",
	"SPELL_AURA_REMOVED 406317",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[

--]]
--TODO, which slam Id, or both?
--TODO, correct Deep Breath trigger, i suspect one activates it and some of casts are each pass
--TODO, what do you actually do with TEmporal Anomaly, soak it?
--Neldris
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26001))
local warnMutilation								= mod:NewTargetAnnounce(406317, 2)
local warnInfusedStrikes							= mod:NewStackAnnounce(406313, 2, nil, "Tank|Healer")

local specWarnMutilation							= mod:NewSpecialWarningMoveAway(406317, nil, nil, nil, 1, 2)
local yellMutilation								= mod:NewShortPosYell(406317)
local yellMutilationFades							= mod:NewIconFadesYell(406317)
local specWarnMassiveSlam							= mod:NewSpecialWarningDodgeCount(404472, nil, nil, nil, 2, 2)
local specWarnForcefulRoar							= mod:NewSpecialWarningCount(404713, nil, nil, nil, 2, 2)
--local specWarnPyroBlast							= mod:NewSpecialWarningInterrupt(396040, "HasInterrupt", nil, nil, 1, 2)
--local specWarnGTFO								= mod:NewSpecialWarningGTFO(370648, nil, nil, nil, 1, 8)

local timerMutilationCD								= mod:NewAITimer(29.9, 406358, nil, nil, nil, 3)
local timerMassiveSlamCD							= mod:NewAITimer(29.9, 404472, nil, nil, nil, 3)
local timerForcefulRoarCD							= mod:NewAITimer(29.9, 404713, nil, nil, nil, 2)
local timerInfusedStrikes							= mod:NewFadesTimer(20, 407302, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON..DBM_COMMON_L.HEALER_ICON)--Track the aura that needs to fall off before tanks "clear" again
--local timerFlameriftCD							= mod:NewAITimer(28.9, 390715, nil, nil, nil, 3, nil, DBM_COMMON_L.DAMAGE_ICON)
--local berserkTimer								= mod:NewBerserkTimer(600)

--mod:AddInfoFrameOption(361651, true)
--mod:AddRangeFrameOption(5, 390715)
mod:AddSetIconOption("SetIconOnMutilation", 406317, false, 0, {4, 5, 6})
--mod:AddNamePlateOption("NPAuraOnAscension", 385541)
mod:GroupSpells(406358, 406317)--Mutilation cast with debuff Id
--Thadrion
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26322))
local warnUnstableEssence							= mod:NewCastAnnounce(405042, 3)
local warnUnstableEssenceTargets					= mod:NewTargetAnnounce(405042, 2)

local specWarnUnstableEssence						= mod:NewSpecialWarningYou(405042, nil, nil, nil, 1, 2)
local specWarnVolatileSpew							= mod:NewSpecialWarningDodgeCount(405492, nil, nil, nil, 2, 2)
local specWarnUncontrollableFrenzy					= mod:NewSpecialWarningCount(405375, nil, nil, nil, 2, 2)

local timerUnstableEssenceCD						= mod:NewAITimer(29.9, 405042, nil, nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)
local timerVolatileSpewCD							= mod:NewAITimer(29.9, 405492, nil, nil, nil, 3)
local timerUncontrollableFrenzyCD					= mod:NewAITimer(29.9, 405375, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)

mod:AddSetIconOption("SetIconOnEssence", 405042, false, 0, {1, 2, 3})
--Rionthus
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26329))
local warnTemporalAnomaly							= mod:NewCastAnnounce(407552, 3)
local warnTemporalAnomalyAbsorbed					= mod:NewTargetNoFilterAnnounce(407552, 2)
local warnDisintegrate								= mod:NewTargetAnnounce(405391, 2)

local specWarnDeepBreath							= mod:NewSpecialWarningDodgeCount(406227, nil, nil, nil, 2, 2)
local specWarnDisintegrate							= mod:NewSpecialWarningMoveAway(405392, nil, nil, nil, 1, 2)
local yellDisintegrate								= mod:NewShortYell(405392)

local timerDeepBreathCD								= mod:NewAITimer(29.9, 406227, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerTemporalAnomalyCD						= mod:NewAITimer(29.9, 407552, nil, nil, nil, 5)
local timerDisintegrateCD							= mod:NewAITimer(29.9, 405391, nil, nil, nil, 3)

mod.vb.mutIcon = 4
mod.vb.massiveSlamCount = 0
mod.vb.forcefulRoarCount = 0
mod.vb.volatileSpewCount = 0
mod.vb.frenzyCount = 0
mod.vb.breathCount = 0
mod.vb.Disintegrate = 0
local essenceMarks = {}

function mod:OnCombatStart(delay)
	--Neldris
	self.vb.massiveSlamCount = 0
	self.vb.forcefulRoarCount = 0
	timerMutilationCD:Start(1-delay)
	timerMassiveSlamCD:Start(1-delay)
	timerForcefulRoarCD:Start(1-delay)
	--Thadrion
	table.wipe(essenceMarks)
	self.vb.volatileSpewCount = 0
	self.vb.frenzyCount = 0
	timerUnstableEssenceCD:Start(1-delay)
	timerVolatileSpewCD:Start(1-delay)
	timerUncontrollableFrenzyCD:Start(1-delay)
	--Rionthus
	self.vb.breathCount = 0
	self.vb.Disintegrate = 0
	timerDeepBreathCD:Start(1-delay)
	timerTemporalAnomalyCD:Start(1-delay)
	timerDisintegrateCD:Start(1-delay)
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
		self.vb.mutIcon = 4
		timerMutilationCD:Start()
	elseif spellId == 407733 or spellId == 404472 then
		self.vb.massiveSlamCount = self.vb.massiveSlamCount + 1
		specWarnMassiveSlam:Show(self.vb.massiveSlamCount)
		specWarnMassiveSlam:Play("shockwave")
		timerMassiveSlamCD:Start()
	elseif spellId == 404713 then
		self.vb.forcefulRoarCount = self.vb.forcefulRoarCount + 1
		specWarnForcefulRoar:Show(self.vb.forcefulRoarCount)
		specWarnForcefulRoar:Play("carefly")
		timerForcefulRoarCD:Start()
	elseif spellId == 405042 then
		warnUnstableEssence:Show()
		timerUnstableEssenceCD:Start()
	elseif spellId == 405492 then
		self.vb.volatileSpewCount = self.vb.volatileSpewCount + 1
		specWarnVolatileSpew:Show(self.vb.volatileSpewCount)
		timerVolatileSpewCD:Start()
	elseif spellId == 405375 then
		self.vb.frenzyCount = self.vb.frenzyCount + 1
		specWarnUncontrollableFrenzy:Show(self.vb.frenzyCount)
		specWarnUncontrollableFrenzy:Play("aesoon")
		timerUncontrollableFrenzyCD:Start()
	elseif spellId == 406227 then
		self.vb.breathCount = self.vb.breathCount + 1
		specWarnDeepBreath:Show(self.vb.breathCount)
		specWarnDeepBreath:Play("breathsoon")
		timerDeepBreathCD:Start()
	elseif spellId == 407552 then
		warnTemporalAnomaly:Show()
		timerTemporalAnomalyCD:Start()
	elseif spellId == 405391 then
		self.vb.Disintegrate = self.vb.Disintegrate + 1
		timerDisintegrateCD:Start()
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
	if spellId == 406317 then
		local icon = self.vb.mutIcon
		if self.Options.SetIconOnMutilation then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnMutilation:Show()
			specWarnMutilation:Play("runout")
			yellMutilation:Yell(icon, icon)
			yellMutilationFades:Countdown(spellId, nil, icon-3)
		end
		warnMutilation:CombinedShow(0.5, args.destName)
		self.vb.mutIcon = self.vb.mutIcon + 1
	elseif spellId == 406313 and not args:IsPlayer() then
		local amount = args.amount or 1
		if amount % 3 == 0 then--Guessed, Filler
			warnInfusedStrikes:Show(args.destName, amount)
		end
	elseif spellId == 407302 and self:AntiSpam() then
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
	if spellId == 406317 then
		if args:IsPlayer() then
			yellMutilationFades:Cancel()
		end
		if self.Options.SetIconOnMutilation then
			self:Seticon(args.destName, 0)
		end
	elseif spellId == 407327 then
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
		timerMutilationCD:Stop()
		timerMassiveSlamCD:Stop()
		timerForcefulRoarCD:Stop()
	elseif cid == 200918 then--Rionthus
		timerDeepBreathCD:Stop()
		timerTemporalAnomalyCD:Stop()
		timerDisintegrateCD:Stop()
	elseif cid == 200913 then--Thadrion
		timerUnstableEssenceCD:Stop()
		timerVolatileSpewCD:Stop()
		timerUncontrollableFrenzyCD:Stop()
	end
end


--function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
--	if spellId == 396734 then
--
--	end
--end
