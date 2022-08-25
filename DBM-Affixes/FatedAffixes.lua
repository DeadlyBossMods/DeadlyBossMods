local mod	= DBM:NewMod("FatedAffixes", "DBM-Affixes")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(47785)
mod:SetZone(2296, 2450, 2481)--Shadowlands Raids

mod.isTrashMod = true
mod.isTrashModBossFightAllowed = true

mod:RegisterEvents(
	"SPELL_CAST_START 372638",
	"SPELL_CAST_SUCCESS 372634",
	"SPELL_SUMMON 371254",
	"SPELL_AURA_APPLIED 369505 371447 371597 372286",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 369505 372286",
--	"SPELL_DAMAGE",
--	"SPELL_MISSED",
	"ENCOUNTER_START",
	"ENCOUNTER_END"
)

--[[
(ability.id = 372419 or ability.id = 372642 or ability.id = 372418 or ability.id = 372647 or ability.id = 372424) and type = "applybuff"
 or ability.id = 372638 and type = "begincast" or ability.id = 371254
 or (ability.id = 369505 or ability.id = 371447 or ability.id = 372286) and (type = "applybuff" or type = "applydebuff")
 or (ability.id = 328921 or ability.id = 330959 or ability.id = 323402 or ability.id = 348805 or ability.id = 328117 or ability.id = 355525 or ability.id = 357739 or ability.id = 362505 or ability.id = 361200 or ability.id = 360300 or ability.id = 360304) and (type = "removebuff")
 or (ability.id = 347376 or ability.id = 330959 or ability.id = 357729 or ability.id = 326005) and type = "cast"
 or (ability.id = 348805 or ability.id = 350857 or ability.id = 348146 or ability.id = 355525 or ability.id = 352051 or ability.id = 357739 or ability.id = 362505 or ability.id = 360300 or ability.id = 360304 or ability.id = 368383 or ability.id = 181089 or ability.id = 323402) and type = "applybuff"
 or (ability.id = 348974 or ability.id = 328117 or ability.id = 333932 or ability.id = 352293 or ability.id = 359235 or ability.id = 359236 or ability.id = 363130 or ability.id = 360717 or ability.id = 363533 or ability.id = 364114 or ability.id = 367851 or ability.id = 367290 or ability.id = 352660 or ability.id = 352538) and type = "begincast"
 or ability.id = 371597 or ability.id = 372634
--]]
local warnChaoticDestruction					= mod:NewCastAnnounce(372638, 3)--Add activating
local warnChaoticEssence						= mod:NewSpellAnnounce(372634, 2)--Clicked add
local warnCreationSpark							= mod:NewTargetNoFilterAnnounce(369505, 3)
local warnProtoformBarrier						= mod:NewTargetNoFilterAnnounce(371447, 3)
local warnReconfigurationEmitter				= mod:NewSpellAnnounce(371254, 3)
local warnReplicatingEssence					= mod:NewTargetNoFilterAnnounce(372286, 3)

local specWarnCreationSpark						= mod:NewSpecialWarningYou(369505, nil, nil, nil, 1, 2)
local yellCreationSpark							= mod:NewYell(369505)
local specWarnCreationSparkSoak					= mod:NewSpecialWarningSoak(369505, nil, nil, nil, 2, 7)
local specWarnReplicatingEssence				= mod:NewSpecialWarningYou(372286, nil, nil, nil, 1, 2)
local yellReplicatingEssence					= mod:NewYell(372286)
local yellReplicatingEssenceFades				= mod:NewShortFadesYell(372286)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(209862, nil, nil, nil, 1, 8)

local timerChaoticEssenceCD						= mod:NewCDTimer(58.8, 372634, nil, nil, nil, 1)--Consistent
local timerCreationSparkCD						= mod:NewCDTimer(44.9, 369505, nil, nil, nil, 3)--Consistent
local timerProtoformBarrierCD					= mod:NewCDTimer(50, 371447, nil, nil, nil, 5)--50-65
local timerReconfigurationEmitterCD				= mod:NewCDTimer(55, 371254, nil, nil, nil, 1)--55-75
local timerReplicatingEssenceCD					= mod:NewAITimer(44.9, 372286, nil, nil, nil, 3)--Not Active week 1

local activeBosses = {}
local activeAffixes = {}
local borrowedTime = {}
local specialTimers = {
	[372419] = {--Emitter
		[0] = {--Repeating Timer
			--Castle Nathria
			[2418] = {75},--Huntsman Altimor
			[2412] = {75, 75},--Council of Blood (always 75, but restarts after dances)
			[2402] = {75},--Kael
			[2398] = {},--Shriekwing
			[2405] = {},--Artificer XyMox
			[2383] = {75},--Hungering Destroyer
			[2406] = {},--Lady Inerva Darkvein
			[2399] = {},--Sludgefist
			[2417] = {},--Stoneborne Generals
			[2407] = {60, 79, 70},--Sire Denathrius (can spell queue higher like 79-84 for Stage 2 if hand of destruction cast pushes it back
			--Sanctum of Domination
			[2423] = {},--The Tarragrue
			[2433] = {},--The Eye of the Jailer
			[2429] = {},--The Nine
			[2432] = {75},--Remnant of Ner'zhul
			[2434] = {},--Soulrender Dormazain
			[2430] = {},--Painsmith Raznal
			[2436] = {},--Guardian of the First Ones
			[2431] = {80, 80, 80},--Fatescribe Roh-Kalo
			[2422] = {},--Kel'Thuzad
			[2435] = {},--Sylvanas Windrunner
			--Sepulcher of the First Ones
			[2512] = {},--Vigilant Guardian
			[2542] = {75},--Skolex, the Insatiable Ravener
			[2553] = {},--Artificer Xy'mox
			[2540] = {},--Dausegne, the Fallen Oracle
			[2544] = {75},--Prototype Pantheon
			[2539] = {},--Lihuvim, Principal Architect
			[2529] = {},--Halondrus the Reclaimer
			[2546] = {75, 75},--Anduin Wrynn
			[2543] = {},--Lords of Dread
			[2549] = {},--Rygelon
			[2537] = {},--The Jailer
		},
		[1] = {--Initial pull/new stages (pull count reduced by 1 due to delayed start)
			--Castle Nathria
			[2418] = {4.8},--Huntsman Altimor
			[2412] = {4.8, 3.2},--Council of Blood
			[2402] = {4.8},--Kael
			[2398] = {},--Shriekwing
			[2405] = {},--Artificer XyMox
			[2383] = {4.8},--Hungering Destroyer
			[2406] = {},--Lady Inerva Darkvein
			[2399] = {},--Sludgefist
			[2417] = {},--Stoneborne Generals
			[2407] = {24.9, 10.5, 29.5},--Sire Denathrius (sometimes sire will skip first cast in stage 2)
			--Sanctum of Domination
			[2423] = {},--The Tarragrue
			[2433] = {},--The Eye of the Jailer
			[2429] = {},--The Nine
			[2432] = {4.8},--Remnant of Ner'zhul
			[2434] = {},--Soulrender Dormazain
			[2430] = {},--Painsmith Raznal
			[2436] = {},--Guardian of the First Ones
			[2431] = {4.8, 10, 10},--Fatescribe Roh-Kalo
			[2422] = {},--Kel'Thuzad
			[2435] = {},--Sylvanas Windrunner
			--Sepulcher of the First Ones
			[2512] = {},--Vigilant Guardian
			[2542] = {4.8},--Skolex, the Insatiable Ravener
			[2553] = {},--Artificer Xy'mox
			[2540] = {},--Dausegne, the Fallen Oracle
			[2544] = {4.8},--Prototype Pantheon
			[2539] = {},--Lihuvim, Principal Architect
			[2529] = {},--Halondrus the Reclaimer
			[2546] = {4.8, 8.6},--Anduin Wrynn
			[2543] = {},--Lords of Dread
			[2549] = {},--Rygelon
			[2537] = {},--The Jailer
		},
	},
	[372642] = {-- Chaotic Essence
		[0] = {--Repeating Timer
			--Castle Nathria
			[2418] = {},--Huntsman Altimor
			[2412] = {},--Council of Blood
			[2402] = {},--Kael
			[2398] = {58.8, 58.8},--Shriekwing
			[2405] = {58.8},--Artificer XyMox
			[2383] = {},--Hungering Destroyer
			[2406] = {58.8},--Lady Inerva Darkvein
			[2399] = {58.8},--Sludgefist
			[2417] = {58.8},--Stoneborne Generals
			[2407] = {},--Sire Denathrius
			--Sanctum of Domination
			[2423] = {},--The Tarragrue
			[2433] = {54.7, 54.7, 54.7},--The Eye of the Jailer
			[2429] = {},--The Nine
			[2432] = {},--Remnant of Ner'zhul
			[2434] = {},--Soulrender Dormazain
			[2430] = {58.8, 58.8, 58.8},--Painsmith Raznal
			[2436] = {},--Guardian of the First Ones
			[2431] = {},--Fatescribe Roh-Kalo
			[2422] = {},--Kel'Thuzad
			[2435] = {58.8, 0, 58.8},--Sylvanas Windrunner (stage 2 timers are chaotic and not quite figured out yet, so disabled)
			--Sepulcher of the First Ones
			[2512] = {},--Vigilant Guardian
			[2542] = {},--Skolex, the Insatiable Ravener
			[2553] = {},--Artificer Xy'mox
			[2540] = {},--Dausegne, the Fallen Oracle
			[2544] = {},--Prototype Pantheon
			[2539] = {},--Lihuvim, Principal Architect
			[2529] = {80, 80},--Halondrus the Reclaimer
			[2546] = {},--Anduin Wrynn
			[2543] = {},--Lords of Dread
			[2549] = {0, 0},--Rygelon (has no CD, it's just synced to singularity stage beginnings and not recast any other time)
			[2537] = {},--The Jailer
		},
		[1] = {--Initial pull/new stages (pull count reduced by 1 due to delayed start)
			--Castle Nathria
			[2418] = {},--Huntsman Altimor
			[2412] = {},--Council of Blood
			[2402] = {},--Kael
			[2398] = {11, 12.4},--Shriekwing
			[2405] = {11},--Artificer XyMox
			[2383] = {},--Hungering Destroyer
			[2406] = {11},--Lady Inerva Darkvein
			[2399] = {11},--Sludgefist
			[2417] = {11},--Stoneborne Generals
			[2407] = {},--Sire Denathrius
			--Sanctum of Domination
			[2423] = {},--The Tarragrue
			[2433] = {11, 3.3, 35.1},--The Eye of the Jailer
			[2429] = {},--The Nine
			[2432] = {},--Remnant of Ner'zhul
			[2434] = {},--Soulrender Dormazain
			[2430] = {11, 17.3, 17.3},--Painsmith Raznal
			[2436] = {},--Guardian of the First Ones
			[2431] = {},--Fatescribe Roh-Kalo
			[2422] = {},--Kel'Thuzad
			[2435] = {11, 0, 26},--Sylvanas Windrunner (stage 2 timers are chaotic and not quite figured out yet, so disabled)
			--Sepulcher of the First Ones
			[2512] = {},--Vigilant Guardian
			[2542] = {},--Skolex, the Insatiable Ravener
			[2553] = {},--Artificer Xy'mox
			[2540] = {},--Dausegne, the Fallen Oracle
			[2544] = {},--Prototype Pantheon
			[2539] = {},--Lihuvim, Principal Architect
			[2529] = {11, 17.4},--Halondrus the Reclaimer
			[2546] = {},--Anduin Wrynn
			[2543] = {},--Lords of Dread
			[2549] = {0, 15.7},--Rygelon (doesn't use affix on engage at all. Instead, affix is disabled and only enabled in singularity stages)
			[2537] = {},--The Jailer
		},

	},
	[372418] = {--Barrier
		[0] = {--Repeating Timer
			--Castle Nathria
			[2418] = {},--Huntsman Altimor
			[2412] = {},--Council of Blood
			[2402] = {60},--Kael (always 60 but reflection of guilt fading causes an ICD that delays current cast, but not one after it)
			[2398] = {},--Shriekwing
			[2405] = {60},--Artificer XyMox
			[2383] = {60},--Hungering Destroyer
			[2406] = {},--Lady Inerva Darkvein
			[2399] = {70},--Sludgefist
			[2417] = {},--Stoneborne Generals
			[2407] = {},--Sire Denathrius
			--Sanctum of Domination
			[2423] = {60},--The Tarragrue
			[2433] = {},--The Eye of the Jailer
			[2429] = {},--The Nine
			[2432] = {},--Remnant of Ner'zhul
			[2434] = {60},--Soulrender Dormazain
			[2430] = {},--Painsmith Raznal
			[2436] = {},--Guardian of the First Ones
			[2431] = {},--Fatescribe Roh-Kalo
			[2422] = {60, 60},--Kel'Thuzad
			[2435] = {},--Sylvanas Windrunner
			--Sepulcher of the First Ones
			[2512] = {},--Vigilant Guardian
			[2542] = {},--Skolex, the Insatiable Ravener
			[2553] = {60},--Artificer Xy'mox
			[2540] = {60},--Dausegne, the Fallen Oracle
			[2544] = {},--Prototype Pantheon
			[2539] = {},--Lihuvim, Principal Architect
			[2529] = {},--Halondrus the Reclaimer
			[2546] = {},--Anduin Wrynn
			[2543] = {0, 0},--Lords of Dread (no in between casts, since it's reset by both bosses specials)
			[2549] = {},--Rygelon
			[2537] = {},--The Jailer
		},
		[1] = {--Initial pull/new stages (pull count reduced by 1 due to delayed start)
			--Castle Nathria
			[2418] = {},--Huntsman Altimor
			[2412] = {},--Council of Blood
			[2402] = {14.8},--Kael
			[2398] = {},--Shriekwing
			[2405] = {14.8},--Artificer XyMox
			[2383] = {14.8},--Hungering Destroyer
			[2406] = {},--Lady Inerva Darkvein
			[2399] = {35},--Sludgefist
			[2417] = {},--Stoneborne Generals
			[2407] = {},--Sire Denathrius
			--Sanctum of Domination
			[2423] = {14.8},--The Tarragrue
			[2433] = {},--The Eye of the Jailer
			[2429] = {},--The Nine
			[2432] = {},--Remnant of Ner'zhul
			[2434] = {14.8},--Soulrender Dormazain
			[2430] = {},--Painsmith Raznal
			[2436] = {},--Guardian of the First Ones
			[2431] = {},--Fatescribe Roh-Kalo
			[2422] = {14.8, 15},--Kel'Thuzad
			[2435] = {},--Sylvanas Windrunner
			--Sepulcher of the First Ones
			[2512] = {},--Vigilant Guardian
			[2542] = {},--Skolex, the Insatiable Ravener
			[2553] = {14.8},--Artificer Xy'mox
			[2540] = {14.8},--Dausegne, the Fallen Oracle
			[2544] = {},--Prototype Pantheon
			[2539] = {},--Lihuvim, Principal Architect
			[2529] = {},--Halondrus the Reclaimer
			[2546] = {},--Anduin Wrynn
			[2543] = {20, 19},--Lords of Dread
			[2549] = {},--Rygelon
			[2537] = {},--The Jailer
		},

	},
	[372647] = {-- Creation Spark
		[0] = {--Repeating Timer
			--Castle Nathria
			[2418] = {44.9},--Huntsman Altimor
			[2412] = {44.9, 44.9},--Council of Blood
			[2402] = {},--Kael
			[2398] = {44.9, 44.9},--Shriekwing
			[2405] = {},--Artificer XyMox
			[2383] = {},--Hungering Destroyer
			[2406] = {44.9},--Lady Inerva Darkvein
			[2399] = {},--Sludgefist
			[2417] = {44.9},--Stoneborne Generals
			[2407] = {57.9, 84.9, 70},--Sire Denathrius
			--Sanctum of Domination
			[2423] = {},--The Tarragrue
			[2433] = {},--The Eye of the Jailer
			[2429] = {44.9},--The Nine
			[2432] = {},--Remnant of Ner'zhul
			[2434] = {},--Soulrender Dormazain
			[2430] = {},--Painsmith Raznal
			[2436] = {0},--Guardian of the First Ones (unknown, since the stage resetting it are far more likely than seeing it twice)
			[2431] = {},--Fatescribe Roh-Kalo
			[2422] = {},--Kel'Thuzad
			[2435] = {},--Sylvanas Windrunner
			--Sepulcher of the First Ones
			[2512] = {44.9},--Vigilant Guardian
			[2542] = {},--Skolex, the Insatiable Ravener
			[2553] = {},--Artificer Xy'mox
			[2540] = {},--Dausegne, the Fallen Oracle
			[2544] = {},--Prototype Pantheon
			[2539] = {44.9, 44.9},--Lihuvim, Principal Architect
			[2529] = {},--Halondrus the Reclaimer
			[2546] = {},--Anduin Wrynn
			[2543] = {},--Lords of Dread
			[2549] = {},--Rygelon
			[2537] = {44.9, 44.9, 44.9, 44.9},--The Jailer (stage 4 not yet known)
		},
		[1] = {--Initial pull/new stages (pull count reduced by 1 due to delayed start)
			--Castle Nathria
			[2418] = {19.9},--Huntsman Altimor
			[2412] = {19.9, 18.2},--Council of Blood
			[2402] = {},--Kael
			[2398] = {19.9, 20},--Shriekwing
			[2405] = {},--Artificer XyMox
			[2383] = {},--Hungering Destroyer
			[2406] = {19.9},--Lady Inerva Darkvein
			[2399] = {},--Sludgefist
			[2417] = {19.9},--Stoneborne Generals
			[2407] = {3, 24.5, 39.5},--Sire Denathrius
			--Sanctum of Domination
			[2423] = {},--The Tarragrue
			[2433] = {},--The Eye of the Jailer
			[2429] = {19.9},--The Nine
			[2432] = {},--Remnant of Ner'zhul
			[2434] = {},--Soulrender Dormazain
			[2430] = {},--Painsmith Raznal
			[2436] = {30, 9},--Guardian of the First Ones
			[2431] = {},--Fatescribe Roh-Kalo
			[2422] = {},--Kel'Thuzad
			[2435] = {},--Sylvanas Windrunner
			--Sepulcher of the First Ones
			[2512] = {19.9},--Vigilant Guardian
			[2542] = {},--Skolex, the Insatiable Ravener
			[2553] = {},--Artificer Xy'mox
			[2540] = {},--Dausegne, the Fallen Oracle
			[2544] = {},--Prototype Pantheon
			[2539] = {19.9, 20},--Lihuvim, Principal Architect
			[2529] = {},--Halondrus the Reclaimer
			[2546] = {},--Anduin Wrynn
			[2543] = {},--Lords of Dread
			[2549] = {},--Rygelon
			[2537] = {19.9, 20.9, 33.9, 0},--The Jailer (stage 4 not yet known)
		},

	},
	[372424] = {-- Replicating Essence
		[0] = {--Repeating Timer
			--Castle Nathria
			[2418] = {},--Huntsman Altimor
			[2412] = {},--Council of Blood
			[2402] = {},--Kael
			[2398] = {},--Shriekwing
			[2405] = {},--Artificer XyMox
			[2383] = {},--Hungering Destroyer
			[2406] = {},--Lady Inerva Darkvein
			[2399] = {},--Sludgefist
			[2417] = {},--Stoneborne Generals
			[2407] = {},--Sire Denathrius
			--Sanctum of Domination
			[2423] = {},--The Tarragrue
			[2433] = {},--The Eye of the Jailer
			[2429] = {},--The Nine
			[2432] = {},--Remnant of Ner'zhul
			[2434] = {},--Soulrender Dormazain
			[2430] = {},--Painsmith Raznal
			[2436] = {},--Guardian of the First Ones
			[2431] = {},--Fatescribe Roh-Kalo
			[2422] = {},--Kel'Thuzad
			[2435] = {},--Sylvanas Windrunner
			--Sepulcher of the First Ones
			[2512] = {},--Vigilant Guardian
			[2542] = {},--Skolex, the Insatiable Ravener
			[2553] = {},--Artificer Xy'mox
			[2540] = {},--Dausegne, the Fallen Oracle
			[2544] = {},--Prototype Pantheon
			[2539] = {},--Lihuvim, Principal Architect
			[2529] = {},--Halondrus the Reclaimer
			[2546] = {},--Anduin Wrynn
			[2543] = {},--Lords of Dread
			[2549] = {},--Rygelon
			[2537] = {},--The Jailer
		},
		[1] = {--Initial pull/new stages (pull count reduced by 1 due to delayed start)
			--Castle Nathria
			[2418] = {},--Huntsman Altimor
			[2412] = {},--Council of Blood
			[2402] = {},--Kael
			[2398] = {},--Shriekwing
			[2405] = {},--Artificer XyMox
			[2383] = {},--Hungering Destroyer
			[2406] = {},--Lady Inerva Darkvein
			[2399] = {},--Sludgefist
			[2417] = {},--Stoneborne Generals
			[2407] = {},--Sire Denathrius
			--Sanctum of Domination
			[2423] = {},--The Tarragrue
			[2433] = {},--The Eye of the Jailer
			[2429] = {},--The Nine
			[2432] = {},--Remnant of Ner'zhul
			[2434] = {},--Soulrender Dormazain
			[2430] = {},--Painsmith Raznal
			[2436] = {},--Guardian of the First Ones
			[2431] = {},--Fatescribe Roh-Kalo
			[2422] = {},--Kel'Thuzad
			[2435] = {},--Sylvanas Windrunner
			--Sepulcher of the First Ones
			[2512] = {},--Vigilant Guardian
			[2542] = {},--Skolex, the Insatiable Ravener
			[2553] = {},--Artificer Xy'mox
			[2540] = {},--Dausegne, the Fallen Oracle
			[2544] = {},--Prototype Pantheon
			[2539] = {},--Lihuvim, Principal Architect
			[2529] = {},--Halondrus the Reclaimer
			[2546] = {},--Anduin Wrynn
			[2543] = {},--Lords of Dread
			[2549] = {},--Rygelon
			[2537] = {},--The Jailer
		},

	},
}

do
	--Callback handler too update timers without registering duplicate CLEU events in affixes mod.
	local function dbmEventCallback(event, ...)
		if event == "DBM_AffixEvent" then
			--eventType 0 = Stop, eventType 1 = Start, eventType 2 = extend due to spell queue/delay
			local _, _, eventType, encounterID, stage, timeAdjust, spellDebit = ...
			if activeBosses[encounterID] then
				stage = stage or 1
				activeBosses[encounterID] = stage
				if activeAffixes[372419] then--Fated Power: Reconfiguration Emitter
					if eventType == 0 then
						timerReconfigurationEmitterCD:Stop()
					elseif eventType == 1 and specialTimers[372419][1][encounterID][stage] then
						timerReconfigurationEmitterCD:Restart(specialTimers[372419][1][encounterID][stage])
					elseif timeAdjust and eventType == 2 then
						if timerReconfigurationEmitterCD:GetRemaining() < timeAdjust then
							local elapsed, total = timerReconfigurationEmitterCD:GetTime()
							local extend = timeAdjust - (total-elapsed)
							DBM:Debug("timerReconfigurationEmitterCD extended by: "..extend, 2)
							timerReconfigurationEmitterCD:Update(elapsed, total+extend)
							if spellDebit then--The extended timer is debited from next cast
								borrowedTime[372419] = extend
							end
						end
					end
				end
				if activeAffixes[372642] then--Fated Power: Chaotic Essence
					if eventType == 0 then
						timerChaoticEssenceCD:Stop()
					elseif eventType == 1 and specialTimers[372642][1][encounterID][stage] then
						timerChaoticEssenceCD:Restart(specialTimers[372642][1][encounterID][stage])
					elseif timeAdjust and eventType == 2 then
						if timerChaoticEssenceCD:GetRemaining() < timeAdjust then
							local elapsed, total = timerChaoticEssenceCD:GetTime()
							local extend = timeAdjust - (total-elapsed)
							DBM:Debug("timerChaoticEssenceCD extended by: "..extend, 2)
							timerChaoticEssenceCD:Update(elapsed, total+extend)
							if spellDebit then--The extended timer is debited from next cast
								borrowedTime[372642] = extend
							end
						end
					end
				end
				if activeAffixes[372418] then--Fated Power: Protoform Barrier
					if eventType == 0 then
						timerProtoformBarrierCD:Stop()
					elseif eventType == 1 and specialTimers[372418][1][encounterID][stage] then
						timerProtoformBarrierCD:Restart(specialTimers[372418][1][encounterID][stage])
					elseif timeAdjust and eventType == 2 then
						if timerProtoformBarrierCD:GetRemaining() < timeAdjust then
							local elapsed, total = timerProtoformBarrierCD:GetTime()
							local extend = timeAdjust - (total-elapsed)
							DBM:Debug("timerProtoformBarrierCD extended by: "..extend, 2)
							timerProtoformBarrierCD:Update(elapsed, total+extend)
							if spellDebit then--The extended timer is debited from next cast
								borrowedTime[372418] = extend
							end
						end
					end
				end
				if activeAffixes[372647] then--Fated Power: Creation Spark
					if eventType == 0 then
						timerCreationSparkCD:Stop()
					elseif eventType == 1 and specialTimers[372647][1][encounterID][stage] then
						timerCreationSparkCD:Restart(specialTimers[372647][1][encounterID][stage])
					elseif timeAdjust and eventType == 2 then
						if timerCreationSparkCD:GetRemaining() < timeAdjust then
							local elapsed, total = timerCreationSparkCD:GetTime()
							local extend = timeAdjust - (total-elapsed)
							DBM:Debug("timerCreationSparkCD extended by: "..extend, 2)
							timerCreationSparkCD:Update(elapsed, total+extend)
							if spellDebit then--The extended timer is debited from next cast
								borrowedTime[372647] = extend
							end
						end
					end
				end
				if activeAffixes[372424] then--Fated Power: Replicating Essence
					if eventType == 0 then
						timerReplicatingEssenceCD:Stop()
					elseif eventType == 1 and specialTimers[372424][1][encounterID][stage] then
					--	timerReplicatingEssenceCD:Restart(specialTimers[372424][1][encounterID][stage])
						timerReplicatingEssenceCD:Start(stage)--AI timer tech for now
					--elseif timeAdjust and eventType == 2 then
					--	if timerReplicatingEssenceCD:GetRemaining() < timeAdjust then
					--		local elapsed, total = timerReplicatingEssenceCD:GetTime()
					--		local extend = timeAdjust - (total-elapsed)
					--		DBM:Debug("timerReplicatingEssenceCD extended by: "..extend, 2)
					--		timerReplicatingEssenceCD:Update(elapsed, total+extend)
					--		if spellDebit then--The extended timer is debited from next cast
					--			borrowedTime[372424] = extend
					--		end
					--	end
					end
				end
			end
		end
	end
	DBM:RegisterCallback("DBM_AffixEvent", dbmEventCallback)
end

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 372638 and self:AntiSpam(3, 1) then
		warnChaoticDestruction:Show()
		local encounterID = activeAffixes[372642]
		local stage = activeBosses[encounterID] or 1
		local timer = encounterID and specialTimers[372642][0][encounterID][stage] or 58.8
		if borrowedTime[372642] then
			timerChaoticEssenceCD:Start(timer-borrowedTime[372642])
			borrowedTime[372642] = nil
		else
			timerChaoticEssenceCD:Start(timer)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 372634 then
		warnChaoticEssence:Show()
	end
end

function mod:SPELL_SUMMON(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 371254 and self:AntiSpam(3, 2) then
		warnReconfigurationEmitter:Show()
		local encounterID = activeAffixes[372419]
		local stage = activeBosses[encounterID] or 1
		local timer = encounterID and specialTimers[372419][0][encounterID][stage]--No or rule for now since no fights are agreeable on good base
		if timer then
			if borrowedTime[372419] then
				timerReconfigurationEmitterCD:Start(timer-borrowedTime[372419])
				borrowedTime[372419] = nil
			else
				timerReconfigurationEmitterCD:Start(timer)
			end
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 369505 then
		warnCreationSpark:CombinedShow(0.3, args.destName)
		if self:AntiSpam(3, 3) then
			local encounterID = activeAffixes[372647]
			local stage = activeBosses[encounterID] or 1
			local timer = encounterID and specialTimers[372647][0][encounterID][stage] or 44.9
			if borrowedTime[372647] then
				timerCreationSparkCD:Start(timer-borrowedTime[372647])
				borrowedTime[372647] = nil
			else
				timerCreationSparkCD:Start(timer)
			end
		end
		if args:IsPlayer() then
			specWarnCreationSpark:Show()
			specWarnCreationSpark:Play("targetyou")
		end
	elseif spellId == 371447 and args:IsDestTypeHostile() then
		warnProtoformBarrier:Show(args.destName)
		local encounterID = activeAffixes[372418]
		local stage = activeBosses[encounterID] or 1
		local timer = encounterID and specialTimers[372418][0][encounterID][stage]--No or rule for now since no fights are agreeable on good base
		if timer then
			if borrowedTime[372418] then
				timerProtoformBarrierCD:Start(timer-borrowedTime[372418])
				borrowedTime[372418] = nil
			else
				timerProtoformBarrierCD:Start(timer)
			end
		end
--	elseif (spellId == 371597) and self:AntiSpam(3, 6) then
--		warnProtoformBarrier:Show(DBM_COMMON_L.ENEMIES)
	elseif spellId == 372286 then
		warnReplicatingEssence:CombinedShow(0.3, args.destName)--Multiple?
		if self:AntiSpam(3, 4) then
			timerReplicatingEssenceCD:Start()--Temp handling for now using AI
			--local encounterID = activeAffixes[372424]
			--local stage = activeBosses[encounterID] or 1
			--local timer = encounterID and specialTimers[372424][0][encounterID][stage] or 44.9
			--if borrowedTime[372424] then
			--	timerReplicatingEssenceCD:Start(timer-borrowedTime[372424])
			--	borrowedTime[372424] = nil
			--else
			--	timerReplicatingEssenceCD:Start(timer)
			--end
		end
		if args:IsPlayer() then
			specWarnReplicatingEssence:Show()
			specWarnReplicatingEssence:Play("targetyou")
			yellReplicatingEssence:Yell()
			yellReplicatingEssenceFades:Countdown(spellId)
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 369505 and self:AntiSpam(5, 2) then
		specWarnCreationSparkSoak:Show()
		specWarnCreationSparkSoak:Play("helpsoak")
	elseif spellId == 372286 then
		if args:IsPlayer() then
			yellReplicatingEssenceFades:Cancel()
		end
	end
end

do
	local function CheckBosses(eID, delay)
		local found = false
		for i = 1, 8 do
			local unitID = "boss"..i
			local unitGUID = UnitGUID(unitID)
			if UnitExists(unitID) and not activeBosses[eID] then
				activeBosses[eID] = 1
				--Currently it's only possible for bosses to have one of them
				--However, we don't elseif rule it because it future proofs support for a case boss might later support 2+
				--Code will break if more than one boss pulled at same time with same affix though
				--All timers are minus 1
				if DBM:UnitBuff(unitID, 372419) then--Fated Power: Reconfiguration Emitter
					found = true
					activeAffixes[372419] = eID
					borrowedTime[372419] = nil
					local timer = (specialTimers[372419][1][eID][1] or 4.9)-delay
					if timer > 0 then
						timerReconfigurationEmitterCD:Start(timer)
					end
				end
				if DBM:UnitBuff(unitID, 372642) then--Fated Power: Chaotic Essence
					found = true
					activeAffixes[372642] = eID
					borrowedTime[372642] = nil
					local timer = (specialTimers[372642][1][eID][1] or 11)-delay
					if timer > 0 then
						timerChaoticEssenceCD:Start(timer)
					end
				end
				if DBM:UnitBuff(unitID, 372418) then--Fated Power: Protoform Barrier
					found = true
					activeAffixes[372418] = eID
					borrowedTime[372418] = nil
					local timer = (specialTimers[372418][1][eID][1] or 15)-delay
					if timer > 0 then
						timerProtoformBarrierCD:Start(timer)
					end
				end
				if DBM:UnitBuff(unitID, 372647) then--Fated Power: Creation Spark
					found = true
					activeAffixes[372647] = eID
					borrowedTime[372647] = nil
					local timer = (specialTimers[372647][1][eID][1] or 19.9)-delay
					if timer > 0 then
						timerCreationSparkCD:Start(timer)
					end
				end
				if DBM:UnitBuff(unitID, 372424) then--Fated Power: Replicating Essence
					found = true
					activeAffixes[372424] = eID
					borrowedTime[372424] = nil
					--local timer = specialTimers[372424][1][eID][1]
					--if timer > 0 then
						timerReplicatingEssenceCD:Start(1)
					--end
				end
			end
		end
		if not found then
			--Failed to find any affix on any boss ID, in a raid that's fated, try again after delay
			if delay < 10 then
				mod:Schedule(1, CheckBosses, eID, delay+1)
			else
				DBM:AddMsg("Failed to detect Fated affix after 10 seconds of scanning, notify DBM authors with this ID: "..eID)
			end
		end
	end

	function mod:ENCOUNTER_START(eID)
		if not self:IsFated() then return end
		--Delay check to make sure INSTANCE_ENCOUNTER_ENGAGE_UNIT has fired and boss unit Ids are valid
		--Yet we avoid using INSTANCE_ENCOUNTER_ENGAGE_UNIT directly since that increases timer start variation versus ENCOUNTER_START by a few milliseconds
		self:Unschedule(CheckBosses, eID)
		self:Schedule(1, CheckBosses, eID, 1)
	end

	function mod:ENCOUNTER_END(eID)
		--Carefully only terminate fated timers if fated was active for fight and specific affix was active for fight
		--This way we can try to avoid canceling timers for other fights that might be engaged at same time
		if activeBosses[eID] then
			self:Unschedule(CheckBosses, eID)
			if activeAffixes[372419] then--Fated Power: Reconfiguration Emitter
				activeAffixes[372419] = nil
				borrowedTime[372419] = nil
				timerReconfigurationEmitterCD:Stop()
			end
			if activeAffixes[372642] then--Fated Power: Chaotic Essence
				activeAffixes[372642] = nil
				borrowedTime[372642] = nil
				timerChaoticEssenceCD:Stop()
			end
			if activeAffixes[372418] then--Fated Power: Protoform Barrier
				activeAffixes[372418] = nil
				borrowedTime[372418] = nil
				timerProtoformBarrierCD:Stop()
			end
			if activeAffixes[372647] then--Fated Power: Creation Spark
				activeAffixes[372647] = nil
				borrowedTime[372647] = nil
				timerCreationSparkCD:Stop()
			end
			if activeAffixes[372424] then--Fated Power: Replicating Essence
				activeAffixes[372424] = nil
				borrowedTime[372424] = nil
				timerReplicatingEssenceCD:Stop()
			end
			activeBosses[eID] = nil
		end
	end
end


--[[
function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 209862 and destGUID == UnitGUID("player") and self:AntiSpam(3, 7) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE
--]]
