local mod	= DBM:NewMod(2463, "DBM-Sepulcher", nil, 1195)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(180906)
mod:SetEncounterID(2529)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7)
mod:SetHotfixNoticeRev(20220314000000)
mod:SetMinSyncRevision(20220314000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")
mod.disableHealthCombat = true--Boss stays active and even heals up after combat, we don't want these events to trigger new combat
--mod:DisableIEEUCombatDetection()--Not sure if required yet
--mod:DisableFriendlyDetection()--Not sure if required yet

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 361676 360977 367079 359236 364979 360115 368957 368529 359235",
	"SPELL_CAST_SUCCESS 365294",--361602
	"SPELL_AURA_APPLIED 365297 361309 368671 368969",
	"SPELL_AURA_REMOVED 368671 368969 360115"
--	"SPELL_PERIODIC_DAMAGE 361002 360114",
--	"SPELL_PERIODIC_MISSED 361002 360114"
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
local warnCrushingPrism							= mod:NewTargetCountAnnounce(365297, 3, nil, "RemoveMagic", nil, nil, nil, nil, true)
--Stage Two: The Shimmering Cliffs
local warnRelocationForm						= mod:NewCastAnnounce(359236, 2)

--Stage Three:
local warnEternityOverdrive						= mod:NewCastAnnounce(368529, 2)

--Mythic
local specWarnVolatileCharges					= mod:NewSpecialWarningCount(368957, nil, nil, nil, 2, 6, 4)
local specWarnVolatileChargeYou					= mod:NewSpecialWarningCount(368969, nil, nil, nil, 1, 2, 12)
local yellVolatileCharge						= mod:NewYell(368969, nil, false, 2)
local yellVolatileChargeFades					= mod:NewShortFadesYell(368969)
--Stage One: The Reclaimer
local specWarnReclaim							= mod:NewSpecialWarningCount(360115, nil, nil, nil, 1, 2)
local specWarnSeismicTremors					= mod:NewSpecialWarningCount(367079, false, nil, nil, 1, 2)--I don't even understand mechanic anymore it's been changed so much, no idea if it should be on or off by default
local specWarnEarthbreakerMissiles				= mod:NewSpecialWarningMoveAway(361676, nil, 183426, nil, 2, 2)
local specWarnCrushingPrism						= mod:NewSpecialWarningYou(365297, nil, nil, nil, 1, 2)
local specWarnLightshatterBeam					= mod:NewSpecialWarningMoveTo(360977, nil, 202046, nil, 1, 2)
local specWarnLightshatterBeamTaunt				= mod:NewSpecialWarningTaunt(360977, nil, 202046, nil, 1, 2)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(361002, nil, nil, nil, 1, 8)
--Stage Two: The Shimmering Cliffs
local specWarnShatter							= mod:NewSpecialWarningDodge(362056, nil, nil, nil, 2, 2)

--Stage One: The Reclaimer
local timerReclaimCD							= mod:NewCDCountTimer(60, 360115, nil, nil, nil, 5)
local timerSeismicTremorsCD						= mod:NewCDCountTimer(26.7, 367079, nil, nil, nil, 5)--Make me count timer when leaving AI
local timerEarthbreakerMissilesCD				= mod:NewCDCountTimer(26.1, 361676, 183426, nil, nil, 3)--shorttext "Missiles"
local timerPlanetcrackerBeamCD					= mod:NewCDTimer(33.2, 369210, nil, nil, nil, 3)
local timerCrushingPrismCD						= mod:NewCDCountTimer(26.9, 365297, nil, nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)
--Stage Two: The Shimmering Cliffs
local timerRelocationForm						= mod:NewCastTimer(6, 359236, nil, nil, nil, 6)
local timerShatterCD							= mod:NewCDCountTimer(6, 362056, nil, nil, nil, 5, nil, DBM_COMMON_L.DAMAGE_ICON)

mod:AddInfoFrameOption(360115, true)
mod:AddSetIconOption("SetIconOnCrushing2", 365297, true, false, {1, 2, 3, 4, 5, 6, 7})
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
	[2] = {
		--Shatter
		[364979] = {30.1, 22},
		--Earthbreaker Missiles
		[361676] = {16.1, 26.1},
		--Crushing Prism
		[365297] = {37.3},
		--Mythic Crushing Prism
		[3652970] = {11.1, 26, 14},
	},
	[4] = {
		--Shatter
		[364979] = {24, 24, 17.9},
		--Earthbreaker Missiles
		[361676] = {12, 18, 26},
		--Crushing Prism
		[365297] = {47.3},
		--Mythic Crushing Prism
		[3652970] = {8.7, 18, 17.9},
	},
}
local p5MissileTimers = {17, 24.5, 37.2, 12.6, 25}
local p5MissileMythicTimers = {17, 24.5, 37.2}--First 3 same, 4th and 5th not

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.crushingCast = 0
	self.vb.chargeCount = 0
	self.vb.tremorCount = 0
	self.vb.missilesCount = 0
	self.vb.reclaimCount = 0
	self.vb.seismicIcon = 1
	if self:IsMythic() then--Same as post reclaimm
		timerSeismicTremorsCD:Start(4-delay, 1)
		--timerPlanetcrackerBeamCD:Start(11.6-delay)--Needs checking
		timerCrushingPrismCD:Start(17-delay, 1)
		timerEarthbreakerMissilesCD:Start(11.1-delay, 1)
	else--Slowed down first time around
		timerSeismicTremorsCD:Start(8-delay, 1)
		if self:IsHeroic() then
			timerPlanetcrackerBeamCD:Start(11.6-delay)
		end
		timerCrushingPrismCD:Start(21-delay, 1)
		timerEarthbreakerMissilesCD:Start(43-delay, 1)
	end
	timerReclaimCD:Start(60, 1)--Seems same
	if self.Options.NPAuraOnFractal then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.NPAuraOnFractal then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

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
		if self.vb.stageTotality then
			local timer = self.vb.stageTotality == 5 and (self:IsMythic() and p5MissileMythicTimers[self.vb.missilesCount+1] or p5MissileTimers[self.vb.missilesCount+1]) or self.vb.phase == 1 and 26.1 or self:GetFromTimersTable(movementTimers, false, self.vb.stageTotality, 361676, self.vb.missilesCount+1)
			if timer then
				timerEarthbreakerMissilesCD:Start(timer, self.vb.missilesCount+1)
			end
		end
	elseif spellId == 360977 then
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then--Change to boss1 check if boss is always boss1, right now unsure
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
			timerCrushingPrismCD:Start(self:IsMythic() and 11.1 or 37.3, 1)
		else--Second movement (self.vb.stageTotality == 4)
			timerEarthbreakerMissilesCD:Start(12.1, 1)
			timerShatterCD:Start(30.1, 1)
			timerCrushingPrismCD:Start(47.3, 1)
		end
		if self:IsFated() then
			self:AffixEvent(0)
		end
	elseif spellId == 359235 then--Reclamation Form
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
		--Start Stationary ones
		if self.vb.stageTotality == 3 then--Second stationary (after first movement)
			timerSeismicTremorsCD:Start(10.1, 1)
			timerEarthbreakerMissilesCD:Start(17.8, 1)
			timerCrushingPrismCD:Start(23.1, 1)
			if self:IsHard() then
				timerPlanetcrackerBeamCD:Start(33.2)
			end
			timerReclaimCD:Start(68)
		else--Third stationary, after 2nd movement (stageTotality == 5)
			if self:IsHard() then
				timerPlanetcrackerBeamCD:Start(14.2)
			end
			timerEarthbreakerMissilesCD:Start(17.1, 1)
		end
		if self:IsFated() then
			self:AffixEvent(1, 2)
		end
	elseif spellId == 368529 then
		warnEternityOverdrive:Show()
	elseif spellId == 364979 then--Casts slightly faster than 362056
		specWarnShatter:Show()
		specWarnShatter:Play("watchstep")
		if self.vb.stageTotality then
			local timer = self:GetFromTimersTable(movementTimers, false, self.vb.stageTotality, spellId, self.vb.shatterCount+1)
			if timer then
				timerShatterCD:Start(timer, self.vb.shatterCount+1)
			end
		end
	elseif spellId == 360115 then
		self.vb.reclaimCount = self.vb.reclaimCount + 1
		specWarnReclaim:Show(self.vb.reclaimCount)
		specWarnReclaim:Play("attackshield")
		--Stop other stage timers
		timerSeismicTremorsCD:Stop()
		timerEarthbreakerMissilesCD:Stop()
		timerCrushingPrismCD:Stop()
	elseif spellId == 368957 then
		self.vb.chargeCount = self.vb.chargeCount + 1
		specWarnVolatileCharges:Show(self.vb.chargeCount)
		specWarnVolatileCharges:Play("bombsoon")
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
			if self.vb.stageTotality then
				--use tabled timers during movements, regular CD during stanary subject to ICD live updates
				local checkedId = self:IsMythic() and 3652970 or 365297
				local timer = self.vb.phase == 1 and 26 or self:GetFromTimersTable(movementTimers, false, self.vb.stageTotality, checkedId, self.vb.crushingCast+1)
				if timer then
					timerCrushingPrismCD:Start(timer, self.vb.crushingCast+1)
				end
			end
		end
		if args:IsPlayer() then
			specWarnCrushingPrism:Show()
			specWarnCrushingPrism:Play("targetyou")
		end
		if self.Options.SetIconOnCrushing2 and self.vb.crushIcon < 8 then
			self:SetIcon(args.destName, self.vb.crushIcon)
		end
		warnCrushingPrism:CombinedShow(0.5, self.vb.crushingCast, args.destName)
		self.vb.crushIcon = self.vb.crushIcon + 1
	elseif spellId == 361309 and not args:IsPlayer() then--and not DBM:UnitDebuff("player", spellId)
		local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
		local remaining
		if expireTime then
			remaining = expireTime-GetTime()
		end
		if (not remaining or remaining and remaining < 3) and not UnitIsDeadOrGhost("player") then
			specWarnLightshatterBeamTaunt:Show(args.destName)
			specWarnLightshatterBeamTaunt:Play("tauntboss")
		end
	elseif spellId == 368671 then
		if self.Options.NPAuraOnFractal then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 368969 then
		if args:IsPlayer() then
			specWarnVolatileChargeYou:Show()
			specWarnVolatileChargeYou:Play("bombyou")
			yellVolatileCharge:Yell()
			yellVolatileChargeFades:Countdown(spellId, 3)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 368671 then
		if self.Options.NPAuraOnFractal then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
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
		timerSeismicTremorsCD:Start(4, 1)
		timerEarthbreakerMissilesCD:Start(11, 1)
		timerCrushingPrismCD:Start(17, 1)
		timerReclaimCD:Start(62, self.vb.reclaimCount+1)--My guess confirmed
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if (spellId == 361002 or spellId == 360114) and destGUID == UnitGUID("player") and not playerDebuff and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]
