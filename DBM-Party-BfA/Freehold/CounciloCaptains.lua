local mod	= DBM:NewMod(2093, "DBM-Party-BfA", 2, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(126845, 126847, 126848)--Captain Jolly, Captain Raoul, Captain Eudora
mod:SetEncounterID(2094)
mod:SetZone()
mod:DisableRegenDetection()
mod:SetMinSyncRevision(20190806000000)--2019, 08, 06

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 258338 256589 257117 267522 272884 267533 272902 265088 264608 265168 256979",
	"SPELL_CAST_SUCCESS 258381 265088 264608",
	"SPELL_AURA_APPLIED 265056 278467",
	"SPELL_DAMAGE 272397",
	"SPELL_MISSED 272397",
	"UNIT_DIED"
)

--TODO: target scan Blackout Barrel?
--(ability.id = 258338 or ability.id = 256589 or ability.id = 257117) and type = "begincast" or ability.id = 258381 and type = "cast"
local warnLuckySevens				= mod:NewSpellAnnounce(257117, 1)
local warnTappedKeg					= mod:NewSpellAnnounce(272884, 1)
local warnChainShot					= mod:NewSpellAnnounce(272902, 1)
local warnPowderShot				= mod:NewTargetNoFilterAnnounce(256979, 3)
--Announce Brews
local warnConfidenceBrew			= mod:NewSpellAnnounce(265088, 1)--Confidence-Boosting Freehold Brew
local warnInvigoratingBrew			= mod:NewSpellAnnounce(264608, 1)--Invigorating Freehold Brew
local warnGoodBrew					= mod:NewAnnounce("warnGoodBrew", 1, 265088)
local warnCausticBrew				= mod:NewCastAnnounce(265168, 4)

--Genera
local specWarnBrewOnBoss			= mod:NewSpecialWarning("specWarnBrewOnBoss", "Tank", nil, nil, 1, 2)
--Raoul
local specWarnBarrelSmash			= mod:NewSpecialWarningRun(256589, "Melee", nil, nil, 4, 2)
local specWarnBlackoutBarrel		= mod:NewSpecialWarningSwitch(258338, nil, nil, nil, 1, 2)
--Eudora
local specWarnGrapeShot				= mod:NewSpecialWarningDodge(258381, nil, nil, nil, 3, 2)
local specWarnPowderShot			= mod:NewSpecialWarningYou(256979, nil, nil, nil, 1, 2)
--Jolly
local specWarnCuttingSurge			= mod:NewSpecialWarningDodge(267522, nil, nil, nil, 2, 2)
local specWarnWhirlpoolofBlades		= mod:NewSpecialWarningDodge(267533, nil, nil, nil, 2, 2)
local specWarnGTFO					= mod:NewSpecialWarningGTFO(272397, nil, nil, nil, 1, 8)

--General
local timerTendingBarCD				= mod:NewNextTimer(8, 264605, nil, nil, nil, 3)
--Raoul
----Hostile
local timerBarrelSmashCD			= mod:NewCDTimer(22.9, 256589, nil, "Melee", nil, 3)--22.9-24.5
local timerBlackoutBarrelCD			= mod:NewCDTimer(47.3, 258338, nil, nil, nil, 3, nil, DBM_CORE_DAMAGE_ICON)
----Friendly
local timerTappedKegCD				= mod:NewNextTimer(22.3, 272884, nil, nil, nil, 5)
--Eudora
----Hostile
local timerGrapeShotCD				= mod:NewNextTimer(30.3, 258381, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
----Friendly
local timerChainShotCD				= mod:NewAITimer(29.1, 272902, nil, nil, nil, 5)
--Jolly
----Hostile
local timerCuttingSurgeCD			= mod:NewCDTimer(22.7, 267522, nil, nil, nil, 3)
local timerWhirlpoolofBladesCD		= mod:NewCDTimer(22.7, 267533, nil, nil, nil, 3)
----Friendly
local timerLuckySevensCD			= mod:NewNextTimer(29.1, 257117, nil, nil, nil, 5)

mod:AddRangeFrameOption(5, 267522)

local function scanCaptains(self, isPull, delay)

	local foundOne, foundTwo, foundThree
	for i = 1, 3 do
		local unitID = "boss"..i
		if UnitExists(unitID) then
			local cid = self:GetUnitCreatureId(unitID)
			if not UnitIsFriend("player", unitID) then
				if not foundOne then foundOne = cid
				elseif not foundTwo then foundTwo = cid
				else foundThree = cid end
				--Set hostile timers
				if isPull then--Only do on pull, if recovery, these will be synced when vb table sent
					if cid == 126845 then--Jolly
						timerCuttingSurgeCD:Start(4.1-delay)
						timerWhirlpoolofBladesCD:Start(9.8-delay)
						if self.Options.RangeFrame then
							DBM.RangeCheck:Show(5)
						end
					elseif cid == 126847 then--Raoul
						timerBarrelSmashCD:Start(6.1-delay)
						timerBlackoutBarrelCD:Start(20.7-delay)
					else--Eudora
						timerGrapeShotCD:Start(7.4-delay)
					end
				end
			else--Friendly
				--Set friendly Timers
				if isPull then--Only do on pull, if recovery, these will be synced when vb table sent
					if cid == 126845 then--Jolly
						timerLuckySevensCD:Start(9.8-delay)
					elseif cid == 126847 then--Raoul
						timerTappedKegCD:Start(12.2-delay)
					else--Eudora
						timerChainShotCD:Start(1-delay)
					end
				end
			end
		end
	end
	if foundTwo then
		if foundThree then
			self:SetCreatureID(foundOne, foundTwo, foundThree)
		else
			self:SetCreatureID(foundOne, foundTwo)
		end
	end
end

function mod:PowderShotTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnPowderShot:Show()
		specWarnPowderShot:Play("targetyou")
	else
		warnPowderShot:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	if not self:IsNormal() then
		timerTendingBarCD:Start(8-delay)
	end
	self:Schedule(1, scanCaptains, self, true, delay)--1 second delay to give IEEU time to populate boss unitIDs
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:OnTimerRecovery()
	scanCaptains(self)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 258338 then
		specWarnBlackoutBarrel:Show()
		specWarnBlackoutBarrel:Play("changetarget")
		timerBlackoutBarrelCD:Start()
	elseif spellId == 256589 then
		specWarnBarrelSmash:Show()
		specWarnBarrelSmash:Play("justrun")
		timerBarrelSmashCD:Start()
	elseif spellId == 257117 then
		warnLuckySevens:Show()
		timerLuckySevensCD:Start()
	elseif spellId == 267522 then
		specWarnCuttingSurge:Show()
		specWarnCuttingSurge:Play("chargemove")
		timerCuttingSurgeCD:Start()
	elseif spellId == 272884 then
		warnTappedKeg:Show()
		timerTappedKegCD:Start()
	elseif spellId == 267533 then
		specWarnWhirlpoolofBlades:Show()
		specWarnWhirlpoolofBlades:Play("watchstep")
		timerWhirlpoolofBladesCD:Start()
	elseif spellId == 272902 then
		warnChainShot:Show()
		timerChainShotCD:Start()
	elseif spellId == 265088 or spellId == 264608 or spellId == 265168 then
		if spellId == 265168 then
			warnCausticBrew:Show()
		elseif spellId == 265088 then
			warnGoodBrew:Show(L.critBrew)
		else--264608
			warnGoodBrew:Show(L.hasteBrew)
		end
		timerTendingBarCD:Start()
	elseif spellId == 256979 and self:IsMythic() then
		self:ScheduleMethod(0.1, "BossTargetScanner", args.sourceGUID, "PowderShotTarget", 0.1, 16, true, nil, nil, nil, true)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 258381 then
		specWarnGrapeShot:Show()
		specWarnGrapeShot:Play("stilldanger")
		timerGrapeShotCD:Start()
	elseif spellId == 265088 or spellId == 264608 then
		if spellId == 265088 then
			warnConfidenceBrew:Show()
		else
			warnInvigoratingBrew:Show()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if (spellId == 265056 or spellId == 278467) and self:AntiSpam(3, 2) then
		local unitId = self:GetUnitIdFromGUID(args.destGUID, true)
		if unitId and UnitIsEnemy("player", unitId) then
			specWarnBrewOnBoss:Show(args.destName)
			specWarnBrewOnBoss:Play("moveboss")
		end
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 272397 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) and not self:IsTank() then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 126845 then--Captain Jolly
		timerCuttingSurgeCD:Stop()
		timerWhirlpoolofBladesCD:Stop()
		timerLuckySevensCD:Stop()
	elseif cid == 126847 then--Captain Raoul
		timerBarrelSmashCD:Stop()
		timerBlackoutBarrelCD:Stop()
		timerTappedKegCD:Stop()
	elseif cid == 126848 then--Captain Eudora
		timerGrapeShotCD:Stop()
		timerChainShotCD:Stop()
	elseif cid == 133219 then--Rummy Mancomb (You bastard, you killed Rummy!)
		timerTendingBarCD:Stop()
	end
end
