local mod	= DBM:NewMod(2463, "DBM-Sepulcher", nil, 1195)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(184915)
mod:SetEncounterID(2529)
mod:SetUsedIcons(1, 2, 3, 4)
--mod:SetHotfixNoticeRev(20210902000000)
--mod:SetMinSyncRevision(20210706000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 363340 364229 363408 360115 361676 365283 360977 362056 367079 359236",
	"SPELL_CAST_SUCCESS 365294 359235",
	"SPELL_AURA_APPLIED 363414 366015 365297 361309",--366016
--	"SPELL_AURA_APPLIED_DOSE 366016",
	"SPELL_AURA_REMOVED 363414 366015 365297",
--	"SPELL_PERIODIC_DAMAGE 361002 360114",
--	"SPELL_PERIODIC_MISSED 361002 360114",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, is materialize Obelisks a redundant alert? like if it's something he just does on pull and that's it, no need for alert
--TODO, figure out which (or if both) earthbreaker missiles cast spells are used.
--TODO, number of droplets for accurate icon marking, possibly improve it with auto pairing
--TODO, what do with lance? https://ptr.wowhead.com/spell=361324/lance#see-also-other Doesn't seem consequential
--TODO, improve messaging on lightshatter Beam and improve debuff with nameplate aura etc once known what debuff is for (which mob/pillars)
--TODO, enable GTFO once it's confirmed debuff doesn't actually linger when you leave pool, misleading tooltip
--TODO, detonation cast more than once?
--TODO, some mechanics were removed/replaced. verify new spells
--TODO, are tanks supposed to trigger lightburst on purpose, or actively try to avoid triggering it with smart tank swaps?
--TODO, Ephemeral Droplet and Rain deleted too or moved to mythic and not reflected in journal yet?
--TODO, w y did crushing prism have icon yells and icons again?
--Stage One: The Reclaimer
local warnReclamationForm						= mod:NewCastAnnounce(359235, 2)
local warnMaterializeObelisks					= mod:NewSpellAnnounce(363340, 2)
--local warnEphemeralEngine						= mod:NewStackAnnounce(366016, 4, nil, "Tank|Healer")--No longer in journal, probably scrapped
local warnEphemeralDroplet						= mod:NewTargetNoFilterAnnounce(366015, 4)
local warnCrushingPrism							= mod:NewSpellAnnounce(365297, 3, nil, "RemoveMagic")
--Stage Two: The Shimmering Cliffs
local warnRelocationForm						= mod:NewCastAnnounce(359236, 2)

--Stage One: The Reclaimer
local specWarnDematerialize						= mod:NewSpecialWarningSpell(363408, nil, nil, nil, 3, 2)
--local specWarnReclaim							= mod:NewSpecialWarningCount(360115, false, nil, nil, 1, 2)--Replaced by Subterranean Scan?
local specWarnSubterraneanScan					= mod:NewSpecialWarningCount(367079, false, nil, nil, 1, 2)
local specWarnEarthbreakerMissiles				= mod:NewSpecialWarningMoveAway(361676, nil, nil, nil, 2, 2)
local specWarnEphemeralRain						= mod:NewSpecialWarningDodge(366011, nil, nil, nil, 2, 2)
local specWarnEphemeralDroplet					= mod:NewSpecialWarningYouPos(366015, nil, nil, nil, 1, 2)--Likely moved to mythic, it's no longer in non mythic
local yellEphemeralDroplet						= mod:NewShortPosYell(366015)
local yellEphemeralDropletFades					= mod:NewIconFadesYell(366015)
local specWarnLightshatterBeam					= mod:NewSpecialWarningDefensive(360977, nil, nil, nil, 1, 2)
local specWarnLightshatterBeamTaunt				= mod:NewSpecialWarningTaunt(361309, nil, nil, nil, 1, 2)
local specWarnCrushingPrism						= mod:NewSpecialWarningYou(365297, nil, nil, nil, 1, 2)
--local specWarnGTFO								= mod:NewSpecialWarningGTFO(361002, nil, nil, nil, 1, 8)
--Stage Two: The Shimmering Cliffs
local specWarnDetonation						= mod:NewSpecialWarningDodge(362056, nil, nil, nil, 2, 2)

--mod:AddTimerLine(BOSS)
--Stage One: The Reclaimer
local timerReclamationForm						= mod:NewCastTimer(6, 359235, nil, nil, nil, 6)
local timerMaterializeObelisksCD				= mod:NewAITimer(28.8, 363340, nil, nil, nil, 1)
local timerFractalShell							= mod:NewCastTimer(30, 364229, nil, nil, nil, 5, nil, DBM_COMMON_L.DAMAGE_ICON)
--local timerReclaimCD							= mod:NewAITimer(28.8, 360115, nil, nil, nil, 5)
local timerSubterraneanScanCD					= mod:NewAITimer(28.8, 367079, nil, nil, nil, 5)
local timerEarthbreakerMissilesCD				= mod:NewAITimer(28.8, 361676, nil, nil, nil, 3)
local timerEphemeralRainCD						= mod:NewAITimer(28.8, 366011, nil, nil, nil, 3)--Mythic now?
local timerLightshatterBeamCD					= mod:NewAITimer(30, 360977, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerCrushingPrismCD						= mod:NewAITimer(28.8, 365294, nil, nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)
--Stage Two: The Shimmering Cliffs
local timerRelocationForm						= mod:NewCastTimer(6, 359236, nil, nil, nil, 6)
local timerDetonationCD							= mod:NewAITimer(6, 362056, nil, nil, nil, 3)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("8")
mod:AddInfoFrameOption(363414, true)
mod:AddSetIconOption("SetIconOnEphemeralDroplet", 366015, true, false, {1, 2, 3, 4})
--mod:AddNamePlateOption("NPAuraOnBurdenofDestiny", 353432, true)

local trackedAbsorbGUIDS = {}
--mod.vb.reclaimCount = 0
mod.vb.scanCount = 0
mod.vb.dropletIcon = 1

function mod:OnCombatStart(delay)
	self:SetStage(1)--Maybe set in form instead, if form cast on pull
--	self.vb.reclaimCount = 0
	self.vb.scanCount = 0
	self.vb.dropletIcon = 1
	if self:AntiSpam(10, 3) then--temp, to prevent on pull double phase 1
		timerMaterializeObelisksCD:Start(1-delay)
--		timerReclaimCD:Start(1-delay)
		timerSubterraneanScanCD:Start(1-delay)
		timerEarthbreakerMissilesCD:Start(1-delay)
		timerEphemeralRainCD:Start(1-delay)
		timerLightshatterBeamCD:Start(1-delay)
		timerCrushingPrismCD:Start(1-delay)
	end
--	if self.Options.NPAuraOnBurdenofDestiny then
--		DBM:FireEvent("BossMod_EnableHostileNameplates")
--	end
end

function mod:OnCombatEnd()
	table.wipe(trackedAbsorbGUIDS)
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
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
	elseif spellId == 363408 and self:AntiSpam(10, 1) then
		specWarnDematerialize:Show()
		specWarnDematerialize:Play("stilldanger")
	elseif spellId == 367079 then
		self.vb.scanCount = self.vb.scanCount + 1
		specWarnSubterraneanScan:Show(self.vb.scanCount)--Text alert doesn't sasy what to do, just count
		if DBM:UnitDebuff("player", 365976) then
			--Avoid them
			specWarnSubterraneanScan:Play("watchorb")
		else
			--Soak 1
			specWarnSubterraneanScan:Play("helpsoak")
		end
		timerSubterraneanScanCD:Start()
--[[elseif spellId == 360115 then
		self.vb.reclaimCount = self.vb.reclaimCount + 1
		specWarnReclaim:Show(self.vb.reclaimCount)--Text alert doesn't sasy what to do, just count
		if DBM:UnitDebuff("player", 365976) then
			--Avoid them
			specWarnReclaim:Play("watchorb")
		else
			--Soak 1
			specWarnReclaim:Play("helpsoak")
		end
		timerReclaimCD:Start()--]]
	elseif spellId == 361676 or spellId == 365283 then
		specWarnEarthbreakerMissiles:Show()
		specWarnEarthbreakerMissiles:Play("scatter")
		timerEarthbreakerMissilesCD:Start()
	elseif spellId == 360977 then
		if self:IsTanking("player", nil, nil, nil, args.sourseGUID) then--Change to boss1 check if boss is always boss1, right now unsure
			specWarnLightshatterBeam:Show()
			specWarnLightshatterBeam:Play("defensive")
		end
		timerLightshatterBeamCD:Start()
	elseif spellId == 359236 then
		self:SetStage(2)
		warnRelocationForm:Show()
		timerRelocationForm:Start()
		--Stop stationary timers
		timerMaterializeObelisksCD:Stop()
--		timerReclaimCD:Stop()
		timerSubterraneanScanCD:Stop()
		timerEarthbreakerMissilesCD:Stop()
		timerEphemeralRainCD:Stop()
		timerLightshatterBeamCD:Stop()
		timerCrushingPrismCD:Stop()
		--Start mobile ones
		timerEarthbreakerMissilesCD:Start(2)
		timerDetonationCD:Start(2)
	elseif spellId == 362056 then
		specWarnDetonation:Show()
		specWarnDetonation:Play("watchorb")
		timerDetonationCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 365294 then
		warnCrushingPrism:Show()
		timerCrushingPrismCD:Start()
	elseif spellId == 359235 and self:AntiSpam(10, 3) then--Temp antispam in case he does this on pull too
		self:SetStage(1)
		warnReclamationForm:Show()
		timerReclamationForm:Start()
		--Stop mobile timers
		timerEarthbreakerMissilesCD:Stop()
		timerDetonationCD:Stop()
		--Start Stationary ones
		timerMaterializeObelisksCD:Start(2)
--		timerReclaimCD:Start(2)
		timerSubterraneanScanCD:Start(2)
		timerEarthbreakerMissilesCD:Start(2)
		timerEphemeralRainCD:Start(2)
		timerLightshatterBeamCD:Start(2)
		timerCrushingPrismCD:Start(2)
		--Start mobile ones
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 363414 then
		if not trackedAbsorbGUIDS[args.destGUID] then--Probably redundant, doubt an obelisk can have two shields
			trackedAbsorbGUIDS[args.destGUID] = true
		end
		if self.Options.InfoFrame then
			--Reinitilize infoframe even if it's visible because we added a new tracked GUID to table
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(5, "multienemyabsorb", nil, args.amount, trackedAbsorbGUIDS)
		end
--	elseif spellId == 366016 then
--		warnEphemeralEngine:Show(args.destName, args.amount or 1)
	elseif spellId == 366015 then
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
		if args:IsPlayer() then
			specWarnCrushingPrism:Show()
			specWarnCrushingPrism:Play("targetyou")
		end
	elseif spellId == 361309 and not args:IsPlayer() and not DBM:UnitDebuff("player", spellId) then
		specWarnLightshatterBeamTaunt:Show(args.destName)
		specWarnLightshatterBeamTaunt:Play("tauntboss")
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 363414 then
		trackedAbsorbGUIDS[args.destGUID] = nil
		if self.Options.InfoFrame then
			if #trackedAbsorbGUIDS == 0 then
				DBM.InfoFrame:Hide()
			else
				--Reinitilize infoframe even if it's visible because we removed a  tracked GUID from table
				DBM.InfoFrame:Show(5, "multienemyabsorb", nil, args.amount, trackedAbsorbGUIDS)
			end
		end
	elseif spellId == 366015 then
		if args:IsPlayer() then
			yellEphemeralDropletFades:Cancel()
		end
		if self.Options.SetIconOnEphemeralDroplet then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 365297 then
		if self.Options.SetIconOnCrushingPrism then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 183870 then--Guessed, based on creature summon script for Materialize Pylons
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
