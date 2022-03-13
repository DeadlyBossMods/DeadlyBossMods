local mod	= DBM:NewMod(2464, "DBM-Sepulcher", nil, 1195)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(180990)
mod:SetEncounterID(2537)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6)--, 7, 8
mod:SetHotfixNoticeRev(20220313000000)
mod:SetMinSyncRevision(20220313000000)
--mod.respawnTime = 29
--mod.NoSortAnnounce = true--Disables DBM automatically sorting announce objects by diff announce types

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 362028 366022 360373 359856 364942 360562 364488 365033 365212 365169 366374 366678 367851",--363179
	"SPELL_CAST_SUCCESS 359809 367051 363893 365436 360279 366284 365147 363332",
--	"SPELL_SUMMON 363175",
	"SPELL_AURA_APPLIED 362631 362401 360281 366285 365150 365153 362075 365219 365222 362192",--362024 360180
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 362401 360281 366285 365150 365153 365222",--360180
	"SPELL_PERIODIC_DAMAGE 360425 365174",
	"SPELL_PERIODIC_MISSED 360425 365174",
--	"UNIT_DIED",
	"UNIT_SPELLCAST_START boss1",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)


--TODO, add mythic stuff later
--TODO, is tyranny warning appropriate? maybe track debuff for mythic?
--TODO, chains may have a pre target spellId, look for it
--TODO, honestly what do for tank combo? most of it is instant casts, misery timing to root is pure guess right now
--TODO, verify add marking
--TODO, https://ptr.wowhead.com/spell=360099/calibrations-of-oblivion have a pre warning/cast? If so, add timer/warn
--TODO, what type of warning for Unholy Attunement
--TODO, shattering blast random target or tank?
--TODO, verify decimator target scan, or find emote for it's targeting
--TODO, https://ptr.wowhead.com/spell=363748/death-sentence / https://ptr.wowhead.com/spell=363772/death-sentence ?
--TODO, auto mark https://ptr.wowhead.com/spell=365419/incarnation-of-torment ? Is Cry of Loathing interruptable or is it like painsmith?
--TODO, do something with https://www.wowhead.com/spell=365810/falling-debris ?
--TODO, maybe short name chains in all phases to "chains"? might remove ability to tell them apart though. maybe use Anguish, Oppression instead
--[[
(ability.id = 362028 or ability.id = 363893 or ability.id = 360373 or ability.id = 359856 or ability.id = 364942 or ability.id = 360562 or ability.id = 364488 or ability.id = 365033 or ability.id = 365212 or ability.id = 365169 or ability.id = 366374 or ability.id = 366678 or ability.id = 367290 or ability.id = 367851) and type = "begincast"
 or (ability.id = 359809 or ability.id = 367051 or ability.id = 363893 or ability.id = 365436 or ability.id = 360279 or ability.id = 366284 or ability.id = 365147 or ability.id = 363332) and type = "cast"
 or ability.id = 181089
--]]
--General
--local berserkTimer							= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption("6")
--mod:AddInfoFrameOption(328897, true)

--Stage One: Origin of Domination
mod:AddTimerLine(DBM:EJ_GetSectionInfo(24087))
local warnDomination							= mod:NewTargetNoFilterAnnounce(362075, 4)
local warnTyranny								= mod:NewCastAnnounce(366022, 3)
local warnChainsofOppression					= mod:NewTargetNoFilterAnnounce(362631, 3)
local warnMartyrdom								= mod:NewTargetCountAnnounce(363893, 4, nil, nil, nil, nil, nil, nil, true)
local warnRuneofDamnation						= mod:NewTargetCountAnnounce(360281, 3, nil, nil, nil, nil, nil, nil, true)

local specWarnWorldCrusher						= mod:NewSpecialWarningCount(366374, nil, nil, nil, 2, 2, 4)
local specWarnRelentingDomination				= mod:NewSpecialWarningMoveTo(362028, nil, nil, nil, 1, 2)
local specWarnChainsofOppression				= mod:NewSpecialWarningYou(362631, nil, nil, nil, 1, 2)
local specWarnMartyrdom							= mod:NewSpecialWarningDefensive(363893, nil, nil, nil, 1, 2)
local yellMartyrdom								= mod:NewYell(363893, nil, nil, nil, "YELL")--rooted target = stack target for misery very likely
local yellMartyrdomFades						= mod:NewShortFadesYell(363893, nil, nil, nil, "YELL")
local specWarnMisery							= mod:NewSpecialWarningTaunt(362192, nil, nil, nil, 1, 2, 4)
local specWarnTorment							= mod:NewSpecialWarningMoveAway(365436, nil, nil, nil, 1, 2)
local specWarnRuneofDamnation					= mod:NewSpecialWarningYou(360281, nil, nil, nil, 1, 2)
local yellRuneofDamnation						= mod:NewShortPosYell(360281)
local yellRuneofDamnationFades					= mod:NewIconFadesYell(360281)

local timerWorldCrusherCD						= mod:NewAITimer(28.8, 366374, nil, nil, nil, 2, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerRelentingDominationCD				= mod:NewCDCountTimer(28.8, 362028, nil, nil, nil, 2)
local timerChainsofOppressionCD					= mod:NewCDCountTimer(28.8, 362631, nil, nil, nil, 3)
local timerMartyrdomCD							= mod:NewCDCountTimer(28.8, 363893, DBM_COMMON_L.TANKCOMBOC, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerTormentCD							= mod:NewCDCountTimer(28.8, 365436, nil, nil, nil, 2)
local timerRuneofDamnationCD					= mod:NewCDCountTimer(28.8, 360281, nil, nil, nil, 3)

mod:AddSetIconOption("SetIconOnMartyrdom", 363893, true, false, {4})
mod:AddSetIconOption("SetIconOnDamnation", 360281, true, false, {1, 2, 3})

--Stage Two: Unholy Attunement
mod:AddTimerLine(DBM:EJ_GetSectionInfo(23925))
local warnUnholyAttunement						= mod:NewCountAnnounce(360373, 3)
local warnRuneofCompulsion						= mod:NewTargetCountAnnounce(366285, 3, nil, nil, nil, nil, nil, nil, true)
local warnDecimator								= mod:NewTargetCountAnnounce(364942, 3, nil, nil, nil, nil, nil, nil, true)

local specWarnWorldCracker						= mod:NewSpecialWarningCount(366678, nil, nil, nil, 2, 2, 4)
local specWarnGTFO								= mod:NewSpecialWarningGTFO(360425, nil, nil, nil, 1, 8)
local specWarnShatteringBlast					= mod:NewSpecialWarningMoveTo(359856, nil, nil, nil, 1, 2)
local specWarnRuneofCompulsion					= mod:NewSpecialWarningYou(366285, nil, nil, nil, 1, 2)
local yellRuneofCompulsion						= mod:NewShortPosYell(366285)
local yellRuneofCompulsionFades					= mod:NewIconFadesYell(366285)
local specWarnDecimator							= mod:NewSpecialWarningMoveAway(364942, nil, nil, nil, 1, 2)
local yellDecimator								= mod:NewYell(364942)
local yellDecimatorFades						= mod:NewShortFadesYell(364942)
local specWarnTormentingEcho					= mod:NewSpecialWarningDodge(365371, nil, nil, nil, 2, 2)

local timerWorldCrackerCD						= mod:NewAITimer(28.8, 366678, nil, nil, nil, 2, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerUnholyAttunementCD					= mod:NewCDCountTimer(28.8, 360373, nil, nil, nil, 3)
local timerShatteringBlastCD					= mod:NewCDCountTimer(28.8, 359856, nil, nil, nil, 5)
local timerRuneofCompulsionCD					= mod:NewCDCountTimer(28.8, 366285, nil, nil, nil, 3)
local timerDecimatorCD							= mod:NewCDCountTimer(28.8, 364942, nil, nil, nil, 3)

mod:AddSetIconOption("SetIconOnCopulsion", 366285, true, false, {1, 2, 3})
mod:AddSetIconOption("SetIconOnDecimator", 364942, true, false, {7})--7 to ensure no conflict in P3 either

--Stage Three: Eternity's End
mod:AddTimerLine(DBM:EJ_GetSectionInfo(24252))
local warnRuneofDomination						= mod:NewTargetCountAnnounce(365150, 3, nil, nil, nil, nil, nil, nil, true)
local warnChainsofAnguishLink					= mod:NewTargetNoFilterAnnounce(365219, 3)
local warnDefile								= mod:NewTargetNoFilterAnnounce(365169, 4)

local specWarnWorldShatterer					= mod:NewSpecialWarningCount(367051, nil, nil, nil, 2, 2, 4)
local specWarnDesolation						= mod:NewSpecialWarningCount(365033, nil, nil, nil, 2, 2)
local specWarnRuneofDomination					= mod:NewSpecialWarningYou(365150, nil, nil, nil, 1, 2)
local yellRuneofDomination						= mod:NewShortPosYell(365150)
local yellRuneofDominationFades					= mod:NewIconFadesYell(365150)
local specWarnChainsofAnguish					= mod:NewSpecialWarningDefensive(365219, nil, nil, nil, 1, 2)
local specWarnChainsofAnguishTaunt				= mod:NewSpecialWarningTaunt(365219, nil, nil, nil, 1, 2)
local specWarnChainsofAnguishLink				= mod:NewSpecialWarningYou(365219, nil, nil, nil, 1, 2)
local yellChainsofAnguishLink					= mod:NewShortPosYell(365219)
local specWarnDefile							= mod:NewSpecialWarningMoveAway(365169, nil, nil, nil, 3, 2)
local yellDefile								= mod:NewYell(365169)
local specWarnDefileNear						= mod:NewSpecialWarningClose(365169, nil, nil, nil, 1, 2)

local timerWorldShattererCD						= mod:NewAITimer(28.8, 367051, nil, nil, nil, 2, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerUnbreakableGraspCD					= mod:NewCDTimer(28.8, 363332, nil, nil, nil, 6)
local timerDesolationCD							= mod:NewCDCountTimer(28.8, 365033, nil, nil, nil, 3)
local timerRuneofDominationCD					= mod:NewCDCountTimer(28.8, 365150, nil, nil, nil, 3)
local timerChainsofAnguishCD					= mod:NewCDCountTimer(28.8, 365219, nil, nil, nil, 5)
local timerDefileCD								= mod:NewCDCountTimer(28.8, 365169, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)

mod:AddSetIconOption("SetIconOnDomination", 365150, true, false, {1, 2, 3})
mod:AddSetIconOption("SetIconOnChainsofAnguish", 365219, true, false, {4, 5, 6})
mod:AddSetIconOption("SetIconOnDefile", 365169, true, false, {8})
--mod:AddNamePlateOption("NPAuraOnBurdenofDestiny", 353432, true)

--General
mod.vb.worldCount = 0--Used in all 3 stages on mythic
mod.vb.tormentCount = 0--Used in all 3 stages
mod.vb.tankCount = 0--Martyrdom, Decimator
mod.vb.runeCount = 0--Used in all 3 stages
mod.vb.runeIcon = 1--Used in all 3 rune types
--P1
mod.vb.relentingCount = 0
mod.vb.chainsCount = 0--Also reused in P3
--P2
mod.vb.unholyCount = 0
mod.vb.shatteringCount = 0
--P3
mod.vb.desolationCount = 0
mod.vb.defileCount = 0
mod.vb.willTotal = 0
mod.vb.chainsIcon = 4

local difficultyName = "None"
local allTimers = {
	["other"] = {--Heroic, Normal, and LFR (probably not all together)
		[1] = {
			--Torment (lasts entire fight)
			[365436] = {21.9, 51, 69},
			--Martyrdom
			[363893] = {40, 40, 40, 40},
			--Relenting Domination
			[362028] = {48, 60},
			--Chains of Oppression
			[359809] = {90},
			--Rune of Damnation
			[360279] = {11, 19, 34, 32.9, 28, 25.9},
		},
		[2] = {
			--Torment (lasts entire fight)
			[365436] = {42, 49.9, 55, 45},
			--Decimator (lasts rest of fight)
			[360562] = {27.9, 57.5, 47.5, 42.9},
			--Unholy Attunement
			[360373] = {18.9, 45, 45, 45},
			--Shattering Blast
			[359856] = {34.5, 13.4, 30, 15, 30.9, 15.5, 28.4, 15.9},
			--Rune of Compulsion
			[366284] = {61.9, 60, 60},
		},
		[3] = {
			--Torment (lasts entire fight)
			[365436] = {26, 86.9},
			--Decimator (lasts rest of fight)
			[360562] = {34.9, 52, 41.9, 41.9},
			--Desolation
			[365033] = {41.9, 60, 60},
			--Rune of Domination
			[365147] = {63, 83.9},
			--Chains of Anguish
			[365212] = {51.9, 41.9, 41.9, 41.9},
			--Defile
			[365169] = {55, 40.9, 43, 42.9},
		},
	},
	["heroic"] = {
		[1] = {
			--Torment (lasts entire fight)
			[365436] = {11, 52, 45, 47},
			--Martyrdom
			[363893] = {31, 40, 52, 39},
			--Relenting Domination
			[362028] = {55, 56.9, 56},
			--Chains of Oppression
			[359809] = {40, 48, 49},
			--Rune of Damnation
			[360279] = {22, 25, 29, 21, 30.5, 19.5},
		},
		[2] = {
			--Torment (lasts entire fight)
			[365436] = {22, 16, 35.4, 61.5},--Double check 65
			--Decimator (lasts rest of fight)
			[360562] = {26, 41, 80},
			--Unholy Attunement
			[360373] = {19, 45, 45, 46.5},
			--Shattering Blast
			[359856] = {33, 16, 30, 15, 29, 17},
			--Rune of Compulsion
			[366284] = {40.9, 46, 45},
		},
		[3] = {
			--Torment (lasts entire fight)
			[365436] = {51, 74.9},
			--Decimator (lasts rest of fight)
			[360562] = {26, 37.9, 47, 32.9, 40},
			--Desolation
			[365033] = {42, 59.9, 64},
			--Rune of Domination
			[365147] = {71, 78.9},
			--Chains of Anguish
			[365212] = {37, 55, 43, 42.9},
			--Defile
			[365169] = {33, 44.9, 44.9, 52},
		},
	},
	["mythic"] = {--Most definitely different, heroic timers placeholdered for now
		[1] = {
			--World Crusher
			[366374] = {},
			--Torment (lasts entire fight)
			[365436] = {11, 52, 45, 47},
			--Martyrdom
			[363893] = {31, 40, 52, 39},
			--Relenting Domination
			[362028] = {55, 56.9, 56},
			--Chains of Oppression
			[359809] = {40, 48, 49},
			--Rune of Damnation
			[360279] = {22, 25, 29, 21, 30.5, 19.5},
		},
		[2] = {
			--World Cracker
			[366678] = {},
			--Torment (lasts entire fight)
			[365436] = {22, 16, 35.4, 61.5},--Double check 65
			--Decimator (lasts rest of fight)
			[360562] = {26, 41, 80},
			--Unholy Attunement
			[360373] = {19, 45, 45, 46.5},
			--Shattering Blast
			[359856] = {33, 16, 30, 15, 29, 17},
			--Rune of Compulsion
			[366284] = {40.9, 46, 45},
		},
		[3] = {
			--World Shatterer
			[367051] = {},
			--Torment (lasts entire fight)
			[365436] = {51, 74.9},
			--Decimator (lasts rest of fight)
			[360562] = {26, 37.9, 47, 32.9, 40},
			--Desolation
			[365033] = {42, 59.9, 64},
			--Rune of Domination
			[365147] = {71, 78.9},
			--Chains of Anguish
			[365212] = {37, 55, 43, 42.9},
			--Defile
			[365169] = {33, 44.9, 44.9, 52},
		},
	},
}

function mod:OnCombatStart(delay)
	--General
	self.vb.worldCount = 0--Used in all 3 stages on mythic
	self.vb.tormentCount = 0--Used in all 3 stages
	self.vb.tankCount = 0--Martyrdom, Decimator
	self.vb.runeCount = 0--Used in all 3 stages
	self.vb.runeIcon = 1--Used in all 3 rune types
	--1
	self.vb.relentingCount = 0
	self.vb.chainsCount = 0--Also reused in P3
	--2
	self.vb.unholyCount = 0
	self.vb.shatteringCount = 0
	--3
	self.vb.desolationCount = 0
	self.vb.defileCount = 0
	self.vb.willTotal = 0
	self.vb.chainsIcon = 4
	self:SetStage(1)
	if self:IsMythic() then
		difficultyName = "mythic"
		timerWorldCrusherCD:Start(1-delay)
	elseif self:IsHeroic() then
		difficultyName = "heroic"
		timerTormentCD:Start(11-delay, 1)
		timerRuneofDamnationCD:Start(21-delay, 1)
		timerMartyrdomCD:Start(31-delay, 1)
		timerChainsofOppressionCD:Start(40-delay, 1)
		timerRelentingDominationCD:Start(55-delay, 1)
	else
		difficultyName = "other"
		timerRuneofDamnationCD:Start(11-delay, 1)
		timerTormentCD:Start(21.9-delay, 1)
		timerMartyrdomCD:Start(40-delay, 1)
		timerRelentingDominationCD:Start(48-delay, 1)
		timerChainsofOppressionCD:Start(90-delay, 1)
	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(328897))
--		DBM.InfoFrame:Show(10, "table", ExsanguinatedStacks, 1)
--	end
--	if self.Options.NPAuraOnBurdenofDestiny then
--		DBM:FireEvent("BossMod_EnableHostileNameplates")
--	end
end

function mod:OnCombatEnd()
--	table.wipe(castsPerGUID)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
--	if self.Options.NPAuraOnBurdenofDestiny then
--		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
--	end
end

function mod:OnTimerRecovery()
	if self:IsMythic() then
		difficultyName = "mythic"
	elseif self:IsHeroic() then
		difficultyName = "heroic"
	else
		difficultyName = "other"
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 362028 then
		self.vb.relentingCount = self.vb.relentingCount + 1
		specWarnRelentingDomination:Show(DBM_COMMON_L.BREAK_LOS)
		specWarnRelentingDomination:Play("findshelter")
		local timer = allTimers[difficultyName][self.vb.phase][spellId][self.vb.relentingCount+1] or 60
		if timer then
			timerRelentingDominationCD:Start(timer, self.vb.relentingCount+1)
		end
	elseif spellId == 366022 then
		warnTyranny:Show()
	elseif spellId == 360373 then
		self.vb.unholyCount = self.vb.unholyCount + 1
		warnUnholyAttunement:Show(self.vb.unholyCount)
		local timer = allTimers[difficultyName][self.vb.phase][spellId][self.vb.unholyCount+1] or 45
		if timer then
			timerUnholyAttunementCD:Start(timer, self.vb.unholyCount+1)
		end
	elseif spellId == 359856 then
		self.vb.shatteringCount = self.vb.shatteringCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnShatteringBlast:Show(L.Pylon)
			specWarnShatteringBlast:Play("findshelter")--Kind of a crappy voice for it but don't have a valid one that sounds better
		end
		local timer = allTimers[difficultyName][self.vb.phase][spellId][self.vb.shatteringCount+1]
		if timer then
			timerShatteringBlastCD:Start(timer, self.vb.shatteringCount+1)
		end
--	elseif args:IsSpellID(364942, 360562, 364488) then--All deciminator casts with a cast time
		--Use if UNIT event target scanning fails
	elseif spellId == 365033 then
		self.vb.desolationCount = self.vb.desolationCount + 1
		specWarnDesolation:Show(self.vb.desolationCount)
		specWarnDesolation:Play("helpsoak")
		local timer = allTimers[difficultyName][self.vb.phase][spellId][self.vb.desolationCount+1] or 60
		if timer then
			timerDesolationCD:Start(timer, self.vb.desolationCount+1)
		end
	elseif spellId == 365212 then
		self.vb.chainsCount = self.vb.chainsCount + 1
		self.vb.chainsIcon = 4
		local timer = allTimers[difficultyName][self.vb.phase][spellId][self.vb.chainsCount+1] or 41.9
		if timer then
			timerChainsofAnguishCD:Start(timer, self.vb.chainsCount+1)
		end
	elseif spellId == 365169 then
		self.vb.defileCount = self.vb.defileCount + 1
		local timer = allTimers[difficultyName][self.vb.phase][spellId][self.vb.defileCount+1] or 40.9--40.9 iffy minimum, need more sequenced data
		if timer then
			timerDefileCD:Start(timer, self.vb.defileCount+1)
		end
	elseif spellId == 366374 then
		self.vb.worldCount = self.vb.worldCount + 1
		specWarnWorldCrusher:Show(self.vb.worldCount)
		specWarnWorldCrusher:Play("specialsoon")
		timerWorldCrusherCD:Start()
	elseif spellId == 366678 then
		self.vb.worldCount = self.vb.worldCount + 1
		specWarnWorldCracker:Show(self.vb.worldCount)
		specWarnWorldCracker:Play("specialsoon")
		timerWorldCrackerCD:Start()
	elseif spellId == 367851 then--Transitional Relentless Domination
		specWarnRelentingDomination:Show(DBM_COMMON_L.BREAK_LOS)
		specWarnRelentingDomination:Play("findshelter")
		self:SetStage(2)
		--General
		self.vb.worldCount = 0--Used in all 3 stages on mythic
		self.vb.tormentCount = 0--Used in all 3 stages
		self.vb.tankCount = 0--Martyrdom, Decimator
		self.vb.runeCount = 0--Used in all 3 stages
		--2
		self.vb.unholyCount = 0
		self.vb.shatteringCount = 0
		self.vb.runeCount = 0
		timerWorldCrusherCD:Stop()
		timerRelentingDominationCD:Stop()
		timerChainsofOppressionCD:Stop()
		timerMartyrdomCD:Stop()
		timerTormentCD:Stop()
		timerRuneofDamnationCD:Stop()
		if self:IsMythic() then
			timerWorldCrackerCD:Start(2)
			--Placeholder heroic timers
			timerUnholyAttunementCD:Start(18.9, 1)
			timerTormentCD:Start(22, 1)
			timerDecimatorCD:Start(26, 1)
			timerShatteringBlastCD:Start(33, 1)
			timerRuneofCompulsionCD:Start(40, 1)
		elseif self:IsHeroic() then
			timerUnholyAttunementCD:Start(18.9, 1)
			timerTormentCD:Start(22, 1)
			timerDecimatorCD:Start(26, 1)
			timerShatteringBlastCD:Start(33, 1)
			timerRuneofCompulsionCD:Start(40, 1)
		else
			timerUnholyAttunementCD:Start(18.9, 1)
			timerDecimatorCD:Start(27.9, 1)
			timerShatteringBlastCD:Start(34.5, 1)
			timerTormentCD:Start(42, 1)
			timerRuneofCompulsionCD:Start(61.9, 1)
		end
	elseif spellId == 367290 then--Transitional Unholy Attunement (possibly even earlier P3 trigger)
		self.vb.unholyCount = self.vb.unholyCount + 1
		warnUnholyAttunement:Show(self.vb.unholyCount)
		timerWorldCrackerCD:Stop()
		timerUnholyAttunementCD:Stop()
		timerShatteringBlastCD:Stop()
		timerRuneofCompulsionCD:Stop()
		timerDecimatorCD:Stop()
		timerUnbreakableGraspCD:Start(10.5)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 363332 then--Unbreaking Grasp
		self:SetStage(3)
		--General
		self.vb.worldCount = 0--Used in all 3 stages on mythic
		self.vb.tormentCount = 0--Used in all 3 stages
		self.vb.tankCount = 0--Martyrdom, Decimator
		self.vb.runeCount = 0--Used in all 3 stages
		--1
		self.vb.chainsCount = 0--Also reused in P3
		--3
		self.vb.desolationCount = 0
		self.vb.defileCount = 0
		if self:IsMythic() then
			timerWorldShattererCD:Start(3)
			--Heroic timers are placeholder right now
			timerDecimatorCD:Start(26, 1)
			timerDefileCD:Start(33, 1)
			timerChainsofAnguishCD:Start(37, 1)
			timerDesolationCD:Start(41.9, 1)
			timerTormentCD:Start(51, 1)
			timerRuneofDominationCD:Start(71, 1)
		elseif self:IsHeroic() then
			timerDecimatorCD:Start(26, 1)
			timerDefileCD:Start(33, 1)
			timerChainsofAnguishCD:Start(37, 1)
			timerDesolationCD:Start(41.9, 1)
			timerTormentCD:Start(51, 1)
			timerRuneofDominationCD:Start(71, 1)
		else
			timerTormentCD:Start(26, 1)
			timerDecimatorCD:Start(34.9, 1)
			timerDesolationCD:Start(41.9, 1)
			timerChainsofAnguishCD:Start(51.9, 1)
			timerDefileCD:Start(55, 1)
			timerRuneofDominationCD:Start(63, 1)
		end
	elseif spellId == 359809 then
		self.vb.chainsCount = self.vb.chainsCount + 1
		local timer = allTimers[difficultyName][self.vb.phase][spellId][self.vb.chainsCount+1]
		if timer then
			timerChainsofOppressionCD:Start(timer, self.vb.chainsCount+1)
		end
	elseif spellId == 367051 then
		self.vb.worldCount = self.vb.worldCount + 1
		specWarnWorldShatterer:Show(self.vb.worldCount)
		specWarnWorldShatterer:Play("specialsoon")
		timerWorldShattererCD:Start()
	elseif spellId == 363893 then
		self.vb.tankCount = self.vb.tankCount + 1
		local timer = allTimers[difficultyName][self.vb.phase][spellId][self.vb.tankCount+1] or 40
		if timer then
			timerMartyrdomCD:Start(timer, self.vb.tankCount+1)
		end
		if args:IsPlayer() then
			specWarnMartyrdom:Show()
			specWarnMartyrdom:Play("defensive")
			yellMartyrdom:Yell()
			yellMartyrdomFades:Countdown(4)
--		elseif self:IsTank() then--You need to move away from it, to avoid physical damage taken debuff
			--Maybe a tauntboss warning? depends on if it screws with targetting or not
		else
			warnMartyrdom:Show(self.vb.tankCount, args.destName)
		end
		if self.Options.SetIconOnMartyrdom then
			self:SetIcon(args.destName, 4)
		end
	elseif spellId == 365436 then
		self.vb.tormentCount = self.vb.tormentCount + 1
		if self:AntiSpam(5, 1) then
			local timer = allTimers[difficultyName][self.vb.phase][spellId][self.vb.tormentCount+1]
			if timer then
				timerTormentCD:Start(timer, self.vb.tormentCount+1)
			end
		end
	elseif spellId == 360279 then
		if self:AntiSpam(5, 2) then--Success doesn't always fire first, so this check done in debuff and success handler
			self.vb.runeCount = self.vb.runeCount + 1
			self.vb.runeIcon = 1
		end
		local timer = allTimers[difficultyName][self.vb.phase][spellId][self.vb.runeCount+1]
		if timer then
			timerRuneofDamnationCD:Start(timer, self.vb.runeCount+1)
		end
	elseif spellId == 366284 then
		if self:AntiSpam(5, 2) then--Success doesn't always fire first, so this check done in debuff and success handler
			self.vb.runeCount = self.vb.runeCount + 1
			self.vb.runeIcon = 1
		end
		local timer = allTimers[difficultyName][self.vb.phase][spellId][self.vb.runeCount+1] or 60
		if timer then
			timerRuneofCompulsionCD:Start(timer, self.vb.runeCount+1)
		end
	elseif spellId == 365147 then
		if self:AntiSpam(5, 2) then--Success doesn't always fire first, so this check done in debuff and success handler
			self.vb.runeCount = self.vb.runeCount + 1
			self.vb.runeIcon = 1
		end
		local timer = allTimers[difficultyName][self.vb.phase][spellId][self.vb.runeCount+1]
		if timer then
			timerRuneofDominationCD:Start(timer, self.vb.runeCount+1)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 362631 then
		warnChainsofOppression:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnChainsofOppression:Show()
			specWarnChainsofOppression:Play("targetyou")
		end
	elseif spellId == 362192 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) and not args:IsPlayer() and not DBM:UnitDebuff("player", spellId) then
			specWarnMisery:Show(args.destName)
			specWarnMisery:Play("tauntboss")
		end
	elseif spellId == 362401 then
		if self:AntiSpam(5, 1) then--In P3, torment cast stopos being in combat log
			local timer = allTimers[difficultyName][self.vb.phase][spellId][self.vb.tormentCount+1]
			if timer then
				timerTormentCD:Start(timer, self.vb.tormentCount+1)
			end
		end
		if args:IsPlayer() then
			specWarnTorment:Show()
			specWarnTorment:Play("scatter")
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(6)
			end
			if self.vb.phase >= 2 then
				specWarnTormentingEcho:Schedule(6)
				specWarnTormentingEcho:ScheduleVoice(6, "watchstep")
			end
		end
	elseif spellId == 360281 then
		if self:AntiSpam(5, 2) then
			self.vb.runeCount = self.vb.runeCount + 1
			self.vb.runeIcon = 1
		end
		local icon = self.vb.runeIcon
		if self.Options.SetIconOnDamnation then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnRuneofDamnation:Show()
			specWarnRuneofDamnation:Play("runout")
			yellRuneofDamnation:Yell(icon, icon)
			yellRuneofDamnationFades:Countdown(spellId, nil, icon)
		end
		warnRuneofDamnation:CombinedShow(0.5, self.vb.runeCount, args.destName)
		self.vb.runeIcon = self.vb.runeIcon + 1
	elseif spellId == 366285 then
		if self:AntiSpam(5, 2) then
			self.vb.runeCount = self.vb.runeCount + 1
			self.vb.runeIcon = 1
		end
		local icon = self.vb.runeIcon
		if self.Options.SetIconOnCopulsion then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnRuneofCompulsion:Show()
			specWarnRuneofCompulsion:Play("runout")
			yellRuneofCompulsion:Yell(icon, icon)
			yellRuneofCompulsionFades:Countdown(spellId, nil, icon)
		end
		warnRuneofCompulsion:CombinedShow(0.5, self.vb.runeCount, args.destName)
		self.vb.runeIcon = self.vb.runeIcon + 1
	elseif spellId == 365150 then
		if self:AntiSpam(5, 2) then
			self.vb.runeCount = self.vb.runeCount + 1
			self.vb.runeIcon = 1
		end
		local icon = self.vb.runeIcon
		if self.Options.SetIconOnDomination then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnRuneofDomination:Show()
			specWarnRuneofDomination:Play("runout")
			yellRuneofDomination:Yell(icon, icon)
			yellRuneofDominationFades:Countdown(spellId, nil, icon)
		end
		warnRuneofDomination:CombinedShow(0.5, self.vb.runeCount, args.destName)
		self.vb.runeIcon = self.vb.runeIcon + 1
	elseif spellId == 365222 then
		local icon = self.vb.chainsIcon
		if self.Options.SetIconOnChainsofAnguish then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnChainsofAnguishLink:Show()
			specWarnChainsofAnguishLink:Play("targetyou")
			yellChainsofAnguishLink:Yell(icon, icon-3)--minus 3 so debuff count is still 1 2 and 3 when using icons 4 5 and 6
		end
		warnChainsofAnguishLink:CombinedShow(0.5, args.destName)
		self.vb.chainsIcon = self.vb.chainsIcon + 1
	elseif spellId == 365153 then--Imposing Will
		self.vb.willTotal = self.vb.willTotal + 1
		if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() then
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(20, "playerabsorb", spellId)
		end
--	elseif spellId == 362024 then
--		if args:IsPlayer() then
--			specWarnRelentingDomination:Show(DBM_COMMON_L.BREAK_LOS)
--			specWarnRelentingDomination:Play("findshelter")
--		end
	elseif spellId == 362075 then
		warnDomination:CombinedShow(1, args.destName)
	elseif spellId == 365219 then
		if args:IsPlayer() then
			specWarnChainsofAnguish:Show()
			specWarnChainsofAnguish:Play("defensive")
		else
			specWarnChainsofAnguishTaunt:Show(args.destName)
			specWarnChainsofAnguishTaunt:Play("tauntboss")
		end
		warnChainsofAnguishLink:CombinedShow(0.5, args.destName)--Combine into the linked targets table
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 363886 then
--		if args:IsPlayer() then
--			yellMartyrdomFades:Cancel()--Don't cancel yet, freedom might dispel it, but misery is still coming?
--		end
		if self.Options.SetIconOnMartyrdom then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 362401 and args:IsPlayer() then
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif spellId == 360281 then
		if self.Options.SetIconOnDamnation then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellRuneofDamnationFades:Cancel()
		end
	elseif spellId == 366285 then
		if self.Options.SetIconOnCopulsion then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellRuneofCompulsionFades:Cancel()
		end
	elseif spellId == 365150 then
		if self.Options.SetIconOnDomination then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellRuneofDominationFades:Cancel()
		end
	elseif spellId == 365153 then--Imposing Will
		self.vb.willTotal = self.vb.willTotal - 1
		if self.Options.InfoFrame and self.vb.willTotal == 0 then
			DBM.InfoFrame:Hide()
		end
	end
end

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 183787 then

	end
end
--]]

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if (spellId == 360425 or spellId == 365174) and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

do
	function mod:DecimatorTarget(targetname, uId)
		if not targetname then return end
		if self.Options.SetIconOnDecimator then
			self:SetIcon(targetname, 7, 4)--So icon clears 1 second after
		end
		if targetname == UnitName("player") then
			specWarnDecimator:Show()
			specWarnDecimator:Play("runout")
			yellDecimator:Yell()
			yellDecimatorFades:Countdown(2.97)--This scan method doesn't support scanningTime, but should be about right
		else
			warnDecimator:Show(self.vb.tankCount, targetname)
		end
	end

	function mod:DefileTarget(targetname, uId)
		if not targetname then return end
		if self.Options.SetIconOnDecimator then
			self:SetIcon(targetname, 8, 3)--So icon clears 1 second after
		end
		if targetname == UnitName("player") then
			specWarnDefile:Show()
			specWarnDefile:Play("runout")
			yellDefile:Yell()
		elseif self:CheckNearby(10, targetname) then
			specWarnDefileNear:Show(targetname)
			specWarnDefileNear:Play("runaway")
		else
			warnDefile:Show(targetname)
		end
	end

	function mod:UNIT_SPELLCAST_START(uId, _, spellId)
		if spellId == 360562 then--spellId == 364942 or spellId == 364488
			self.vb.tankCount = self.vb.tankCount + 1--This event may be before CLEU event so just make sure count updated before target scan
			local timer = allTimers[difficultyName][self.vb.phase][spellId][self.vb.tankCount+1]
			if timer then
				timerDecimatorCD:Start(timer, self.vb.tankCount+1)
			end
			self:BossUnitTargetScanner(uId, "DecimatorTarget", 3)
		elseif spellId == 365169 then
			self:BossUnitTargetScanner(uId, "DefileTarget", 3)
		end
	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 360507 then--Trigger Azeroth Visibility (may not be reliable for mythic, replace with diff P3 trigger if possible)

	end
end
--]]
