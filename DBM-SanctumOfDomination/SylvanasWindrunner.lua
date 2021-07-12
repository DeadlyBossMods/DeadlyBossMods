local mod	= DBM:NewMod(2441, "DBM-SanctumOfDomination", nil, 1193)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(175732)
mod:SetEncounterID(2435)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
mod:SetHotfixNoticeRev(20210711000000)--2021-07-11
mod:SetMinSyncRevision(20210711000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 349419 347726 347609 352663 353418 353417 348094 355540 352271 351075 351179 351353 356023 354011 353969 354068 353952 353935 354147 357102 358704 351589 351562 358181",
	"SPELL_CAST_SUCCESS 351178 358433",
	"SPELL_AURA_APPLIED 347504 347807 347670 349458 348064 347607 350857 348146 351109 351117 351451 353929 357886 357720 353935 348064 356986 358711 358705 351562 358433",
	"SPELL_AURA_APPLIED_DOSE 347807 347607 351672 353929",
	"SPELL_AURA_REMOVED 347504 347807 351109 358711 358705 351562 358433 348064 353929",
	"SPELL_AURA_REMOVED_DOSE 347807 353929",
	"CHAT_MSG_RAID_BOSS_EMOTE"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, do what with the combo of attacks of windrunner? IE https://ptr.wowhead.com/spell=347928/withering-fire
--TODO, infoframe on barbed stacks useful? add more stuff to it like banshees bane in phase 3 and adds/orbs monitors in phase 2?
--TODO, determine add warnings/timers for phase 2
--TODO, icons for crushing dread? Depends on number of debuffs and number of adds etc
--TODO, verify/improve orb auto marking on mythic
--TODO, do more with https://ptr.wowhead.com/spell=351939/curse-of-lethargy?
--TODO, chains cast timer for when they land?
--[[
(ability.id = 349419 or ability.id = 347609 or ability.id = 352663 or ability.id = 353418 or ability.id = 353417 or ability.id = 348094 or ability.id = 355540 or ability.id = 352271 or ability.id = 354011 or ability.id = 353969 or ability.id = 354068 or ability.id = 353952 or ability.id = 354147 or ability.id = 357102 or ability.id = 347726 or ability.id = 347741 or ability.id = 354142 or ability.id = 353935 or ability.id = 358704 or ability.id = 358181) and type = "begincast"
 or ability.id = 358433 and type = "cast"
 or (ability.id = 356986 or ability.id = 347504 or ability.id = 350857 or ability.id = 348146) and (type = "begincast" or type = "applydebuff" or type = "applybuff" or type = "removebuff" or type = "removedebuff")
 or (ability.id = 351075 or ability.id = 351117 or ability.id = 351353 or ability.id = 356023 or ability.id = 351589 or ability.id = 351562) and type = "begincast"
--]]

--General
local warnPhase										= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)
--Stage One: A Cycle of Hatred
local warnWindrunnerOver							= mod:NewEndAnnounce(347504, 2)
local warnShadowDagger								= mod:NewTargetNoFilterAnnounce(347670, 2, nil, "Healer")
local warnDominationChains							= mod:NewTargetAnnounce(349458, 2, nil, nil, 298213)--Could be spammy, unknown behavior
--local warnVeilofDarkness							= mod:NewTargetNoFilterAnnounce(347704, 2, nil, nil, 209426)
local warnWailingArrow								= mod:NewTargetNoFilterAnnounce(348064, 4)
local warnRangersHeartseeker						= mod:NewSpellAnnounce(352663, 2, nil, "Tank")
local warnBansheesMark								= mod:NewStackAnnounce(347607, 2, nil, "Tank|Healer")
local warnBlackArrow								= mod:NewTargetNoFilterAnnounce(358705, 4)
--Intermission: A Monument to our Suffering
local warnRive										= mod:NewCountAnnounce(353418, 4)--May default off by default depending on feedback
--Stage Two: The Banshee Queen
local warnWindsofIcecrown							= mod:NewTargetCountAnnounce(356986, 1, nil, nil, nil, nil, nil, nil, true)
----Forces of the Maw
local warnUnstoppableForce							= mod:NewCountAnnounce(351075, 2)--Mawsworn Vanguard
local warnLashingStrike								= mod:NewTargetNoFilterAnnounce(351179, 3)--Mawforged Souljudge
local warnCrushingDread								= mod:NewTargetAnnounce(351117, 2)--Mawforged Souljudge
local warnSummonDecrepitOrbs						= mod:NewCountAnnounce(351353, 2)--Mawforged Summoner
local warnCurseofLthargy							= mod:NewTargetAnnounce(351451, 2)--Mawforged Summoner
local warnExpulsion									= mod:NewTargetNoFilterAnnounce(327796, 4)
--Stage Three: The Freedom of Choice
local warnBansheesHeartseeker						= mod:NewSpellAnnounce(353969, 2, nil, "Tank")
local warnBansheesBane								= mod:NewTargetNoFilterAnnounce(353929, 4)
local warnBansheesScream							= mod:NewTargetNoFilterAnnounce(357720, 3)
local warnBansheesBlades							= mod:NewSpellAnnounce(358181, 4, nil, "Tank")
local warnDeathKnives								= mod:NewTargetNoFilterAnnounce(358433, 3)

--local specWarnGTFO								= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)
--Stage One: A Cycle of Hatred
local specWarnWindrunner							= mod:NewSpecialWarningCount(347504, nil, nil, nil, 2, 2)
local specWarnDominationChains						= mod:NewSpecialWarningCount(349419, nil, 298213, nil, 2, 2)
local specWarnVeilofDarkness						= mod:NewSpecialWarningDodgeCount(347704, nil, 209426, nil, 2, 2)
local specWarnWailingArrow							= mod:NewSpecialWarningRun(348064, nil, nil, nil, 4, 2)
local yellWailingArrow								= mod:NewYell(348064)
local yellWailingArrowFades							= mod:NewShortFadesYell(348064)
local specWarnWailingArrowTaunt						= mod:NewSpecialWarningTaunt(348064, nil, nil, nil, 1, 2)
--local specWarnBansheesMark						= mod:NewSpecialWarningStack(347607, nil, 3, nil, nil, 1, 2)
--local specWarnBansheesMarkTaunt					= mod:NewSpecialWarningTaunt(347607, nil, nil, nil, 1, 2)
local specWarnBlackArrow							= mod:NewSpecialWarningYou(358705, nil, nil, nil, 1, 2, 4)--Is this also on tanks? it doesn't have tank icon
local yellBlackArrow								= mod:NewYell(358705)
local yellBlackArrowFades							= mod:NewShortFadesYell(358705)
local specWarnBlackArrowTaunt						= mod:NewSpecialWarningTaunt(358705, nil, nil, nil, 1, 2)
local specWarnRage									= mod:NewSpecialWarningRun(358711, nil, nil, nil, 4, 2)
--Intermission: A Monument to our Suffering
local specWarnBansheeWail							= mod:NewSpecialWarningMoveAway(348094, nil, nil, nil, 2, 2)
--Stage Two: The Banshee Queen
local specWarnHauntingWave							= mod:NewSpecialWarningDodgeCount(352271, nil, nil, nil, 2, 2)
local specWarnRuin									= mod:NewSpecialWarningInterrupt(355540, nil, nil, nil, 3, 2)
----Forces of the Maw
local specWarnLashingStrike							= mod:NewSpecialWarningYou(351179, nil, nil, nil, 1, 2)--Mawforged Souljudge
local yellLashingStrike								= mod:NewYell(351179)--Mawforged Souljudge
local specWarnCrushingDread							= mod:NewSpecialWarningMoveAway(351117, nil, nil, nil, 1, 2)--Mawforged Souljudge
local yellCrushingDread								= mod:NewYell(351117)--Mawforged Souljudge
local specWarnTerrorOrb								= mod:NewSpecialWarningInterruptCount(356023, nil, nil, nil, 1, 2, 4)--Mawforged Summoner
local specWarnCurseofLethargy						= mod:NewSpecialWarningYou(351451, nil, nil, nil, 1, 2)--Mawforged Summoner
local specWarnFury									= mod:NewSpecialWarningCount(351672, nil, DBM_CORE_L.AUTO_SPEC_WARN_OPTIONS.stack:format(12, 351672), nil, 1, 2)--Mawforged Goliath
local specWarnFuryOther								= mod:NewSpecialWarningTaunt(351672, nil, nil, nil, 1, 2)--Mawforged Goliath
local specWarnFilthDefensive						= mod:NewSpecialWarningDefensive(351589, nil, nil, nil, 1, 2, 4)--Mythic
local specWarnFilth									= mod:NewSpecialWarningYou(351589, nil, nil, nil, 1, 2, 4)--Mythic
local specWarnFilthTaunt							= mod:NewSpecialWarningTaunt(351589, nil, nil, nil, 1, 2, 4)--Mythic
local specWarnExpulsion								= mod:NewSpecialWarningYouPos(351562, nil, nil, nil, 1, 2, 4)--Mythic
local yellExpulsion									= mod:NewShortPosYell(351562)
local yellExpulsionFades							= mod:NewIconFadesYell(351562)
local specWarnExpulsionTarget						= mod:NewSpecialWarningTarget(351562, false, nil, nil, 1, 2, 4)
--Stage Three: The Freedom of Choice
local specWarnBansheesBane							= mod:NewSpecialWarningStack(353929, nil, 1, nil, nil, 1, 6)
local specWarnBansheesBaneTaunt						= mod:NewSpecialWarningTaunt(353929, nil, nil, nil, 1, 2)--Let the tank drop bane out by swapping for it
local specWarnBansheesBaneDispel					= mod:NewSpecialWarningDispel(353929, "RemoveMagic", nil, nil, 3, 2)--Dispel alert during Fury
local specWarnBansheeScream							= mod:NewSpecialWarningYou(357720, nil, 31295, nil, 1, 2)
local yellBansheeScream								= mod:NewYell(357720, 31295)
local specWarnRaze									= mod:NewSpecialWarningRun(354147, nil, nil, nil, 4, 2)
local specWarnDeathKnives							= mod:NewSpecialWarningMoveAway(358433, nil, nil, nil, 1, 2, 4)--Mythic
local yellDeathKnives								= mod:NewShortPosYell(358433)--REVIEW
local yellDeathKnivesFades							= mod:NewIconFadesYell(358433)--REVIEW

--General
--local berserkTimer								= mod:NewBerserkTimer(600)
--Stage One: A Cycle of Hatred
--mod:AddTimerLine(BOSS)
local timerWindrunnerCD								= mod:NewCDCountTimer(50.3, 347504, nil, nil, nil, 6, nil, nil, nil, 1, 3)
local timerDominationChainsCD						= mod:NewCDCountTimer(50.7, 349419, 298213, nil, nil, 3)--Shortname Chains
local timerVeilofDarknessCD							= mod:NewCDCountTimer(48.8, 347726, 209426, nil, nil, 3)--Shortname Darkness
local timerWailingArrowCD							= mod:NewCDCountTimer(33.9, 347609, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerRangersHeartseekerCD						= mod:NewCDCountTimer(33.9, 352663, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerBlackArrowCD								= mod:NewAITimer(33.9, 358704, nil, nil, nil, 3, nil, DBM_CORE_L.MYTHIC_ICON)
--Intermission: A Monument to our Suffering
local timerRiveCD									= mod:NewCDCountTimer(48.8, 353418, nil, nil, nil, 3)
local timerNextPhase								= mod:NewPhaseTimer(16.5, 348094, nil, nil, nil, 6)
--Stage Two: The Banshee Queen
--local timerRuinCD									= mod:NewAITimer(23, 355540, nil, nil, nil, 2)--Add Interrupt icon if it's actually interruptable
--local timerHauntingWaveCD							= mod:NewAITimer(23, 352271, nil, nil, nil, 2)
local timerWindsofIcecrown							= mod:NewBuffActiveTimer(35, 356986, nil, nil, nil, 5, nil, DBM_CORE_L.DAMAGE_ICON)
--Unstoppable Force ~9sec cd
----Forces of the Maw
--local timerFilthCD								= mod:NewAITimer(33.9, 351589, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.MYTHIC_ICON..DBM_CORE_L.TANK_ICON)
--local timerExpulsionCD							= mod:NewAITimer(48.8, 351562, nil, nil, nil, 3, nil, DBM_CORE_L.MYTHIC_ICON)

--Stage Three: The Freedom of Choice
local timerBansheesHeartseekerCD					= mod:NewCDCountTimer(33.9, 353969, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerShadowDaggerCD							= mod:NewCDCountTimer(23, 353935, nil, nil, nil, 3)--Only used in phase 3, in phase 1 it's tied to windrunner
local timerBaneArrowsCD								= mod:NewCDCountTimer(23, 354011, nil, nil, nil, 3)
local timerBansheesFuryCD							= mod:NewCDCountTimer(23, 354068, nil, nil, nil, 2)--Short name NOT used since "Fury" also exists on fight
local timerBansheesScreamCD							= mod:NewCDCountTimer(23, 353952, 31295, nil, nil, 3)
local timerRazeCD									= mod:NewCDCountTimer(23, 354147, nil, nil, nil, 3, nil, DBM_CORE_L.DEADLY_ICON)
local timerDeathKnivesCD							= mod:NewAITimer(33.9, 358433, nil, nil, nil, 3, nil, DBM_CORE_L.MYTHIC_ICON)

--mod:AddRangeFrameOption("8")
mod:AddInfoFrameOption(347807, true)
--Stage 1
mod:AddSetIconOption("SetIconOnWailingArrow", 347609, true, false, {1, 2, 3})--Applies to both reg and mythic version
mod:AddSetIconOption("SetIconOnTerrorOrb", 356023, true, true, {4, 5, 6, 7, 8})--Didn't see any on heroic
--Stage 2
mod:AddSetIconOption("SetIconOnExpulsion", 351562, true, true, {1, 2, 3})
--Stage 3
mod:AddSetIconOption("SetIconOnDeathKnives2", 358433, false, false, {1, 2, 3})--Conflicts with arrow, which will be more logical choice. might delete this
--Stage 1
mod:AddNamePlateOption("NPAuraOnRage", 358711)--Dark Sentinel
--Stage 2
mod:AddNamePlateOption("NPAuraOnEnflame", 351109)--Mawsworn Hopebreaker

--P1+ variable
mod.vb.arrowIcon = 1
mod.vb.windrunnerCount = 0
mod.vb.dominationChainsCount = 0
mod.vb.veilofDarknessCount = 0
mod.vb.wailingArrowCount = 0
mod.vb.heartseekerCount = 0
--Intermission (P1.5) variables
mod.vb.windrunnerActive = 0
mod.vb.riveCount = 0
--P2+ variables
mod.vb.addIcon = 8
mod.vb.debuffIcon = 1
mod.vb.icecrownCast = 0
mod.vb.hauntingWavecount = 0
--P3+ variables
mod.vb.baneArrowCount = 0
mod.vb.shadowDaggerCount = 0
mod.vb.bansheeScreamCount = 0
mod.vb.bansheesFuryCount = 0
mod.vb.razeCount = 0
mod.vb.knivesCount = 0
local debuffStacks = {}
local castsPerGUID = {}
local difficultyName = "None"
local allTimers = {
	["lfr"] = {
		[1] = {
			--Windrunner
			[347504] = {},
			--Ranger's Heartseeker
			[352663] = {},
			--Domination Chains
			[349419] = {},
			--Wailing Arrow
			[347609] = {},
			--Veil of Darkness
			[347726] = {},
		},
--		[1.5] = {

--		},
--		[2] = {

--		},
		[3] = {
			--Bane Arrows
			[354011] = {},
			--Banshee's Heartseeker
			[353969] = {},
			--Shadow Dagger
			[353935] = {},
			--Banshee Scream
			[353952] = {},
			--Wailing Arrow
			[347609] = {},
			--Veil of Darkness
			[347726] = {},
			--Raze
			[354147] = {},
		},
	},
	["normal"] = {
		[1] = {
			--Windrunner
			[347504] = {7.8, 55.5, 55.9, 55.4},
			--Ranger's Heartseeker
			[352663] = {22.5, 20.5, 33.3, 16, 19.2, 22.8, 19.8},
			--Domination Chains
			[349419] = {25.6, 58.3, 57.4},
			--Wailing Arrow
			[347609] = {37.6, 41.8, 35.3, 35.1},
			--Veil of Darkness
			[347726] = {52.4, 53.3, 54.8},
		},
--		[1.5] = {

--		},
--		[2] = {

--		},
		[3] = {
			--Bane Arrows
			[354011] = {45.4, 80.4, 76.2, 79.3, 78.6},--Pre July 9th hotfixes
--			[354011] = {45.4, 91.6, 66.3, 98.9, 63.8},--Post July 9th hotfixes
			--Banshee's Heartseeker
			[353969] = {59.5, 19, 45.3, 4.5, 30.1, 15.3, 23.5, 32.7, 15.3, 38.5, 9.7, 27.3, 30.1, 14.8, 34.4, 12.6},--Pre July 9th hotfixes
--			[353969] = {59.5, 18.3, 69.1, 57.6, 46.1, 3, 58.3, 8},--Post July 9th hotfixes
			--Shadow Dagger
			[353935] = {62.5, 80, 83.6, 76.9, 87.6},--Pre July 9th hotfixes
--			[353935] = {62.5, 80.8, 98.9, 61.4},--Post July 9th hotfixes
			--Banshee Scream
			[353952] = {111.3, 52.1, 55.7, 55.7, 58.2, 59.8},--Pre July 9th hotfixes
--			[353952] = {127.4, 49.9, 57.5, 59.8, 55.2},--Post July 9th hotfixes
			--Wailing Arrow
			[347609] = {91.7, 3, 3, 51.8, 3, 3, 51.6, 3, 3, 52.6, 3, 3, 52.2, 3, 3, 53.3, 3},--Pre July 9th hotfixes
--			[347609] = {91.7, 3, 3, 51.8, 3, 3, 51.6, 3, 3, 115.6, 3, 3},--Post July 9th hotfixes
			--Veil of Darkness
			[347726] = {56.5, 64.3, 68.6, 46.5, 62.7, 57.5, 61.9},--Pre July 9th hotfixes
--			[347726] = {56.5, 83.9, 56.9, 50.5, 61.3, 62.2},--Post July 9th hotfixes
			--Raze
			[354147] = {100.8, 76.1, 78.2, 85.4},--Pre July 9th hotfixes
--			[354147] = {118.8, 66, 72.3, 100.4},--Post July 9th hotfixes
		},
	},
	["heroic"] = {
		[1] = {
			--Windrunner
			[347504] = {7.2, 51.3, 48.8, 48.1, 52.7},
			--Ranger's Heartseeker
			[352663] = {20.1, 19.1, 17.1, 29.9, 4.8, 32.2, 16.1, 12, 25.7, 20.6, 4.7},
			--Domination Chains
			[349419] = {23.2, 53.4, 49.6, 53.9},
			--Wailing Arrow
			[347609] = {34.9, 38, 30.5, 31.7, 37.7, 31.7},
			--Veil of Darkness
			[347726] = {47.9, 49.4, 48.3, 46.3},
		},
--		[1.5] = {

--		},
--		[2] = {

--		},
		[3] = {
			--Bane Arrows
			[354011] = {43.6, 76.8, 73.2, 76.1, 74.5},--Pre July 9th hotfixes
--			[354011] = {43.6, 87.5, 97.4, 66.9, 58.2},--Post July 9th hotfixes
			--Banshee's Heartseeker
			[353969] = {50.1, 21.1, 50, 3, 16.4, 21.4, 31.9, 12, 14, 18.3, 31.6, 23.5, 10.2},--Pre July 9th hotfixes
--			[353969] = {50.1, 20.8},--Post July 9th hotfixes
			--Shadow Dagger
			[353935] = {59.7, 78.1, 79.9, 73.5},--Pre July 9th hotfixes
--			[353935] = {59.7, 84.4, 93.9, 60.4},--Post July 9th hotfixes
			--Banshee Scream
			[353952] = {107.9, 47.4, 54.5, 52, 54.9},--Pre July 9th hotfixes
--			[353952] = {124, 50.7, 55.8, 57.9, 48.6},--Post July 9th hotfixes
			--Wailing Arrow
			[347609] = {88.3, 3, 3, 49.8, 3, 3, 47.7, 3, 3, 49, 3, 3, 51.8, 3},--Pre July 9th hotfixes
--			[347609] = {88.3, 3, 3, 53.3, 3, 3, 48.3, 3, 3, 54.4, 3},--Post July 9th hotfixes
			--Veil of Darkness
			[347726] = {55.8, 61.6, 50.4, 58, 61.9},--Pre July 9th hotfixes
--			[347726] = {55.8},--Post July 9th hotfixes
			--Banshees Fury (Heroic+)
			[354068] = {31.1, 49.4, 49.6, 52.6, 47.4, 47.8, 58},--Pre July 9th hotfixes
--			[354068] = {31.1, 49.4, 55.7, 57.7, 57.7, 48.8, 59.2, 55.7},--Post July 9th hotfixes
			--Raze
			[354147] = {97.3, 73.6, 71.3, 82},--Pre July 9th hotfixes
--			[354147] = {115.4, 66.8, 68.6, 93.8},--Post July 9th hotfixes
		},
	},
	["mythic"] = {
		[1] = {
			--Windrunner
			[347504] = {},
			--Ranger's Heartseeker
			[352663] = {},
			--Domination Chains
			[349419] = {},
			--Black Arrow (Replaces Wailing Arrow)
			[358704] = {},
			--Veil of Darkness
			[347726] = {},
		},
--		[1.5] = {

--		},
--		[2] = {

--		},
		[3] = {
			--Bane Arrows
			[354011] = {},
			--Banshee's Heartseeker
			[353969] = {},
			--Shadow Dagger
			[353935] = {},
			--Banshee Scream
			[353952] = {},
			--Wailing Arrow
			[347609] = {},
			--Veil of Darkness
			[347726] = {},
			--Banshees Fury (Heroic/Mythic)
			[354068] = {},
			--Raze
			[354147] = {},
			--Death Knives (Mythic Only)
			[358433] = {},
		},
	},
}

--TODO, more than windrunner can delay this
local function intermissionStart(self, adjust)
	timerDominationChainsCD:Start(4-adjust, 1)--Practically right away
	timerRiveCD:Start(13.2-adjust)--Init timer only, for when the spam begins
	timerNextPhase:Start(55.6-adjust)
end

function mod:OnCombatStart(delay)
	table.wipe(debuffStacks)
	table.wipe(castsPerGUID)
	self:SetStage(1)
	self.vb.arrowIcon = 1
	self.vb.windrunnerCount = 0
	self.vb.dominationChainsCount = 0
	self.vb.veilofDarknessCount = 0
	self.vb.wailingArrowCount = 0
	self.vb.heartseekerCount = 0
	self.vb.addIcon = 8
	self.vb.windrunnerActive = 0
	if self:IsMythic() then
		difficultyName = "mythic"
		timerBlackArrowCD:Start(1-delay)
--		timerWindrunnerCD:Start(7.2-delay, 1)
--		timerRangersHeartseekerCD:Start(22.5, 1)
--		timerDominationChainsCD:Start(25.6-delay, 1)
--		timerVeilofDarknessCD:Start(52.4-delay, 1)--Probably shorter to emote
	elseif self:IsHeroic() then
		difficultyName = "heroic"
		timerWindrunnerCD:Start(7.2-delay, 1)
		timerRangersHeartseekerCD:Start(20.2, 1)
		timerDominationChainsCD:Start(23.2-delay, 1)
		timerWailingArrowCD:Start(34.9-delay, 1)
		timerVeilofDarknessCD:Start(47.9-delay, 1)--Probably shorter to emote
	elseif self:IsNormal() then
		difficultyName = "normal"
		timerWindrunnerCD:Start(8.4-delay, 1)
		timerRangersHeartseekerCD:Start(22.5, 1)
		timerDominationChainsCD:Start(25.6-delay, 1)
		timerWailingArrowCD:Start(37.6-delay, 1)
		timerVeilofDarknessCD:Start(52.4-delay, 1)--Probably shorter to emote
	else
		difficultyName = "lfr"
--		timerWindrunnerCD:Start(8.4-delay, 1)
--		timerRangersHeartseekerCD:Start(22.5, 1)
--		timerDominationChainsCD:Start(25.6-delay, 1)
--		timerWailingArrowCD:Start(37.6-delay, 1)
--		timerVeilofDarknessCD:Start(52.4-delay, 1)--Probably shorter to emote
	end
--	berserkTimer:Start(-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(347807))
		DBM.InfoFrame:Show(10, "table", debuffStacks, 1)
	end
	if self.Options.NPAuraOnEnflame or self.Options.NPAuraOnRage then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.NPAuraOnEnflame or self.Options.NPAuraOnRage then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
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
	if spellId == 349419 then
		self.vb.dominationChainsCount = self.vb.dominationChainsCount + 1
		specWarnDominationChains:Show(self.vb.dominationChainsCount)
		specWarnDominationChains:Play("watchstep")
		local timer = allTimers[difficultyName][self.vb.phase][spellId][self.vb.dominationChainsCount+1]
		if timer then
			timerDominationChainsCD:Start(timer, self.vb.dominationChainsCount+1)
		end
--	elseif spellId == 347726 or spellId == 347741 or spellId == 354142 then
--		self.vb.veilofDarknessCount = self.vb.veilofDarknessCount + 1
--		timerVeilofDarknessCD:Start()
	elseif spellId == 347609 then
		self.vb.arrowIcon = 1
		self.vb.wailingArrowCount = self.vb.wailingArrowCount + 1
		local timer = allTimers[difficultyName][self.vb.phase][spellId][self.vb.wailingArrowCount+1]
		if timer then
			timerWailingArrowCD:Start(timer, self.vb.wailingArrowCount+1)
		end
	elseif spellId == 358704 then
		self.vb.arrowIcon = 1
		self.vb.wailingArrowCount = self.vb.wailingArrowCount + 1--Replaces this arrow in stage 1, so might as well use same variable
		timerBlackArrowCD:Start()--Temp, just to utilize AI timer
--		local timer = allTimers[difficultyName][self.vb.phase][spellId][self.vb.wailingArrowCount+1]
--		if timer then
--			timerBlackArrowCD:Start(timer, self.vb.wailingArrowCount+1)
--		end
	elseif spellId == 352663 then
		self.vb.heartseekerCount = self.vb.heartseekerCount + 1
		warnRangersHeartseeker:Show()
		local timer = allTimers[difficultyName][self.vb.phase][spellId][self.vb.heartseekerCount+1]
		if timer then
			timerRangersHeartseekerCD:Start(timer, self.vb.heartseekerCount+1)
		end
	elseif (spellId == 353418 or spellId == 353417) then--Rive
		self.vb.riveCount = self.vb.riveCount + 1
		warnRive:Show(self.vb.riveCount)
	elseif spellId == 348094 then
		specWarnBansheeWail:Show()
		specWarnBansheeWail:Play("scatter")
	elseif spellId == 355540 then
		specWarnRuin:Show(args.sourceName)
		specWarnRuin:Play("kickcast")
--		timerRuinCD:Start()
	elseif spellId == 352271 then
		self.vb.hauntingWavecount = self.vb.hauntingWavecount + 1
		specWarnHauntingWave:Show(self.vb.hauntingWavecount)
		specWarnHauntingWave:Play("watchwave")
--		timerHauntingWaveCD:Start()
	elseif spellId == 351075 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		if self:AntiSpam(3, 1) then--If multiple cast it at same time
			warnUnstoppableForce:Show(castsPerGUID[args.sourceGUID])
		end
--	elseif spellId == 351179 then
--		timerAbsorbingChargeCD:Start(18.3, args.sourceGUID)

	elseif spellId == 351353 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		warnSummonDecrepitOrbs:Show(castsPerGUID[args.sourceGUID])
	elseif spellId == 356023 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
			if self.vb.addIcon < 4 then--Only use up to 5 icons
				self.vb.addIcon = 8
			end
			if self.Options.SetIconOnTerrorOrb then
				self:ScanForMobs(args.sourceGUID, 2, self.vb.addIcon, 1, 0.2, 12, "SetIconOnTerrorOrb")
			end
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then
			specWarnTerrorOrb:Show(args.sourceName, count)
			if count == 1 then
				specWarnTerrorOrb:Play("kick1r")
			elseif count == 2 then
				specWarnTerrorOrb:Play("kick2r")
			elseif count == 3 then
				specWarnTerrorOrb:Play("kick3r")
			elseif count == 4 then
				specWarnTerrorOrb:Play("kick4r")
			elseif count == 5 then
				specWarnTerrorOrb:Play("kick5r")
			else
				specWarnTerrorOrb:Play("kickcast")
			end
		end
	elseif spellId == 354011 then
		self.vb.baneArrowCount = self.vb.baneArrowCount + 1
		local timer = allTimers[difficultyName][self.vb.phase][spellId][self.vb.baneArrowCount+1]
		if timer then
			timerBaneArrowsCD:Start(timer, self.vb.baneArrowCount+1)
		end
	elseif spellId == 353969 then
		self.vb.heartseekerCount = self.vb.heartseekerCount + 1
		warnBansheesHeartseeker:Show()
		local timer = allTimers[difficultyName][self.vb.phase][spellId][self.vb.heartseekerCount+1]
		if timer then
			timerBansheesHeartseekerCD:Start(timer, self.vb.heartseekerCount+1)
		end
	elseif spellId == 354068 then
		self.vb.bansheesFuryCount = self.vb.bansheesFuryCount + 1
		local timer = allTimers[difficultyName][self.vb.phase][spellId][self.vb.bansheesFuryCount+1]
		if timer then
			timerBansheesFuryCD:Start(timer, self.vb.bansheesFuryCount+1)
		end
		for uId in DBM:GetGroupMembers() do
			if DBM:UnitDebuff(uId, 353929) then
				local name = DBM:GetUnitFullName(uId)
				if self.Options.SpecWarn353929dispel then
					specWarnBansheesBaneDispel:CombinedShow(0.3, name)
					specWarnBansheesBaneDispel:ScheduleVoice(0.3, "helpdispel")
				else
					warnBansheesBane:CombinedShow(0.3, name)
				end
			end
		end
	elseif spellId == 353952 then
		self.vb.bansheeScreamCount = self.vb.bansheeScreamCount + 1
		local timer = allTimers[difficultyName][self.vb.phase][spellId][self.vb.bansheeScreamCount+1]
		if timer then
			timerBansheesScreamCD:Start(timer, self.vb.bansheeScreamCount+1)
		end
	elseif spellId == 353935 then
		if self.vb.phase == 3 then
			self.vb.shadowDaggerCount = self.vb.shadowDaggerCount + 1
			local timer = allTimers[difficultyName][self.vb.phase][spellId][self.vb.shadowDaggerCount+1]
			if timer then
				timerShadowDaggerCD:Start(timer, self.vb.shadowDaggerCount+1)
			end
		end
	elseif spellId == 354147 then
		self.vb.razeCount = self.vb.razeCount + 1
		specWarnRaze:Show(self.vb.razeCount)
		specWarnRaze:Play("justrun")
		local timer = allTimers[difficultyName][self.vb.phase][spellId][self.vb.razeCount+1]
		if timer then
			timerRazeCD:Start(timer, self.vb.razeCount+1)
		end
	elseif spellId == 357102 then--Raid Portal: Oribos
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(3))
		warnPhase:Play("pthree")
		self:SetStage(3)
		table.wipe(debuffStacks)
		self.vb.baneArrowCount = 0
		self.vb.shadowDaggerCount = 0
		self.vb.bansheeScreamCount = 0
		self.vb.bansheesFuryCount = 0
		self.vb.veilofDarknessCount = 0--Used only once per platform but might as well count it
		self.vb.wailingArrowCount = 0
		self.vb.razeCount = 0
		self.vb.heartseekerCount = 0
		self.vb.knivesCount = 0
--		timerRuinCD:Stop()
--		timerHauntingWaveCD:Stop()
--		timerVeilofDarknessCD:Stop()
		if self:IsMythic() then
--			timerBansheesFuryCD:Start(31.9, 1)--Heroic+
--			timerBaneArrowsCD:Start(43.6, 1)
--			timerBansheesHeartseekerCD:Start(50.8, 1)
--			timerVeilofDarknessCD:Start(55.9, 1)
--			timerShadowDaggerCD:Start(59.7, 1)
--			timerWailingArrowCD:Start(88.3, 1)
--			timerRazeCD:Start(97.3, 1)
--			timerBansheesScreamCD:Start(107.9, 1)
			timerDeathKnivesCD:Start(3)--Mythic Only
		elseif self:IsHeroic() then
			timerBansheesFuryCD:Start(31.9, 1)--Heroic+
			timerBaneArrowsCD:Start(43.6, 1)
			timerBansheesHeartseekerCD:Start(50.1, 1)--Flipped on heroic
			timerVeilofDarknessCD:Start(55.8, 1)--Flipped on heroic
			timerShadowDaggerCD:Start(59.7, 1)
			timerWailingArrowCD:Start(88.3, 1)
			timerRazeCD:Start(115.4, 1)
			timerBansheesScreamCD:Start(124, 1)
		else--Normal, LFR assumed
			timerBaneArrowsCD:Start(46.5, 1)
			timerVeilofDarknessCD:Start(56.5, 1)
			timerBansheesHeartseekerCD:Start(59.5, 1)
			timerShadowDaggerCD:Start(62.5, 1)
			timerWailingArrowCD:Start(91.7, 1)
			timerRazeCD:Start(100.8, 1)
			timerBansheesScreamCD:Start(111.3, 1)
		end
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(353929))
			DBM.InfoFrame:Show(10, "table", debuffStacks, 1)
		end
	elseif spellId == 351589 then
		if self:IsTanking("player", nil, nil, nil, args.sourceGUID) then
			specWarnFilthDefensive:Show()
			specWarnFilthDefensive:Play("defensive")
		end
		--timerFilthCD:Start(12, args.sourceGUID)
	elseif spellId == 351562 then
		self.vb.debuffIcon = 1
		--timerExpulsionCD:Start(12, args.sourceGUID)
	elseif spellId == 358181 then
		warnBansheesBlades:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 351178 then
		if args:IsPlayer() then
			specWarnLashingStrike:Show()
			specWarnLashingStrike:Play("targetyou")
			yellLashingStrike:Yell()
		else
			warnLashingStrike:Show(args.destName)
		end
	elseif spellId == 358433 then
		self.vb.debuffIcon = 1
		self.vb.knivesCount = self.vb.knivesCount + 1
		timerDeathKnivesCD:Start()
--		local timer = allTimers[difficultyName][self.vb.phase][spellId][self.vb.knivesCount+1]
--		if timer then
--			timerDeathKnivesCD:Start(timer, self.vb.knivesCount+1)
--		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 347504 then
		self.vb.windrunnerActive = 1
		self.vb.windrunnerCount = self.vb.windrunnerCount + 1
		specWarnWindrunner:Show(self.vb.windrunnerCount)
		specWarnWindrunner:Play("specialsoon")
		local timer = allTimers[difficultyName][self.vb.phase][spellId][self.vb.windrunnerCount+1]
		if timer then
			timerWindrunnerCD:Start(timer, self.vb.windrunnerCount+1)
		end
	elseif spellId == 347807 then
		local amount = args.amount or 1
		debuffStacks[args.destName] = amount
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(debuffStacks)
		end
	elseif spellId == 347670 or spellId == 353935 then
		warnShadowDagger:CombinedShow(0.3, args.destName)
	elseif spellId == 349458 then
		warnDominationChains:CombinedShow(0.3, args.destName)
	elseif spellId == 348064 then
		local icon = self.vb.arrowIcon
		if self.Options.SetIconOnWailingArrow then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnWailingArrow:Show()
			specWarnWailingArrow:Play("runout")
			yellWailingArrow:Yell(icon, icon)
			yellWailingArrow:Countdown(spellId, nil, icon)
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			if self:IsTanking(uId) then
				specWarnWailingArrowTaunt:Show(args.destName)
				specWarnWailingArrowTaunt:Play("tauntboss")
			end
		end
		warnWailingArrow:CombinedShow(0.3, args.destName)
		self.vb.arrowIcon = self.vb.arrowIcon + 1
	elseif spellId == 358705 then
		local icon = self.vb.arrowIcon
		if self.Options.SetIconOnWailingArrow then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnBlackArrow:Show()
			specWarnBlackArrow:Play("runout")
			yellBlackArrow:Yell(icon, icon)
			yellBlackArrowFades:Countdown(spellId, nil, icon)
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			if self:IsTanking(uId) then
				specWarnBlackArrowTaunt:Show(args.destName)
				specWarnBlackArrowTaunt:Play("tauntboss")
			end
		end
		warnBlackArrow:CombinedShow(0.3, args.destName)
		self.vb.arrowIcon = self.vb.arrowIcon + 1
	elseif spellId == 347607 then
		local amount = args.amount or 1
--		if amount >= 3 then
--			if args:IsPlayer() then
--				specWarnBansheesMark:Show(amount)
--				specWarnBansheesMark:Play("stackhigh")
--			else
--				if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", spellId) then
--					specWarnBansheesMarkTaunt:Show(args.destName)
--					specWarnBansheesMarkTaunt:Play("tauntboss")
--				else
--					warnBansheesMark:Show(args.destName, amount)
--				end
--			end
--		else
			warnBansheesMark:Show(args.destName, amount)
--		end
	elseif spellId == 350857 and self.vb.phase == 1 then
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(1.5))
		warnPhase:Play("phasechange")
		self:SetStage(1.5)--Intermission to phase 2
		self.vb.dominationChainsCount = 0
		self.vb.riveCount = 0
		timerWindrunnerCD:Stop()
		timerDominationChainsCD:Stop()
		timerVeilofDarknessCD:Stop()
		timerBlackArrowCD:Stop()
		timerRangersHeartseekerCD:Stop()
		if self.vb.windrunnerActive == 0 then--Only start timers here i windrunner not active
			intermissionStart(self, 0)
		elseif self.vb.windrunnerActive == 1 then
			self.vb.windrunnerActive = 2
		end
	elseif spellId == 348146 and self.vb.phase < 2 then
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2))
		warnPhase:Play("ptwo")
		self:SetStage(2)
		self.vb.veilofDarknessCount = 0
		self.vb.icecrownCast = 0
		self.vb.hauntingWavecount = 0
		timerRiveCD:Stop()
		timerDominationChainsCD:Stop()
		timerNextPhase:Stop()
		--Phase 2 timers still up in the air
--		timerRuinCD:Start(63.5)
--		timerHauntingWaveCD:Start(33.1)
--		timerVeilofDarknessCD:Start(3, 1)
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	elseif spellId == 351109 then
		if self.Options.NPAuraOnEnflame then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 351117 or spellId == 357886 then
		warnCrushingDread:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnCrushingDread:Show()
			specWarnCrushingDread:Play("runout")
			yellCrushingDread:Yell()
		end
	elseif spellId == 351451 then
		warnCurseofLthargy:combinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnCurseofLethargy:Show()
			specWarnCurseofLethargy:Play("targetyou")
		end
	elseif spellId == 351672 then
		local amount = args.amount or 1
		if amount >= 12 and self:AntiSpam(4, 2) then
			if self:IsTanking("player", "boss1", nil, true) then
				specWarnFury:Show(amount)
				specWarnFury:Play("changemt")
			else
				specWarnFuryOther:Show(args.destName)
				specWarnFuryOther:Play("tauntboss")
			end
		end
	elseif spellId == 353929 then
		local amount = args.amount or 1
		debuffStacks[args.destName] = amount
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(debuffStacks)
		end
		if args:IsPlayer() then
			specWarnBansheesBane:Cancel()
			specWarnBansheesBane:Schedule(0.3, amount)--Aggregate grabbing a bunch within 300ms
			specWarnBansheesBane:ScheduleVoice(0.3, "targetyou")
		elseif self:AntiSpam(3, args.destName) then
			local uId = DBM:GetRaidUnitId(args.destName)
			if self:IsTanking(uId) then
				specWarnBansheesBaneTaunt:Show(args.destName)
				specWarnBansheesBaneTaunt:Play("tauntboss")
			end
		end
	elseif spellId == 357720 then
		warnBansheesScream:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnBansheeScream:Show()
			specWarnBansheeScream:Play("scatter")
			yellBansheeScream:Yell()
		end
	elseif spellId == 356986 then
		self.vb.icecrownCast = self.vb.icecrownCast + 1
		warnWindsofIcecrown:Show(self.vb.icecrownCast, args.destName)
		timerWindsofIcecrown:Start()
	elseif spellId == 358711 then
		if args:IsPlayer() then
			specWarnRage:Show()
			specWarnRage:Play("justrun")
			if self.Options.NPAuraOnRage then
				DBM.Nameplate:Show(true, args.sourceGUID, spellId)
			end
		end
	elseif spellId == 351589 then
		if args:IsPlayer() then
			specWarnFilth:Show()
			specWarnFilth:Play("targetyou")
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			if self:IsTanking(uId) then
				specWarnFilthTaunt:Show(args.destName)
				specWarnFilthTaunt:Play("tauntboss")
			end
		end
	elseif spellId == 351562 then
		local icon = self.vb.debuffIcon
		if self.Options.SetIconOnExpulsion then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			--Unschedule target warning if you've become one of victims
			specWarnExpulsionTarget:Cancel()
			specWarnExpulsionTarget:CancelVoice()
			--Now show your warnings
			specWarnExpulsion:Show(self:IconNumToTexture(icon))
			specWarnExpulsion:Play("mm"..icon)
			yellExpulsion:Yell(icon, icon)
			yellExpulsionFades:Countdown(spellId, nil, icon)
		elseif self.Options.SpecWarn351562target and not DBM:UnitDebuff("player", spellId) then
			--Don't show special warning if you're one of victims
			specWarnExpulsionTarget:CombinedShow(0.5, args.destName)
			specWarnExpulsionTarget:ScheduleVoice(0.5, "helpsoak")
		else
			warnExpulsion:CombinedShow(0.5, args.destName)
		end
		self.vb.debuffIcon = self.vb.debuffIcon + 1
	elseif spellId == 358433 then
		local icon = self.vb.debuffIcon
		if self.Options.SetIconOnDeathKnives2 then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnDeathKnives:Show()
			specWarnDeathKnives:Play("runout")
			yellDeathKnives:Yell(icon, icon)
			yellDeathKnivesFades:Countdown(spellId, nil, icon)
		end
		warnDeathKnives:CombinedShow(0.5, args.destName)
		self.vb.debuffIcon = self.vb.debuffIcon + 1
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 347504 then
		if self.vb.windrunnerActive == 2 then--Execute delayed intermission start
			intermissionStart(self, 1.5)
		end
		self.vb.windrunnerActive = 0
		warnWindrunnerOver:Show()
	elseif spellId == 347807 or spellId == 353929 then
		debuffStacks[args.destName] = nil
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(debuffStacks)
		end
	elseif spellId == 351109 then
		if self.Options.NPAuraOnEnflame then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 356986 then
		timerWindsofIcecrown:Stop()
--		timerHauntingWaveCD:Start(15.6)
--		timerRuinCD:start(68.8)
--	elseif spellId == 348146 then
	elseif spellId == 348064 then
		if self.Options.SetIconOnWailingArrow then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellWailingArrowFades:Cancel()
		end
	elseif spellId == 358705 then
		if self.Options.SetIconOnWailingArrow then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellBlackArrowFades:Cancel()
		end
	elseif spellId == 351562 then
		if self.Options.SetIconOnExpulsion then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellExpulsionFades:Cancel()
		end
	elseif spellId == 358433 then
		if self.Options.SetIconOnDeathKnives2 then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellDeathKnivesFades:Cancel()
		end
	end
end

function mod:SPELL_AURA_REMOVED_DOSE(args)
	local spellId = args.spellId
	if spellId == 347807 or spellId == 353929 then
		debuffStacks[args.destName] = args.amount or 1
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(debuffStacks)
		end
	end
end

--"<55.31 21:07:27> [CHAT_MSG_RAID_BOSS_EMOTE] |TInterface\\Icons\\Ability_Argus_DeathFog.blp:20|t %s begins to cast |cFFFF0000|Hspell:347704|h[Veil of Darkness]|h|r!#Sylvanas Windrunner#####0#0##0#30#nil#0#false#false#false#false", -- [1092]
--"<57.93 21:07:29> [CLEU] SPELL_CAST_START#Vehicle-0-2083-2450-4126-175732-00002FED6E#Sylvanas Windrunner##nil#347726#Veil of Darkness#nil#nil", -- [1151]
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find("spell:347704") then--Faster than Combat log by 2.5 seconds in phase 1 and doesn't exist in combat log at all in phase 3 because reasons
		self.vb.veilofDarknessCount = self.vb.veilofDarknessCount + 1
		specWarnVeilofDarkness:Show(self.vb.veilofDarknessCount)
		specWarnVeilofDarkness:Play("watchstep")
		local timer = allTimers[difficultyName][self.vb.phase][347726][self.vb.veilofDarknessCount+1]
		if timer then
			timerVeilofDarknessCD:Start(timer, self.vb.wailingArrowCount+1)
		end
	end
end

--[[
https://ptr.wowhead.com/npc=177893/mawforged-colossus
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 177893 then--mawforged-colossus
		timerFilthCD:Stop(args.destGUID)
		timerExpulsionCD:Stop(args.destGUID)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 340324 and destGUID == UnitGUID("player") and not playerDebuff and self:AntiSpam(2, 3) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 342074 then

	end
end
--]]
