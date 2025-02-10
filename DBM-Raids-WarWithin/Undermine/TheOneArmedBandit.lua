if DBM:GetTOC() < 110100 then return end
local mod	= DBM:NewMod(2644, "DBM-Raids-WarWithin", 1, 1296)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(228458)
mod:SetEncounterID(3014)
mod:SetHotfixNoticeRev(20250209000000)
mod:SetMinSyncRevision(20250209000000)
mod:SetZone(2769)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 461060 464806 464801 464804 472178 464772 464809 464810 460582 471930 472197 460181 469993 460472 465432 465322 465580 465587 465761 464776",--460847
	"SPELL_CAST_SUCCESS 465765",--460181
	"SPELL_AURA_APPLIED 461060 471720 472832 472837 472828 472783 465009 460973 473278 471927 460430 460472 473195",
	"SPELL_AURA_REFRESH 473195",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 461060 471720 465009 460973 473278 471927",
	"SPELL_PERIODIC_DAMAGE 460576",
	"SPELL_PERIODIC_MISSED 460576",
	"UNIT_DIED"
--	"CHAT_MSG_RAID_BOSS_WHISPER",
--	"UNIT_SPELLCAST_SUCCEEDED_UNFILTERED"
)

--TODO, mark token holders with red, blue, orange, and skull?
--TODO, revise audio as needed
--TODO, auto mark bombs with https://www.wowhead.com/ptr-2/spell=461176/reward-flame-and-bomb ?
--TODO, add https://www.wowhead.com/ptr-2/spell=464705/golden-ticket stack tracker? probably not really needed
--TODO, record new payline audio (based on if we can detect it or not)
--TODO, bait timers and short texts
--TODO, figure out the lineyou and farfromline overlap since we can't detect debuff and filter farfromline on private aura...
--[[
(ability.id = 472197 or ability.id = 460181 or ability.id = 469993 or ability.id = 460472 or ability.id = 465587 or ability.id = 461060) and type = "begincast"
or ability.id = 465761 and type = "begincast" or ability.id = 465765 and type = "cast"
or (ability.id = 464810 or ability.id = 464809 or ability.id = 464772 or ability.id = 464804 or ability.id = 464801 or ability.id = 464806 or ability.id = 465761 or ability.id = 465432 or ability.id = 465322 or ability.id = 465580) and type = "begincast"
or ability.id = 461060 and (type = "removebuff")
or (ability.id = 460582 or ability.id = 472178 or ability.id = 471930) and type = "begincast" or ability.id = 471720 and type = "applybuff"
or ability.id = 465309 and type = "cast"
--]]
--Stage One: That's RNG, Baby!
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30083))
--Player carrying Tokens
local warnTokenCoin									= mod:NewTargetNoFilterAnnounce(472832, 1)
local warnTokenBomb									= mod:NewTargetNoFilterAnnounce(472837, 1)
local warnTokenFlame								= mod:NewTargetNoFilterAnnounce(472828, 1)
local warnTokenShock								= mod:NewTargetNoFilterAnnounce(472783, 1)
--Token activations
local warnFraudDetected								= mod:NewCastAnnounce(464776, 4)
local warnShockandFlame								= mod:NewCountAnnounce(464772, 2)
local warnShockandBomb								= mod:NewCountAnnounce(464801, 3)
local warnFlameandBomb								= mod:NewCountAnnounce(464804, 3)
local warnExplosiveGaze								= mod:NewTargetAnnounce(465009, 2)
local warnFlameandCoin								= mod:NewCountAnnounce(464806, 2)
local warnCoinandShock								= mod:NewCountAnnounce(464809, 2)
local warnCoinandBomb								= mod:NewCountAnnounce(464810, 3)

local specWarnSpintoWin								= mod:NewSpecialWarningCount(461060, nil, nil, nil, 2, 2)
--local specWarnTravelingFlames 					= mod:NewSpecialWarningCount(474731, nil, nil, nil, 2, 2)--No usabe events
local specWarnExplosiveGaze							= mod:NewSpecialWarningRun(465009, nil, nil, nil, 1, 2)
local specWarnBurningBlast							= mod:NewSpecialWarningDodge(472178, nil, nil, nil, 2, 2)
--local specWarnCoinMagnet							= mod:NewSpecialWarningSpell(474665, nil, nil, nil, 2, 12)--No event to use for alerting it

local timerSpintoWinCD								= mod:NewVarCountTimer("v60.9-62.1", 461060, nil, nil, nil, 6)
local timerSpintoWin								= mod:NewBuffActiveTimer(30, 461060, nil, nil, nil, 6)

mod:AddNamePlateOption("NPAuraOnGaze", 465009, true)
--Reel Assistant
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30085))
local warnWitheringFlames						= mod:NewTargetNoFilterAnnounce(471930, 2)

local specWarnOverload							= mod:NewSpecialWarningInterruptCount(460582, "HasInterrupt", nil, nil, 1, 2)
local specWarnWitheringFlames					= mod:NewSpecialWarningMoveAway(471930, nil, nil, nil, 1, 2)
local yellWitheringFlames						= mod:NewShortYell(471930)
local yellWitheringFlamesFades					= mod:NewShortFadesYell(471930)

local timerOverloadCD							= mod:NewCDNPTimer(18.2, 460582, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)
local timerWitheringFlamesCD					= mod:NewCDNPTimer(18.2, 471930, nil, nil, nil, 3)
--local timerElectricBlastCD					= mod:NewCDNPTimer(3.7, 460847, nil, nil, nil, 3)--3.7-5.2

mod:AddNamePlateOption("NPAuraOnDLC", 460973, true)
--Boss
mod:AddTimerLine(DBM_COMMON_L.BOSS)
local warnCrushed								= mod:NewTargetNoFilterAnnounce(460430, 4)
local warnFoulExhaust							= mod:NewCountAnnounce(469993, 2)

local specWarnPayline							= mod:NewSpecialWarningCount(460181, nil, nil, nil, 2, 2)
local specWarnBigHit							= mod:NewSpecialWarningDefensive(460472, nil, nil, nil, 1, 2)
local specWarnBigHitTaunt						= mod:NewSpecialWarningTaunt(460472, nil, nil, nil, 1, 2)
local specWarnGTFO								= mod:NewSpecialWarningGTFO(460576, nil, nil, nil, 1, 8)

local timerPaylineCD							= mod:NewVarCountTimer("v31.6-36.5", 460181, nil, nil, nil, 3)
local timerFoulExhaustCD						= mod:NewVarCountTimer("v31.6-36.5", 469993, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerTheBigHitCD							= mod:NewVarCountTimer("v17.8-40.5", 460472, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--Stage Two: This Game Is Rigged!
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30086))
local warnPhase2								= mod:NewPhaseAnnounce(2, nil, nil, nil, nil, nil, nil, 2)
local warnLinkedMachines						= mod:NewCountAnnounce(465432, 2)--Forst cast
local warnExplosiveJackpot						= mod:NewCountAnnounce(465587, 4)--Berserk (Final cast)

local specWarnHotHotHot							= mod:NewSpecialWarningDodgeCount(465322, nil, nil, nil, 2, 2)--Second Cast
local specWarnScatteredPayout					= mod:NewSpecialWarningSwitchCount(465580, "Dps", nil, nil, 1, 2)--Third Cast

local timerLinkedMachinesCD						= mod:NewCDCountTimer(25.2, 465432, nil, nil, nil, 6)
local timerLinkedMachinesCast					= mod:NewCastTimer(7.5, 465432, 28405, nil, nil, 5)--Shorttext knockback
local timerHotHotHotCD							= mod:NewCDCountTimer(25.2, 465322, nil, nil, nil, 6)
local timerScatteredPayoutCD					= mod:NewCDCountTimer(25.2, 465580, nil, nil, nil, 6)
local timerExplosiveJackpotCD					= mod:NewCDCountTimer(25.2, 465587, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerExplosiveJackpot						= mod:NewCastTimer(10, 465587, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)

mod:AddPrivateAuraSoundOption(465325, true, 465322, 1)

mod.vb.spinCount = 0
mod.vb.paylineCount = 0
mod.vb.foulExhaustCount = 0
mod.vb.bigHitCount = 0
mod.vb.linkedCount = 0
local castsPerGUID = {}

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.spinCount = 0
	self.vb.paylineCount = 0
	self.vb.foulExhaustCount = 0
	self.vb.bigHitCount = 0
	table.wipe(castsPerGUID)
	timerPaylineCD:Start(string.format("v%s-%s", 2.9-delay, 4.1-delay), 1)
	timerFoulExhaustCD:Start(string.format("v%s-%s", 8.1-delay, 10-delay), 1)

	if self:IsMythic() then
		--Seem flipped on mythic (but could also be because of boss kiting)
		timerSpintoWinCD:Start(string.format("v%s-%s", 14.8-delay, 16.7-delay), 1)--15 placeholder
		timerTheBigHitCD:Start(string.format("v%s-%s", 18.1-delay, 20.6-delay), 1)
	else
		timerTheBigHitCD:Start(string.format("v%s-%s", 14.1-delay, 15.3-delay), 1)
		timerSpintoWinCD:Start(string.format("v%s-%s", 18.1-delay, 20.6-delay), 1)
	end
	self:EnablePrivateAuraSound(465325, "lineyou", 17)
	if self.Options.NPAuraOnGaze or self.Options.NPAuraOnDLC then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.NPAuraOnGaze or self.Options.NPAuraOnDLC then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 461060 then
		self.vb.spinCount = self.vb.spinCount + 1
		specWarnSpintoWin:Show(self.vb.spinCount)
		specWarnSpintoWin:Play("phasechange")
		if self:IsMythic() then
			timerSpintoWinCD:Start("v51-54.8", self.vb.spinCount+1)
		elseif self:IsHeroic() then
			timerSpintoWinCD:Start("v60.9-62.1", self.vb.spinCount+1)
		else
			timerSpintoWinCD:Start("v80.4-85.1", self.vb.spinCount+1)
		end
		--Stop other timers?
		--timerPaylineCD:Stop()
		--timerFoulExhaustCD:Stop()
		--timerTheBigHitCD:Stop()
	elseif spellId == 464806 or spellId == 464801 or spellId == 464804 or spellId == 464772 or spellId == 464809 or spellId == 464810 then
		if spellId == 464806 then
			warnFlameandCoin:Show(self.vb.spinCount)
		--	specWarnTravelingFlames:Show(self.vb.spellCount)
		--	specWarnTravelingFlames:Play("watchwave")
		elseif spellId == 464801 then
			warnShockandBomb:Show(self.vb.spinCount)
		elseif spellId == 464804 then
			warnFlameandBomb:Show(self.vb.spinCount)
		elseif spellId == 464772 then
			warnShockandFlame:Show(self.vb.spinCount)
		elseif spellId == 464809 then
			warnCoinandShock:Show(self.vb.spinCount)
		elseif spellId == 464810 then
			warnCoinandBomb:Show(self.vb.spinCount)
		end
		--Timers reset
		timerPaylineCD:Stop()
		timerFoulExhaustCD:Stop()
		timerTheBigHitCD:Stop()
		if spellId == 464806 then--Flame and coin has custom timers
			timerFoulExhaustCD:Start("v11.4-12.2", self.vb.foulExhaustCount+1)
			timerPaylineCD:Start("v17.5-24", self.vb.paylineCount+1)
			timerTheBigHitCD:Start("v23.6-28.9", self.vb.bigHitCount+1)
		else
			timerPaylineCD:Start("v4.4-5.2", self.vb.paylineCount+1)
			timerFoulExhaustCD:Start("v9.5-10.2", self.vb.foulExhaustCount+1)
			timerTheBigHitCD:Start("v14.9-16.3", self.vb.bigHitCount+1)
		end
	elseif spellId == 464776 then--Fraud Detected
		warnFraudDetected:Show()
		--Timers reset
		timerPaylineCD:Stop()
		timerFoulExhaustCD:Stop()
		timerTheBigHitCD:Stop()
		timerPaylineCD:Start(5.7, self.vb.paylineCount+1)
		timerFoulExhaustCD:Start(10.6, self.vb.foulExhaustCount+1)
		timerTheBigHitCD:Start(16.6, self.vb.bigHitCount+1)
	elseif spellId == 472178 then
		if self:CheckBossDistance(args.sourceGUID, false, 6450, 18) then
			specWarnBurningBlast:Show()
			specWarnBurningBlast:Play("watchstep")
		end
	elseif spellId == 460582 then
		timerOverloadCD:Start(nil, args.sourceGUID)
		if not castsPerGUID[args.sourceGUID] then--Shouldn't happen, but backup
			castsPerGUID[args.sourceGUID] = 0
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnOverload:Show(args.sourceName, count)
			if count == 1 then
				specWarnOverload:Play("kick1r")
			elseif count == 2 then
				specWarnOverload:Play("kick2r")
			elseif count == 3 then
				specWarnOverload:Play("kick3r")
			elseif count == 4 then
				specWarnOverload:Play("kick4r")
			elseif count == 5 then
				specWarnOverload:Play("kick5r")
			else
				specWarnOverload:Play("kickcast")
			end
		end
	elseif spellId == 471930 or spellId == 472197 then--471930 confirmed on heroic, 472197 unknown
		timerWitheringFlamesCD:Start(nil, args.sourceGUID)
	elseif spellId == 460181 then
		self.vb.paylineCount = self.vb.paylineCount + 1
		specWarnPayline:Show(self.vb.paylineCount)
		specWarnPayline:Play("specialsoon")
		--NOTE, Mythic reworked how timers work, so we have no idea what heroic and normal look like now
		--For now, we assume others are same
		if self:IsHard() and self:GetStage(1) then
			timerPaylineCD:Start("v26.0-27.1", self.vb.paylineCount+1)
		end
	elseif spellId == 469993 then
		self.vb.foulExhaustCount = self.vb.foulExhaustCount + 1
		warnFoulExhaust:Show(self.vb.foulExhaustCount)
		if self:GetStage(1) then
			--33.2 for all except flame and coin which makes it 36
			timerFoulExhaustCD:Start("v32.8-36.6", self.vb.foulExhaustCount+1)
		end
	elseif spellId == 460472 then
		self.vb.bigHitCount = self.vb.bigHitCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnBigHit:Show()
			specWarnBigHit:Play("defensive")
		end
		if self:GetStage(1) then
			timerTheBigHitCD:Start("v18.2-21.5", self.vb.bigHitCount+1)
		end
	elseif spellId == 465432 then
		self.vb.linkedCount = 1
		---@diagnostic disable-next-line: param-type-mismatch
		warnLinkedMachines:Show("1/4")
		timerLinkedMachinesCast:Start(7.5, self.vb.linkedCount)
		--new Phase Timers
		timerFoulExhaustCD:Start("v4.1-4.6", self.vb.foulExhaustCount+1)
		timerPaylineCD:Start("v10.2-10.7", self.vb.paylineCount+1)
		timerTheBigHitCD:Start(15.1, self.vb.bigHitCount+1)
		timerHotHotHotCD:Start(self:IsEasy() and 29.9 or 25.2, 2)
	elseif spellId == 465322 then
		---@diagnostic disable-next-line: param-type-mismatch
		specWarnHotHotHot:Show("2/4")
		specWarnHotHotHot:Play("farfromline")
		--new Phase Timers
		timerFoulExhaustCD:Start(4.5, self.vb.foulExhaustCount+1)
		timerTheBigHitCD:Start(10.7, self.vb.bigHitCount+1)
		timerPaylineCD:Start(16.7, self.vb.paylineCount+1)
		timerScatteredPayoutCD:Start(self:IsEasy() and 29.9 or 25.2, 3)
	elseif spellId == 465580 then
		---@diagnostic disable-next-line: param-type-mismatch
		specWarnScatteredPayout:Show("3/4")
		specWarnScatteredPayout:Play("targetchange")
		--new Phase Timers
		timerTheBigHitCD:Start(3.4, self.vb.bigHitCount+1)
		timerFoulExhaustCD:Start(9.4, self.vb.foulExhaustCount+1)
		timerPaylineCD:Start(17.9, self.vb.paylineCount+1)
		timerExplosiveJackpotCD:Start(self:IsEasy() and 29.9 or 25.2, 2)
	elseif spellId == 465587 then
		---@diagnostic disable-next-line: param-type-mismatch
		warnExplosiveJackpot:Show("4/4")
		timerExplosiveJackpot:Start()
	--"<393.42 21:30:17> [CLEU] SPELL_CAST_SUCCESS#Vehicle-0-5769-2769-2058-228458-00000ABC32#One-Armed Bandit(35.1%-100.0%)##nil#465765#Maintenance Cycle#nil#nil#nil#nil#nil#nil",
	--"<400.42 21:30:24> [CLEU] SPELL_CAST_START#Vehicle-0-5769-2769-2058-228458-00000ABC32#One-Armed Bandit(34.7%-0.0%)##nil#465761#Rig the Game!#nil#nil#nil#nil#nil#nil",
	elseif spellId == 465761 and self:GetStage(1) then--Rig the game (stage 2 trigger)
		--Disabled resetting for now to match BW/Weak auras
		self.vb.paylineCount = 0
		self.vb.foulExhaustCount = 0
		self.vb.bigHitCount = 0
		self:SetStage(2)
		warnPhase2:Show()
		warnPhase2:Play("ptwo")
		--Timer reset
		timerSpintoWinCD:Stop()
		timerPaylineCD:Stop()
		timerFoulExhaustCD:Stop()
		timerTheBigHitCD:Stop()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 465765 and self:GetStage(1) then--Maintenance Cycle (stage 2 pre-trigger)
		--Disabled resetting for now to match BW/Weak auras
		self.vb.spinCount = 0
		self.vb.paylineCount = 0
		self.vb.foulExhaustCount = 0
		self.vb.bigHitCount = 0
		self:SetStage(2)
		warnPhase2:Show()
		warnPhase2:Play("ptwo")
		--Timer reset
		timerSpintoWinCD:Stop()
		timerPaylineCD:Stop()
		timerFoulExhaustCD:Stop()
		timerTheBigHitCD:Stop()
		timerLinkedMachinesCD:Start(13.3, 1)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 461060 then--Spin to win on main boss
		timerSpintoWin:Start(self:IsEasy() and 35 or 30)
	elseif spellId == 471720 then--Spin to win on adds
		if not castsPerGUID[args.destGUID] then
			castsPerGUID[args.destGUID] = 0
			timerWitheringFlamesCD:Start(12.6, args.destGUID)--If it's not cast before overload, gets delayed by several seconds
			timerOverloadCD:Start(15, args.destGUID)
		end
	elseif spellId == 472832 then
		warnTokenCoin:Show(args.destName)
	elseif spellId == 472837 then
		warnTokenBomb:Show(args.destName)
	elseif spellId == 472828 then
		warnTokenFlame:Show(args.destName)
	elseif spellId == 472783 then
		warnTokenShock:Show(args.destName)
	elseif spellId == 465009 then
		warnExplosiveGaze:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnExplosiveGaze:Show()
			specWarnExplosiveGaze:Play("justrun")
			if self.Options.NPAuraOnGaze then
				DBM.Nameplate:Show(true, args.sourceGUID, spellId, nil, nil, nil, true)
			end
		end
	elseif spellId == 460973 then
		if self.Options.NPAuraOnDLC then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 473278 or spellId == 471927 then
		warnWitheringFlames:CombinedShow(0.3, args.destName)--2 targets on hard and 1 target on non hard?
		if args:IsPlayer() then
			specWarnWitheringFlames:Show()
			specWarnWitheringFlames:Play("runout")
			yellWitheringFlames:Yell()
			yellWitheringFlamesFades:Countdown(spellId)
		end
	elseif spellId == 460430 then
		warnCrushed:CombinedShow(1, args.destName)
	elseif spellId == 460472 and not args:IsPlayer() then
		specWarnBigHitTaunt:Show(args.destName)
		specWarnBigHitTaunt:Play("tauntboss")
	elseif spellId == 473195 then
		self.vb.linkedCount = self.vb.linkedCount + 1
		timerLinkedMachinesCast:Start(10, self.vb.linkedCount)
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REFRESH(args)
	local spellId = args.spellId
	if spellId == 473195 then
		self.vb.linkedCount = self.vb.linkedCount + 1
		timerLinkedMachinesCast:Start(10, self.vb.linkedCount)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 461060 then--461060 is boss and 471720 is reel assistants
		timerSpintoWin:Stop()
	elseif spellId == 465009 then
		if args:IsPlayer() then
			if self.Options.NPAuraOnGaze then
				DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
			end
		end
	elseif spellId == 460973 then
		if self.Options.NPAuraOnDLC then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 473278 or spellId == 471927 then
		if args:IsPlayer() then
			yellWitheringFlamesFades:Cancel()
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 460576 and destGUID == UnitGUID("player") and self:AntiSpam(2.5, 3) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 234211 or cid == 228463 or cid == 232599 then--Reel Assistant
		timerOverloadCD:Stop(args.destGUID)
		timerWitheringFlamesCD:Stop(args.destGUID)
	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED_UNFILTERED(uId, _, spellId)
	if spellId == 1217551 and self:AntiSpam(5, 1) then--Coin magnet
		specWarnCoinMagnet:Show()
		specWarnCoinMagnet:Play("pullin")
	end
end
--]]
