local mod	= DBM:NewMod(2520, "DBM-Aberrus", nil, 1208)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(203284)
mod:SetEncounterID(2685)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
mod:SetHotfixNoticeRev(20230501000000)
--mod:SetMinSyncRevision(20221215000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 401383 401810 401500 401642 402050 401325 404027 404456 404769 411302 404754 404403 411030 407496 404288 411236 403771 405022 403625 403524 408422 401704",
--	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON 404505 404507",
	"SPELL_AURA_APPLIED 401951 401383 401215 403997 407576 401905 401680 401330 404218 404705 407496 404288 411241 405486 403520 408429",
	"SPELL_AURA_APPLIED_DOSE 401951 401383 403997 407576 401330 404269 411241 408429",
	"SPELL_AURA_REMOVED 401951 401383 401680 401330 404218 404705 407496 404288 404269 411241 403520 408429 401215",
	"SPELL_AURA_REMOVED_DOSE 401951 401383",
	"SPELL_PERIODIC_DAMAGE 406989",
	"SPELL_PERIODIC_MISSED 406989",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[

--]]
--NOTE, next to no chance Mass Disteingrate and Infinite Duress target debuffs stay public auras by time fight is reached on mythic. Both have incoming debuff alerts out the gate
--TODO, probably fix stacks for Howl on mythic. It probably just applies 2 stacks outright and not _DOSE event, like Sire did
--TODO, timer track https://www.wowhead.com/ptr/spell=410247/echoing-howl ? I suspect most would ignore DBM anyways and just have a WA for this
--TODO, verify Mass Disintegrate cast ID
--TODO, better handle triple breath stuff if it's incorrect
--TODO, drifting embers spawn count, if it's periodic spawn and not constant anyways https://www.wowhead.com/ptr/spell=402746/drifting-embers
--TODO, switch to https://www.wowhead.com/ptr/spell=410631/void-empowerment if the specific phase scripts don't work, using applied/removed and stage = stage + 1
--TODO, what kind of warning for flowers? Dodge for now but may be wrong
--TODO, track https://www.wowhead.com/ptr/spell=404269/ebon-might stacks? or is nameplate aura at 5 stacks enough?
--TODO, old void claws used on lfr/normal? https://www.wowhead.com/ptr/spell=403364/void-claws and 403358
--TODO, clearer understanding of Hurtling Barrage is needed (how many, how many targets, etc). Also if the target aura is hidden or not
--TODO, add incoming alert for nothingness if debuff target aura is hidden
--TODO, verify tank debuff durations
--General
local warnOblivionStack						= mod:NewCountAnnounce(401951, 2, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(401951))
local warnMindFragment						= mod:NewAddsLeftAnnounce(403997, 1)--Not technically adds, but wording of option and alert text is ambigious that it doesn't matter, it fits
local warnEmptynessBetweenStars				= mod:NewFadesAnnounce(401215, 1)
local warnAstralFlare						= mod:NewCountAnnounce(407576, 1, nil, false, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(407576))--Optional, don't want it to drown out the important messages of collecting mind fragments

local specWarnOblivionStack					= mod:NewSpecialWarningStack(401951, nil, 12, nil, nil, 1, 6)
local specWarnEmptynessBetweenStars			= mod:NewSpecialWarningYou(401215, nil, nil, nil, 1, 2)
local specWarnGTFO							= mod:NewSpecialWarningGTFO(406989, nil, nil, nil, 1, 8)

local timerEmptynessBetweenStars			= mod:NewBuffFadesTimer(15, 401215, nil, nil, nil, 3)
--local berserkTimer							= mod:NewBerserkTimer(600)

mod:AddInfoFrameOption(401951, true)
mod:AddMiscLine(DBM_CORE_L.OPTION_CATEGORY_DROPDOWNS)
mod:AddDropdownOption("InfoFrameBehavior", {"OblivionOnly", "HowlOnly", "Hybrid"}, "Hybrid", "misc")
--Stage One: The Legacy of the Dracthyr
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26140))
local warnOppressingHowl						= mod:NewCountAnnounce(401383, 3)
local warnDazzled								= mod:NewTargetNoFilterAnnounce(401905, 4, nil, false)--Not entirely much you can do about it's a lot but if it's a couple, a healer might want to see this to TRY and save them
local warnMassDisintegrate						= mod:NewTargetCountAnnounce(401642, 3, nil, nil, nil, nil, nil, nil, true)
local warnBurningClaws							= mod:NewStackAnnounce(401325, 2, nil, "Tank|Healer")

local specWarnGlitteringSurge					= mod:NewSpecialWarningCount(401810, nil, nil, nil, 2, 2)
local specWarnScorchingBomb						= mod:NewSpecialWarningCount(401500, nil, nil, nil, 2, 2)
local specWarnMassDisintegrate					= mod:NewSpecialWarningIncomingCount(401642, nil, nil, nil, 1, 14)
local specWarnMassDisintegrateYou				= mod:NewSpecialWarningYou(401642, nil, nil, nil, 1, 2)
local yellMassDisintegrate						= mod:NewShortPosYell(401642)
local yellMassDisintegrateFades					= mod:NewIconFadesYell(401642)
local specWarnSearingBreath						= mod:NewSpecialWarningCount(402050, nil, nil, nil, 2, 2)
--local specWarnDriftingEmbers					= mod:NewSpecialWarningDodgeCount(402746, nil, nil, nil, 2, 2)
local specWarnBurningClaws						= mod:NewSpecialWarningDefensive(401325, nil, nil, nil, 1, 2)
local specWarnBurningClawsTaunt					= mod:NewSpecialWarningTaunt(401325, nil, nil, nil, 1, 2)

local timerOppressingHowlCD						= mod:NewAITimer(29.9, 401383, nil, nil, nil, 2)
local timerGlitteringSurgeCD					= mod:NewAITimer(29.9, 401810, nil, nil, nil, 2)
local timerScorchingBombCD						= mod:NewAITimer(29.9, 401500, nil, nil, nil, 3)
local timerMassDisintegrateCD					= mod:NewAITimer(29.9, 401642, nil, nil, nil, 3)
local timerSearingBreathCD						= mod:NewAITimer(29.9, 402050, nil, nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)
--local timerDriftingEmbersCD					= mod:NewAITimer(29.9, 402746, nil, nil, nil, 3, nil, DBM_COMMON_L.HEROIC_ICON)
local timerBurningClawsCD						= mod:NewAITimer(29.9, 401325, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerBurningClaws							= mod:NewTargetTimer(27, 401325, nil, "Tank|Healer", nil, 2, nil, DBM_COMMON_L.TANK_ICON)--AOE damage from expiring

--mod:AddInfoFrameOption(361651, true)
--mod:AddRangeFrameOption(5, 390715)
mod:AddSetIconOption("SetIconOnMassDisintegrate", 401642, true, 0, {1, 2, 3, 4})
--mod:GroupSpells(390715, 396094)
--Stage Two: A Touch of the Forbidden
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26142))
local warnVoidFracture							= mod:NewTargetAnnounce(404218, 3, nil, false)
local warnInfiniteDuress						= mod:NewTargetCountAnnounce(404288, 3, nil, nil, nil, nil, nil, nil, true)
local warnVoidClaws								= mod:NewStackAnnounce(411236, 2, nil, "Tank|Healer")

local specWarnVoidBomb							= mod:NewSpecialWarningCount(404027, nil, nil, nil, 2, 2)
local specWarnVoidFracture						= mod:NewSpecialWarningYou(404218, nil, nil, nil, 1, 2)--Maybe change to MoveTo alert to say move to emptyness?
local yellVoidFractureFades						= mod:NewShortFadesYell(404218)
local specWarnAbyssalBreath						= mod:NewSpecialWarningCount(404456, nil, nil, nil, 2, 2)
local specWarnEmptyStrike						= mod:NewSpecialWarningDefensive(404769, nil, nil, nil, 1, 2, 4)
local specWarnCosmicVolley						= mod:NewSpecialWarningInterruptCount(411302, "HasInterrupt", nil, nil, 1, 2, 4)
local specWarnBlastingScream					= mod:NewSpecialWarningInterruptCount(404754, "HasInterrupt", nil, nil, 1, 2, 4)
local specWarnDesolateBlossom					= mod:NewSpecialWarningDodgeCount(404403, nil, nil, nil, 2, 2)
local specWarnInfiniteDuress					= mod:NewSpecialWarningIncomingCount(404288, nil, nil, nil, 1, 14)
local specWarnInfiniteDuressYou					= mod:NewSpecialWarningYou(404288, nil, nil, nil, 1, 2)
local yellInfiniteDuress						= mod:NewShortPosYell(404288)
local yellInfiniteDuressFades					= mod:NewIconFadesYell(404288)
local specWarnVoidClaws							= mod:NewSpecialWarningDefensive(411236, nil, nil, nil, 1, 2)
local specWarnVoidClawsOut						= mod:NewSpecialWarningMoveAway(411236, nil, nil, nil, 1, 2)
local yellVoidClawsFades						= mod:NewShortFadesYell(411236)
local specWarnVoidClawsTaunt					= mod:NewSpecialWarningTaunt(411236, nil, nil, nil, 1, 2)

local timerVoidBombCD							= mod:NewAITimer(29.9, 404027, nil, nil, nil, 3)
local timerAbyssalBreathCD						= mod:NewAITimer(29.9, 404456, nil, nil, nil, 3)
local timerEmptyStrikeCD						= mod:NewAITimer(29.9, 404769, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerCosmicVolleyCD						= mod:NewAITimer(29.9, 411302, nil, "HasInterrupt", nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)
local timerBlastingScreamCD						= mod:NewAITimer(29.9, 404754, nil, "HasInterrupt", nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)
local timerDesolateBlossomCD					= mod:NewAITimer(29.9, 404403, nil, nil, nil, 3)
local timerInfiniteDuressCD						= mod:NewAITimer(29.9, 404288, nil, nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)
local timerVoidClawsCD							= mod:NewAITimer(29.9, 411236, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerVoidClaws							= mod:NewTargetTimer(18, 411236, nil, "Tank|Healer", nil, 2, nil, DBM_COMMON_L.TANK_ICON)--AOE damage from expiring

mod:AddSetIconOption("SetIconOnEmptyRecollection", 404505, true, 5, {8})
mod:AddSetIconOption("SetIconOnNullGlimmer", 404507, true, 5, {7, 6, 5, 4})
mod:AddSetIconOption("SetIconOnInfiniteDuress", 404288, true, 0, {1, 2})
mod:AddNamePlateOption("NPAuraOnRescind", 404705)
mod:AddNamePlateOption("NPAuraOnMight", 404269)
--Stage Three: The Seas of Infinity
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26145))
local warnEmbraceofNothingness					= mod:NewTargetCountAnnounce(403524, 3, nil, nil, nil, nil, nil, nil, true)
local warnVoidSlash								= mod:NewStackAnnounce(408422, 2, nil, "Tank|Healer")

local specWarnCosmicAscension					= mod:NewSpecialWarningDodgeCount(403771, nil, nil, nil, 2, 2)
local specWarnHurtlingBarrage					= mod:NewSpecialWarningDodgeCount(405022, nil, nil, nil, 2, 2)--May be spammy as fuck if multiple of these pop off at once
local yellHurtlingBarrage						= mod:NewShortYell(405022)
local specWarnScouringEternity					= mod:NewSpecialWarningDodgeCount(403625, nil, nil, nil, 3, 2)
local specWarnEmbraceofNothingness				= mod:NewSpecialWarningYou(403524, nil, nil, nil, 1, 2)
local yellEmbraceofNothingness					= mod:NewShortYell(403524, nil, nil, nil, "YELL")
local yellEmbraceofNothingnessFades				= mod:NewShortFadesYell(403524, nil, nil, nil, "YELL")
--local specWarnMotesofOblivion					= mod:NewSpecialWarningDodgeCount(406428, nil, nil, nil, 2, 2)
local specWarnVoidSlash							= mod:NewSpecialWarningDefensive(408422, nil, nil, nil, 1, 2)
local specWarnVoidSlashOut						= mod:NewSpecialWarningMoveAway(408422, nil, nil, nil, 1, 2)
local yellVoidSlashFades						= mod:NewShortFadesYell(408422)
local specWarnVoidSlashTaunt					= mod:NewSpecialWarningTaunt(408422, nil, nil, nil, 1, 2)

local timerCosmicAscensionCD					= mod:NewAITimer(29.9, 403771, nil, nil, nil, 3)
local timerHurtlingBarrageCD					= mod:NewAITimer(29.9, 405022, nil, nil, nil, 3)
local timerScouringEternityCD					= mod:NewAITimer(29.9, 403625, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerEmbraceofNothingnessCD				= mod:NewAITimer(29.9, 403524, nil, nil, nil, 3)
--local timerMotesofOblivionCD					= mod:NewAITimer(29.9, 406428, nil, nil, nil, 3)
local timerVoidSlashCD							= mod:NewAITimer(29.9, 408422, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerVoidSlash							= mod:NewTargetTimer(18, 408422, nil, "Tank|Healer", nil, 2, nil, DBM_COMMON_L.TANK_ICON)--AOE damage from expiring

local oblivionStacks = {}
local howlStacks = {}
local castsPerGUID = {}
local usingHowl = true--Cache to avoid constant option table spamming
local oblivionDisabled = false--Cache to avoid constant option table spamming
--P1 Variables
mod.vb.howlCount = 0
mod.vb.surgeCount = 0
mod.vb.bombCount = 0
mod.vb.disintegrateCount = 0
mod.vb.disintegrateIcon = 1
mod.vb.breathSetCount = 0
mod.vb.breathCount = 0
--mod.vb.embersCount = 0
mod.vb.tankCount = 0
--P2 Variables
mod.vb.addIcon = 7
mod.vb.blossomCount = 0
--P3 Variables
mod.vb.nothingnessCount = 0

function mod:OnCombatStart(delay)
	table.wipe(oblivionStacks)
	table.wipe(howlStacks)
	table.wipe(castsPerGUID)
	self:SetStage(1)
	self.vb.howlCount = 0
	self.vb.surgeCount = 0
	self.vb.bombCount = 0
	self.vb.disintegrateCount = 0
	self.vb.breathSetCount = 0
	self.vb.breathCount = 0
	--self.vb.embersCount = 0
	self.vb.tankCount = 0
	self.vb.blossomCount = 0
	self.vb.nothingnessCount = 0
	timerOppressingHowlCD:Start(1-delay)
	timerGlitteringSurgeCD:Start(1-delay)
	timerScorchingBombCD:Start(1-delay)
	timerMassDisintegrateCD:Start(1-delay)
	timerSearingBreathCD:Start(1-delay)
	--timerDriftingEmbersCD:Start(1-delay)
	timerBurningClawsCD:Start(1-delay)
	if self.Options.NPAuraOnRescind or self.Options.NPAuraOnMight then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
	if self.Options.InfoFrame then
		if self.Options.InfoFrameBehavior == "OblivionOnly" then
			usingHowl = false--Means infoframe just shows oblivion entire fight and never shows howl
			oblivionDisabled = false
			DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(401951))
			DBM.InfoFrame:Show(20, "table", oblivionStacks, 1)
		else
			usingHowl = true
			if self.Options.InfoFrameBehavior == "HowlOnly" then
				oblivionDisabled = true--Means in phase 2 and 3 infoframe just closes
				--If hybrid is enabled, oblivionDisabled will be set to false on stage 2 trigger
			end
			DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(401383))
			DBM.InfoFrame:Show(20, "table", howlStacks, 1)
		end
	end
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.NPAuraOnRescind or self.Options.NPAuraOnMight then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end


function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 401383 then
		self.vb.howlCount = self.vb.howlCount + 1
		warnOppressingHowl:Show(self.vb.howlCount)
		timerOppressingHowlCD:Start()
	elseif spellId == 401810 then
		self.vb.surgeCount = self.vb.surgeCount + 1
		specWarnGlitteringSurge:Show(self.vb.surgeCount)
		specWarnGlitteringSurge:Play("aesoon")
		timerGlitteringSurgeCD:Start()
	elseif spellId == 401500 then
		self.vb.bombCount = self.vb.bombCount + 1
		specWarnScorchingBomb:Show(self.vb.bombCount)
		specWarnScorchingBomb:Play("bombsoon")
		timerScorchingBombCD:Start()
	elseif (spellId == 401642 or spellId == 401704) and self:AntiSpam(8, 1) then
		self.vb.disintegrateCount = self.vb.disintegrateCount + 1
		self.vb.disintegrateIcon = 1
		specWarnMassDisintegrate:Show(self.vb.disintegrateCount)
		specWarnMassDisintegrate:Play("incomingdebuff")
		timerMassDisintegrateCD:Start()
	elseif spellId == 402050 then
		if self:AntiSpam(10, 2) then
			self.vb.breathSetCount = self.vb.breathSetCount + 1
		end
		self.vb.breathCount = self.vb.breathCount + 1
		specWarnSearingBreath:Show(self.vb.breathSetCount .. "-" .. self.vb.breathCount)
		specWarnSearingBreath:Play("breathsoon")
		timerSearingBreathCD:Start()
	elseif spellId == 401325 then
		self.vb.tankCount = self.vb.tankCount + 1
		timerBurningClawsCD:Start()
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnBurningClaws:Show()
			specWarnBurningClaws:Play("defensive")
		end
	elseif spellId == 404027 then
		self.vb.bombCount = self.vb.bombCount + 1
		specWarnVoidBomb:Show(self.vb.bombCount)
		specWarnVoidBomb:Play("bombsoon")
		timerVoidBombCD:Start()
	elseif spellId == 404456 then
		self.vb.addIcon = 7
		self.vb.breathSetCount = self.vb.breathSetCount + 1
		specWarnAbyssalBreath:Show(self.vb.breathSetCount)
		specWarnAbyssalBreath:Play("breathsoon")
		timerAbyssalBreathCD:Start()
	elseif spellId == 411302 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
			if self.Options.SetIconOnEmptyRecollection then
				self:ScanForMobs(args.sourceGUID, 2, 8, 1, nil, 12, "SetIconOnEmptyRecollection")
			end
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then--Count interrupt, so cooldown is not checked
			specWarnCosmicVolley:Show(args.sourceName, count)
			if count < 6 then
				specWarnCosmicVolley:Play("kick"..count.."r")
			else
				specWarnCosmicVolley:Play("kickcast")
			end
		end
		timerCosmicVolleyCD:Start(nil, args.sourceGUID)
	elseif spellId == 404754 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
			if self.Options.SetIconOnNullGlimmer then
				self:ScanForMobs(args.sourceGUID, 2, self.vb.addIcon, 1, nil, 12, "SetIconOnNullGlimmer")
			end
			self.vb.addIcon = self.vb.addIcon - 1
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then--Count interrupt, so cooldown is not checked
			specWarnBlastingScream:Show(args.sourceName, count)
			if count < 6 then
				specWarnBlastingScream:Play("kick"..count.."r")
			else
				specWarnBlastingScream:Play("kickcast")
			end
		end
		timerBlastingScreamCD:Start(nil, args.sourceGUID)
	elseif spellId == 404769 then
		timerEmptyStrikeCD:Start(nil, args.sourceGUID)
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnEmptyStrike:Show()
			specWarnEmptyStrike:Play("defensive")
		end
	elseif spellId == 404403 or spellId == 411030 then--Hard/Easy
		self.vb.blossomCount = self.vb.blossomCount + 1
		specWarnDesolateBlossom:Show(self.vb.blossomCount)
		specWarnDesolateBlossom:Play("watchstep")
		timerDesolateBlossomCD:Start()
	elseif spellId == 407496 or spellId == 404288 then
		self.vb.disintegrateCount = self.vb.disintegrateCount + 1
		self.vb.disintegrateIcon = 1
		specWarnInfiniteDuress:Show(self.vb.disintegrateCount)
		specWarnInfiniteDuress:Play("incomingdebuff")
		timerInfiniteDuressCD:Start()
	elseif spellId == 411236 then
		self.vb.tankCount = self.vb.tankCount + 1
		timerVoidClawsCD:Start()
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnVoidClaws:Show()
			specWarnVoidClaws:Play("defensive")
		end
	elseif spellId == 403771 then
		self.vb.breathSetCount = self.vb.breathSetCount + 1
		specWarnCosmicAscension:Show(self.vb.breathSetCount)
		specWarnCosmicAscension:Play("watchstep")
		timerCosmicAscensionCD:Start()
	elseif spellId == 405022 then
		self.vb.surgeCount = self.vb.surgeCount + 1
		specWarnHurtlingBarrage:Show(self.vb.surgeCount)
		specWarnHurtlingBarrage:Play("farfromline")
		timerHurtlingBarrageCD:Start()
	elseif spellId == 403625 then
		self.vb.blossomCount = self.vb.blossomCount + 1
		specWarnScouringEternity:Show(self.vb.blossomCount)
		specWarnScouringEternity:Play("watchstep")
		timerScouringEternityCD:Start()
	elseif spellId == 403524 then
		self.vb.nothingnessCount = self.vb.nothingnessCount + 1
		--TODO, add incoming debuff alert if target aura is hidden
		timerEmbraceofNothingnessCD:Start()
	elseif spellId == 408422 then
		self.vb.tankCount = self.vb.tankCount + 1
		timerVoidSlashCD:Start()
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnVoidSlash:Show()
			specWarnVoidSlash:Play("defensive")
		end
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 394917 then

	end
end
--]]

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 404505 then--Empty Recollection (Mythic Add)
		if not castsPerGUID[args.destGUID] then
			castsPerGUID[args.destGUID] = 0
			if self.Options.SetIconOnEmptyRecollection then
				self:ScanForMobs(args.destGUID, 2, 8, 1, nil, 12, "SetIconOnEmptyRecollection")
			end
		end
		timerEmptyStrikeCD:Start(1, args.destGUID)
		timerCosmicVolleyCD:Start(1, args.destGUID)
	elseif spellId == 404507 then--Null Glimmer (regular adds)
		if not castsPerGUID[args.destGUID] then
			castsPerGUID[args.destGUID] = 0
			if self.Options.SetIconOnNullGlimmer then--Only use up to 5 icons
				self:ScanForMobs(args.destGUID, 2, self.vb.addIcon, 1, nil, 12, "SetIconOnNullGlimmer")
			end
			self.vb.addIcon = self.vb.addIcon - 1
		end
		timerBlastingScreamCD:Start(1, args.destGUID)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 401951 then
		local amount = args.amount or 1
		oblivionStacks[args.destName] = amount
		if args:IsPlayer() and amount % 3 == 0 then--3, 6, 9
			if amount < 6 then--3
				warnOblivionStack:Show(amount)
			else--6 and 9
				specWarnOblivionStack:Show(amount)
				specWarnOblivionStack:Play("stackhigh")
			end
		end
		if self.Options.InfoFrame and not oblivionDisabled then
			DBM.InfoFrame:UpdateTable(oblivionStacks, 0.2)
		end
	elseif spellId == 401383 then
		local amount = args.amount or 1
		howlStacks[args.destName] = amount
		if self.Options.InfoFrame and usingHowl then
			DBM.InfoFrame:UpdateTable(howlStacks, 0.2)
		end
	elseif spellId == 401215 then
		if args:IsPlayer() then
			specWarnEmptynessBetweenStars:Show()
			specWarnEmptynessBetweenStars:Play("stilldanger")
			yellVoidFractureFades:Cancel()
			local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
			if expireTime then--Buff has various durations based on difficulty, 15-25, this is just easiest
				local remaining = expireTime-GetTime()
				timerEmptynessBetweenStars:Start(remaining)
			end
		end
	elseif spellId == 403997 and args:IsPlayer() then
		local amount = args.amount or 1
		if amount < 3 then
			warnMindFragment:Show(3-amount)
		end
	elseif spellId == 407576 and args:IsPlayer() then
		local amount = args.amount or 1
		if amount % 2 == 0 then
			warnAstralFlare:Show(amount)
		end
	elseif spellId == 404269 then
		if (args.amount or 1) == 5 then
			if self.Options.NPAuraOnMight then
				DBM.Nameplate:Show(true, args.destGUID, spellId)
			end
		end
	elseif spellId == 401905 then
		warnDazzled:CombinedShow(0.5, args.destName)
	elseif spellId == 401680 then
		local icon = self.vb.disintegrateIcon
		if self.Options.SetIconOnMassDisintegrate then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnMassDisintegrateYou:Show()
			specWarnMassDisintegrateYou:Play("targetyou")
			yellMassDisintegrate:Yell(icon, icon)
			yellMassDisintegrateFades:Countdown(spellId, nil, icon)
		end
		warnMassDisintegrate:CombinedShow(0.3, self.vb.disintegrateCount, args.destName)
		self.vb.disintegrateIcon = self.vb.disintegrateIcon + 1
	elseif spellId == 407496 or spellId == 404288 then
		local icon = self.vb.disintegrateIcon
		if self.Options.SetIconOnInfiniteDuress then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnInfiniteDuressYou:Show()
			specWarnInfiniteDuressYou:Play("targetyou")
			yellInfiniteDuress:Yell(icon, icon)
			yellInfiniteDuressFades:Countdown(spellId, nil, icon)
		end
		warnInfiniteDuress:CombinedShow(0.3, self.vb.disintegrateCount, args.destName)
		self.vb.disintegrateIcon = self.vb.disintegrateIcon + 1
	elseif spellId == 401330 then
		local amount = args.amount or 1
		if amount >= 2 then--Guessed, if swapping is every 1 or 3, adjust
			if not args:IsPlayer() and not DBM:UnitDebuff("player", spellId) and not UnitIsDeadOrGhost("player") then
				specWarnBurningClawsTaunt:Show(args.destName)
				specWarnBurningClawsTaunt:Play("tauntboss")
			else
				warnBurningClaws:Show(args.destName, amount)
			end
		else
			warnBurningClaws:Show(args.destName, amount)
		end
		timerBurningClaws:Restart(27, args.destName)
	elseif spellId == 411241 then
		local amount = args.amount or 1
		if amount >= 2 then--Guessed, if swapping is every 1, adjust
			if not args:IsPlayer() and not DBM:UnitDebuff("player", spellId) and not UnitIsDeadOrGhost("player") then
				specWarnVoidClawsTaunt:Show(args.destName)
				specWarnVoidClawsTaunt:Play("tauntboss")
			else
				warnVoidClaws:Show(args.destName, amount)
				if args:IsPlayer() then
					specWarnVoidClawsOut:Cancel()
					specWarnVoidClawsOut:Schedule(12)
					specWarnVoidClawsOut:ScheduleVoice(12, "runout")
					yellVoidClawsFades:Cancel()
					yellVoidClawsFades:Countdown(spellId)
				end
			end
		else
			warnVoidClaws:Show(args.destName, amount)
		end
		timerVoidClaws:Restart(18, args.destName)
	elseif spellId == 408429 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then--Frontal filter, in case it can hit anyone that's in front of boss
			local amount = args.amount or 1
			if amount >= 2 then--Guessed, if swapping is every 1, adjust
				if not args:IsPlayer() and not DBM:UnitDebuff("player", spellId) and not UnitIsDeadOrGhost("player") then
					specWarnVoidSlashTaunt:Show(args.destName)
					specWarnVoidSlashTaunt:Play("tauntboss")
				else
					warnVoidSlash:Show(args.destName, amount)
					if args:IsPlayer() then
						specWarnVoidSlashOut:Cancel()
						specWarnVoidSlashOut:Schedule(12)
						specWarnVoidSlashOut:ScheduleVoice(12, "runout")
						yellVoidClawsFades:Cancel()
						yellVoidClawsFades:Countdown(spellId)
					end
				end
			else
				warnVoidSlash:Show(args.destName, amount)
			end
		end
		timerVoidSlash:Restart(21, args.destName)--Needs to show for even non tanks getting hit though
	elseif spellId == 404218 then
		if args:IsPlayer() then
			specWarnVoidFracture:Show()
			specWarnVoidFracture:Play("bombyou")
			if self:IsMythic() then
				--schedule for Dimensional Puncture
				yellVoidFractureFades:Countdown(spellId)
			end
		else
			warnVoidFracture:Show(args.destName)
		end
	elseif spellId == 404705 then
		if self.Options.NPAuraOnRescind then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 405486 then
		if args:IsPlayer() then
			yellHurtlingBarrage:Yell()
		end
	elseif spellId == 403520 then
		if args:IsPlayer() then
			specWarnEmbraceofNothingness:Show()
			specWarnEmbraceofNothingness:Play("gathershare")
			yellEmbraceofNothingness:Yell()
			yellEmbraceofNothingnessFades:Countdown(spellId)
		else
			warnEmbraceofNothingness:Show(self.vb.nothingnessCount, args.destName)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 401951 then
		oblivionStacks[args.destName] = nil
		if self.Options.InfoFrame and not oblivionDisabled then
			DBM.InfoFrame:UpdateTable(oblivionStacks, 0.2)
		end
	elseif spellId == 401383 then
		howlStacks[args.destName] = nil
		if self.Options.InfoFrame and usingHowl then
			DBM.InfoFrame:UpdateTable(howlStacks, 0.2)
		end
	elseif spellId == 401215 then
		if args:IsPlayer() then
			warnEmptynessBetweenStars:Show()
			timerEmptynessBetweenStars:Stop()
		end
	elseif spellId == 401680 then
		if self.Options.SetIconOnMassDisintegrate then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellMassDisintegrateFades:Cancel()
		end
	elseif spellId == 407496 or spellId == 404288 then
		if self.Options.SetIconOnInfiniteDuress then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellInfiniteDuressFades:Cancel()
		end
	elseif spellId == 401330 then
		timerBurningClaws:Stop(args.destName)
	elseif spellId == 411241 then
		if args:IsPlayer() then
			specWarnVoidClawsOut:Cancel()
			specWarnVoidClawsOut:CancelVoice()
			yellVoidClawsFades:Cancel()
		end
		timerVoidClaws:Stop(args.destName)
	elseif spellId == 408429 then
		if args:IsPlayer() then
			specWarnVoidSlashOut:Cancel()
			specWarnVoidSlashOut:CancelVoice()
			yellVoidClawsFades:Cancel()
		end
		timerVoidSlash:Stop(args.destName)--Needs to show for even non tanks getting hit though
	elseif spellId == 404218 then
		if args:IsPlayer() then
			yellVoidFractureFades:Cancel()
		end
	elseif spellId == 404705 then
		if self.Options.NPAuraOnRescind then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 404269 then
		if self.Options.NPAuraOnMight then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 403520 then
		if args:IsPlayer() then
			yellEmbraceofNothingnessFades:Cancel()
		end
	end
end

function mod:SPELL_AURA_REMOVED_DOSE(args)
	local spellId = args.spellId
	if spellId == 401951 then
		oblivionStacks[args.destName] = args.amount or 1
		if self.Options.InfoFrame and not oblivionDisabled then
			DBM.InfoFrame:UpdateTable(oblivionStacks, 0.2)
		end
	elseif spellId == 401383 then
		howlStacks[args.destName] = args.amount or 1
		if self.Options.InfoFrame and usingHowl then
			DBM.InfoFrame:UpdateTable(howlStacks, 0.2)
		end
	end
end


function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 406989 and destGUID == UnitGUID("player") and self:AntiSpam(3, 3) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 202971 then--Null Glimmer
		castsPerGUID[args.destGUID] = nil
		timerBlastingScreamCD:Stop(args.destGUID)
	elseif cid == 202969 then--Empty Recollection
		castsPerGUID[args.destGUID] = nil
		timerEmptyStrikeCD:Stop(args.destGUID)
		timerCosmicVolleyCD:Stop(args.destGUID)
	end
end

--https://www.wowhead.com/ptr/spell=402736/drifting-embers
--https://www.wowhead.com/ptr/spell=403308/void-empowerment
--https://www.wowhead.com/ptr/spell=404564/void-empowerment

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 403304 then--Guessed P1 to P2 cleanup script
		self:SetStage(2)
		self.vb.bombCount = 0--Reused for Void Bombs
		self.vb.breathSetCount = 0--Reused for Abyssal Breath
		self.vb.disintegrateCount = 0--Reused for Inifinite Duress
		self.vb.tankCount = 0----Reused for Void Claws
		timerOppressingHowlCD:Stop()
		timerGlitteringSurgeCD:Stop()
		timerScorchingBombCD:Stop()
		timerMassDisintegrateCD:Stop()
		timerSearingBreathCD:Stop()
		--timerDriftingEmbersCD:Stop()
		timerBurningClawsCD:Stop()
		timerVoidBombCD:Start(2)
		timerAbyssalBreathCD:Start(2)
		timerDesolateBlossomCD:Start(2)
		timerInfiniteDuressCD:Start(2)
		timerVoidClawsCD:Start(2)
		if self.Options.InfoFrame then
			--If oblivion only, no changes need to run on Phase 2
			if self.Options.InfoFrameBehavior == "Hybrid" then
				--Transition from Howl to Oblivion for phase 2 and phase 3
				usingHowl = false
				oblivionDisabled = false
				DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(401951))
				DBM.InfoFrame:Show(20, "table", oblivionStacks, 1)
			else
				--Just close it out, It was howl only
				if self.Options.InfoFrameBehavior == "HowlOnly" then
					DBM.InfoFrame:Hide()
				end
			end
		end
	elseif spellId == 408577 then--Guessed P2 to P3 cleanup script
		self:SetStage(3)
		self.vb.bombCount = 0--Reused for Void Bombs
		self.vb.breathSetCount = 0--Reused for Cosmic Ascension
		self.vb.surgeCount = 0--Reused for Hurtling Barrage
		self.vb.blossomCount = 0--Reused for Scouring Eternity
		self.vb.disintegrateCount = 0--Reused for Inifinite Duress
		--self.vb.embersCount--Reused for Motes of Oblivion
		self.vb.tankCount = 0----Reused for Void Slash
		timerVoidBombCD:Stop()
		timerAbyssalBreathCD:Stop()
		timerDesolateBlossomCD:Stop()
		timerInfiniteDuressCD:Stop()
		timerVoidClawsCD:Stop()
		timerVoidBombCD:Start(3)
		timerCosmicAscensionCD:Start(3)
		timerHurtlingBarrageCD:Start(3)
		timerScouringEternityCD:Start(3)
		timerEmbraceofNothingnessCD:Start(3)
		timerInfiniteDuressCD:Start(3)
		--timerMotesofOblivionCD:Start(3)
		timerVoidSlashCD:Start(3)
--	elseif spellId == 402736 then--Drifting Embers
--		self.vb.embersCount = self.vb.embersCount + 1
--		specWarnDriftingEmbers:Show(self.vb.embersCount)
--		specWarnDriftingEmbers:Play("watchstep")
--		timerDriftingEmbersCD:Start()
--	elseif spellId == 406427 then--Motesof Oblivion
--		self.vb.embersCount = self.vb.embersCount + 1
--		specWarnMotesofOblivion:Show(self.vb.embersCount)
--		specWarnMotesofOblivion:Play("watchstep")
--		timerMotesofOblivionCD:Start()
	end
end
