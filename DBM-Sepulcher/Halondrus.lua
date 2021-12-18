local mod	= DBM:NewMod(2463, "DBM-Sepulcher", nil, 1195)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(180906)
mod:SetEncounterID(2529)
mod:SetUsedIcons(1, 2, 3, 4, 8)
mod:SetHotfixNoticeRev(20211216000000)
mod:SetMinSyncRevision(20211216000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 363340 364229 363408 361676 365283 360977 367079 359236 362056 364979",
	"SPELL_CAST_SUCCESS 365294 359235",
	"SPELL_AURA_APPLIED 366015 365297 361309",--366016
--	"SPELL_AURA_APPLIED_DOSE 366016",
	"SPELL_AURA_REMOVED 366015",
--	"SPELL_PERIODIC_DAMAGE 361002 360114",
--	"SPELL_PERIODIC_MISSED 361002 360114",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, number of droplets for accurate icon marking, possibly improve it with auto pairing
--TODO, enable GTFO once it's confirmed debuff doesn't actually linger when you leave pool, misleading tooltip
--TODO, are tanks supposed to trigger lightburst on purpose, or actively try to avoid triggering it with smart tank swaps? Need Mythic Timings
--TODO, Ephemeral Droplet and Rain deleted or moved to mythic and not reflected in journal yet?
--[[
(ability.id = 363340 or ability.id = 363408 or ability.id = 367079 or ability.id = 361676 or ability.id = 365283 or ability.id = 360977 or ability.id = 359236 or ability.id = 364979) and type = "begincast"
 or (ability.id = 365294 or ability.id = 359235) and type = "cast"
 or ability.id = 365297 and type = "applydebuff"
 or (ability.id = 364229 or ability.id = 362056) and type = "begincast"
--]]
--Stage One: The Reclaimer
local warnReclamationForm						= mod:NewCastAnnounce(359235, 2)
local warnMaterializeObelisks					= mod:NewSpellAnnounce(363340, 2)
local warnSubterraneanScan						= mod:NewCountAnnounce(367079, 2)
--local warnEphemeralEngine						= mod:NewStackAnnounce(366016, 4, nil, "Tank|Healer")--No longer in journal, probably scrapped
local warnEphemeralDroplet						= mod:NewTargetNoFilterAnnounce(366015, 4)
local warnCrushingPrism							= mod:NewCountAnnounce(365297, 3, nil, "RemoveMagic")
--Stage Two: The Shimmering Cliffs
local warnRelocationForm						= mod:NewCastAnnounce(359236, 2)

--Stage One: The Reclaimer
local specWarnDematerialize						= mod:NewSpecialWarningSpell(363408, nil, nil, nil, 3, 2)
local specWarnSubterraneanScan					= mod:NewSpecialWarningCount(367079, false, nil, nil, 1, 2)--Opt in, for someone that might be a soaker
local specWarnEarthbreakerMissiles				= mod:NewSpecialWarningMoveAway(361676, nil, nil, nil, 2, 2)
local specWarnEphemeralRain						= mod:NewSpecialWarningDodge(366011, nil, nil, nil, 2, 2)
local specWarnEphemeralDroplet					= mod:NewSpecialWarningYouPos(366015, nil, nil, nil, 1, 2, 4)--Likely moved to mythic, it's no longer in non mythic
local yellEphemeralDroplet						= mod:NewShortPosYell(366015)
local yellEphemeralDropletFades					= mod:NewIconFadesYell(366015)
local specWarnLightshatterBeam					= mod:NewSpecialWarningMoveTo(360977, nil, nil, nil, 1, 2)
local specWarnLightshatterBeamTaunt				= mod:NewSpecialWarningTaunt(361309, nil, nil, nil, 1, 2)
local specWarnCrushingPrism						= mod:NewSpecialWarningYou(365297, nil, nil, nil, 1, 2)
--local specWarnGTFO								= mod:NewSpecialWarningGTFO(361002, nil, nil, nil, 1, 8)
--Stage Two: The Shimmering Cliffs
local specWarnDetonation						= mod:NewSpecialWarningSwitch(362056, "Dps", nil, nil, 1, 2)

--mod:AddTimerLine(BOSS)
--Stage One: The Reclaimer
local timerMaterializeObelisksCD				= mod:NewCDTimer(28.8, 363340, nil, nil, nil, 1)
local timerFractalShell							= mod:NewCastTimer(30, 364229, nil, nil, nil, 5, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerSubterraneanScanCD					= mod:NewCDTimer(35, 367079, nil, nil, nil, 5)
local timerEarthbreakerMissilesCD				= mod:NewCDTimer(33.2, 361676, nil, nil, nil, 3)
local timerEphemeralRainCD						= mod:NewAITimer(28.8, 366011, nil, nil, nil, 3)--Mythic now?
local timerLightshatterBeamCD					= mod:NewCDTimer(14, 360977, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerCrushingPrismCD						= mod:NewCDCountTimer(43, 365294, nil, nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)
--Stage Two: The Shimmering Cliffs
local timerRelocationForm						= mod:NewCastTimer(6, 359236, nil, nil, nil, 6)
local timerDetonationCD							= mod:NewCDCountTimer(6, 362056, nil, nil, nil, 5, nil, DBM_COMMON_L.DAMAGE_ICON)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("8")
--mod:AddInfoFrameOption(363414, true)
mod:AddSetIconOption("SetIconOnEphemeralDroplet", 366015, true, false, {1, 2, 3, 4})
mod:AddSetIconOption("SetIconOnFractal", 364229, true, true, {8})
mod:AddSetIconOption("SetIconOnDetonation", 362056, true, true, {8})
--mod:AddNamePlateOption("NPAuraOnBurdenofDestiny", 353432, true)

mod.vb.scanCount = 0
mod.vb.dropletIcon = 1
mod.vb.detonateCast = 0
mod.vb.crushingCast = 0
local detonateTimers = {
	[2] = {27, 22.6},
	[4] = {20.4, 19.9, 6.9, 1, 10.7, 8.7},
}
local crushingTimers = {
--	[1] = {45.4, 45.4, 43.5},
	[2] = {34.9},
--	[3] = {46.9, 45.6, 42.3, 44.3},
	[4] = {12.7, 33, 24.2},
--	[5] = {36.7, 43.4, 46.6, 53.3, 42.9, 45.7},
}

--Scan triggers 3.5 second ICD
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
	if timerSubterraneanScanCD:GetRemaining() < ICD then
		local elapsed, total = timerSubterraneanScanCD:GetTime()
		local extend = ICD - (total-elapsed)
		DBM:Debug("timerSubterraneanScanCD extended by: "..extend, 2)
		timerSubterraneanScanCD:Stop()
		timerSubterraneanScanCD:Update(elapsed, total+extend)
	end
	if timerLightshatterBeamCD:GetRemaining() < ICD then
		local elapsed, total = timerLightshatterBeamCD:GetTime()
		local extend = ICD - (total-elapsed)
		DBM:Debug("timerLightshatterBeamCD extended by: "..extend, 2)
		timerLightshatterBeamCD:Stop()
		timerLightshatterBeamCD:Update(elapsed, total+extend)
	end
	if timerCrushingPrismCD:GetRemaining() < ICD then
		local elapsed, total = timerCrushingPrismCD:GetTime()
		local extend = ICD - (total-elapsed)
		DBM:Debug("timerCrushingPrismCD extended by: "..extend, 2)
		timerCrushingPrismCD:Stop()
		timerCrushingPrismCD:Update(elapsed, total+extend)
	end
end

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.scanCount = 0
	self.vb.dropletIcon = 1
	self.vb.crushingCast = 0
	timerMaterializeObelisksCD:Start(3.7-delay)
	timerLightshatterBeamCD:Start(11-delay)
	timerSubterraneanScanCD:Start(16.1-delay)--16.3-18.2
	timerEarthbreakerMissilesCD:Start(35.2-delay)--35.2-37
	timerCrushingPrismCD:Start(45.4-delay)
	if self:IsMythic() then
		timerEphemeralRainCD:Start(1-delay)--??
	end
--	if self.Options.NPAuraOnBurdenofDestiny then
--		DBM:FireEvent("BossMod_EnableHostileNameplates")
--	end
end

function mod:OnCombatEnd()
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
--	if self.Options.NPAuraOnBurdenofDestiny then
--		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
--	end
end

--[[
function mod:OnTimerRecovery()

end
--]]

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 363340 then
		warnMaterializeObelisks:Show()
		timerMaterializeObelisksCD:Start()
	elseif spellId == 364229 then
		timerFractalShell:Start(30, args.sourceGUID)
		if self.Options.SetIconOnFractal then
			self:ScanForMobs(args.sourceGUID, 2, 8, 1, nil, 12, "SetIconOnFractal")
		end
	elseif spellId == 363408 then
		if self:AntiSpam(10, 1) then
			specWarnDematerialize:Show()
			specWarnDematerialize:Play("stilldanger")
		end
		timerFractalShell:Stop(args.sourceGUID)--Auto canceled if Dematerialize starts
	elseif spellId == 367079 then
		self.vb.scanCount = self.vb.scanCount + 1
		if self.Options.SpecWarn367079count then
			specWarnSubterraneanScan:Show(self.vb.scanCount)--Text alert doesn't sasy what to do, just count
			if DBM:UnitDebuff("player", 365976) then
				--Avoid them
				specWarnSubterraneanScan:Play("watchorb")
			else
				--Soak 1
				specWarnSubterraneanScan:Play("helpsoak")
			end
		else
			warnSubterraneanScan:Show(self.vb.scanCount)
		end
		timerSubterraneanScanCD:Start()
		updateAllTimers(self, 3.5)
	elseif spellId == 361676 or spellId == 365283 then--361676 Confirmed on heroic, 365283 where?
		specWarnEarthbreakerMissiles:Show()
		specWarnEarthbreakerMissiles:Play("scatter")
		timerEarthbreakerMissilesCD:Start()
		updateAllTimers(self, 4.8)
	elseif spellId == 360977 then
		if self:IsTanking("player", nil, nil, nil, args.sourseGUID) then--Change to boss1 check if boss is always boss1, right now unsure
			specWarnLightshatterBeam:Show(L.Pylon)
			specWarnLightshatterBeam:Play("defensive")
		end
		timerLightshatterBeamCD:Start()
		updateAllTimers(self, 3.5)
	elseif spellId == 359236 then
		self:SetStage(2)--Stage, as determined by dungeon journal
		self.vb.detonateCast = 0
		self.vb.crushingCast = 0
		warnRelocationForm:Show()
		timerRelocationForm:Start()
		--Stop stationary timers
		timerMaterializeObelisksCD:Stop()
		timerSubterraneanScanCD:Stop()
		timerEarthbreakerMissilesCD:Stop()
		timerEphemeralRainCD:Stop()
		timerLightshatterBeamCD:Stop()
		timerCrushingPrismCD:Stop()
		--Start mobile ones
		--Halondrus is a phase 1, 2, 1, 2 boss.
		--We want to distinguish between first phase 2 and second phase 2 (per dungeon journals termonology)
		--So this is first mod in wows history that is actually using a stageTotality check.
		if self.vb.stageTotality == 2 then--First movement
			timerEarthbreakerMissilesCD:Start(13.6)--Was 41.4 in first half of testing, and 13.6 in second. Keep an eye on this
			timerDetonationCD:Start(27, 1)
			timerCrushingPrismCD:Start(34.4)
		else--Second movement (self.vb.stageTotality == 4)
			timerCrushingPrismCD:Start(12.6)
			timerDetonationCD:Start(20.4, 1)
			timerEarthbreakerMissilesCD:Start(32.6)
		end
	elseif spellId == 362056 then
		--USE for alert too if the detonate script gets hidden
		if self.Options.SetIconOnDetonation then
			self:ScanForMobs(args.sourceGUID, 2, 8, 1, nil, 12, "SetIconOnDetonation")
		end
	elseif spellId == 364979 then--Casts slightly faster than 362056
		specWarnDetonation:Show()
		specWarnDetonation:Play("targetchange")
		local timer = detonateTimers[self.vb.stageTotality][self.vb.detonateCast+1]
		if timer then
			timerDetonationCD:Start(timer, self.vb.detonateCast+1)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 365294 then
		DBM:AddMsg("Crushing Prism unhidden from combat log. Notify DBM Authors")
	elseif spellId == 359235 then
		self:SetStage(1)--Stage, as determined by dungeon journal
		self.vb.crushingCast = 0
		warnReclamationForm:Show()
		--Stop mobile timers
		timerEarthbreakerMissilesCD:Stop()
		timerDetonationCD:Stop()
		timerCrushingPrismCD:Stop()
		--Start Stationary ones
		timerMaterializeObelisksCD:Start(4.9)--4.9-5.3
		if self.vb.stageTotality == 3 then--Second stationary (after first movement)
			timerLightshatterBeamCD:Start(12.5)
			timerSubterraneanScanCD:Start(16.4)
			timerEarthbreakerMissilesCD:Start(35.8)
			timerCrushingPrismCD:Start(46.8, 1)
			if self:IsMythic() then
				timerEphemeralRainCD:Start(2)
			end
		else--Third stationary, after 2nd movement (stageTotality == 5)
			timerLightshatterBeamCD:Start(16)
			timerSubterraneanScanCD:Start(19.7)
			timerEarthbreakerMissilesCD:Start(28.2)
			timerCrushingPrismCD:Start(36.7, 1)
			if self:IsMythic() then
				timerEphemeralRainCD:Start(2)
			end
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 366015 then
		if self:AntiSpam(10, 2) then--Temp location, to ensure it is resetting
			self.vb.dropletIcon = 1
		end
		local icon = self.vb.dropletIcon
		if self.Options.SetIconOnEphemeralDroplet then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnEphemeralDroplet:Show(self:IconNumToTexture(icon))
			specWarnEphemeralDroplet:Play("mm"..icon)
			yellEphemeralDroplet:Yell(icon, icon)
			yellEphemeralDropletFades:Countdown(spellId, nil, icon)
		end
		warnEphemeralDroplet:CombinedShow(0.5, args.destName)
		self.vb.dropletIcon = self.vb.dropletIcon + 1
	elseif spellId == 365297 then
		if self:AntiSpam(5, 3) then
			self.vb.crushingCast = self.vb.crushingCast + 1
			warnCrushingPrism:Show(self.vb.crushingCast)
			--use tabled timers during movements, regular CD during stanary subject to ICD live updates
			local timer = self.vb.phase == 1 and 42.9 or crushingTimers[self.vb.stageTotality][self.vb.crushingCast+1]
			if timer then
				timerCrushingPrismCD:Start(timer, self.vb.crushingCast+1)
				updateAllTimers(self, 1.2)
			end
		end
		if args:IsPlayer() then
			specWarnCrushingPrism:Show()
			specWarnCrushingPrism:Play("targetyou")
		end
	elseif spellId == 361309 and not args:IsPlayer() and not DBM:UnitDebuff("player", spellId) then
		specWarnLightshatterBeamTaunt:Show(args.destName)
		specWarnLightshatterBeamTaunt:Play("tauntboss")
--	elseif spellId == 366016 then
--		warnEphemeralEngine:Show(args.destName, args.amount or 1)
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 366015 then
		if args:IsPlayer() then
			yellEphemeralDropletFades:Cancel()
		end
		if self.Options.SetIconOnEphemeralDroplet then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 183870 then--Pylons
		timerFractalShell:Stop(args.destGUID)
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

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 366009 then
		self.vb.dropletIcon = 1
		specWarnEphemeralRain:Show()
		specWarnEphemeralRain:Play("watchstep")
		timerEphemeralRainCD:Start()
	end
end
