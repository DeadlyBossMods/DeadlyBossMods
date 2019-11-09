local mod	= DBM:NewMod(2370, "DBM-Nyalotha", nil, 1180)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(151798)
mod:SetEncounterID(2336)
mod:SetZone()
mod:SetHotfixNoticeRev(20191109000000)--2019, 11, 09
--mod:SetMinSyncRevision(20190716000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 307020 307403 306982 307177 307639 315762 307729",
	"SPELL_CAST_SUCCESS 307359 307828 310323 307396 307075",
	"SPELL_AURA_APPLIED 307314 307019 307359 306981 307075 310323",
	"SPELL_AURA_APPLIED_DOSE 307019",
	"SPELL_AURA_REMOVED 307314 307019 307359 310323",
	"SPELL_PERIODIC_DAMAGE 307343",
	"SPELL_PERIODIC_MISSED 307343",
--	"SPELL_INTERRUPT",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, Improve add spawn detection and their initial ability timers.
--TODO, aura https://ptr.wowhead.com/spell=306996/gift-of-the-void on the mob itself?
--TODO, verify with greater data if timers actually do reset on phase changes
--TODO, improve timer start code for P1 abilities to not start new timers if lift off is soon
--TODO, use https://ptr.wowhead.com/spell=306996/gift-of-the-void for initial void duder timers?
----Stage 1: Cult of the Void
local warnGiftoftheVoid						= mod:NewTargetNoFilterAnnounce(306981, 1)
local warnFanaticalAscension				= mod:NewCastAnnounce(307729, 4)
local warnPoweroftheChosen					= mod:NewTargetNoFilterAnnounce(307075, 3)
local warnSpitefulAssault					= mod:NewSpellAnnounce(307396, 2)
----Stage 3: The Void Unleashed
local warnPhase3							= mod:NewPhaseAnnounce(3, 2)

--Vexiona
----Stage 1: Cult of the Void
local specWarnEncroachingShadows			= mod:NewSpecialWarningMoveAway(307314, nil, nil, nil, 1, 2)
local yellEncroachingShadows				= mod:NewYell(307314)
local yellEncroachingShadowsFades			= mod:NewShortFadesYell(307314)
local specWarnTwilightBreath				= mod:NewSpecialWarningDefensive(307020, nil, nil, nil, 1, 2)
local specWarnDespair						= mod:NewSpecialWarningYou(307359, nil, nil, nil, 1, 2)
local yellDespairFades						= mod:NewFadesYell(307359, nil, false)
local specWarnDespairOther					= mod:NewSpecialWarningTarget(307359, "Healer", nil, nil, 1, 2)
local specWarnDarkGateway					= mod:NewSpecialWarningSwitchCount(307057, "-Healer", nil, nil, 1, 2)
local specWarnGTFO							= mod:NewSpecialWarningGTFO(307343, nil, nil, nil, 1, 8)
----Stage 2: Death From Above
local specWarnTwilightDecimator				= mod:NewSpecialWarningDodgeCount(307218, nil, nil, nil, 2, 2)
----Stage 3: The Void Unleashed
local specWarnHeartofDarkness				= mod:NewSpecialWarningRun(307639, nil, nil, nil, 4, 2)
local specWarnDesolation					= mod:NewSpecialWarningYou(310325, nil, nil, nil, 1, 2)
local yellDesolation						= mod:NewYell(310325, nil, nil, nil, "YELL")
local yellDesolationFades					= mod:NewShortFadesYell(310325, nil, nil, nil, "YELL")
local specWarnDesolationShare				= mod:NewSpecialWarningMoveTo(310325, "-Tank", nil, nil, 1, 2)
--Adds
----Void Ascendant
local specWarnAnnihilation					= mod:NewSpecialWarningDodgeCount(307403, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dodge:format(307403), nil, 2, 2)
----Spellbound Ritualist
local specWarnVoidBolt						= mod:NewSpecialWarningInterrupt(307177, "HasInterrupt", nil, nil, 3, 2)

--Vexiona
----Stage 1: Cult of the Void
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20661))
local timerEncroachingShadowsCD				= mod:NewCDTimer(14.6, 307314, nil, nil, nil, 3)
local timerTwilightBreathCD					= mod:NewCDTimer(18.2, 307020, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON, nil, 2, 4)
local timerDespairCD						= mod:NewCDTimer(35.2, 307359, nil, nil, nil, 5, nil, DBM_CORE_HEALER_ICON)--35.2-36.4
local timerShatteredResolve					= mod:NewTargetTimer(6, 307371, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
local timerDarkGatewayCD					= mod:NewCDCountTimer(33.2, 307057, nil, nil, nil, 1, nil, nil, nil, 1, 4)
----Stage 2: Death From Above
--mod:AddTimerLine(DBM:EJ_GetSectionInfo(20667))
local timerTwilightDecimatorCD				= mod:NewNextCountTimer(12.2, 307218, nil, nil, nil, 3)
----Stage 3: The Void Unleashed
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20669))
local timerHeartofDarknessCD				= mod:NewCDCountTimer(31.6, 307639, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON, nil, 1, 4)
local timerDesolationCD						= mod:NewCDTimer(30.4, 310325, nil, nil, nil, 3, nil, DBM_CORE_HEROIC_ICON)
--Adds
----Void Ascendant
--mod:AddTimerLine(DBM:EJ_GetSectionInfo(20684))
local timerAnnihilationCD					= mod:NewCDTimer(14.6, 307403, nil, nil, nil, 3)

--local berserkTimer						= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption(6, 264382)
mod:AddInfoFrameOption(307019, true)
--mod:AddSetIconOption("SetIconOnEyeBeam", 264382, true, false, {1, 2})
mod:AddNamePlateOption("NPAuraOnPoweroftheChosen", 307729, false)

local voidCorruptionStacks = {}
local unitTracked = {}
mod.vb.gatewayCount = 0
mod.vb.phase = 1
mod.vb.TwilightDCasts = 0
mod.vb.darknessCasts = 0

function mod:OnCombatStart(delay)
	table.wipe(voidCorruptionStacks)
	table.wipe(unitTracked)
	self.vb.gatewayCount = 0
	self.vb.phase = 1
	self.vb.TwilightDCasts = 0
	self.vb.darknessCasts = 0
	timerTwilightBreathCD:Start(7.2-delay)
	timerDespairCD:Start(10.1-delay)
	timerEncroachingShadowsCD:Start(14.8-delay)
	timerDarkGatewayCD:Start(32.9-delay, 1)
	timerTwilightDecimatorCD:Start(89.7-delay)
	if self.Options.NPAuraOnPoweroftheChosen then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
		self:RegisterOnUpdateHandler(function(self)
			for i = 1, 40 do
				local UnitID = "nameplate"..i
				local GUID = UnitGUID(UnitID)
				local cid = self:GetCIDFromGUID(GUID)
				if cid == 157447 then
					local unitPower = UnitPower(UnitID)
					if not unitTracked[GUID] then unitTracked[GUID] = "None" end
					if (unitPower < 30) then
						if unitTracked[GUID] ~= "Green" then
							unitTracked[GUID] = "Green"
							DBM.Nameplate:Show(true, GUID, 276299, 463281)
						end
					elseif (unitPower < 60) then
						if unitTracked[GUID] ~= "Yellow" then
							unitTracked[GUID] = "Yellow"
							DBM.Nameplate:Hide(true, GUID, 276299, 463281)
							DBM.Nameplate:Show(true, GUID, 276299, 460954)
						end
					elseif (unitPower < 90) then
						if unitTracked[GUID] ~= "Red" then
							unitTracked[GUID] = "Red"
							DBM.Nameplate:Hide(true, GUID, 276299, 460954)
							DBM.Nameplate:Show(true, GUID, 276299, 463282)
						end
					elseif (unitPower < 100) then
						if unitTracked[GUID] ~= "Critical" then
							unitTracked[GUID] = "Critical"
							DBM.Nameplate:Hide(true, GUID, 276299, 463282)
							DBM.Nameplate:Show(true, GUID, 276299, 237521)
						end
					end
				end
			end
		end, 1)
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(307019))
		DBM.InfoFrame:Show(10, "table", voidCorruptionStacks, 1)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--	if self.Options.NPAuraOnChaoticGrowth then
--		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
--	end
end

--function mod:OnTimerRecovery()

--end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 307020 then
		timerTwilightBreathCD:Start()
		if UnitDetailedThreatSituation("player", "boss1") then
			specWarnTwilightBreath:Show()
			specWarnTwilightBreath:Play("breathsoon")
		end
	elseif spellId == 307403 or spellId == 306982 then--Enemy, Player
		specWarnAnnihilation:Show(args.sourceName)
		specWarnAnnihilation:Play("shockwave")
		if spellId == 307403 then--Cast by mob not player
			timerAnnihilationCD:Start(14.6, args.sourceGUID)
		end
	elseif spellId == 307177 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnVoidBolt:Show(args.sourceName)
		specWarnVoidBolt:Play("kickcast")
	elseif spellId == 307639 then
		self.vb.darknessCasts = self.vb.darknessCasts + 1
		specWarnHeartofDarkness:Show()
		specWarnHeartofDarkness:Play("justrun")
		timerHeartofDarknessCD:Start(31.6, self.vb.darknessCasts+1)
	elseif spellId == 307729 and self:AntiSpam(3, 3) then
		warnFanaticalAscension:Show()
	--[[elseif spellId == 315762 then
		self.vb.TwilightDCasts = self.vb.TwilightDCasts + 1
		specWarnTwilightDecimator:Show(self.vb.TwilightDCasts)
		specWarnTwilightDecimator:Play("breathsoon")
		if self.vb.TwilightDCasts < 3 then
			timerTwilightDecimatorCD:Start(12.2, self.vb.TwilightDCasts+1)
		else
			self.vb.TwilightDCasts = 0
			timerTwilightDecimatorCD:Start(104, 1)
		end--]]
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 307359 then
		timerDespairCD:Start()
	elseif spellId == 307828 and self.vb.phase < 3 then
		self.vb.phase = 3
		warnPhase3:Show()
		warnPhase3:Play("pthree")
		timerEncroachingShadowsCD:Stop()
		timerTwilightBreathCD:Stop()
		timerDespairCD:Stop()
		timerDarkGatewayCD:Stop()
		timerTwilightBreathCD:Start(14.5)
		timerEncroachingShadowsCD:Start(14.6)
		timerHeartofDarknessCD:Start(17.1, 1)
		if self:IsHard() then
			timerDesolationCD:Start(28.1)
		end
	elseif spellId == 310323 then
		timerDesolationCD:Start()
	elseif spellId == 307396 then
		warnSpitefulAssault:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 307314 then
		if self:AntiSpam(5, 1) then--cast event not in combat log, only debuff. has unit event but only in final phase
			timerEncroachingShadowsCD:Start()
		end
		if args:IsPlayer() then
			specWarnEncroachingShadows:Show()
			specWarnEncroachingShadows:Play("runout")
			yellEncroachingShadows:Yell()
			yellEncroachingShadowsFades:Countdown(spellId)
		end
	elseif spellId == 307019 then
		local amount = args.amount or 1
		voidCorruptionStacks[args.destName] = amount
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(voidCorruptionStacks)
		end
	elseif spellId == 307359 then
		timerShatteredResolve:Start(6, args.destName)
		if args:IsPlayer() then
			specWarnDespair:Show()
			specWarnDespair:Play("targetyou")
			yellDespairFades:Countdown(spellId)
		else
			specWarnDespairOther:Show(args.destName)
			specWarnDespairOther:Play("healfull")
		end
	elseif spellId == 306981 then
		warnGiftoftheVoid:Show(args.destName)
	elseif spellId == 307075 then
		warnPoweroftheChosen:Show(args.destName)
		unitTracked[args.destGUID] = nil
		DBM.Nameplate:Hide(true, args.destGUID)
	elseif spellId == 310323 then
		if args:IsPlayer() then
			specWarnDesolation:Show()
			specWarnDesolation:Play("targetyou")
			yellDesolation:Yell()
			yellDesolationFades:Countdown(spellId)
		else
			specWarnDesolationShare:Show(args.destName)
			specWarnDesolationShare:Play("gathershare")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 307314 then
		if args:IsPlayer() then
			yellEncroachingShadowsFades:Cancel()
		end
	elseif spellId == 307019 then
		voidCorruptionStacks[args.destName] = nil
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(voidCorruptionStacks)
		end
	elseif spellId == 307359 then
		timerShatteredResolve:Stop(args.destName)
		if args:IsPlayer() then
			yellDespairFades:Cancel()
		end
	elseif spellId == 310323 then
		if args:IsPlayer() then
			yellDesolationFades:Cancel()
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 307343 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:SPELL_INTERRUPT(args)
	if type(args.extraSpellId) == "number" and args.extraSpellId == 298548 then

	end
end
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 157467 then--Void Ascendant
		unitTracked[args.destGUID] = nil
		DBM.Nameplate:Hide(true, args.destGUID)
		timerAnnihilationCD:Stop(args.destGUID)
	elseif cid == 157447 then --fanatical-cultist
		unitTracked[args.destGUID] = nil
		DBM.Nameplate:Hide(true, args.destGUID)
	--elseif cid == 157450 then--spellbound-ritualist

	--elseif cid == 157449 then--sinister-soulcarver (heroic+)

	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	--More robust than using SPELL_CAST_START which only starts when breath attack actually begins
	--This comes about 2.5 seconds sooner. In addition, this also acts as an end script (basically a dummy cast) at end of it all
	if spellId == 310225 then--Twilight Decimator
		if self.vb.phase == 1 then
			self.vb.phase = 2
			self.vb.TwilightDCasts = 0
			timerEncroachingShadowsCD:Stop()
			timerEncroachingShadowsCD:Start(2)
			timerTwilightBreathCD:Stop()
			timerDespairCD:Stop()
			timerDarkGatewayCD:Stop()
		end
		self.vb.TwilightDCasts = self.vb.TwilightDCasts + 1
		if self.vb.TwilightDCasts == 4 then--4th time doesn't actually cast a breath, it's phase ending
			self.vb.phase = 1
			self.vb.gatewayCount = 0
			timerEncroachingShadowsCD:Start(7.7)
			timerDarkGatewayCD:Start(12.2, 1)
			timerTwilightBreathCD:Start(13.4)
			timerDespairCD:Start(18)
			timerTwilightDecimatorCD:Start(92.3, 1)
		else
			specWarnTwilightDecimator:Show(self.vb.TwilightDCasts)
			specWarnTwilightDecimator:Play("breathsoon")
			if self.vb.TwilightDCasts < 3 then
				timerTwilightDecimatorCD:Start(12.2, self.vb.TwilightDCasts+1)
			end
		end
	elseif spellId == 307043 then--Dark Gateway
		self.vb.gatewayCount = self.vb.gatewayCount + 1
		specWarnDarkGateway:Show(self.vb.gatewayCount)
		specWarnDarkGateway:Play("killmob")
		timerDarkGatewayCD:Start(33.2, self.vb.gatewayCount+1)
	end
end

