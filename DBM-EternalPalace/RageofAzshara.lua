local mod	= DBM:NewMod(2353, "DBM-EternalPalace", nil, 1179)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(152364)
mod:SetEncounterID(2305)
mod:SetZone()
--mod:SetHotfixNoticeRev(16950)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 296546 296459 296894 302465 295916 296701",
	"SPELL_CAST_SUCCESS 296430 296737",
	"SPELL_AURA_APPLIED 296566 296737",
	"SPELL_AURA_REMOVED 296737",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED"
)

--TODO, verify arcanado burst ID/event
--TODO, verify target scanning squall trap, or use an alternate method if possible
--TODO, verify correct unshackled power spellid
--TODO, right voie for gale buffet
local warnArcanadoBurst					= mod:NewSpellAnnounce(296430, 2)
local warnSquallTrap					= mod:NewTargetNoFilterAnnounce(296459, 4)
local warnArcaneBomb					= mod:NewTargetNoFilterAnnounce(296737, 4)

--Rising Fury
local specWarnTideFistCast				= mod:NewSpecialWarningDefensive(296566, nil, nil, nil, 1, 2)
local specWarnTideFist					= mod:NewSpecialWarningTaunt(296566, nil, nil, nil, 1, 2)
local specWarnSquallTrap				= mod:NewSpecialWarningMoveAway(296459, nil, nil, nil, 1, 2)
local yellSquallTrap					= mod:NewYell(296459)
local specWarnCrushingNear				= mod:NewSpecialWarningClose(296459, nil, nil, nil, 1, 2)
local specWarnArcaneBomb				= mod:NewSpecialWarningMoveAway(296737, nil, nil, nil, 1, 2)
local yellArcaneBomb					= mod:NewYell(296737)
local yellArcaneBombFades				= mod:NewShortFadesYell(296737)
local specWarnUnshackledPower			= mod:NewSpecialWarningCount(296894, nil, nil, nil, 2, 2)
--Raging Storm
local specWarnAncientTempest			= mod:NewSpecialWarningSpell(295916, nil, nil, nil, 2, 2)
local specWarnGaleBuffet				= mod:NewSpecialWarningDodge(296701, nil, nil, nil, 2, 2)
--local specWarnGTFO						= mod:NewSpecialWarningGTFO(270290, nil, nil, nil, 1, 8)
--local specWarnEntropicBlast				= mod:NewSpecialWarningInterrupt(270620, "HasInterrupt", nil, nil, 1, 2)

--mod:AddTimerLine(BOSS)
--local timerPlasmaDischargeCD			= mod:NewAITimer(30.4, 271225, nil, nil, nil, 3)--30.4-42
local timerTideFistCD					= mod:NewAITimer(58.2, 296546, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)
local timerArcanadoBurstCD				= mod:NewAITimer(58.2, 296430, nil, nil, nil, 3)
local timerArcaneBombCD					= mod:NewAITimer(58.2, 296737, nil, nil, nil, 3)
local timerUnshacklingPowerCD			= mod:NewAITimer(58.2, 296894, nil, nil, nil, 2)
--Raging Storm
local timerGaleBuffetCD					= mod:NewAITimer(58.2, 296701, nil, nil, nil, 3)

--local berserkTimer					= mod:NewBerserkTimer(600)

--local countdownCudgelofGore				= mod:NewCountdown(58, 271296)
--local countdownEnlargedHeart			= mod:NewCountdown("Alt60", 275205, true, 2)

--mod:AddRangeFrameOption(6, 264382)
--mod:AddInfoFrameOption(275270, true)
--mod:AddSetIconOption("SetIconOnEyeBeam", 264382, true)

--mod.vb.phase = 1
mod.vb.unshackledCount = 0

function mod:CrushingTarget(targetname, uId)
	if not targetname then return end
	if self:AntiSpam(4, targetname) then
		if targetname == UnitName("player") then
			specWarnSquallTrap:Show()
			specWarnSquallTrap:Play("runout")
			yellSquallTrap:Yell()
		elseif self:CheckNearby(12, targetname) then
			specWarnCrushingNear:Show(targetname)
			specWarnCrushingNear:Play("runaway")
		else
			warnSquallTrap:Show(targetname)
		end
	end
end

function mod:OnCombatStart(delay)
	self.vb.unshackledCount = 0
	timerTideFistCD:Start(1-delay)
	timerArcanadoBurstCD:Start(1-delay)
	timerArcaneBombCD:Start(1-delay)
	timerUnshacklingPowerCD:Start(1-delay)
end

function mod:OnCombatEnd()
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 296546 then
		if UnitDetailedThreatSituation("player", "boss1") then
			specWarnTideFistCast:Show()
			specWarnTideFistCast:Play("defensive")
		end
		timerTideFistCD:Start()
	elseif spellId == 296459 then
		self:ScheduleMethod(0.2, "BossTargetScanner", args.sourceGUID, "CrushingTarget", 0.1, 16, true, nil, nil, nil, false)--Does this target tank? if not, change false to true
	elseif spellId == 296894 or spellId == 302465 then
		self.vb.unshackledCount = self.vb.unshackledCount + 1
		specWarnUnshackledPower:Show(self.vb.unshackledCount)
		specWarnUnshackledPower:Play("aesoon")
		timerUnshacklingPowerCD:Start()
	elseif spellId == 295916 then
		timerTideFistCD:Stop()
		timerArcanadoBurstCD:Stop()
		timerArcaneBombCD:Stop()
		timerUnshacklingPowerCD:Stop()
		specWarnAncientTempest:Show()
		specWarnAncientTempest:Play("phasechange")
		timerGaleBuffetCD:Start(2)
		timerArcaneBombCD:Start(2)
	elseif spellId == 296701 then
		specWarnGaleBuffet:Show()
		specWarnGaleBuffet:Play("watchstep")
		timerGaleBuffetCD:Start()
--	elseif spellId == 267180 then
--		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
		--	specWarnVoidbolt:Show(args.sourceName)
			--specWarnVoidbolt:Play("kickcast")
--		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 296430 and self:AntiSpam(3, 1) then--Remove antispam if only one event
		warnArcanadoBurst:Show()
		timerArcanadoBurstCD:Start()
	elseif spellId == 296737 then
		timerArcaneBombCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 296566 then
		if not args:IsPlayer() then
			specWarnTideFist:Show(args.destName)
			specWarnTideFist:Play("tauntboss")
		end
	elseif spellId == 296737 then
		if args:IsPlayer() then
			specWarnArcaneBomb:Show()
			specWarnArcaneBomb:Play("runout")
			yellArcaneBomb:Yell()
			yellArcaneBombFades:Countdown(10)
		else
			warnArcaneBomb:Show(args.destName)
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 296737 then
		if args:IsPlayer() then
			yellArcaneBombFades:Cancel()
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 270290 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 152512 then--Stormwraith
		timerGaleBuffetCD:Stop()
		timerArcaneBombCD:Stop()
		timerTideFistCD:Start(2)
		timerArcanadoBurstCD:Start(2)
		timerArcaneBombCD:Start(3)
		timerUnshacklingPowerCD:Start(2)
	--elseif cid == 152816 then--Stormling

	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 266913 then

	end
end
--]]
