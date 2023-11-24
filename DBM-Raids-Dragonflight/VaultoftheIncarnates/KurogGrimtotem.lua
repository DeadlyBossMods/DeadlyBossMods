local mod	= DBM:NewMod(2491, "DBM-Raids-Dragonflight", 3, 1200)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(184986)
mod:SetEncounterID(2605)
mod:SetUsedIcons(1, 2, 3, 4, 5)
mod:SetHotfixNoticeRev(20230205000000)
mod:SetMinSyncRevision(20230205000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 390548 373678 382563 374022 372456 375450 374691 374215 376669 397338 374430 374623 374624 374622 391019 392125 392192 392152 391268 393314 393295 393296 392098 393459 394719 393429 395893 394416 393309",
	"SPELL_CAST_SUCCESS 375825 375828 375824 375792 373415",
	"SPELL_AURA_APPLIED 371971 372158 373494 372458 372514 372517 374779 374380 374427 391056 390920 391419 396109 396113 396106 396085 396241 391696",
	"SPELL_AURA_APPLIED_DOSE 372158 374321",
	"SPELL_AURA_REMOVED 371971 372458 372514 374779 374380 374427 390920 391419 391056",
	"SPELL_PERIODIC_DAMAGE 374554 391555",
	"SPELL_PERIODIC_MISSED 374554 391555",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[
(ability.id = 390548 or ability.id = 373678 or ability.id = 382563 or ability.id = 392125 or ability.id = 373487 or ability.id = 373329
 or ability.id = 374022 or ability.id = 392192 or ability.id = 392152 or ability.id = 372456 or ability.id = 375450 or ability.id = 395893
 or ability.id = 374691 or ability.id = 376669 or ability.id = 374215 or ability.id = 397338 or ability.id = 374430 or ability.id = 390920
 or ability.id = 374623 or ability.id = 374624 or ability.id = 374622 or ability.id = 391019 or ability.id = 391055
 or ability.id = 391268 or ability.id = 393314 or ability.id = 393309 or ability.id = 393295 or ability.id = 394416
 or ability.id = 393296 or ability.id = 392098 or ability.id = 393459 or ability.id = 394719 or ability.id = 393429 or ability.id = 397341) and type = "begincast"
 or ability.id = 373415 and type = "cast" or ability.id = 396241 and type = "applybuff"
 or (ability.id = 375828 or ability.id = 375825 or ability.id = 375824 or ability.id = 375792) and type = "cast"
 or ability.id = 374779
--]]
--General
local specWarnGTFO								= mod:NewSpecialWarningGTFO(374554, nil, nil, nil, 1, 8)

local timerPhaseCD								= mod:NewPhaseTimer(30)
local berserkTimer								= mod:NewBerserkTimer(600)

--Stage One: Elemental Mastery
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25036))
local warnSunderStrikeDebuff					= mod:NewStackAnnounce(372158, 2, nil, "Tank|Healer")

local specWarnSunderStrike						= mod:NewSpecialWarningDefensive(372158, nil, nil, nil, 1, 2)
local specWarnSunderStrikeDebuff				= mod:NewSpecialWarningTaunt(372158, nil, nil, nil, 1, 2)

local timerSunderStrikeCD						= mod:NewCDTimer(19.4, 372158, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--General timers for handling of bosses ability rotation
local timerDamageCD								= mod:NewTimer(30, "timerDamageCD", 391096, nil, nil, 3, nil, nil, nil, nil, nil, nil, nil, 391096, nil, nil, "next")--Magma Burst, Biting Chill, Enveloping Earth, Lightning Crash
local timerAvoidCD								= mod:NewTimer(60, "timerAvoidCD", 391100, nil, nil, 3, nil, nil, nil, nil, nil, nil, nil, 391100, nil, nil, "next")--Molten Rupture, Frigid Torrent, Erupting Bedrock, Shocking Burst
local timerUltimateCD							= mod:NewTimer(60, "timerUltimateCD", 374680, nil, nil, 3, nil, nil, nil, nil, nil, nil, nil, 374680, nil, nil, "next")--Searing Carnage, Absolute Zero, Seismic Rupture, Thunder Strike
local timerAddEnrageCD							= mod:NewTimer(60, "timerAddEnrageCD", 28131, nil, nil, 5, nil, DBM_COMMON_L.DAMAGE_ICON, nil, nil, nil, nil, nil, 400473, nil, nil, "next")

--mod:AddInfoFrameOption(361651, true)
mod:AddNamePlateOption("NPAuraOnSurge", 371971, true)
--Fire Altar An altar of primal fire
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25040))
local specWarnMagmaBurst						= mod:NewSpecialWarningDodge(382563, nil, nil, nil, 2, 2)
local specWarnMoltenRupture						= mod:NewSpecialWarningDodge(373329, nil, nil, nil, 2, 2)
local specWarnSearingCarnage					= mod:NewSpecialWarningDodge(374023, nil, nil, nil, 2, 2)--Just warn everyone since it targets most of raid, even if it's not on YOU, you need to avoid it

----Mythic Only (Flamewrought Eradicator)
local warnRagingInferno							= mod:NewSpellAnnounce(394416, 3)

local specWarnFlamewroughtEradicator			= mod:NewSpecialWarningSwitch(393314, "-Healer", nil, nil, 1, 2, 4)
local specWarnFlameSmite						= mod:NewSpecialWarningYou(393309, nil, nil, nil, 2, 2, 4)

local timerFlameSmiteCD							= mod:NewCDTimer(30, 393309, nil, nil, nil, 5)
local timerRagingInfernoCD						= mod:NewCDTimer(30, 394416, nil, nil, nil, 1)
--Frost Altar An altar of primal frost.
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25061))
local warnBitingChill							= mod:NewCountAnnounce(373678, 2)
local warnAbsoluteZero							= mod:NewTargetNoFilterAnnounce(372458, 3)
local warnFrostBite								= mod:NewFadesAnnounce(372514, 1)
local warnFrozenSolid							= mod:NewTargetNoFilterAnnounce(372517, 4, nil, false)--RL kinda thing

local specWarnFrigidTorrent						= mod:NewSpecialWarningDodge(391019, nil, nil, nil, 2, 2)--Cast by boss AND Dominator
local specWarnAbsoluteZero						= mod:NewSpecialWarningYouPos(372458, nil, nil, nil, 1, 2)
local yellAbsoluteZero							= mod:NewShortPosYell(372458)
local yellAbsoluteZeroFades						= mod:NewIconFadesYell(372458)

local timerFrostBite							= mod:NewBuffFadesTimer(30, 372514, nil, false, nil, 5)

mod:AddSetIconOption("SetIconOnAbsoluteZero", 372458, true, 9, {1, 2})

mod:GroupSpells(372458, 372514, 372517)--Group all Below Zero mechanics together
----Mythic Only (Icebound Dominator)
local specWarnIceboundDominator					= mod:NewSpecialWarningSwitch(393295, "-Healer", nil, nil, 1, 2, 4)
local specWarnFreezing							= mod:NewSpecialWarningMoveTo(391419, nil, nil, nil, 1, 2, 4)--Effect of Icy Tempest (391425)
local specWarnFrostSmite						= mod:NewSpecialWarningYou(393296, nil, nil, nil, 2, 2, 4)

local timerFrostSmiteCD							= mod:NewCDTimer(30, 393296, nil, nil, nil, 5)
local timerFrigidTorrentCD						= mod:NewCDTimer(32.5, 391019, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
--Earth Altar An altar of primal earth.
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25064))
local warnEnvelopingEarth						= mod:NewTargetNoFilterAnnounce(391056, 4, nil, "Healer")

local specWarnEnvelopingEarth					= mod:NewSpecialWarningYou(391056, nil, nil, nil, 1, 2)
local specWarnEruptingBedrock					= mod:NewSpecialWarningDodge(395893, nil, nil, 2, 2, 2)--Cast by boss AND Doppelboulder
local specWarnSeismicRupture					= mod:NewSpecialWarningDodge(374691, nil, nil, nil, 2, 2)

----Mythic Only (Ironwrought Smasher)
local specWarnIronwroughtSmasher				= mod:NewSpecialWarningSwitch(392098, "-Healer", nil, nil, 1, 2, 4)
local specWarnEarthSmite						= mod:NewSpecialWarningSpell(391268, nil, nil, nil, 1, 2, 4)

local timerEarthSmiteCD							= mod:NewCDTimer(30, 391268, nil, nil, nil, 5)--Ironwrought Smasher
local timerEruptingBedrockCD					= mod:NewCDTimer(60, 395893, nil, nil, nil, 2, nil, DBM_COMMON_L.MYTHIC_ICON)

mod:AddSetIconOption("SetIconOnEnvelopingEarth", 391056, false, false, {1, 2, 3})
--Storm Altar An altar of primal storm
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25068))
local warnLightningCrash						= mod:NewTargetNoFilterAnnounce(373487, 4)
local warnShockingBurst							= mod:NewTargetNoFilterAnnounce(390920, 3)

local specWarnLightningCrash					= mod:NewSpecialWarningMoveAway(373487, nil, nil, nil, 1, 2)
local yellLightningCrash						= mod:NewShortYell(373487)
--local yellLightningCrashFades					= mod:NewIconFadesYell(373487)
--local specWarnLightningCrashStacks			= mod:NewSpecialWarningStack(373535, nil, 8, nil, nil, 1, 6)
local specWarnShockingBurst						= mod:NewSpecialWarningMoveAway(390920, nil, nil, nil, 1, 2)
local yellShockingBurst							= mod:NewShortYell(390920)
local yellShockingBurstFades					= mod:NewShortFadesYell(390920)
local specWarnThunderStrike						= mod:NewSpecialWarningSoak(374215, nil, nil, nil, 2, 2)--No Debuff
local specWarnThunderStrikeBad					= mod:NewSpecialWarningDodge(374215, nil, nil, nil, 2, 2)--Debuff

mod:AddSetIconOption("SetIconOnShockingBurst", 390920, false, false, {4, 5})
--mod:GroupSpells(373487, 373535)--Group Lighting crash source debuff with dest (nearest player) debuff
----Mythic Only (Stormwrought Despoiler)
local warnOrbLightning							= mod:NewSpellAnnounce(394719, 3)

local specWarnStormwroughtDespoiler				= mod:NewSpecialWarningSwitch(393459, "-Healer", nil, nil, 1, 2, 4)
local specWarnStormSmite						= mod:NewSpecialWarningYou(393429, nil, nil, nil, 2, 2, 4)

local timerOrbLightningCD						= mod:NewCDTimer(48.5, 394719, nil, nil, nil, 3)
local timerStormSmiteCD							= mod:NewCDTimer(30, 393429, nil, nil, nil, 5)

--Stage Two: Summoning Incarnates
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25071))
mod:AddNamePlateOption("NPAuraOnElementalBond", 374380, true)
----Tectonic Crusher
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25073))
local warnBreakingGravel						= mod:NewStackAnnounce(374321, 2, nil, "Tank|Healer")
local warnGroundShatter							= mod:NewTargetNoFilterAnnounce(374427, 3)

local specWarnGroundShatter						= mod:NewSpecialWarningMoveAway(374427, nil, nil, nil, 1, 2)
local yellGroundShatter							= mod:NewShortYell(374427)
local yellGroundShatterFades					= mod:NewShortFadesYell(374427)
local specWarnViolentUpheavel					= mod:NewSpecialWarningDodge(374430, nil, nil, nil, 2, 2)

local timerGroundShatterCD						= mod:NewCDTimer(30.4, 374427, nil, nil, nil, 3)
local timerViolentUpheavelCD					= mod:NewCDTimer(33.2, 374430, nil, nil, nil, 3)--Sometimess stutter casts
local timerSeismicRuptureCD						= mod:NewCDTimer(49.4, 374691, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)--Mythic Add version

----Frozen Destroyer
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25076))
local specWarnFrostBinds						= mod:NewSpecialWarningInterrupt(374623, "HasInterrupt", nil, nil, 1, 2)

local specWarnFreezingTempest					= mod:NewSpecialWarningMoveTo(374624, nil, nil, nil, 3, 2)

local timerFreezingTempestCD					= mod:NewCDTimer(37.7, 374624, nil, nil, nil, 2)
local timerAbsoluteZeroCD						= mod:NewCDCountTimer(24.3, 372458, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)--Mythic Add version

----Blazing Fiend
--mod:AddTimerLine(DBM:EJ_GetSectionInfo(25079))--Since searing gets bunbled with cast, it leaves category empty
local timerSearingCarnageCD						= mod:NewCDTimer(23, 374023, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)--Mythic Add version

----Thundering Destroyer
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25083))
local warnStormBreak							= mod:NewSpellAnnounce(374622, 3)

local specWarnLethalCurrent						= mod:NewSpecialWarningYou(391696, nil, nil, nil, 1, 2)
local yellLethalCurrent							= mod:NewShortYell(391696)

local timerStormBreakCD							= mod:NewCDTimer(20.8, 374622, nil, nil, nil, 2)
local timerThunderStrikeCD						= mod:NewCDTimer(41, 374215, nil, nil, nil, 5, nil, DBM_COMMON_L.MYTHIC_ICON)--Mythic Add version

mod:GroupSpells(374622, 391696)--Storm Break and it's sub debuff Lethal Current

mod.vb.chillCast = 0
mod.vb.curAltar = false
mod.vb.damageSpell = "?"
mod.vb.avoidSpell = "?"
mod.vb.ultimateSpell = "?"
mod.vb.damageCount = 0
mod.vb.damageTimer = 30
mod.vb.avoidTimer = 60
mod.vb.ultTimer = 60
local castsPerGUID = {}
local groundShatterTargets = {}
local zeroIcons = {}
local updateAltar

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.chillCast = 0
	self.vb.curAltar = false
	self.vb.damageCount = 0
	self.vb.damageSpell = "?"
	self.vb.avoidSpell = "?"
	self.vb.ultimateSpell = "?"
	timerSunderStrikeCD:Start(8-delay)
	timerPhaseCD:Start(125-delay)--125-127
	self.vb.damageTimer = 19.5--Alternating in P1
	self.vb.avoidTimer = 45
	self.vb.ultTimer = 45
	timerDamageCD:Start(14.2-delay, "?")
	timerAvoidCD:Start(22-delay, "?")
	timerUltimateCD:Start(45-delay, "?")
	if self:IsMythic() then
		berserkTimer:Start(600-delay)
	end
	if self.Options.NPAuraOnSurge or self.Options.NPAuraOnElementalBond then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	table.wipe(castsPerGUID)
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
		specWarnMagmaBurst:Play("watchstep")
	elseif spellId == 374022 or spellId == 392192 or spellId == 392152 then--Normal/Heroic, LFR, Mythic (assumed)
		specWarnSearingCarnage:Show()
		specWarnSearingCarnage:Play("watchstep")
		if args:GetSrcCreatureID() ~= 184986 then--Mythic Add
			timerSearingCarnageCD:Start(nil, args.sourceGUID)
		end
	elseif spellId == 372456 or spellId == 375450 then--Hard, easy (assumed)
		table.wipe(zeroIcons)
		if args:GetSrcCreatureID() ~= 184986 then--Mythic Add
			self.vb.zeroCount = self.vb.zeroCount + 1
			timerAbsoluteZeroCD:Start(nil, self.vb.zeroCount+1, args.sourceGUID)
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
	elseif spellId == 397338 then
		table.wipe(groundShatterTargets)
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
		if self:AntiSpam(3, 1) then
			specWarnFrigidTorrent:Show()
			specWarnFrigidTorrent:Play("watchorb")
		end
		if args:GetSrcCreatureID() ~= 184986 then--Mythic Add
			timerFrigidTorrentCD:Start(nil, args.sourceGUID)
		end
--	elseif spellId == 391055 then

	elseif spellId == 395893 then
		if self:AntiSpam(3, 2) then
			specWarnEruptingBedrock:Show()
			specWarnEruptingBedrock:Play("watchstep")
		end
		if args:GetSrcCreatureID() ~= 184986 then--Mythic Add
			timerEruptingBedrockCD:Start(nil, args.sourceGUID)
		end
	--Mythic Stuff
	elseif spellId == 391268 then
		timerEarthSmiteCD:Start(nil, args.sourceGUID)
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnEarthSmite:Show()
			specWarnEarthSmite:Play("carefly")
		end
	elseif spellId == 393314 then
		specWarnFlamewroughtEradicator:Show()
		specWarnFlamewroughtEradicator:Play("bigmob")
		timerFlameSmiteCD:Start(13.1)
		timerRagingInfernoCD:Start(27.7)
		timerAddEnrageCD:Start(94, L.Fire)
	elseif spellId == 393309 then
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnFlameSmite:Show()
			specWarnFlameSmite:Play("shockwave")
		end
		timerFlameSmiteCD:Start(nil, args.sourceGUID)
	elseif spellId == 394416 then
		warnRagingInferno:Show()
		timerRagingInfernoCD:Start(nil, args.sourceGUID)
	elseif spellId == 393295 then
		specWarnIceboundDominator:Show()
		specWarnIceboundDominator:Play("bigmob")
		timerFrostSmiteCD:Start(13.1)
		timerFrigidTorrentCD:Start(27.7)
		timerAddEnrageCD:Start(94, L.Frost)
	elseif spellId == 393296 then
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnFrostSmite:Show()
			specWarnFrostSmite:Play("shockwave")
		end
		timerFrostSmiteCD:Start(nil, args.sourceGUID)
	elseif spellId == 392098 then
		specWarnIronwroughtSmasher:Show()
		specWarnIronwroughtSmasher:Play("bigmob")
		timerEarthSmiteCD:Start(13.1)
		timerEruptingBedrockCD:Start(27.7)
		timerAddEnrageCD:Start(94, L.Earth)
	elseif spellId == 393459 then
		specWarnStormwroughtDespoiler:Show()
		specWarnStormwroughtDespoiler:Play("bigmob")
		timerStormSmiteCD:Start(13.1)
		timerOrbLightningCD:Start(18.2)
		timerAddEnrageCD:Start(94, L.Storm)
	elseif spellId == 394719 then
		warnOrbLightning:Show()
		timerOrbLightningCD:Start(nil, args.sourceGUID)
	elseif spellId == 393429 then
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnStormSmite:Show()
			specWarnStormSmite:Play("shockwave")
		end
		timerStormSmiteCD:Start(nil, args.sourceGUID)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 375825 then--Frozen Destroyer
		timerFreezingTempestCD:Start(30.4, args.sourceGUID)
		if self:IsMythic() then
			timerAbsoluteZeroCD:Start(20.3, 1, args.sourceGUID)
		end
	elseif spellId == 375828 then--Blazing Fiend
		if self:IsMythic() then
			timerSearingCarnageCD:Start(20.2, args.sourceGUID)
		end
	elseif spellId == 375824 then--Tectonic Crusher
		timerGroundShatterCD:Start(5.9, args.sourceGUID)
		timerViolentUpheavelCD:Start(20.6, args.sourceGUID)
		if self:IsMythic() then
			timerSeismicRuptureCD:Start(45, args.sourceGUID)
		end
	elseif spellId == 375792 then--Thundering Ravager
		timerStormBreakCD:Start(7.2, args.sourceGUID)
		if self:IsMythic() then
			timerThunderStrikeCD:Start(38.5, args.sourceGUID)
		end
	elseif spellId == 373415 then
		DBM:AddMsg("373415 is combat logging now, notify DBM author")
		--specWarnMoltenRupture:Show()
		--specWarnMoltenRupture:Play("farfromline")
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
	elseif spellId == 396109 and (not self.vb.curAltar or self.vb.curAltar ~= 1) then--Freezing Dominance
		self.vb.curAltar = 1
		updateAltar(self)
	elseif spellId == 396113 and (not self.vb.curAltar or self.vb.curAltar ~= 2) then--Thundering Dominance
		self.vb.curAltar = 2
		updateAltar(self)
	elseif spellId == 396106 and (not self.vb.curAltar or self.vb.curAltar ~= 3) then--Flaming Dominance
		self.vb.curAltar = 3
		updateAltar(self)
	elseif spellId == 396085 and (not self.vb.curAltar or self.vb.curAltar ~= 4) then--Earthen Dominance
		self.vb.curAltar = 4
		updateAltar(self)
	elseif spellId == 372158 and not args:IsPlayer() then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if not UnitIsDeadOrGhost("player") and not self:IsHealer() then
				specWarnSunderStrikeDebuff:Show(args.destName)
				specWarnSunderStrikeDebuff:Play("tauntboss")
			else
				warnSunderStrikeDebuff:Show(args.destName, amount)
			end
		end
	elseif spellId == 373494 then
		if args:IsPlayer() then
			specWarnLightningCrash:Show()
			specWarnLightningCrash:Play("scatter")
			yellLightningCrash:Yell()
--			yellLightningCrashFades:Countdown(spellId, nil, icon)
		end
		warnLightningCrash:CombinedShow(0.5, args.destName)
	elseif spellId == 372458 then
		zeroIcons[#zeroIcons+1] = args.destName
		if #zeroIcons == 2 or DBM:NumRealAlivePlayers() < 2 then
			table.sort(zeroIcons, DBM.SortByTankRoster)
			for i = 1, #zeroIcons do
				local name = zeroIcons[i]
				if self.Options.SetIconOnAbsoluteZero then
					self:SetIcon(name, i)
				end
				if name == DBM:GetMyPlayerInfo() then
					specWarnAbsoluteZero:Show(self:IconNumToTexture(i))
					specWarnAbsoluteZero:Play("mm"..i)
					yellAbsoluteZero:Yell(i, i)
					yellAbsoluteZeroFades:Countdown(spellId, nil, i)
				end
			end
			warnAbsoluteZero:Show(table.concat(zeroIcons, "<, >"))
		end
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
	elseif spellId == 374380 then
		if self.Options.NPAuraOnElementalBond then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 374427 then
		warnGroundShatter:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnGroundShatter:Show()
			specWarnGroundShatter:Play("runout")
			yellGroundShatter:Yell()
			yellGroundShatterFades:Countdown(spellId)
		end
	elseif spellId == 391056 then
		if self.Options.SetIconOnEnvelopingEarth then
			self:SetUnsortedIcon(0.3, args.destName, 1, 8, false)
		end
		if args:IsPlayer() then
			specWarnEnvelopingEarth:Show()
			specWarnEnvelopingEarth:Play("checkhp")
		end
		warnEnvelopingEarth:CombinedShow(0.3, args.destName)
	elseif spellId == 390920 then
		if self.Options.SetIconOnShockingBurst then
			self:SetUnsortedIcon(0.3, args.destName, 4, 2, false)
		end
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
--	elseif spellId == 396241 then
		--berserk
	elseif spellId == 391696 then
		if args:IsPlayer() then
			specWarnLethalCurrent:Show()
			specWarnLethalCurrent:Play("targetyou")
			yellLethalCurrent:Yell()
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 371971 then
		if self.Options.NPAuraOnSurge then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
--	elseif spellId == 373487 then
--		if args:IsPlayer() then
--			yellLightningCrashFades:Cancel()
--		end
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
		self.vb.curAltar = false--Reset on intermission end because we don't want initial timers to show an altar spell when there isn't one yet
		self.vb.damageCount = 0
		self.vb.zeroCount = 0
		self:SetStage(1)
		timerSunderStrikeCD:Start(11.3)
		if self.vb.stageTotality == 3 then
			timerPhaseCD:Start(127)--Second intermission (Primal Barrier)
		else
			timerPhaseCD:Start(94)--Primal Attunement
		end
		timerDamageCD:Start(14.5, "?")
		timerAvoidCD:Start(22.2, "?")--They fixed the skip bug apparently and it's no longer 68.4
		timerUltimateCD:Start(45, "?")--if it's seismic rupture it's 53 else 45
	elseif spellId == 374380 then
		if self.Options.NPAuraOnElementalBond then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 374427 then
		if args:IsPlayer() then
			yellGroundShatterFades:Cancel()
		end
	elseif spellId == 390920 then
		if self.Options.SetIconOnShockingBurst then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellShockingBurstFades:Cancel()
		end
	elseif spellId == 391419 and args:IsPlayer() then
		specWarnFreezing:Cancel()
		specWarnFreezing:CancelVoice()
	elseif spellId == 391056 then
		if self.Options.SetIconOnEnvelopingEarth then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	--Intermission Adds
	if cid == 190688 then--Blazing Fiend
		timerSearingCarnageCD:Stop(args.destGUID)
	elseif cid == 190686 then--Frozen Destroyer
		timerAbsoluteZeroCD:Stop(args.destGUID)
		timerFreezingTempestCD:Stop(args.destGUID)
		timerAbsoluteZeroCD:Stop()
		timerFreezingTempestCD:Stop()
	elseif cid == 190588 then--Tectonic Crusher
		timerGroundShatterCD:Stop(args.destGUID)
		timerViolentUpheavelCD:Stop(args.destGUID)
		timerSeismicRuptureCD:Stop(args.destGUID)
		timerGroundShatterCD:Stop()
		timerViolentUpheavelCD:Stop()
		timerSeismicRuptureCD:Stop()
	elseif cid == 190690 then--Thundering Ravager
		timerStormBreakCD:Stop(args.destGUID)
		timerThunderStrikeCD:Stop(args.destGUID)
		timerStormBreakCD:Stop()
		timerThunderStrikeCD:Stop()
	--Mythic Adds
	elseif cid == 198311 then--Flamewrought Eradicator
		timerFlameSmiteCD:Stop(args.destGUID)
		timerRagingInfernoCD:Stop(args.destGUID)
		timerFlameSmiteCD:Stop()
		timerRagingInfernoCD:Stop()
		timerAddEnrageCD:Stop(L.Fire)
	elseif cid == 198308 then--Icewrought Dominator
		timerFrostSmiteCD:Stop(args.destGUID)
		timerFrigidTorrentCD:Stop(args.destGUID)
		timerFrostSmiteCD:Stop()
		timerFrigidTorrentCD:Stop()
		timerAddEnrageCD:Stop(L.Frost)
	elseif cid == 197595 then--Ironwrought Smasher
		timerEarthSmiteCD:Stop(args.destGUID)
		timerEruptingBedrockCD:Stop(args.destGUID)
		timerEarthSmiteCD:Stop()
		timerEruptingBedrockCD:Stop()
		timerAddEnrageCD:Stop(L.Earth)
	elseif cid == 198326 then--Stormwrought Despoiler
		timerOrbLightningCD:Stop(args.destGUID)
		timerStormSmiteCD:Stop(args.destGUID)
		timerOrbLightningCD:Stop()
		timerStormSmiteCD:Stop()
		timerAddEnrageCD:Stop(L.Storm)
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
		[391096] = {DBM:GetSpellInfo(373678), DBM:GetSpellInfo(373487), DBM:GetSpellInfo(382563), (DBM:GetSpellInfo(395893))},
		--Biting Chill, Shocking Burst, Magma Burst, Erupting Bedrock
		[391100] = {DBM:GetSpellInfo(373678), DBM:GetSpellInfo(390920), DBM:GetSpellInfo(382563), (DBM:GetSpellInfo(395893))},
		--Ultimate Selection (Absolute Zero, Thunder Strike, Searing Carnage, Seismic Rupture
		[374680] = {DBM:GetSpellInfo(372456), DBM:GetSpellInfo(374217), DBM:GetSpellInfo(374022), (DBM:GetSpellInfo(374705))}
	}
	local iconEasyMapping = {
		--Biting Chill, Shocking Burst, Magma Burst, Erupting Bedrock
		[391096] = {GetSpellTexture(373678), GetSpellTexture(373487), GetSpellTexture(382563), (GetSpellTexture(395893))},
		--Biting Chill, Shocking Burst, Magma Burst, Erupting Bedrock
		[391100] = {GetSpellTexture(373678), GetSpellTexture(390920), GetSpellTexture(382563), (GetSpellTexture(395893))},
		--Ultimate Selection (Absolute Zero, Thunder Strike, Searing Carnage, Seismic Rupture
		[374680] = {GetSpellTexture(372456), GetSpellTexture(374217), GetSpellTexture(374022), (GetSpellTexture(374705))}
	}
	local spellMapping = {
		--Biting Chill, Lightning Crash, Magma Burst, Enveloping Earth
		[391096] = {DBM:GetSpellInfo(373678), DBM:GetSpellInfo(373487), DBM:GetSpellInfo(382563), (DBM:GetSpellInfo(391055))},
		--Frigid Torrent, Shocking Burst, Molten Rupture, Erupting Bedrock
		[391100] = {DBM:GetSpellInfo(391019), DBM:GetSpellInfo(390920), DBM:GetSpellInfo(373329), (DBM:GetSpellInfo(395893))},
		--Ultimate Selection (Absolute Zero, Thunder Strike, Searing Carnage, Seismic Rupture
		[374680] = {DBM:GetSpellInfo(372456), DBM:GetSpellInfo(374217), DBM:GetSpellInfo(374022), (DBM:GetSpellInfo(374705))}
	}
	local iconMapping = {
		--Biting Chill, Lightning Crash, Magma Burst, Enveloping Earth
		[391096] = {GetSpellTexture(373678), GetSpellTexture(373487), GetSpellTexture(382563), (GetSpellTexture(391055))},
		--Frigid Torrent, Shocking Burst, Molten Rupture, Erupting Bedrock
		[391100] = {GetSpellTexture(391019), GetSpellTexture(390920), GetSpellTexture(373329), (GetSpellTexture(395893))},
		--Ultimate Selection (Absolute Zero, Thunder Strike, Searing Carnage, Seismic Rupture
		[374680] = {GetSpellTexture(372456), GetSpellTexture(374217), GetSpellTexture(374022), (GetSpellTexture(374705))}
	}

	function updateAltar(self)
		if self:GetStage(2) then return end
		--Collect current timers usiing cached spellname reference so it's actually possible to find timer with API (before we change it)
		local dElapsed, dTotal = timerDamageCD:GetTime(self.vb.damageSpell)
		local aElapsed, aTotal = timerAvoidCD:GetTime(self.vb.avoidSpell)
		local uElapsed, uTotal = timerUltimateCD:GetTime(self.vb.ultimateSpell)
		--Terminate old timers
		timerDamageCD:Stop()
		timerAvoidCD:Stop()
		timerUltimateCD:Stop()
		--Gather new spellNames and Icons and update bars
		if dTotal and dTotal > 0 then
			self.vb.damageSpell = self.vb.curAltar and (self:IsEasy() and spellEasyMapping[391096][self.vb.curAltar] or spellMapping[391096][self.vb.curAltar]) or "?"
			local dSpellIcon = self.vb.curAltar and (self:IsEasy() and iconEasyMapping[391096][self.vb.curAltar] or iconMapping[391096][self.vb.curAltar]) or 136116
			timerDamageCD:Update(dElapsed, dTotal, self.vb.damageSpell)
			timerDamageCD:UpdateIcon(dSpellIcon, self.vb.damageSpell)
		end

		if aTotal and aTotal > 0 then
			self.vb.avoidSpell = self.vb.curAltar and (self:IsEasy() and spellEasyMapping[391100][self.vb.curAltar] or spellMapping[391100][self.vb.curAltar]) or "?"
			local aSpellIcon = self.vb.curAltar and (self:IsEasy() and iconEasyMapping[391100][self.vb.curAltar] or iconMapping[391100][self.vb.curAltar]) or 136116
			timerAvoidCD:Update(aElapsed, aTotal, self.vb.avoidSpell)
			timerAvoidCD:UpdateIcon(aSpellIcon, self.vb.avoidSpell)
		end

		if uTotal and uTotal > 0 then
			self.vb.ultimateSpell = self.vb.curAltar and (self:IsEasy() and spellEasyMapping[374680][self.vb.curAltar] or spellMapping[374680][self.vb.curAltar]) or "?"
			local uSpellIcon = self.vb.curAltar and (self:IsEasy() and iconEasyMapping[374680][self.vb.curAltar] or iconMapping[374680][self.vb.curAltar]) or 136116
			timerUltimateCD:Update(uElapsed, uTotal, self.vb.ultimateSpell)
			timerUltimateCD:UpdateIcon(uSpellIcon, self.vb.ultimateSpell)
		end
	end

	--Problematic Notes:
	--Molten Rupture and Frigid Torrent flagged heroic+ only. So on normal and LFR Avoid Selection only has a 2/4 spells.
	--Lightning Crash and Enveloping Earth flagged heroic+ only. So on normal and LFR "Damage Selection" only has a 2/4 spells.
	function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
		if spellId == 373415 then
			specWarnMoltenRupture:Show()
			specWarnMoltenRupture:Play("farfromline")
		elseif spellId == 391096 then--Damage Selection (Biting Chill, Lightning Crash, Magma Burst, Enveloping Earth)
			self.vb.damageCount = self.vb.damageCount + 1
			self.vb.damageSpell = self.vb.curAltar and (self:IsEasy() and spellEasyMapping[spellId][self.vb.curAltar] or spellMapping[spellId][self.vb.curAltar]) or "?"
			local spellIcon = self.vb.curAltar and (self:IsEasy() and iconEasyMapping[spellId][self.vb.curAltar] or iconMapping[spellId][self.vb.curAltar]) or 136116
			local timer
			if self.vb.damageCount % 2 == 0 then
				timer = 19.5
			else
				timer = 25.5
			end
			timerDamageCD:Start(timer, self.vb.damageSpell)
			timerDamageCD:UpdateIcon(spellIcon, self.vb.damageSpell)
		elseif spellId == 391100 then--Avoid Selection (Frigid Torrent, Shocking Burst, Molten Rupture, Erupting Bedrock)
			self.vb.avoidSpell = self.vb.curAltar and (self:IsEasy() and spellEasyMapping[spellId][self.vb.curAltar] or spellMapping[spellId][self.vb.curAltar]) or "?"
			local spellIcon = self.vb.curAltar and (self:IsEasy() and iconEasyMapping[spellId][self.vb.curAltar] or iconMapping[spellId][self.vb.curAltar]) or 136116
			timerAvoidCD:Start(self.vb.avoidTimer, self.vb.avoidSpell)
			timerAvoidCD:UpdateIcon(spellIcon, self.vb.avoidSpell)
		elseif spellId == 374680 then--Ultimate Selection (Absolute Zero, Thunder Strike, Searing Carnage, Seismic Rupture)
			self.vb.ultimateSpell = self.vb.curAltar and (self:IsEasy() and spellEasyMapping[spellId][self.vb.curAltar] or spellMapping[spellId][self.vb.curAltar]) or "?"
			local spellIcon = self.vb.curAltar and (self:IsEasy() and iconEasyMapping[spellId][self.vb.curAltar] or iconMapping[spellId][self.vb.curAltar]) or 136116
			timerUltimateCD:Start(self.vb.ultTimer, self.vb.ultimateSpell)
			timerUltimateCD:UpdateIcon(spellIcon, self.vb.ultimateSpell)
		end
	end
end
