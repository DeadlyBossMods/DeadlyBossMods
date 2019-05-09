local mod	= DBM:NewMod(2351, "DBM-EternalPalace", nil, 1179)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(152128)--Zoatroid 153941 Orgozoa 152128
mod:SetEncounterID(2303)
mod:SetZone()
--mod:SetHotfixNoticeRev(16950)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 298242 298413 298548 295818 295822 296691",
	"SPELL_CAST_SUCCESS 299095 298156 298548",
	"SPELL_AURA_APPLIED 299095 298156 298306 296914 295779",
	"SPELL_AURA_APPLIED_DOSE 298156",
	"SPELL_AURA_REMOVED 298306 296914",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"SPELL_INTERRUPT",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, correct ichor event
--TODO, more with incubation fluid?
--TODO, Pervasive Shock?
--TODO, review phase change methods
--TODO, skewer or not to skewer
--TODO, verify aqua lance. if works, nameplate aura with line between casting mob and player
--TODO, raging-rapids?
--TODO, shocking lightning warnings/timer defaults?
--TODO, do more with powerful stomp?
local warnDesensitizingSting				= mod:NewStackAnnounce(298156, 2, nil, "Tank")
local warnIncubationFluid					= mod:NewStackAnnounce(298242, 2, nil, "Tank")
----Adds
local warnAquaLance							= mod:NewTargetAnnounce(295779, 2)
local warnShockingLightning					= mod:NewSpellAnnounce(295818, 2, nil, false)
local warnPowerfulStomp						= mod:NewCountAnnounce(296691, 2)

local specWarnDesensitizingSting			= mod:NewSpecialWarningStack(298156, nil, 9, nil, nil, 1, 6)
local specWarnDesensitizingStingTaunt		= mod:NewSpecialWarningTaunt(298156, nil, nil, nil, 1, 2)
local specWarnDribblingIchor				= mod:NewSpecialWarningSwitchCount(298103, nil, nil, nil, 1, 2)
local specWarnIncubationFluid				= mod:NewSpecialWarningMoveAway(298306, nil, nil, nil, 1, 2)
local specWarnArcingCurrent					= mod:NewSpecialWarningSpell(295825, nil, nil, nil, 2, 2)
local yellArcingCurrent						= mod:NewYell(295825)
----Adds
local specWarnAquaLance						= mod:NewSpecialWarningMoveAway(295779, nil, nil, nil, 1, 2)
local yellAquaLance							= mod:NewYell(295779)
--local specWarnGTFO						= mod:NewSpecialWarningGTFO(270290, nil, nil, nil, 1, 8)
local specWarnConductivePulse				= mod:NewSpecialWarningInterrupt(295822, "HasInterrupt", nil, nil, 3, 2)

--mod:AddTimerLine(BOSS)
local timerDesensitizingStingCD				= mod:NewAITimer(58.2, 298156, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)
local timerDribblingIchorCD					= mod:NewAITimer(30.4, 298103, nil, nil, nil, 1)--30.4-42
local timerIncubationFluidCD				= mod:NewAITimer(30.4, 298242, nil, nil, nil, 3)
local timerArcingCurrentCD					= mod:NewAITimer(30.4, 295825, nil, nil, nil, 3)
local timerMassiveIncubator					= mod:NewCastTimer(45, 298548, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
----Adds
local timerAquaLanceCD						= mod:NewAITimer(30.4, 295779, nil, nil, nil, 3)
local timerShockingLightningCD				= mod:NewAITimer(30.4, 295818, nil, false, nil, 3)
local timerConductivePulseCD				= mod:NewAITimer(45, 295822, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
local timerPowerfulStompCD					= mod:NewAITimer(45, 296691, nil, nil, nil, 2, nil, DBM_CORE_HEALER_ICON)

--local berserkTimer					= mod:NewBerserkTimer(600)

--local countdownCudgelofGore				= mod:NewCountdown(58, 271296)
--local countdownEnlargedHeart			= mod:NewCountdown("Alt60", 275205, true, 2)

--mod:AddRangeFrameOption(6, 264382)
--mod:AddInfoFrameOption(275270, true)
--mod:AddSetIconOption("SetIconOnEyeBeam", 264382, true)
mod:AddNamePlateOption("NPAuraOnChaoticGrowth", 296914)

mod.vb.phase = 1
mod.vb.addCount = 0
local playerHasIncubation = false
local castsPerGUID = {}

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.addCount = 0
	playerHasIncubation = false
	table.wipe(castsPerGUID)
	timerDesensitizingStingCD:Start(1-delay)
	timerDribblingIchorCD:Start(1-delay)
	timerIncubationFluidCD:Start(1-delay)
	timerArcingCurrentCD:Start(1-delay)
	if self.Options.NPAuraOnChaoticGrowth then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.NPAuraOnChaoticGrowth then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:OnTimerRecovery()
	if DBM:UnitDebuff("player", 298306) then
		playerHasIncubation = true
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 298242 then
		warnIncubationFluid:Show()
		timerIncubationFluidCD:Start()
	elseif spellId == 298413 then
		specWarnArcingCurrent:Show()
		timerArcingCurrentCD:Start()
		if playerHasIncubation then
			yellArcingCurrent:Yell()
			specWarnArcingCurrent:Play("targetyou")
		else
			specWarnArcingCurrent:Play("farfromline")
		end
	elseif spellId == 298548 then
		timerMassiveIncubator:Start(45)
	elseif spellId == 295818 then
		warnShockingLightning:Show()
		timerShockingLightningCD:Start(nil, args.sourceGUID)
	elseif spellId == 295822 then
		timerConductivePulseCD:Start(nil, args.sourceGUID)
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnConductivePulse:Show(args.sourceName)
			specWarnConductivePulse:Play("kickcast")
		end
	elseif spellId == 296691 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		warnPowerfulStomp:Show(castsPerGUID[args.sourceGUID])
		timerPowerfulStompCD:Start(nil, args.sourceGUID)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 298103 and self:AntiSpam(5, 1) then--Dribbling Ichor
		self.vb.addCount = self.vb.addCount + 1
		specWarnDribblingIchor:Show(self.vb.addCount)
		specWarnDribblingIchor:Play("mobsoon")
		timerDribblingIchorCD:Start()
	elseif spellId == 298156 then
		timerDesensitizingStingCD:Start()
	elseif spellId == 298548 then--Massive Incubator
		timerDribblingIchorCD:Start(2)
		timerDesensitizingStingCD:Start(2)
		timerIncubationFluidCD:Start(2)
		timerArcingCurrentCD:Start(2)
	elseif spellId == 295779 then
		timerAquaLanceCD:Start(nil, args.sourceGUID)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 299095 and self:AntiSpam(5, 1) then--Dribbling Ichor
		self.vb.addCount = self.vb.addCount + 1
		specWarnDribblingIchor:Show(self.vb.addCount)
		specWarnDribblingIchor:Play("mobsoon")
		timerDribblingIchorCD:Start()
	elseif spellId == 298156 then
		local amount = args.amount or 1
		if amount >= 9 then
			if args:IsPlayer() then
				specWarnDesensitizingSting:Show(amount)
				specWarnDesensitizingSting:Play("stackhigh")
			else
				if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", spellId) then--Can't taunt less you've dropped yours off, period.
					specWarnDesensitizingStingTaunt:Show(args.destName)
					specWarnDesensitizingStingTaunt:Play("tauntboss")
				else
					warnDesensitizingSting:Show(args.destName, amount)
				end
			end
		else
			warnDesensitizingSting:Show(args.destName, amount)
		end
	elseif spellId == 298306 then
		if args:IsPlayer() then
			specWarnIncubationFluid:Show()
			specWarnIncubationFluid:Play("targetyou")
			playerHasIncubation = true
		end
	elseif spellId == 296914 then--Sanguine Presence
		if self.Options.NPAuraOnChaoticGrowth then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 295779 then
		if args:IsPlayer() then
			specWarnAquaLance:Show()
			specWarnAquaLance:Play("targetyou")
			yellAquaLance:Yell()
		else
			warnAquaLance:Show(args.destName)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 298306 then--Incubation Fluid
		if args:IsPlayer() then
			playerHasIncubation = false
		end
	elseif spellId == 296914 then--Chaotic Growth
		if self.Options.NPAuraOnChaoticGrowth then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
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

function mod:SPELL_INTERRUPT(args)
	if type(args.extraSpellId) == "number" and args.extraSpellId == 298548 then
		timerMassiveIncubator:Stop()
		timerDribblingIchorCD:Start(2)
		timerDesensitizingStingCD:Start(2)
		timerIncubationFluidCD:Start(2)
		timerArcingCurrentCD:Start(2)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 153941 then--Zoatroid

	elseif cid == 152311 then--hatchery-warrior
		timerAquaLanceCD:Stop(args.destGUID)
	elseif cid == 152312 then--hatchery-witch
		timerShockingLightningCD:Stop(args.destGUID)
		timerConductivePulseCD:Stop(args.destGUID)
	elseif cid == 152313 then--hatchery-brute
		castsPerGUID[args.destGUID] = nil
		timerPowerfulStompCD:Stop(args.destGUID)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 298077 and self:AntiSpam(5, 1) then--Dribling Ichor
		self.vb.addCount = self.vb.addCount + 1
		specWarnDribblingIchor:Show(self.vb.addCount)
		specWarnDribblingIchor:Play("mobsoon")
		if self.vb.addCount == 3 then
			self.vb.phase = 2
			timerDribblingIchorCD:Stop()
			timerDesensitizingStingCD:Stop()
			timerIncubationFluidCD:Stop()
			timerArcingCurrentCD:Stop()
		else
			timerDribblingIchorCD:Start()
		end
	end
end
