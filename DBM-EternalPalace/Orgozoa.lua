local mod	= DBM:NewMod(2351, "DBM-EternalPalace", nil, 1179)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(152128)
mod:SetEncounterID(2303)
mod:SetZone()
mod:SetHotfixNoticeRev(20190716000000)--2019, 7, 16
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 298548 295818 295822 296691 307167 305857",
	"SPELL_CAST_SUCCESS 298242 298103 298156 305057",
	"SPELL_SUMMON 298465",
	"SPELL_AURA_APPLIED 298156 298306 296914 295779",
	"SPELL_AURA_APPLIED_DOSE 298156",
	"SPELL_AURA_REMOVED 298306 296914 295779",
	"SPELL_INTERRUPT",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, Pervasive Shock?
--TODO, skewer or not to skewer
--TODO, raging-rapids?
--TODO, do more with powerful stomp?
--[[
(ability.id = 298548 or ability.id = 295818 or ability.id = 295822 or ability.id = 296691 or ability.id = 307167 or ability.id = 305857) and type = "begincast"
 or (ability.id = 298242 or ability.id = 298103 or ability.id = 298156 or ability.id = 298548 or ability.id = 295779 or ability.id = 305057) and type = "cast"
 or type = "interrupt"
--]]
local warnDesensitizingSting				= mod:NewStackAnnounce(298156, 2, nil, "Tank")
local warnIncubationFluid					= mod:NewTargetNoFilterAnnounce(298306, 2)
local warnCallofTender						= mod:NewCountAnnounce(305057, 2)
local warnArcingCurrent						= mod:NewCountAnnounce(295825, 2)
----Adds
local warnAquaLance							= mod:NewTargetNoFilterAnnounce(295779, 2)
local warnShockingLightning					= mod:NewSpellAnnounce(295818, 2, nil, false)
local warnPowerfulStomp						= mod:NewCountAnnounce(296691, 2)

local specWarnDesensitizingSting			= mod:NewSpecialWarningStack(298156, nil, 9, nil, nil, 1, 6)
local specWarnDesensitizingStingTaunt		= mod:NewSpecialWarningTaunt(298156, nil, nil, nil, 1, 2)
local specWarnDribblingIchor				= mod:NewSpecialWarningCount(298103, nil, nil, nil, 2, 2)
local specWarnCallofTender					= mod:NewSpecialWarningSwitchCount(305057, "Tank", nil, nil, 1, 2, 4)
local specWarnIncubationFluid				= mod:NewSpecialWarningMoveAway(298306, nil, nil, nil, 1, 2)
local specWarnArcingCurrent					= mod:NewSpecialWarningCount(295825, nil, nil, nil, 2, 2)
local yellArcingCurrent						= mod:NewYell(295825)
--local specWarnGTFO						= mod:NewSpecialWarningGTFO(270290, nil, nil, nil, 1, 8)
----Adds
local specWarnAquaLance						= mod:NewSpecialWarningMoveAway(295779, nil, nil, nil, 1, 2)
local yellAquaLance							= mod:NewYell(295779)
local yellAquaLanceFades					= mod:NewShortFadesYell(295779)
local specWarnConductivePulse				= mod:NewSpecialWarningInterrupt(295822, "HasInterrupt", nil, nil, 3, 2)

mod:AddTimerLine(BOSS)
local timerDesensitizingStingCD				= mod:NewCDTimer(5.3, 298156, nil, "Tank", 2, 5, nil, DBM_CORE_TANK_ICON, nil, nil, 3)--If user does enable countdown for this, max count at 3
local timerDribblingIchorCD					= mod:NewCDCountTimer(84, 298103, nil, nil, nil, 1, nil, nil, nil, 1, 4)--30.4-42
local timerIncubationFluidCD				= mod:NewCDTimer(31.7, 298242, nil, nil, nil, 3, nil, nil, nil, 3, 4)
local timerArcingCurrentCD					= mod:NewCDCountTimer(30.1, 295825, nil, nil, nil, 3)
local timerCalloftheTenderCD				= mod:NewCDCountTimer(35, 305057, nil, nil, nil, 1, nil, DBM_CORE_MYTHIC_ICON, nil, 2, 4)--30.4-42
--Transition
local timerMassiveIncubator					= mod:NewCastTimer(20, 298548, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON, nil, 1, 4)--was 45, is 20 now
mod:AddTimerLine(DBM_ADDS)
local timerAmnioticEruption					= mod:NewCastTimer(5, 298465, nil, nil, nil, 2, nil, DBM_CORE_TANK_ICON)
local timerAquaLanceCD						= mod:NewCDTimer(25.5, 295779, nil, nil, nil, 3)
local timerShockingLightningCD				= mod:NewCDTimer(4.8, 295818, nil, false, nil, 3)
local timerConductivePulseCD				= mod:NewCDTimer(18.2, 295822, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
local timerPowerfulStompCD					= mod:NewCDTimer(29.1, 296691, nil, nil, nil, 2, nil, DBM_CORE_HEALER_ICON)

local berserkTimer							= mod:NewBerserkTimer(600)

mod:AddNamePlateOption("NPAuraOnAquaLance", 282209)
mod:AddNamePlateOption("NPAuraOnChaoticGrowth", 296914)

mod.vb.phase = 1
mod.vb.addCount = 0
mod.vb.arcingCurrentCount = 0
mod.vb.tenderCount = 0
mod.vb.ichorAddsRemaining = 0
local playerHasIncubation = false
local castsPerGUID = {}

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.addCount = 0
	self.vb.arcingCurrentCount = 0
	self.vb.tenderCount = 0
	self.vb.ichorAddsRemaining = 0
	playerHasIncubation = false
	table.wipe(castsPerGUID)
	timerDesensitizingStingCD:Start(3-delay)
	timerIncubationFluidCD:Start(18.6-delay)
	timerDribblingIchorCD:Start(28.9-delay, 1)
	timerArcingCurrentCD:Start(41-delay, 1)
	if self:IsMythic() then
		timerCalloftheTenderCD:Start(20.3-delay, 1)
	end
	berserkTimer:Start(759-delay)--Normal and Heroic at least, unconfirmed LFR and mythic
	if self.Options.NPAuraOnChaoticGrowth or self.Options.NPAuraOnAquaLance then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.NPAuraOnChaoticGrowth or self.Options.NPAuraOnAquaLance then
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
	if spellId == 298548 then
		local _, _, _, startTime, endTime = UnitCastingInfo("boss1")
		local time = ((endTime or 0) - (startTime or 0)) / 1000
		timerMassiveIncubator:Start(time)
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
	elseif spellId == 307167 or spellId == 305857 then--Normal/Heroic, Mythic
		self.vb.arcingCurrentCount = self.vb.arcingCurrentCount + 1
		timerArcingCurrentCD:Start(nil, self.vb.arcingCurrentCount+1)
		if playerHasIncubation and self:IsMythic() then
			specWarnArcingCurrent:Show(self.vb.arcingCurrentCount)
			specWarnArcingCurrent:Play("targetyou")
			yellArcingCurrent:Yell()
		else
			warnArcingCurrent:Show(self.vb.arcingCurrentCount)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 298242 then
		timerIncubationFluidCD:Start()
	elseif spellId == 298103 then--Dribbling Ichor
		self.vb.addCount = self.vb.addCount + 1
		self.vb.ichorAddsRemaining = self.vb.ichorAddsRemaining + 3
		specWarnDribblingIchor:Show(self.vb.addCount)
		specWarnDribblingIchor:Play("mobsoon")
		if self.vb.addCount == 1 then
			timerDribblingIchorCD:Start(85, 2)
		else--2+ (todo verify the + part)
			timerDribblingIchorCD:Start(86.4, self.vb.addCount+1)
		end
	elseif spellId == 298156 then
		timerDesensitizingStingCD:Start()
	elseif spellId == 295779 then
		timerAquaLanceCD:Start(nil, args.sourceGUID)
	elseif spellId == 305057 then
		self.vb.tenderCount = self.vb.tenderCount + 1
		--Will not show warning if you are tanking boss, unless you're only tank left alive
		if self.Options.SpecWarn305057switchcount and (not self:IsTanking("player", "boss1", nil, true) or self:GetNumAliveTanks() < 2) then
			specWarnCallofTender:Show(self.vb.tenderCount)
			specWarnCallofTender:Play("killmob")
		else
			warnCallofTender:Show(self.vb.tenderCount)
		end
		timerCalloftheTenderCD:Start(35, self.vb.tenderCount+1)
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 298465 then
		timerAmnioticEruption:Start(5, args.destGUID)
	end
end


function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 298156 then
		local amount = args.amount or 1
		--if adds all dead, should be swapping at about 6-7. If they aren't all dead, it'll start throwing emergency warnings at 8+
		if (self.vb.ichorAddsRemaining == 0 and amount >= 6) or amount >= 8 then
			if args:IsPlayer() then
				specWarnDesensitizingSting:Show(amount)
				specWarnDesensitizingSting:Play("stackhigh")
			else
				--Don't show taunt warning if you're 3 tanking and aren't near the boss (this means you are the add tank)
				--Show taunt warning if you ARE near boss, or if number of alive tanks is less than 3
				if (self:CheckNearby(8, args.destName) or self:GetNumAliveTanks() < 3) and not DBM:UnitDebuff("player", spellId) and not UnitIsDeadOrGhost("player") then--Can't taunt less you've dropped yours off, period.
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
		warnIncubationFluid:CombinedShow(1.5, args.destName)
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
			yellAquaLanceFades:Countdown(spellId)
			if self.Options.NPAuraOnAquaLance then
				DBM.Nameplate:Show(true, args.sourceGUID, spellId)
			end
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
	elseif spellId == 295779 then
		if args:IsPlayer() then
			yellAquaLanceFades:Cancel()
			if self.Options.NPAuraOnAquaLance then
				DBM.Nameplate:Hide(true, args.destGUID, spellId)
			end
		end
	end
end

function mod:SPELL_INTERRUPT(args)
	if type(args.extraSpellId) == "number" and args.extraSpellId == 298548 then
		timerMassiveIncubator:Stop()
		timerDesensitizingStingCD:Start(3)
		timerIncubationFluidCD:Start(18.6)
		timerDribblingIchorCD:Start(26.1, 1)
		timerArcingCurrentCD:Start(38.2, 1)
		if self:IsMythic() then
			timerCalloftheTenderCD:Start(20.3, 1)
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 152311 then--hatchery-warrior
		timerAquaLanceCD:Stop(args.destGUID)
	elseif cid == 152312 then--hatchery-witch
		timerShockingLightningCD:Stop(args.destGUID)
		timerConductivePulseCD:Stop(args.destGUID)
	elseif cid == 152313 then--hatchery-brute
		castsPerGUID[args.destGUID] = nil
		timerPowerfulStompCD:Stop(args.destGUID)
	elseif cid == 152159 then--Zoatroid
		self.vb.ichorAddsRemaining = self.vb.ichorAddsRemaining - 1
	end
end

--"<216.58 17:04:01> [UNIT_SPELLCAST_SUCCEEDED] Orgozoa(??) -Absorb Fluids- [[boss1:Cast-3-3198-2164-287-298689-0041D5E741:298689]]", -- [6915]
--"<236.77 17:04:22> [UNIT_SPELLCAST_START] Orgozoa(??) - Massive Incubator - 45s [[boss1:Cast-3-3198-2164-287-298548-005955E755:298548]]", -- [7466]
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 298689 then--Absorb Fluids
		self.vb.phase = 2
		self.vb.addCount = 0
		self.vb.arcingCurrentCount = 0
		self.vb.tenderCount = 0
		timerDribblingIchorCD:Stop()
		timerDesensitizingStingCD:Stop()
		timerIncubationFluidCD:Stop()
		timerArcingCurrentCD:Stop()
		timerCalloftheTenderCD:Stop()
	end
end
