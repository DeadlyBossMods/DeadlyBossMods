local mod	= DBM:NewMod(2370, "DBM-Nyalotha", nil, 1180)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(157354)
mod:SetEncounterID(2336)
mod:SetZone()
mod:SetHotfixNoticeRev(20200128000000)--2020, 1, 28
mod:SetMinSyncRevision(20200128000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 307020 307403 306982 307177 307639 315762 307729 315932 307453",
	"SPELL_CAST_SUCCESS 307359 310323 307396 307075",
	"SPELL_AURA_APPLIED 307314 307019 307359 306981 307075 310323 307343",
	"SPELL_AURA_APPLIED_DOSE 307019",
	"SPELL_AURA_REMOVED 307314 307019 307359 310323",
	"SPELL_PERIODIC_DAMAGE 307343",
	"SPELL_PERIODIC_MISSED 307343",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED"
)

--TODO, Improve add spawn detection and their initial ability timers.
--TODO, aura https://ptr.wowhead.com/spell=306996/gift-of-the-void on the mob itself?
--TODO, verify with greater data if timers actually do reset on phase changes
--TODO, improve timer start code for P1 abilities to not start new timers if lift off is soon
--TODO, use https://ptr.wowhead.com/spell=306996/gift-of-the-void for initial void duder timers?
--[[
(ability.id = 307020 or ability.id = 307403 or ability.id = 307639 or ability.id = 315762 or ability.id = 307453) and type = "begincast"
 or (ability.id = 307359 or ability.id = 307828 or ability.id = 310323) and type = "cast"
 or ability.id = 307314 and type = "applydebuff"

 or (ability.id = 307177 or ability.id = 307729) and type = "begincast"
 or ability.id = 307396 and type = "cast"
--]]
----Stage 1: Cult of the Void
local warnGiftoftheVoid						= mod:NewTargetNoFilterAnnounce(306981, 1)
local warnFanaticalAscension				= mod:NewCastAnnounce(307729, 4)
local warnPoweroftheChosen					= mod:NewTargetNoFilterAnnounce(307075, 3)
local warnSpitefulAssault					= mod:NewSpellAnnounce(307396, 2)
local warnBrutalSmash						= mod:NewSpellAnnounce(315932, 4)--Fall back warning that'll only fire if special warning for brutal smash disabled
----Stage 3: The Void Unleashed
local warnPhase3							= mod:NewPhaseAnnounce(3, 2)
local warnDesolation						= mod:NewTargetNoFilterAnnounce(310325, 4)

--Vexiona
----Stage 1: Cult of the Void
local specWarnEncroachingShadows			= mod:NewSpecialWarningMoveAway(307314, nil, nil, nil, 1, 2)
local yellEncroachingShadows				= mod:NewYell(307314)
local yellEncroachingShadowsFades			= mod:NewShortFadesYell(307314)
local specWarnTwilightBreath				= mod:NewSpecialWarningDefensive(307020, nil, 18620, nil, 1, 2)
local specWarnDespair						= mod:NewSpecialWarningYou(307359, nil, nil, nil, 1, 2)
local yellDespairFades						= mod:NewFadesYell(307359, nil, false)
local specWarnDespairOther					= mod:NewSpecialWarningTarget(307359, "Healer", nil, nil, 1, 2)
local specWarnDarkGateway					= mod:NewSpecialWarningSwitchCount(307057, "-Healer", nil, nil, 1, 2)
local specWarnGTFO							= mod:NewSpecialWarningGTFO(307343, nil, nil, nil, 1, 8)
----Iron-Willed Enforcer
local specWarnBrutalSmash					= mod:NewSpecialWarningDodge(315932, false, nil, 2, 2, 2, 4)--May feel spammy if multiple adds are up so elect in instead of out
----Stage 2: Death From Above
local specWarnTwilightDecimator				= mod:NewSpecialWarningDodgeCount(307218, nil, 125030, nil, 2, 2)
----Stage 3: The Void Unleashed
local specWarnHeartofDarkness				= mod:NewSpecialWarningRun(307639, nil, nil, nil, 4, 2)
local specWarnDesolation					= mod:NewSpecialWarningYou(310325, nil, nil, nil, 1, 2)
local yellDesolation						= mod:NewYell(310325, nil, nil, nil, "YELL")
local yellDesolationFades					= mod:NewShortFadesYell(310325, nil, nil, nil, "YELL")
local specWarnDesolationShare				= mod:NewSpecialWarningMoveTo(310325, false, nil, 2, 1, 2)
--Adds
----Void Ascendant
local specWarnAnnihilation					= mod:NewSpecialWarningDodgeCount(307403, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dodge:format(307403), nil, 2, 2)
local specWarnAnnihilationDefensive			= mod:NewSpecialWarningDefensive(307403, nil, nil, nil, 1, 2)
----Spellbound Ritualist
local specWarnVoidBolt						= mod:NewSpecialWarningInterrupt(307177, "HasInterrupt", nil, nil, 3, 2)

--Vexiona
----Stage 1: Cult of the Void
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20661))
local timerEncroachingShadowsCD				= mod:NewCDTimer(14.6, 307314, nil, nil, nil, 3)
local timerTwilightBreathCD					= mod:NewCDTimer(14.8, 307020, 18620, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON, nil, 2, 3)--14.8-20.0
local timerDespairCD						= mod:NewCDTimer(35.2, 307359, nil, nil, nil, 5, nil, DBM_CORE_HEALER_ICON)--35.2-36.4
local timerShatteredResolve					= mod:NewTargetTimer(6, 307371, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
local timerDarkGatewayCD					= mod:NewCDCountTimer(33.2, 307057, nil, nil, nil, 1, nil, nil, nil, 1, 4)
----Iron-Willed Enforcer
local timerNoEscapeCD						= mod:NewCDCountTimer(11, 316437, nil, nil, nil, 3, nil, DBM_CORE_MYTHIC_ICON)
----Stage 2: Death From Above
--mod:AddTimerLine(DBM:EJ_GetSectionInfo(20667))
local timerTwilightDecimatorCD				= mod:NewNextCountTimer(12.2, 307218, 125030, nil, nil, 3)--Deep Breath shorttext
----Stage 3: The Void Unleashed
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20669))
local timerHeartofDarknessCD				= mod:NewCDCountTimer(31.6, 307639, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON, nil, 1, 4)
local timerDesolationCD						= mod:NewCDTimer(32.3, 310325, nil, nil, nil, 3, nil, DBM_CORE_HEROIC_ICON)
--Adds
----Void Ascendant
--mod:AddTimerLine(DBM:EJ_GetSectionInfo(20684))
local timerAnnihilationCD					= mod:NewCDTimer(14.6, 307403, nil, nil, nil, 3)

local berserkTimer							= mod:NewBerserkTimer(600)

mod:AddInfoFrameOption(307019, true)
mod:AddNamePlateOption("NPAuraOnPoweroftheChosen", 307729, false)

local voidCorruptionStacks = {}
local unitTracked = {}
local seenAdds = {}
local enforcerCount = 0
local playerName = UnitName("player")
mod.vb.gatewayCount = 0
mod.vb.phase = 1
mod.vb.TwilightDCasts = 0
mod.vb.darknessCasts = 0

--/run DBM:GetModByName("2370"):Test()
function mod:Test()
	timerTwilightDecimatorCD:Start(92, 1)
end

function mod:OnCombatStart(delay)
	table.wipe(voidCorruptionStacks)
	table.wipe(unitTracked)
	table.wipe(seenAdds)
	enforcerCount = 0
	self.vb.gatewayCount = 0
	self.vb.phase = 1
	self.vb.TwilightDCasts = 0
	self.vb.darknessCasts = 0
	timerTwilightBreathCD:Start(7.2-delay)
	timerDespairCD:Start(10.1-delay)
	timerEncroachingShadowsCD:Start(14.8-delay)
	timerDarkGatewayCD:Start(32.9-delay, 1)
	timerTwilightDecimatorCD:Start(89.7-delay, 1)
	berserkTimer:Start(720-delay)--Normal confirmed, heroic people didn't have parses that far yet, but likely same
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
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 307020 then
		timerTwilightBreathCD:Start(self.vb.phase == 3 and 14.8 or 17)
		if UnitDetailedThreatSituation("player", "boss1") then
			specWarnTwilightBreath:Show()
			specWarnTwilightBreath:Play("breathsoon")
		end
	elseif (spellId == 307403 or spellId == 306982) and self:AntiSpam(3, args.sourceName) then--Enemy, Player
		if spellId == 307403 then--Enemy
			local bossUnitID = self:GetUnitIdFromGUID(args.sourceGUID)
			--First check if we're tanking the caster, if we are, DBM should tell you to pop defensive, not dodge it (tank can't dodge it)
			if self:IsTanking("player", bossUnitID, nil, true) then
				specWarnAnnihilationDefensive:Show()
				specWarnAnnihilationDefensive:Play("defensive")
			else--Not tanking it, you can dodge it
				specWarnAnnihilation:Show(args.sourceName)
				specWarnAnnihilation:Play("shockwave")
			end
		--Source is a player, now we make sure that the player casting it isn't ourselves. Can't be hit by our own cast so shouldn't be told to dodge it
		elseif args.sourceName ~= playerName then
			specWarnAnnihilation:Show(args.sourceName)
			specWarnAnnihilation:Play("shockwave")
		end
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
	elseif spellId == 315762 and (self.vb.phase == 3) then--Mythic can't use the faster method
		self.vb.TwilightDCasts = self.vb.TwilightDCasts + 1
		--specWarnTwilightDecimator:Show(self.vb.TwilightDCasts)
		specWarnTwilightDecimator:Schedule(16.3, self.vb.TwilightDCasts+1)
		specWarnTwilightDecimator:ScheduleVoice(16.3, "breathsoon")
		timerTwilightDecimatorCD:Start(16.3, self.vb.TwilightDCasts+1)--Actually 18.3-19.1, but we make timer line up with pre scheduling
	elseif spellId == 315932 then
		if self:AntiSpam(3, 4) then
			if self.Options.SpecWarn315932dodge then
				specWarnBrutalSmash:Show()
				specWarnBrutalSmash:Play("watchstep")
			else
				warnBrutalSmash:Show()
			end
		end
		if self:AntiSpam(3, args.sourceGUID) then
			self:SendSync("NoEscape", args.sourceGUID)
		end
	--TODO, i want to say there was a reason i was using SUCCESS instead of START, DO gateway or something persist until this spell finishes?
	elseif spellId == 307453 then
		self.vb.phase = 3
		self.vb.TwilightDCasts = 0
		warnPhase3:Show()
		warnPhase3:Play("pthree")
		timerTwilightDecimatorCD:Stop()
		timerEncroachingShadowsCD:Stop()
		timerTwilightBreathCD:Stop()
		timerDespairCD:Stop()
		timerDarkGatewayCD:Stop()
		timerTwilightBreathCD:Start(11.3)
		timerEncroachingShadowsCD:Start(21.1)--SUCCESS/APPLIED
		timerHeartofDarknessCD:Start(21.5, 1)--START
		if self:IsHard() then
			timerDesolationCD:Start(37.9)
			if self:IsMythic() then
				specWarnTwilightDecimator:Schedule(12.7, 1)
				specWarnTwilightDecimator:ScheduleVoice(12.7, "breathsoon")
				timerTwilightDecimatorCD:Start(12.7, 1)--Actually 14.7-15, but we want to pre warn like P2 does with scripts
			end
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 307359 then
		timerDespairCD:Start()
	elseif spellId == 310323 then
		timerDesolationCD:Start()
	elseif spellId == 307396 and self:AntiSpam(3, 5) then
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
		elseif self.Options.SpecWarn310325moveto then
			specWarnDesolationShare:Show(args.destName)
			specWarnDesolationShare:Play("gathershare")
		else
			warnDesolation:Show(args.destName)
		end
	elseif spellId == 307343 and args:IsPlayer() and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("watchfeet")
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

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 157467 then--Void Ascendant
		unitTracked[args.destGUID] = nil
		DBM.Nameplate:Hide(true, args.destGUID)
		timerAnnihilationCD:Stop(args.destGUID)
	elseif cid == 157447 then --fanatical-cultist
		unitTracked[args.destGUID] = nil
		DBM.Nameplate:Hide(true, args.destGUID)
	elseif cid == 157451 then--Mythic Iron Guy
		if seenAdds[args.destGUID] then
			timerNoEscapeCD:Stop(seenAdds[args.destGUID])
			seenAdds[args.destGUID] = nil
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	--More robust than using SPELL_CAST_START which only starts when breath attack actually begins
	--This comes about 2.5 seconds sooner. In addition, this also acts as an end script (basically a dummy cast) at end of it all
	if uId == "boss1" then
		if spellId == 310225 and self.vb.phase ~= 3 then--Twilight Decimator
			if self.vb.phase == 1 then
				self.vb.phase = 2
				self.vb.TwilightDCasts = 0
				timerEncroachingShadowsCD:Stop()--Cast immediately when she goes up
				--timerEncroachingShadowsCD:Start(2)
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
			timerDarkGatewayCD:Start(33, self.vb.gatewayCount+1)
		end
	elseif spellId == 316437 then--No Escape
		local guid = UnitGUID(uId)
		if self:AntiSpam(3, guid) then
			self:SendSync("NoEscape", guid)
		end
	end
end

function mod:OnSync(msg, guid)
	if msg == "NoEscape" and guid then
		if not seenAdds[guid] then
			enforcerCount = enforcerCount + 1
			seenAdds[guid] = enforcerCount--Store add count by guid
		end
		if seenAdds[guid] then
			timerNoEscapeCD:Start(11, seenAdds[guid])
		end
	end
end
