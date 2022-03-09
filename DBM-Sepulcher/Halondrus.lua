local mod	= DBM:NewMod(2463, "DBM-Sepulcher", nil, 1195)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(180906)
mod:SetEncounterID(2529)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
mod:SetHotfixNoticeRev(20220303000000)
mod:SetMinSyncRevision(20220302000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")
mod.disableHealthCombat = true--Boss stays active and even heals up after combat, we don't want these events to trigger new combat
--mod:DisableIEEUCombatDetection()--Not sure if required yet
--mod:DisableFriendlyDetection()--Not sure if required yet

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 361676 360977 367079 359236 362056 364979 360115 368957 368529 359235",
	"SPELL_CAST_SUCCESS 365294",--361602
	"SPELL_AURA_APPLIED 365297 361309 368671 368969",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 368671 368969 360115"
--	"SPELL_PERIODIC_DAMAGE 361002 360114",
--	"SPELL_PERIODIC_MISSED 361002 360114",
--	"UNIT_DIED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, enable GTFO once it's confirmed debuff doesn't actually linger when you leave pool, misleading tooltip
--TODO, infoframe for reclaim absorb shield %?
--TODO, is Shatter (formerly detonation) still a dps switch warning?
--[[
(ability.id = 363340 or ability.id = 363408 or ability.id = 367079 or ability.id = 361676 or ability.id = 360977 or ability.id = 359236 or ability.id = 364979 or ability.id = 360115 or ability.id = 359235) and type = "begincast"
 or (ability.id = 365294 or ability.id = 359235 or ability.id = 361602 or ability.id = 359236) and type = "cast"
 or ability.id = 365297 and type = "applydebuff"
 or (ability.id = 364229 or ability.id = 362056) and type = "begincast"
 or ability.id = 368347 and type = "applydebuff"
 or ability.id = 360115 and type = "removebuff"
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
local timerReclaimCD							= mod:NewCDCountTimer(60, 360115, nil, nil, nil, 5)
local timerSeismicTremorsCD						= mod:NewCDCountTimer(26.7, 367079, nil, nil, nil, 5)--Make me count timer when leaving AI
local timerEarthbreakerMissilesCD				= mod:NewCDCountTimer(26.1, 361676, nil, nil, nil, 3)
local timerPlanetcrackerBeamCD					= mod:NewCDTimer(33.2, 369210, nil, nil, nil, 3)
local timerCrushingPrismCD						= mod:NewCDCountTimer(26.9, 365297, nil, nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)
--Stage Two: The Shimmering Cliffs
local timerRelocationForm						= mod:NewCastTimer(6, 359236, nil, nil, nil, 6)
local timerShatterCD							= mod:NewCDCountTimer(6, 362056, nil, nil, nil, 5, nil, DBM_COMMON_L.DAMAGE_ICON)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("8")
mod:AddInfoFrameOption(360115, true)
--mod:AddSetIconOption("SetIconOnSeismicTremors", 368669, true, false, {1, 2, 3, 4})
mod:AddSetIconOption("SetIconOnFractal", 368671, true, true, {8})
mod:AddSetIconOption("SetIconOnShatter", 362056, true, true, {8})
mod:AddSetIconOption("SetIconOnCrushing", 365297, false, false, {1, 2, 3, 4, 5, 6, 7})
mod:AddNamePlateOption("NPAuraOnFractal", 368671, true)
mod:GroupSpells(368957, 368969)--Combine the cast (Charges with the debuff Charge)

mod.vb.chargeCount = 0
mod.vb.tremorCount = 0
mod.vb.missilesCount = 0
mod.vb.reclaimCount = 0
mod.vb.seismicIcon = 1
mod.vb.shatterCount = 0
mod.vb.crushingCast = 0
mod.vb.crushIcon = 1
local movementTimers = {
	--Shatter
	[364979] = {
		[2] = {30.1, 22},
		[4] = {24.1, 24, 18},
	},
	--Earthbreaker Missiles
	[361676] = {
		[2] = {16.2, 26.1},
		[4] = {12.1, 18.1, 26.1},
	},
	--Crushing Prism
	[365297] = {
		[2] = {37.3},
		[4] = {47.3},
	},
}
local p3MissileTimers = {17, 24.5, 37.2, 12.6, 25}

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.crushingCast = 0
	self.vb.chargeCount = 0
	self.vb.tremorCount = 0
	self.vb.missilesCount = 0
	self.vb.reclaimCount = 0
	self.vb.seismicIcon = 1
	timerSeismicTremorsCD:Start(8-delay, 1)
	if self:IsHard() then
		timerPlanetcrackerBeamCD:Start(11.6-delay)
	end
	timerCrushingPrismCD:Start(21-delay, 1)
	timerEarthbreakerMissilesCD:Start(43-delay, 1)
	timerReclaimCD:Start(60, 1)
	if self:IsMythic() then
		timerVolatileChargesCD:Start(1-delay)
	end
	if self.Options.NPAuraOnFractal then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
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
		timerSeismicTremorsCD:Start(nil, self.vb.tremorCount+1)
	elseif spellId == 361676 then
		self.vb.missilesCount = self.vb.missilesCount + 1
		specWarnEarthbreakerMissiles:Show(self.vb.missilesCount)
		specWarnEarthbreakerMissiles:Play("scatter")
		local timer = self.vb.stageTotality == 5 and p3MissileTimers[self.vb.missilesCount+1] or self.vb.phase == 1 and 26.1 or movementTimers[361676][self.vb.stageTotality][self.vb.missilesCount+1]
		if timer then
			timerEarthbreakerMissilesCD:Start(timer, self.vb.missilesCount+1)
		end
	elseif spellId == 360977 then
		if self:IsTanking("player", nil, nil, nil, args.sourseGUID) then--Change to boss1 check if boss is always boss1, right now unsure
			specWarnLightshatterBeam:Show(L.Mote)
			specWarnLightshatterBeam:Play("defensive")
		end
	elseif spellId == 359236 then--Relocation Form
		self:SetStage(2)--Stage, as determined by dungeon journal
		self.vb.shatterCount = 0
		self.vb.crushingCast = 0
		self.vb.missilesCount = 0
		warnRelocationForm:Show()
		timerRelocationForm:Start()
		--Stop stationary timers
		timerEarthbreakerMissilesCD:Stop()
		timerVolatileChargesCD:Stop()
		timerCrushingPrismCD:Stop()
		timerReclaimCD:Stop()
		timerSeismicTremorsCD:Stop()
		timerPlanetcrackerBeamCD:Stop()--Future proofing, you know, when phase is shorter than 12 seconds
		--Start mobile ones
		--Halondrus is a phase 1, 2, 1, 2 boss.
		--We want to distinguish between first phase 2 and second phase 2 (per dungeon journals termonology)
		--So this is first mod in wows history that is actually using a stageTotality check.
		if self.vb.stageTotality == 2 then--First movement
			timerEarthbreakerMissilesCD:Start(16.1, 1)
			timerShatterCD:Start(30.1, 1)
			timerCrushingPrismCD:Start(37.3, 1)
			if self:IsMythic() then
				timerVolatileChargesCD:Start(2)
			end
		else--Second movement (self.vb.stageTotality == 4)
			timerEarthbreakerMissilesCD:Start(12.1, 1)
			timerShatterCD:Start(30.1, 1)
			timerCrushingPrismCD:Start(47.3, 1)
			if self:IsMythic() then
				timerVolatileChargesCD:Start(4)
			end
		end
	elseif spellId == 359235 then
		self:SetStage(1)--Stage, as determined by dungeon journal
		self.vb.crushingCast = 0
		self.vb.chargeCount = 0
		self.vb.tremorCount = 0
		self.vb.reclaimCount = 0
		self.vb.missilesCount = 0
		warnReclamationForm:Show()
		--Stop mobile timers
		timerEarthbreakerMissilesCD:Stop()--Remove if not needed
		timerShatterCD:Stop()
		timerCrushingPrismCD:Stop()
		timerVolatileChargesCD:Stop()
		--Start Stationary ones
		if self.vb.stageTotality == 3 then--Second stationary (after first movement)
			timerSeismicTremorsCD:Start(10.1, 1)
			timerEarthbreakerMissilesCD:Start(17.8, 1)
			timerCrushingPrismCD:Start(23.1, 1)
			if self:IsHard() then
				timerPlanetcrackerBeamCD:Start(33.2)
			end
			timerReclaimCD:Start(68)
			if self:IsMythic() then
				timerVolatileChargesCD:Start(3)
			end
		else--Third stationary, after 2nd movement (stageTotality == 5)
			if self:IsHard() then
				timerPlanetcrackerBeamCD:Start(14.2)
			end
			timerEarthbreakerMissilesCD:Start(17.1, 1)
			if self:IsMythic() then
				timerVolatileChargesCD:Start(5)
			end
		end
	elseif spellId == 368529 then
		warnEternityOverdrive:Show()
	elseif spellId == 362056 then
		--USE for alert too if the detonate script gets hidden
		if self.Options.SetIconOnShatter then
			self:ScanForMobs(args.sourceGUID, 2, 8, 1, nil, 12, "SetIconOnShatter")
		end
	elseif spellId == 364979 then--Casts slightly faster than 362056
		specWarnShatter:Show()
		specWarnShatter:Play("targetchange")
		local timer = movementTimers[spellId][self.vb.stageTotality][self.vb.shatterCount+1]
		if timer then
			timerShatterCD:Start(timer, self.vb.shatterCount+1)
		end
	elseif spellId == 360115 then
		self.vb.reclaimCount = self.vb.reclaimCount + 1
		specWarnReclaim:Show(self.vb.reclaimCount)
		specWarnReclaim:Play("attackshield")
		--Stop other stage timers
		timerSeismicTremorsCD:Stop()
		timerEarthbreakerMissilesCD:Stop()
		timerCrushingPrismCD:Stop()
		timerVolatileChargesCD:Stop()
	elseif spellId == 368957 then
		self.vb.chargeCount = self.vb.chargeCount + 1
		specWarnVolatileCharges:Show(self.vb.chargeCount)
		specWarnVolatileCharges:Play("bombsoon")
		timerVolatileChargesCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 365294 then
		DBM:Debug("Crushing Prism unhidden from combat log. Notify DBM Authors")
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
			local timer = self.vb.phase == 1 and 26 or movementTimers[spellId][self.vb.stageTotality][self.vb.crushingCast+1]
			if timer then
				timerCrushingPrismCD:Start(timer, self.vb.crushingCast+1)
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
	elseif spellId == 360115 then
		self.vb.crushingCast = 0
		self.vb.chargeCount = 0
		self.vb.tremorCount = 0
		self.vb.missilesCount = 0
		--Seems same in reclaim form 1 and 2. and NA for 3
		timerSeismicTremorsCD:Start(4.8, 1)
		timerEarthbreakerMissilesCD:Start(11, 1)
		timerCrushingPrismCD:Start(17, 1)
		timerReclaimCD:Start(62.8, self.vb.reclaimCount+1)--Guessed based on pattern
		if self:IsMythic() then
			timerVolatileChargesCD:Start(3)
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

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 369207 then--Planetcracker Beam
		specWarnPlanetcrackerBeam:Show()
		specWarnPlanetcrackerBeam:Play("watchstep")--or farfromline if it's a line
	end
end
--]]
