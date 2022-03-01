local mod	= DBM:NewMod(2463, "DBM-Sepulcher", nil, 1195)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(180906)
mod:SetEncounterID(2529)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
mod:SetHotfixNoticeRev(20220209000000)
mod:SetMinSyncRevision(20220209000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 361676 365283 360977 367079 359236 362056 364979 360115 368957 369210 368529",
	"SPELL_CAST_SUCCESS 365294 359235",--361602
	"SPELL_AURA_APPLIED 365297 361309 368671 368969",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 368671 368969",
--	"SPELL_PERIODIC_DAMAGE 361002 360114",
--	"SPELL_PERIODIC_MISSED 361002 360114",
--	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, enable GTFO once it's confirmed debuff doesn't actually linger when you leave pool, misleading tooltip
--TODO, reclaim addition probably changes all the frigging timers, this mod may need redoing, and doubt blizz will even retest this
--TODO, infoframe for reclaim absorb shield %?
--TODO, target scan planet cracker? GTFO stuff it leaves behind?
--TODO, is Shatter (formerly detonation) still a dps switch warning?
--[[
(ability.id = 363340 or ability.id = 363408 or ability.id = 367079 or ability.id = 361676 or ability.id = 365283 or ability.id = 360977 or ability.id = 359236 or ability.id = 364979 or ability.id = 360115) and type = "begincast"
 or (ability.id = 365294 or ability.id = 359235 or ability.id = 361602) and type = "cast"
 or ability.id = 365297 and type = "applydebuff"
 or (ability.id = 364229 or ability.id = 362056) and type = "begincast"
 or ability.id = 368347 and type = "applydebuff"
--]]
--Stage One: The Reclaimer
local warnReclamationForm						= mod:NewCastAnnounce(359235, 2)
local warnSeismicTremors						= mod:NewCountAnnounce(367079, 2)
local warnCrushingPrism							= mod:NewCountAnnounce(365297, 3, nil, "RemoveMagic")
--Stage Two: The Shimmering Cliffs
local warnRelocationForm						= mod:NewCastAnnounce(359236, 2)

--Stage Three:
local warnEternityOverdrive						= mod:NewCastAnnounce(368529, 2)

--Mythic
local specWarnVolatileCharges					= mod:NewSpecialWarningCount(368957, nil, nil, nil, 2, 6, 4)
local specWarnVolatileChargeYou					= mod:NewSpecialWarningCount(368969, nil, nil, nil, 1, 2, 12)
local yellVolatileCharge						= mod:NewYell(368969)
local yellVolatileChargeFades					= mod:NewShortFadesYell(368969)
--Stage One: The Reclaimer
local specWarnReclaim							= mod:NewSpecialWarningCount(360115, nil, nil, nil, 1, 2)
local specWarnSeismicTremors					= mod:NewSpecialWarningCount(367079, false, nil, nil, 1, 2)--I don't even understand mechanic anymore it's been changed so much, no idea if it should be on or off by default
local specWarnEarthbreakerMissiles				= mod:NewSpecialWarningMoveAway(361676, nil, nil, nil, 2, 2)
local specWarnPlanetcrackerBeam					= mod:NewSpecialWarningDodgeCount(369210, nil, nil, nil, 2, 2)
local specWarnCrushingPrism						= mod:NewSpecialWarningYou(365297, nil, nil, nil, 1, 2)
local specWarnLightshatterBeam					= mod:NewSpecialWarningMoveTo(360977, nil, nil, nil, 1, 2)
local specWarnLightshatterBeamTaunt				= mod:NewSpecialWarningTaunt(360977, nil, nil, nil, 1, 2)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(361002, nil, nil, nil, 1, 8)
--Stage Two: The Shimmering Cliffs
local specWarnShatter							= mod:NewSpecialWarningSwitch(362056, "Dps", nil, nil, 1, 2)

--mod:AddTimerLine(BOSS)
--Mythic
local timerVolatileChargesCD					= mod:NewAITimer(36.5, 368957, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
--Stage One: The Reclaimer
local timerReclaimCD							= mod:NewAITimer(28.8, 360115, nil, nil, nil, 5)
local timerSeismicTremorsCD						= mod:NewAITimer(35, 367079, nil, nil, nil, 5)--Make me count timer when leaving AI
local timerEarthbreakerMissilesCD				= mod:NewAITimer(33.2, 361676, nil, nil, nil, 3)
local timerPlanetcrackerBeamCD					= mod:NewAITimer(33.2, 369210, nil, nil, nil, 3)
local timerCrushingPrismCD						= mod:NewAITimer(42.5, 365297, nil, nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)
local timerLightshatterBeamCD					= mod:NewCDTimer(14, 360977, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--Stage Two: The Shimmering Cliffs
local timerRelocationForm						= mod:NewCastTimer(6, 359236, nil, nil, nil, 6)
local timerShatterCD							= mod:NewAITimer(6, 362056, nil, nil, nil, 5, nil, DBM_COMMON_L.DAMAGE_ICON)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("8")
mod:AddInfoFrameOption(360115, true)
--mod:AddSetIconOption("SetIconOnSeismicTremors", 368669, true, false, {1, 2, 3, 4})
mod:AddSetIconOption("SetIconOnFractal", 368671, true, true, {8})
mod:AddSetIconOption("SetIconOnShatter", 362056, true, true, {8})
mod:AddSetIconOption("SetIconOnCrushing", 365297, false, false, {1, 2, 3, 4, 5, 6, 7}, true)
mod:AddNamePlateOption("NPAuraOnFractal", 368671, true)
mod:GroupSpells(368957, 368969)--Combine the cast (Charges with the debuff Charge)

mod.vb.chargeCount = 0
mod.vb.tremorCount = 0
mod.vb.reclaimCount = 0
mod.vb.planetCrackerCount = 0
mod.vb.seismicIcon = 1
mod.vb.detonateCast = 0
mod.vb.crushingCast = 0
mod.vb.crushIcon = 1
local shatterTimers = {
	[2] = {27, 22.6},
--	[4] = {20.4, 19.9, 6.9, 1, 10.7, 8.7},--Heroic
	[4] = {20.4, 19.9, 8.6, 12.3},--Normal
}
local crushingTimers = {
--	[1] = {45.4, 45.4, 43.5},
	[2] = {34.4},
--	[3] = {46.9, 45.6, 42.3, 44.3},
--	[4] = {12.7, 33, 24.2},--Heroic
	[4] = {45.3, 24.6}--Normal (did heroic change?)
--	[5] = {36.7, 43.4, 46.6, 53.3, 42.9, 45.7},
}

--OBSOLETE INFO, needs review
--Tremors triggers 3.5 second ICD
--Lightshatter triggers 3.5 second ICD
--missiles trigger 4.8-8 second ICD (not sure why it's variable yet)
--Crushing triggers 1.2 second ICD (technically longer but the bosses cast of it is hidden so can't update timers until debuffs go out)
local function updateAllTimers(self, ICD)
	if self.vb.phase == 2 then return end--This doesn't touch timers when boss is moving
	DBM:Debug("updateAllTimers running", 2)
	if timerEarthbreakerMissilesCD:GetRemaining() < ICD then
		local elapsed, total = timerEarthbreakerMissilesCD:GetTime()
		local extend = ICD - (total-elapsed)
		DBM:Debug("timerEarthbreakerMissilesCD extended by: "..extend, 2)
		timerEarthbreakerMissilesCD:Stop()
		timerEarthbreakerMissilesCD:Update(elapsed, total+extend)
	end
	if timerSeismicTremorsCD:GetRemaining(self.vb.tremorCount+1) < ICD then
		local elapsed, total = timerSeismicTremorsCD:GetTime(self.vb.tremorCount+1)
		local extend = ICD - (total-elapsed)
		DBM:Debug("timerSeismicTremorsCD extended by: "..extend, 2)
		timerSeismicTremorsCD:Stop()
		timerSeismicTremorsCD:Update(elapsed, total+extend, self.vb.tremorCount+1)
	end
	if timerLightshatterBeamCD:GetRemaining() < ICD then
		local elapsed, total = timerLightshatterBeamCD:GetTime()
		local extend = ICD - (total-elapsed)
		DBM:Debug("timerLightshatterBeamCD extended by: "..extend, 2)
		timerLightshatterBeamCD:Stop()
		timerLightshatterBeamCD:Update(elapsed, total+extend)
	end
	if timerCrushingPrismCD:GetRemaining(self.vb.crushingCast+1) < ICD then
		local elapsed, total = timerCrushingPrismCD:GetTime(self.vb.crushingCast+1)
		local extend = ICD - (total-elapsed)
		DBM:Debug("timerCrushingPrismCD extended by: "..extend, 2)
		timerCrushingPrismCD:Stop()
		timerCrushingPrismCD:Update(elapsed, total+extend, self.vb.crushingCast+1)
	end
	if timerPlanetcrackerBeamCD:GetRemaining(self.vb.planetCrackerCount+1) < ICD then
		local elapsed, total = timerPlanetcrackerBeamCD:GetTime(self.vb.planetCrackerCount+1)
		local extend = ICD - (total-elapsed)
		DBM:Debug("timerPlanetcrackerBeamCD extended by: "..extend, 2)
		timerPlanetcrackerBeamCD:Stop()
		timerPlanetcrackerBeamCD:Update(elapsed, total+extend, self.vb.planetCrackerCount+1)
	end
--	if self:IsMythic() and timerVolatileChargesCD:GetRemaining() < ICD then
--		local elapsed, total = timerVolatileChargesCD:GetTime()
--		local extend = ICD - (total-elapsed)
--		DBM:Debug("timerVolatileChargesCD extended by: "..extend, 2)
--		timerVolatileChargesCD:Stop()
--		timerVolatileChargesCD:Update(elapsed, total+extend)
--	end
end

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.crushingCast = 0
	self.vb.chargeCount = 0
	self.vb.tremorCount = 0
	self.vb.reclaimCount = 0
	self.vb.planetCrackerCount = 0
	self.vb.seismicIcon = 1
	timerLightshatterBeamCD:Start(10.1-delay)
	timerSeismicTremorsCD:Start(1-delay)
	timerEarthbreakerMissilesCD:Start(1-delay)
	timerPlanetcrackerBeamCD:Start(1-delay)
	timerCrushingPrismCD:Start(1-delay)
	timerReclaimCD:Start(1)
	if self:IsMythic() then
		timerVolatileChargesCD:Start(1-delay)
	end
	if self.Options.NPAuraOnFractal then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
	DBM:AddMsg("This fight was significatly redesigned after it was tested and is no longer the same fight it was. Unfortunately, Blizzard never retested this fight, so this mod will be very outdated until post launch update.")
end

function mod:OnCombatEnd()
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
	if self.Options.NPAuraOnFractal then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

--[[
function mod:OnTimerRecovery()

end
--]]

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 367079 then
		self.vb.tremorCount = self.vb.tremorCount + 1
		if self.Options.SpecWarn367079count then
			specWarnSeismicTremors:Show(self.vb.tremorCount)--Text alert doesn't sasy what to do, just count
			specWarnSeismicTremors:Play("specialsoon")
		else
			warnSeismicTremors:Show(self.vb.tremorCount)
		end
		timerSeismicTremorsCD:Start(self:IsMythic() and 39.1 or 35)--TODO, verify if heroic or others have changed too
--		updateAllTimers(self, 3.5)
	elseif spellId == 361676 or spellId == 365283 then--361676 Confirmed on heroic, 365283 where?
		specWarnEarthbreakerMissiles:Show()
		specWarnEarthbreakerMissiles:Play("scatter")
		timerEarthbreakerMissilesCD:Start(self:IsMythic() and 38.4 or 33.2)--TODO, verify everything again since they moved it from stage 1 to stage 2
--		updateAllTimers(self, 4.8)
	elseif spellId == 360977 then
		if self:IsTanking("player", nil, nil, nil, args.sourseGUID) then--Change to boss1 check if boss is always boss1, right now unsure
			specWarnLightshatterBeam:Show(L.Mote)
			specWarnLightshatterBeam:Play("defensive")
		end
--		updateAllTimers(self, 3.5)
	elseif spellId == 359236 then
		self:SetStage(2)--Stage, as determined by dungeon journal
		self.vb.detonateCast = 0
		self.vb.crushingCast = 0
		warnRelocationForm:Show()
		timerRelocationForm:Start()
		--Stop stationary timers
		timerEarthbreakerMissilesCD:Stop()
		timerVolatileChargesCD:Stop()
		timerLightshatterBeamCD:Stop()
		timerCrushingPrismCD:Stop()
		timerReclaimCD:Stop()
		timerSeismicTremorsCD:Stop()
		timerPlanetcrackerBeamCD:Stop()
		--Start mobile ones
		--Halondrus is a phase 1, 2, 1, 2 boss.
		--We want to distinguish between first phase 2 and second phase 2 (per dungeon journals termonology)
		--So this is first mod in wows history that is actually using a stageTotality check.
		if self.vb.stageTotality == 2 then--First movement
			timerShatterCD:Start(2, 1)
			timerCrushingPrismCD:Start(2, 1)--34.4
			timerEarthbreakerMissilesCD:Start(2)--13.6 old
			if self:IsMythic() then
				timerVolatileChargesCD:Start(2)
			end
		else--Second movement (self.vb.stageTotality == 4)
			timerCrushingPrismCD:Start(4, 1)--12.6
			timerShatterCD:Start(4, 1)
			timerEarthbreakerMissilesCD:Start(4)--32.6
			if self:IsMythic() then
				timerVolatileChargesCD:Start(4)
			end
		end
	elseif spellId == 368529 then
		self:SetStage(3)--Stage, as determined by dungeon journal
		warnEternityOverdrive:Show()
		--Stop stationary timers
		timerEarthbreakerMissilesCD:Stop()
		timerVolatileChargesCD:Stop()
		timerLightshatterBeamCD:Stop()
		timerCrushingPrismCD:Stop()
		timerReclaimCD:Stop()
		timerSeismicTremorsCD:Stop()
		timerPlanetcrackerBeamCD:Stop()
		--Stop mobile timers
--		timerEarthbreakerMissilesCD:Stop()--Remove if not needed
		timerShatterCD:Stop()
--		timerCrushingPrismCD:Stop()--Remove if not needed
		timerVolatileChargesCD:Stop()
		--Stop/restart stage 1 timers? or just stop them and do nothing?
	elseif spellId == 362056 then
		--USE for alert too if the detonate script gets hidden
		if self.Options.SetIconOnShatter then
			self:ScanForMobs(args.sourceGUID, 2, 8, 1, nil, 12, "SetIconOnShatter")
		end
	elseif spellId == 364979 then--Casts slightly faster than 362056
		specWarnShatter:Show()
		specWarnShatter:Play("targetchange")
		local timer = shatterTimers[self.vb.stageTotality][self.vb.detonateCast+1]
		if timer then
			timerShatterCD:Start(timer, self.vb.detonateCast+1)
		end
	elseif spellId == 360115 then
		self.vb.reclaimCount = self.vb.reclaimCount + 1
		specWarnReclaim:Show(self.vb.reclaimCount)
		specWarnReclaim:Play("attackshield")
		timerReclaimCD:Start()
	elseif spellId == 368957 then
		self.vb.chargeCount = self.vb.chargeCount + 1
		specWarnVolatileCharges:Show(self.vb.chargeCount)
		specWarnVolatileCharges:Play("bombsoon")
		timerVolatileChargesCD:Start()
	elseif spellId == 369210 then

		specWarnPlanetcrackerBeam:Show()
		specWarnPlanetcrackerBeam:Play("watchstep")--or farfromline if it's a line
		timerPlanetcrackerBeamCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 365294 then
		DBM:Debug("Crushing Prism unhidden from combat log. Notify DBM Authors")
	elseif spellId == 359235 then
		self:SetStage(1)--Stage, as determined by dungeon journal
		self.vb.crushingCast = 0
		self.vb.chargeCount = 0
		self.vb.tremorCount = 0
		self.vb.reclaimCount = 0
		self.vb.planetCrackerCount = 0
		warnReclamationForm:Show()
		--Stop mobile timers
		timerEarthbreakerMissilesCD:Stop()--Remove if not needed
		timerShatterCD:Stop()
		timerCrushingPrismCD:Stop()
		timerVolatileChargesCD:Stop()
		--Start Stationary ones
		if self.vb.stageTotality == 3 then--Second stationary (after first movement)
			timerLightshatterBeamCD:Start(12.5)
			timerEarthbreakerMissilesCD:Start(3)--35.8
			timerPlanetcrackerBeamCD:Start(3)
			timerCrushingPrismCD:Start(3)
			timerReclaimCD:Start(3)
			timerSeismicTremorsCD:Start(3)
			if self:IsMythic() then
				timerVolatileChargesCD:Start(3)
			end
		else--Third stationary, after 2nd movement (stageTotality == 5)
			timerLightshatterBeamCD:Start(16)
			timerEarthbreakerMissilesCD:Start(5)--28.2
			timerPlanetcrackerBeamCD:Start(5)
			timerCrushingPrismCD:Start(5, 1)
			timerReclaimCD:Start(5)
			timerSeismicTremorsCD:Start(5)
			if self:IsMythic() then
				timerVolatileChargesCD:Start(5)
			end
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 365297 then
		if self:AntiSpam(5, 2) then
			self.vb.crushIcon = 1
			self.vb.crushingCast = self.vb.crushingCast + 1
			warnCrushingPrism:Show(self.vb.crushingCast)
			--use tabled timers during movements, regular CD during stanary subject to ICD live updates
			local timer = self.vb.phase == 1 and (self:IsMythic() and 36.1 or 42.9) or crushingTimers[self.vb.stageTotality][self.vb.crushingCast+1]
			if timer then
				timerCrushingPrismCD:Start(timer, self.vb.crushingCast+1)
--				updateAllTimers(self, 1.2)
			end
		end
		if args:IsPlayer() then
			specWarnCrushingPrism:Show()
			specWarnCrushingPrism:Play("targetyou")
		end
		if self.Options.SetIconOnCrushing and self.vb.crushIcon < 8 then
			self:SetIcon(args.destName, self.vb.crushIcon)
		end
		self.vb.crushIcon = self.vb.crushIcon + 1
	elseif spellId == 361309 and not args:IsPlayer() and not DBM:UnitDebuff("player", spellId) then
		specWarnLightshatterBeamTaunt:Show(args.destName)
		specWarnLightshatterBeamTaunt:Play("tauntboss")
	elseif spellId == 368671 then
		if self.Options.NPAuraOnFractal then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 368969 then
		if args:IsPlayer() then
			specWarnVolatileChargeYou:Show()
			specWarnVolatileChargeYou:Play("bombyou")
			yellVolatileCharge:Yell()
			yellVolatileChargeFades:Countdown(spellId)
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 368671 then
		if self.Options.NPAuraOnFractal then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
		if self.Options.SetIconOnFractal then
			self:ScanForMobs(args.destGUID, 2, 8, 1, nil, 12, "SetIconOnFractal")
		end
	elseif spellId == 368969 then
		if args:IsPlayer() then
			yellVolatileChargeFades:Cancel()
		end
	end
end

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 183870 then--Pylons

	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if (spellId == 361002 or spellId == 360114) and destGUID == UnitGUID("player") and not playerDebuff and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 360990 then--More reliable script for light timer
		timerLightshatterBeamCD:Start()
		--updateAllTimers(self, 3.5)
	end
end

