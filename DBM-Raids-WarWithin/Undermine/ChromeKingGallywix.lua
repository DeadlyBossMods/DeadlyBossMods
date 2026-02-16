local mod	= DBM:NewMod(2646, "DBM-Raids-WarWithin", 2, 1296)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(231075)
mod:SetEncounterID(3016)
mod:SetUsedIcons(8, 7, 6, 5, 4, 3)
mod:SetHotfixNoticeRev(20250404000000)
mod:SetMinSyncRevision(20250403000000)
mod:SetZone(2769)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 466340 467182 466751 469286 469327 466341 466834 1216845 1214607 466342 466958 1217987 1219041 1218488 1218546 1218696",--465952 1216852 1219039
	"SPELL_AURA_APPLIED 1216846 1214229 1214369 466165 1216444 1218504 1219039 1220784 469362 1218992 1218991 1220846 1220761 466246 469293 471603 469387 1226891",--1216852
	"SPELL_AURA_APPLIED_DOSE 466246",
	"SPELL_AURA_REMOVED 1214229 1214369 466165 466246 1220290 469293 1226891",
	"SPELL_INTERRUPT",
	"SPELL_PERIODIC_DAMAGE 1215209",
	"SPELL_PERIODIC_MISSED 1215209",
	"UNIT_DIED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_START boss1"
)

--TODO, VERIFY when a player is carrying a Gigabomb, use https://www.wowhead.com/ptr-2/spell=469361/giga-bomb too?
--TODO, add stack announce for https://www.wowhead.com/ptr-2/spell=471352/juice-it when frequency of stacks is known
--TODO, detect darkfuse cronies spawn, maybe https://www.wowhead.com/ptr-2/spell=462416/signal-flare ?
--TODO, auto mark hob goblins? https://www.wowhead.com/ptr-2/spell=1216846/holding-a-wrench
--TODO, possibly readd 469404 as a stack warning instead
--TODO, LFR phase detection fails and counts don't reset and timers break at a point in fight, unclear why without some detailed trancsriptor logs of LFR
--NOTE, it's possible to detect phase changes in story mode with anchor casts, but it's a mess and not worth dev time investment since the timers don't actually matter. As such timers just hard disabled in story mode
--[[
stoppedAbility.id = 1214369 or ability.id = 1214229 and (type = "applydebuff" or type = "removedebuff") or ability.id = 1220290 and type = "removebuff" or (ability.id = 1226891 or ability.id = 469293) and (type = "applybuff" or type = "removebuff")
--]]
local warnPhase										= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)

local timerPhaseTransition							= mod:NewStageCountTimer(33, 66911)

mod:AddInfoFrameOption(nil, true)
--Stage One: The House of Chrome
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30490))
local warnVentingHeat								= mod:NewCountAnnounce(466751, 2, nil, nil, 2)
local warnFocusedDetonation							= mod:NewCountAnnounce(466246, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(466246))

local specWarnSupression							= mod:NewSpecialWarningDodgeCount(467182, nil, nil, nil, 2, 2)
local specWarnScatterblastCanisters					= mod:NewSpecialWarningCount(466340, nil, nil, nil, 2, 2)
local specWarnScatterblastCanistersTaunt			= mod:NewSpecialWarningTaunt(466340, nil, nil, nil, 1, 2)
local specWarnBBBBombs								= mod:NewSpecialWarningCount(465952, nil, nil, nil, 2, 2)

local timerScatterblastCanistersCD					= mod:NewCDCountTimer(97.3, 466340, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerBBBBombsCD								= mod:NewCDCountTimer(97.3, 465952, nil, nil, nil, 3)
local timerSuppressionCD							= mod:NewCDCountTimer(97.3, 467182, nil, nil, nil, 3)
local timerVentingHeatCD							= mod:NewCDCountTimer(97.3, 466751, nil, nil, nil, 2)
local timer1500PoundDudCast							= mod:NewCastNPTimer(15, 466165, nil, nil, nil, 2)
local timerTimeReleasedCackler						= mod:NewTargetTimer(10, 1217292, nil, nil, nil, 2)
local timerFinalBlast								= mod:NewCastCountTimer(6, 1219333, nil, nil, nil, 3)

mod:AddPrivateAuraSoundOption(466155, true, 466155, 1)--Sapper's Satchel (sub mechanic to BBBBombs)
--Stage Two: Mechanical Maniac
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30497))
----Gallywix
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30555))
local warnGigaCoils									= mod:NewCountAnnounce(469286, 2)
local warnChargedGigaBomb							= mod:NewTargetNoFilterAnnounce(469362, 2, nil, false, 2)
local warnGigaBlast									= mod:NewCountAnnounce(469327, 3, nil, nil, 2)
local warnFusedCanisters							= mod:NewIncomingCountAnnounce(466341, 3)

local specChargedGigaBomb							= mod:NewSpecialWarningYou(469362, false, nil, nil, 1, 12)
local specWarnGTFO									= mod:NewSpecialWarningGTFO(1215209, nil, nil, nil, 1, 8)

local timerGigaCoilsCD								= mod:NewCDCountTimer(97.3, 469286, nil, nil, nil, 5)
local timerGigaBlastCD								= mod:NewCDCountTimer(6.5, 469327, nil, nil, nil, 3)--6.5 repeating but only while giga coil active
local timerFusedCanistersCD							= mod:NewCDCountTimer(97.3, 466341, nil, nil, nil, 3)
local timerControlMeltdownCD						= mod:NewCastCountTimer(15, 1220846, nil, nil, nil, 2)

mod:AddPrivateAuraSoundOption(466344, true, 466341, 2)--Fused Canister
----Darkfuse Cronies
mod:AddTimerLine(DBM:EJ_GetSectionInfo(31028))
--local warnEnrage									= mod:NewTargetNoFilterAnnounce(1216852, 2, nil, "Tank|Healer|RemoveEnrage")

local specWarnShockBarrage							= mod:NewSpecialWarningInterruptCount(466834, false, nil, nil, 1, 2)--REVISIT enabling by default based on player behavior
local specWarnWrench								= mod:NewSpecialWarningDefensive(1216845, nil, nil, nil, 1, 2)

local timerShockBarrageCast							= mod:NewCastNPTimer(10, 466834, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)
local timerWrenchCD									= mod:NewCDNPTimer(7.3, 1216845, nil, nil, nil, 5)
--local timerEnrageCD								= mod:NewCDNPTimer(97.3, 1216852, nil, nil, nil, 5)--Not in combat log

mod:AddSetIconOption("SetIconOnTechnician", -31482, true, 5, {8, 7, 6, 5, 4, 3})
--mod:AddSetIconOption("SetIconOnHobb", -31489, false, 5, {7, 8}, true)
--Intermission: Docked and Loaded
mod:AddTimerLine(DBM:EJ_GetSectionInfo(31558))

local specWarnCratering								= mod:NewSpecialWarningDodge(1214226, nil, nil, nil, 3, 2)
local specWarnTotalDestructionInterrupt				= mod:NewSpecialWarningInterrupt(1214369, "HasInterrupt", nil, nil, 1, 2)

local timerTotalDestruction							= mod:NewCastTimer(25, 1214369, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)

mod:AddPrivateAuraSoundOption(1219279, true, 1219279, 2)--Gallybux Pest Eliminator (Mythic only)
--Stage Three: What an Arsenal!
mod:AddTimerLine(DBM:EJ_GetSectionInfo(31445))

local specWarnBBBBlast								= mod:NewSpecialWarningCount(1214607, nil, nil, nil, 2, 2)
local specWarnBBBBlastTaunt							= mod:NewSpecialWarningTaunt(1214607, nil, nil, nil, 1, 2)
local specWarnTickTockCanisters						= mod:NewSpecialWarningSoakCount(466342, nil, nil, nil, 2, 2)
local specWarnEgoCheck								= mod:NewSpecialWarningDefensive(466958, nil, nil, nil, 1, 2)--Ability not seen yet

local timerBBBBlastCD								= mod:NewCDCountTimer(97.3, 1214607, nil, nil, nil, 3)
local timerOverloadedRocketsCD						= mod:NewCDCountTimer(11.5, 1214755, nil, nil, nil, 5)
local timerTickTockCanistersCD						= mod:NewCDCountTimer(97.3, 466342, nil, nil, nil, 3)
local timerEgoCheckCD								= mod:NewCDTimer(97.3, 466958, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)

mod:AddPrivateAuraSoundOption(1226489, true, 1226489, 2)--Overloaded Rockets (sub mechanic to BBBBlast)
--Mythic
mod:AddTimerLine(PLAYER_DIFFICULTY6)
local warnGigaBlastResidue							= mod:NewTargetNoFilterAnnounce(1218504, 2, nil, false)
local warnDischargedGigaBomb						= mod:NewTargetNoFilterAnnounce(1218992, 2)
local warnAutoLockingCuffBomb						= mod:NewTargetNoFilterAnnounce(1220784, 4)
local warnMayhemRockets								= mod:NewCountAnnounce(1218696, 2)

local specWarnCombinationCanisters					= mod:NewSpecialWarningSoakCount(1217987, nil, nil, nil, 2, 2, 4)
local specWarnScatterbombCanisters					= mod:NewSpecialWarningSoakCount(1218488, nil, nil, nil, 2, 2, 4)
local specWarnStaticZap								= mod:NewSpecialWarningInterruptCount(1219041, "HasInterrupt", nil, nil, 1, 2)
local specWarnIonizationDispel						= mod:NewSpecialWarningDispel(1219039, "RemoveMagic", nil, nil, 1, 2)
local specWarnBBBBarrage							= mod:NewSpecialWarningCount(1218546, nil, nil, nil, 2, 2)

local timerCombinationCanistersCD					= mod:NewCDCountTimer(97.3, 1217987, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerScatterbombCanistersCD					= mod:NewCDCountTimer(97.3, 1218488, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerMayhemRockets							= mod:NewCastTimer(5, 1218696, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerBBBBarrageCD								= mod:NewCDCountTimer(97.3, 1218546, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)

--S1
mod.vb.canisterCount = 0
mod.vb.canistersSubCount = 0
mod.vb.bombsCount = 0
mod.vb.bombsSubCount = 0
mod.vb.suppressionCount = 0
mod.vb.suppressionSubCount = 0
mod.vb.heatCount = 0
mod.vb.heatSubCount = 0
--S2
mod.vb.coilsCount = 0
mod.vb.gigaBlastCount = 0
mod.vb.meltdownCount = 0
local castsPerGUID = {}
local addUsedMarks = {}
--S3
mod.vb.egocheckSubCount = 0
--Mythic
mod.vb.mayhemRocketsCount = 0

--For stages, stage 2 and 3 have to be broken down by coils count
--it seems, based on initial data, each coil has a different sequence
local savedDifficulty = "normal"
local allTimers = {
	["mythic"] = {--No idea how many coils mythic is gonna need or if it repeats at a point
		[1] = {
			[469286] = {25.0, 58.1, 58.5, 59.2},--Giga Coils (these variate 58-61
			[469327] = {18.0, 56.0, 62.0, 52.4},--Giga Blast
			[1217987] = {31.0, 28.5, 31.6, 38.3, 25.6, 38.9, 23.8},--Combination Canisters
			[1214607] = {8.0, 58.0, 57.5, 55.5},--BBB Blast
			[467182] = {43.1, 60.4, 64.5},--Supression
			[466751] = {39.6, 16.4, 23.6, 18.3, 22.0, 29.6, 12.0, 23.3, 23.6},--Venting Heat
			[466958] = {16.0, 21.6, 14.6, 19.9, 17.0, 12.4, 16.5, "v23.7-29.6", "v5.5-11.5", 23.8, "v17.1-23.6", 11.6, 12.3},--Ego Check (can exceed 208)
		},
		[2] = {
			[469286] = {157.2},--Giga Coils
			[469327] = {49.5, 56.5, 43.5},--Giga Blast
			[1218488] = {12.5, 42.5, 36.9, 32.5},--Scatterbomb Canisters
			[1218546] = {35.3, 48.0, 54.0},--BBB Barrage
			[467182] = {23.0, 44.0, 44.8},--Suppression
			[466751] = {9.0, 35.0, 19.6, 36.9, 20.4, 25.0},--Venting Heat
			[466958] = {21.0, 26.5, 28.6, 27.9, "v20.5-29.0", 22.0},--Ego Check
		},
		[3] = {
			[469327] = {56.5},--Giga Blast
			[1218488] = {7.5, 37.0, 45.5},--Scatterbomb Canisters
			[1218546] = {25.9, 51.5},--BBB Barrage
			[467182] = {64.1, 34.6},--Suppression
			[466751] = {19.5, 32.5, 20.4},--Venting Heat
			[466958] = {23.0, 39.0, 26.0},--Ego Check
		},
	},
	["heroic"] = {
		[1] = {
			[466340] = {6.5, 17.0, 18.3, 18.9, 16.5, 20.5},--Scatterblast Canisters
			[465952] = {17.9, 35.4, 35.4},--BBBBombs
			[467182] = {31.4, 39.0, 33.6},--Suppression
			[466751] = {12.5, 25.8, 28.4, 27.5},--Venting Heat
		},
		[2] = {
			[469286] = {6, 54.3, 54.3, 54.3, 54.3, 54.3, 54.3},--Giga Coils (always same so no subcounts needed)
			[466341] = {--Fused Canisters
				[0] = {0.000001},--No casts before first coil
				[1] = {10, 32.8},
				[2] = {27.2},
				[3] = {0.000001},
				[4] = {0.000001},
				[5] = {0.000001},
			},
			[465952] = {--BBBBombs
				[0] = {0.000001},--No casts before first coil
				[1] = {34.3},
				[2] = {35.5},
				[3] = {0.000001},
				[4] = {0.000001},
				[5] = {0.000001},
			},
			[467182] = {--Suppression
				[0] = {0.000001},--No casts before first coil
				[1] = {24},
				[2] = {8.8},
				[3] = {0.000001},
				[4] = {7.6, 35.0},
				[5] = {0.000001},
			},
			[466751] = {--Venting Heat
				[0] = {0.000001},--No casts before first coil
				[1] = {20.5},
				[2] = {16.7},
				[3] = {0.000001},
				[4] = {0.000001},
				[5] = {0.000001},
			},
		},
		[3] = {
			[469286] = {60, 59.8, 68},--Giga Coils
			[467182] = {--Suppression
				[0] = {33},
				[1] = {20.3},
				[2] = {7.5, "v37-43"},--37 can shift to 43 due to collision with another spell
				[3] = {31.1},
				[4] = {0.000001},
				[5] = {0.000001},
			},
			[466751] = {--Venting Heat
				[0] = {18},
				[1] = {11.6, 37},
				[2] = {37.4},
				[3] = {"v19.9-26"},--19-26 (Collision with BBB Blast)
				[4] = {0.000001},
				[5] = {0.000001},
			},
			[1214607] = {--BBB Blast
				[0] = {"v5-8", 36},
				[1] = {30.7},
				[2] = {18.5, "v26-35"},--26-35
				[3] = {"v19.7-23.1"},--(Collision with Venting Heat)
				[4] = {0.000001},
				[5] = {0.000001},
			},
			[466342] = {--Tick Tock Canisters
				[0] = {22},
				[1] = {6.6, 35},
				[2] = {26.4},
				[3] = {3.6},
				[4] = {0.000001},
				[5] = {0.000001},
			},
			[466958] = {--Ego Check
				[0] = {14, 13, 15, 8},
				[1] = {15.3, 13.4, 8, 10},
				[2] = {16.4, 8, 9, 26},
				[3] = {10.6, 18.5, 11},
				[4] = {0.000001},
				[5] = {0.000001},
			},
		},
	},
	["normal"] = {
		[1] = {
			[466340] = {7.3, 19, 20.3, 20.9, 18.4, 22.9},--Scatterblast Canisters
			[465952] = {20.2, 39.1, 39.3},--BBBBombs
			[467182] = {34.8, 43.3, 37.4},--Suppression
			[466751] = {13.9, 28.7, 31.5, 30.6},--Venting Heat
		},
		[2] = {
			[469286] = {6, 70.6, 70.6, 70.6, 70.6, 70.6, 70.6},--Giga Coils
			[466341] = {--Fused Canisters
				[0] = {0.000001},--No casts before first coil
				[1] = {12.7, 41.1},
				[2] = {0.000001},
				[3] = {0.000001},
				[4] = {0.000001},
				[5] = {0.000001},
			},
			[465952] = {--BBBBombs
				[0] = {0.000001},--No casts before first coil
				[1] = {41.8},
				[2] = {0.000001},
				[3] = {0.000001},
				[4] = {0.000001},
				[5] = {0.000001},
			},
			[467182] = {--Suppression
				[0] = {0.000001},--No casts before first coil
				[1] = {30},
				[2] = {9.4},
				[3] = {0.000001},
				[4] = {0.000001},
				[5] = {0.000001},
			},
			[466751] = {--Venting Heat
				[0] = {0.000001},--No casts before first coil
				[1] = {25.5},
				[2] = {0.000001},
				[3] = {0.000001},
				[4] = {0.000001},
				[5] = {0.000001},
			},
		},
		[3] = {
			[469286] = {60, 59.9, 65.7, 53.7, 59.5},--Giga Coils
			[467182] = {--Suppression
				[0] = {33},
				[1] = {19.4},
				[2] = {6.5, 37},
				[3] = {31.2},
				[4] = {"v18.7-20.9"},--Collision wth Venting Heat
				[5] = {5.1, 37},
			},
			[466751] = {--Venting Heat
				[0] = {18},
				[1] = {11.5, 36},
				[2] = {37.6},
				[3] = {"v22.5-27.7"},--or 27.7 (collision with BBB Blast. Either one can be cast at 22 and it bumps other to 27)
				[4] = {"v17-26.5"},--Collision with supression
				[5] = {14.1, 37},
			},
			[1214607] = {--BBBBlast
				[0] = {8, 34},
				[1] = {28.5},
				[2] = {15.6, 37},
				[3] = {"v21.7-26"},--21-26 (collision with Venting Heat. Either one can be cast at 22 and it bumps other to 27)
				[4] = {11.4, 34},
				[5] = {30.1},
			},
			[466342] = {--Tick Tock Canisters
				[0] = {22},
				[1] = {6.5, 35},
				[2] = {26.6},
				[3] = {5.6, 35},
				[4] = {31.4},
				[5] = {17.6, 37},
			},
		},
	},
	["lfr"] = {
		[1] = {
			[465952] = {15.3, 31.3},--BBBBombs
			[467182] = {33.3, 31.3},--Suppression
			[466751] = {22.1, 31.3},--Venting Heat
		},
		[2] = {
			[469286] = {0, "v72.7-75.1"},--Giga Coils
			[465952] = {--BBBBombs
				[0] = {0.000001},--No casts before first coil
				[1] = {"v42.9-45"},
				[2] = {0.000001},
				[3] = {0.000001},
				[4] = {0.000001},
				[5] = {0.000001},
			},
			[467182] = {--Suppression
				[0] = {0.000001},--No casts before first coil
				[1] = {"v23.7-25.8", 31.9},
				[2] = {0.000001},
				[3] = {0.000001},
				[4] = {0.000001},
				[5] = {0.000001},
			},
			[466751] = {--Venting Heat
				[0] = {0.000001},--No casts before first coil
				[1] = {"v10.6-12.6", 40.7},
				[2] = {"v9.4-10.1"},
				[3] = {0.000001},
				[4] = {0.000001},
				[5] = {0.000001},
			},
		},
		[3] = {
			[469286] = {"v74.9-83", "v63.4-81.5", "v63.4-81.5", "v63.4-81.5"},--Giga Coils (LFR is a mess, coils are allowed to run overtime, and then it shortens next CD)
			[467182] = {--Suppression
				[0] = {34.2, 32.5},
				[1] = {"v25.2-32.4"},
				[2] = {34, 31.2},--Second one doesn't always happen
				[3] = {"v25.7-35.1", 32.5},
				[4] = {0.000001},
				[5] = {0.000001},
			},
			[466751] = {--Venting Heat
				[0] = {21.7, 31.2},
				[1] = {"v12.7-21.1", 31.2},--All of these have same variance on first cast
				[2] = {"v13.2-21.5", 32.5},--^
				[3] = {"v13.2-22.9", 31.2},--^
				[4] = {0.000001},
				[5] = {0.000001},
			},
			[1214607] = {--BBBBlast
				[0] = {"v21.7-26.1", 33},
				[1] = {"v24.9-33.6"},
				[2] = {"v9-38.2", 37.5},--Boss sometimes skips first cast and just goes right into second. we just handle it with variance
				[3] = {"v17.6-27.2", 33.1},
				[4] = {0.000001},
				[5] = {0.000001},
			},
		},
	},
}

function mod:OnCombatStart(delay)
	table.wipe(castsPerGUID)
	table.wipe(addUsedMarks)
	self.vb.canisterCount = 0
	self.vb.bombsCount = 0
	self.vb.suppressionCount = 0
	self.vb.heatCount = 0
	self.vb.coilsCount = 0
	self.vb.gigaBlastCount = 0
	self.vb.meltdownCount = 0
	--Reset all Subcounts
	self.vb.canistersSubCount = 0
	self.vb.bombsSubCount = 0
	self.vb.suppressionSubCount = 0
	self.vb.heatSubCount = 0
	self.vb.egocheckSubCount = 0
	if self:IsMythic() then
		savedDifficulty = "mythic"
		self.vb.phase = 0
		self:SetStage(0.5)
	else
		self:SetStage(1)
	end
	if not self:IsStory() and not self:IsMythic() then
		if self:IsHeroic() then
			savedDifficulty = "heroic"
			timerPhaseTransition:Start(111, 2)
		elseif self:IsNormal() then
			savedDifficulty = "normal"
			timerPhaseTransition:Start(123, 2)
		else
			savedDifficulty = "lfr"
			--timerPhaseTransition:Start(71, 2)--Seems LFR often triggers health threshold, so don't know timed one
		end
		if not self:IsLFR() then
			timerScatterblastCanistersCD:Start(allTimers[savedDifficulty][1][466340][1]-delay, 1)
		end
		timerBBBBombsCD:Start(allTimers[savedDifficulty][1][465952][1]-delay, 1)
		timerSuppressionCD:Start(allTimers[savedDifficulty][1][467182][1]-delay, 1)
		timerVentingHeatCD:Start(allTimers[savedDifficulty][1][466751][1]-delay, 1)
	end
	self:EnablePrivateAuraSound(466155, "bombyou", 12)
	self:EnablePrivateAuraSound(466344, "gather", 2)
	self:EnablePrivateAuraSound(1219279, "lineyou", 17)
	self:EnablePrivateAuraSound({1226489,1214767,1214750,1214763,1214758,1214765,1214761,1214766,1214749,1214762,1214759,1214764,1214760}, "lineyou", 17)
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:OnTimerRecovery()
	if self:IsMythic() then
		savedDifficulty = "mythic"
	elseif self:IsHeroic() then
		savedDifficulty = "heroic"
	elseif self:IsNormal() then
		savedDifficulty = "normal"
	else
		savedDifficulty = "lfr"
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 466340 then
		self.vb.canisterCount = self.vb.canisterCount + 1
		self.vb.canistersSubCount = self.vb.canistersSubCount + 1
		specWarnScatterblastCanisters:Show(self.vb.canisterCount)
		if self.vb.canisterCount % 2 == 0 then
			specWarnScatterblastCanisters:Play("sharetwo")
		else
			specWarnScatterblastCanisters:Play("shareone")
		end
		if self:IsStory() then return end--hard disable timers in story mode
		local timer
		if self:GetStage(1) then--No coils yet, NOT used on mythic
			--timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.canistersSubCount+1)
			timer = allTimers[savedDifficulty][self.vb.phase][spellId][self.vb.canistersSubCount+1]
		else
			--timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.coilsCount, self.vb.canistersSubCount+1)
			timer = allTimers[savedDifficulty][self.vb.phase][spellId][self.vb.coilsCount][self.vb.canistersSubCount+1]
		end
		if timer and timer ~= 0 then
			timerScatterblastCanistersCD:Start(timer, self.vb.canisterCount+1)
		elseif not self:IsMythic() and self.vb.coilsCount > 0 and not allTimers[savedDifficulty][self.vb.phase][spellId][self.vb.coilsCount][self.vb.canistersSubCount] then
			DBM:AddMsg("Scatterblast Canister timer not found for coil count "..self.vb.coilsCount.." "..self.vb.canistersSubCount .. " Please report to DBM authors with a lot of this pull")
			DBM:Debug("Scatterblast Canister timer not found for coil count "..self.vb.coilsCount.." "..self.vb.canistersSubCount .. " Please report to DBM authors with a lot of this pull")
		end
	--elseif spellId == 465952 then
	--	self.vb.bombsCount = self.vb.bombsCount + 1
	--	specWarnBBBBombs:Show(self.vb.bombsCount)
	--	specWarnBBBBombs:Play("bombsoon")
	--	timerBBBBombsCD:Start()--nil, self.vb.bombsCount+1
	elseif spellId == 467182 then
		self.vb.suppressionCount = self.vb.suppressionCount + 1
		self.vb.suppressionSubCount = self.vb.suppressionSubCount + 1
		specWarnSupression:Show(self.vb.suppressionCount)
		specWarnSupression:Play("watchstep")
		if self:IsStory() then return end--hard disable timers in story mode
		if self:GetStage(3) or self:IsMythic() then
			timerFinalBlast:Start(6, self.vb.suppressionCount)
		end
		local timer
		if self:GetStage(1) or self:IsMythic() then--No coils yet or is mythic
			--timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.suppressionSubCount+1)
			timer = allTimers[savedDifficulty][self.vb.phase][spellId][self.vb.suppressionSubCount+1]
		else
			--timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.coilsCount, self.vb.suppressionSubCount+1)
			timer = allTimers[savedDifficulty][self.vb.phase][spellId][self.vb.coilsCount][self.vb.suppressionSubCount+1]
		end
		if timer and timer ~= 0 then
			timerSuppressionCD:Start(timer, self.vb.suppressionCount+1)
		elseif not self:IsMythic() and self.vb.coilsCount > 0 and not allTimers[savedDifficulty][self.vb.phase][spellId][self.vb.coilsCount][self.vb.suppressionSubCount] then
			DBM:AddMsg("Suppression timer not found for coil count "..self.vb.coilsCount.." "..self.vb.suppressionSubCount .. " Please report to DBM authors with a lot of this pull")
			DBM:Debug("Suppression timer not found for coil count "..self.vb.coilsCount.." "..self.vb.suppressionSubCount .. " Please report to DBM authors with a lot of this pull")
		end
	elseif spellId == 466751 then
		self.vb.heatCount = self.vb.heatCount + 1
		self.vb.heatSubCount = self.vb.heatSubCount + 1
		warnVentingHeat:Show(self.vb.heatCount)
		if self:IsStory() then return end--hard disable timers in story mode
		local timer
		if self:GetStage(1) or self:IsMythic() then--No coils yet or is mythic
			--timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.heatSubCount+1)
			timer = allTimers[savedDifficulty][self.vb.phase][spellId][self.vb.heatSubCount+1]
		else
			--timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.coilsCount, self.vb.heatSubCount+1)
			timer = allTimers[savedDifficulty][self.vb.phase][spellId][self.vb.coilsCount][self.vb.heatSubCount+1]
		end
		if timer and timer ~= 0 then
			timerVentingHeatCD:Start(timer, self.vb.heatCount+1)
		elseif not self:IsMythic() and self.vb.coilsCount > 0 and not allTimers[savedDifficulty][self.vb.phase][spellId][self.vb.coilsCount][self.vb.heatSubCount] then
			DBM:AddMsg("Venting Heat timer not found for coil count "..self.vb.coilsCount.." "..self.vb.heatSubCount .. " Please report to DBM authors with a lot of this pull")
			DBM:Debug("Venting Heat timer not found for coil count "..self.vb.coilsCount.." "..self.vb.heatSubCount .. " Please report to DBM authors with a lot of this pull")
		end
	elseif spellId == 469286 then
		DBM:AddMsg("Giga Coils added to combat log, please report to DBM authors")
	elseif spellId == 469327 then
		self.vb.gigaBlastCount = self.vb.gigaBlastCount + 1
		warnGigaBlast:Show(self.vb.gigaBlastCount)
		if self:IsStory() then return end--hard disable timers in story mode
		if self:IsMythic() then
			local timer = allTimers[savedDifficulty][self.vb.phase][spellId][self.vb.gigaBlastCount+1]
			if timer and timer ~= 0 then
				timerGigaBlastCD:Start(timer, self.vb.gigaBlastCount+1)
			end
		else
			timerGigaBlastCD:Start(nil, self.vb.gigaBlastCount+1)
		end
	elseif spellId == 466341 then
		self.vb.canisterCount = self.vb.canisterCount + 1
		self.vb.canistersSubCount = self.vb.canistersSubCount + 1
		warnFusedCanisters:Show(self.vb.canisterCount)
		if self:IsStory() then return end--hard disable timers in story mode
		local timer
		if self:GetStage(1) or self:IsMythic() then--No coils yet or is mythic
			--timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.canistersSubCount+1)
			timer = allTimers[savedDifficulty][self.vb.phase][spellId][self.vb.canistersSubCount+1]
		else
			--timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.coilsCount, self.vb.canistersSubCount+1)
			timer = allTimers[savedDifficulty][self.vb.phase][spellId][self.vb.coilsCount][self.vb.canistersSubCount+1]
		end
		if timer and timer ~= 0 then
			timerFusedCanistersCD:Start(timer, self.vb.canisterCount+1)
		elseif not self:IsMythic() and self.vb.coilsCount > 0 and not allTimers[savedDifficulty][self.vb.phase][spellId][self.vb.coilsCount][self.vb.canistersSubCount] then
			DBM:AddMsg("Fused Canister timer not found for coil count "..self.vb.coilsCount.." "..self.vb.canistersSubCount .. " Please report to DBM authors with a lot of this pull")
			DBM:Debug("Fused Canister timer not found for coil count "..self.vb.coilsCount.." "..self.vb.canistersSubCount .. " Please report to DBM authors with a lot of this pull")
		end
	elseif spellId == 466834 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnShockBarrage:Show(args.sourceName, count)
			if count == 1 then
				specWarnShockBarrage:Play("kick1r")
			elseif count == 2 then
				specWarnShockBarrage:Play("kick2r")
			elseif count == 3 then
				specWarnShockBarrage:Play("kick3r")
			elseif count == 4 then
				specWarnShockBarrage:Play("kick4r")
			elseif count == 5 then
				specWarnShockBarrage:Play("kick5r")
			else
				specWarnShockBarrage:Play("kickcast")
			end
		end
	elseif spellId == 1219041 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnStaticZap:Show(args.sourceName, count)
			if count == 1 then
				specWarnStaticZap:Play("kick1r")
			elseif count == 2 then
				specWarnStaticZap:Play("kick2r")
			elseif count == 3 then
				specWarnStaticZap:Play("kick3r")
			elseif count == 4 then
				specWarnStaticZap:Play("kick4r")
			elseif count == 5 then
				specWarnStaticZap:Play("kick5r")
			else
				specWarnStaticZap:Play("kickcast")
			end
		end
	elseif spellId == 1216845 then
		if self:IsTanking("player",nil, nil, true, args.sourceGUID) then
			specWarnWrench:Show()
			specWarnWrench:Play("defensive")
		end
		timerWrenchCD:Start(nil, args.sourceGUID)
	--elseif spellId == 1216852 then
		--timerEnrageCD:Start(nil, args.destGUID)
	elseif spellId == 1214607 then
		self.vb.bombsCount = self.vb.bombsCount + 1
		self.vb.bombsSubCount = self.vb.bombsSubCount + 1
		specWarnBBBBlast:Show(self.vb.bombsCount)
		timerOverloadedRocketsCD:Start(12.5, self.vb.bombsCount)
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnBBBBlast:Play("defensive")
			specWarnBBBBlast:ScheduleVoice(1.5, "runout")
		else
			specWarnBBBBlast:Play("bombsoon")
		end
		if self:IsStory() then return end--hard disable timers in story mode
		local timer
		if self:GetStage(1) or self:IsMythic() then--No coils yet or is mythic
			--timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.bombsSubCount+1)
			timer = allTimers[savedDifficulty][self.vb.phase][spellId][self.vb.bombsSubCount+1]
		else
			--timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.coilsCount, self.vb.bombsSubCount+1)
			timer = allTimers[savedDifficulty][self.vb.phase][spellId][self.vb.coilsCount][self.vb.bombsSubCount+1]
		end
		if timer and timer ~= 0 then
			timerBBBBlastCD:Start(timer, self.vb.bombsCount+1)
		elseif not self:IsMythic() and self.vb.coilsCount > 0 and not allTimers[savedDifficulty][self.vb.phase][spellId][self.vb.coilsCount][self.vb.bombsSubCount] then
			DBM:AddMsg("BBB Blast timer not found for coil count "..self.vb.coilsCount.." "..self.vb.bombsSubCount .. " Please report to DBM authors with a lot of this pull")
			DBM:Debug("BBB Blast timer not found for coil count "..self.vb.coilsCount.." "..self.vb.bombsSubCount .. " Please report to DBM authors with a lot of this pull")
		end
	elseif spellId == 466342 then
		self.vb.canisterCount = self.vb.canisterCount + 1
		self.vb.canistersSubCount = self.vb.canistersSubCount + 1
		specWarnTickTockCanisters:Show(self.vb.canisterCount)
		specWarnTickTockCanisters:Play("helpsoak")
		if self:IsStory() then return end--hard disable timers in story mode
		local timer
		if self:GetStage(1) or self:IsMythic() then--No coils yet or is mythic
			--timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.canistersSubCount+1)
			timer = allTimers[savedDifficulty][self.vb.phase][spellId][self.vb.canistersSubCount+1]
		else
			--timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.coilsCount, self.vb.canistersSubCount+1)
			timer = allTimers[savedDifficulty][self.vb.phase][spellId][self.vb.coilsCount][self.vb.canistersSubCount+1]
		end
		if timer and timer ~= 0 then
			timerTickTockCanistersCD:Start(timer, self.vb.canisterCount+1)
		elseif not self:IsMythic() and self.vb.coilsCount > 0 and not allTimers[savedDifficulty][self.vb.phase][spellId][self.vb.coilsCount][self.vb.canistersSubCount] then
			DBM:AddMsg("Tick Tock Canister timer not found for coil count "..self.vb.coilsCount.." "..self.vb.canistersSubCount .. " Please report to DBM authors with a lot of this pull")
			DBM:Debug("Tick Tock Canister timer not found for coil count "..self.vb.coilsCount.." "..self.vb.canistersSubCount .. " Please report to DBM authors with a lot of this pull")
		end
	elseif spellId == 466958 then
		self.vb.egocheckSubCount = self.vb.egocheckSubCount + 1
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnEgoCheck:Show()
			specWarnEgoCheck:Play("defensive")
		end
		if self:IsStory() then return end--hard disable timers in story mode
		--Only cast in stage 3 (or stage 1 mythic) so doesn't need stage check
		local timer
		if self:IsMythic() then
			--timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.egoCheckSubCount+1)
			timer = allTimers[savedDifficulty][self.vb.phase][spellId][self.vb.egocheckSubCount+1]
		else
			--timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.coilsCount, self.vb.egoCheckSubCount+1)
			timer = allTimers[savedDifficulty][self.vb.phase][spellId][self.vb.coilsCount][self.vb.egocheckSubCount+1]
		end
		if timer and timer ~= 0 then
			timerEgoCheckCD:Start(timer)
		elseif not self:IsMythic() and self.vb.coilsCount > 0 and not allTimers[savedDifficulty][self.vb.phase][spellId][self.vb.coilsCount][self.vb.egocheckSubCount] then
			DBM:AddMsg("Ego Check timer not found for coil count "..self.vb.coilsCount.." "..self.vb.egocheckSubCount .. " Please report to DBM authors with a lot of this pull")
			DBM:Debug("Ego Check timer not found for coil count "..self.vb.coilsCount.." "..self.vb.egocheckSubCount .. " Please report to DBM authors with a lot of this pull")
		end
	elseif spellId == 1217987 then
		self.vb.canisterCount = self.vb.canisterCount + 1
		self.vb.canistersSubCount = self.vb.canistersSubCount + 1
		specWarnCombinationCanisters:Show(self.vb.canisterCount)
		specWarnCombinationCanisters:Play("helpsoak")
		--local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.coilsCount, self.vb.canistersSubCount+1)
		local timer = allTimers[savedDifficulty][self.vb.phase][spellId][self.vb.canistersSubCount+1]
		if timer and timer ~= 0 then
			timerCombinationCanistersCD:Start(timer, self.vb.canisterCount+1)
		elseif not allTimers[savedDifficulty][self.vb.phase][spellId][self.vb.canistersSubCount] then
			DBM:AddMsg("Combined Canister timer not found for coil count "..self.vb.canistersSubCount .. " Please report to DBM authors with a lot of this pull")
			DBM:Debug("Combined Canister timer not found for coil count "..self.vb.canistersSubCount .. " Please report to DBM authors with a lot of this pull")
		end
	elseif spellId == 1218488 then
		self.vb.canisterCount = self.vb.canisterCount + 1
		self.vb.canistersSubCount = self.vb.canistersSubCount + 1
		specWarnScatterbombCanisters:Show(self.vb.canisterCount)
		specWarnScatterbombCanisters:Play("helpsoak")
		local timer = allTimers[savedDifficulty][self.vb.phase][spellId][self.vb.canistersSubCount+1]
		if timer and timer ~= 0 then
			timerScatterbombCanistersCD:Start(timer, self.vb.canisterCount+1)
		elseif not allTimers[savedDifficulty][self.vb.phase][spellId][self.vb.canistersSubCount] then
			DBM:AddMsg("Scatterbomb Canister timer not found for"..self.vb.canistersSubCount .. " Please report to DBM authors with a lot of this pull")
			DBM:Debug("Scatterbomb Canister timer not found for "..self.vb.canistersSubCount .. " Please report to DBM authors with a lot of this pull")
		end
	elseif spellId == 1218696 then
		self.vb.mayhemRocketsCount = self.vb.mayhemRocketsCount + 1
		warnMayhemRockets:Show(self.vb.mayhemRocketsCount)
		timerMayhemRockets:Start(nil, self.vb.mayhemRocketsCount+1)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 1216846 then
		--timerWrenchCD:Start(nil, args.destGUID)
		--timerEnrageCD:Start(nil, args.destGUID)
	--elseif spellId == 1216852 then
	--	warnEnrage:Show(args.destName)
	elseif spellId == 1214229 then--Armageddon-class Plating
		local _, _, _, startTime, endTime = UnitChannelInfo("boss1")
		local time = ((endTime or 0) - (startTime or 0)) / 1000
		timerTotalDestruction:Start(time)
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(args.spellName)
			local uId = DBM:GetUnitIdFromGUID(args.destGUID, true)
			DBM.InfoFrame:Show(2, "enemyabsorb", nil, args.amount, uId)
		end
		if self:GetStage(2) and not self:IsMythic() then
			self:SetStage(2.5)
			warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2.5))
			warnPhase:Play("phasechange")
			--Stop Timers
			timerGigaCoilsCD:Stop()
			timerFusedCanistersCD:Stop()
			timerBBBBombsCD:Stop()
			timerSuppressionCD:Stop()
			timerGigaBlastCD:Stop()
			timerTickTockCanistersCD:Stop()
			timerVentingHeatCD:Stop()
		end
	elseif spellId == 1214369 then
		local _, _, _, startTime, endTime = UnitChannelInfo("boss1")
		local time = ((endTime or 0) - (startTime or 0)) / 1000
		timerTotalDestruction:Start(time)
	elseif spellId == 466165 then
		timer1500PoundDudCast:Start(nil, args.destGUID)
	elseif spellId == 1216444 and not args:IsPlayer() then
		specWarnBBBBlastTaunt:Show(args.destName)
		specWarnBBBBlastTaunt:Play("tauntboss")
	elseif spellId == 1218504 then
		warnGigaBlastResidue:CombinedShow(0.3, args.destName)
	elseif spellId == 1219039 and self:CheckDispelFilter("magic") then
		specWarnIonizationDispel:CombinedShow(0.5, args.destName)
		specWarnIonizationDispel:ScheduleVoice(0.5, "helpdispel")
	elseif spellId == 1220784 then
		warnAutoLockingCuffBomb:Show(args.destName)
	elseif spellId == 469362 then
		warnChargedGigaBomb:Show(args.destName)
		if args:IsPlayer() then
			specChargedGigaBomb:Show()
			specChargedGigaBomb:Play("targetyou")
		end
	elseif spellId == 1218992 or spellId == 1218991 then--Heroic vs non heroic probably
		warnDischargedGigaBomb:Show(args.destName)
	elseif spellId == 1220846 then
		self.vb.meltdownCount = self.vb.meltdownCount + 1
		timerControlMeltdownCD:Start(15, self.vb.meltdownCount)
	elseif spellId == 466246 then
		if args:IsPlayer() then
			warnFocusedDetonation:Show(args.amount or 1)
		end
		timerTimeReleasedCackler:Stop(args.destName)
		timerTimeReleasedCackler:Start(10, args.destName)
	elseif spellId == 471603 and not args:IsPlayer() then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			specWarnScatterblastCanistersTaunt:Show(args.destName)
			specWarnScatterblastCanistersTaunt:Play("tauntboss")
		end
	elseif spellId == 469293 and not self:IsMythic() then--Giga Coils Starting
		self.vb.gigaBlastCount = 0
		timerGigaBlastCD:Start(2, 1)
	elseif spellId == 469387 then--Carrying Bomb
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
			if self.Options.SetIconOnTechnician then--Set only icons 8-6
				for i = 8, 3, -1 do
					if not addUsedMarks[i] then
						addUsedMarks[i] = args.destGUID
						self:ScanForMobs(args.destGUID, 2, i, 1, nil, 12, "SetIconOnTechnician")
						break
					end
				end
			end
		end
	elseif spellId == 1226891 and self:AntiSpam(3, 1) then--Circuit Reboot Applied (1219062 is lfr id)
		self:SetStage(0.5)--Increment stage by 0.5
		self.vb.mayhemRocketsCount = 0
		--Stop all timers
		timerGigaCoilsCD:Stop()
		timerFusedCanistersCD:Stop()
		timerBBBBombsCD:Stop()
		timerSuppressionCD:Stop()
		timerGigaBlastCD:Stop()
		timerTickTockCanistersCD:Stop()
		timerVentingHeatCD:Stop()
		timerEgoCheckCD:Stop()
		timerCombinationCanistersCD:Stop()
		timerScatterbombCanistersCD:Stop()
		timerControlMeltdownCD:Stop()
		timerMayhemRockets:Stop()
		timerFinalBlast:Stop()
		timerBBBBarrageCD:Stop()
		timerOverloadedRocketsCD:Stop()
		if self:GetStage(1.5) then
			warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(1.5))
			warnPhase:Play("phasechange")
			timerPhaseTransition:Start(33, 2)
		else
			warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2.5))
			warnPhase:Play("phasechange")
			timerPhaseTransition:Start(31, 3)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 1214229 then
		specWarnTotalDestructionInterrupt:Show(args.destName)
		specWarnTotalDestructionInterrupt:Play("kickcast")
		if self.Options.InfoFrame then--Armageddon-class Plating
			DBM.InfoFrame:Hide()
		end
	elseif spellId == 1214369 and self:AntiSpam(8, 3) then--Backup stage 3/1 mythic trigger
		timerTotalDestruction:Stop()
		if self:IsMythic() then
			self:SetStage(0.5)--Stage should be 0.5 at this point, but this also future proofs race condition when overgearing where you might push boss to stage 2 at same time
			warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(1))
			warnPhase:Play("pone")
			timerGigaCoilsCD:Start(allTimers[savedDifficulty][1][469286][1], 1)
			timerGigaBlastCD:Start(allTimers[savedDifficulty][1][469327][1], 1)
			timerCombinationCanistersCD:Start(allTimers[savedDifficulty][1][1217987][1], 1)
			timerBBBBlastCD:Start(allTimers[savedDifficulty][1][1214607][1], 1)
			timerSuppressionCD:Start(allTimers[savedDifficulty][1][467182][1], 1)
			timerEgoCheckCD:Start(allTimers[savedDifficulty][1][466958][1], 1)
			timerVentingHeatCD:Start(allTimers[savedDifficulty][1][466751][1], 1)
			timerPhaseTransition:Start(208.7, 1.5)
		else
			self:SetStage(3)
			warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(3))
			warnPhase:Play("pthree")
			--Reset Counts
			self.vb.canisterCount = 0
			self.vb.bombsCount = 0
			self.vb.suppressionCount = 0
			self.vb.coilsCount = 0
			self.vb.heatCount = 0
			self.vb.gigaBlastCount = 0
			--Reset all Subcounts
			self.vb.canistersSubCount = 0
			self.vb.bombsSubCount = 0
			self.vb.suppressionSubCount = 0
			self.vb.heatSubCount = 0
			self.vb.egocheckSubCount = 0
			--Stage 3 timers
			timerGigaCoilsCD:Start(allTimers[savedDifficulty][3][469286][1], 1)
			timerSuppressionCD:Start(allTimers[savedDifficulty][3][467182][0][1], 1)
			timerBBBBlastCD:Start(allTimers[savedDifficulty][3][1214607][0][1], 1)
			if not self:IsLFR() then
				timerTickTockCanistersCD:Start(allTimers[savedDifficulty][3][466342][0][1], 1)
			end
			timerVentingHeatCD:Start(allTimers[savedDifficulty][3][466751][0][1], 1)
			if self:IsHard() then
				timerEgoCheckCD:Start(allTimers[savedDifficulty][3][466958][0][1], 1)
			end
		end
	elseif spellId == 466165 then
		timer1500PoundDudCast:Stop(args.destGUID)
	elseif spellId == 466246 then
		timerTimeReleasedCackler:Stop(args.destName)
	elseif spellId == 1220290 and self:IsInCombat() and not self:IsMythic() then--Trick shots falling off boss
		if self:GetStage(1) then
			self:SetStage(2)
			warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2))
			warnPhase:Play("ptwo")
			--Reset Counts
			self.vb.canisterCount = 0
			self.vb.bombsCount = 0
			self.vb.suppressionCount = 0
			self.vb.heatCount = 0
			--Reset all Subcounts
			self.vb.canistersSubCount = 0
			self.vb.bombsSubCount = 0
			self.vb.suppressionSubCount = 0
			self.vb.heatSubCount = 0
			self.vb.egocheckSubCount = 0
			timerScatterblastCanistersCD:Stop()
			timerBBBBombsCD:Stop()
			timerSuppressionCD:Stop()
			timerVentingHeatCD:Stop()
			--Start all timers as stage 2 count 1 subcount 1
			timerGigaCoilsCD:Start(allTimers[savedDifficulty][2][469286][1], 1)--coils don't have subcounts
			timerBBBBombsCD:Start(allTimers[savedDifficulty][2][465952][0][1], 1)
			timerSuppressionCD:Start(allTimers[savedDifficulty][2][467182][0][1], 1)
			if not self:IsLFR() then
				timerFusedCanistersCD:Start(allTimers[savedDifficulty][2][466341][0][1], 1)
			end
			timerVentingHeatCD:Start(allTimers[savedDifficulty][2][466751][0][1], 1)
		end
	elseif spellId == 469293 and not self:IsMythic() then--Giga Coils Ending
		timerGigaBlastCD:Stop()
		--Reset all Subcounts
		self.vb.canistersSubCount = 0
		self.vb.bombsSubCount = 0
		self.vb.suppressionSubCount = 0
		self.vb.heatSubCount = 0
		self.vb.egocheckSubCount = 0
		--Stop all timers
		timerGigaCoilsCD:Stop()
		timerFusedCanistersCD:Stop()
		timerBBBBombsCD:Stop()
		timerSuppressionCD:Stop()
		timerTickTockCanistersCD:Stop()
		timerVentingHeatCD:Stop()
		timerEgoCheckCD:Stop()
		if self:GetStage(2) then
			timerGigaCoilsCD:Start(allTimers[savedDifficulty][2][469286][1], self.vb.coilsCount+1)
			timerBBBBombsCD:Start(allTimers[savedDifficulty][2][465952][self.vb.coilsCount][1], self.vb.bombsCount+1)
			timerSuppressionCD:Start(allTimers[savedDifficulty][2][467182][self.vb.coilsCount][1], self.vb.suppressionCount+1)
			if not self:IsLFR() then
				timerFusedCanistersCD:Start(allTimers[savedDifficulty][2][466341][self.vb.coilsCount][1], self.vb.canisterCount+1)
			end
			timerVentingHeatCD:Start(allTimers[savedDifficulty][2][466751][self.vb.coilsCount][1], self.vb.heatCount+1)
		else--Stage 3
			timerGigaCoilsCD:Start(allTimers[savedDifficulty][3][469286][1], self.vb.coilsCount+1)
			timerSuppressionCD:Start(allTimers[savedDifficulty][3][467182][self.vb.coilsCount][1], self.vb.suppressionCount+1)
			timerBBBBlastCD:Start(allTimers[savedDifficulty][3][1214607][self.vb.coilsCount][1], self.vb.bombsCount+1)
			if not self:IsLFR() then
				timerTickTockCanistersCD:Start(allTimers[savedDifficulty][3][466342][self.vb.coilsCount][1], self.vb.canisterCount+1)
			end
			timerVentingHeatCD:Start(allTimers[savedDifficulty][3][466751][self.vb.coilsCount][1], self.vb.heatCount+1)
			if self:IsHard() then
				timerEgoCheckCD:Start(allTimers[savedDifficulty][3][466958][self.vb.coilsCount][1])
			end
		end
	elseif spellId == 1226891 and self:IsInCombat() and self:AntiSpam(3, 2) then--Circuit Reboot Removed (1219062 is lfr id)
		self:SetStage(0.5)--Increment stage by 0.5
		--Reset Counts
		self.vb.canisterCount = 0
		self.vb.bombsCount = 0
		self.vb.suppressionCount = 0
		self.vb.heatCount = 0
		self.vb.coilsCount = 0
		self.vb.gigaBlastCount = 0
		--Reset all Subcounts
		self.vb.canistersSubCount = 0
		self.vb.bombsSubCount = 0
		self.vb.suppressionSubCount = 0
		self.vb.heatSubCount = 0
		self.vb.egocheckSubCount = 0
		if self:GetStage(2) then
			warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2))
			warnPhase:Play("ptwo")
			timerGigaCoilsCD:Start(allTimers[savedDifficulty][2][469286][1], 1)
			timerGigaBlastCD:Start(allTimers[savedDifficulty][2][469327][1], 1)
			timerScatterbombCanistersCD:Start(allTimers[savedDifficulty][2][1218488][1], 1)
			timerBBBBarrageCD:Start(allTimers[savedDifficulty][2][1218546][1], 1)
			timerSuppressionCD:Start(allTimers[savedDifficulty][2][467182][1], 1)
			timerEgoCheckCD:Start(allTimers[savedDifficulty][2][466958][1], 1)
			timerVentingHeatCD:Start(allTimers[savedDifficulty][2][466751][1], 1)
			timerPhaseTransition:Start(167.1, 2.5)
		else--Stage 3
			warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(3))
			warnPhase:Play("pthree")
			timerGigaBlastCD:Start(allTimers[savedDifficulty][3][469327][1], 1)
			timerScatterbombCanistersCD:Start(allTimers[savedDifficulty][3][1218488][1], 1)
			timerBBBBarrageCD:Start(allTimers[savedDifficulty][3][1218546][1], 1)
			timerSuppressionCD:Start(allTimers[savedDifficulty][3][467182][1], 1)
			timerEgoCheckCD:Start(allTimers[savedDifficulty][3][466958][1], 1)
			timerVentingHeatCD:Start(allTimers[savedDifficulty][3][466751][1], 1)
		end
	end
end

function mod:SPELL_INTERRUPT(args)
	if args.extraSpellId == 466834 then
		timerShockBarrageCast:Stop(args.destGUID)
	elseif args.extraSpellId == 1214369 and self:AntiSpam(8, 3) then
		timerTotalDestruction:Stop()
		if self:IsMythic() then
			self:SetStage(0.5)--Stage should be 0.5 at this point, but this also future proofs race condition when overgearing where you might push boss to stage 2 at same time
			warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(1))
			warnPhase:Play("pone")
			timerGigaCoilsCD:Start(allTimers[savedDifficulty][1][469286][1], 1)
			timerGigaBlastCD:Start(allTimers[savedDifficulty][1][469327][1], 1)
			timerCombinationCanistersCD:Start(allTimers[savedDifficulty][1][1217987][1], 1)
			timerBBBBlastCD:Start(allTimers[savedDifficulty][1][1214607][1], 1)
			timerSuppressionCD:Start(allTimers[savedDifficulty][1][467182][1], 1)
			timerEgoCheckCD:Start(allTimers[savedDifficulty][1][466958][1], 1)
			timerVentingHeatCD:Start(allTimers[savedDifficulty][1][466751][1], 1)
			timerPhaseTransition:Start(208.7, 1.5)
		else
			self:SetStage(3)
			warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(3))
			warnPhase:Play("pthree")
			--Reset Counts
			self.vb.canisterCount = 0
			self.vb.bombsCount = 0
			self.vb.suppressionCount = 0
			self.vb.coilsCount = 0
			self.vb.heatCount = 0
			self.vb.gigaBlastCount = 0
			--Reset all Subcounts
			self.vb.canistersSubCount = 0
			self.vb.bombsSubCount = 0
			self.vb.suppressionSubCount = 0
			self.vb.heatSubCount = 0
			self.vb.egocheckSubCount = 0
			--Stage 3 timers
			timerGigaCoilsCD:Start(allTimers[savedDifficulty][3][469286][1], 1)
			timerSuppressionCD:Start(allTimers[savedDifficulty][3][467182][0][1], 1)
			timerBBBBlastCD:Start(allTimers[savedDifficulty][3][1214607][0][1], 1)
			if not self:IsLFR() then
				timerTickTockCanistersCD:Start(allTimers[savedDifficulty][3][466342][0][1], 1)
			end
			timerVentingHeatCD:Start(allTimers[savedDifficulty][3][466751][0][1], 1)
			if self:IsHard() then
				timerEgoCheckCD:Start(allTimers[savedDifficulty][3][466958][0][1], 1)
			end
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 1215209 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 231977 or cid == 237192 then--Darkfuse Technician / Giga-Juiced Technician
		for i = 8, 3, -1 do
			if addUsedMarks[i] == args.destGUID then
				addUsedMarks[i] = nil
				return
			end
		end
		if cid == 237192 then--Giga-Juiced Technician
			--timerIonizationCD:Stop(args.destGUID)
		end
	elseif cid == 231978 then--Sharpshot Sentry
		timerShockBarrageCast:Stop(args.destGUID)
	elseif cid == 231939 then --Darkfuse Wrenchmonger
		timerWrenchCD:Stop(args.destGUID)
		--timerEnrageCD:Stop(args.destGUID)
	end
end

--"<20.27 08:39:20> [CHAT_MSG_RAID_BOSS_EMOTE] |TInterface\\ICONS\\Ships_ABILITY_Bombers.BLP:20|t %s begins to cast |cFFFF0000|Hspell:465952|h[Big Bad Buncha Bombs]|h|r!#Chrome King Gallywix#####0#0##0#2735#nil#0#false#false#false#false",
--"<22.38 08:39:22> [CLEU] SPELL_CAST_START#Vehicle-0-3772-2769-360-231075-00004950E9#Chrome King Gallywix(91.1%-18.0%)##nil#465952#Big Bad Buncha Bombs#nil#nil#nil#nil#nil#nil",
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find("spell:1214222") or msg:find("spell:1214217") or msg:find("spell:1214226") then
		specWarnCratering:Show()
		specWarnCratering:Play("watchstep")
	elseif msg:find("spell:465952") then--Emote 2 seconds faster than CLEU
		self.vb.bombsCount = self.vb.bombsCount + 1
		self.vb.bombsSubCount = self.vb.bombsSubCount + 1
		specWarnBBBBombs:Show(self.vb.bombsCount)
		specWarnBBBBombs:Play("bombsoon")
		if self:IsStory() then return end--hard disable timers in story mode
		local timer
		if self:GetStage(1) or self:IsMythic() then--No coils yet or is mythic
			--timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 465952, self.vb.bombsSubCount+1)
			timer = allTimers[savedDifficulty][self.vb.phase][465952][self.vb.bombsSubCount+1]
		else
			--timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 465952, self.vb.coilsCount, self.vb.bombsSubCount+1)
			timer = allTimers[savedDifficulty][self.vb.phase][465952][self.vb.coilsCount][self.vb.bombsSubCount+1]
		end
		if timer and timer ~= 0 then
			timerBBBBombsCD:Start(timer, self.vb.bombsCount+1)
		end
	elseif msg:find("spell:1218546") then--Emote 2 seconds faster than CLEU
		self.vb.bombsCount = self.vb.bombsCount + 1
		self.vb.bombsSubCount = self.vb.bombsSubCount + 1
		specWarnBBBBarrage:Show(self.vb.bombsCount)
		specWarnBBBBarrage:Play("bombsoon")
		timerOverloadedRocketsCD:Start(13.5, self.vb.bombsCount)--cast time plus emote 2 sec early warn plus 8.5
		local timer = allTimers[savedDifficulty][self.vb.phase][1218546][self.vb.bombsSubCount+1]
		if timer and timer ~= 0 then
			timerBBBBarrageCD:Start(timer, self.vb.bombsCount+1)
		end
	end
end

function mod:UNIT_SPELLCAST_START(_, _, spellId)
	if spellId == 469286 then
		if self:GetStage(1) and not self:IsMythic() and not self:IsStory() then--LFR backup
			self:SetStage(2)
			warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2))
			warnPhase:Play("ptwo")
			--Reset Counts
			self.vb.canisterCount = 0
			self.vb.bombsCount = 0
			self.vb.suppressionCount = 0
			self.vb.heatCount = 0
			--Reset all Subcounts
			self.vb.canistersSubCount = 0
			self.vb.bombsSubCount = 0
			self.vb.suppressionSubCount = 0
			self.vb.heatSubCount = 0
			self.vb.egocheckSubCount = 0
			timerScatterblastCanistersCD:Stop()
			timerBBBBombsCD:Stop()
			timerSuppressionCD:Stop()
			timerVentingHeatCD:Stop()
			--Start all timers as stage 2 count 1 subcount 1, all timers subtracking 4 since this triggers 4 seconds after non LFR phase trigger
			--timerGigaCoilsCD:Start(allTimers[savedDifficulty][2][469286][1] - 4, 1)--coils don't have subcounts
			timerBBBBombsCD:Start(allTimers[savedDifficulty][2][465952][0][1] - 4, 1)
			timerSuppressionCD:Start(allTimers[savedDifficulty][2][467182][0][1] - 4, 1)
			if not self:IsLFR() then
				timerFusedCanistersCD:Start(allTimers[savedDifficulty][2][466341][0][1] - 4, 1)
			end
			timerVentingHeatCD:Start(allTimers[savedDifficulty][2][466751][0][1] - 4, 1)
		end
		self.vb.coilsCount = self.vb.coilsCount + 1
		warnGigaCoils:Show(self.vb.coilsCount)
		if self:IsMythic() then
			local timer = allTimers[savedDifficulty][self.vb.phase][spellId][self.vb.coilsCount+1]
			if timer and timer ~= 0 then
				timerGigaCoilsCD:Start(timer, self.vb.coilsCount+1)
			end
		end
	end
end
