local mod	= DBM:NewMod(2464, "DBM-Sepulcher", nil, 1195)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(180990)
mod:SetEncounterID(2537)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
mod:SetHotfixNoticeRev(20220423160000)
mod:SetMinSyncRevision(20220329000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 362028 360373 359856 364942 360562 364488 365033 365212 365169 366374 366678 367851 360378",--363179
	"SPELL_CAST_SUCCESS 359809 367051 363893 365436 360279 366284 365147 363332 370071 363772",
	"SPELL_AURA_APPLIED 362401 360281 366285 365150 365153 362075 365219 365222 362192 368383 360174 368593 363748 368591 181089",--362024 360180
	"SPELL_AURA_REMOVED 362401 360281 366285 365150 365153 365222 368383 360174 368593 363748 368591",--360180
	"SPELL_PERIODIC_DAMAGE 360425 365174",
	"SPELL_PERIODIC_MISSED 360425 365174",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, is tyranny warning appropriate? maybe track debuff for mythic?
--TODO, verify add marking
--TODO, what type of warning for Unholy Attunement
--TODO, do something with https://www.wowhead.com/spell=365810/falling-debris ?
--TODO, maybe short name chains in all phases to "chains"? might remove ability to tell them apart though. maybe use Anguish, Oppression instead
--TODO, azeroth health tracking on infoframe? (Widget ID: 3554). Feels like something people will prefer weak auras for so hands offing it for no unless requested enough
--[[
(ability.id = 362028 or ability.id = 363893 or ability.id = 360373 or ability.id = 359856 or ability.id = 364942 or ability.id = 360562 or ability.id = 364488 or ability.id = 365033 or ability.id = 365212 or ability.id = 365169 or ability.id = 366374 or ability.id = 366678 or ability.id = 367290 or ability.id = 367851 or ability.id = 360378 or ability.id = 363772 or ability.id = 360143) and type = "begincast"
 or (ability.id = 359809 or ability.id = 367051 or ability.id = 363893 or ability.id = 365436 or ability.id = 360279 or ability.id = 366284 or ability.id = 365147 or ability.id = 363332 or ability.id = 370071 or ability.id = 363772) and type = "cast"
 or ability.id = 181089 or ability.id = 368383
 or ability.id = 366132 and type = "applydebuff"
--]]
--General
local warnPhase									= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)
local warnHealAzeroth							= mod:NewAnnounce("warnHealAzeroth", 3, 366401, nil, nil, nil, 366401)

local timerPhaseCD								= mod:NewPhaseTimer(30)
local timerPits									= mod:NewTimer(28.8, "timerPits", 353643, nil, nil, 3)--Stages 1-3
local timerHealAzeroth							= mod:NewTimer(28.8, "timerHealAzeroth", 366401, nil, nil, 5, nil, nil, nil, nil, nil, nil, nil, 366401)--Stages 1-3

--local berserkTimer							= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption("6")

--Stage One: Origin of Domination
mod:AddTimerLine(DBM:EJ_GetSectionInfo(24087))
local warnDomination							= mod:NewTargetNoFilterAnnounce(362075, 4)
local warnTyranny								= mod:NewCastAnnounce(366022, 3, 4)
local warnMartyrdom								= mod:NewTargetCountAnnounce(363893, 4, nil, nil, nil, nil, nil, nil, true)
local warnRuneofDamnation						= mod:NewTargetCountAnnounce(360281, 3, nil, nil, nil, nil, nil, nil, true)

local specWarnWorldCrusher						= mod:NewSpecialWarningCount(366374, nil, nil, nil, 2, 2, 4)
local specWarnRelentingDomination				= mod:NewSpecialWarningMoveTo(362028, nil, nil, nil, 1, 2)
local specWarnChainsofOppression				= mod:NewSpecialWarningRun(362631, nil, nil, nil, 4, 2)
local specWarnMartyrdom							= mod:NewSpecialWarningDefensive(363893, nil, nil, nil, 1, 2)
local yellMartyrdom								= mod:NewYell(363893, nil, nil, nil, "YELL")--rooted target = stack target for misery very likely
local yellMartyrdomFades						= mod:NewShortFadesYell(363893, nil, nil, nil, "YELL")
local specWarnMisery							= mod:NewSpecialWarningTaunt(362192, nil, nil, nil, 1, 2, 4)
local specWarnTorment							= mod:NewSpecialWarningMoveAway(365436, nil, nil, nil, 1, 2)
local specWarnRuneofDamnation					= mod:NewSpecialWarningYou(360281, nil, nil, nil, 1, 2)
local specWarnRuneofDamnationPit				= mod:NewSpecialWarningMoveTo(360281, nil, nil, nil, 1, 7)
local yellRuneofDamnation						= mod:NewShortPosYell(360281, 166419)--short text "Rune"
local yellRuneofDamnationFades					= mod:NewIconFadesYell(360281)

--local timerWorldCrusherCD						= mod:NewAITimer(28.8, 366374, nil, nil, nil, 2, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerRelentingDominationCD				= mod:NewCDCountTimer(28.8, 362028, nil, nil, nil, 2)
local timerTyrany								= mod:NewCDTimer(11, 366132, nil, nil, nil, 3)
local timerChainsofOppressionCD					= mod:NewCDCountTimer(28.8, 362631, nil, nil, nil, 3)
local timerMartyrdomCD							= mod:NewCDCountTimer(28.8, 363893, DBM_COMMON_L.TANKCOMBOC, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerTormentCD							= mod:NewCDCountTimer(28.8, 365436, nil, nil, nil, 2)
local timerRuneofDamnationCD					= mod:NewCDCountTimer(28.8, 360281, DBM_COMMON_L.BOMBS.." (%s)", nil, nil, 3)

mod:AddSetIconOption("SetIconOnMartyrdom2", 363893, false, false, {7})
mod:AddSetIconOption("SetIconOnDamnation", 360281, true, false, {1, 2, 3, 4, 5, 6})

--Stage Two: Unholy Attunement
mod:AddTimerLine(DBM:EJ_GetSectionInfo(23925))
local warnUnholyAttunement						= mod:NewCountAnnounce(360373, 3)
local warnRuneofCompulsion						= mod:NewTargetCountAnnounce(366285, 3, nil, nil, nil, nil, nil, nil, true)

local specWarnWorldCracker						= mod:NewSpecialWarningSpell(366678, nil, nil, nil, 2, 2, 4)
local specWarnGTFO								= mod:NewSpecialWarningGTFO(360425, nil, nil, nil, 1, 8)
local specWarnShatteringBlast					= mod:NewSpecialWarningMoveTo(359856, nil, nil, nil, 1, 2)
local specWarnRuneofCompulsion					= mod:NewSpecialWarningYou(366285, nil, nil, nil, 1, 2)
local yellRuneofCompulsion						= mod:NewShortPosYell(366285, 166419)--short text "Rune"
local yellRuneofCompulsionFades					= mod:NewIconFadesYell(366285)
local specWarnDecimator							= mod:NewSpecialWarningCount(364942, nil, 72994, nil, 2, 2)
local specWarnTormentingEcho					= mod:NewSpecialWarningDodge(365371, nil, nil, nil, 2, 2)

local timerWorldCrackerCD						= mod:NewCDCountTimer(28.8, 366678, nil, nil, nil, 2, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerUnholyAttunementCD					= mod:NewCDCountTimer(28.8, 360373, nil, nil, nil, 3)
local timerShatteringBlastCD					= mod:NewCDCountTimer(28.8, 359856, nil, nil, nil, 5)
local timerRuneofCompulsionCD					= mod:NewCDCountTimer(28.8, 366285, DBM_COMMON_L.MINDCONTROL.." (%s)", nil, nil, 3)
local timerDecimatorCD							= mod:NewCDCountTimer(28.8, 364942, 72994, nil, nil, 2)

mod:AddSetIconOption("SetIconOnCopulsion", 366285, true, false, {1, 2, 3, 4})

--Stage Three: Eternity's End
mod:AddTimerLine(DBM:EJ_GetSectionInfo(24252))
local warnUnbreakableGrasp						= mod:NewSpellAnnounce(363332, 2)
local warnRuneofDomination						= mod:NewTargetCountAnnounce(365150, 3, nil, nil, nil, nil, nil, nil, true)
local warnChainsofAnguishLink					= mod:NewTargetNoFilterAnnounce(365219, 3)
local warnDefile								= mod:NewTargetNoFilterAnnounce(365169, 4)

local specWarnWorldShatterer					= mod:NewSpecialWarningCount(367051, nil, nil, nil, 2, 2, 4)
local specWarnDesolation						= mod:NewSpecialWarningCount(365033, nil, nil, nil, 2, 2)
local specWarnRuneofDomination					= mod:NewSpecialWarningYouPos(365150, nil, nil, nil, 1, 2)
local yellRuneofDomination						= mod:NewShortPosYell(365150, 166419)--short text "Rune"
local yellRuneofDominationFades					= mod:NewIconFadesYell(365150)
local specWarnChainsofAnguish					= mod:NewSpecialWarningDefensive(365219, nil, nil, nil, 1, 2)
local specWarnChainsofAnguishTaunt				= mod:NewSpecialWarningTaunt(365219, nil, nil, nil, 1, 2)
local specWarnChainsofAnguishLink				= mod:NewSpecialWarningYou(365219, nil, nil, nil, 1, 2)
local yellChainsofAnguishLink					= mod:NewShortYell(365219)
local specWarnDefile							= mod:NewSpecialWarningCount(365169, nil, nil, nil, 3, 2)
--local yellDefile								= mod:NewYell(365169)
--local specWarnDefileNear						= mod:NewSpecialWarningClose(365169, nil, nil, nil, 1, 2)

local timerWorldShattererCD						= mod:NewCDTimer(28.8, 367051, nil, nil, nil, 2, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerUnbreakableGraspCD					= mod:NewCDTimer(28.8, 363332, nil, nil, nil, 6)
local timerDesolationCD							= mod:NewCDCountTimer(28.8, 365033, L.AzerothSoak.." (%s)", nil, nil, 3)
local timerRuneofDominationCD					= mod:NewCDCountTimer(28.8, 365150, DBM_COMMON_L.GROUPSOAKS.." (%s)", nil, nil, 3)
local timerChainsofAnguishCD					= mod:NewCDCountTimer(28.8, 365219, nil, nil, nil, 5)
local timerDefileCD								= mod:NewCDCountTimer(28.8, 365169, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)

mod:AddSetIconOption("SetIconOnDomination2", 365150, true, false, {1, 2, 3})
mod:AddSetIconOption("SetIconOnChainsofAnguish", 365219, true, false, {5, 6, 7, 8})
--mod:AddSetIconOption("SetIconOnDefile", 365169, true, false, {8})
--Stage Four: Hidden Mythic Stage
mod:AddTimerLine(SCENARIO_STAGE:format(4))
local warnLifeShieldOver				= mod:NewEndAnnounce(368383, 1)
local warnDeathSentence					= mod:NewTargetNoFilterAnnounce(363772, 4)--Initial death sentence
local warnDispel						= mod:NewAnnounce("warnDispel", 3, 182887, nil, nil, nil, 363772)

local specWarnMeteorCleave				= mod:NewSpecialWarningCount(360378, nil, nil, nil, 2, 2, 4)
local specWarnMeteorCleaveTaunt			= mod:NewSpecialWarningTaunt(360378, nil, nil, nil, 1, 2, 4)
local specWarnDeathSentence				= mod:NewSpecialWarningYou(363772, nil, nil, nil, 1, 2, 4)
local yellDeathSentence					= mod:NewShortYell(363772, nil, false)
local yellDeathSentenceFades			= mod:NewShortFadesYell(363772)

local timerMeteorCleaveCD				= mod:NewCDCountTimer(28.8, 360378, nil, nil, nil, 5, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerDeathSentenceCD				= mod:NewCDTimer(28.8, 363772, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerDispels						= mod:NewTimer(28.8, "timerDispels", 182887, nil, nil, 5, DBM_COMMON_L.MAGIC_ICON, nil, nil, nil, nil, nil, nil, 363772)--Stages 4

--Common text replacements for some warnings that help clarify mechanics as well as more closely align with other mods
if DBM.Options.WarningShortText then
	--Stage1
	warnMartyrdom:SetText(DBM_COMMON_L.TANKCOMBO)
	warnRuneofDamnation:SetText(DBM_COMMON_L.BOMB)
	specWarnMartyrdom:SetText(DBM_COMMON_L.TANKCOMBO)
	specWarnRuneofDamnation:SetText(DBM_COMMON_L.BOMB)
	specWarnRuneofDamnationPit:SetText(DBM_COMMON_L.BOMB)
	--Stage2
	warnRuneofCompulsion:SetText(DBM_COMMON_L.MINDCONTROL)
	specWarnRuneofCompulsion:SetText(DBM_COMMON_L.MINDCONTROL)
	--Stage3
	warnRuneofDomination:SetText(DBM_COMMON_L.GROUPSOAKS)
	specWarnRuneofDomination:SetText(DBM_COMMON_L.GROUPSOAK)
	specWarnDesolation:SetText(L.AzerothSoak)
end

--General
mod.vb.worldCount = 0--Used in all 3 stages on mythic
mod.vb.tormentCount = 0--Used in all 3 stages
mod.vb.tankCount = 0--Martyrdom, Shattering Blast, Meteor Cleave
mod.vb.runeCount = 0--Used in all 3 stages
mod.vb.runeIcon = 1--Used in all 3 rune types
mod.vb.echoCount = 0
--P1
mod.vb.relentingCount = 0
mod.vb.chainsCount = 0--Also reused in P3
--P2
mod.vb.unholyCount = 0
mod.vb.decimatorCount = 0
--P3
mod.vb.desolationCount = 0
mod.vb.defileCount = 0
mod.vb.willTotal = 0
mod.vb.chainsIcon = 8

local difficultyName = mod:IsMythic() and "mythic" or mod:IsHeroic() and "heroic" or "easy"
local allTimers = {
	["lfr"] = {
		[1] = {
			--Torment (lasts entire fight)
			[365436] = {21.9, 51, 69},
			--Martyrdom
			[363893] = {39.9, 40, 40, 40},
			--Relentless Domination
			[362028] = {47.9, 60, 60},
			--Chains of Oppression
			[359809] = {89.9},
			--Rune of Damnation
			[360279] = {10.9, 19, 34, 32.9, 28, 25.9},
		},
		[2] = {
			--Torment (lasts entire fight)
			[365436] = {25, 59, 17.9, 39, 38.9},
			--Decimator (lasts rest of fight)
			[360562] = {11, 64.9, 39, 50},
			--Unholy Attunement
			[360373] = {184.6},--Only used once in LFR
			--Shattering Blast
			[359856] = {18, 21.9, 22, 27.9, 18, 19.9, 22, 21.9},
			--Rune of Compulsion
			[366284] = {47, 48, 61.9},
		},
		[3] = {
			--Torment (lasts entire fight)
			[365436] = {27, 49.9, 32, 9.9, 46, 41, 32, 9.9, 45.9, 42, 31.9, 9.9, 46, 41.9, 32, 9.9, 45.9},--45.9, 41, 31.9, 9.9 except first two casts in first set
			--Decimator (lasts rest of fight)
			[360562] = {36, 51.9, 42, 42, 45, 41.9, 42, 46, 41.9, 42, 46, 42},--42, 45, 42 repeating except for two casts in first set
			--Desolation
			[365033] = {},--Not used in LFR
			--Rune of Domination
			[365147] = {63.9, 84, 45, 84, 46, 83.9, 46, 84},--45, 84 repeating except first cast in first set
			--Chains of Anguish
			[365212] = {52.9, 42, 41.9, 41.9, 45, 42, 41.9, 46, 42, 41.9, 46, 42},--45, 42, 42 repeating except for first cast in first set
			--Defile
			[365169] = {48, 35.9, 30.9, 43, 55, 31, 36.9, 62.1, 30.9, 37, 61.9, 31, 37},--36.9, 62.1, 30.9 repeating after first two sets (6 casts)
		},
	},
	["normal"] = {
		[1] = {
			--Torment (lasts entire fight)
			[365436] = {21.9, 51, 69},
			--Martyrdom
			[363893] = {39.9, 40, 40, 40},
			--Relentless Domination
			[362028] = {47.9, 60, 60},
			--Chains of Oppression
			[359809] = {89.9},
			--Rune of Damnation
			[360279] = {10.9, 19, 34, 32.9, 28, 25.9},
		},
		[2] = {
			--Torment (lasts entire fight)
			[365436] = {30, 49.9, 55, 45},
			--Decimator (lasts rest of fight)
			[360562] = {15.9, 57.5, 47.5, 42.9},
			--Unholy Attunement
			[360373] = {6.9, 45, 45, 45},
			--Shattering Blast
			[359856] = {22.5, 13.4, 30, 15, 30.9, 15.5, 28.4, 15.9},
			--Rune of Compulsion
			[366284] = {49.9, 60, 60},
		},
		[3] = {
			--Torment (lasts entire fight)
			[365436] = {27, 86.9},
			--Decimator (lasts rest of fight)
			[360562] = {35.9, 52, 41.9, 41.9},
			--Desolation
			[365033] = {42.9, 60, 60},
			--Rune of Domination
			[365147] = {64, 83.9},
			--Chains of Anguish
			[365212] = {52.9, 41.9, 41.9, 41.9},
			--Defile
			[365169] = {56, 40.9, 43, 42.9},
		},
	},
	["heroic"] = {
		[1] = {
			--Torment (lasts entire fight)
			[365436] = {11, 52, 45, 47},
			--Martyrdom
			[363893] = {31, 40, 52, 39},
			--Relentless Domination
			[362028] = {55, 56.9, 56},
			--Chains of Oppression
			[359809] = {40, 48, 49},
			--Rune of Damnation
			[360279] = {22, 25, 29, 21, 30.5, 19.5},
		},
		[2] = {
			--Torment (lasts entire fight)
			[365436] = {10, 16, 35.4, 61.5, 28.9, 30},
			--Decimator (lasts rest of fight)
			[360562] = {14, 41, 34.9, 44.9, 41},
			--Unholy Attunement
			[360373] = {6.9, 44.9, 44.9, 45, 42},
			--Shattering Blast
			[359856] = {20.9, 15.9, 30, 15, 29, 16.9, 28.9, 14},
			--Rune of Compulsion
			[366284] = {28.9, 46, 45, 46.9},
		},
		[3] = {
			--Torment (lasts entire fight)
			[365436] = {52, 74.9},
			--Decimator (lasts rest of fight)
			[360562] = {27, 37.9, 47, 32.9, 40},
			--Desolation
			[365033] = {43, 59.9, 64},
			--Rune of Domination
			[365147] = {72, 78.9},
			--Chains of Anguish
			[365212] = {38, 54.8, 43, 42.9},
			--Defile
			[365169] = {34, 44.9, 44.9, 52},
		},
	},
	["mythic"] = {--Confiremd different, so empty until data collected
		[1] = {
			--Torment (lasts entire fight)
			[365436] = {7.9, 42, 40, 31.9, 44},
			--Martyrdom
			[363893] = {29.9, 47, 30.9, 43},
			--Relentless Domination
			[362028] = {43.9, 54, 70},
			--Chains of Oppression
			[359809] = {15.9, 111},
			--Rune of Damnation
			[360279] = {34.9, 22.9, 25.9, 29, 26.9, 17.9},
		},
		[2] = {--Timers started at final relentless domination. about 13 seconds sooner than Encounter Event
			--World Cracker
			[366678] = {11, 45, 45},
			--Torment (lasts entire fight)
			[365436] = {21, 38, 34.9, 25},
			--Decimator (lasts rest of fight)
			[360562] = {45, 42.5, 42.5},
			--Unholy Attunement
			[360373] = {6.9, 44.9, 45, 46.4},
			--Shattering Blast
			[359856] = {23, 14, 30, 14.9, 26, 22},
			--Rune of Compulsion
			[366284] = {15, 50, 49.9},
		},
		[3] = {--Using Second Encounter Event cast (1 second sooner than unbreaking grasp)
			--Torment (lasts entire fight)
			[365436] = {59, 110},
			--Decimator (lasts rest of fight)
			[360562] = {29, 43.9, 39, 35.9},
			--Desolation
			[365033] = {40, 81.9},
			--Rune of Domination
			[365147] = {87, 56.9},
			--Chains of Anguish
			[365212] = {37, 46.9, 47.5, 40.4},--87.9 if he skips 3rd cast
			--Defile
			[365169] = {56, 24, 39, 40},
		},
		[4] = {
			--Torment (lasts entire fight)
			[365436] = {50, 24, 38},
			--Decimator (lasts rest of fight)
			[360562] = {25, 31, 48},
			--Rune of Damnation (P1 rune)
			[360279] = {14, 28, 43},
			--Meteor Cleave
			[360378] = {20, 60, 44},
		},
	},
}

--Echo strategy timers provided by Justwait
local mythicSpecialTimers = {
	-- pull/0:00 -> 0:25 -> 1:11 -> 1:43 -> 2:17
	[1] = {25.0, 46.0, 32.0, 34.0},
	-- stage2/2:47 -> 3:40.5 -> 4:22 -> 5:15 -> 5:49
	[2] = {36.5, 46.5, 53, 34},
	-- stage3/6:15 -> 7:00.5 -> 7:21 -> 7:54.5 (2x lines) -> 8:33
	[3] = {46.5, 20.5, 33.5, 38.5},
	-- Dispel Timers in last stage, from Heal Channel Start (_SUCCES)
	[4] = {40, 30, 29}
}

local function mythicTimerLoop(self)
	if not self.vb.phase then return end--This loop cannot cleanly recover on mid fight disconnect, prevent nil error
	self.vb.echoCount = self.vb.echoCount + 1
	local timer = mythicSpecialTimers[self.vb.phase][self.vb.echoCount]
	if timer then
		if self.vb.phase < 4 then
			warnHealAzeroth:Show(self.vb.echoCount-1)
			timerHealAzeroth:Start(timer, self.vb.echoCount)
		else
			warnDispel:Show(self.vb.echoCount-1)
			timerDispels:Start(timer, self.vb.echoCount)
		end
		self:Schedule(timer, mythicTimerLoop, self)
	end
end

local function chainsSkipCheck(self)
	self.vb.chainsCount = self.vb.chainsCount + 1
	timerChainsofAnguishCD:Start(35, self.vb.chainsCount+1)
end

function mod:OnCombatStart(delay)
	--General
	self.vb.worldCount = 0--Used in all 3 stages on mythic
	self.vb.tormentCount = 0--Used in all 3 stages
	self.vb.tankCount = 0--Martyrdom, Shattering Blast
	self.vb.runeCount = 0--Used in all 3 stages
	self.vb.runeIcon = 1--Used in all 3 rune types
	self.vb.echoCount = 0
	--1
	self.vb.relentingCount = 0
	self.vb.chainsCount = 0--Also reused in P3
	--2
	self.vb.unholyCount = 0
	self.vb.decimatorCount = 0
	--3
	self.vb.desolationCount = 0
	self.vb.defileCount = 0
	self.vb.willTotal = 0
	self.vb.chainsIcon = 8
	self:SetStage(1)
	timerPhaseCD:Start(179.9-delay)
	if self:IsMythic() then
		difficultyName = "mythic"
--		timerWorldCrusherCD:Start(1-delay)--Used on pull
		timerTormentCD:Start(7.9-delay, 1)
		timerChainsofOppressionCD:Start(15.9-delay, 1)
		timerMartyrdomCD:Start(29.9-delay, 1)
		timerRuneofDamnationCD:Start(34.9-delay, 1)
		timerRelentingDominationCD:Start(43.9-delay, 1)
		mythicTimerLoop(self)
	elseif self:IsHeroic() then
		difficultyName = "heroic"
		timerTormentCD:Start(11-delay, 1)
		timerRuneofDamnationCD:Start(21-delay, 1)
		timerMartyrdomCD:Start(31-delay, 1)
		timerChainsofOppressionCD:Start(40-delay, 1)
		timerRelentingDominationCD:Start(55-delay, 1)
	else
		if self:IsNormal() then
			difficultyName = "normal"
		else--LFR
			difficultyName = "lfr"
		end
		--LFR and Normal phase 1 timers the same
		timerRuneofDamnationCD:Start(10.9-delay, 1)
		timerTormentCD:Start(21.9-delay, 1)
		timerMartyrdomCD:Start(39.9-delay, 1)
		timerRelentingDominationCD:Start(47.9-delay, 1)
		timerChainsofOppressionCD:Start(89.9-delay, 1)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:OnTimerRecovery()
	if self:IsMythic() then
		difficultyName = "mythic"
	elseif self:IsHeroic() then
		difficultyName = "heroic"
	elseif self:IsNormal() then
		difficultyName = "normal"
	else
		difficultyName = "lfr"
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 362028 or spellId == 367851 then--First two, Final cast
		self.vb.relentingCount = self.vb.relentingCount + 1
		specWarnRelentingDomination:Show(DBM_COMMON_L.BREAK_LOS)
		specWarnRelentingDomination:Play("findshelter")
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, 362028, self.vb.relentingCount+1)
		if timer then
			timerRelentingDominationCD:Start(timer, self.vb.relentingCount+1)
		end
		if not self:IsEasy() then
			warnTyranny:Schedule(8)
			timerTyrany:Start(8)--hit is at 11, so we do hit minus 3 for the cast (which is hidden)
		end
		if spellId == 367851 and self:IsFated() then
			self:AffixEvent(0)--Stop Affix Bars
		end
	elseif spellId == 360373 then
		self.vb.unholyCount = self.vb.unholyCount + 1
		warnUnholyAttunement:Show(self.vb.unholyCount)
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.unholyCount+1)
		if timer then
			timerUnholyAttunementCD:Start(timer, self.vb.unholyCount+1)
		end
	elseif spellId == 359856 then
		self.vb.tankCount = self.vb.tankCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnShatteringBlast:Show(L.Pylon)
			specWarnShatteringBlast:Play("findshelter")--Kind of a crappy voice for it but don't have a valid one that sounds better
		end
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.tankCount+1)
		if timer then
			timerShatteringBlastCD:Start(timer, self.vb.tankCount+1)
		end
	elseif args:IsSpellID(364942, 360562, 364488) then--All deciminator casts with a cast time
		self.vb.decimatorCount = self.vb.decimatorCount + 1--This event may be before CLEU event so just make sure count updated before target scan
		specWarnDecimator:Show(self.vb.decimatorCount)
		specWarnDecimator:Play("specialsoon")
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, 360562, self.vb.decimatorCount+1)
		if timer then
			timerDecimatorCD:Start(timer, self.vb.decimatorCount+1)
		end
	elseif spellId == 365033 then
		self.vb.desolationCount = self.vb.desolationCount + 1
		specWarnDesolation:Show(self.vb.desolationCount)
		specWarnDesolation:Play("helpsoak")
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.desolationCount+1)
		if timer then
			timerDesolationCD:Start(timer, self.vb.desolationCount+1)
		end
	elseif spellId == 365212 then
		self.vb.chainsIcon = 8
		self.vb.chainsCount = self.vb.chainsCount + 1
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.chainsCount+1)
		if timer then
			timerChainsofAnguishCD:Start(timer, self.vb.chainsCount+1)
			if self:IsMythic() then
				--Boss sometimes skips 3rd cast, this corrects timer if that happens
				if self.vb.chainsCount == 2 then
					self:Schedule(53, chainsSkipCheck, self)
				elseif self.vb.chainsCount == 3 then
					self:Unschedule(chainsSkipCheck)
				end
			end
		end
	elseif spellId == 365169 then
		self.vb.defileCount = self.vb.defileCount + 1
		specWarnDefile:Show(self.vb.defileCount)
		specWarnDefile:Play("stilldanger")
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.defileCount+1)
		if timer then
			timerDefileCD:Start(timer, self.vb.defileCount+1)
		end
	elseif spellId == 366374 then
		self.vb.worldCount = self.vb.worldCount + 1
		specWarnWorldCrusher:Show(self.vb.worldCount)
		specWarnWorldCrusher:Play("specialsoon")
	elseif spellId == 366678 then
		self.vb.worldCount = self.vb.worldCount + 1
		specWarnWorldCracker:Show()--self.vb.worldCount
		specWarnWorldCracker:Play("specialsoon")
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.worldCount+1)
		if timer then
			timerWorldCrackerCD:Start(timer, self.vb.worldCount+1)
		end
	elseif spellId == 367290 then--Transitional/Final Unholy Attunement (possibly even earlier P3 trigger)
		self.vb.unholyCount = self.vb.unholyCount + 1
		warnUnholyAttunement:Show(self.vb.unholyCount)
		timerPits:Start(3.5)
		timerUnbreakableGraspCD:Start(10.5)
		if self:IsFated() then
			self:AffixEvent(0)--Stop Affix Bars
		end
	elseif spellId == 360378 then
		self.vb.tankCount = self.vb.tankCount + 1
		specWarnMeteorCleave:Show(self.vb.tankCount)
		specWarnMeteorCleave:Play("cleave")
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.tankCount+1)
		if timer then
			timerMeteorCleaveCD:Start(timer, self.vb.tankCount+1)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 363332 then--Unbreaking Grasp
		warnUnbreakableGrasp:Show()
	elseif spellId == 359809 then
		self.vb.chainsCount = self.vb.chainsCount + 1
		specWarnChainsofOppression:Show()
		specWarnChainsofOppression:Play("justrun")
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.chainsCount+1)
		if timer then
			timerChainsofOppressionCD:Start(timer, self.vb.chainsCount+1)
		end
	elseif spellId == 367051 then
		self.vb.worldCount = self.vb.worldCount + 1
		specWarnWorldShatterer:Show(self.vb.worldCount)
		specWarnWorldShatterer:Play("specialsoon")
	elseif spellId == 363893 then
		self.vb.tankCount = self.vb.tankCount + 1
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
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.tankCount+1)
		if timer then
			timerMartyrdomCD:Start(timer, self.vb.tankCount+1)
		end
		if self.Options.SetIconOnMartyrdom2 then
			self:SetIcon(args.destName, 7)
		end
	elseif spellId == 365436 or spellId == 370071 then
		self.vb.tormentCount = self.vb.tormentCount + 1
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, 365436, self.vb.tormentCount+1)
		if timer then
			timerTormentCD:Start(timer, self.vb.tormentCount+1)
		end
	elseif spellId == 360279 or spellId == 366284 or spellId == 365147 then--All rune spells
		if self:AntiSpam(5, 1) then--Success doesn't always fire first, so this check done in debuff and success handler
			self.vb.runeCount = self.vb.runeCount + 1
			self.vb.runeIcon = 1
		end
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.runeCount+1)
		if timer then
			if spellId == 360279 then
				timerRuneofDamnationCD:Start(timer, self.vb.runeCount+1)
			elseif spellId == 366284 then
				timerRuneofCompulsionCD:Start(timer, self.vb.runeCount+1)
			else--365147
				timerRuneofDominationCD:Start(timer, self.vb.runeCount+1)
			end
		end
	elseif spellId == 363772 then
		warnDeathSentence:Show(args.destName)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 362192 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) and not args:IsPlayer() and not DBM:UnitDebuff("player", spellId) then
			specWarnMisery:Show(args.destName)
			specWarnMisery:Play("tauntboss")
		end
	elseif spellId == 362401 then
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
		if self:AntiSpam(5, 1) then
			self.vb.runeCount = self.vb.runeCount + 1
			self.vb.runeIcon = 1
		end
		local icon = self.vb.runeIcon
		if self.Options.SetIconOnDamnation then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnRuneofDamnation:Show()--self:IconNumToTexture(icon)
			specWarnRuneofDamnation:Play("targetyou")--"mm"..icon
			specWarnRuneofDamnationPit:Schedule(5, DBM_COMMON_L.PIT)
			specWarnRuneofDamnationPit:ScheduleVoice(5, "jumpinpit")
			yellRuneofDamnation:Yell(icon, icon)
			yellRuneofDamnationFades:Countdown(spellId, nil, icon)
		end
		warnRuneofDamnation:CombinedShow(0.5, self.vb.runeCount, args.destName)
		self.vb.runeIcon = self.vb.runeIcon + 1
	elseif spellId == 366285 then
		if self:AntiSpam(5, 1) then
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
		if self:AntiSpam(5, 1) then
			self.vb.runeCount = self.vb.runeCount + 1
			self.vb.runeIcon = 1
		end
		local icon = self.vb.runeIcon
		if self.Options.SetIconOnDomination2 then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnRuneofDomination:Show(self:IconNumToTexture(icon))
			specWarnRuneofDomination:Play("mm"..icon)
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
			yellChainsofAnguishLink:Yell()--minus 3 so debuff count is still 1 2 and 3 when using icons 4 5 and 6
		end
		warnChainsofAnguishLink:CombinedShow(0.5, args.destName)
		self.vb.chainsIcon = self.vb.chainsIcon - 1
	elseif spellId == 365153 then--Imposing Will
		self.vb.willTotal = self.vb.willTotal + 1
		if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() then
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(20, "playerabsorb", spellId)
		end
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
	elseif spellId == 368383 then--Diverted Life Shield
		--Todo, maybe move this to cast success or start event if it's sooner
		self:SetStage(4)
		if self:IsFated() then
			self:AffixEvent(1, 4)
		end
		self.vb.tankCount = 0
		self.vb.runeCount = 0
		self.vb.decimatorCount = 0
		self.vb.echoCount = 0
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(4))
		warnPhase:Play("pfour")
		timerTormentCD:Stop()
		timerDecimatorCD:Stop()
		timerDesolationCD:Stop()
		timerChainsofAnguishCD:Stop()
		timerDefileCD:Stop()
		timerRuneofDominationCD:Stop()

		timerDeathSentenceCD:Start(12)--SUCCESS/APPLIED
		timerRuneofDamnationCD:Start(14, 1)
		timerMeteorCleaveCD:Start(20, 1)
		timerDecimatorCD:Start(25, 1)
		timerTormentCD:Start(50, 1)
		self:Unschedule(mythicTimerLoop)
		mythicTimerLoop(self)
	elseif spellId == 360378 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) and not args:IsPlayer() and not DBM:UnitDebuff("player", spellId) then
			specWarnMeteorCleaveTaunt:Show(args.destName)
			specWarnMeteorCleaveTaunt:Play("tauntboss")
		end
	elseif args:IsSpellID(363748, 368591) then--363748, 368591 (30 sec versions)
		if args:IsPlayer() then
			specWarnDeathSentence:Show()
			specWarnDeathSentence:Play("targetyou")
			yellDeathSentence:Yell()
		end
	elseif args:IsSpellID(360174, 368593) then--360174, 368593 (6 second versions)
		if args:IsPlayer() then
			yellDeathSentenceFades:Countdown(spellId, 5)
		end
	elseif spellId == 181089 then
		self:SetStage(0)--0 causes auto increment to happen in DBM-Core
		--General
		self.vb.worldCount = 0--Used in all 3 stages on mythic
		self.vb.tormentCount = 0--Used in all 3 stages
		self.vb.tankCount = 0--Martyrdom, Shattering Blast
		self.vb.runeCount = 0--Used in all 3 stages
		self.vb.echoCount = 0
		--2+
		self.vb.decimatorCount = 0--Used in P2 and P3
		--Technically no stops should be needed since timers are sequenced to not proceed past final casts
		--But in event boss can push early like 2 expansions from now :D
		timerRelentingDominationCD:Stop()
		timerChainsofOppressionCD:Stop()
		timerMartyrdomCD:Stop()
		timerTormentCD:Stop()
		timerRuneofDamnationCD:Stop()
		timerWorldCrackerCD:Stop()
		timerTormentCD:Stop()
		timerUnholyAttunementCD:Stop()
		timerShatteringBlastCD:Stop()
		timerRuneofCompulsionCD:Stop()
		timerDecimatorCD:Stop()
		if self.vb.phase == 2 then--First time it's cast
			warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2))
			warnPhase:Play("ptwo")
			--2
			self.vb.unholyCount = 0
			self.vb.runeCount = 0
			timerPits:Start(4)
			if self:IsMythic() then
				timerUnholyAttunementCD:Start(6.9, 1)--Same in all but LFR
				timerWorldCrackerCD:Start(11, 1)
				timerRuneofCompulsionCD:Start(15, 1)
				timerTormentCD:Start(21, 1)
				timerShatteringBlastCD:Start(23, 1)
				timerDecimatorCD:Start(45, 1)
				timerPhaseCD:Start(193.5)
				self:Unschedule(mythicTimerLoop)
				mythicTimerLoop(self)
			elseif self:IsHeroic() then
				timerUnholyAttunementCD:Start(6.9, 1)--Same in all but LFR
				timerTormentCD:Start(10, 1)
				timerDecimatorCD:Start(14, 1)
				timerShatteringBlastCD:Start(20.9, 1)
				timerRuneofCompulsionCD:Start(28, 1)
				timerPhaseCD:Start(193.5)
			elseif self:IsNormal() then
				timerUnholyAttunementCD:Start(6.9, 1)--Same in all but LFR
				timerDecimatorCD:Start(15.9, 1)
				timerShatteringBlastCD:Start(22.5, 1)
				timerTormentCD:Start(30, 1)
				timerRuneofCompulsionCD:Start(49.9, 1)
				timerPhaseCD:Start(152)--Only difficulty that stage 2 is shorter
			else--LFR
				timerDecimatorCD:Start(11, 1)
				timerShatteringBlastCD:Start(18, 1)
				timerTormentCD:Start(25, 1)
				timerRuneofCompulsionCD:Start(47, 1)
				timerUnholyAttunementCD:Start(184.6, 1)--Only used once, at end of Stage 2
				timerPhaseCD:Start(193.5)
			end
			if self:IsFated() then
				self:AffixEvent(1, 2)
			end
		else--Phase 3 (second time it's cast)
			warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(3))
			warnPhase:Play("pthree")
			--1
			self.vb.chainsCount = 0--Also reused in P3
			--3
			self.vb.desolationCount = 0
			self.vb.defileCount = 0
			if self:IsMythic() then
				timerWorldShattererCD:Start(22.8, 1)
				timerDecimatorCD:Start(29, 1)
				timerChainsofAnguishCD:Start(37, 1)
				timerDesolationCD:Start(40, 1)
				timerDefileCD:Start(56, 1)
				timerTormentCD:Start(59, 1)
				timerRuneofDominationCD:Start(87, 1)
				self:Unschedule(mythicTimerLoop)
				mythicTimerLoop(self)
			elseif self:IsHeroic() then
				timerDecimatorCD:Start(27, 1)
				timerDefileCD:Start(34, 1)
				timerChainsofAnguishCD:Start(38, 1)
				timerDesolationCD:Start(42.9, 1)
				timerTormentCD:Start(52, 1)
				timerRuneofDominationCD:Start(72, 1)
			elseif self:IsNormal() then
				timerTormentCD:Start(27, 1)
				timerDecimatorCD:Start(35.9, 1)
				timerDesolationCD:Start(42.9, 1)
				timerChainsofAnguishCD:Start(52.9, 1)
				timerDefileCD:Start(56, 1)
				timerRuneofDominationCD:Start(63.9, 1)
			else--LFR
				timerTormentCD:Start(27, 1)
				timerDecimatorCD:Start(35.9, 1)
				timerDefileCD:Start(48, 1)--Defile comes earlier in LFR
				timerChainsofAnguishCD:Start(52.9, 1)
				timerRuneofDominationCD:Start(63.9, 1)
			end
			if self:IsFated() then
				self:AffixEvent(1, 3)
			end
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 363886 then
--		if args:IsPlayer() then
--			yellMartyrdomFades:Cancel()--Don't cancel yet, freedom might dispel it, but misery is still coming?
--		end
		if self.Options.SetIconOnMartyrdom2 then
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
			specWarnRuneofDamnationPit:Cancel()
			specWarnRuneofDamnationPit:CancelVoice()
		end
	elseif spellId == 366285 then
		if self.Options.SetIconOnCopulsion then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellRuneofCompulsionFades:Cancel()
		end
	elseif spellId == 365150 then
		if self.Options.SetIconOnDomination2 then
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
	elseif spellId == 368383 then--Diverted Life Shield
		warnLifeShieldOver:Show()
	elseif args:IsSpellID(360174, 368593) then--360174, 368593 (6 second versions), 368592 16 second version, 363748, 368591 (30 sec versions)
		if args:IsPlayer() then
			yellDeathSentenceFades:Cancel()
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if (spellId == 360425 or spellId == 365174) and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--do
	--function mod:DefileTarget(targetname, uId)
	--	if not targetname then return end
	--	if self.Options.SetIconOnDecimator2 then
	--		self:SetIcon(targetname, 8, 3)--So icon clears 1 second after
	--	end
	--	if targetname == UnitName("player") then
	--		specWarnDefile:Show()
	--		specWarnDefile:Play("runout")
	--		yellDefile:Yell()
	--	elseif self:CheckNearby(10, targetname) then
	--		specWarnDefileNear:Show(targetname)
	--		specWarnDefileNear:Play("runaway")
	--	else
	--		warnDefile:Show(targetname)
	--	end
	--end

	--function mod:UNIT_SPELLCAST_START(uId, _, spellId)
	--	if spellId == 365169 then
	--	--	self:BossUnitTargetScanner(uId, "DefileTarget", 3)
	--	end
	--end
--end
