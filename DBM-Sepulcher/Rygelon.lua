local mod	= DBM:NewMod(2467, "DBM-Sepulcher", nil, 1195)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(182777)
mod:SetEncounterID(2549)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
mod:SetHotfixNoticeRev(20220405000000)
mod:SetMinSyncRevision(20220308000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 362275 362390 366379 362184 363533 366606 364114 364386",
	"SPELL_CAST_SUCCESS 363108 363110",
	"SPELL_AURA_APPLIED 361548 362273 362206 362088 362081 362207 363773 362271 368082 368080",
	"SPELL_AURA_APPLIED_DOSE 362273 362088 362081 368080",
	"SPELL_AURA_REMOVED 361548 362273 362206 362088 362081 362207 363773 368082 368080",
	"SPELL_PERIODIC_DAMAGE 362798",
	"SPELL_PERIODIC_MISSED 362798",
	"UNIT_DIED"
)

--TODO, number of dark eclipse targets. if only 1, kill the icon stuff
--TODO, https://ptr.wowhead.com/spell=362172/corrupted-wound is gonna need more evalulation to determine action. prob not taunt at stacks but at dot size?
--TODO, probably upgrade Terminator warning and fix it's triggers
--TODO, how to actuall warn unstable matter if it has fixed timed spawns etc or if unstable matter field should have 20 second "active" timer
--TODO, maybe personal https://ptr.wowhead.com/spell=362384/eternal-radiation stack warning?
--TODO, how to warn https://ptr.wowhead.com/spell=368080/dark-quasar? does it apply multiple stacks on boss then just warn as they deplete?
--TODO, reset/start timers on https://ptr.wowhead.com/spell=363773/the-singularity being applied or removed on boss accurate?
--[[
(ability.id = 362806 or ability.id = 362275 or ability.id = 362390 or ability.id = 366379 or ability.id = 363533 or ability.id = 364114 or ability.id = 364386) and type = "begincast"
 or (ability.id = 363108 or ability.id = 363110 or ability.id = 362806) and type = "cast"
 or ability.id = 363773
 or (ability.id = 361548 or ability.id = 362806) and type = "applydebuff"
 or ability.id = 362184 and type = "begincast"
--]]
--General
local berserkTimer								= mod:NewBerserkTimer(600)
local specWarnGTFO								= mod:NewSpecialWarningGTFO(362798, nil, nil, nil, 1, 8)

--Rygelon
mod:AddTimerLine(DBM:EJ_GetSectionInfo(24245))
local warnDarkEclipse							= mod:NewTargetNoFilterAnnounce(361548, 3)
local warnCelestialCollapse						= mod:NewCountAnnounce(362275, 3)
local warnQuasarRadiation						= mod:NewStackAnnounce(362273, 4)
local warnEventHorizon							= mod:NewTargetAnnounce(362206, 3)
local warnManifestCosmos						= mod:NewCountAnnounce(362390, 2)
local warnCosmicCore							= mod:NewAddsLeftAnnounce(362770, 2)
local warnCosmicIrregularity					= mod:NewCountAnnounce(362088, 2)
local warnCelestialTerminator					= mod:NewSpellAnnounce(363108, 3)
local warnRadiantPlasma							= mod:NewSpellAnnounce(366606, 4)--No one is tanking him fail check
local warnDarkQuasarBoss						= mod:NewStackAnnounce(368080, 2)
local warnDarkQuasarBossFaded					= mod:NewEndAnnounce(368080, 1)

local specWarnDarkEclipse						= mod:NewSpecialWarningYou(361548, nil, nil, nil, 1, 2)
local yellDarkEclipse							= mod:NewShortPosYell(361548)
local yellDarkEclipseFades						= mod:NewIconFadesYell(361548)
local specWarnCelestialCollapse					= mod:NewSpecialWarningCount(362275, false, nil, nil, 1, 2)
local specWarnEventHorizon						= mod:NewSpecialWarningYou(362206, nil, nil, nil, 1, 2)
local yellEventHorizonFades						= mod:NewShortFadesYell(362206)
local specWarnCosmicIrregularity				= mod:NewSpecialWarningStack(362088, nil, 4, nil, nil, 1, 6, 4)
local specWarnStellarShroud						= mod:NewSpecialWarningCount(366379, nil, nil, nil, 2, 2, 4)
local specWarnCorruptedStrikes					= mod:NewSpecialWarningDefensive(362184, nil, nil, nil, 1, 2)
local specWarnMassiveBang						= mod:NewSpecialWarningCount(363533, nil, nil, nil, 2, 2)--First warn, begin cast
local specWarnMassiveBangEscape					= mod:NewSpecialWarningMoveTo(363533, nil, nil, nil, 3, 2)--Second warn if not in singularity by 4 sec
local specWarnDarkQuasarPersonal				= mod:NewSpecialWarningMoveAway(368082, nil, nil, nil, 1, 2)
local yellarkQuasarPersonal						= mod:NewShortFadesYell(368082)

local timerDarkEclipseCD						= mod:NewCDCountTimer(11, 361548, nil, nil, nil, 3)
local timerCelestialCollapseCD					= mod:NewCDCountTimer(20.6, 362275, nil, nil, nil, 5)
local timerQuasarRadiation						= mod:NewBuffActiveTimer(21, 361548, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerManifestCosmosCD						= mod:NewCDCountTimer(23.1, 362390, nil, nil, nil, 1, nil, DBM_COMMON_L.HEROIC_ICON)
local timerStellarShroudCD						= mod:NewCDCountTimer(28.8, 366379, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON .. DBM_COMMON_L.MYTHIC_ICON)
local timerCorruptedStrikesCD					= mod:NewCDTimer(6, 362184, nil, "Tank", 2, 5, nil, DBM_COMMON_L.TANK_ICON)
--local timerCelestialTerminatorCD				= mod:NewCDCountTimer(28.8, 363108, nil, nil, nil, 3)
local timerMassiveBangCD						= mod:NewCDCountTimer(28.8, 363533, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerMassiveBang							= mod:NewCastTimer(10, 363533, nil, nil, nil, 5, nil, DBM_COMMON_L.DEADLY_ICON)

mod:AddRangeFrameOption(5, 362206)
mod:AddInfoFrameOption(362081, false)--Tracks just ejection on heroic but on mythic it tracks Irregularity
mod:AddSetIconOption("SetIconOnDarkEclipse", 361548, true, false, {1, 2, 3}, true)
mod:AddSetIconOption("SetIconOnQuasar", 362275, false, true, {3, 4, 5, 6, 7, 8}, true)
--The Singularity
local singularityName = DBM:GetSpellInfo(362207)
mod:AddTimerLine(singularityName)
local warnSingularity							= mod:NewYouAnnounce(362207, 1)
local warnGravitationalCollapse					= mod:NewCastAnnounce(364386, 4)

local specWarnShatterSphere						= mod:NewSpecialWarningSpell(364114, nil, nil, nil, 2, 2)
local specWarnGravitationalCollapse				= mod:NewSpecialWarningSoak(364386, "Tank", nil, nil, 3, 2)

local timerShatterSphereCD						= mod:NewCDTimer(26.6, 364114, nil, nil, nil, 6)

local cosmicStacks = {}
local playerInSingularity = false
--Other Variables
mod.vb.eclipseIcon = 1
mod.vb.quasarIcon = 8
mod.vb.coreCount = 0
--Timer Variables
mod.vb.eclipseCount = 0
mod.vb.collapseCount = 0
mod.vb.cosmosCount = 0
mod.vb.shroudCount = 0
mod.vb.bangCount = 0

local function bangDelay(self)
	if not playerInSingularity then--TODO, maybe also check for Event Horizon if it doesn't also apply "The Singularity"
		specWarnMassiveBangEscape:Show(singularityName)
		specWarnMassiveBangEscape:Play("findshelter")
	end
end

function mod:OnCombatStart(delay)
	table.wipe(cosmicStacks)
	playerInSingularity = false
	self.vb.eclipseCount = 0
	self.vb.eclipseIcon = 1
	self.vb.quasarIcon = 8
	self.vb.collapseCount = 0
	self.vb.cosmosCount = 0
	self.vb.coreCount = 0
	self.vb.shroudCount = 0
	self.vb.bangCount = 0
	if self:IsMythic() then
		timerDarkEclipseCD:Start(6.8-delay, 1)
		timerStellarShroudCD:Start(8.1-delay, 1)
		timerCelestialCollapseCD:Start(9.3-delay, 1)
		timerCorruptedStrikesCD:Start(10.6-delay)
		timerManifestCosmosCD:Start(20-delay, 1)
--		timerCelestialTerminatorCD:Start(1, 1)--not in combat log, do later
		timerMassiveBangCD:Start(65-delay, 1)
		berserkTimer:Start(390-delay)
		if self.Options.InfoFrame then
			--On mythic it's slightly more elaborate and involves coordinating a bunch of people around the new mechanic
			DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(362088))
			DBM.InfoFrame:Show(20, "table", cosmicStacks, 1)
		end
	else--Rest are all same, and seem to have been tweaked in recent weeks too
		timerCorruptedStrikesCD:Start(4.5-delay)
		timerDarkEclipseCD:Start(7.3-delay, 1)
		timerCelestialCollapseCD:Start(9.5-delay, 1)
--		timerCelestialTerminatorCD:Start(1, 1)--not in combat log, do later
		timerMassiveBangCD:Start(61.7-delay, 1)
		if self:IsHeroic() then
			timerManifestCosmosCD:Start(16.7-delay, 1)
			if self.Options.InfoFrame then
				--On heroic it's fairly straight forward swaps tracking only some people
				DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(362081))
				DBM.InfoFrame:Show(5, "table", cosmicStacks, 1)
			end
		end
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:OnTimerRecovery()
	if DBM:UnitAura("player", 362207) then
		playerInSingularity = true
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 362275 then
		self.vb.collapseCount = self.vb.collapseCount + 1
		self.vb.quasarIcon = 8
		if self.Options.SpecWarn362275count then
			specWarnCelestialCollapse:Show(self.vb.collapseCount)
			specWarnCelestialCollapse:Play("specialsoon")--TEMP sound, I need to see what these look like to articulate a better sound replacement
		else
			warnCelestialCollapse:Show(self.vb.collapseCount)
		end
		if self.vb.collapseCount == 1 then--Only cast twice per cycle
			timerCelestialCollapseCD:Start(self:IsMythic() and 23.1 or 20.6, self.vb.collapseCount+1)--20.6
		end
	elseif spellId == 362390 then
		self.vb.cosmosCount = self.vb.cosmosCount + 1
		self.vb.coreCount = self.vb.coreCount + (self:IsMythic() and 3 or 1)
		warnManifestCosmos:Show(self.vb.cosmosCount)
		if (self:IsMythic() and self.vb.cosmosCount < 3) or self.vb.cosmosCount == 1 then
			timerManifestCosmosCD:Start(self:IsMythic() and 11.6 or 23.1, self.vb.cosmosCount+1)
		end
	elseif spellId == 366379 then
		self.vb.shroudCount = self.vb.shroudCount + 1
		specWarnStellarShroud:Show(self.vb.shroudCount)
		specWarnStellarShroud:Play("aesoon")
		if self.vb.shroudCount < 4 then
			timerStellarShroudCD:Start(self.vb.shroudCount == 2 and 14.9 or 16.2, self.vb.shroudCount+1)
		end
	elseif spellId == 362184 then
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnCorruptedStrikes:Show()
			specWarnCorruptedStrikes:Play("defensive")
		end
		timerCorruptedStrikesCD:Start()
	elseif spellId == 363533 then
		self.vb.bangCount = self.vb.bangCount + 1
		specWarnMassiveBang:Show(self.vb.bangCount)
		specWarnMassiveBang:Play("specialsoon")
		timerMassiveBang:Start()
		self:Schedule(5.5, bangDelay, self)
		if self:IsFated() then
			self:AffixEvent(1, 2)
		end
	elseif spellId == 366606 and self:AntiSpam(3, 1) then
		warnRadiantPlasma:Show()
	elseif spellId == 364114 then
		specWarnShatterSphere:Show()
		specWarnShatterSphere:Play("phasechange")--No idea what voice to use
		if self:IsFated() then
			self:AffixEvent(0)--Technically not needed, since at this time affix isn't cast more than once, but another affix might be
		end
	elseif spellId == 364386 then
		if self.Options.SpecWarn364386soak and playerInSingularity then
			specWarnGravitationalCollapse:Show()
			specWarnGravitationalCollapse:Play("helpsoak")
		else
			warnGravitationalCollapse:Show()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if args:IsSpellID(363108, 363110) and self:AntiSpam(3, 2) then
		warnCelestialTerminator:Show()
--		timerCelestialTerminatorCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 361548 then
		if self:AntiSpam(3, 3) then--TEMP, not in combat log yet
			self.vb.eclipseCount = self.vb.eclipseCount + 1
			self.vb.eclipseIcon = 1
			if self.vb.eclipseCount < 5 then
				timerDarkEclipseCD:Start(nil, self.vb.eclipseCount+1)--11
			end
		end
		local icon = self.vb.eclipseIcon
		if self.Options.SetIconOnDarkEclipse then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnDarkEclipse:Show()
			specWarnDarkEclipse:Play("runout")
			yellDarkEclipse:Yell(icon, icon)
			yellDarkEclipseFades:Countdown(spellId, nil, icon)
		end
		warnDarkEclipse:CombinedShow(0.75, args.destName)
		self.vb.eclipseIcon = self.vb.eclipseIcon + 1
	elseif spellId == 362273 and args:IsPlayer() then
		warnQuasarRadiation:Show(args.destName, args.amount or 1)
		timerQuasarRadiation:Stop()
		timerQuasarRadiation:Start()
	elseif spellId == 362206 then
		if args:IsPlayer() then
			specWarnEventHorizon:Show()
			specWarnEventHorizon:Play("range5")
			yellEventHorizonFades:Countdown(spellId)
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(5)
			end
		else
			warnEventHorizon:CombinedShow(1, args.destName)
		end
	elseif spellId == 362088 then
		local amount = args.amount or 1
		cosmicStacks[args.destName] = amount
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(cosmicStacks)
		end
		if args:IsPlayer() then
			if amount >= 4 then
				specWarnCosmicIrregularity:Show(amount)
				specWarnCosmicIrregularity:Play("stackhigh")
			else
				warnCosmicIrregularity:Show(amount)
			end
		end
	elseif spellId == 362081 then
		local amount = args.amount or 1
		if not self:IsMythic() then
			cosmicStacks[args.destName] = amount
			if self.Options.InfoFrame then
				DBM.InfoFrame:UpdateTable(cosmicStacks)
			end
		end
	elseif spellId == 362207 then
		if args:IsPlayer() then
			playerInSingularity = true
		end
	elseif spellId == 362271 then
		if self.Options.SetIconOnQuasar then
			self:ScanForMobs(args.sourceGUID, 2, self.vb.quasarIcon, 1, nil, 12, "SetIconOnQuasar")
		end
		self.vb.quasarIcon = self.vb.quasarIcon - 1
	elseif spellId == 368082 and args:IsPlayer() then
		specWarnDarkQuasarPersonal:Show()
		specWarnDarkQuasarPersonal:Play("runout")
		yellarkQuasarPersonal:Countdown(spellId, 2)
	elseif spellId == 368080 then
		warnDarkQuasarBoss:Cancel()
		warnDarkQuasarBoss:Schedule(0.3, args.destName, args.amount or 1)
	elseif spellId == 363773 then--Boss Entering Singularity
		timerDarkEclipseCD:Stop()
		timerCelestialCollapseCD:Stop()
		timerCorruptedStrikesCD:Stop()
--		timerCelestialTerminatorCD:Stop()
		timerMassiveBangCD:Stop()
		timerManifestCosmosCD:Stop()
		timerStellarShroudCD:Stop()

		timerCorruptedStrikesCD:Start(4.7)
		timerShatterSphereCD:Start(26.6)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 361548 then
		if self.Options.SetIconOnDarkEclipse then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellDarkEclipseFades:Cancel()
		end
	elseif spellId == 362273 then
		timerQuasarRadiation:Stop()
	elseif spellId == 362206 then
		if args:IsPlayer() then
			yellEventHorizonFades:Cancel()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
	elseif spellId == 362088 then
		cosmicStacks[args.destName] = nil
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(cosmicStacks)
		end
	elseif spellId == 362081 and not self:IsMythic() then
		cosmicStacks[args.destName] = nil
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(cosmicStacks)
		end
	elseif spellId == 362207 then
		if args:IsPlayer() then
			playerInSingularity = false
		end
	elseif spellId == 368082 and args:IsPlayer() then
		yellarkQuasarPersonal:Cancel()
	elseif spellId == 368080 then
		warnDarkQuasarBossFaded:Show()
	elseif spellId == 363773 then --Boss Leaving Singularity
		self.vb.eclipseCount = 0
		self.vb.collapseCount = 0
		self.vb.cosmosCount = 0
		self.vb.shroudCount = 0
		self.vb.bangCount = 0
		timerCorruptedStrikesCD:Stop()
		timerShatterSphereCD:Stop()
		if self:IsMythic() then
			timerDarkEclipseCD:Start(6.9, 1)--SUCCESS
			timerStellarShroudCD:Start(8.4, 1)
			timerCelestialCollapseCD:Start(9.6, 1)
			timerCorruptedStrikesCD:Start(10.8)
--			timerCelestialTerminatorCD:Start(3, 1)
			timerManifestCosmosCD:Start(19.9, 1)
			timerMassiveBangCD:Start(65, self.vb.bangCount+1)
		else
			timerCorruptedStrikesCD:Start(4.5)
			timerDarkEclipseCD:Start(7.1, 1)--SUCCESS
			timerCelestialCollapseCD:Start(9.5, 1)
--			timerCelestialTerminatorCD:Start(3, 1)
			timerMassiveBangCD:Start(61.5, self.vb.bangCount+1)
			if self:IsHeroic() then
				timerManifestCosmosCD:Start(16.8, 1)
			end
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 185884 then--Cosmic Core
		self.vb.coreCount = self.vb.coreCount - 1
		warnCosmicCore:Show(self.vb.coreCount)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 362798 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
