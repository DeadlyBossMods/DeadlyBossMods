if DBM:GetTOC() < 110100 then return end
local mod	= DBM:NewMod(2644, "DBM-Raids-WarWithin", 1, 1296)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(228458)
mod:SetEncounterID(3014)
--mod:SetHotfixNoticeRev(20240921000000)
--mod:SetMinSyncRevision(20240921000000)
mod:SetZone(2769)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 461060 464806 464801 464804 472178 464772 464809 464810 460582 471930 472197 460847 460181 469993 460472 465432 465322 465580 465587",
	"SPELL_CAST_SUCCESS 465309",
	"SPELL_AURA_APPLIED 461060 471720 472832 472837 472828 472783 461068 465009 460973 473278 471927 460430 460472",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 461060 471720 465009 460973 473278 471927",
	"SPELL_PERIODIC_DAMAGE 460576",
	"SPELL_PERIODIC_MISSED 460576",
	"UNIT_DIED",
--	"CHAT_MSG_RAID_BOSS_WHISPER",
	"UNIT_SPELLCAST_SUCCEEDED_UNFILTERED"
)

--TODO, is 20 second variant of spin to win even used?
--TODO, are token buffs enemy buffs or player buffs
--TODO, mark token holders with red, blue, orange, and skull?
--TODO, revise audio as needed
--TODO, clean way to alert wave warning for Traveling Flames mechanics
--TODO, auto mark bombs with https://www.wowhead.com/ptr-2/spell=461176/reward-flame-and-bomb ?
--TODO, detect coin magnet correctly
--TODO, Reel nameplate timers
--TODO, add https://www.wowhead.com/ptr-2/spell=464705/golden-ticket stack tracker? probably not really needed
--TODO, detect payline targets
--TODO, record new payline audio (based on if we can detect it or not)
--TODO, more work on phase 2 with context
--Stage One: That's RNG, Baby!
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30083))
local warnTokenCoin									= mod:NewTargetNoFilterAnnounce(472832, 1)
local warnTokenBomb									= mod:NewTargetNoFilterAnnounce(472837, 1)
local warnTokenFlame								= mod:NewTargetNoFilterAnnounce(472828, 1)
local warnTokenShock								= mod:NewTargetNoFilterAnnounce(472783, 1)
local warnFraudDetected								= mod:NewTargetNoFilterAnnounce(461068, 4)
local warnShockandFlame								= mod:NewCountAnnounce(464772, 2)
local warnShockandBomb								= mod:NewCountAnnounce(464801, 3)
local warnFlameandBomb								= mod:NewCountAnnounce(464804, 3)
local warnExplosiveGaze								= mod:NewTargetAnnounce(465009, 2)
local warnFlameandCoin								= mod:NewCountAnnounce(464806, 2)
local warnCoinandShock								= mod:NewCountAnnounce(464809, 2)
local warnCoinandBomb								= mod:NewCountAnnounce(464810, 3)

local specWarnSpintoWin								= mod:NewSpecialWarningCount(461060, nil, nil, nil, 2, 2)
--local specWarnTravelingFlames 					= mod:NewSpecialWarningCount(474731, nil, nil, nil, 2, 2)
local specWarnExplosiveGaze							= mod:NewSpecialWarningRun(465009, nil, nil, nil, 1, 2)
local specWarnBurningBlast							= mod:NewSpecialWarningDodge(472178, nil, nil, nil, 2, 2)
local specWarnCoinMagnet							= mod:NewSpecialWarningSpell(474665, nil, nil, nil, 2, 12)

local timerSpintoWinCD								= mod:NewAITimer(97.3, 461060, nil, nil, nil, 6)
local timerSpintoWin								= mod:NewBuffActiveTimer(30, 461060, nil, nil, nil, 6)

mod:AddNamePlateOption("NPAuraOnGaze", 465009, true)
--Reel Assistant
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30085))
local warnWitheringFlames						= mod:NewTargetNoFilterAnnounce(471930, 2)

local specWarnOverload							= mod:NewSpecialWarningInterruptCount(460582, "HasInterrupt", nil, nil, 1, 2)
local specWarnWitheringFlames					= mod:NewSpecialWarningMoveAway(471930, nil, nil, nil, 1, 2)
local yellWitheringFlames						= mod:NewShortYell(471930)
local yellWitheringFlamesFades					= mod:NewShortFadesYell(471930)

--local timerWitheringFlamesCD					= mod:NewCDNPTimer(97.3, 471930, nil, nil, nil, 3)
--local timerElectricBlastCD					= mod:NewCDNPTimer(20.5, 460847, nil, nil, nil, 3)

mod:AddNamePlateOption("NPAuraOnDLC", 460973, true)
--Boss
mod:AddTimerLine(DBM_COMMON_L.BOSS)
local warnCrushed								= mod:NewTargetNoFilterAnnounce(460430, 4)
local warnFoulExhaust							= mod:NewCountAnnounce(469993, 2)

local specWarnPayline							= mod:NewSpecialWarningCount(460181, nil, nil, nil, 2, 2)
local specWarnBigHit							= mod:NewSpecialWarningDefensive(460472, nil, nil, nil, 1, 2)
local specWarnBigHitTaunt						= mod:NewSpecialWarningTaunt(460472, nil, nil, nil, 1, 2)
local specWarnGTFO								= mod:NewSpecialWarningGTFO(460576, nil, nil, nil, 1, 8)

local timerPaylineCD							= mod:NewAITimer(97.3, 460181, nil, nil, nil, 3)
local timerFoulExhaustCD						= mod:NewAITimer(97.3, 469993, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerTheBigHitCD							= mod:NewAITimer(97.3, 460472, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--Stage Two: This Game Is Rigged!
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30086))
local warnPhase2								= mod:NewPhaseAnnounce(2, nil, nil, nil, nil, nil, nil, 2)
local warnLinkedMachines						= mod:NewCountAnnounce(465432, 2)
local warnHotHotHeat							= mod:NewIncomingCountAnnounce(465322, 2)
local warnExplosiveJackpot						= mod:NewCastAnnounce(465587, 4)--Berserk

local specWarnScatteredPayout					= mod:NewSpecialWarningSwitch(465580, "Dps", nil, nil, 1, 2)

local timerCheatToWinCD							= mod:NewAITimer(97.3, 465309, nil, nil, nil, 6)
local timerExplosiveJackpot						= mod:NewCastTimer(30, 465587, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)

mod:AddPrivateAuraSoundOption(465325, true, 465322, 1)

mod.vb.spinCount = 0
mod.vb.paylineCount = 0
mod.vb.foulExhaustCount = 0
mod.vb.bigHitCount = 0
--mod.vb.linkedCount = 0
--mod.vb.hotHotHeatCount = 0
local castsPerGUID = {}

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.spinCount = 0
	self.vb.paylineCount = 0
	self.vb.foulExhaustCount = 0
	self.vb.bigHitCount = 0
	self.vb.linkedCount = 0
	self.vb.hotHotHeatCount = 0
	table.wipe(castsPerGUID)
	timerSpintoWinCD:Start(1-delay)
	timerPaylineCD:Start(1-delay)
	timerFoulExhaustCD:Start(1-delay)
	timerTheBigHitCD:Start(1-delay)
	self:EnablePrivateAuraSound(465325, "flameyou", 15)
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
		timerSpintoWinCD:Start()--nil, self.vb.spinCount+1
		--Stop other timers?
		timerPaylineCD:Stop()
		timerFoulExhaustCD:Stop()
		timerTheBigHitCD:Stop()
	elseif spellId == 464806 then
		warnFlameandCoin:Show(self.vb.spinCount)
	--	specWarnTravelingFlames:Show(self.vb.spellCount)
	--	specWarnTravelingFlames:Play("watchwave")
	elseif spellId == 464801 then
		warnShockandBomb:Show(self.vb.spinCount)
		warnShockandBomb:Play("killmob")
	elseif spellId == 464804 then
		warnFlameandBomb:Show(self.vb.spinCount)
	elseif spellId == 472178 then
		if self:CheckBossDistance(args.sourceGUID, false, 6450, 18) then
			specWarnBurningBlast:Show()
			specWarnBurningBlast:Play("watchstep")
		end
	elseif spellId == 464772 then
		warnShockandFlame:Show(self.vb.spinCount)
	elseif spellId == 464809 then
		warnCoinandShock:Show(self.vb.spinCount)
	elseif spellId == 464810 then
		warnCoinandBomb:Show(self.vb.spinCount)
	elseif spellId == 460582 then
		if not castsPerGUID[args.sourceGUID] then
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
	elseif spellId == 471930 or spellId == 472197 then
--		timerWitheringFlamesCD:Start(nil, args.sourceGUID)
	elseif spellId == 460847 then
--		timerElectricBlastCD:Start(nil, args.sourceGUID)
	elseif spellId == 460181 then
		self.vb.paylineCount = self.vb.paylineCount + 1
		specWarnPayline:Show(self.vb.paylineCount)
		specWarnPayline:Play("specialsoon")
		timerPaylineCD:Start()--nil, self.vb.paylineCount+1
	elseif spellId == 469993 then
		self.vb.foulExhaustCount = self.vb.foulExhaustCount + 1
		warnFoulExhaust:Show(self.vb.foulExhaustCount)
		timerFoulExhaustCD:Start()--nil, self.vb.foulExhaustCount+1
	elseif spellId == 460472 then
		self.vb.bigHitCount = self.vb.bigHitCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnBigHit:Show()
			specWarnBigHit:Play("defensive")
		end
		timerTheBigHitCD:Start()--nil, self.vb.bigHitCount+1
	elseif spellId == 465432 then
		self.vb.linkedCount = self.vb.linkedCount + 1
		warnLinkedMachines:Show(self.vb.linkedCount)
	elseif spellId == 465322 then
		self.vb.hotHotHeatCount = self.vb.hotHotHeatCount + 1
		warnHotHotHeat:Show(self.vb.hotHotHeatCount)
	elseif spellId == 465580 then
		specWarnScatteredPayout:Show()
		specWarnScatteredPayout:Play("targetchange")
	elseif spellId == 465587 then
		warnExplosiveJackpot:Show()
		timerExplosiveJackpot:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 465309 then
		if self:GetStage(1) then
			self.vb.spinCount = 0
			self.vb.paylineCount = 0
			self.vb.foulExhaustCount = 0
			self.vb.bigHitCount = 0
			self.vb.linkedCount = 0
			self.vb.hotHotHeatCount = 0
			self:SetStage(2)
			warnPhase2:Show()
			warnPhase2:Play("ptwo")
			--Timer reset?
			timerSpintoWinCD:Stop()
			timerPaylineCD:Stop()
			timerFoulExhaustCD:Stop()
			timerTheBigHitCD:Stop()
			timerPaylineCD:Start(3)
			timerFoulExhaustCD:Start(3)
			timerTheBigHitCD:Start(3)
			timerCheatToWinCD:Start(3)
		end
		self.vb.spinCount = self.vb.spinCount + 1
		timerCheatToWinCD:Start()--nil, self.vb.spinCount+1
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 461060 or spellId == 471720 then--CHECK for SPAM
		timerSpintoWin:Start(spellId == 471720 and 20 or 30)
	elseif spellId == 472832 then
		warnTokenCoin:Show(args.destName)
	elseif spellId == 472837 then
		warnTokenBomb:Show(args.destName)
	elseif spellId == 472828 then
		warnTokenFlame:Show(args.destName)
	elseif spellId == 472783 then
		warnTokenShock:Show(args.destName)
	elseif spellId == 461068 then
		warnFraudDetected:Show(args.destName)
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
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 461060 or spellId == 471720 then
		timerSpintoWin:Stop()
		--restart boss timers?
		timerPaylineCD:Start(2)
		timerFoulExhaustCD:Start(2)
		timerTheBigHitCD:Start(2)
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
		--timerWitheringFlamesCD:Stop(args.destGUID)
		--timerElectricBlastCD:Stop(args.destGUID)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED_UNFILTERED(uId, _, spellId)
	if spellId == 1217551 and self:AntiSpam(5, 1) then--Coin magnet
		specWarnCoinMagnet:Show()
		specWarnCoinMagnet:Play("pullin")
	end
end
