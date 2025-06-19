local mod	= DBM:NewMod(2599, "DBM-Raids-WarWithin", 3, 1273)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(214503)
mod:SetEncounterID(2898)
mod:SetHotfixNoticeRev(20240921000000)
mod:SetMinSyncRevision(20240921000000)
mod:SetZone(2657)
mod.respawnTime = 29

mod:RegisterCombat("combat")
mod:DisableRegenDetection()--He returns true to UnitAffectingCombat when fighting his trash for some reason, triggering false combat detection if scanning PLAYER_REGEN_DISABLED
mod.disableHealthCombat = true--^^

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 456420 435401 432965 435403 439559 453258 442428",
	"SPELL_CAST_SUCCESS 439559 453258 433475",
	"SPELL_AURA_APPLIED 459273 438845 435410 439191 459785",--433517
	"SPELL_AURA_APPLIED_DOSE 459273 438845",
	"SPELL_AURA_REMOVED 459273 439191",--433517
	"SPELL_PERIODIC_DAMAGE 459785",
	"SPELL_PERIODIC_MISSED 459785"
)

--TODO, GTFO for rain of arrows with correct ID
--NOTE, As predicted, phase blades was made a private aura
--TODO, change option keys to match BW for weak aura compatability before live
--[[
(ability.id = 456420 or ability.id = 435401 or ability.id = 432965 or ability.id = 435403 or ability.id = 439559 or ability.id = 453258 or ability.id = 442428) and type = "begincast"
 or ability.id = 433517 and type = "applydebuff"
--]]
local warnCosmicShards							= mod:NewCountAnnounce(459273, 4, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(459273))--Player
local warnPhaseBlades							= mod:NewIncomingCountAnnounce(433517, 3, nil, nil, 100)
local warnDecimate								= mod:NewIncomingCountAnnounce(442428, 3)

local specWarnRainofArrows						= mod:NewSpecialWarningDodgeCount(439559, nil, nil, nil, 2, 2)
local specWarnShatteringSweep					= mod:NewSpecialWarningRunCount(456420, nil, 394017, nil, 4, 2)
local specWarnExpose							= mod:NewSpecialWarningDefensive(435401, nil, nil, nil, 1, 2)
local specWarnPhaseLunge						= mod:NewSpecialWarningDefensive(435403, nil, nil, nil, 1, 2)
local specWarnExposedWeakness					= mod:NewSpecialWarningTaunt(438845, nil, nil, nil, 1, 2)
local specWarnPiercedDefenses					= mod:NewSpecialWarningTaunt(435410, nil, nil, nil, 1, 2)
local specWarnGTFO								= mod:NewSpecialWarningGTFO(459785, nil, nil, nil, 1, 8)

local timerShatteringSweepCD					= mod:NewCDCountTimer(97.3, 456420, 394017, nil, nil, 2)--Shortname "Sweep"
local timerCosmicShards							= mod:NewBuffFadesTimer(6, 459273, nil, nil, nil, 5)
local timerCaptainsFlourishCD					= mod:NewCDCountTimer(22, 439511, DBM_COMMON_L.TANKCOMBO.." (%s)", "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerPhaseBladesCD						= mod:NewCDCountTimer(42.6, 433517, 100, nil, nil, 3)--Shortname "Charge"
local timerRainofArrowsCD						= mod:NewCDCountTimer(52.3, 439559, nil, nil, nil, 3)
local timerDecimateCD							= mod:NewCDCountTimer(38.1, 442428, nil, nil, nil, 3)

mod:AddPrivateAuraSoundOption(433517, true, 433517, 1)--Phase Blades
mod:AddPrivateAuraSoundOption(439191, true, 442428, 1)--Decimate

mod.vb.sweepCount = 0
mod.vb.tankCombo = 0
mod.vb.comboCount = 0
mod.vb.bladesCount = 0
mod.vb.arrowsCount = 0
mod.vb.arrowsTrackedCount = 0--Because count changes before and after sweep, and since BW doesn't reset timer counts, we have to track a separate variable
mod.vb.decimateCount = 0

function mod:OnCombatStart(delay)
	self.vb.sweepCount = 0
	self.vb.tankCombo = 0
	self.vb.comboCount = 0
	self.vb.bladesCount = 0
	self.vb.arrowsCount = 0
	self.vb.arrowsTrackedCount = 0
	self.vb.decimateCount = 0
	timerCaptainsFlourishCD:Start(6-delay, 1)
	if self:IsMythic() then
		timerPhaseBladesCD:Start(12.1-delay, 1)
		timerRainofArrowsCD:Start(22.2-delay, 1)
		timerDecimateCD:Start(50.8-delay, 1)
	else--Confirmed heroic and normal
		timerPhaseBladesCD:Start(14.3-delay, 1)
		timerRainofArrowsCD:Start(35.1-delay, 1)
		timerDecimateCD:Start(42.7-delay, 1)
	end
	timerShatteringSweepCD:Start(89.9, 1)
	self:EnablePrivateAuraSound(433517, "runout", 2)--Phase Blades
	self:EnablePrivateAuraSound(439191, "lineyou", 17)--Decimate
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 456420 then
		self.vb.sweepCount = self.vb.sweepCount + 1
		specWarnShatteringSweep:Show(self.vb.sweepCount)
		specWarnShatteringSweep:Play("justrun")
		timerShatteringSweepCD:Start(nil, self.vb.sweepCount+1)
		--Restart timers
		self.vb.arrowsTrackedCount = 0
		timerCaptainsFlourishCD:Start(10.7, self.vb.tankCombo+1)--10.7-12.3 (likely travel time affected after sweep)
		timerPhaseBladesCD:Start(19.3, self.vb.bladesCount+1)
		timerRainofArrowsCD:Start(self:IsMythic() and 19.5 or 39.7, self.vb.arrowsCount+1)
		timerDecimateCD:Start(self:IsMythic() and 60.1 or 48.3, self.vb.decimateCount+1)
	elseif spellId == 435401 or spellId == 432965 then--Second cast / First cast
		if spellId == 432965 then
			--First part of Combo
			self.vb.tankCombo = self.vb.tankCombo + 1
			self.vb.comboCount = 0
			if self.vb.tankCombo % 4 ~= 0 then
				--On mythic, the first tank combos are always 25.1 apart but then they are 27.9 apart after first sweep
				timerCaptainsFlourishCD:Start(self:IsMythic() and (self.vb.sweepCount == 0 and 25.1 or 26.4) or 22.1, self.vb.tankCombo+1)
			end
		end
		--Now do combo stuff
		self.vb.comboCount = self.vb.comboCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			if spellId == 432965 then
				specWarnExpose:Show()
				specWarnExpose:Play("defensive")
			end
		end
	elseif spellId == 435403 then
		self.vb.comboCount = self.vb.comboCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnPhaseLunge:Show()
			specWarnPhaseLunge:Play("defensive")
		else
			--Other tank has this debuff already and it will NOT be gone when cast finishes, TAUNT NOW!
			--This doesn't check TankSwapBehavior dropdown because this always validates that the player about to get hit by this, shouldn't be hit by it
			if UnitExists("boss1target") and not UnitIsUnit("player", "boss1target") then
				local _, _, _, _, _, expireTimeTarget = DBM:UnitDebuff("boss1target", 435410)--Target has Pierced Defenses already and can't take this 500% damage hit
				if (expireTimeTarget and expireTimeTarget-GetTime() >= 2) and self:AntiSpam(1.5, 1) then
					specWarnPiercedDefenses:Show(UnitName("boss1target"))
					specWarnPiercedDefenses:Play("tauntboss")
				end
			end
		end
	elseif spellId == 439559 or spellId == 453258 then
		self.vb.arrowsCount = self.vb.arrowsCount + 1
		self.vb.arrowsTrackedCount = self.vb.arrowsTrackedCount + 1
		if self:IsMythic() then
			--Behavior changes fairly radically after first sweep on mythic
			--prior to first sweep only 2 casts and 2nd delayed
			--After it's always 3 casts
			if self.vb.arrowsTrackedCount == 1 then
				timerRainofArrowsCD:Start(self.vb.sweepCount == 0 and 40.1 or 27.9, self.vb.arrowsCount+1)
			elseif self.vb.arrowsTrackedCount == 2 and self.vb.sweepCount > 0 then
				timerRainofArrowsCD:Start(27.9, self.vb.arrowsCount+1)
			end
		else
			if self.vb.arrowsTrackedCount == 1 then
				timerRainofArrowsCD:Start(52.3, self.vb.arrowsCount+1)
			end
		end
	elseif spellId == 442428 then
		self.vb.decimateCount = self.vb.decimateCount + 1
		warnDecimate:Show(self.vb.decimateCount)
		if self.vb.decimateCount % 2 == 1 then
			--26.1 before sweep, 28 after? (mythic). need more data, it's just an assumption atm
			timerDecimateCD:Start(self:IsMythic() and (self.vb.sweepCount == 0 and 26.1 or 27.1) or 39.5, self.vb.decimateCount+1)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 439559 or spellId == 453258 then
		--Alert on success instead of start since that's when swirls actually appear
		specWarnRainofArrows:Show(self.vb.arrowsCount)
		specWarnRainofArrows:Play("watchstep")
	elseif spellId == 433475 then
		if self:AntiSpam(10, 2) then
			self.vb.bladesCount = self.vb.bladesCount + 1
			warnPhaseBlades:Show(self.vb.bladesCount)
			if self:IsMythic() then
				if self.vb.bladesCount % 3 ~= 0 then
					--Mythic consistently same before and after sweep, within the standard variation of ~28
					timerPhaseBladesCD:Start(27.6, self.vb.bladesCount+1)
				end
			else
				if self.vb.bladesCount % 2 == 1 then
					--The 45 seems to be a consisted fluke only in first rotation (ie before first sweep)
					timerPhaseBladesCD:Start(self.vb.sweepCount == 0 and 44.9 or 42.5, self.vb.bladesCount+1)
				end
			end
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 459273 and args:IsPlayer() then
		warnCosmicShards:Cancel()
		--0.5 aggregation so all ones blowing up at once during Shattering Sweep are only single warned
		warnCosmicShards:Schedule(0.5, args.amount or 1)
		timerCosmicShards:Stop()
		timerCosmicShards:Start()
	elseif spellId == 438845 and not args:IsPlayer() then--Exposed weakness / Pierced Defenses
		if (args.amount or 1) == 2 and self:AntiSpam(1.5, 1) then--Only thing we can be sure of, you don't want a tank taking all 3 hits
			specWarnExposedWeakness:Show(args.destName)
			specWarnExposedWeakness:Play("tauntboss")
		end
	elseif spellId == 459785 and args:IsPlayer() and self:AntiSpam(3, 3) then
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 459273 and args:IsPlayer() then
		timerCosmicShards:Stop()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 459785 and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
