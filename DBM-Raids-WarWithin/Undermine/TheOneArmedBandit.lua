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
	"SPELL_AURA_APPLIED 461060 471720 472832 472837 472828 472783 465009 460973 473278 471927 460430 460472 473195 460444 461068",
	"SPELL_AURA_REFRESH 473195",
	"SPELL_AURA_REMOVED 461060 471720 465009 460973 473278 471927",
	"SPELL_PERIODIC_DAMAGE 460576",
	"SPELL_PERIODIC_MISSED 460576",
	"UNIT_DIED"
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
or ability.id = 473195 and (type = "applybuff" or type = "refreshbuff")
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
local warnFraudDetected								= mod:NewCastAnnounce(461068, 4)
local warnShockandFlame								= mod:NewCountAnnounce(464772, 2)
local warnShockandBomb								= mod:NewCountAnnounce(464801, 3)
local warnFlameandBomb								= mod:NewCountAnnounce(464804, 3)
local warnExplosiveGaze								= mod:NewTargetAnnounce(465009, 2)
local warnFlameandCoin								= mod:NewCountAnnounce(464806, 2)
local warnCoinandShock								= mod:NewCountAnnounce(464809, 2)
local warnCoinandBomb								= mod:NewCountAnnounce(464810, 3)

local specWarnTokenCoin								= mod:NewSpecialWarningYou(472832, nil, nil, nil, 1, 18)
local specWarnTokenBomb								= mod:NewSpecialWarningYou(472837, nil, nil, nil, 1, 12)
local specWarnTokenFlame							= mod:NewSpecialWarningYou(472828, nil, nil, nil, 1, 15)
local specWarnTokenShock							= mod:NewSpecialWarningYou(472783, nil, nil, nil, 1, 18)
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
local warnWitheringFlames						= mod:NewTargetNoFilterAnnounce(471927, 2)

local specWarnOverload							= mod:NewSpecialWarningInterruptCount(460582, "HasInterrupt", nil, nil, 1, 2)
local specWarnWitheringFlames					= mod:NewSpecialWarningMoveAway(471927, nil, nil, nil, 1, 2)
local yellWitheringFlames						= mod:NewShortYell(471927)
local yellWitheringFlamesFades					= mod:NewShortFadesYell(471927)

local timerOverloadCD							= mod:NewCDNPTimer(17, 460582, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)
local timerWitheringFlamesCD					= mod:NewCDNPTimer(18.2, 471927, nil, nil, nil, 3)
--local timerElectricBlastCD					= mod:NewCDNPTimer(3.7, 460847, nil, nil, nil, 3)--3.7-5.2

mod:AddNamePlateOption("NPAuraOnDLC", 460973, true)
--Boss
mod:AddTimerLine(DBM_COMMON_L.BOSS)
local warnCrushed								= mod:NewTargetNoFilterAnnounce(460430, 4, nil, false, 2)
local warnFoulExhaust							= mod:NewCountAnnounce(469993, 2)
local warnHighRoller							= mod:NewYouAnnounce(460444, 1)

local specWarnPayline							= mod:NewSpecialWarningCount(460181, nil, nil, nil, 2, 2)
local specWarnBigHit							= mod:NewSpecialWarningDefensive(460472, nil, nil, nil, 1, 2)
local specWarnBigHitRunOut						= mod:NewSpecialWarningMoveTo(460472, nil, nil, nil, 1, 2)
local specWarnBigHitTaunt						= mod:NewSpecialWarningTaunt(460472, nil, nil, nil, 1, 2)
local specWarnGTFO								= mod:NewSpecialWarningGTFO(460576, nil, nil, nil, 1, 8)

local timerPaylineCD							= mod:NewVarCountTimer("v31.6-36.5", 460181, nil, nil, nil, 3)
local timerFoulExhaustCD						= mod:NewVarCountTimer("v31.6-36.5", 469993, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerTheBigHitCD							= mod:NewVarCountTimer("v17.8-40.5", 460472, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--Stage Two: This Game Is Rigged!
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30086))
local warnPhase2								= mod:NewPhaseAnnounce(2, nil, nil, nil, nil, nil, nil, 2)
local warnCheatToWin							= mod:NewCountAnnounce(465309, 4)
--local warnLinkedMachines						= mod:NewCountAnnounce(465432, 2)--Forst cast
--local warnExplosiveJackpot					= mod:NewCountAnnounce(465587, 4)--Berserk (Final cast)

local specWarnHotHotHot							= mod:NewSpecialWarningDodge(465322, nil, nil, nil, 2, 2)--Second Cast
local specWarnScatteredPayout					= mod:NewSpecialWarningSwitch(465580, "Dps", nil, nil, 1, 2)--Third Cast

local timerLinkedMachinesCD						= mod:NewCDCountTimer(25.2, 473195, L.BaitCoil.." %s)", nil, nil, 6)
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
mod.vb.secondExhaustOccurred = 0
local castsPerGUID = {}
local knockback = DBM:GetSpellName(28405)

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.spinCount = 0
	self.vb.paylineCount = 0
	self.vb.foulExhaustCount = 0
	self.vb.bigHitCount = 0
	self.vb.secondExhaustOccurred = 0
	table.wipe(castsPerGUID)
	timerPaylineCD:Start(string.format("v%s-%s", 2.9-delay, 4.8-delay), 1)
	timerFoulExhaustCD:Start(string.format("v%s-%s", 8.1-delay, 10-delay), 1)
	if self:IsMythic() then
		--Seem flipped on mythic (but could also be because of boss kiting)
		timerSpintoWinCD:Start(string.format("v%s-%s", 14.8-delay, 16.7-delay), 1)
		timerTheBigHitCD:Start(string.format("v%s-%s", 18.1-delay, 20.6-delay), 1)
	else
		timerTheBigHitCD:Start(string.format("v%s-%s", 10.8-delay, 15.6-delay), 1)
		timerSpintoWinCD:Start(string.format("v%s-%s", 17.3-delay, 20.6-delay), 1)
	end
	self:EnablePrivateAuraSound(465325, "lineyou", 17)
	if self.Options.NPAuraOnGaze or self.Options.NPAuraOnDLC then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd(_, _, secondRun)
	if self.Options.NPAuraOnGaze or self.Options.NPAuraOnDLC then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
	if secondRun then self:Stop() end--Stop all timers in a second run of combat end to try and fix bugged timers
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
			timerSpintoWinCD:Start("v60.9-63.4", self.vb.spinCount+1)
		else
			timerSpintoWinCD:Start("v78.6-86.7", self.vb.spinCount+1)
		end
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
		if spellId == 464806 then--Flame and Coin has unique sequence
			if self:IsMythic() then
				timerPaylineCD:Start(16.4, self.vb.paylineCount+1)
				timerTheBigHitCD:Start("v22.7-23.1", self.vb.bigHitCount+1)
				timerFoulExhaustCD:Start("v16.6-18.9", self.vb.foulExhaustCount+1)
			elseif self:IsHeroic() or self:IsLFR() then--Heroic/LFR swaps payline and bighit compared to normal
				timerPaylineCD:Start("v11.1-11.8", self.vb.paylineCount+1)
				timerFoulExhaustCD:Start("v16.0-16.7", self.vb.foulExhaustCount+1)
				timerTheBigHitCD:Start("v22.1-23", self.vb.bigHitCount+1)
			else
				timerTheBigHitCD:Start("v11.9-13.1", self.vb.bigHitCount+1)
				timerFoulExhaustCD:Start("v16.6-18.9", self.vb.foulExhaustCount+1)
				timerPaylineCD:Start("v24-25.2", self.vb.paylineCount+1)
			end
		else
			if self:IsMythic() then
				timerPaylineCD:Start(5, self.vb.paylineCount+1)
				timerFoulExhaustCD:Start("v9.5-9.9", self.vb.foulExhaustCount+1)
				timerTheBigHitCD:Start("v16.0-16.7", self.vb.bigHitCount+1)
			elseif self:IsHeroic() or self:IsLFR() then
				timerPaylineCD:Start("v5.9-7", self.vb.paylineCount+1)
				timerFoulExhaustCD:Start("v10.4-11.8", self.vb.foulExhaustCount+1)
				timerTheBigHitCD:Start("v16.4-18", self.vb.bigHitCount+1)
			else
				timerFoulExhaustCD:Start("v9.5-10.7", self.vb.foulExhaustCount+1)
				timerTheBigHitCD:Start("v15.5-16.7", self.vb.bigHitCount+1)
				timerPaylineCD:Start("v21.6-22.6", self.vb.paylineCount+1)
			end
		end
	elseif spellId == 464776 then--Fraud Detected
		warnFraudDetected:Show()
		--Timers reset, it's a wipe anyways so we don't bother to restart them
		timerPaylineCD:Stop()
		timerFoulExhaustCD:Stop()
		timerTheBigHitCD:Stop()
	elseif spellId == 472178 then
		if self:AntiSpam(8, 1) then
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
		--Heroic sees massive variation
		if self:IsHard() and self:GetStage(1) then
			timerPaylineCD:Start(self:IsMythic() and 26.7 or "v31.6-42.8", self.vb.paylineCount+1)
		end
	elseif spellId == 469993 then
		self.vb.foulExhaustCount = self.vb.foulExhaustCount + 1
		warnFoulExhaust:Show(self.vb.foulExhaustCount)
		if self:GetStage(1) then
			timerFoulExhaustCD:Start(self:IsMythic() and "v32.9-34" or "v30.6-32.9", self.vb.foulExhaustCount+1)
		--Custom condition where it gets a 2nd cast due to CD of cheat to win being 30 instead of 25
		elseif self:GetStage(2) and self:IsEasy() and self.vb.spinCount == 2 then
			timerFoulExhaustCD:Start("v25.5", self.vb.foulExhaustCount+1)
			self.vb.secondExhaustOccurred = self.vb.secondExhaustOccurred + 1
		end
	elseif spellId == 460472 then
		self.vb.bigHitCount = self.vb.bigHitCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnBigHit:Show()
			specWarnBigHit:Play("defensive")
		end
		if self:GetStage(1) then
			--Subject to long skips on heroic especially if boss is kited about (which is the normal strat)
			timerTheBigHitCD:Start(self:IsMythic() and 20.6 or "v18.6-32.9", self.vb.bigHitCount+1)
		elseif self:GetStage(2) and self.vb.spinCount == 3 then
			timerTheBigHitCD:Start(18.2, self.vb.bigHitCount+1)
		end
	elseif spellId == 465432 then
		self.vb.linkedCount = 1
		self.vb.spinCount = 1
		---@diagnostic disable-next-line: param-type-mismatch
		warnCheatToWin:Show("1/4".." "..knockback)
		timerLinkedMachinesCD:Start(3.8, self.vb.linkedCount)--Bait
		timerLinkedMachinesCast:Start(6.8, self.vb.linkedCount)--Knockback
		--new Phase Timers
		timerFoulExhaustCD:Start("v4.1-4.6", self.vb.foulExhaustCount+1)
		timerPaylineCD:Start("v10.2-10.7", self.vb.paylineCount+1)
		timerTheBigHitCD:Start("v15.1-15.6", self.vb.bigHitCount+1)
		timerHotHotHotCD:Start(self:IsEasy() and "v29.9-31.6" or "v24.3-25.2", 2)
	elseif spellId == 465322 then
		self.vb.spinCount = 2
		---@diagnostic disable-next-line: param-type-mismatch
		warnCheatToWin:Show("2/4".." "..DBM_COMMON_L.DEBUFFS)
		specWarnHotHotHot:Show()
		specWarnHotHotHot:Play("farfromline")
		--new Phase Timers
		timerFoulExhaustCD:Stop()--Just to cancel run over from the custom 2nd cast between linked and hot
		--On normal and LFR, it's possible to get two exhausts between linked and hot, if so, we'll get a long timer, else it'll be short one
		timerFoulExhaustCD:Start((self.vb.secondExhaustOccurred == 2) and 28.8 or self:IsHard() and "v4.6-5.8" or "v3.3-4.4", self.vb.foulExhaustCount+1)
		timerTheBigHitCD:Start(self:IsMythic() and 11.9 or "v4.6-10.7", self.vb.bigHitCount+1)--This one gets a little screwed up
		timerPaylineCD:Start(self:IsHard() and "v21.6-22.9" or "v15.5-18", self.vb.paylineCount+1)
		timerScatteredPayoutCD:Start(self:IsEasy() and 29.9 or 25.2, 3)
	elseif spellId == 465580 then
		self.vb.spinCount = 3
		---@diagnostic disable-next-line: param-type-mismatch
		warnCheatToWin:Show("3/4".." "..DBM_COMMON_L.AOEDAMAGE)
		specWarnScatteredPayout:Show()
		specWarnScatteredPayout:Play("targetchange")
		--new Phase Timers 10.7-14.3
		timerTheBigHitCD:Start(self:IsHard() and "v3.3-5.8" or "v10.7-14.3", self.vb.bigHitCount+1)
		--again, on normal if 2 exhausts occured before hot, the it's a longer timer here too, else very short. Heroic and mythic more consistent in their 9-11 sec range
		timerFoulExhaustCD:Start(self:IsMythic() and "v10.7-11.9" or self:IsHeroic() and "v9.4-10.6" or (self.vb.secondExhaustOccurred == 2) and 26.4 or "v3.3-4.4", self.vb.foulExhaustCount+1)
		timerPaylineCD:Start(21.6, self.vb.paylineCount+1)--Mythic and heroic Unknown
		timerExplosiveJackpotCD:Start(self:IsEasy() and 29.9 or 25.2, 2)
	elseif spellId == 465587 then
		self.vb.spinCount = 4
		---@diagnostic disable-next-line: param-type-mismatch
		warnCheatToWin:Show("4/4")
		timerTheBigHitCD:Stop()
		timerFoulExhaustCD:Stop()
		timerPaylineCD:Stop()
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
		timerLinkedMachinesCD:Start(12.9, 1)
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
		if args:IsPlayer() then
			specWarnTokenCoin:Show()
			specWarnTokenCoin:Play("coinyou")
		else
			warnTokenCoin:Show(args.destName)
		end
	elseif spellId == 472837 then
		if args:IsPlayer() then
			specWarnTokenBomb:Show()
			specWarnTokenBomb:Play("bombyou")
		else
			warnTokenBomb:Show(args.destName)
		end
	elseif spellId == 472828 then
		if args:IsPlayer() then
			specWarnTokenFlame:Show()
			specWarnTokenFlame:Play("flameyou")
		else
			warnTokenFlame:Show(args.destName)
		end
	elseif spellId == 472783 then
		if args:IsPlayer() then
			specWarnTokenShock:Show()
			specWarnTokenShock:Play("shockyou")
		else
			warnTokenShock:Show(args.destName)
		end
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
	elseif spellId == 460472 then
		if args:IsPlayer() then
			specWarnBigHitRunOut:Show(DBM_COMMON_L.EDGE)
			specWarnBigHitRunOut:Play("runtoedge")
		else
			specWarnBigHitTaunt:Show(args.destName)
			specWarnBigHitTaunt:Play("tauntboss")
		end
	elseif spellId == 473195 then
		self.vb.linkedCount = self.vb.linkedCount + 1
		timerLinkedMachinesCD:Start(15, self.vb.linkedCount+1)--Bait timer
		timerLinkedMachinesCast:Start(18, self.vb.linkedCount+1)--Knockback timer
	elseif spellId == 460444 and args:IsPlayer() then
		warnHighRoller:Show()
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REFRESH(args)
	local spellId = args.spellId
	if spellId == 473195 then
		self.vb.linkedCount = self.vb.linkedCount + 1
		timerLinkedMachinesCD:Start(15, self.vb.linkedCount+1)--Bait timer
		timerLinkedMachinesCast:Start(18, self.vb.linkedCount+1)--Knockback timer
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
