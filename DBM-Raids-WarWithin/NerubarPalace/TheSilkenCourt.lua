local mod	= DBM:NewMod(2608, "DBM-Raids-WarWithin", 2, 1273)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(217489, 217491)--Anub'arash, Skeinspinner Takazj
mod:SetEncounterID(2921)
mod:SetUsedIcons(6, 7, 8)
mod:SetBossHPInfoToHighest()
mod:SetHotfixNoticeRev(20240711000000)
mod:SetMinSyncRevision(20241213000000)
mod:DisableRegenDetection()--Try to fix false combat detection
mod:SetZone(2657)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 438218 438801 440246 440504 438343 439838 450045 438677 452231 441626 450129 441782 450483 438355 443068 456174 442994 441791",
--	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON 438249",
	"SPELL_AURA_APPLIED 455849 455850 438218 455080 449857 440001 450980 438708 451277 443598 440179 456245 438200 456235 456252",--451611, 440503, 438656
	"SPELL_AURA_APPLIED_DOSE 438218 438200 456252",
	"SPELL_AURA_REMOVED 455080 450980 451277 440001 456252"--451611, 440503, 438656
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2"
)

--TODO, binding webs multi target alerts to alert who you are bound to once it's clear how it's presented in combat log (if it's presented)
--TODO, stinging swarm seems to have two versions, complex one that reequires dispeling near other boss to interrupt it, and one that's just ordinary debuff (probably LFR version)
--TODO, maybe Entropic should be a run away warning instead for melee?
--NOTE, https://www.wowhead.com/beta/spell=440503/impaling-eruption was not exposed, re-add of that changes
--[[
(ability.id = 438218 or ability.id = 438801 or ability.id = 440246 or ability.id = 440504 or ability.id = 438343 or ability.id = 439838 or ability.id = 450045 or ability.id = 438677 or ability.id = 452231 or ability.id = 441626 or ability.id = 450129 or ability.id = 441782 or ability.id = 450483 or ability.id = 438355 or ability.id = 443068 or ability.id = 442994) and type = "begincast"
or (ability.id = 451016 or ability.id = 456174) and type = "begincast"
or (ability.id = 451277 or ability.id = 450980) and (type = "applybuff" or type = "removebuff")
--]]
local anubarash, takazj = DBM:EJ_GetSectionInfo(29012), DBM:EJ_GetSectionInfo(29017)
--General Stuff
local specWarnMarkofParanoia					= mod:NewSpecialWarningYou(455849, nil, nil, nil, 1, 17, 4)
local specWarnMarkofRage						= mod:NewSpecialWarningYou(455850, nil, nil, nil, 1, 17, 4)

mod:AddInfoFrameOption(nil, true)--Absorb shield infoframe
--Stage One: Clash of Rivals
mod:AddTimerLine(DBM:EJ_GetSectionInfo(29011))
----Anub'arash
mod:AddTimerLine(anubarash)
local warnPiercingStrike						= mod:NewStackAnnounce(438218, 2, nil, "Tank|Healer", 2)
local warnCalloftheSwarm						= mod:NewCountAnnounce(438801, 2, nil, nil, nil, nil, DBM_COMMON_L.ADDS)
local warnBurrowedEruption						= mod:NewCountAnnounce(441791, 2, nil, nil, 118563)
local warnImpaled								= mod:NewTargetNoFilterAnnounce(449857, 4)
local warnEntangled								= mod:NewTargetNoFilterAnnounce(440179, 1)

local specWarnPiercingStrike					= mod:NewSpecialWarningDefensive(438218, nil, nil, nil, 1, 2)
local specWarnPiercingStrikeTaunt				= mod:NewSpecialWarningTaunt(438218, nil, nil, nil, 1, 2)
local specWarnRecklessCharge					= mod:NewSpecialWarningCount(440246, nil, 100, nil, 1, 2)--If we can get target, make dodge warning for non target and "move to web" for target
local specWarnImpalingEruption					= mod:NewSpecialWarningDodgeCount(440504, nil, nil, DBM_COMMON_L.FRONTAL .. L.Blue, 2, 15)
local yellImpaled								= mod:NewShortYell(449857, nil, false)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(421532, nil, nil, nil, 1, 8)

local timerPiercingStrikeCD						= mod:NewCDCountTimer(49, 438218, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerCalloftheSwarmCD						= mod:NewCDCountTimer(49, 438801, DBM_COMMON_L.ADDS.." (%s)", nil, nil, 1)
local timerRecklessChargeCD						= mod:NewCDCountTimer(49, 440246, 100, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)--Shortname "Charge"
local timerRecklessCharge						= mod:NewCastTimer(49, 440246, 100, nil, nil, 5, nil, DBM_COMMON_L.DEADLY_ICON)--Shortname "Charge"
local timerBurrowedEruptionCD					= mod:NewCDCountTimer(49, 441791, 118563, nil, nil, 3)--Shortname "Burrow"
local timerImpalingEruptionCD					= mod:NewCDCountTimer(49, 440504, DBM_COMMON_L.FRONTAL .. L.Blue .. " (%s)", nil, nil, 3)--Frontal + boss initial
--local timerEntangledCD						= mod:NewTargetTimer(6, 440179, nil, false, nil, 5)--Too many timers on fight already, this is opt in

mod:AddNamePlateOption("NPAuraOnPerseverance", 455080, true)
mod:AddSetIconOption("SetIconOnScarab", 438801, true, 5, {8, 7, 6})
----Skeinspinner Takazj
mod:AddTimerLine(takazj)
local warnPoisonBolt						= mod:NewStackAnnounce(438200, 2, nil, "Tank|Healer")
--local warnVenomousRain					= mod:NewCountAnnounce(438656, 2, nil, nil, 44933)
local warnWebBomb							= mod:NewCountAnnounce(439838, 3)--General announce for everyone, personal special announce to target
local warnSkitteringLeap					= mod:NewCountAnnounce(450045, 2, nil, nil, 47482)
local warnBindingWeb						= mod:NewFadesAnnounce(440001, 1)

--local specWarnWebBomb						= mod:NewSpecialWarningYou(439838, nil, nil, nil, 1, 2)--Not exposed
--local yellWebBomb							= mod:NewShortYell(439838)
--local yellWebBombFades					= mod:NewShortFadesYell(439838)
local specWarnBindingWebs					= mod:NewSpecialWarningLink(440001, nil, nil, nil, 1, 2)
local specWarnVenomousRain					= mod:NewSpecialWarningMoveAwayCount(438656, nil, 44933, nil, 1, 2)--Change to moveto if this is one that removes ground webs?

local timerVenomousRainCD					= mod:NewCDCountTimer(49, 438656, 44933, nil, nil, 3)--Shortname "Rain"
local timerWebBombCD						= mod:NewCDCountTimer(49, 439838, nil, nil, nil, 3)
local timerSkitteringLeapCD					= mod:NewCDCountTimer(49, 450045, 47482, nil, nil, 3)--Shortname "Leap"
local timerVoidAscensionCD					= mod:NewIntermissionCountTimer(100, 450483, nil, nil, nil, 6)
--Stage Two: Grasp of the Void
mod:AddTimerLine(DBM:EJ_GetSectionInfo(29021))
----Anub'arash
mod:AddTimerLine(anubarash)
local warnStingingSwarm						= mod:NewTargetNoFilterAnnounce(438677, 2)--PLAYER. No Filter because this is a raid wiping mechanic if the 3/5 players don't get to boss
local warnStingingSwarmBossStack			= mod:NewStackAnnounce(456252, 1)
local warnStingingDelirium					= mod:NewTargetNoFilterAnnounce(456245, 2)--Player or Boss

local specWarnStingingSwarm					= mod:NewSpecialWarningMoveTo(438677, nil, nil, nil, 1, 2)--438708
local yellStingingSwarm						= mod:NewShortYell(438677)

local timerStingingSwarmCD					= mod:NewCDCountTimer(49, 438677, DBM_COMMON_L.DISPELS.." (%s)", nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)
local timerRagingFuryIntermissionCD			= mod:NewIntermissionCountTimer(100, 451277, nil, nil, nil, 6)

mod:AddNamePlateOption("NPAuraOnStingingBoss", 456252, true)
----Skeinspinner Takazj
mod:AddTimerLine(takazj)
local warnVoidStep							= mod:NewCountAnnounce(450483, 2, nil, nil, 4801)
local warnEntropicDesolation				= mod:NewCastAnnounce(450129, 4, nil, nil, nil, 301902)

local specWarnWebVortex						= mod:NewSpecialWarningCount(441626, nil, nil, nil, 2, 12)
--local specWarnEntropicDesolation			= mod:NewSpecialWarningRun(450129, nil, nil, nil, 4, 2)
local specWarnStrandsofReality				= mod:NewSpecialWarningDodgeCount(441782, nil, nil, DBM_COMMON_L.FRONTAL .. L.Red, 2, 15)
local specWarnCataclysmicEntropy			= mod:NewSpecialWarningCount(438355, nil, nil, nil, 2, 2)

local timerWebVortexCD						= mod:NewCDCountTimer(49, 441626, nil, nil, nil, 2)
local timerEntropicDesolationCD				= mod:NewCDCountTimer(49, 450129, 301902, nil, nil, 2)--Shortname "Run Away!"
local timerStrandsofRealityCD				= mod:NewCDCountTimer(49, 441782, DBM_COMMON_L.FRONTAL .. L.Red .. " (%s)", nil, nil, 3)--Frontal + boss initial
local timerVoidStepCD						= mod:NewCDCountTimer(49, 450483, 4801, nil, nil, 3)--Shortname "Teleport"
local timerCataclysmicEntropyCD				= mod:NewCDCountTimer(49, 438355, 108132, nil, nil, 5, nil, DBM_COMMON_L.DEADLY_ICON)--Shortname "Massive Explosion"
--Stage Three: Unleashed Rage
mod:AddTimerLine(DBM:EJ_GetSectionInfo(29022))
local specWarnEnragedFerocity				= mod:NewSpecialWarningDispel(443598, "RemoveEnrage", nil, nil, 1, 2)
----Anub'arash
mod:AddTimerLine(anubarash)
local specWarnUnleashedSwarm				= mod:NewSpecialWarningCount(442994, nil, 310414, nil, 2, 2)
local specWarnSpikeEruption					= mod:NewSpecialWarningDodgeCount(443068, nil, 14104, nil, 2, 2)

local timerSpikeEruptionCD					= mod:NewCDCountTimer(49, 443068, 14104, nil, nil, 3)--Shortname "Spikes"
local timerUnleashedSwarmCD					= mod:NewCDCountTimer(49, 442994, 310414, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)--Shortname "Swarm"
--local timerRagingFuryCD					= mod:NewCDCountTimer(49, 451327, nil, nil, nil, 5, nil, DBM_COMMON_L.ENRAGE_ICON)

mod.vb.burrowedEruptionCount = 0
mod.vb.piercingCount = 0
mod.vb.swarmCount = 0--Call of the Swarm and Unleashed Swarm
mod.vb.chargeCount = 0
mod.vb.eruptionCount = 0--Impaling Eruption & Spike Eruption
mod.vb.rainCount = 0--Venomous Rain & Entropic Desolation
mod.vb.webBombCount = 0--Web Bomb & Web Vortex
mod.vb.leapCount = 0--Skittering Leap & Void Step
mod.vb.stingingCount = 0
mod.vb.strandsCount = 0
mod.vb.cataCount = 0
mod.vb.scarabIcon = 8
--mod.vb.rageCount = 0--Only cast once?
local weblinkCount, playerFirst, lastPlayer = 0, false, nil

local savedDifficulty = "heroic"
local allTimers = {
	["lfr"] = {--9:32
	[1] = {
		-- Piercing Strike
		[438218] = {13.0, 26.6, 38.6, 26.6, 52.0},
		-- Call of the Swarm
		[438801] = {15.7},
		-- Burrowed Eruption (precursor to Reckless Charge)
		[441791] = {42.4, 77.2},
		-- Reckless Charge
		[440246] = {47.3, 77.2},
		-- Impaling Eruption
		[440504] = {29.1, 51.9, 30.6},
		-- Venomous Rain
		[438343] = {7.8, 68.5, 70.5},
		-- Web Bomb
		[439838] = {21.3, 78.6},
		-- Skittering Leap
		[450045] = {51.6, 76.5},
	},
	[2] = {
		-- Call of the Swarm
		[438801] = {79.3},
		-- Piercing Strike
		[438218] = {19.3, 33.3, 32.0, 26.6, 34.6},
		-- Impaling Eruption
		[440504] = {44.6, 93.3},
		-- Stinging Swarm
		[438677] = {36.6, 81.3},
		-- Web Vortex
		[441626] = {103.7},
		-- Entropic Desolation
		[450129] = {106.5},
		-- Strands of Reality
		[441782] = {27.4, 66.1},
		-- Void Step
		[450483] = {37.5, 49.5, 30.1},
		-- Cataclysmic Entropy
		[438355] = {41.5, 79.6},
	},
	[3] = {
		-- Piercing Strike
		[438218] = {36.0, 29.3, 26.6, 40},
		-- Burrowed Eruption (precursor to Reckless Charge)
		[441791] = {96.0},
		-- Reckless Charge
		[440246] = {100.8},
		-- Stinging Swarm
		[438677] = {0.000001},
		-- Web Vortex
		[441626] = {74.4},
		-- Entropic Desolation
		[450129] = {77.1},
		-- Strands of Reality
		[441782] = {40.2, 45.5, 46.2},
		-- Void Step
		[450483] = {106.5},
		-- Cataclysmic Entropy
		[438355] = {0.000001},
		-- Spike Eruption
		[443068] = {61.3, 82.6},
		-- Unleashed Swarm
		[442994] = {45.3},
	}
},
	["normal"] = {
		[1] = {
			-- Piercing Strike
			[438218] = {10.1, 20.0, 28.0, 20.0, 39.0},
			-- Call of the Swarm
			[438801] = {12.1, 54.0},
			-- Burrowed Eruption (precursor to Reckless Charge)
			[441791] = {32.1, 58.0},
			-- Reckless Charge
			[440246] = {35.9, 57.9},
			-- Impaling Eruption
			[440504] = {22.1, 38.0, 25.0},
			-- Venomous Rain
			[438343] = {6.1, 37.8, 36.3, 36.4},
			-- Web Bomb
			[439838] = {16.4, 59.0},
			-- Skittering Leap
			[450045] = {39.5, 58.5},
		},
		[2] = {
			-- Call of the Swarm
			[438801] = {12, 54},
			-- Piercing Strike
			[438218] = {16, 20, 26, 20, 20, 20},
			-- Impaling Eruption
			[440504] = {18, 39, 39},
			-- Stinging Swarm
			[438677] = {33, 58},
			-- Web Vortex
			[441626] = {29.7, 43.1},
			-- Entropic Desolation
			[450129] = {32.5, 43.1},
			-- Strands of Reality
			[441782] = {22.2, 65.7},
			-- Void Step
			[450483] = {37.5, 32.9, 25},
			-- Cataclysmic Entropy
			[438355] = {41.2, 58.2},
		},
		[3] = {--Data looped 2nd time for now, will clean up once make sure it doesn't change after RWF
			-- Piercing Strike
			[438218] = {25, 23, 40, 23, 36, 20, 20, 40.4, 23, 40, 23, 36, 20, 20, 40.4, 23, 40, 23, 36, 20, 20, 40.4, 23, 40, 23, 36, 20, 20},--(40.4, 23, 40, 23, 36, 20, 20 looping)
			-- Burrowed Eruption (precursor to Reckless Charge)
			[441791] = {55.0, 75, 127.5, 75, 127.5, 75, 127.5, 75},--(127.5, 75 looping)
			-- Reckless Charge
			[440246] = {58.8, 75, 127.5, 75, 127.5, 75, 127.5, 75},--(127.5, 75 looping)
			-- Stinging Swarm
			[438677] = {75.0, 100.0, 102.5, 100, 102.5, 100, 102.5, 100},--(102.5, 100 looping)
			-- Web Vortex
			[441626] = {41.8, 75.5, 126.4, 75.5, 126.4, 75.5, 126.4, 75.5},--(126.4, 75.5 looping)
			-- Entropic Desolation
			[450129] = {44.6, 75.5, 126.4, 75.5, 126.4, 75.5, 126.4, 75.5},--(126.4, 75.5 looping)
			-- Strands of Reality
			[441782] = {26.3, 78.4, 74.5, 50.1, 77.6},--Loop?
			-- Void Step
			[450483] = {62.8, 24.9, 24.5, 25.7, 50, 76.4, 24.9, 24.5, 25.7, 50},--(76.4, 24.9, 24.5, 25.7, 50 looping)
			-- Cataclysmic Entropy
			[438355] = {90.7, 101, 101},
			-- Spike Eruption
			[443068] = {45.0, 62.9, 62.9, 76.5, 62.9, 62.9, 76.5, 62.9, 62.9, 76.5, 62.9, 62.9},--(76.5, 62.9, 62.9 looping)
			-- Unleashed Swarm
			[442994] = {30.0, 118.9, 83.5, 119, 83.5, 119, 83.5, 119},--Updated Sept 12 (83.5, 119 looping)
		}
	},
	["heroic"] = {
		[1] = {
			-- Piercing Strike
			[438218] = {10, 20, 27, 20.9, 38},
			-- Call of the Swarm
			[438801] = {12.1, 54},
			-- Burrowed Eruption (precursor to Reckless Charge)
			[441791] = {32.1, 58},
			-- Reckless Charge
			[440246] = {35.4, 58},
			-- Impaling Eruption
			[440504] = {19.1, 40, 26, 32.9},
			-- Venomous Rain
			[438343] = {6.2, 37.8, 35.9, 36.4},--3rd cast can be as early as 27 if you fail to stun anub, but usually it's 36-37
			-- Web Bomb
			[439838] = {16.2, 56.1},
			-- Skittering Leap
			[450045] = {39, 58.3},
		},
		[2] = {
			-- Call of the Swarm
			[438801] = {20, 54},
			-- Piercing Strike
			[438218] = {18, 20, 20, 20, 20, 20},
			-- Impaling Eruption
			[440504] = {13, 40, 27, 30},
			-- Stinging Swarm
			[438677] = {29, 58},
			-- Web Vortex
			[441626] = {20.3, 55.2},
			-- Entropic Desolation
			[450129] = {22.9, 55.2},
			-- Strands of Reality
			[441782] = {30.5, 35.8, 24.5},
			-- Void Step
			[450483] = {38.4, 34, 24.1, 29.1},
			-- Cataclysmic Entropy
			[438355] = {41.2, 58.3},
		},
		[3] = {--12:14 (all tables doubled for now, will code actual clean coded loops once make sure they don't change after RWF)
			-- Piercing Strike
			[438218] = {20, 48, 20, 23, 20, 35, 34, 48, 20, 23, 20, 35, 34, 48, 20, 23, 20, 35, 34, 48, 20, 23, 20, 35},--Updated Sept 12 (34, 48, 20, 23, 20, 35 looping)
			-- Burrowed Eruption (precursor to Reckless Charge)
			[441791] = {43, 98, 81.5, 98, 81.5, 98, 81.5, 98},--Updated Sept 12 (82, 98 looping)
			-- Reckless Charge
			[440246] = {45.9, 98, 81.5, 98, 82, 98, 81.5, 98},--Updated Sept 12 (82, 98 looping)
			-- Stinging Swarm
			[438677] = {81, 57, 123, 57, 123, 57, 123, 57},--Updated Sept 12 (123, 57 looping)
			-- Web Vortex
			[441626] = {33.5, 96.4, 83.3, 96.4, 83.3, 96.4, 83.3, 96.4},--Updated Sept 12 (83.3, 96.5 looping)
			-- Entropic Desolation
			[450129] = {36.3, 96.5, 82.3, 96.5, 82.3, 96.5, 82.3, 96.5},--Updated Sept 12 (82.3, 96.5 looping)
			-- Strands of Reality
			[441782] = {22.3, 31.9, 23.1, 45.1, 78.7, 31.9, 23.1, 45.1},--Updated Sept 12 (78.7, 31.9, 23.1, 45.1 looping)
			-- Void Step
			[450483] = {49.8, 38.5, 31.1, 28.3, 2.5, 78.8, 38.5, 31.1, 28.6, 2.5, 78.8, 38.5, 31.1, 28.6, 2.5, 78.8, 38.5, 31.1, 28.6, 2.5},--Updated Sept 12 (79.6, 38.5, 31.1, 28.6, 2.5 looping)
			-- Cataclysmic Entropy
			[438355] = {91.6, 62.3, 117.8, 62.3, 117.8, 62.3, 117.8, 62.3},--Updated Sept 12 (117.8, 62.3 looping)
			-- Spike Eruption
			[443068] = {40, 31, 63.9, 85, 31, 63.9, 85, 31, 63.9, 85, 31, 63.9},--Updated Sept 12 (85, 31, 63.9 looping)
			-- Unleashed Swarm
			[442994] = {23, 75, 70, 35, 75, 70, 35, 75, 70, 35, 75, 70},--Updated Sept 12 (35, 75, 70 looping)
		}
	},
	["mythic"] = {
		[1] = {
			-- Piercing Strike
			[438218] = {12.8, 20.0, 27.0, 20.0, 40.0},
			-- Call of the Swarm
			[438801] = {22.8, 53.0},
			-- Burrowed Eruption (precursor to Reckless Charge)
			[441791] = {34.8, 60.0},
			-- Reckless Charge
			[440246] = {38.2, 59.8},
			-- Impaling Eruption
			[440504] = {7.8, 20.0, 34.0, 20.0},
			-- Venomous Rain
			[438343] = {15.2, 33.5, 26.8},
			-- Web Bomb
			[439838] = {15.0, 70.3},
			-- Skittering Leap
			[450045] = {42.0, 60.1},
		},
		[2] = {
			-- Call of the Swarm
			[438801] = {28.0, 61.0},
			-- Piercing Strike
			[438218] = {16.0, 20.0, 25.0, 15.0, 20.0, 25.0},
			-- Impaling Eruption
			[440504] = {11.0, 30.0, 30.0, 30.0},
			-- Stinging Swarm
			[438677] = {25.0, 58.0},
			-- Web Vortex
			[441626] = {20.2, 2.5, 53.3, 2.5},
			-- Entropic Desolation
			[450129] = {25.5, 55.8},
			-- Strands of Reality
			[441782] = {32.1, 35.9, 23.9},
			-- Void Step
			[450483] = {38.7, 34.3, 23.6, 29.2},
			-- Cataclysmic Entropy
			[438355] = {41.8, 57.9},
		},
		[3] = {
			-- Piercing Strike
			[438218] = {20.0, 17.0, 32.0, 20.0, 21.0, 20.0, 36.0},
			-- Burrowed Eruption (precursor to Reckless Charge)
			[441791] = {43.0, 98.0},
			-- Reckless Charge
			[440246] = {46.1, 98.0},
			-- Stinging Swarm
			[438677] = {81.0, 57.0},
			-- Web Vortex
			[441626] = {33.4, 2.5, 31.1, 2.5, 61.4, 2.5},--33.4, 33.6, 63.9
			-- Entropic Desolation
			[450129] = {38.6, 33.6, 63.9},
			-- Strands of Reality
			[441782] = {22.3, 33.6, 24.9, 43.0},
			-- Void Step
			[450483] = {51.2, 38.4, 29.3, 29.9, 2.6},
			-- Cataclysmic Entropy
			[438355] = {92.6, 61.8},
			-- Spike Eruption
			[443068] = {40.0, 31.0, 64.0},
			-- Unleashed Swarm
			[442994] = {23.0, 75.0, 70.0, 37.0},
		}
	},
}

--NOTE< below part might not be true anymore. They changed timers so boss has natural pause in casts after cataclysmic entropy, whether interrupted or not, his next casts aren't queued up/skipped
--The boss has a mechanic where a stun can be used to interrupt bosses casts
--Intent of the stun is to stop Cataclysmic Entropy, but it can also stop other casts
local function checkSkippedWebVortex(self)
	self.vb.webBombCount = self.vb.webBombCount + 1
	local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 441626, self.vb.webBombCount+1)
	if timer then
		timerWebVortexCD:Start(timer-8, self.vb.webBombCount+1)
		self:Schedule(timer, checkSkippedWebVortex, self)
	end
	DBM:Debug("checkSkippedWebVortex fired", 2)
end

local function checkSkippedEntropicDesolation(self)
	self.vb.rainCount = self.vb.rainCount + 1
	local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 450129, self.vb.rainCount+1)
	if timer then
		timerEntropicDesolationCD:Start(timer-8, self.vb.rainCount+1)
		self:Schedule(timer, checkSkippedEntropicDesolation, self)
	end
	DBM:Debug("checkSkippedEntropicDesolation fired", 2)
end

local function checkSkippedCatalysmicEntropy(self)
	self.vb.cataCount = self.vb.cataCount + 1
	local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 438355, self.vb.cataCount+1)
	if timer then
		timerCataclysmicEntropyCD:Start(timer-8, self.vb.cataCount+1)
		self:Schedule(timer, checkSkippedCatalysmicEntropy, self)
	end
	DBM:Debug("checkSkippedCatalysmicEntropy fired", 2)
end

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.burrowedEruptionCount = 0
	self.vb.piercingCount = 0
	self.vb.swarmCount = 0
	self.vb.chargeCount = 0
	self.vb.eruptionCount = 0
	self.vb.rainCount = 0
	self.vb.webBombCount = 0
	self.vb.leapCount = 0
	self.vb.stingingCount = 0
	self.vb.strandsCount = 0
	self.vb.cataCount = 0
	--self.vb.rageCount = 0
	playerFirst = false
	if self:IsMythic() then
		savedDifficulty = "mythic"
	elseif self:IsHeroic() then
		savedDifficulty = "heroic"
	else--Combine LFR and Normal
		savedDifficulty = "normal"
	end
	--Anub
	timerPiercingStrikeCD:Start(allTimers[savedDifficulty][1][438218][1]-delay, 1)--15.1
	timerCalloftheSwarmCD:Start(allTimers[savedDifficulty][1][438801][1]-delay, 1)--18.0
	timerImpalingEruptionCD:Start(allTimers[savedDifficulty][1][440504][1]-delay, 1)--21.1
	timerRecklessChargeCD:Start(allTimers[savedDifficulty][1][440246][1]-delay, 1)--43.3
	timerBurrowedEruptionCD:Start(allTimers[savedDifficulty][1][441791][1]-delay, 1)
	--Takazj
	timerVenomousRainCD:Start(allTimers[savedDifficulty][1][438343][1]-delay, 1)--7.7
	timerSkitteringLeapCD:Start(allTimers[savedDifficulty][1][450045][1]-delay, 1)--15.6
	timerWebBombCD:Start(allTimers[savedDifficulty][1][439838][1]-delay, 1)--25.0
	timerVoidAscensionCD:Start(126.1, 1.5)
	if self.Options.NPAuraOnPerseverance or self.Options.NPAuraOnStingingBoss then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.NPAuraOnPerseverance or self.Options.NPAuraOnStingingBoss then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:OnTimerRecovery()
	if self:IsMythic() then
		savedDifficulty = "mythic"
	elseif self:IsHeroic() then
		savedDifficulty = "heroic"
	else--Combine LFR and Normal
		savedDifficulty = "normal"
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 438218 then
		self.vb.piercingCount = self.vb.piercingCount + 1
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 438218, self.vb.piercingCount+1)
		if timer then
			timerPiercingStrikeCD:Start(timer, self.vb.piercingCount+1)
		end
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnPiercingStrike:Show()
			specWarnPiercingStrike:Play("defensive")
		end
	elseif spellId == 438801 then
		self.vb.scarabIcon = 8
		self.vb.swarmCount = self.vb.swarmCount + 1
		warnCalloftheSwarm:Show(self.vb.swarmCount)
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 438801, self.vb.swarmCount+1)
		if timer then
			timerCalloftheSwarmCD:Start(timer, self.vb.swarmCount+1)
		end
	elseif spellId == 440246 then
		self.vb.chargeCount = self.vb.chargeCount + 1
		specWarnRecklessCharge:Show(self.vb.chargeCount)
		if DBM:UnitDebuff("player", 440001) then--Web Lines
			specWarnRecklessCharge:Play("stopchargewithline")
		else
			specWarnRecklessCharge:Play("chargemove")
		end
		specWarnRecklessCharge:Play("chargemove")
		timerRecklessCharge:Start()
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 440246, self.vb.chargeCount+1)
		if timer then
			timerRecklessChargeCD:Start(timer, self.vb.chargeCount+1)
		end
	elseif spellId == 440504 then
		self.vb.eruptionCount = self.vb.eruptionCount + 1
		specWarnImpalingEruption:Show(self.vb.eruptionCount)
		specWarnImpalingEruption:Play("frontal")
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 440504, self.vb.eruptionCount+1)
		if timer then
			timerImpalingEruptionCD:Start(timer, self.vb.eruptionCount+1)
		end
	elseif spellId == 438343 then
		self.vb.rainCount = self.vb.rainCount + 1
		specWarnVenomousRain:Show(self.vb.rainCount)
		specWarnVenomousRain:Play("scatter")
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 438343, self.vb.rainCount+1)
		if timer then
			timerVenomousRainCD:Start(timer, self.vb.rainCount+1)
		end
	elseif spellId == 439838 then
		self.vb.webBombCount = self.vb.webBombCount + 1
		warnWebBomb:Show(self.vb.webBombCount)
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 439838, self.vb.webBombCount+1)
		if timer then
			timerWebBombCD:Start(timer, self.vb.webBombCount+1)
		end
	elseif spellId == 450045 then
		self.vb.leapCount = self.vb.leapCount + 1
		warnSkitteringLeap:Show(self.vb.leapCount)
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 450045, self.vb.leapCount+1)
		if timer then
			timerSkitteringLeapCD:Start(timer, self.vb.leapCount+1)
		end
	elseif spellId == 438677 or spellId == 452231 then--Hard difficulty, and second ID LFR assumed
		self.vb.stingingCount = self.vb.stingingCount + 1
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 438677, self.vb.stingingCount+1)
		if timer then
			timerStingingSwarmCD:Start(timer, self.vb.stingingCount+1)
		end
	elseif spellId == 441626 then
		self:Unschedule(checkSkippedWebVortex)
		self.vb.webBombCount = self.vb.webBombCount + 1
		specWarnWebVortex:Show(self.vb.webBombCount)
		specWarnWebVortex:Play("pullin")
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 441626, self.vb.webBombCount+1)
		if timer then
			timerWebVortexCD:Start(timer, self.vb.webBombCount+1)
			self:Schedule(timer+8, checkSkippedWebVortex, self)
		end
	elseif spellId == 450129 then
		self:Unschedule(checkSkippedEntropicDesolation)
		self.vb.rainCount = self.vb.rainCount + 1
		warnEntropicDesolation:Show()
--		specWarnEntropicDesolation:Show(self.vb.rainCount)
--		specWarnEntropicDesolation:Play("runout")
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 450129, self.vb.rainCount+1)
		if timer then
			timerEntropicDesolationCD:Start(timer, self.vb.rainCount+1)
			self:Schedule(timer+8, checkSkippedEntropicDesolation, self)
		end
	elseif spellId == 441782 then
		self.vb.strandsCount = self.vb.strandsCount + 1
		specWarnStrandsofReality:Show(self.vb.strandsCount)
		specWarnStrandsofReality:Play("frontal")
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 441782, self.vb.strandsCount+1)
		if timer then
			timerStrandsofRealityCD:Start(timer, self.vb.strandsCount+1)
		end
	elseif spellId == 450483 then
		--"<128.45 21:38:32> [CLEU] SPELL_CAST_START#Creature-0-2085-2657-20809-217491-00007DBEE3#Skeinspinner Takazj(62.2%-0.0%)##nil#450483#Void Step#nil#nil",
		--"<131.92 21:38:36> [CLEU] SPELL_AURA_APPLIED#Creature-0-2085-2657-20809-217491-00007DBEE3#Skeinspinner Takazj#Creature-0-2085-2657-20809-217491-00007DBEE3#Skeinspinner Takazj#450980#Shatter Existence#BUFF#269896768",
		--Early phasing since boss does a void step before casting shatter existence
		if self:GetStage(1) then
			self:SetStage(1.5)
			self:Unschedule(checkSkippedWebVortex)
			self:Unschedule(checkSkippedEntropicDesolation)
			self:Unschedule(checkSkippedCatalysmicEntropy)
			--We manually stop timers Mostly in case phases can push early with higher dps checks in future
			--Anub
			timerRecklessChargeCD:Stop()
			timerRecklessCharge:Stop()
			timerPiercingStrikeCD:Stop()
			timerCalloftheSwarmCD:Stop()
			timerImpalingEruptionCD:Stop()
			--Takazj
			timerVenomousRainCD:Stop()
			timerWebBombCD:Stop()
			timerSkitteringLeapCD:Stop()
		else
			self.vb.leapCount = self.vb.leapCount + 1
			warnVoidStep:Show(self.vb.leapCount)
			local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 450483, self.vb.leapCount+1)
			if timer then
				timerVoidStepCD:Start(timer, self.vb.leapCount+1)
			end
		end
	elseif spellId == 438355 then
		self:Unschedule(checkSkippedCatalysmicEntropy)
		self.vb.cataCount = self.vb.cataCount + 1
		specWarnCataclysmicEntropy:Show(self.vb.cataCount)
		specWarnCataclysmicEntropy:Play("specialsoon")--Maybe custom sound?
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 438355, self.vb.cataCount+1)
		if timer then
			timerCataclysmicEntropyCD:Start(timer, self.vb.cataCount+1)
			self:Schedule(timer+8, checkSkippedCatalysmicEntropy, self)
		end
	elseif spellId == 443068 then
		self.vb.eruptionCount = self.vb.eruptionCount + 1
		specWarnSpikeEruption:Show(self.vb.eruptionCount)
		specWarnSpikeEruption:Play("watchstep")
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 443068, self.vb.eruptionCount+1)
		if timer then
			timerSpikeEruptionCD:Start(timer, self.vb.eruptionCount+1)
		end
	elseif spellId == 441791 then
		self.vb.burrowedEruptionCount = self.vb.burrowedEruptionCount + 1
		warnBurrowedEruption:Show(self.vb.burrowedEruptionCount)
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 441791, self.vb.burrowedEruptionCount+1)
		if timer then
			timerBurrowedEruptionCD:Start(timer, self.vb.burrowedEruptionCount+1)
		end
	elseif spellId == 456174 and self:GetStage(2) then--Burrow Transition 2 (451160 is transition 1 but we use earlier event)
		self:SetStage(2.5)
		self:Unschedule(checkSkippedWebVortex)
		self:Unschedule(checkSkippedEntropicDesolation)
		self:Unschedule(checkSkippedCatalysmicEntropy)
		--We manually stop timers Mostly in case phases can push early with higher dps checks in future
		--Anub
		timerPiercingStrikeCD:Stop()
		timerCalloftheSwarmCD:Stop()
		timerImpalingEruptionCD:Stop()
		timerStingingSwarmCD:Stop()
		--Takazj
		timerWebVortexCD:Stop()
		timerEntropicDesolationCD:Stop()
		timerStrandsofRealityCD:Stop()
		timerVoidStepCD:Stop()
		timerCataclysmicEntropyCD:Stop()
	elseif spellId == 442994 then
		self.vb.swarmCount = self.vb.swarmCount + 1
		specWarnUnleashedSwarm:Show(self.vb.swarmCount)
		specWarnUnleashedSwarm:Play("aesoon")
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 442994, self.vb.swarmCount+1)
		if timer then
			timerUnleashedSwarmCD:Start(timer, self.vb.swarmCount+1)
		end
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 438249 then
		if self.Options.SetIconOnScarab then
			self:ScanForMobs(args.destGUID, 2, self.vb.scarabIcon, 1, nil, 12, "SetIconOnScarab")
		end
		self.vb.scarabIcon = self.vb.scarabIcon - 1
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 455849 and args:IsPlayer() then
		specWarnMarkofParanoia:Show()
		specWarnMarkofParanoia:Play("paranoiayou")
	elseif spellId == 455850 and args:IsPlayer() then
		specWarnMarkofRage:Show()
		specWarnMarkofRage:Play("rageyou")
	elseif spellId == 438218 then
		if not args:IsPlayer() then
			if not UnitIsDeadOrGhost("player") then
				specWarnPiercingStrikeTaunt:Show(args.destName)
				specWarnPiercingStrikeTaunt:Play("tauntboss")
			else
				warnPiercingStrike:Show(args.destName, args.amount or 1)
			end
		else
			warnPiercingStrike:Show(args.destName, args.amount or 1)
		end
	elseif spellId == 438200 then
		local amount = args.amount or 1
		if amount % 6 == 0 then
			warnPoisonBolt:Show(args.destName, args.amount or 1)
		end
	elseif spellId == 455080 then
		if self.Options.NPAuraOnPerseverance then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 449857 then
		warnImpaled:CombinedShow(1.5, args.destName)--Collects impaled targets over 1.5 seconds to reduce spam from bad dodging
		if args:IsPlayer() then
			yellImpaled:Yell()
		end
--	elseif spellId == 451611 then
--		if args:IsPlayer() then
--			specWarnWebBomb:Show()
--			specWarnWebBomb:Play("bombyou")
--			yellWebBomb:Yell()
--			yellWebBombFades:Countdown(spellId)
--		end
	elseif spellId == 440001 then
		if self:AntiSpam(4, 1) then
			weblinkCount = 0
			playerFirst = false
			lastPlayer = nil
		end
		weblinkCount = weblinkCount + 1
		if args:IsPlayer() then
			if weblinkCount % 2 == 0 then
				specWarnBindingWebs:Show(lastPlayer or DBM_COMMON_L.UNKNOWN)
				specWarnBindingWebs:Play(self:GetStage(2) and "lineapart" or "lineyou")--No charges to stop in stage 2
			else
				playerFirst = true
			end
		elseif playerFirst then
			playerFirst = false
			specWarnBindingWebs:Show(args.destName)
			specWarnBindingWebs:Play(self:GetStage(2) and "lineapart" or "lineyou")--No charges to stop in stage 2
		end
		lastPlayer = args.destName
	elseif spellId == 450980 then--Shatter Existence Absorb
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(args.spellName)
			local uId = DBM:GetUnitIdFromGUID(args.destGUID, true)
			DBM.InfoFrame:Show(2, "enemyabsorb", nil, args.amount, uId)
		end
	--elseif spellId == 438656 then
	--	if args:IsPlayer() then
	--		specWarnVenomousRain:Show()
	--		specWarnVenomousRain:Play("targetyou")
	--	end
	elseif spellId == 440179 then
		warnEntangled:Show(args.destName)
	elseif spellId == 456245 or spellId == 456235 then
		if args:GetDestCreatureID() == 217491 then
			warnStingingDelirium:UpdateColor(1)--Set green positive
		else
			warnStingingDelirium:UpdateColor(4)--Set red very bad
		end
		warnStingingDelirium:Show(args.destName)
	elseif spellId == 451277 then--Spike Storm Absorb
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(args.spellName)
			local uId = DBM:GetUnitIdFromGUID(args.destGUID, true)
			DBM.InfoFrame:Show(2, "enemyabsorb", nil, args.amount, uId)
		end
		if self:GetStage(2) then--backup phase change if Burrow fails
			self:SetStage(2.5)
			self:Unschedule(checkSkippedWebVortex)
			self:Unschedule(checkSkippedEntropicDesolation)
			self:Unschedule(checkSkippedCatalysmicEntropy)
			--Anub
			timerPiercingStrikeCD:Stop()
			timerCalloftheSwarmCD:Stop()
			timerImpalingEruptionCD:Stop()
			timerStingingSwarmCD:Stop()
			--Takazj
			timerWebVortexCD:Stop()
			timerEntropicDesolationCD:Stop()
			timerStrandsofRealityCD:Stop()
			timerVoidStepCD:Stop()
			timerCataclysmicEntropyCD:Stop()
		end
	elseif spellId == 438708 then--Stinging Sawrm on Players
		warnStingingSwarm:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnStingingSwarm:Show(takazj)
			specWarnStingingSwarm:Play("movetoboss")
			yellStingingSwarm:Yell()
		end
	elseif spellId == 456252 then--Stinging Swarm on boss
		local amount = args.amount or 1
		--Counts based on https://www.wowhead.com/spell=438677/stinging-swarm
		local maxStacks = self:IsMythic() and 5 or self:IsLFR() and 2 or 3
		if amount < maxStacks then
			warnStingingSwarmBossStack:Show(args.destName, amount)
		end
		if self.Options.NPAuraOnStingingBoss then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
			DBM.Nameplate:Show(true, args.destGUID, spellId, nil, 10, nil, true)
		end
	elseif spellId == 443598 then
		specWarnEnragedFerocity:Show(args.destName)
		specWarnEnragedFerocity:Play("enrage")
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 455080 then
		if self.Options.NPAuraOnPerseverance then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 456252 then--Stinging Swarm on boss
		if self.Options.NPAuraOnStingingBoss then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
--	elseif spellId == 451611 then
--		if args:IsPlayer() then
--			yellWebBombFades:Cancel()
--		end
	elseif spellId == 440001 then
		if args:IsPlayer() then
			warnBindingWeb:Show()
		end
	elseif spellId == 450980 then--Shatter Existence Absorb Removed
		self:SetStage(2)
		self:Unschedule(checkSkippedWebVortex)
		self:Unschedule(checkSkippedEntropicDesolation)
		self:Unschedule(checkSkippedCatalysmicEntropy)
		self.vb.piercingCount = 0
		self.vb.swarmCount = 0
		self.vb.eruptionCount = 0
		self.vb.rainCount = 0--Also used for Entropic Desolation
		self.vb.webBombCount = 0--Also web vortex
		self.vb.leapCount = 0--Also used for void step
		self.vb.strandsCount = 0
		self.vb.stingingCount = 0
		self.vb.cataCount = 0
		--Anub
		timerImpalingEruptionCD:Start(allTimers[savedDifficulty][2][440504][1], 1)
		timerPiercingStrikeCD:Start(allTimers[savedDifficulty][2][438218][1], 1)
		timerCalloftheSwarmCD:Start(allTimers[savedDifficulty][2][438801][1], 1)
		timerStingingSwarmCD:Start(allTimers[savedDifficulty][2][438677][1], 1)
		--Takazj
		timerStrandsofRealityCD:Start(allTimers[savedDifficulty][2][441782][1], 1)
		timerVoidStepCD:Start(allTimers[savedDifficulty][2][450483][1], 1)
		timerWebVortexCD:Start(allTimers[savedDifficulty][2][441626][1], 1)
		timerEntropicDesolationCD:Start(allTimers[savedDifficulty][2][450129][1], 1)
		timerCataclysmicEntropyCD:Start(allTimers[savedDifficulty][2][438355][1], 1)
		timerRagingFuryIntermissionCD:Start(self:IsEasy() and 128.7 or 132, 2.5)
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	elseif spellId == 451277 then--Spike Storm Absorb Removed
		self:SetStage(3)
		self:Unschedule(checkSkippedWebVortex)
		self:Unschedule(checkSkippedEntropicDesolation)
		self:Unschedule(checkSkippedCatalysmicEntropy)
		self.vb.piercingCount = 0
		self.vb.swarmCount = 0
		self.vb.chargeCount = 0
		self.vb.eruptionCount = 0
		self.vb.rainCount = 0--Also used for Entropic Desolation
		self.vb.webBombCount = 0--Also web vortex
		self.vb.leapCount = 0--Also used for void step
		self.vb.strandsCount = 0
		self.vb.stingingCount = 0
		self.vb.cataCount = 0
		--Anub
		timerSpikeEruptionCD:Start(allTimers[savedDifficulty][3][443068][1], 1)
		timerPiercingStrikeCD:Start(allTimers[savedDifficulty][3][438218][1], 1)
		timerUnleashedSwarmCD:Start(allTimers[savedDifficulty][3][442994][1], 1)
		timerRecklessChargeCD:Start(allTimers[savedDifficulty][3][440246][1], 1)
		timerStingingSwarmCD:Start(allTimers[savedDifficulty][3][438677][1], 1)
		--Takazj
		timerStrandsofRealityCD:Start(allTimers[savedDifficulty][3][441782][1], 1)
		timerVoidStepCD:Start(allTimers[savedDifficulty][3][450483][1], 1)
		timerWebVortexCD:Start(allTimers[savedDifficulty][3][441626][1], 1)
		timerEntropicDesolationCD:Start(allTimers[savedDifficulty][3][450129][1], 1)
		timerCataclysmicEntropyCD:Start(allTimers[savedDifficulty][3][438355][1], 1)
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 421532 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 426144 then

	end
end
--]]
