local mod	= DBM:NewMod(2491, "DBM-VaultoftheIncarnates", nil, 1200)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(184986)
mod:SetEncounterID(2605)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
--mod:SetHotfixNoticeRev(20220322000000)
--mod:SetMinSyncRevision(20211203000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 390548 373678 382563 373487 374022 372456 375450 374691 374215 376669 374427 374430 374623 374624 374622 391019 390796 392125 392192 392152 391268 393314 393295 393296 392098 393459 391267 393429 395893",
	"SPELL_CAST_SUCCESS 373415",
	"SPELL_SUMMON 374935 374931 374939 374943 393295 392098 393459",
	"SPELL_AURA_APPLIED 371971 372158 373487 372458 372514 372517 374779 374380 374427 391056 390921 391419 391265",
	"SPELL_AURA_APPLIED_DOSE 372158 374321",
	"SPELL_AURA_REMOVED 371971 373487 373494 372458 372514 374779 374380 374427 390921 391419 391265",
	"SPELL_PERIODIC_DAMAGE 374554 391555",
	"SPELL_PERIODIC_MISSED 374554 391555",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, number of lighting crash icons verified on all difficulties (spell data says 3-default)
--TODO, also add a stack too high warning on https://www.wowhead.com/beta/spell=373535/lightning-crash when strategies and tuning are established
--TODO, See how things play out with WA/BW on handling some of this bosses mechanics, right now drycode is steering clear of computational/solving for things and sticking to just showing them
--TODO, is https://www.wowhead.com/beta/npc=190807/seismic-rupture tangible or invisible script bunny
--TODO, is https://www.wowhead.com/beta/npc=190586/seismic-pillar tangible/in need of killing or no?
--TODO, GTFO https://www.wowhead.com/beta/spell=374705/seismic-rupture ?
--TODO, revisit thunder strike automation. May want to combine warnings to generalized warning instead of saying soak/avoid
--TODO, target scan https://www.wowhead.com/beta/spell=374622/storm-front ?
--TODO, announce https://www.wowhead.com/beta/spell=391555/raging-inferno spawns on mythic? They spawn from Searing
--TODO, smart change checker for https://www.wowhead.com/beta/spell=391272/icy-tempest on mythic
--TODO, is Sundering smash (391268) dodgable by tank? is it even aimed at tank?
--TODO, the abilities that are used by boss and add during stage 1/3, review if they are cast independantly and need independant Cds or if they're just cast at same time
--TODO, verify Dark Clouds mechanic on mythic
--TODO, add https://www.wowhead.com/beta/spell=374321/breaking-gravel if requires an actual tank swap to clear
--[[
(ability.id = 390548 or ability.id = 373678 or ability.id = 382563 or ability.id = 392125 or ability.id = 373487
 or ability.id = 374022 or ability.id = 392192 or ability.id = 392152 or ability.id = 372456 or ability.id = 375450 or ability.id = 395893
 or ability.id = 374691 or ability.id = 376669 or ability.id = 374215 or ability.id = 374427 or ability.id = 374430 or ability.id = 390920
 or ability.id = 374623 or ability.id = 374624 or ability.id = 374622 or ability.id = 391019 or ability.id = 391055
 or ability.id = 390796 or ability.id = 391268 or ability.id = 393314 or ability.id = 393309 or ability.id = 393295
 or ability.id = 393296 or ability.id = 392098 or ability.id = 393459 or ability.id = 391267 or ability.id = 393429) and type = "begincast"
 or ability.id = 373415 and type = "cast"
 or ability.id = 374779
--]]
--General
local specWarnGTFO								= mod:NewSpecialWarningGTFO(374554, nil, nil, nil, 1, 8)

--local berserkTimer							= mod:NewBerserkTimer(600)

--Stage One: Elemental Mastery
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25036))
--local warnElementalShift						= mod:NewSpellAnnounce(374861, 3)--Cast not logged, so removed for now
local warnSplinteredBones						= mod:NewStackAnnounce(372158, 2, nil, "Tank|Healer")

local specWarnSunderStrike						= mod:NewSpecialWarningDefensive(390548, nil, nil, nil, 1, 2)
local specWarnSplinteredBones					= mod:NewSpecialWarningTaunt(372158, nil, nil, nil, 1, 2)

local timerSunderStrikeCD						= mod:NewCDTimer(30.3, 390548, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--General timers for handling of bosses ability rotation
local timerDamageCD								= mod:NewTimer(30, "timerDamageCD", 391096, nil, nil, 3)--Magma Burst, Biting Chill, Enveloping Earth, Lightning Crash
local timerAvoidCD								= mod:NewTimer(60, "timerAvoidCD", 391100, nil, nil, 3)--Molten Rupture, Frigid Torrent, Erupting Bedrock, Shocking Burst
local timerUltimateCD							= mod:NewTimer(60, "timerUltimateCD", 374680, nil, nil, 3)--Searing Carnage, Absolute Zero, Seismic Rupture, Thunder Strike
local timerAddsCD								= mod:NewAddsTimer(60, 393314, nil, nil, nil, 1, nil, DBM_COMMON_L.MYTHIC_ICON)--60-66, blizz might have been playing with energy gains, or it's just that bad due to queuing

--mod:AddInfoFrameOption(361651, true)
mod:AddSetIconOption("SetIconOnLightningCrash", 373487, false, false, {1, 2, 3, 4, 5, 6, 7, 8})
mod:AddNamePlateOption("NPAuraOnSurge", 371971, true)

mod:GroupSpells(390548, 372158)--Tank cast with tank debuff
--Fire Altar An altar of primal fire
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25040))
--local warnBlisteringDominance					= mod:NewStackAnnounce(374881, 2)
--local warnSearingCarnage						= mod:NewTargetNoFilterAnnounce(374022, 3)

local specWarnMagmaBurst						= mod:NewSpecialWarningDodge(382563, nil, nil, nil, 2, 2)
local specWarnMoltenRupture						= mod:NewSpecialWarningDodge(373329, nil, nil, nil, 2, 2)
local specWarnSearingCarnage					= mod:NewSpecialWarningDodge(374022, nil, nil, nil, 2, 2)--Just warn everyone since it targets most of raid, even if it's not on YOU, you need to avoid it

----Mythic Only (Flamewrought Eradicator)
local specWarnFlamewroughtEradicator			= mod:NewSpecialWarningSwitch(393314, "-Healer", nil, nil, 1, 2)
local specWarnSunderingFlame					= mod:NewSpecialWarningDodge(393309, nil, nil, nil, 2, 2)

local timerFlamewroughtEradicatorCD				= mod:NewAITimer(35, 393314, nil, nil, nil, 1, nil, DBM_COMMON_L.MYTHIC_ICON)--Granyth Ability Selection
local timerSunderingFlameCD						= mod:NewAITimer(35, 393309, nil, nil, nil, 3)
--Frost Altar An altar of primal frost.
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25061))
--local warnChillingDominance						= mod:NewStackAnnounce(374916, 2)
local warnBitingChill							= mod:NewCountAnnounce(373678, 2)
local warnAbsoluteZero							= mod:NewTargetNoFilterAnnounce(372456, 3)
local warnFrostBite								= mod:NewFadesAnnounce(372514, 1)
local warnFrozenSolid							= mod:NewTargetNoFilterAnnounce(372517, 4, nil, false)--RL kinda thing

local specWarnFrigidTorrent						= mod:NewSpecialWarningDodge(391019, nil, nil, nil, 2, 2)--Cast by boss AND Dominator
local specWarnAbsoluteZero						= mod:NewSpecialWarningYouPos(372456, nil, nil, nil, 1, 2)
local yellAbsoluteZero							= mod:NewShortPosYell(372456)
local yellAbsoluteZeroFades						= mod:NewIconFadesYell(372456)

local timerFrostBite							= mod:NewBuffFadesTimer(30, 372514, nil, false, nil, 5)

mod:AddSetIconOption("SetIconOnAbsoluteZero", 372456, true, false, {1, 2})

mod:GroupSpells(372456, 372514, 372517)--Group all Below Zero mechanics together
----Mythic Only (Icebound Dominator)
local specWarnIceboundDominator					= mod:NewSpecialWarningSwitch(393295, "-Healer", nil, nil, 1, 2)
local specWarnFreezing							= mod:NewSpecialWarningMoveTo(391419, nil, nil, nil, 1, 2)--Effect of Icy Tempest (391425)
local specWarnSunderingFrost					= mod:NewSpecialWarningDodge(393296, nil, nil, nil, 2, 2)

local timerIceboundDominatorCD					= mod:NewAITimer(35, 393295, nil, nil, nil, 1, nil, DBM_COMMON_L.MYTHIC_ICON)--Granyth Ability Selection
local timerSunderingFrostCD						= mod:NewAITimer(35, 393296, nil, nil, nil, 3)
local timerFrigidTorrentCD						= mod:NewAITimer(60, 391019, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
--Earth Altar An altar of primal earth.
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25064))
--local warnShatteringDominance					= mod:NewStackAnnounce(374917, 2)
local warnEnvelopingEarth						= mod:NewTargetNoFilterAnnounce(391055, 4, nil, "Healer")

local specWarnEnvelopingEarth					= mod:NewSpecialWarningYou(391055, nil, nil, nil, 1, 2)
local specWarnEruptingBedrock					= mod:NewSpecialWarningRun(390796, "Melee", nil, nil, 2, 2)--Cast by boss AND Doppelboulder
local specWarnSeismicRupture					= mod:NewSpecialWarningDodge(374691, nil, nil, nil, 2, 2)

----Mythic Only (Ironwrought Smasher)
local specWarnIronwroughtSmasher				= mod:NewSpecialWarningSwitch(392098, "-Healer", nil, nil, 1, 2)
local specWarnSunderingSmash					= mod:NewSpecialWarningSpell(391268, nil, nil, nil, 1, 2)

local timerIronwroughtSmasherCD					= mod:NewAITimer(35, 392098, nil, nil, nil, 1, nil, DBM_COMMON_L.MYTHIC_ICON)--Granyth Ability Selection
local timerSunderingSmashCD						= mod:NewAITimer(35, 391268, nil, nil, nil, 3)--Ironwrought Smasher
local timerEruptingBedrockCD					= mod:NewCDTimer(60, 390796, nil, nil, nil, 2, nil, DBM_COMMON_L.MYTHIC_ICON)
--Storm Altar An altar of primal storm
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25068))
--local warnThunderingDominance					= mod:NewStackAnnounce(374918, 2)
local warnLightningCrash						= mod:NewTargetNoFilterAnnounce(373487, 4)
local warnShockingBurst							= mod:NewTargetNoFilterAnnounce(390920, 3)

local specWarnLightningCrash					= mod:NewSpecialWarningYouPos(373487, nil, nil, nil, 1, 2)
local yellLightningCrash						= mod:NewShortPosYell(373487)
local yellLightningCrashFades					= mod:NewIconFadesYell(373487)
--local specWarnLightningCrashStacks			= mod:NewSpecialWarningStack(373535, nil, 8, nil, nil, 1, 6)
local specWarnShockingBurst						= mod:NewSpecialWarningMoveAway(390920, nil, nil, nil, 1, 2)
local yellShockingBurst							= mod:NewShortYell(390920)
local yellShockingBurstFades					= mod:NewShortFadesYell(390920)
local specWarnThunderStrike						= mod:NewSpecialWarningSoak(374215, nil, nil, nil, 2, 2)--No Debuff
local specWarnThunderStrikeBad					= mod:NewSpecialWarningDodge(374215, nil, nil, nil, 2, 2)--Debuff

--mod:GroupSpells(373487, 373535)--Group Lighting crash source debuff with dest (nearest player) debuff
----Mythic Only (Stormwrought Despoiler)
local warnOrbLightning							= mod:NewTargetAnnounce(391267, 3)

local specWarnStormwroughtDespoiler				= mod:NewSpecialWarningSwitch(393459, "-Healer", nil, nil, 1, 2)
local specWarnOrbLightning						= mod:NewSpecialWarningMoveAway(373487, nil, nil, nil, 1, 2)
local yellOrbLightning							= mod:NewShortYell(391267)
local yellOrbLightningFades						= mod:NewShortFadesYell(391267)
local specWarnSunderingPeal						= mod:NewSpecialWarningDodge(393429, nil, nil, nil, 2, 2)

local timerStormwroughtDespoilerCD				= mod:NewAITimer(35, 393459, nil, nil, nil, 1, nil, DBM_COMMON_L.MYTHIC_ICON)--Granyth Ability Selection
local timerOrbLightningCD						= mod:NewAITimer(35, 391267, nil, nil, nil, 3)
local timerSunderingPealCD						= mod:NewAITimer(35, 393429, nil, nil, nil, 3)

--Stage Two: Summoning Incarnates
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25071))
mod:AddNamePlateOption("NPAuraOnElementalBond", 374380, true)
----Tectonic Crusher
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25073))
local warnBreakingGravel						= mod:NewStackAnnounce(374321, 2, nil, "Tank|Healer")

local specWarnGroundShatter						= mod:NewSpecialWarningMoveAway(374427, nil, nil, nil, 1, 2)
local yellGroundShatter							= mod:NewShortYell(374427)
local yellGroundShatterFades					= mod:NewShortFadesYell(374427)
local specWarnViolentUpheavel					= mod:NewSpecialWarningDodge(374430, nil, nil, nil, 2, 2)

local timerGroundShatterCD						= mod:NewCDTimer(33.4, 374427, nil, nil, nil, 3)
local timerViolentUpheavelCD					= mod:NewCDTimer(33.4, 374430, nil, nil, nil, 3)
local timerSeismicRuptureCD						= mod:NewAITimer(60, 374691, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)--Mythic Add version

----Frozen Destroyer
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25076))
local specWarnFrostBinds						= mod:NewSpecialWarningInterrupt(374623, "HasInterrupt", nil, nil, 1, 2)

local specWarnFreezingTempest					= mod:NewSpecialWarningMoveTo(374624, nil, nil, nil, 3, 2)

local timerFreezingTempestCD					= mod:NewCDTimer(37.7, 374624, nil, nil, nil, 2)
local timerAbsoluteZeroCD						= mod:NewAITimer(60, 372456, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)--Mythic Add version

----Blazing Fiend
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25079))
local timerSearingCarnageCD						= mod:NewAITimer(60, 374022, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)--Mythic Add version

----Thundering Destroyer
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25083))
local warnStormBreak							= mod:NewSpellAnnounce(374622, 3)

local timerStormBreakCD							= mod:NewCDTimer(20.8, 374622, nil, nil, nil, 2)
local timerThunderStrikeCD						= mod:NewAITimer(60, 374215, nil, nil, nil, 5, nil, DBM_COMMON_L.MYTHIC_ICON)--Mythic Add version

mod:AddRangeFrameOption(10, 374620)

mod.vb.chillCast = 0
mod.vb.litCrashIcon = 1
mod.vb.zeroIcon = 1
mod.vb.curAltar = false

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.chillCast = 0
	self.vb.curAltar = false
	timerSunderStrikeCD:Start(10.7-delay)
	timerDamageCD:Start(20.4-delay, " ")
	timerAvoidCD:Start(30.2-delay, " ")
	timerUltimateCD:Start(63.1-delay, " ")
	--if self:IsMythic() then
	--	timerAddsCD:Start(1-delay)
	--end
	if self.Options.NPAuraOnSurge or self.Options.NPAuraOnElementalBond then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
	if self.Options.NPAuraOnSurge or self.Options.NPAuraOnElementalBond then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 390548 then
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnSunderStrike:Show()
			specWarnSunderStrike:Play("defensive")
		end
		timerSunderStrikeCD:Start()
	elseif spellId == 373678 then
		self.vb.chillCast = self.vb.chillCast + 1
		warnBitingChill:Show(self.vb.chillCast)
	elseif spellId == 382563 or spellId == 392125 then--Non Mythic, Mythic
		specWarnMagmaBurst:Show()
		specWarnMagmaBurst:Play("watchwave")
	elseif spellId == 373487 then
		self.vb.litCrashIcon = 1
	elseif spellId == 374022 or spellId == 392192 or spellId == 392152 then--Normal/Heroic, LFR, Mythic (assumed)
		specWarnSearingCarnage:Show()
		specWarnSearingCarnage:Play("watchstep")
		if args:GetSrcCreatureID() ~= 184986 then--Mythic Add
			timerSearingCarnageCD:Start(nil, args.sourceGUID)
		end
	elseif spellId == 372456 or spellId == 375450 then--Hard, easy (assumed)
		self.vb.zeroIcon = 1
		if args:GetSrcCreatureID() ~= 184986 then--Mythic Add
			timerAbsoluteZeroCD:Start(nil, args.sourceGUID)
		end
	elseif spellId == 374691 then
		specWarnSeismicRupture:Show()
		specWarnSeismicRupture:Play("watchstep")
		if args:GetSrcCreatureID() ~= 184986 then--Mythic Add
			timerSeismicRuptureCD:Start(nil, args.sourceGUID)
		end
	elseif spellId == 376669 or spellId == 374215 then--Mythic, Non (assumed)
		if DBM:UnitDebuff("player", 373494) then--Vulnerable to nature damage
			specWarnThunderStrikeBad:Show()
			specWarnThunderStrikeBad:Play("watchstep")
		else
			specWarnThunderStrike:Show()
			specWarnThunderStrike:Play("helpsoak")
		end
		if args:GetSrcCreatureID() ~= 184986 then--Mythic Add
			timerThunderStrikeCD:Start(nil, args.sourceGUID)
		end
	elseif spellId == 374427 then
		timerGroundShatterCD:Start(nil, args.sourceGUID)
	elseif spellId == 374430 then
		specWarnViolentUpheavel:Show()
		specWarnViolentUpheavel:Play("watchstep")
		timerViolentUpheavelCD:Start(nil, args.sourceGUID)
	elseif spellId == 374623 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnFrostBinds:Show(args.sourceName)
		specWarnFrostBinds:Play("kickcast")
	elseif spellId == 374624 then
		specWarnFreezingTempest:Show(args.sourceName)
		specWarnFreezingTempest:Play("runin")
		timerFreezingTempestCD:Start(nil, args.sourceGUID)
	elseif spellId == 374622 then
		warnStormBreak:Show()
		timerStormBreakCD:Start(nil, args.sourceGUID)
	elseif spellId == 391019 then
		specWarnFrigidTorrent:Show()
		specWarnFrigidTorrent:Play("watchorb")
		if args:GetSrcCreatureID() ~= 184986 then--Mythic Add
			timerFrigidTorrentCD:Start(nil, args.sourceGUID)
		end
--	elseif spellId == 391055 then

	elseif spellId == 390796 or spellId == 395893 then--Hard, Easy
		specWarnEruptingBedrock:Show()
		specWarnEruptingBedrock:Play("justrun")
		if args:GetSrcCreatureID() ~= 184986 then--Mythic Add
			timerEruptingBedrockCD:Start(nil, args.sourceGUID)
		end
	--Mythic Stuff
	elseif spellId == 391268 then
		timerSunderingSmashCD:Start(nil, args.sourceGUID)
		if self:IsTanking("player", nil, nil, nil, args.sourceGUID) then
			specWarnSunderingSmash:Show()
			specWarnSunderingSmash:Play("carefly")
		end
	elseif spellId == 393314 then
		specWarnFlamewroughtEradicator:Show()
		specWarnFlamewroughtEradicator:Play("bigmob")
		timerFlamewroughtEradicatorCD:Start()
	elseif spellId == 393309 then
		specWarnSunderingFlame:Show()
		specWarnSunderingFlame:Play("shockwave")
		timerSunderingFlameCD:Start(nil, args.sourceGUID)
	elseif spellId == 393295 then
		specWarnIceboundDominator:Show()
		specWarnIceboundDominator:Play("bigmob")
		timerIceboundDominatorCD:Start()
	elseif spellId == 393296 then
		specWarnSunderingFrost:Show()
		specWarnSunderingFrost:Play("shockwave")
		timerSunderingFrostCD:Start(nil, args.sourceGUID)
	elseif spellId == 392098 then
		specWarnIronwroughtSmasher:Show()
		specWarnIronwroughtSmasher:Play("bigmob")
		timerIronwroughtSmasherCD:Start()
	elseif spellId == 393459 then
		specWarnStormwroughtDespoiler:Show()
		specWarnStormwroughtDespoiler:Play("bigmob")
		timerStormwroughtDespoilerCD:Start()
	elseif spellId == 391267 then
		timerOrbLightningCD:Start(nil, args.sourceGUID)
	elseif spellId == 393429 then
		specWarnSunderingPeal:Show()
		specWarnSunderingPeal:Play("shockwave")
		timerSunderingPealCD:Start(nil, args.sourceGUID)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 373415 then
		DBM:AddMsg("373415 is combat logging now, notify DBM author")
		--specWarnMoltenRupture:Show()
		--specWarnMoltenRupture:Play("farfromline")
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if args:IsSpellID(374935, 374931, 374939, 374943) then--Not logged
		if spellId == 374935 then--Frozen Incarnation
			timerFreezingTempestCD:Start(1, args.destGUID)
			--if self:IsMythic() then
			--	timerAbsoluteZeroCD:Start()
			--end
		elseif spellId == 374931 then--Blazing Incarnation
			--if self:IsMythic() then
			--	timerSearingCarnageCD:Start()
			--end
		elseif spellId == 374939 then--Tectonic Incarnation
			timerGroundShatterCD:Start(1, args.destGUID)
			timerViolentUpheavelCD:Start(1, args.destGUID)
			--if self:IsMythic() then
			--	timerSeismicRuptureCD:Start()
			--end
		elseif spellId == 374943 then--Thundering Incarnation
			timerStormBreakCD:Start(1, args.destGUID)
			--if self:IsMythic() then
			--	timerThunderStrikeCD:Start()
			--end
		end
	elseif spellId == 393314 then--Flamewrought Eradicator
		timerSunderingFlameCD:Start(1, args.destGUID)
	elseif spellId == 393295 then--Icewrought Dominator
		timerSunderingFrostCD:Start(1, args.destGUID)
	elseif spellId == 392098 then--Ironwrought Smasher
		timerSunderingSmashCD:Start(1, args.destGUID)
	elseif spellId == 393459 then--Stormwrought Despoiler
		timerOrbLightningCD:Start(1, args.destGUID)
		timerSunderingPealCD:Start(1, args.destGUID)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 371971 then
		if self.Options.NPAuraOnSurge then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 374321 then
		local amount = args.amount or 1
		if amount % 3 == 0 then
			warnBreakingGravel:Show(args.destName, amount)
		end
--	elseif spellId == 374881 then--Blistering Dominance
--		local amount = args.amount or 1
--		if amount % 3 == 0 then
--			warnBlisteringDominance:Show(args.destName, amount)
--		end
--	elseif spellId == 374916 then--ChillingDominance
--		local amount = args.amount or 1
--		if amount % 3 == 0 then
--			warnChillingDominance:Show(args.destName, amount)
--		end
--	elseif spellId == 374917 then--ShatteringDominance
--		local amount = args.amount or 1
--		if amount % 3 == 0 then
--			warnShatteringDominance:Show(args.destName, amount)
--		end
--	elseif spellId == 374918 then--Thundering
--		local amount = args.amount or 1
--		if amount % 3 == 0 then
--			warnThunderingDominance:Show(args.destName, amount)
--		end
	elseif spellId == 372158 and not args:IsPlayer() then
		local amount = args.amount or 1
		local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
		local remaining
		if expireTime then
			remaining = expireTime-GetTime()
		end
		if (not remaining or remaining and remaining < 6.1) and not UnitIsDeadOrGhost("player") and not self:IsHealer() then
			specWarnSplinteredBones:Show(args.destName)
			specWarnSplinteredBones:Play("tauntboss")
		else
			warnSplinteredBones:Show(args.destName, amount)
		end
	elseif spellId == 373487 then
		local icon = self.vb.litCrashIcon
		if self.Options.SetIconOnLightningCrash and icon < 9 then--On 30 man it's 9 icons :\
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnLightningCrash:Show(self:IconNumToTexture(icon))
			specWarnLightningCrash:Play("mm"..icon)
			yellLightningCrash:Yell(icon, icon)
			yellLightningCrashFades:Countdown(spellId, nil, icon)
		end
		warnLightningCrash:CombinedShow(0.5, args.destName)
		self.vb.litCrashIcon = self.vb.litCrashIcon + 1
	elseif spellId == 372458 then
		local icon = self.vb.zeroIcon
		if self.Options.SetIconOnAbsoluteZero then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnAbsoluteZero:Show(self:IconNumToTexture(icon))
			specWarnAbsoluteZero:Play("mm"..icon)
			yellAbsoluteZero:Yell(icon, icon)
			yellAbsoluteZeroFades:Countdown(spellId, nil, icon)
		else
			warnAbsoluteZero:CombinedShow(0.5, args.destName)
		end
		self.vb.zeroIcon = self.vb.zeroIcon + 1
	elseif spellId == 372514 and args:IsPlayer() then
		timerFrostBite:Start()
	elseif spellId == 372517 then
		warnFrozenSolid:CombinedShow(1, args.destName)
	elseif spellId == 374779 then--Primal Barrier
		self:SetStage(2)
		--Base
		timerSunderStrikeCD:Stop()

		timerDamageCD:Stop()
		timerAvoidCD:Stop()
		timerUltimateCD:Stop()
		timerAddsCD:Stop()
	elseif spellId == 374380 then
		if self.Options.NPAuraOnElementalBond then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 374427 then
		if args:IsPlayer() then
			specWarnGroundShatter:Show()
			specWarnGroundShatter:Play("runout")
			yellGroundShatter:Yell()
			yellGroundShatterFades:Countdown(spellId)
		end
	elseif spellId == 391056 then
		warnEnvelopingEarth:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnEnvelopingEarth:Show()
			specWarnEnvelopingEarth:Play("checkhp")
		end
	elseif spellId == 390921 then
		if args:IsPlayer() then
			specWarnShockingBurst:Show()
			specWarnShockingBurst:Play("runout")
			yellShockingBurst:Yell()
			yellShockingBurstFades:Countdown(spellId)
		end
		warnShockingBurst:CombinedShow(0.5, args.destName)
	elseif spellId == 391419 and args:IsPlayer() then
		--Players will get debuff a lot for momentary moves, we don't want to spam them to death
		--So we schedule a check after 2.5 seconds (to give them 3.5 to find allies)
		specWarnFreezing:Cancel()
		specWarnFreezing:Schedule(2.5, DBM_COMMON_L.ALLIES)--Might adjust timing
		specWarnFreezing:ScheduleVoice(2.5, "gathershare")
	elseif spellId == 391265 then
		if args:IsPlayer() then
			specWarnOrbLightning:Show()
			specWarnOrbLightning:Play("runout")
			yellOrbLightning:Yell()
			yellOrbLightningFades:Countdown(spellId)
		end
		warnOrbLightning:CombinedShow(0.5, args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 371971 then
		if self.Options.NPAuraOnSurge then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 373487 then
--		if self.Options.SetIconOnLightningCrash then
--			self:SetIcon(args.destName, 0)
--		end
		if args:IsPlayer() then
			yellLightningCrashFades:Cancel()
		end
	elseif spellId == 373494 then--Icon removed off secondary debuff
		if self.Options.SetIconOnLightningCrash then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 372458 then
		if self.Options.SetIconOnAbsoluteZero then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellAbsoluteZeroFades:Cancel()
		end
	elseif spellId == 372514 and args:IsPlayer() then
		warnFrostBite:Show()
		timerFrostBite:Stop()
	elseif spellId == 374779 then--Primal Barrier
		if self.vb.stageTotality == 2 then
			self:SetStage(1)
			--Base
			timerSunderStrikeCD:Start(11)
			timerDamageCD:Start(20, " ")
			timerAvoidCD:Start(30, " ")
			--Boss retains power from previous stage
			--Hopefully this is temp
			--Alternatively could just pause timer going into intermission and resume it here with 4 seconds added?
			local currentPower = UnitPower("boss1")
			if currentPower then
				local percent = currentPower / 100
				local elapsed = percent * 60
				timerUltimateCD:Update(elapsed, 64, " ")--Power updates resume after 4 seconds, so 4 sec added to total
			end
			--if self:IsMythic() then
			--	timerAddsCD:Start()
			--end
		else--4, which means stage 3, totality 5
			self:SetStage(3)
			timerSunderStrikeCD:Start(10)
			timerDamageCD:Start(15, " ")
			timerAvoidCD:Start(22, " ")--28.4 now?
			--Boss retains power from previous stage
			--Hopefully this is temp
			--Alternatively could just pause timer going into intermission and resume it here with 4 seconds added?
			local currentPower = UnitPower("boss1")
			if currentPower then
				local percent = currentPower / 100
				local elapsed = percent * 60
				timerUltimateCD:Update(elapsed, 64, " ")--Power updates resume after 4 seconds, so 4 sec added to total
			end
			--if self:IsMythic() then
			--	timerAddsCD:Start()
			--end
		end
	elseif spellId == 374380 then
		if self.Options.NPAuraOnElementalBond then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 374427 then
		if args:IsPlayer() then
			yellGroundShatterFades:Cancel()
		end
	elseif spellId == 390921 then
		if args:IsPlayer() then
			yellShockingBurstFades:Cancel()
		end
	elseif spellId == 391419 and args:IsPlayer() then
		specWarnFreezing:Cancel()
		specWarnFreezing:CancelVoice()
	elseif spellId == 391265 then
		if args:IsPlayer() then
			yellOrbLightningFades:Cancel()
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	--Intermission Adds
	if cid == 190688 then--Blazing Fiend
		timerSearingCarnageCD:Stop(args.destGUID)
	elseif cid == 190686 then--Frozen Destroyer
		timerFreezingTempestCD:Stop(args.destGUID)
		timerAbsoluteZeroCD:Stop(args.destGUID)
	elseif cid == 190588 then--Tectonic Crusher
		timerGroundShatterCD:Stop(args.destGUID)
		timerViolentUpheavelCD:Stop(args.destGUID)
		timerSeismicRuptureCD:Stop()
	elseif cid == 190690 then--Thundering Tempest
		timerStormBreakCD:Stop(args.destGUID)
		timerThunderStrikeCD:Stop(args.destGUID)
	--Mythic Adds
	elseif cid == 198311 then--Flamewrought Eradicator
		timerSunderingFlameCD:Stop(args.destGUID)
	elseif cid == 198308 then--Icewrought Dominator
		timerSunderingFrostCD:Stop(args.destGUID)
		timerFrigidTorrentCD:Stop(args.destGUID)
	elseif cid == 197595 then--Ironwrought Smasher
		timerSunderingSmashCD:Stop(args.destGUID)
	elseif cid == 198326 then--Stormwrought Despoiler
		timerOrbLightningCD:Stop(args.destGUID)
		timerSunderingPealCD:Stop(args.destGUID)
--	elseif cid == 190586 then--seismic-pillar

	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if (spellId == 374554 or spellId == 391555) and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

do
	local spellEasyMapping = {
		--Biting Chill, Shocking Burst, Magma Burst, Erupting Bedrock
		[391096] = {DBM:GetSpellInfo(373678), DBM:GetSpellInfo(373487), DBM:GetSpellInfo(382563), (DBM:GetSpellInfo(390796))},
		--Biting Chill, Shocking Burst, Magma Burst, Erupting Bedrock
		[391100] = {DBM:GetSpellInfo(373678), DBM:GetSpellInfo(390920), DBM:GetSpellInfo(382563), (DBM:GetSpellInfo(390796))},
		--Ultimate Selection (Absolute Zero, Thunder Strike, Searing Carnage, Seismic Rupture
		[374680] = {DBM:GetSpellInfo(372456), DBM:GetSpellInfo(374217), DBM:GetSpellInfo(374022), (DBM:GetSpellInfo(374705))}
	}
	local spellMapping = {
		--Biting Chill, Lightning Crash, Magma Burst, Enveloping Earth
		[391096] = {DBM:GetSpellInfo(373678), DBM:GetSpellInfo(373487), DBM:GetSpellInfo(382563), (DBM:GetSpellInfo(391055))},
		--Frigid Torrent, Shocking Burst, Molten Rupture, Erupting Bedrock
		[391100] = {DBM:GetSpellInfo(391019), DBM:GetSpellInfo(390920), DBM:GetSpellInfo(373329), (DBM:GetSpellInfo(390796))},
		--Ultimate Selection (Absolute Zero, Thunder Strike, Searing Carnage, Seismic Rupture
		[374680] = {DBM:GetSpellInfo(372456), DBM:GetSpellInfo(374217), DBM:GetSpellInfo(374022), (DBM:GetSpellInfo(374705))}
	}

	--Problematic Notes:
	--Molten Rupture and Frigid Torrent flagged heroic+ only. So on normal and LFR Avoid Selection only has a 2/4 spells.
	--Lightning Crash and Enveloping Earth flagged heroic+ only. So on normal and LFR "Damage Selection" only has a 2/4 spells.
	function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
		if spellId == 373415 then
			specWarnMoltenRupture:Show()
			specWarnMoltenRupture:Play("farfromline")
		elseif spellId == 391096 then--Damage Selection (Biting Chill, Lightning Crash, Magma Burst, Enveloping Earth)
			local spellName = self.vb.curAltar and (self:IsEasy() and spellEasyMapping[spellId][self.vb.curAltar] or spellMapping[spellId][self.vb.curAltar]) or " "
			timerDamageCD:Start(nil, spellName)
		elseif spellId == 391100 then--Avoid Selection (Frigid Torrent, Shocking Burst, Molten Rupture, Erupting Bedrock)
			local spellName = self.vb.curAltar and (self:IsEasy() and spellEasyMapping[spellId][self.vb.curAltar] or spellMapping[spellId][self.vb.curAltar]) or " "
			timerAvoidCD:Start(nil, spellName)
		elseif spellId == 374680 then--Ultimate Selection (Absolute Zero, Thunder Strike, Searing Carnage, Seismic Rupture)
			local spellName = self.vb.curAltar and (self:IsEasy() and spellEasyMapping[spellId][self.vb.curAltar] or spellMapping[spellId][self.vb.curAltar]) or " "
			timerUltimateCD:Start(self.vb.phase == 3 and 37.6 or 60, spellName)
		elseif spellId == 386432 then--Granyth Ability Selection (Mythic add selection)
			timerAddsCD:Start()
		end
	end
end
