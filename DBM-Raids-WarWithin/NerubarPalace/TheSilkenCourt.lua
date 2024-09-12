local mod	= DBM:NewMod(2608, "DBM-Raids-WarWithin", 1, 1273)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(217489, 217491)--Anub'arash, Skeinspinner Takazj
mod:SetEncounterID(2921)
mod:SetUsedIcons(6, 7, 8)
mod:SetBossHPInfoToHighest()
mod:SetHotfixNoticeRev(20240711000000)
mod:SetMinSyncRevision(20240628000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 438218 438801 440246 440504 438343 439838 450045 451016 438677 452231 441626 450129 441782 450483 438355 443068 451327 442994 441791",
--	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON 438249",
	"SPELL_AURA_APPLIED 455849 455850 438218 455080 449857 440001 450980 438708 456252 450728 451277 443598 438656 440179 456245 438200 456235",--451611, 440503
	"SPELL_AURA_APPLIED_DOSE 438218 438200",
	"SPELL_AURA_REMOVED 455080 450980 451277 440001"--451611, 440503, 438656
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2"
)

--TODO, target scan charge? ALsos tooltip unclear, should a player soak it to avoid him hitting a wall or is that purely about aiming charge nots soaking?
--TODO, binding webs multi target alerts to alert who you are bound to once it's clear how it's presented in combat log (if it's presented)
--TODO, stinging swarm seems to have two versions, complex one that reequires dispeling near other boss to interrupt it, and one that's just ordinary debuff (probably LFR version)
--TODO, if stringing swarm doesn't go private aura, add icons and icon based yells for dispel assignments. Not gonna waste time doing it now though when this fight hasn't had PA flagging done yet
--TODO, add https://www.wowhead.com/beta/spell=441775/void-blast if it's not spammed, similar boat to poison bolt
--TODO, maybe Entropic should be a run away warning instead for melee?
--TODO, lots of cleanup of boss mechanics that interrupt other boss mechanics with better clarity and voices
--TODO, change option keys to match BW for weak aura compatability before live
--NOTE, https://www.wowhead.com/beta/spell=440503/impaling-eruption was not exposed, re-add of that changes
--[[
(ability.id = 438218 or ability.id = 438801 or ability.id = 440246 or ability.id = 440504 or ability.id = 438343 or ability.id = 439838 or ability.id = 450045 or ability.id = 438677 or ability.id = 452231 or ability.id = 441626 or ability.id = 450129 or ability.id = 441782 or ability.id = 450483 or ability.id = 438355 or ability.id = 443068 or ability.id = 442994) and type = "begincast"
or (ability.id = 451016 or ability.id = 451327) and type = "begincast"
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
local warnCalloftheSwarm						= mod:NewCountAnnounce(438801, 2)
local warnBurrowedEruption						= mod:NewCountAnnounce(441791, 2, nil, nil, 118563)
local warnImpaled								= mod:NewTargetNoFilterAnnounce(449857, 4)
local warnEntangled								= mod:NewTargetNoFilterAnnounce(440179, 1)

local specWarnPiercingStrike					= mod:NewSpecialWarningDefensive(438218, nil, nil, nil, 1, 2)
local specWarnRecklessCharge					= mod:NewSpecialWarningCount(440246, nil, 100, nil, 1, 2)--If we can get target, make dodge warning for non target and "move to web" for target
local specWarnImpalingEruption					= mod:NewSpecialWarningDodgeCount(440504, nil, nil, nil, 2, 2)
local yellImpaled								= mod:NewShortYell(449857, nil, false)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(421532, nil, nil, nil, 1, 8)

local timerPiercingStrikeCD						= mod:NewCDCountTimer(49, 438218, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerCalloftheSwarmCD						= mod:NewCDCountTimer(49, 438801, DBM_COMMON_L.ADDS.." (%s)", nil, nil, 1)
local timerRecklessChargeCD						= mod:NewCDCountTimer(49, 440246, 100, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)--Shortname "Charge"
local timerBurrowedEruptionCD					= mod:NewCDCountTimer(49, 441791, 118563, nil, nil, 3)--Shortname "Burrow"
local timerImpalingEruptionCD					= mod:NewCDCountTimer(49, 440504, DBM_COMMON_L.FRONTAL.." [A] (%s)", nil, nil, 3)--Frontal + boss initial
--local timerEntangledCD						= mod:NewTargetTimer(6, 440179, nil, false, nil, 5)--Too many timers on fight already, this is opt in

mod:AddNamePlateOption("NPAuraOnPerseverance", 455080, true)
mod:AddSetIconOption("SetIconOnScarab", 438801, true, 5, {6, 7, 8})
----Skeinspinner Takazj
mod:AddTimerLine(takazj)
local warnPoisonBolt						= mod:NewStackAnnounce(438200, 2, nil, "Tank|Healer")
local warnVenomousRain						= mod:NewCountAnnounce(438656, 2, nil, nil, 44933)
local warnWebBomb							= mod:NewCountAnnounce(439838, 3)--General announce for everyone, personal special announce to target
local warnSkitteringLeap					= mod:NewCountAnnounce(450045, 2, nil, nil, 47482)
local warnBindingWeb						= mod:NewFadesAnnounce(440001, 1)

--local specWarnWebBomb						= mod:NewSpecialWarningYou(439838, nil, nil, nil, 1, 2)--Not exposed
--local yellWebBomb							= mod:NewShortYell(439838)
--local yellWebBombFades					= mod:NewShortFadesYell(439838)
local specWarnBindingWebs					= mod:NewSpecialWarningYou(440001, nil, nil, nil, 1, 2)
local specWarnVenomousRain					= mod:NewSpecialWarningYou(438656, nil, 44933, nil, 1, 2)--Change to moveto if this is one that removes ground webs?

local timerVenomousRainCD					= mod:NewCDCountTimer(49, 438656, 44933, nil, nil, 3)--Shortname "Rain"
local timerWebBombCD						= mod:NewCDCountTimer(49, 439838, nil, nil, nil, 3)
local timerSkitteringLeapCD					= mod:NewCDCountTimer(49, 450045, 47482, nil, nil, 3)--Shortname "Leap"
local timerVoidAscensionCD					= mod:NewIntermissionCountTimer(100, 450483, nil, nil, nil, 6)
--Stage Two: Grasp of the Void
mod:AddTimerLine(DBM:EJ_GetSectionInfo(29021))
----Anub'arash
mod:AddTimerLine(anubarash)
local warnStingingSwarm						= mod:NewTargetNoFilterAnnounce(450045, 2)--No Filter because this is a raid wiping mechanic if the 3 players don't get to boss
local warnStingingDelirium					= mod:NewTargetNoFilterAnnounce(456245, 2)--Player or Boss

local specWarnStingingSwarm					= mod:NewSpecialWarningMoveTo(438677, nil, nil, nil, 1, 2)--438708
local yellStingingSwarm						= mod:NewShortYell(438677)

local timerStingingSwarmCD					= mod:NewCDCountTimer(49, 438677, DBM_COMMON_L.DISPELS.." (%s)", nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)
local timerRagingFuryIntermissionCD			= mod:NewIntermissionCountTimer(100, 451327, nil, nil, nil, 6)
----Skeinspinner Takazj
mod:AddTimerLine(takazj)
local warnVoidStep							= mod:NewCountAnnounce(450483, 2, nil, nil, 4801)
local warnEntropicDesolation				= mod:NewCastAnnounce(450129, 4, nil, nil, nil, 301902)

local specWarnWebVortex						= mod:NewSpecialWarningCount(441626, nil, nil, nil, 2, 12)
--local specWarnEntropicDesolation			= mod:NewSpecialWarningRun(450129, nil, nil, nil, 4, 2)
local specWarnStrandsofReality				= mod:NewSpecialWarningDodgeCount(441782, nil, nil, nil, 2, 2)
local specWarnCataclysmicEntropy			= mod:NewSpecialWarningCount(438355, nil, nil, nil, 2, 2)

local timerWebVortexCD						= mod:NewCDCountTimer(49, 441626, nil, nil, nil, 2)
local timerEntropicDesolationCD				= mod:NewCDCountTimer(49, 450129, 301902, nil, nil, 2)--Shortname "Run Away!"
local timerStrandsofRealityCD				= mod:NewCDCountTimer(49, 441782, DBM_COMMON_L.FRONTAL.." [S] (%s)", nil, nil, 3)--Frontal + boss initial
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

local savedDifficulty = "heroic"
local allTimers = {
	["normal"] = {--Updated Sept 11
		[1] = {
			-- Piercing Strike
			[438218] = {10.1, 20.0, 28.0, 20.0, 39.0},--Updated Sept 11
			-- Call of the Swarm
			[438801] = {12.1, 54.0},--Updated Sept 11
			-- Burrowed Eruption (precursor to Reckless Charge)
			[441791] = {32.1, 58.0},--Updated Sept 11
			-- Reckless Charge
			[440246] = {35.9, 58.0},--Updated Sept 11
			-- Impaling Eruption
			[440504] = {22.1, 38.0, 25.0},--Updated Sept 11
			-- Venomous Rain
			[438343] = {6.2, 38.0, 36.3, 37.6},--Updated Sept 11
			-- Web Bomb
			[439838] = {16.4, 57.9},--Updated Sept 11
			-- Skittering Leap
			[450045] = {39.5, 60.1},--Updated Sept 11
		},
		[2] = {
			-- Call of the Swarm
			[438801] = {12, 54},--Updated Sept 11
			-- Piercing Strike
			[438218] = {16, 20, 26, 20, 20, 20},--Updated Sept 11
			-- Impaling Eruption
			[440504] = {18, 39, 39},--Updated Sept 11
			-- Stinging Swarm
			[438677] = {33, 58},--Updated Sept 11
			-- Web Vortex
			[441626] = {31.7, 43.1},--Updated Sept 11
			-- Entropic Desolation
			[450129] = {34.5, 43.1},--Updated Sept 11
			-- Strands of Reality
			[441782] = {24.2, 65.7},--Updated Sept 11
			-- Void Step
			[450483] = {42.7, 29.1, 25.5},--Updated Sept 11
			-- Cataclysmic Entropy
			[438355] = {45.8, 54.7},--Updated Sept 11
		},
		[3] = {--Data looped 2nd time for now, will clean up once make sure it doesn't change after RWF
			-- Piercing Strike
			[438218] = {25, 23, 40, 23, 36, 20, 20, 40.4, 23, 40, 23, 36, 20, 20, 40.4, 23, 40, 23, 36, 20, 20, 40.4, 23, 40, 23, 36, 20, 20},--Updated Sept 11 (40.4, 23, 40, 23, 36, 20, 20 looping)
			-- Burrowed Eruption (precursor to Reckless Charge)
			[441791] = {55.0, 75, 127.5, 75, 127.5, 75, 127.5, 75},--Updated Sept 11 (127.5, 75 looping)
			-- Reckless Charge
			[440246] = {58.8, 75, 127.5, 75, 127.5, 75, 127.5, 75},--Updated Sept 11 (127.5, 75 looping)
			-- Stinging Swarm
			[438677] = {75.0, 100.0, 102.5, 100, 102.5, 100, 102.5, 100},--Updated Sept 11 (102.5, 100 looping)
			-- Web Vortex
			[441626] = {42, 75.8, 126.4, 75.8, 126.4, 75.8, 126.4, 75.8},--Updated Sept 11 (126.4, 75.8 looping)
			-- Entropic Desolation
			[450129] = {44.8, 75.8, 126.4, 75.8, 126.4, 75.8, 126.4, 75.8},--Updated Sept 11 (126.4, 75.8 looping)
			-- Strands of Reality
			[441782] = {26.4, 153.9, 48.4, 153.8, 48.4, 153.8, 48.4, 153.8},--Updated Sept 11 (48.4, 153.8 looping)
			-- Void Step
			[450483] = {63, 25.1, 24.5, 26.1, 48.8, 77.6, 25.2, 24.5, 26.1, 48.8, 77.6, 25.2, 24.5, 26.1, 48.8, 77.6, 25.2, 24.5, 26.1, 48.8},--Updated Sept 11 (77.6, 25.2, 24.5, 26.1, 48.8 looping)
			-- Cataclysmic Entropy
			[438355] = {91.2, 99.5, 102.9, 99.5, 102.9, 99.5, 102.9, 99.5},--Updated Sept 11 (102.9, 99.5 looping)
			-- Spike Eruption
			[443068] = {45.0, 62.9, 62.9, 76.6, 62.9, 62.9, 76.6, 62.9, 62.9, 76.6, 62.9, 62.9},--Updated Sept 11 (76.6, 62.9, 62.9 looping)
			-- Unleashed Swarm
			[442994] = {30.0, 118.9, 83.5, 119, 83.5, 119, 83.5, 119},--Updated Sept 12 (83.5, 119 looping)
		}
	},
	["heroic"] = {
		[1] = {
			-- Piercing Strike
			[438218] = {10, 20, 27, 21, 38},--Updated Sept 11
			-- Call of the Swarm
			[438801] = {12.1, 54},--Updated Sept 11
			-- Burrowed Eruption (precursor to Reckless Charge)
			[441791] = {32.1, 58},--Updated Sept 11
			-- Reckless Charge
			[440246] = {35.4, 58},--Updated Sept 11
			-- Impaling Eruption
			[440504] = {19.1, 40, 26, 33},--Updated Sept 11
			-- Venomous Rain
			[438343] = {6.2, 38.2, 26.1, 37.8},--Updated Sept 11
			-- Web Bomb
			[439838] = {16.7, 56.3},--Updated Sept 11
			-- Skittering Leap
			[450045] = {40, 58.3},--Updated Sept 11
		},
		[2] = {
			-- Call of the Swarm
			[438801] = {20, 54},--Updated Sept 11
			-- Piercing Strike
			[438218] = {18, 20, 20, 20, 20, 20},--Updated Sept 11
			-- Impaling Eruption
			[440504] = {13, 40, 27, 30},--Updated Sept 11
			-- Stinging Swarm
			[438677] = {29, 58},--Updated Sept 11
			-- Web Vortex
			[441626] = {20.3, 55.2},--Updated Sept 11
			-- Entropic Desolation
			[450129] = {23.1, 55.2},--Updated Sept 11
			-- Strands of Reality
			[441782] = {31.6, 35.8, 25.5},--Updated Sept 11
			-- Void Step
			[450483] = {38.4, 34, 25.2, 29.1},--Updated Sept 11
			-- Cataclysmic Entropy
			[438355] = {41.2, 59.2},--Updated Sept 11
		},
		[3] = {--12:14 (all tables doubled for now, will code actual clean coded loops once make sure they don't change after RWF)
			-- Piercing Strike
			[438218] = {20, 48, 20, 23, 20, 35, 34, 48, 20, 23, 20, 35, 34, 48, 20, 23, 20, 35, 34, 48, 20, 23, 20, 35},--Updated Sept 12 (34, 48, 20, 23, 20, 35 looping)
			-- Burrowed Eruption (precursor to Reckless Charge)
			[441791] = {43, 98, 82, 98, 82, 98, 82, 98},--Updated Sept 12 (82, 98 looping)
			-- Reckless Charge
			[440246] = {46.2, 98, 82, 98, 82, 98, 82, 98},--Updated Sept 12 (82, 98 looping)
			-- Stinging Swarm
			[438677] = {81, 57, 123, 57, 123, 57, 123, 57},--Updated Sept 12 (123, 57 looping)
			-- Web Vortex
			[441626] = {33.5, 97.5, 82.3, 97.5, 82.3, 97.5, 82.3, 97.5},--Updated Sept 12 (82.3, 97.5 looping)
			-- Entropic Desolation
			[450129] = {36.3, 97.4, 82.3, 97.5, 82.3, 97.5, 82.3, 97.5},--Updated Sept 12 (82.3, 97.5 looping)
			-- Strands of Reality
			[441782] = {22.3, 32.7, 21.3, 47.1, 78.7, 32.7, 21.1, 47.1},--Updated Sept 12 (78.7, 32.7, 21.1, 47.1 looping)
			-- Void Step
			[450483] = {50.8, 38.5, 29.1, 29.4, 2.5, 79.6, 38.9, 29.1, 29.5, 2.5, 79.6, 38.9, 29.1, 29.5, 2.5, 79.6, 38.9, 29.1, 29.5, 2.5},--Updated Sept 12 (79.6, 38.9, 29.1, 29.5, 2.5 looping)
			-- Cataclysmic Entropy
			[438355] = {92.6, 61.2, 118.5, 61.3, 118.5, 61.3, 118.5, 61.3},--Updated Sept 12 (118.5, 61.3 looping)
			-- Spike Eruption
			[443068] = {40, 31, 64, 85, 31, 64, 85, 31, 64, 85, 31, 64},--Updated Sept 12 (85, 31, 64 looping)
			-- Unleashed Swarm
			[442994] = {23, 75, 70, 35, 75, 70, 35, 75, 70, 35, 75, 70},--Updated Sept 12 (35, 75, 70 looping)
		}
	},
	["mythic"] = {--OLD beta timers, probably changed
		[1] = {
			-- Piercing Strike
			[438218] = {15.0, 23.0, 25.0, 24.0},
			-- Call of the Swarm
			[438801] = {23.0, 50.0},
			-- Burrowed Eruption (precursor to Reckless Charge)
			[441791] = {40.0, 59.9},
			-- Reckless Charge
			[440246] = {43.0, 59.9},
			-- Impaling Eruption
			[440504] = {8.0, 24.0, 25.0, 23.0},
			-- Venomous Rain
			[438343] = {15.2, 41.9, 33.2},
			-- Web Bomb
			[439838] = {31.4, 32.9, 28.1},
			-- Skittering Leap
			[450045] = {19.3, 27.3, 61.1},
		},
		[2] = {
			-- Call of the Swarm
			[438801] = {20.0, 48.0},
			-- Piercing Strike
			[438218] = {15.0, 19.0, 20.0, 23.0, 19.0, 24.0},
			-- Impaling Eruption
			[440504] = {9.0, 35.0, 35.0, 35.0},
			-- Stinging Swarm
			[438677] = {36.0, 37.0},
			-- Web Vortex
			[441626] = {32.7, 2.5, 34.6, 2.5, 33.7},--Sometimes boss skips 2nd cast then 3rd cast 73.4 after 1st cast
			-- Entropic Desolation
			[450129] = {38.0, 37.1},--Sometimes boss skips 2nd cast then 3rd cast 73.4 after 1st cast
			-- Strands of Reality
			[441782] = {14.1, 32.2, 36.1},
			-- Void Step
			[450483] = {52.8, 26.6, 23.7},
			-- Cataclysmic Entropy
			[438355] = {55.8, 61.3},
		},
		[3] = {
			-- Piercing Strike
			[438218] = {26.0, 20.0, 20.0, 34.0, 22.0, 21.0, 20.0},
			-- Burrowed Eruption (precursor to Reckless Charge)
			[441791] = {81.0, 97.0},
			-- Reckless Charge
			[440246] = {84.4, 96.6},
			-- Stinging Swarm
			[438677] = {63.0, 77.0},
			-- Web Vortex
			[441626] = {20.2, 2.5, 68.5, 2.5, 73.9, 2.5},
			-- Entropic Desolation
			[450129] = {25.5, 71.0, 76.4},
			-- Strands of Reality
			[441782] = {42.8, 38.8, 48.2, 47.2},
			-- Void Step
			[450483] = {37.8, 50.4, 24.6, 49.7, 23.1, 3.0},
			-- Cataclysmic Entropy
			[438355] = {115.8, 75.8},
			-- Spike Eruption
			[443068] = {23.0, 37.0, 37.0, 37.0, 37.0},
			-- Unleashed Swarm
			[442994] = {30.0, 80.0},
		}
	},
}

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
	--timerBurrowedEruptionCD:Start(allTimers[savedDifficulty][1][441791][1]-delay, 1)
	--Takazj
	timerVenomousRainCD:Start(allTimers[savedDifficulty][1][438343][1]-delay, 1)--7.7
	timerSkitteringLeapCD:Start(allTimers[savedDifficulty][1][450045][1]-delay, 1)--15.6
	timerWebBombCD:Start(allTimers[savedDifficulty][1][439838][1]-delay, 1)--25.0
	timerVoidAscensionCD:Start(self:IsHeroic() and 126.1, 1.5)--131 confirmed on mythic and normal, maybe heroic changed?
	if self.Options.NPAuraOnPerseverance then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.NPAuraOnPerseverance then
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
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 440246, self.vb.chargeCount+1)
		if timer then
			timerRecklessChargeCD:Start(timer, self.vb.chargeCount+1)
		end
	elseif spellId == 440504 then
		self.vb.eruptionCount = self.vb.eruptionCount + 1
		specWarnImpalingEruption:Show(self.vb.eruptionCount)
		specWarnImpalingEruption:Play("shockwave")
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 440504, self.vb.eruptionCount+1)
		if timer then
			timerImpalingEruptionCD:Start(timer, self.vb.eruptionCount+1)
		end
	elseif spellId == 438343 then
		self.vb.rainCount = self.vb.rainCount + 1
		warnVenomousRain:Show(self.vb.rainCount)
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
	elseif spellId == 451016 and self:GetStage(1) then--Shatter Existence (not cast anymore?)
		self:SetStage(1.5)
		self:Unschedule(checkSkippedWebVortex)
		self:Unschedule(checkSkippedEntropicDesolation)
		self:Unschedule(checkSkippedCatalysmicEntropy)
		--We manually stop timers Mostly in case phases can push early with higher dps checks in future
		--Anub
		timerRecklessChargeCD:Stop()
		timerPiercingStrikeCD:Stop()
		timerCalloftheSwarmCD:Stop()
		timerImpalingEruptionCD:Stop()
		--Takazj
		timerVenomousRainCD:Stop()
		timerWebBombCD:Stop()
		timerSkitteringLeapCD:Stop()
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
		specWarnStrandsofReality:Play("shockwave")
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
	elseif spellId == 451327 and self:GetStage(3) then--Raging Fury (Not always cast, don't start timers here)
		if self:GetStage(2) then
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
		--else
			--self.vb.rageCount = self.vb.rageCount + 1
			--timerRagingFuryCD:Start()
		end
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
		warnPiercingStrike:Show(args.destName, args.amount or 1)
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
		if args:IsPlayer() and self:AntiSpam(3, 1) then
			specWarnBindingWebs:Show()
			specWarnBindingWebs:Play("lineapart")--Maybe use a diff sound during charge like "block charge"?
		end
	elseif spellId == 450980 then--Shatter Existence Absorb
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(args.spellName)
			local uId = DBM:GetUnitIdFromGUID(args.destGUID, true)
			DBM.InfoFrame:Show(2, "enemyabsorb", nil, args.amount, uId)
		end
	elseif spellId == 438656 then
		if args:IsPlayer() then
			specWarnVenomousRain:Show()
			specWarnVenomousRain:Play("targetyou")
		end
	elseif spellId == 440179 then
		warnEntangled:Show(args.destName)
	elseif spellId == 456245 or spellId == 456235 then
		warnStingingDelirium:Show(args.destName)
	elseif spellId == 451277 and self:GetStage(2) then--Spike Storm Absorb
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
	elseif spellId == 438708 or spellId == 456252 or spellId == 450728 then--One is unlimited version one is 9 second. I suspect one is initial version and one is jump?
		warnStingingSwarm:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnStingingSwarm:Show(takazj)
			specWarnStingingSwarm:Play("movetoboss")
			yellStingingSwarm:Yell()
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
--	elseif spellId == 451611 then
--		if args:IsPlayer() then
--			yellWebBombFades:Cancel()
--		end
	elseif spellId == 440001 then
		if args:IsPlayer() then
			warnBindingWeb:Show()
		end
	elseif spellId == 450980 then--Shatter Existence Absorb
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
	elseif spellId == 451277 then--Spike Storm Absorb
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
