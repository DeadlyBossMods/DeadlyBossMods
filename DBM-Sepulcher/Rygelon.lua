local mod	= DBM:NewMod(2467, "DBM-Sepulcher", nil, 1195)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(182777)
mod:SetEncounterID(2549)
mod:SetUsedIcons(1, 2, 3)
mod:SetHotfixNoticeRev(20220206000000)
--mod:SetMinSyncRevision(20220206000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 362806 362275 362390 366379 362184 363533 366606 364114 364386",
	"SPELL_CAST_SUCCESS 363108 363110",
	"SPELL_AURA_APPLIED 361548 362273 362206 362088 362081 362207 363773",
	"SPELL_AURA_APPLIED_DOSE 362273 362088 362081",
	"SPELL_AURA_REMOVED 361548 362273 362206 362088 362081 362207 363773",
	"SPELL_PERIODIC_DAMAGE 362798",
	"SPELL_PERIODIC_MISSED 362798",
	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, number of dark eclipse targets. if only 1, kill the icon stuff
--TODO, https://ptr.wowhead.com/spell=362172/corrupted-wound is gonna need more evalulation to determine action. prob not taunt at stacks but at dot size?
--TODO, probably upgrade Terminator warning and fix it's triggers
--TODO, how to actuall warn unstable matter if it has fixed timed spawns etc or if unstable matter field should have 20 second "active" timer
--TODO, maybe personal https://ptr.wowhead.com/spell=362384/eternal-radiation stack warning?
--TODO, how to warn https://ptr.wowhead.com/spell=368080/dark-quasar? does it apply multiple stacks on boss then just warn as they deplete?
--TODO, no fucking idea, even after 2 days of studying journal, now the singularity works. the spell data literally says opposite of journal about bosse presence
--TODO, reset/start timers on https://ptr.wowhead.com/spell=363773/the-singularity being applied or removed on boss?
--General
local specWarnGTFO								= mod:NewSpecialWarningGTFO(362798, nil, nil, nil, 1, 8)

--local berserkTimer							= mod:NewBerserkTimer(600)
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

local timerDarkEclipseCD						= mod:NewAITimer(28.8, 361548, nil, nil, nil, 3)
local timerCelestialCollapseCD					= mod:NewAITimer(28.8, 362275, nil, nil, nil, 5)
local timerQuasarRadiation						= mod:NewBuffActiveTimer(21, 361548, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerManifestCosmosCD						= mod:NewAITimer(28.8, 362390, nil, nil, nil, 1, nil, DBM_COMMON_L.HEROIC_ICON)
local timerStellarShroudCD						= mod:NewAITimer(28.8, 366379, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON .. DBM_COMMON_L.MYTHIC_ICON)
local timerCorruptedStrikesCD					= mod:NewAITimer(28.8, 362184, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON, nil, 2, 3)
local timerCelestialTerminatorCD				= mod:NewAITimer(28.8, 363108, nil, nil, nil, 3)
local timerMassiveBangCD						= mod:NewAITimer(28.8, 363533, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerMassiveBang							= mod:NewCastTimer(10, 363533, nil, nil, nil, 5, nil, DBM_COMMON_L.DEADLY_ICON)

mod:AddRangeFrameOption(5, 362206)
mod:AddInfoFrameOption(362081, true)--Tracks just ejection on heroic but on mythic it tracks Irregularity
mod:AddSetIconOption("SetIconOnDarkEclipse", 361548, true, false, {1, 2, 3})
--mod:AddNamePlateOption("NPAuraOnBurdenofDestiny", 353432, true)
--The Singularity
local singularityName = DBM:GetSpellInfo(362207)
mod:AddTimerLine(singularityName)
local warnSingularity							= mod:NewYouAnnounce(362207, 1)
local warnGravitationalCollapse					= mod:NewCastAnnounce(364386, 4)

local specWarnShatterSphere						= mod:NewSpecialWarningSpell(364114, nil, nil, nil, 2, 2)
local specWarnGravitationalCollapse				= mod:NewSpecialWarningSoak(364386, "Tank", nil, nil, 3, 2)

local cosmicStacks = {}
local playerInSingularity = false
mod.vb.debuffIcon = 1
mod.vb.collapseCount = 0
mod.vb.coreCastCount = 0
mod.vb.coreCount = 0
mod.vb.chaddCount = 0
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
	self.vb.debuffIcon = 1
	self.vb.collapseCount = 0
	self.vb.coreCastCount = 0
	self.vb.coreCount = 0
	self.vb.chaddCount = 0
	self.vb.bangCount = 0
	timerDarkEclipseCD:Start(1)
	timerCelestialCollapseCD:Start(1)
	timerCorruptedStrikesCD:Start(1)
	timerCelestialTerminatorCD:Start(1)
	timerMassiveBangCD:Start(1)
	if self:IsHard() then
		timerManifestCosmosCD:Start(1)
		if self:IsMythic() then
			timerStellarShroudCD:Start(1)
			if self.Options.InfoFrame then
				--On mythic it's slightly more elaborate and involves coordinating a bunch of people around the new mechanic
				DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(362088))
				DBM.InfoFrame:Show(20, "table", cosmicStacks, 1)
			end
		else
			if self.Options.InfoFrame then
				--On heroic it's fairly straight forward swaps tracking only some people
				DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(362081))
				DBM.InfoFrame:Show(5, "table", cosmicStacks, 1)
			end
		end

	end
--	if self.Options.NPAuraOnBurdenofDestiny then
--		DBM:FireEvent("BossMod_EnableHostileNameplates")
--	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
--	if self.Options.NPAuraOnBurdenofDestiny then
--		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
--	end
end

function mod:OnTimerRecovery()
	if DBM:UnitAura("player", 362207) then
		playerInSingularity = true
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 362806 then
		self.vb.debuffIcon = 1
		timerDarkEclipseCD:Start()
	elseif spellId == 362275 then
		self.vb.collapseCount = self.vb.collapseCount + 1
		if self.Options.SpecWarn362275count then
			specWarnCelestialCollapse:Show(self.vb.collapseCount)
			specWarnCelestialCollapse:Play("specialsoon")--TEMP sound, I need to see what these look like to articulate a better sound replacement
		else
			warnCelestialCollapse:Show(self.vb.collapseCount)
		end
		timerCelestialCollapseCD:Start()
	elseif spellId == 362390 then
		self.vb.coreCastCount = self.vb.coreCastCount + 1
		self.vb.coreCount = self.vb.coreCount + self:IsMythic() and 3 or 1
		warnManifestCosmos:Show(self.vb.coreCastCount)
		timerManifestCosmosCD:Start()
	elseif spellId == 366379 then
		self.vb.chaddCount = self.vb.chaddCount + 1
		specWarnStellarShroud:Show(self.vb.chaddCount)
		specWarnStellarShroud:Play("aesoon")
		timerStellarShroudCD:Start()
	elseif spellId == 362184 then
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnCorruptedStrikes:Show()
			specWarnCorruptedStrikes:Play("defensive")
		end
	elseif spellId == 363533 then
		self.vb.bangCount = self.vb.bangCount + 1
		specWarnMassiveBang:Show(self.vb.bangCount)
		specWarnMassiveBang:Play("specialsoon")
		timerMassiveBangCD:Start()
		timerMassiveBang:Start()
		self:Schedule(5.5, bangDelay, self)
	elseif spellId == 366606 and self:AntiSpam(3, 2) then
		warnRadiantPlasma:Show()
	elseif spellId == 364114 then
		specWarnShatterSphere:Show()
		specWarnShatterSphere:Play("phasechange")--No idea what voice to use
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
	if (spellId == 363108 or spellId == 363110) and self:AntiSpam(3, 1) then
		warnCelestialTerminator:Show()
		timerCelestialTerminatorCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 361548 then
		local icon = self.vb.debuffIcon
		if self.Options.SetIconOnDarkEclipse then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnDarkEclipse:Show()
			specWarnDarkEclipse:Play("runout")
			yellDarkEclipse:Yell(icon, icon)
			yellDarkEclipseFades:Countdown(spellId, nil, icon)
		end
		warnDarkEclipse:CombinedShow(0.5, args.destName)
		self.vb.debuffIcon = self.vb.debuffIcon + 1
	elseif spellId == 362273 then
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
	elseif spellId == 363773 then--Boss Entering Singularity
		DBM:Debug("Boss Entered Singularity")
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
	elseif spellId == 363773 then--Boss Leaving Singularity
		DBM:Debug("Boss Left Singularity")
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

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 353193 then

	end
end
--]]
