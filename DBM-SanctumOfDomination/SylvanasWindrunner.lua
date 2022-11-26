local mod	= DBM:NewMod(2441, "DBM-SanctumOfDomination", nil, 1193)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(175732)
mod:SetEncounterID(2435)
mod:SetUsedIcons(1, 2, 3)
mod:SetHotfixNoticeRev(20210826000000)--2021-08-26
mod:SetMinSyncRevision(20210826000000)
mod.respawnTime = 29
--mod.NoSortAnnounce = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 349419 347726 352663 353418 353417 348094 355540 352271 351075 351353 356023 354011 353969 354068 353952 353935 354147 357102 351589 351562 358181 352843 352842 347609 358704",
	"SPELL_CAST_SUCCESS 351178 357729 358588",
	"SPELL_CREATE 348148 348093 351837 351838 351840 351841",
	"SPELL_AURA_APPLIED 347504 347807 347670 349458 348064 347607 350857 348146 351109 351117 351451 353929 357886 357720 353935 348064 356986 358711 358705 351562 358434",
	"SPELL_AURA_APPLIED_DOSE 347807 347607 351672 353929",
	"SPELL_AURA_REMOVED 347504 347807 351109 358711 358705 351562 358434 348064 353929 350857",
	"SPELL_AURA_REMOVED_DOSE 347807 353929",
	"CHAT_MSG_RAID_BOSS_EMOTE",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, improve add warnings/timers for phase 2? ie curse, crush, orbs, filth, etc
--TODO, chains cast timer for when they land?
--[[
(ability.id = 349419 or ability.id = 347609 or ability.id = 352663 or ability.id = 353418 or ability.id = 353417 or ability.id = 348094 or ability.id = 355540 or ability.id = 352271 or ability.id = 354011 or ability.id = 353969 or ability.id = 354068 or ability.id = 353952 or ability.id = 354147 or ability.id = 357102 or ability.id = 347726 or ability.id = 347741 or ability.id = 354142 or ability.id = 353935 or ability.id = 358704 or ability.id = 358181) and type = "begincast"
 or (ability.id = 357729 or ability.id = 358588) and type = "cast"
 or (ability.id = 356986 or ability.id = 347504 or ability.id = 350857 or ability.id = 348146) and (type = "begincast" or type = "applydebuff" or type = "applybuff" or type = "removebuff" or type = "removedebuff")
 or ability.id = 348148 or ability.id = 348093 or ability.id = 351837 or ability.id = 351838 or ability.id = 351840 or ability.id = 351841
 or (ability.id = 348064 or ability.id = 358705 or ability.id = 347670 or ability.id = 358434) and type =  "applydebuff"
 or ability.id = 355841  or ability.id = 355826
 or (ability.id = 351075 or ability.id = 351117 or ability.id = 351353 or ability.id = 356023 or ability.id = 351589 or ability.id = 351562) and type = "begincast"
--]]
--Shadow dagger timer pruposely uses diff timer from
local P1Info, P15Info, P2Info, P3Info = DBM:EJ_GetSectionInfo(23057), DBM:EJ_GetSectionInfo(22891), DBM:EJ_GetSectionInfo(23067), DBM:EJ_GetSectionInfo(22890)
--General
local warnPhase										= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)

--local specWarnGTFO								= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)

--local berserkTimer								= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("8")
mod:AddInfoFrameOption(nil, true)--Aused for 353929 and 347807

--Stage One: A Cycle of Hatred
--mod:AddOptionLine(P1Info, "announce")
--mod:AddOptionLine(P1Info, "specialannounce")
--mod:AddOptionLine(P1Info, "yell")
mod:AddTimerLine(P1Info)
--mod:AddIconLine(P1Info)
local warnWindrunnerOver							= mod:NewEndAnnounce(347504, 2)
local warnShadowDagger								= mod:NewTargetNoFilterAnnounce(353935, 2, nil, "Healer")
local warnDominationChains							= mod:NewTargetAnnounce(349419, 2, nil, nil, 298213)--Could be spammy, unknown behavior
local warnWailingArrow								= mod:NewTargetCountAnnounce(348064, 4, nil, nil, 208407, nil, nil, nil, true)
local warnRangersHeartseeker						= mod:NewCountAnnounce(352663, 2, nil, "Tank")
local warnBansheesMark								= mod:NewStackAnnounce(347607, 2, nil, "Tank|Healer")
local warnBlackArrow								= mod:NewTargetCountAnnounce(358705, 4, nil, nil, 208407, nil, nil, nil, true)

local specWarnWindrunner							= mod:NewSpecialWarningCount(347504, nil, nil, nil, 2, 2)
local specWarnShadowDagger							= mod:NewSpecialWarningYou(353935, false, nil, nil, 1, 2)
local specWarnDominationChains						= mod:NewSpecialWarningCount(349419, nil, 298213, nil, 2, 2)
local specWarnVeilofDarkness						= mod:NewSpecialWarningDodgeCount(347704, nil, 209426, nil, 2, 2)
local specWarnWailingArrow							= mod:NewSpecialWarningRun(348064, nil, 208407, nil, 4, 2)
local yellWailingArrow								= mod:NewShortPosYell(348064, 208407)
local yellWailingArrowFades							= mod:NewIconFadesYell(348064, 208407)
local specWarnWailingArrowTaunt						= mod:NewSpecialWarningTaunt(348064, nil, nil, nil, 1, 2)
local specWarnBlackArrow							= mod:NewSpecialWarningYou(358705, nil, 208407, nil, 1, 2, 4)--Is this also on tanks? it doesn't have tank icon
local yellBlackArrow								= mod:NewShortPosYell(358705, 208407)
local yellBlackArrowFades							= mod:NewIconFadesYell(358705, 208407)
local specWarnBlackArrowTaunt						= mod:NewSpecialWarningTaunt(358705, nil, 208407, nil, 1, 2)
local specWarnRage									= mod:NewSpecialWarningRun(358711, nil, nil, nil, 4, 2)

local timerWindrunnerCD								= mod:NewCDCountTimer(50.3, 347504, nil, nil, nil, 6, nil, nil, nil, 1, 3)
local timerDominationChainsCD						= mod:NewCDCountTimer(50.7, 349419, 298213, nil, nil, 3)--Shortname Chains
local timerVeilofDarknessCD							= mod:NewCDCountTimer(48.8, 347704, 209426, nil, nil, 3)--Shortname Darkness
local timerWailingArrowCD							= mod:NewCDCountTimer(33.9, 347609, 208407, nil, 2, 3)--Shortname Arrow
local timerWailingArrow								= mod:NewTargetCountTimer(9, 347609, 208407, nil, nil, 5)--6 seconds for pre debuff plus 3 sec cast
local timerRangersHeartseekerCD						= mod:NewCDCountTimer(33.9, 352663, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerBlackArrowCD								= mod:NewCDCountTimer(33.9, 358705, 208407, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerBlackArrow								= mod:NewTargetCountTimer(9, 358705, 208407, nil, nil, 5, nil, DBM_COMMON_L.MYTHIC_ICON)

mod:AddSetIconOption("SetIconOnWailingArrow", 348064, true, false, {1, 2, 3})--Applies to both reg and mythic version
mod:AddNamePlateOption("NPAuraOnRage", 358711)--Dark Sentinel

--Intermission: A Monument to our Suffering
--mod:AddOptionLine(P15Info, "announce")
--mod:AddOptionLine(P15Info, "specialannounce")
mod:AddTimerLine(P15Info)
local warnRive										= mod:NewCountAnnounce(353418, 4)--May default off by default depending on feedback

local specWarnBansheeWail							= mod:NewSpecialWarningMoveAwayCount(348094, nil, nil, nil, 2, 2)

local timerRiveCD									= mod:NewCDTimer(48.8, 353418, nil, nil, nil, 3)
local timerNextPhase								= mod:NewPhaseTimer(16.5, 348094, nil, nil, nil, 6)

--Stage Two: The Banshee Queen
--mod:AddOptionLine(P2Info, "announce")
--mod:AddOptionLine(P2Info, "specialannounce")
--mod:AddOptionLine(P2Info, "yell")
mod:AddTimerLine(P2Info)
--mod:AddIconLine(P2Info)
local warnIceBridge									= mod:NewCountAnnounce(348148, 2)
local warnEarthBridge								= mod:NewCountAnnounce(348093, 2)
local warnWindsofIcecrown							= mod:NewTargetCountAnnounce(356986, 1, nil, nil, nil, nil, nil, nil, true)
local warnPortal									= mod:NewCastAnnounce(357102, 1)
----Forces of the Maw
local warnUnstoppableForce							= mod:NewCountAnnounce(351075, 2)--Mawsworn Vanguard
local warnLashingStrike								= mod:NewTargetNoFilterAnnounce(351178, 3)--Mawforged Souljudge
local warnCrushingDread								= mod:NewTargetAnnounce(351117, 2)--Mawforged Souljudge
local warnSummonDecrepitOrbs						= mod:NewCountAnnounce(351353, 2)--Mawforged Summoner
local warnCurseofLthargy							= mod:NewTargetAnnounce(351451, 2)--Mawforged Summoner
local warnExpulsion									= mod:NewTargetNoFilterAnnounce(351562, 4)

local specWarnHauntingWave							= mod:NewSpecialWarningDodgeCount(352271, nil, nil, nil, 2, 2)
local specWarnRuin									= mod:NewSpecialWarningInterruptCount(355540, nil, nil, nil, 3, 2)
----Forces of the Maw
local specWarnLashingStrike							= mod:NewSpecialWarningYou(351178, nil, nil, nil, 1, 2)--Mawforged Souljudge
local yellLashingStrike								= mod:NewYell(351178)--Mawforged Souljudge
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

local timerChannelIce								= mod:NewCastTimer(5, 348148, nil, nil, nil, 6)
local timerCallEarth								= mod:NewCastTimer(5, 348093, nil, nil, nil, 6)
--local timerChannelIceCD							= mod:NewCDCountTimer(48.8, 348148, nil, nil, nil, 6)
local timerCallEarthCD								= mod:NewCDCountTimer(48.8, 348093, nil, nil, nil, 6)
local timerRuinCD									= mod:NewCDCountTimer(23, 355540, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)
local timerHauntingWaveCD							= mod:NewCDCountTimer("d23", 352271, nil, nil, nil, 2)--String timer starting with "d" means "allowDouble"
local timerBansheeWailCD							= mod:NewCDCountTimer(48.8, 348094, nil, nil, nil, 2)
local timerWindsofIcecrown							= mod:NewBuffActiveTimer(35, 356986, nil, nil, nil, 5, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerPortal									= mod:NewCastTimer(10, 357102, nil, nil, nil, 6)
--Unstoppable Force ~9sec cd
----Forces of the Maw
local timerDecrepitOrbsCD							= mod:NewCDTimer(16, 351353, nil, nil, nil, 1)
local timerFilthCD									= mod:NewCDTimer(13.1, 351589, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.MYTHIC_ICON..DBM_COMMON_L.TANK_ICON)
local timerExpulsionCD								= mod:NewCDTimer(15.8, 351562, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)

mod:AddSetIconOption("SetIconOnExpulsion", 351562, true, true, {1, 2, 3})
mod:AddNamePlateOption("NPAuraOnEnflame", 351109)--Mawsworn Hopebreaker

--Stage Three: The Freedom of Choice
--mod:AddOptionLine(P3Info, "announce")
--mod:AddOptionLine(P3Info, "specialannounce")
--mod:AddOptionLine(P3Info, "yell")
mod:AddTimerLine(P3Info)
--mod:AddIconLine(P3Info)
local warnBansheesHeartseeker						= mod:NewCountAnnounce(353969, 2, nil, "Tank")
local warnBansheesBane								= mod:NewTargetNoFilterAnnounce(353929, 4)
local warnBansheesScream							= mod:NewTargetNoFilterAnnounce(357720, 3)
local warnBansheesBlades							= mod:NewCountAnnounce(358181, 4, nil, "Tank")
local warnDeathKnives								= mod:NewTargetNoFilterAnnounce(358434, 3)
local warnMerciless									= mod:NewCountAnnounce(358588, 2)

local specWarnBansheesBane							= mod:NewSpecialWarningStack(353929, nil, 1, nil, nil, 1, 6)
local specWarnBansheesBaneDispel					= mod:NewSpecialWarningDispel(353929, "RemoveMagic", nil, nil, 3, 2)--Dispel alert during Fury
local specWarnBansheeScream							= mod:NewSpecialWarningYou(357720, nil, 31295, nil, 1, 2)
local yellBansheeScream								= mod:NewYell(357720, 31295)
local specWarnRaze									= mod:NewSpecialWarningRun(354147, nil, nil, nil, 4, 2)
local specWarnDeathKnives							= mod:NewSpecialWarningMoveAway(358434, nil, nil, nil, 1, 2, 4)--Mythic
local yellDeathKnives								= mod:NewShortPosYell(358434)
local yellDeathKnivesFades							= mod:NewIconFadesYell(358434)
local specWarnMerciless								= mod:NewSpecialWarningSoakCount(358588, false, nil, nil, 2, 2, 4)--Mythic (opt in to upgrade to special waring)

local timerBansheesHeartseekerCD					= mod:NewCDCountTimer(33.9, 353969, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerShadowDaggerCD							= mod:NewCDCountTimer(23, 353935, nil, nil, nil, 3)--Only used in phase 3, in phase 1 it's tied to windrunner
local timerBaneArrowsCD								= mod:NewCDCountTimer(23, 354011, 208407, nil, nil, 3)
local timerBansheesFuryCD							= mod:NewCDCountTimer(23, 354068, nil, nil, nil, 2)--Short name NOT used since "Fury" also exists on fight
local timerBansheesScreamCD							= mod:NewCDCountTimer(23, 353952, 31295, nil, nil, 3)
local timerRazeCD									= mod:NewCDCountTimer(23, 354147, nil, nil, 2, 2, nil, DBM_COMMON_L.DEADLY_ICON)
--local timerBansheesBladesCD						= mod:NewCDCountTimer(33.9, 358181, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.MYTHIC_ICON..DBM_COMMON_L.TANK_ICON)
local timerDeathKnivesCD							= mod:NewCDCountTimer(33.9, 358434, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerDeathKnives								= mod:NewBuffFadesTimer(9, 358434, nil, nil, nil, 5, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerMercilessCD								= mod:NewCDCountTimer(33.9, 358588, nil, nil, 2, 5, nil, DBM_COMMON_L.MYTHIC_ICON)

mod:AddSetIconOption("SetIconOnDeathKnives2", 358434, false, false, {1, 2, 3})--Conflicts with arrow, which will be more logical choice. might delete this
--mod:GroupSpells(358705, 358711)--Black Arrow and Rage should be bundled?

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
mod.vb.debuffIcon = 1
mod.vb.bridgeCount = 0
mod.vb.icecrownCast = 0
mod.vb.ruinCount = 0
mod.vb.hauntingWavecount = 0
mod.vb.bansheeWailCount = 0
mod.vb.shroudremovedCount = 0
--P3+ variables
mod.vb.baneArrowCount = 0
mod.vb.shadowDaggerCount = 0
mod.vb.bansheeScreamCount = 0
mod.vb.bansheesFuryCount = 0
mod.vb.razeCount = 0
mod.vb.bladesCount = 0
mod.vb.knivesCount = 0
mod.vb.merciCount = 0
local debuffStacks = {}
local castsPerGUID = {}
local difficultyName = "None"
local allTimers = {
	["lfr"] = {
		[1] = {
			--Windrunner
			[347504] = {8.9, 62.0, 62, 61.1},
			--Ranger's Heartseeker
			[352663] = {22.2, 19.3, 18.7, 19.7, 20.8, 18.8, 18.7, 19.4},
			--Domination Chains
			[349419] = {29, 63.9, 63.9},
			--Wailing Arrow
			[347609] = {41.3, 46.6, 37.3, 39.8},
			--Veil of Darkness
			[347726] = {56.6, 59.3, 59.3},
		},
		[3] = {
			--Bane Arrows
			[354011] = {36.1, 87.8, 87.9, 88.8, 87.9},
			--Banshee's Heartseeker
			[353969] = {38.9, 24.4, 54.5, 3, 13.3, 24.4, 35.1, 11.8, 34.3, 12.5, 36.1, 12.1, 23.3, 45.5, 3},
			--Shadow Dagger
			[353935] = {54, 89.1, 93.2, 84.8},
			--Banshee Scream
			[353952] = {105.7, 62.1, 62, 63.1, 59.9},
			--Wailing Arrow
			[347609] = {86.1, 64.8, 64.9, 64.4, 65},
			--Veil of Darkness
			[347726] = {44, 68.7, 66.2, 67.2, 67.4, 67.4},
			--Raze
			[354147] = {95.2, 89.4, 86.5, 90.1},
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
		[3] = {
			--Bane Arrows
			[354011] = {30.7, 80.4, 76.2, 79.3, 78.6},
			--Banshee's Heartseeker
			[353969] = {44.9, 19, 45.3, 4.5, 30.1, 15.3, 23.5, 32.7, 15.3, 38.5, 9.7, 27.3, 30.1, 14.8, 34.4, 12.6},
			--Shadow Dagger
			[353935] = {48.1, 80, 83.6, 76.9, 87.6},
			--Banshee Scream
			[353952] = {96.6, 52.1, 55.7, 55.7, 58.2, 59.8},
			--Wailing Arrow
			[347609] = {77, 57.8, 57.6, 58.6, 58.2, 59.3},
			--Veil of Darkness
			[347726] = {41.8, 64.3, 68.6, 46.5, 62.7, 57.5, 61.9},
			--Raze
			[354147] = {86, 76.1, 78.2, 85.4},
		},
	},
	["heroic"] = {
		[1] = {
			--Windrunner
			[347504] = {7, 51.3, 48.8, 47.5, 52.7},
			--Ranger's Heartseeker
			[352663] = {20.1, 19.1, 17.1, 29.9, 4.8, 32.2, 16.1, 12, 25.7, 20.6, 4.7},
			--Domination Chains
			[349419] = {23.2, 53.4, 49.6, 53.9},
			--Wailing Arrow
			[347609] = {34.9, 38, 30.5, 31.7, 37.7, 31.7},
			--Veil of Darkness
			[347726] = {44.9, 49.4, 46.5, 46.3},--46-48 variable
		},
		[3] = {
			--Bane Arrows
			[354011] = {29.1, 76.8, 73.2, 76.1, 74.5},
			--Banshee's Heartseeker
			[353969] = {36.6, 20.8, 50, 3, 16.4, 13.9, 31.9, 12, 14, 17.9, 31.6, 22.9, 9.9},--6th can be 13.9 or 21.4, 7th can be 31-39. Affected by arrows
			--Shadow Dagger
			[353935] = {45.5, 77.4, 79.9, 73.4},
			--Banshee Scream
			[353952] = {93.3, 47.4, 54.5, 52, 54.9},
			--Wailing Arrow
			[347609] = {73.7, 55.8, 53.7, 55, 57.8},
			--Veil of Darkness
			[347726] = {41.6, 61.6, 50.4, 58, 61.9},
			--Banshees Fury (Heroic+)
			[354068] = {17.2, 49.4, 49.6, 52.6, 47.4, 47.8, 58},
			--Raze
			[354147] = {82.7, 73.6, 71.3, 81.2},
		},
	},
	["mythic"] = {
		[1] = {
			--Windrunner
			[347504] = {6.5, 57, 55.1, 56.2},
			--Ranger's Heartseeker
			[352663] = {20, 17, 25, 17, 23, 4, 31, 20, 3, 8},
			--Domination Chains
			[349419] = {29, 55, 64.1},
			--Black Arrow (Replaces Wailing Arrow)
			[358704] = {40.6, 63.3, 63.3},--Initial to cast, not pre debuff, may change later
			--Veil of Darkness
			[347726] = {48, 43.4, 46.5, 52.4},
		},
		[3] = {
			--Bane Arrows
			[354011] = {15.4, 93.9, 100, 93},
			--Banshee's Heartseeker
			[353969] = {},--Supressed for now, do to it's unpredictable behavir with blades
			--Banshee's Blades
			[358181] = {},--Supressed for now, do to it's unpredictable behavir with heartseeker
			--Banshee Scream
			[353952] = {71.6, 111, 112},
			--Wailing Arrow
			[347609] = {59.5, 69.5, 68, 69, 69},--Cast not pre debuff
			--Veil of Darkness
			[347726] = {23.5, 56, 55, 55, 57, 57, 63},--2nd one can come later (60ish) if she casts tanka ability first)
			--Banshees Fury (Heroic/Mythic)
			[354068] = {38.3, 60.8, 64, 58, 62, 66},
			--Raze
			[354147] = {45.4, 105, 106, 104},--Technically on mythic sequence isn't needed, but it's used for code uniformity
			--Death Knives (Mythic Only)
			[358434] = {65.7, 54.7, 54.3, 55, 54, 55},
			--Merciless (Mythic Only)
--			[358588] = {22.8, 21, 21, 21, 21, 21, 21, 41, 41, 41},--Sets are aggregated into one (currently sequence not used, for obvious reasons)
		},
	},
}

--TODO, more than windrunner can delay this
local function intermissionStart(self, adjust)
	timerDominationChainsCD:Start(4-adjust, 1)--Practically right away
	timerRiveCD:Start(13.2-adjust)--Init timer only, for when the spam begins
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
	self.vb.windrunnerActive = 0
	if self:IsMythic() then
		difficultyName = "mythic"
		timerWindrunnerCD:Start(6.5-delay, 1)
		timerRangersHeartseekerCD:Start(20, 1)
		timerDominationChainsCD:Start(29-delay, 1)
		timerBlackArrowCD:Start(40.6-delay, 1)
		timerVeilofDarknessCD:Start(48-delay, 1)--Probably shorter to emote
	elseif self:IsHeroic() then
		difficultyName = "heroic"
		timerWindrunnerCD:Start(7-delay, 1)
		timerRangersHeartseekerCD:Start(20.2, 1)
		timerDominationChainsCD:Start(23.2-delay, 1)
		timerWailingArrowCD:Start(34.9-delay, 1)
		timerVeilofDarknessCD:Start(44.9-delay, 1)--To EMOTE
	elseif self:IsNormal() then
		difficultyName = "normal"
		timerWindrunnerCD:Start(7.7-delay, 1)
		timerRangersHeartseekerCD:Start(22.1, 1)
		timerDominationChainsCD:Start(25.2-delay, 1)
		timerWailingArrowCD:Start(37.6-delay, 1)
		timerVeilofDarknessCD:Start(50-delay, 1)--Probably shorter to emote
	else
		difficultyName = "lfr"
		timerWindrunnerCD:Start(8-delay, 1)
		timerRangersHeartseekerCD:Start(21.8, 1)
		timerDominationChainsCD:Start(28.5-delay, 1)
		timerWailingArrowCD:Start(40.8-delay, 1)
		timerVeilofDarknessCD:Start(55.3-delay, 1)
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
		if self.vb.phase == 1 or self.vb.phase == 3 then
			local timer = allTimers[difficultyName][self.vb.phase] and allTimers[difficultyName][self.vb.phase][spellId][self.vb.dominationChainsCount+1]
			if timer then
				timerDominationChainsCD:Start(timer, self.vb.dominationChainsCount+1)
			end
		end
--	elseif spellId == 347726 or spellId == 347741 or spellId == 354142 then--Emote currently used for speed
--		self.vb.veilofDarknessCount = self.vb.veilofDarknessCount + 1
--		timerVeilofDarknessCD:Start()
	elseif spellId == 347609 then
		if self:AntiSpam(15, 1) then
--			self.vb.arrowIcon = 1
			self.vb.wailingArrowCount = self.vb.wailingArrowCount + 1
			if self.vb.phase == 1 or self.vb.phase == 3 then
				local timer = allTimers[difficultyName][self.vb.phase] and allTimers[difficultyName][self.vb.phase][spellId][self.vb.wailingArrowCount+1]
				if timer then
					timerWailingArrowCD:Start(timer, self.vb.wailingArrowCount+1)
				end
			end
		end
	elseif spellId == 358704 then
		if self:AntiSpam(15, 1) then
--			self.vb.arrowIcon = 1
			self.vb.wailingArrowCount = self.vb.wailingArrowCount + 1--Replaces this arrow in stage 1, so might as well use same variable
			if self.vb.phase == 1 or self.vb.phase == 3 then
				local timer = allTimers[difficultyName][self.vb.phase] and allTimers[difficultyName][self.vb.phase][spellId][self.vb.wailingArrowCount+1]
				if timer then
					timerBlackArrowCD:Start(timer, self.vb.wailingArrowCount+1)
				end
			end
		end
	elseif spellId == 352663 then
		self.vb.heartseekerCount = self.vb.heartseekerCount + 1
		warnRangersHeartseeker:Show(self.vb.heartseekerCount)
		if self.vb.phase == 1 or self.vb.phase == 3 then
			local timer = allTimers[difficultyName][self.vb.phase] and allTimers[difficultyName][self.vb.phase][spellId][self.vb.heartseekerCount+1]
			if timer then
				timerRangersHeartseekerCD:Start(timer, self.vb.heartseekerCount+1)
			end
		end
	elseif (spellId == 353418 or spellId == 353417) then--Rive
		self.vb.riveCount = self.vb.riveCount + 1
		warnRive:Show(self.vb.riveCount)
		if self.vb.riveCount == 2 then--Easy has less rives
			timerBansheeWailCD:Start(self:IsEasy() and 31.8 or 39.5, 1)
			timerNextPhase:Start(self:IsEasy() and 36.2 or 44.3)
		end
	elseif spellId == 348094 then
		self.vb.bansheeWailCount = self.vb.bansheeWailCount + 1
		specWarnBansheeWail:Show(self.vb.bansheeWailCount)
		specWarnBansheeWail:Play("scatter")
	elseif spellId == 355540 then
		self.vb.ruinCount = self.vb.ruinCount + 1
		specWarnRuin:Show(args.sourceName, self.vb.ruinCount)
		specWarnRuin:Play("kickcast")
	elseif spellId == 352271 then
		self.vb.hauntingWavecount = self.vb.hauntingWavecount + 1
		specWarnHauntingWave:Show(self.vb.hauntingWavecount)
		specWarnHauntingWave:Play("watchwave")
		--waves cast in middle of bridge cycles that need independant starts
		if self:IsMythic() then
			if self.vb.hauntingWavecount == 3 then
				timerHauntingWaveCD:Start(23, 4)
			elseif self.vb.hauntingWavecount == 4 then
				timerHauntingWaveCD:Start(17.3, 5)
			elseif self.vb.hauntingWavecount == 7 then
				timerHauntingWaveCD:Start(24.7, 8)
			end
		else
			if self.vb.hauntingWavecount == 6 then
				timerHauntingWaveCD:Start(41, 7)
			end
		end
	elseif spellId == 351075 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		if self:AntiSpam(3, 2) then--If multiple cast it at same time
			warnUnstoppableForce:Show(castsPerGUID[args.sourceGUID])
		end
	elseif spellId == 351353 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		warnSummonDecrepitOrbs:Show(castsPerGUID[args.sourceGUID])
		timerDecrepitOrbsCD:Start()
	elseif spellId == 356023 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then
			specWarnTerrorOrb:Show(args.sourceName, count)
			if count < 6 then
				specWarnTerrorOrb:Play("kick"..count.."r")
			else
				specWarnTerrorOrb:Play("kickcast")
			end
		end
	elseif spellId == 354011 then
		self.vb.baneArrowCount = self.vb.baneArrowCount + 1
		if self.vb.phase == 1 or self.vb.phase == 3 then
			local timer = allTimers[difficultyName][self.vb.phase] and allTimers[difficultyName][self.vb.phase][spellId][self.vb.baneArrowCount+1]
			if timer then
				timerBaneArrowsCD:Start(timer, self.vb.baneArrowCount+1)
			end
		end
	elseif spellId == 353969 then
		self.vb.heartseekerCount = self.vb.heartseekerCount + 1
		warnBansheesHeartseeker:Show(self.vb.heartseekerCount)
		if self.vb.phase == 1 or self.vb.phase == 3 then
			local timer = allTimers[difficultyName][self.vb.phase] and allTimers[difficultyName][self.vb.phase][spellId][self.vb.heartseekerCount+1]
			if timer then
				timerBansheesHeartseekerCD:Start(timer, self.vb.heartseekerCount+1)
			end
		end
	elseif spellId == 354068 then
		self.vb.bansheesFuryCount = self.vb.bansheesFuryCount + 1
		if self.vb.phase == 1 or self.vb.phase == 3 then
			local timer = allTimers[difficultyName][self.vb.phase] and allTimers[difficultyName][self.vb.phase][spellId][self.vb.bansheesFuryCount+1]
			if timer then
				timerBansheesFuryCD:Start(timer, self.vb.bansheesFuryCount+1)
			end
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
		if self.vb.phase == 1 or self.vb.phase == 3 then
			local timer = allTimers[difficultyName][self.vb.phase] and allTimers[difficultyName][self.vb.phase][spellId][self.vb.bansheeScreamCount+1]
			if timer then
				timerBansheesScreamCD:Start(timer, self.vb.bansheeScreamCount+1)
			end
		end
	elseif spellId == 353935 then
		if self.vb.phase == 3 then
			self.vb.shadowDaggerCount = self.vb.shadowDaggerCount + 1
			if self.vb.phase == 1 or self.vb.phase == 3 then
				local timer = allTimers[difficultyName][self.vb.phase] and allTimers[difficultyName][self.vb.phase][spellId][self.vb.shadowDaggerCount+1]
				if timer then
					timerShadowDaggerCD:Start(timer, self.vb.shadowDaggerCount+1)
				end
			end
		elseif self.vb.phase == 2 then
			if self:IsMythic() then
				if self.vb.shadowDaggerCount == 1 then
					timerShadowDaggerCD:Start(23.1, self.vb.shadowDaggerCount+1)
				end
			end
		end
	elseif spellId == 354147 then
		self.vb.razeCount = self.vb.razeCount + 1
		specWarnRaze:Show(self.vb.razeCount)
		specWarnRaze:Play("justrun")
		if self.vb.phase == 1 or self.vb.phase == 3 then
			local timer = allTimers[difficultyName][self.vb.phase] and allTimers[difficultyName][self.vb.phase][spellId][self.vb.razeCount+1]
			if timer then
				timerRazeCD:Start(timer, self.vb.razeCount+1)
			end
		end
	elseif spellId == 357102 then--Raid Portal: Oribos
		--Stop some bars here at least
		timerVeilofDarknessCD:Stop()
		timerHauntingWaveCD:Stop()
		timerBansheeWailCD:Stop()
		warnPortal:Show()
		timerPortal:Start()
	elseif spellId == 351589 then
		if self:IsTanking("player", nil, nil, nil, args.sourceGUID) then
			specWarnFilthDefensive:Show()
			specWarnFilthDefensive:Play("defensive")
		end
		timerFilthCD:Start()
	elseif spellId == 351562 then
		self.vb.debuffIcon = 1
		timerExpulsionCD:Start()
	elseif spellId == 358181 then
		self.vb.bladesCount = self.vb.bladesCount + 1
		warnBansheesBlades:Show(self.vb.bladesCount)
--		if self.vb.phase == 1 or self.vb.phase == 3 then
--			local timer = allTimers[difficultyName][self.vb.phase] and allTimers[difficultyName][self.vb.phase][spellId][self.vb.bladesCount+1]
--			if timer then
--				timerBansheesBladesCD:Start(timer, self.vb.bladesCount+1)
--			end
--		end
	elseif spellId == 352843 then--Channel Ice
		timerChannelIce:Start()
	elseif spellId == 352842 then--Call earth
		timerCallEarth:Start()
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
	elseif spellId == 358588 and self:AntiSpam(5, 3) then--Aggregated warnings/timers
		self.vb.merciCount = self.vb.merciCount + 1
		local soakCount
		if self.vb.merciCount == 7 or self.vb.merciCount < 3 then--1 2 and 7
			soakCount = 1--Three 1 soaks
		elseif self.vb.merciCount < 7 then--3 4 5 and 6
			soakCount = 2
		else--8+
			soakCount = 4
		end
		if self.Options.SpecWarn358588soakcount then
			specWarnMerciless:Show(self.vb.merciCount.." ("..soakCount.."x)")
			specWarnMerciless:Play("helpsoak")
		else
			warnMerciless:Show(self.vb.merciCount.." ("..soakCount.."x)")
		end
		timerMercilessCD:Start(self.vb.merciCount < 7 and 21 or 41, self.vb.merciCount+1)
	elseif spellId == 357729 and self.vb.phase ~= 3 then--Blasphemy
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(3))
		warnPhase:Play("pthree")
		self:SetStage(3)
		if self:IsFated() then
			self:AffixEvent(1, 3)
		end
		table.wipe(debuffStacks)
		self.vb.baneArrowCount = 0
		self.vb.shadowDaggerCount = 0
		self.vb.bansheeScreamCount = 0
		self.vb.bansheesFuryCount = 0
		self.vb.veilofDarknessCount = 0--Used only once per platform but might as well count it
		self.vb.wailingArrowCount = 0
		self.vb.razeCount = 0
		self.vb.heartseekerCount = 0
		self.vb.bladesCount = 0
		self.vb.knivesCount = 0
		self.vb.merciCount = 0
		timerRuinCD:Stop()
		timerHauntingWaveCD:Stop()
		timerVeilofDarknessCD:Stop()
		timerRangersHeartseekerCD:Stop()
		timerVeilofDarknessCD:Stop()
		timerBansheeWailCD:Stop()
		timerCallEarthCD:Stop()
		if self:IsMythic() then
			timerBaneArrowsCD:Start(15.4, 1)
--			timerBansheesHeartseekerCD:Start(31, 1)
			timerMercilessCD:Start(22.8, 1)
			timerVeilofDarknessCD:Start(23.5, 1)
			timerBansheesFuryCD:Start(38.3, 1)--Heroic+
			timerRazeCD:Start(45.4, 1)
--			timerBansheesBladesCD:Start(58, 1)--Mythic Only
			timerWailingArrowCD:Start(59.5, 1)
			timerDeathKnivesCD:Start(65.7, 1)--Mythic Only
			timerBansheesScreamCD:Start(71.6, 1)
		elseif self:IsHeroic() then
			timerBansheesFuryCD:Start(17.2, 1)--Heroic+
			timerBaneArrowsCD:Start(29.1, 1)
			timerBansheesHeartseekerCD:Start(36.6, 1)--Flipped on heroic
			timerVeilofDarknessCD:Start(41.6, 1)--Flipped on heroic
			timerShadowDaggerCD:Start(45.5, 1)--Non mythic
			timerWailingArrowCD:Start(73.7, 1)
			timerRazeCD:Start(82.7, 1)
			timerBansheesScreamCD:Start(93.3, 1)
		elseif self:IsNormal() then--Normal
			timerBaneArrowsCD:Start(30.7, 1)
			timerVeilofDarknessCD:Start(41.8, 1)
			timerBansheesHeartseekerCD:Start(44.9, 1)
			timerShadowDaggerCD:Start(48.1, 1)--Non mythic
			timerWailingArrowCD:Start(77, 1)
			timerRazeCD:Start(86, 1)
			timerBansheesScreamCD:Start(96.6, 1)
		else--LFR
			timerBaneArrowsCD:Start(34.9, 1)
			timerBansheesHeartseekerCD:Start(38.9, 1)
			timerVeilofDarknessCD:Start(44, 1)
			timerShadowDaggerCD:Start(54, 1)--Non mythic
			timerWailingArrowCD:Start(86.1, 1)
			timerRazeCD:Start(95.2, 1)
			timerBansheesScreamCD:Start(105.7, 1)
		end
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(353929))
			DBM.InfoFrame:Show(10, "table", debuffStacks, 1)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 347504 then
		self.vb.windrunnerActive = 1
		self.vb.windrunnerCount = self.vb.windrunnerCount + 1
		specWarnWindrunner:Show(self.vb.windrunnerCount)
		specWarnWindrunner:Play("specialsoon")
		if self.vb.phase == 1 or self.vb.phase == 3 then
			local timer = allTimers[difficultyName][self.vb.phase] and allTimers[difficultyName][self.vb.phase][spellId][self.vb.windrunnerCount+1]
			if timer then
				timerWindrunnerCD:Start(timer, self.vb.windrunnerCount+1)
			end
		end
	elseif spellId == 347807 then
		local amount = args.amount or 1
		debuffStacks[args.destName] = amount
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(debuffStacks, 0.2)
		end
	elseif spellId == 347670 or spellId == 353935 then
		warnShadowDagger:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnShadowDagger:Show()
			specWarnShadowDagger:Play("targetyou")
		end
	elseif spellId == 349458 then
		warnDominationChains:CombinedShow(0.3, args.destName)
	elseif spellId == 348064 then
		if self:AntiSpam(15, 4) then
			self.vb.arrowIcon = 1
		end
		local icon = self.vb.arrowIcon
		if self.Options.SetIconOnWailingArrow then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnWailingArrow:Show()
			specWarnWailingArrow:Play("runout")
			yellWailingArrow:Yell(icon, icon)
			yellWailingArrowFades:Countdown(spellId, nil, icon)
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			if self:IsTanking(uId) then
				specWarnWailingArrowTaunt:Show(args.destName)
				specWarnWailingArrowTaunt:Play("tauntboss")
			end
		end
		warnWailingArrow:Show(icon, args.destName)
		timerWailingArrow:Start(9, args.destName, icon)
		self.vb.arrowIcon = self.vb.arrowIcon + 1
	elseif spellId == 358705 then
		if self:AntiSpam(15, 4) then
			self.vb.arrowIcon = 1
		end
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
		warnBlackArrow:Show(icon, args.destName)
		timerBlackArrow:Start(9, args.destName, icon)
		self.vb.arrowIcon = self.vb.arrowIcon + 1
	elseif spellId == 347607 then
		local amount = args.amount or 1
		if amount % 3 == 0 then--3 stacks at a time
			warnBansheesMark:Show(args.destName, amount)
		end
	elseif spellId == 350857 and self.vb.phase == 1 then
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(1.5))
		warnPhase:Play("phasechange")
		self:SetStage(1.5)--Intermission to phase 2
		if self:IsFated() then
			self:AffixEvent(0)
		end
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
		if self:IsFated() then
			self:AffixEvent(1, 2)
		end
		self.vb.veilofDarknessCount = 0
		self.vb.bridgeCount = 0
		self.vb.icecrownCast = 0
		self.vb.ruinCount = 0
		self.vb.hauntingWavecount = 0
		self.vb.bansheeWailCount = 0
		self.vb.shadowDaggerCount = 0--Used on Mythic
		self.vb.shroudremovedCount = 0
		timerRiveCD:Stop()
		timerDominationChainsCD:Stop()
		timerNextPhase:Stop()
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
		warnCurseofLthargy:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnCurseofLethargy:Show()
			specWarnCurseofLethargy:Play("targetyou")
		end
	elseif spellId == 351672 then
		local amount = args.amount or 1
		if amount >= 12 and self:AntiSpam(4, 5) then
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
			DBM.InfoFrame:UpdateTable(debuffStacks, 0.2)
		end
		if args:IsPlayer() then
			specWarnBansheesBane:Cancel()
			specWarnBansheesBane:Schedule(1.5, amount)--Aggregate grabbing a bunch within 300ms
			specWarnBansheesBane:ScheduleVoice(1.5, "targetyou")
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
	elseif spellId == 358434 then
		if self:AntiSpam(5, 6) then
			self.vb.debuffIcon = 1
			self.vb.knivesCount = self.vb.knivesCount + 1
			if self.vb.phase == 1 or self.vb.phase == 3 then
				local timer = allTimers[difficultyName][self.vb.phase] and allTimers[difficultyName][self.vb.phase][spellId][self.vb.knivesCount+1]
				if timer then
					timerDeathKnivesCD:Start(timer, self.vb.knivesCount+1)
				end
			end
			timerDeathKnives:Start()
		end
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
			DBM.InfoFrame:UpdateTable(debuffStacks, 0.2)
		end
	elseif spellId == 351109 then
		if self.Options.NPAuraOnEnflame then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 356986 then
		timerWindsofIcecrown:Stop()
	elseif spellId == 348064 then
		if self.Options.SetIconOnWailingArrow then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellWailingArrowFades:Cancel()
		end
		timerWailingArrow:Stop(args.destName, 1)
		timerWailingArrow:Stop(args.destName, 2)
		timerWailingArrow:Stop(args.destName, 3)
	elseif spellId == 358705 then
		if self.Options.SetIconOnWailingArrow then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellBlackArrowFades:Cancel()
		end
		timerBlackArrow:Stop(args.destName, 1)
		timerBlackArrow:Stop(args.destName, 2)
		timerBlackArrow:Stop(args.destName, 3)
	elseif spellId == 351562 then
		if self.Options.SetIconOnExpulsion then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellExpulsionFades:Cancel()
		end
	elseif spellId == 358434 then
		if self.Options.SetIconOnDeathKnives2 then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellDeathKnivesFades:Cancel()
		end
	elseif spellId == 358711 then
		if args:IsPlayer() then
			if self.Options.NPAuraOnRage then
				DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
			end
		end
	elseif spellId == 350857 and self.vb.phase == 2 then--Banshee Shroud
		self.vb.shroudremovedCount = self.vb.shroudremovedCount + 1
		if self:IsMythic() then
		    if self.vb.shroudremovedCount == 1 then--MYTHIC MYTHIC MYTHIC MYTHIC MYTHIC
				timerShadowDaggerCD:Start(8.5, self.vb.shadowDaggerCount+1)--MYTHIC MYTHIC MYTHIC MYTHIC MYTHIC
				timerHauntingWaveCD:Start(11.1, self.vb.hauntingWavecount+1)--MYTHIC MYTHIC MYTHIC MYTHIC MYTHIC
				timerVeilofDarknessCD:Start(18.5, self.vb.veilofDarknessCount+1)--MYTHIC MYTHIC MYTHIC MYTHIC MYTHIC
				timerBansheeWailCD:Start(42.3, self.vb.bansheeWailCount+1)--MYTHIC MYTHIC MYTHIC MYTHIC MYTHIC
		    elseif self.vb.shroudremovedCount == 2 then--MYTHIC MYTHIC MYTHIC MYTHIC MYTHIC
				--Daggers used near immediately--MYTHIC MYTHIC MYTHIC MYTHIC MYTHIC
--				timerHauntingWaveCD:Start(11.4, self.vb.hauntingWavecount+1)--MYTHIC MYTHIC MYTHIC MYTHIC MYTHIC
--				timerVeilofDarknessCD:Start(18.5, self.vb.veilofDarknessCount+1)--MYTHIC MYTHIC MYTHIC MYTHIC MYTHIC
				timerBansheeWailCD:Start(42, self.vb.bansheeWailCount+1)--MYTHIC MYTHIC MYTHIC MYTHIC MYTHIC
--				timerNextPhase:Start(58) -- Raid Portal: Oribos--MYTHIC MYTHIC MYTHIC MYTHIC MYTHIC
		    end
		else
		    if self.vb.shroudremovedCount == 1 then--THIS IS NOT MYTHIC STOP FUCKING IT UP MYSTICALOS
				timerShadowDaggerCD:Start(6.7, self.vb.shadowDaggerCount+1)--6.7-9--THIS IS NOT MYTHIC STOP FUCKING IT UP MYSTICALOS
				timerRangersHeartseekerCD:Start(self:IsLFR() and 29.4 or 18, self.vb.heartseekerCount+1)--THIS IS NOT MYTHIC STOP FUCKING IT UP MYSTICALOS
				timerVeilofDarknessCD:Start(21.1, self.vb.veilofDarknessCount+1)--22.102-21.1--THIS IS NOT MYTHIC STOP FUCKING IT UP MYSTICALOS
				if self:IsHeroic() then--Normal doesn't seem to get second one--THIS IS NOT MYTHIC STOP FUCKING IT UP MYSTICALOS
					timerRangersHeartseekerCD:Start(36.1, self.vb.heartseekerCount+2)--THIS IS NOT MYTHIC STOP FUCKING IT UP MYSTICALOS
				end--THIS IS NOT MYTHIC STOP FUCKING IT UP MYSTICALOS
				timerBansheeWailCD:Start(39.1, self.vb.bansheeWailCount+1)--THIS IS NOT MYTHIC STOP FUCKING IT UP MYSTICALOS
				timerCallEarthCD:Start(50.9, 3)--THIS IS NOT MYTHIC STOP FUCKING IT UP MYSTICALOS
				timerHauntingWaveCD:Start(51, self.vb.hauntingWavecount+1)--THIS IS NOT MYTHIC STOP FUCKING IT UP MYSTICALOS
		    elseif self.vb.shroudremovedCount == 2 then--THIS IS NOT MYTHIC STOP FUCKING IT UP MYSTICALOS
				--Daggers used near immediately (1.5-6)--THIS IS NOT MYTHIC STOP FUCKING IT UP MYSTICALOS
--				timerHauntingWaveCD:Start(12.7, self.vb.hauntingWavecount+1)--12.7-16.5--THIS IS NOT MYTHIC STOP FUCKING IT UP MYSTICALOS
				timerRangersHeartseekerCD:Start(20, self.vb.heartseekerCount+1)--20-22--THIS IS NOT MYTHIC STOP FUCKING IT UP MYSTICALOS
--				timerVeilofDarknessCD:Start(25.5, self.vb.veilofDarknessCount+1)--THIS IS NOT MYTHIC STOP FUCKING IT UP MYSTICALOS
				timerBansheeWailCD:Start(self:IsEasy() and 34.9 or 42, self.vb.bansheeWailCount+1)--THIS IS NOT MYTHIC STOP FUCKING IT UP MYSTICALOS
				--Portal timer is just not accurate, pretty sure it's timed and health event, so timer should be max time but that's also misleading since it's usually pushed by health
--				timerNextPhase:Start(self:IsLFR() and 31.3 or 40.1) --This probably has a timed and health push. 31-51 Raid Portal: Oribos--THIS IS NOT MYTHIC STOP FUCKING IT UP MYSTICALOS
		    end
		end
	end
end

function mod:SPELL_CREATE(args)
	if args:IsSpellID(348148, 348093, 351837, 351838, 351840, 351841) then
		self.vb.bridgeCount = self.vb.bridgeCount + 1
		--Failsafe Cancels in case a bridge can be advanced faster
--		timerChannelIceCD:Stop()
		timerCallEarthCD:Stop()
--		timerHauntingWaveCD:Stop()
--		timerRuinCD:Stop()
--		timerVeilofDarknessCD:Stop()
--		timerRangersHeartseekerCD:Stop()
--		timerBansheeWailCD:Stop()
		if self:IsMythic() then
			if self.vb.bridgeCount == 2 then--1 and 2 used together at same time roughly
				timerVeilofDarknessCD:Start(18.5, self.vb.veilofDarknessCount+1)
				timerHauntingWaveCD:Start(35.6, self.vb.hauntingWavecount+1)--Wave 2
				timerRuinCD:Start(47.3, self.vb.ruinCount+1)
--			elseif self.vb.bridgeCount == 3 then--Or shroud 1
--				timerShadowDaggerCD:Start(14, self.vb.shadowDaggerCount+1)
--				timerHauntingWaveCD:Start(17.1, self.vb.hauntingWavecount+1)
--				timerVeilofDarknessCD:Start(26, self.vb.veilofDarknessCount+1)
			elseif self.vb.bridgeCount == 6 then
				timerVeilofDarknessCD:Start(17.6, self.vb.veilofDarknessCount+1)
				timerHauntingWaveCD:Start(34.7, self.vb.hauntingWavecount+1)--Wave 6
				timerRuinCD:Start(46.9, self.vb.ruinCount+1)
			elseif self.vb.bridgeCount == 7 then--Seems more accurate starting these here than bridge 8 or shroud 2
				timerHauntingWaveCD:Start(15, self.vb.hauntingWavecount+1)--15-16
				timerVeilofDarknessCD:Start(23.3, self.vb.veilofDarknessCount+1)
				timerNextPhase:Start(54.1)
				--Heartseeker, daggers, and wail still seem  more accurate from shroud 2
			end
		else
			if self.vb.bridgeCount == 1 then
				warnIceBridge:Show(self.vb.bridgeCount)
--				timerHauntingWaveCD:Start(1, 1)--Used too soon to have timer
				timerHauntingWaveCD:Start(6.5, 2)
				timerHauntingWaveCD:Start(11, 3)
				timerHauntingWaveCD:Start(17.5, 4)
				timerHauntingWaveCD:Start(23, 5)
				timerCallEarthCD:Start(30.4, 2)
				timerRuinCD:Start(32.4, 1)--Only timer that runs over til next bridge
			elseif self.vb.bridgeCount == 2 then
				warnEarthBridge:Show(self.vb.bridgeCount)
				--Timers moved to shroud removed 1
--				timerRuinCD:Update(32, 34.1, 1)--Just to replace the timer that stop call cancelled for run over timer
--				timerRangersHeartseekerCD:Start(27.6, self.vb.heartseekerCount+1)
--				timerVeilofDarknessCD:Start(30, self.vb.veilofDarknessCount+1)--to EMOTE
--				if self:IsHeroic() then--Normal doesn't seem to get second one
--					timerRangersHeartseekerCD:Start(45.2, self.vb.heartseekerCount+2)
--				end
--				timerBansheeWailCD:Start(47, self.vb.bansheeWailCount+1)
--				timerCallEarthCD:Start(60, 3)
				--TODO, more shit if not pushed?
			elseif self.vb.bridgeCount == 3 then
				--Instant wave at start of bridge 3 handled by shroud removed 1
				warnEarthBridge:Show(self.vb.bridgeCount)
				timerVeilofDarknessCD:Start(23, self.vb.veilofDarknessCount+1)
				--Second wave near end of bridge 3 handled by prevous wave
				--TODO, more shit if not pushed?
			elseif self.vb.bridgeCount == 4 then--Normal timers are slightly slower but close enough to just use these globally
				--Instant wave at start of bridge 3 handled by haunting wave 6
				warnIceBridge:Show(self.vb.bridgeCount)
				timerRuinCD:Start(5, self.vb.ruinCount+1)--5-11 variation
				timerVeilofDarknessCD:Start(27.4, self.vb.veilofDarknessCount+1)--27-29
				--TODO, more shit if not pushed?
			elseif self.vb.bridgeCount == 5 then
				warnIceBridge:Show(self.vb.bridgeCount)
--				timerBansheeWailCD:Start(1, self.vb.bansheeWailCount+1)--Used too soon to have timer
				timerRuinCD:Start(10.7, self.vb.ruinCount+1)
				timerHauntingWaveCD:Start(31.5, self.vb.hauntingWavecount+1)
				timerVeilofDarknessCD:Start(35.7, self.vb.veilofDarknessCount+1)--35-37
				--TODO, more shit if not pushed?
			elseif self.vb.bridgeCount == 6 then
				timerVeilofDarknessCD:Stop()--If you push 6 before darkness happens from 5, it's canceled
				warnEarthBridge:Show(self.vb.bridgeCount)
				--These timers are more accurate here
				timerRuinCD:Start(7, self.vb.ruinCount+1)
				timerHauntingWaveCD:Start(25.4, self.vb.hauntingWavecount+1)
--				timerRangersHeartseekerCD:Start(self:IsEasy() and 33.8 or 30.6, self.vb.heartseekerCount+1)--Tough to decide if this should be here or shroud 2
				timerVeilofDarknessCD:Start(36.7, self.vb.veilofDarknessCount+1)
				--Shadow dagger, Wail, and portal are started in shroud removed 2 because it's more accurate
			end
		end
	end
end

function mod:SPELL_AURA_REMOVED_DOSE(args)
	local spellId = args.spellId
	if spellId == 347807 or spellId == 353929 then
		debuffStacks[args.destName] = args.amount or 1
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(debuffStacks, 0.2)
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
		if self.vb.phase == 1 or self.vb.phase == 3 then
			local timer = allTimers[difficultyName][self.vb.phase] and allTimers[difficultyName][self.vb.phase][347726][self.vb.veilofDarknessCount+1]
			if timer then--Handles P1 and P3, P2 is scheduled via bridges
				timerVeilofDarknessCD:Start(timer, self.vb.veilofDarknessCount+1)
			end
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 177891 then--Mawforged Summoner
		timerDecrepitOrbsCD:Stop()
	elseif cid == 177893 then--mawforged-colossus
		timerFilthCD:Stop()
		timerExpulsionCD:Stop()
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 340324 and destGUID == UnitGUID("player") and not playerDebuff and self:AntiSpam(2, 7) then
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
