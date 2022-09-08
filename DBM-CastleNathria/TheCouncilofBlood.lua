local mod	= DBM:NewMod(2426, "DBM-CastleNathria", nil, 1190)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(166971, 166969, 166970)--Castellan Niklaus, Baroness Frieda, Lord Stavros
mod:SetEncounterID(2412)
mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(8,6)
mod:SetHotfixNoticeRev(20210216000000)--2021, 02, 16
mod:SetMinSyncRevision(20210216000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 330965 330978 327497 346654 346690 337110 346657 346762 346303 346790 346698 346800 331634",
	"SPELL_CAST_SUCCESS 330959 346657 346303 347376",
	"SPELL_AURA_APPLIED 330967 331636 331637 332535 346694 347350 346690 346709",
	"SPELL_AURA_APPLIED_DOSE 332535 346690",
	"SPELL_AURA_REMOVED 330967 331636 331637 346694 330959 347350",
	"SPELL_AURA_REMOVED_DOSE 347350",
	"SPELL_PERIODIC_DAMAGE 346945",
	"SPELL_PERIODIC_MISSED 346945",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

--TODO, upgrade Dreadbolt volley to interrupt count special warning with more data
--TODO, upgrade Cadre to special warning for melee/everyone based on where they spawn?
--TODO, Soul Spikes mid spikes swap, similar to the mid combo swap of Zek'vhoz?
--TODO, continue reviewing timers, especially rechecking mythic and any guessed timers or timers that may have changed since last testing
--TODO, rework and reenable the volley timer eventually. It needs a lot of work since it's sequenced by phase and difficulty and alive vs dead. Real damn mess, Lower Priority
--[[
(ability.id = 330965 or ability.id = 330978 or ability.id = 327497 or ability.id = 346654 or ability.id = 337110 or ability.id = 346657 or ability.id = 346762 or ability.id = 346698 or ability.id = 346690 or ability.id = 346800 or ability.id = 331634) and type = "begincast"
 or ability.id = 332535 or ability.id = 330959 or ability.id = 332538 or abiity.id = 331918 or ability.id = 346709 or ability.id = 346706
 or (ability.id = 330964 or ability.id = 335773) and type = "cast"
 or (target.id = 166971 or target.id = 166969 or target.id = 166970) and type = "death"
 or ability.id = 347350 and type = "applydebuff"
 or ability.id = 346303 and type = "begincast"
 or (ability.id = 347376) and type = "cast"
 --]]
 --I Forgot
 --https://www.warcraftlogs.com/reports/MFwzxfRcthN4C9mX#fight=36&view=events&pins=2%24Off%24%23244F4B%24expression%24(ability.id%20%3D%20330965%20or%20ability.id%20%3D%20330978%20or%20ability.id%20%3D%20327497%20or%20ability.id%20%3D%20346654%20or%20ability.id%20%3D%20337110%20or%20ability.id%20%3D%20346657%20or%20ability.id%20%3D%20346681%20or%20ability.id%20%3D%20346698%20or%20ability.id%20%3D%20346690%20or%20ability.id%20%3D%20346800)%20and%20type%20%3D%20%22begincast%22%20%20or%20(ability.id%20%3D%20331634)%20and%20type%20%3D%20%22cast%22%20%20or%20ability.id%20%3D%20332535%20or%20ability.id%20%3D%20330959%20or%20ability.id%20%3D%20332538%20or%20abiity.id%20%3D%20331918%20or%20ability.id%20%3D%20346709%20%20or%20(ability.id%20%3D%20330964%20or%20ability.id%20%3D%20335773)%20and%20type%20%3D%20%22cast%22%20%20or%20(target.id%20%3D%20166971%20or%20target.id%20%3D%20166969%20or%20target.id%20%3D%20166970)%20and%20type%20%3D%20%22death%22%20%20or%20ability.id%20%3D%20346303%20and%20type%20%3D%20%22begincast%22
 --https://www.warcraftlogs.com/reports/L8wWqHKkFmBPgTCQ#fight=16&view=events&pins=2%24Off%24%23244F4B%24expression%24(ability.id%20%3D%20330965%20or%20ability.id%20%3D%20330978%20or%20ability.id%20%3D%20327497%20or%20ability.id%20%3D%20346654%20or%20ability.id%20%3D%20337110%20or%20ability.id%20%3D%20346657%20or%20ability.id%20%3D%20346762%20or%20ability.id%20%3D%20346698%20or%20ability.id%20%3D%20346690%20or%20ability.id%20%3D%20346800)%20and%20type%20%3D%20%22begincast%22%0A%20or%20(ability.id%20%3D%20331634)%20and%20type%20%3D%20%22cast%22%0A%20or%20ability.id%20%3D%20332535%20or%20ability.id%20%3D%20330959%20or%20ability.id%20%3D%20332538%20or%20abiity.id%20%3D%20331918%20or%20ability.id%20%3D%20346709%0A%20or%20(ability.id%20%3D%20330964%20or%20ability.id%20%3D%20335773)%20and%20type%20%3D%20%22cast%22%0A%20or%20(target.id%20%3D%20166971%20or%20target.id%20%3D%20166969%20or%20target.id%20%3D%20166970)%20and%20type%20%3D%20%22death%22%20%20or%20ability.id%20%3D%20346303%20and%20type%20%3D%20%22begincast%22
 --https://www.warcraftlogs.com/reports/94ydxX23tR8Phcfj#fight=26&view=events&pins=2%24Off%24%23244F4B%24expression%24(ability.id%20%3D%20330965%20or%20ability.id%20%3D%20330978%20or%20ability.id%20%3D%20327497%20or%20ability.id%20%3D%20346654%20or%20ability.id%20%3D%20337110%20or%20ability.id%20%3D%20346657%20or%20ability.id%20%3D%20346681%20or%20ability.id%20%3D%20346698%20or%20ability.id%20%3D%20346690%20or%20ability.id%20%3D%20346800)%20and%20type%20%3D%20%22begincast%22%20%20or%20(ability.id%20%3D%20331634)%20and%20type%20%3D%20%22cast%22%20%20or%20ability.id%20%3D%20332535%20or%20ability.id%20%3D%20330959%20or%20ability.id%20%3D%20332538%20or%20abiity.id%20%3D%20331918%20or%20ability.id%20%3D%20346709%20%20or%20(ability.id%20%3D%20330964%20or%20ability.id%20%3D%20335773)%20and%20type%20%3D%20%22cast%22%20%20or%20(target.id%20%3D%20166971%20or%20target.id%20%3D%20166969%20or%20target.id%20%3D%20166970)%20and%20type%20%3D%20%22death%22%20%20or%20ability.id%20%3D%20346303%20and%20type%20%3D%20%22begincast%22
--LFR
--https://www.warcraftlogs.com/reports/ahyp8WPMnFcA96Vg#fight=last&view=events&pins=2%24Off%24%23244F4B%24expression%24(ability.id%20%3D%20330965%20or%20ability.id%20%3D%20330978%20or%20ability.id%20%3D%20327497%20or%20ability.id%20%3D%20346654%20or%20ability.id%20%3D%20337110%20or%20ability.id%20%3D%20346657%20or%20ability.id%20%3D%20346762%20or%20ability.id%20%3D%20346698%20or%20ability.id%20%3D%20346690%20or%20ability.id%20%3D%20346800)%20and%20type%20%3D%20%22begincast%22%20%20or%20(ability.id%20%3D%20331634)%20and%20type%20%3D%20%22cast%22%20%20or%20ability.id%20%3D%20332535%20or%20ability.id%20%3D%20330959%20or%20ability.id%20%3D%20332538%20or%20abiity.id%20%3D%20331918%20or%20ability.id%20%3D%20346709%20%20or%20(ability.id%20%3D%20330964%20or%20ability.id%20%3D%20335773)%20and%20type%20%3D%20%22cast%22%20%20or%20(target.id%20%3D%20166971%20or%20target.id%20%3D%20166969%20or%20target.id%20%3D%20166970)%20and%20type%20%3D%20%22death%22%20%20or%20ability.id%20%3D%20347350%20and%20type%20%3D%20%22applydebuff%22%20%20or%20ability.id%20%3D%20346303%20and%20type%20%3D%20%22begincast%22
--https://www.warcraftlogs.com/reports/cNrfpg1XZt89Aa4R#fight=last&view=events&pins=2%24Off%24%23244F4B%24expression%24(ability.id%20%3D%20330965%20or%20ability.id%20%3D%20330978%20or%20ability.id%20%3D%20327497%20or%20ability.id%20%3D%20346654%20or%20ability.id%20%3D%20337110%20or%20ability.id%20%3D%20346657%20or%20ability.id%20%3D%20346762%20or%20ability.id%20%3D%20346698%20or%20ability.id%20%3D%20346690%20or%20ability.id%20%3D%20346800)%20and%20type%20%3D%20%22begincast%22%20%20or%20(ability.id%20%3D%20331634)%20and%20type%20%3D%20%22cast%22%20%20or%20ability.id%20%3D%20332535%20or%20ability.id%20%3D%20330959%20or%20ability.id%20%3D%20332538%20or%20abiity.id%20%3D%20331918%20or%20ability.id%20%3D%20346709%20%20or%20(ability.id%20%3D%20330964%20or%20ability.id%20%3D%20335773)%20and%20type%20%3D%20%22cast%22%20%20or%20(target.id%20%3D%20166971%20or%20target.id%20%3D%20166969%20or%20target.id%20%3D%20166970)%20and%20type%20%3D%20%22death%22%20%20or%20ability.id%20%3D%20347350%20and%20type%20%3D%20%22applydebuff%22%20%20or%20ability.id%20%3D%20346303%20and%20type%20%3D%20%22begincast%22
--https://www.warcraftlogs.com/reports/zHM8mJ4hxX6TaVdG#fight=9&view=events&pins=2%24Off%24%23244F4B%24expression%24(ability.id%20%3D%20330965%20or%20ability.id%20%3D%20330978%20or%20ability.id%20%3D%20327497%20or%20ability.id%20%3D%20346654%20or%20ability.id%20%3D%20337110%20or%20ability.id%20%3D%20346657%20or%20ability.id%20%3D%20346762%20or%20ability.id%20%3D%20346698%20or%20ability.id%20%3D%20346690%20or%20ability.id%20%3D%20346800)%20and%20type%20%3D%20%22begincast%22%20%20or%20(ability.id%20%3D%20331634)%20and%20type%20%3D%20%22cast%22%20%20or%20ability.id%20%3D%20332535%20or%20ability.id%20%3D%20330959%20or%20ability.id%20%3D%20332538%20or%20abiity.id%20%3D%20331918%20or%20ability.id%20%3D%20346709%20%20or%20(ability.id%20%3D%20330964%20or%20ability.id%20%3D%20335773)%20and%20type%20%3D%20%22cast%22%20%20or%20(target.id%20%3D%20166971%20or%20target.id%20%3D%20166969%20or%20target.id%20%3D%20166970)%20and%20type%20%3D%20%22death%22%20%20or%20ability.id%20%3D%20347350%20and%20type%20%3D%20%22applydebuff%22%20%20or%20ability.id%20%3D%20346303%20and%20type%20%3D%20%22begincast%22
--General
local warnPhase									= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)
local warnDanceOver								= mod:NewEndAnnounce(328497, 2)

local specWarnDanseMacabre						= mod:NewSpecialWarningSpell(328497, nil, nil, 2, 2, 2)
local specWarnGTFO								= mod:NewSpecialWarningGTFO(346945, nil, nil, nil, 1, 8)

local berserkTimer								= mod:NewBerserkTimer(600)
--Castellan Niklaus
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22147))--2 baseline abilities
local warnDualistsRiposte						= mod:NewStackAnnounce(346690, 2, nil, "Tank|Healer")
local warnDutifulAttendant						= mod:NewSpellAnnounce(346698, 2)

local specWarnDualistsRiposte					= mod:NewSpecialWarningStack(346690, nil, 2, nil, nil, 1, 2)
local specWarnDualistsRiposteTaunt				= mod:NewSpecialWarningTaunt(346690, nil, nil, nil, 1, 2)
local specWarnDutifulAttendant					= mod:NewSpecialWarningSwitch(346698, "Dps", nil, nil, 1, 2)

local timerDualistsRiposteCD					= mod:NewCDTimer(18.7, 346690, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerDutifulAttendantCD					= mod:NewCDTimer(44.9, 346698, nil, nil, nil, 5, nil, DBM_COMMON_L.DAMAGE_ICON)--Used after death on Mythic

mod:AddNamePlateOption("NPAuraOnShield", 346694)
mod:AddSetIconOption("SetIconOnDutiful", 346698, true, true, {8})
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22201))--One is dead
local warnDredgerServants						= mod:NewSpellAnnounce(330978, 2)--One boss dead

local timerDredgerServantsCD					= mod:NewCDTimer(44.3, 330978, nil, nil, nil, 1)--Iffy on verification
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22199))--Two are dead
local warnCastellansCadre						= mod:NewSpellAnnounce(330965, 2)--Two bosses dead
local warnFixate								= mod:NewTargetAnnounce(330967, 3)--Two bosses dead (Veteran Stoneguard)
local warnSintouchedBlade						= mod:NewSpellAnnounce(346790, 4)--Veteran Stoneguard

local specWarnFixate							= mod:NewSpecialWarningRun(330967, nil, nil, nil, 4, 2)--Two bosses dead

local timerCastellansCadreCD					= mod:NewCDTimer(26.7, 330965, nil, nil, nil, 1)
--local timerSintouchedBladeCD						= mod:NewNextCountTimer(12.1, 308872, nil, nil, nil, 5)

mod:AddNamePlateOption("NPAuraOnFixate", 330967)
--Baroness Frieda
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22148))--2 baseline abilities
local warnDreadboltVolley						= mod:NewCountAnnounce(337110, 2)
local warnDrainEssence							= mod:NewCountAnnounce(346654, 3, nil, "Healer")

local specWarnDreadboltVolley					= mod:NewSpecialWarningInterruptCount(337110, false, nil, nil, 1, 2)

local timerDrainEssenceCD						= mod:NewCDTimer(22.5, 346654, nil, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON)
local timerDreadboltVolleyCD					= mod:NewCDTimer(45, 337110, nil, nil, nil, 2, nil, DBM_COMMON_L.MYTHIC_ICON)--Only for after image
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22202))--One is dead
local specWarnPridefulEruption					= mod:NewSpecialWarningMoveAway(346657, nil, 138658, nil, 2, 2)--One boss dead

local timerPridefulEruptionCD					= mod:NewCDTimer(25, 346657, 138658, nil, nil, 3)

mod:AddRangeFrameOption(8, 346657)
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22945))--Two are dead
local timerSoulSpikesCD							= mod:NewCDTimer(19.4, 346762, nil, nil, nil, 3)

mod:AddSetIconOption("SetIconOnImage", "ej22433", true, true, {6})
--Lord Stavros
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22149))--2 baseline abilities
local warnDarkRecital							= mod:NewTargetNoFilterAnnounce(331634, 3)

local specWarnEvasiveLunge						= mod:NewSpecialWarningDodge(327497, nil, 219588, nil, 2, 2)
local specWarnDarkRecital						= mod:NewSpecialWarningMoveTo(331634, nil, nil, nil, 1, 2)--One boss dead
local yellDarkRecitalRepeater					= mod:NewIconRepeatYell(331634, DBM_CORE_L.AUTO_YELL_ANNOUNCE_TEXT.shortyell)--One boss dead

local timerEvasiveLungeCD						= mod:NewCDTimer(18.7, 327497, 219588, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerDarkRecitalCD						= mod:NewCDTimer(45, 331634, nil, nil, nil, 3)--Continues on Mythic after death instead of gaining new ability
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22203))--One is dead
local specWarnWaltzofBlood						= mod:NewSpecialWarningDodge(327616, nil, nil, nil, 2, 2)

local timerWaltzofBloodCD						= mod:NewCDTimer(21.8, 327616, nil, nil, nil, 3)
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22206))--Two are dead
local warnDancingFools							= mod:NewSpellAnnounce(330964, 2)--Two bosses dead

local specWarnDancingFools						= mod:NewSpecialWarningSwitch(330964, "Dps", nil, nil, 1, 2)

local timerDancingFoolsCD						= mod:NewCDTimer(30.3, 330964, nil, nil, nil, 1)

mod:AddSetIconOption("SetIconOnDancingFools", 346826, true, true, {8})--Attempts to set icon only on killable one, not yet tested
mod:AddNamePlateOption("NPAuraOnUproar", 346303)
--Mythic
mod:AddTimerLine(PLAYER_DIFFICULTY6)
local warnDancingFever							= mod:NewTargetNoFilterAnnounce(347350, 4)

local yellDancingFever							= mod:NewYell(347350, nil, false)--Off by default do to potential to spam when spread, going to dry run nameplate auras for this

local timerDancingFeverCD						= mod:NewCDCountTimer(60, 347350, nil, nil, nil, 3)

mod:AddInfoFrameOption(347350, true)
mod:GroupSpells(346698, 346694)--Dutiful Attendant and it's shield (tied together because they are one in same. Ie it's not an ability the add users from time to time, the add is the ability
mod:GroupSpells(346790, 330967)--Fixate and Sintouched (the stone adds cast sintouched on the target they are fixating)

mod.vb.feversActive = 0
mod.vb.volleyCast = 0
mod.vb.drainCount = 0
mod.vb.feverCast = 0
mod.vb.nikDead = false
mod.vb.friedaDead = false
mod.vb.stavrosDead = false
--local danceDurationFix = 0
local darkRecitalTargets = {}
local playerName = UnitName("player")
local castsPerGUID = {}
local FeverStacks = {}
local difficultyName = "None"
local allTimers = {
	["lfr"] = {--LFR definitely differs from everything else
		--Duelist Riposte
		[346690] = {25, 20, 10},
		--Dutiful Attendant
		[346698] = {60, 60, 29.9},
		--Dreger Servants (P2+)
		[330978] = {0, 60, 60},
		--Castellan's Cadre (P3+)
		[330965] = {0, 0, 60},

		--Drain Essence
		[346654] = {27.3, 19.8, 46.6},
		--Prideful Eruption (P2+)
		[346657] = {0, 43.3, 46.6},
		--Soul Spikes (P3+)
		[346762] = {0, 0, 46.6},

		--Evasive Lunge
		[327497] = {25, 19.6, 13.3},--Phase 2 lunge can get in a bugged state and spam every 10 seconds in rare cases
		--Dark Recital
		[331634] = {60, 80, 26.6},
		--Waltz of Blood (P2+)
		[346800] = {0, 80, 110},
		--Dancing Fools (P3+)
		[346826] = {0, 0, 110},
	},
	["normal"] = {--Heroic and Normal same, for now, but separated for time being in case this changes
		--Duelist Riposte
		[346690] = {21.4, 17.1, 11.4},
		--Dutiful Attendant
		[346698] = {51.4, 51.4, 25.6},
		--Dreger Servants (P2+)
		[330978] = {0, 51.4, 51.4},
		--Castellan's Cadre (P3+)
		[330965] = {0, 0, 51.4},

		--Drain Essence
		[346654] = {25.7, 19.9, 41.3},--not a bug, verified in two logs at least.
		--Prideful Eruption (P2+)
		[346657] = {0, 65, 40.9},
		--Soul Spikes (P3+)
		[346762] = {0, 0, 40.9},

		--Evasive Lunge
		[327497] = {21.4, 17.1, 11.4},
		--Dark Recital
		[331634] = {51.4, 68.1, 22.8},
		--Waltz of Blood (P2+)
		[346800] = {0, 68.1, 68.1},
		--Dancing Fools (P3+)
		[346826] = {0, 0, 68.1},
	},
	["heroic"] = {--Heroic and Normal same, for now, but separated for time being in case this changes
		--Duelist Riposte
		[346690] = {21.4, 17.1, 11.4},
		--Dutiful Attendant
		[346698] = {51.4, 51.4, 25.6},
		--Dreger Servants (P2+)
		[330978] = {0, 51.4, 51.4},
		--Castellan's Cadre (P3+)
		[330965] = {0, 0, 51.4},

		--Drain Essence
		[346654] = {25.7, 19.9, 41.3},--not a bug, verified in two logs at least.
		--Prideful Eruption (P2+)
		[346657] = {0, 68.1, 40.9},--68.1 is guessed, did not find any logs it was cast twice in phase 2
		--Soul Spikes (P3+)
		[346762] = {0, 0, 40.9},

		--Evasive Lunge
		[327497] = {21.4, 17.1, 11.4},
		--Dark Recital
		[331634] = {51.4, 68.1, 22.8},
		--Waltz of Blood (P2+)
		[346800] = {0, 68.1, 68.1},
		--Dancing Fools (P3+)
		[346826] = {0, 0, 68.1},
	},
	["mythic"] = {
		--Duelist Riposte
		[346690] = {18.7, 14.9, 7.5},
		--Dutiful Attendant (Living)
		[346698] = {44.9, 44.9, 22.5},--Verified final mythic test
		--Dreger Servants (P2+)
		[330978] = {0, 44.9, 44.9},
		--Castellan's Cadre (P3+)
		[330965] = {0, 0, 44.9},

		--Drain Essence
		[346654] = {22.5, 17.4, 36.1},--17 and 36 are extrapolated based on non mythic timers, could be wrong
		--Prideful Eruption (P2+)
		[346657] = {0, 60, 35.7},--Guessed based on math differential, but both could be wrong.
		--Soul Spikes (P3+)
		[346762] = {0, 0, 35.7},--Guessed based on math differential, but both could be wrong
		--Dreadbolt Volley (Dead)
		[337110] = {0, 44.9, 37.5},

		--Evasive Lunge
		[327497] = {18.7, 14.9, 10},
		--Dark Recital (Living)
		[331634] = {44.9, 59.9, 20},
		--Dark Recital (Dead)
		[331635] = {0, 60, 36.9},
		--Waltz of Blood (P2+)
		[346800] = {0, 60, 60},
		--Dancing Fools (P3+)
		[346826] = {0, 0, 60},
	},
}
local function warndarkRecitalTargets(self)
	warnDarkRecital:Show(table.concat(darkRecitalTargets, "<, >"))
	table.wipe(darkRecitalTargets)
end

local function darkRecitalYellRepeater(self, text, runTimes)
	yellDarkRecitalRepeater:Yell(text)
--	runTimes = runTimes + 1
--	if runTimes < 4 then--If they fix visual bugs, enable this restriction
		self:Schedule(2, darkRecitalYellRepeater, self, text, runTimes)
--	end
end

local function phaseChange(self, adjustment)
	--Bump phase and stop all timers since regardless of kills, phase changes reset anyone that's still up
	local bossesDead = (self.vb.nikDead and 1 or 0) + (self.vb.friedaDead and 1 or 0) + (self.vb.stavrosDead and 1 or 0)
	if (bossesDead+1) == self.vb.phase then return end--Somehow phaseChange ran more than once for same phase change, force abort
	self:SetStage(0)
	if adjustment > 0 then
		DBM:AddMsg("Some timers may be incorrect this phase. This usually happens when Infusion/Empowered buff misses remaining boss, causing timers not to correctly reset")
	end
	if self.vb.phase == 3 then--Two Dead
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(3))
		warnPhase:Play("pthree")
		--Castellan Niklaus
		timerDualistsRiposteCD:Stop()
		timerDutifulAttendantCD:Stop()
		if self.vb.nikDead then
			if self:IsMythic() then
				timerDutifulAttendantCD:Start(19.1-adjustment)--Confirmed
			end
		else
			timerDredgerServantsCD:Start((self:IsMythic() and 4.4 or self:IsLFR() and 5.7 or 5)-adjustment)--Verify heroic
			timerDualistsRiposteCD:Start((self:IsMythic() and 8.2 or self:IsLFR() and 10.7 or 9.2)-adjustment)
			timerCastellansCadreCD:Start((self:IsMythic() and 11.9 or self:IsLFR() and 15.7 or 13.5)-adjustment)
			timerDutifulAttendantCD:Start((self:IsMythic() and 19.5 or self:IsLFR() and 25.7 or 22.1)-adjustment)
		end
		--Baroness Frieda
		timerDrainEssenceCD:Stop()
--		timerDreadboltVolleyCD:Stop()
		timerPridefulEruptionCD:Stop()
		if self.vb.friedaDead then
			if self:IsMythic() then
				timerDreadboltVolleyCD:Start(25-adjustment)--Might be because she cast it on transition though, needs recheck
			end
		else
			--timerDreadboltVolleyCD:Start(1)--Used near imediately, except on LFR which has a massive delay of about 25 seconds
			timerDrainEssenceCD:Start((self:IsMythic() and 5 or self:IsLFR() and 7.4 or 6.4)-adjustment)--Mythic unknown, completely guessed
			timerPridefulEruptionCD:Start((self:IsMythic() and 17 or self:IsLFR() and 24.1 or 20)-adjustment)--Unknown on mythic, completely guessed
			timerSoulSpikesCD:Start((self:IsMythic() and 28 or self:IsLFR() and 37.4 or 32.1)-adjustment)--Mythic unknown, completely guessed
		end
		--Lord Stavros
		timerEvasiveLungeCD:Stop()
		timerWaltzofBloodCD:Stop()
		timerDarkRecitalCD:Stop()
		if self.vb.stavrosDead then
			if self:IsMythic() then
				timerDarkRecitalCD:Start(35.9-adjustment)
			end
		else
			timerDarkRecitalCD:Start((self:IsMythic() and 5.6 or self:IsLFR() and 7.3 or 6.4)-adjustment)
			timerEvasiveLungeCD:Start((self:IsMythic() and 10.7 or self:IsLFR() and 14 or 12.1)-adjustment)
			timerDancingFoolsCD:Start((self:IsMythic() and 18.2 or self:IsLFR() and 24 or 20.7)-adjustment)
			timerWaltzofBloodCD:Start((self:IsMythic() and 54.4 or self:IsLFR() and 44.4 or 62.1)-adjustment)--START (LFR iffy, dance correction makes murky)
		end
	else--One Dead (Phase 2)
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2))
		warnPhase:Play("ptwo")
		--Castellan Niklaus
		timerDredgerServantsCD:Stop()
		timerDualistsRiposteCD:Stop()
		timerDutifulAttendantCD:Stop()
		if self.vb.nikDead then
			--if self:IsMythic() then
				--timerDutifulAttendantCD:Start(34.4-adjustment)--Unknown
			--end
		else
			timerDredgerServantsCD:Start((self:IsMythic() and 4.4 or self:IsLFR() and 5.7 or 13.5)-adjustment)
			timerDualistsRiposteCD:Start((self:IsMythic() and 8.2 or self:IsLFR() and 10.7 or 9.2)-adjustment)
			timerDutifulAttendantCD:Start((self:IsMythic() and 34.4 or self:IsLFR() and 8.7 or 5)-adjustment)--Mythic confirmed, this is just weird that heroic is way different
		end
		--Baroness Frieda
		timerDrainEssenceCD:Stop()
--		timerDreadboltVolleyCD:Stop()
		if self.vb.friedaDead then
			if self:IsMythic() then
				timerDreadboltVolleyCD:Start(13.4-adjustment)
			end
		else
			--Still needs correcting with live mythic
--			timerDreadboltVolleyCD:Start(1.3)--Used like 1 second after except on LFR
			timerDrainEssenceCD:Start((self:IsMythic() and 5 or self:IsLFR() and 7.4 or 6.4)-adjustment)--Unknown on mythic, completely guessed
			timerPridefulEruptionCD:Start((self:IsMythic() and 27.3 or self:IsLFR() and 40.7 or 35)-adjustment)--Unknown on mythic, completely guessed
		end
		--Lord Stavros
		timerEvasiveLungeCD:Stop()
		timerDarkRecitalCD:Stop()
		if self.vb.stavrosDead then
			--if self:IsMythic() then
			--	timerDarkRecitalCD:Start(26.6-adjustment)--Unknown
			--end
		else
			timerEvasiveLungeCD:Start((self:IsMythic() and 7 or self:IsLFR() and 10.7 or 7.9)-adjustment)
			timerDarkRecitalCD:Start((self:IsMythic() and 20.6 or self:IsLFR() and 15.7 or 23.5)-adjustment)
			timerWaltzofBloodCD:Start((self:IsMythic() and 26.9 or self:IsLFR() and 35.7 or 30.7)-adjustment)--START
		end
	end
end

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.feversActive = 0
	self.vb.volleyCast = 1
	self.vb.drainCount = 0
	self.vb.feverCast = 0
	self.vb.nikDead = false
	self.vb.friedaDead = false
	self.vb.stavrosDead = false
	table.wipe(darkRecitalTargets)
	table.wipe(castsPerGUID)
	table.wipe(FeverStacks)
	if self:IsMythic() then
		difficultyName = "mythic"
		timerDancingFeverCD:Start(5-delay, 1)
		--Castellan Niklaus
		timerDutifulAttendantCD:Start(6.5-delay)
		timerDualistsRiposteCD:Start(16.5-delay)
		--Baroness Frieda
--		timerDreadboltVolleyCD:Start(5-delay)
		timerDrainEssenceCD:Start(13.6-delay)
		--Lord Stavros
		timerEvasiveLungeCD:Start(8.4-delay)
		timerDarkRecitalCD:Start(21.1-delay)
	elseif self:IsHeroic() then
		difficultyName = "heroic"
		--Castellan Niklaus
		timerDutifulAttendantCD:Start(7.3-delay)
		timerDualistsRiposteCD:Start(18.4-delay)
		--Baroness Frieda
--		timerDreadboltVolleyCD:Start(5.5-delay)
		timerDrainEssenceCD:Start(15.5-delay)
		--Lord Stavros
		timerEvasiveLungeCD:Start(8.4-delay)--Not changed?
		timerDarkRecitalCD:Start(22.7-delay)
	elseif self:IsNormal() then--CURRENTLY SAME AS HEROIC, which may be wrong
		difficultyName = "normal"
		--TODO, FIXME?
		--Castellan Niklaus
		timerDutifulAttendantCD:Start(7.3-delay)
		timerDualistsRiposteCD:Start(18.4-delay)
		--Baroness Frieda
--		timerDreadboltVolleyCD:Start(5.5-delay)
		timerDrainEssenceCD:Start(15.5-delay)
		--Lord Stavros
		timerEvasiveLungeCD:Start(8.4-delay)--Not changed?
		timerDarkRecitalCD:Start(22.7-delay)
	else
		difficultyName = "lfr"
		--Castellan Niklaus
		timerDutifulAttendantCD:Start(7.7-delay)
		timerDualistsRiposteCD:Start(21-delay)
		--Baroness Frieda
--		timerDreadboltVolleyCD:Start(6-delay)
		timerDrainEssenceCD:Start(17.7-delay)
		--Lord Stavros
		timerEvasiveLungeCD:Start(9.4-delay)
		timerDarkRecitalCD:Start(27.7-delay)
	end
	if self.Options.NPAuraOnFixate or self.Options.NPAuraOnShield or self.Options.NPAuraOnUproar then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
	berserkTimer:Start(720-delay)
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	table.wipe(castsPerGUID)
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.NPAuraOnFixate or self.Options.NPAuraOnShield or self.Options.NPAuraOnUproar then
		DBM.Nameplate:Hide(false, nil, nil, nil, true, true)
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
	if spellId == 331634 then
		if args:GetSrcCreatureID() == 166970 then--Main boss
			local timer = allTimers[difficultyName][spellId][self.vb.phase]
			if timer then
				timerDarkRecitalCD:Start(timer)
			end
		else--173053
			local timer = allTimers[difficultyName][331635][self.vb.phase]
			if timer then
				timerDarkRecitalCD:Start(timer)
				timerDarkRecitalCD:UpdateInline(DBM_COMMON_L.MYTHIC_ICON)
			end
		end
	elseif spellId == 330965 then
		warnCastellansCadre:Show()
		local timer = allTimers[difficultyName][spellId][self.vb.phase]
		if timer then
			timerCastellansCadreCD:Start(timer)
		end
	elseif spellId == 330978 then
		warnDredgerServants:Show()
		local timer = allTimers[difficultyName][spellId][self.vb.phase]
		if timer then
			timerDredgerServantsCD:Start(timer)
		end
	elseif spellId == 327497 then
		specWarnEvasiveLunge:Show()
		specWarnEvasiveLunge:Play("chargemove")
		local timer = allTimers[difficultyName][spellId][self.vb.phase]
		if timer then
			timerEvasiveLungeCD:Start(timer)
		end
	elseif spellId == 346654 then
		self.vb.drainCount = self.vb.drainCount + 1
		warnDrainEssence:Show(self.vb.drainCount)
		local timer = allTimers[difficultyName][spellId][self.vb.phase]
		if timer then
			timerDrainEssenceCD:Start(timer)
		end
	elseif spellId == 346690 then
		local timer = allTimers[difficultyName][spellId][self.vb.phase]
		if timer then
			timerDualistsRiposteCD:Start(timer)
		end
	elseif spellId == 337110 then--Cast in sets of 2 or 3
		if self:AntiSpam(12, 4) then
			self.vb.volleyCast = 0
		end
		self.vb.volleyCast = self.vb.volleyCast + 1
		local count = self.vb.volleyCast
		if self.Options.SpecWarn337110interruptcount then
			specWarnDreadboltVolley:Show(args.sourceName, count)
			if count == 1 then
				specWarnDreadboltVolley:Play("kick1r")
			elseif count == 2 then
				specWarnDreadboltVolley:Play("kick2r")
			elseif count == 3 then
				specWarnDreadboltVolley:Play("kick3r")
			else--fallback, shouldn't happen but never know
				specWarnDreadboltVolley:Play("kickcast")
			end
		else
			warnDreadboltVolley:Show(count)
		end
	elseif spellId == 346657 then
		specWarnPridefulEruption:Show()
		specWarnPridefulEruption:Play("scatter")
		local timer = allTimers[difficultyName][spellId][self.vb.phase]
		if timer then
			timerPridefulEruptionCD:Start(timer)
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(8)
		end
	elseif spellId == 346762 then
		local timer = allTimers[difficultyName][spellId][self.vb.phase]
		if timer then
			timerSoulSpikesCD:Start(timer)
		end
	elseif spellId == 346303 then
		if self.Options.NPAuraOnUproar then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId, nil, 15)
		end
	elseif spellId == 346790 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
--		local addnumber, count = self.vb.darkManifestationCount, castsPerGUID[args.sourceGUID]
		local count = castsPerGUID[args.sourceGUID]
		warnSintouchedBlade:Show(count)--addnumber.."-"..
--		timerSintouchedBladeCD:Start(12.1, count+1, args.sourceGUID)
	elseif spellId == 346698 then
		if self.Options.SpecWarn346698switch then
			specWarnDutifulAttendant:Show()
			specWarnDutifulAttendant:Play("killmob")
		else
			warnDutifulAttendant:Show()
		end
		if args:GetSrcCreatureID() == 166971 then--Main boss
			local timer = allTimers[difficultyName][spellId][self.vb.phase]
			if timer then
				timerDutifulAttendantCD:Start(timer)
			end
		else
			timerDutifulAttendantCD:Start(self.vb.phase == 2 and 44.9 or 36.2)--Mythic only, and yes two diff timers in last test
			timerDutifulAttendantCD:UpdateInline(DBM_COMMON_L.MYTHIC_ICON)
		end
		if self.Options.SetIconOnDutiful then
			self:ScanForMobs(175992, 2, 8, 1, nil, 25, "SetIconOnDutiful")--creatureID, iconSetMethod, mobIcon, maxIcon, scanInterval, scanningTime, optionName
		end
	elseif spellId == 346800 then
		specWarnWaltzofBlood:Show()
		specWarnWaltzofBlood:Play("watchstep")
		local timer = allTimers[difficultyName][spellId][self.vb.phase]
		if timer then
			timerWaltzofBloodCD:Start(timer)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if (spellId == 347376 or spellId == 330959) and self:AntiSpam(10, 1) then
		specWarnDanseMacabre:Show()
		specWarnDanseMacabre:Play("specialsoon")
		--Automatic timer extending.
		--After many rounds of testing blizzard finally listened to feedback and suspends active CD timers during dance
		--Castellan Niklaus
--		danceDurationFix = GetTime()
		--Over adds time to all timers just to keep them from expiring
		--This is then corrected later after knowing exact time of dance
		timerDancingFeverCD:Stop()
		if self:IsFated() then
			self:AffixEvent(0)--Stop Affix Bars
		end
		if not self.vb.nikDead then
			timerDutifulAttendantCD:Pause()--Alive and dead ability
			timerDualistsRiposteCD:Pause()
			if self.vb.phase >= 2 then--1 Dead
				timerDredgerServantsCD:Pause()
			end
			if self.vb.phase >= 3 then--1 Dead
				timerCastellansCadreCD:Pause()
			end
		else
			if self:IsMythic() then
				timerDutifulAttendantCD:Pause()
			end
		end
		--Baroness Frieda
		if not self.vb.friedaDead then
--			timerDreadboltVolleyCD:Pause()
			timerDrainEssenceCD:Pause()
			if self.vb.phase >= 2 then--1 Dead
				timerPridefulEruptionCD:Pause()
			end
			if self.vb.phase >= 3 then--2 Dead
				timerSoulSpikesCD:Pause()
			end
		else
--			if self:IsMythic() then
--				timerDreadboltVolleyCD:Pause()
--			end
		end
		--Lord Stavros
		if not self.vb.stavrosDead then
			timerDarkRecitalCD:Pause()
			timerEvasiveLungeCD:Pause()
			if self.vb.phase >= 2 then--1 Dead
				timerWaltzofBloodCD:Pause()
			end
			if self.vb.phase >= 3 then--1 Dead
				timerDancingFoolsCD:Pause()
			end
		else
			if self:IsMythic() then
				timerDarkRecitalCD:Pause()
			end
		end
	elseif spellId == 346657 then
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif spellId == 346303 then
		if self.Options.NPAuraOnUproar then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 330967 then
		warnFixate:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnFixate:Show()
			specWarnFixate:Play("justrun")
			if self.Options.NPAuraOnFixate then
				DBM.Nameplate:Show(true, args.sourceGUID, spellId, nil, 12)
			end
		end
	elseif spellId == 346690 then
		local amount = args.amount or 1
		if amount >= 2 then
			if args:IsPlayer() then
				specWarnDualistsRiposte:Show(amount)
				specWarnDualistsRiposte:Play("stackhigh")
			else
				local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
				local remaining
				if expireTime then
					remaining = expireTime-GetTime()
				end
				if (not remaining or remaining and remaining < 18.7) and not UnitIsDeadOrGhost("player") then
					specWarnDualistsRiposteTaunt:Show(args.destName)
					specWarnDualistsRiposteTaunt:Play("tauntboss")
				else
					warnDualistsRiposte:Show(args.destName, amount)
				end
			end
		else
			warnDualistsRiposte:Show(args.destName, amount)
		end
	elseif spellId == 331636 or spellId == 331637 then
		--Pair offs actually work by 331636 paired with 331637 in each set, but combat log order also works
		darkRecitalTargets[#darkRecitalTargets + 1] = args.destName
		self:Unschedule(warndarkRecitalTargets)
		self:Schedule(0.3, warndarkRecitalTargets, self)
		local icon
		if #darkRecitalTargets % 2 == 0 then
			icon = #darkRecitalTargets / 2--Generate icon on the evens, because then we can divide it by 2 to assign raid icon to that pair
			local playerIsInPair = false
			--TODO, REMOVE me if entire raid doesn't get it on mythic (they probably don't)
			if icon == 9 then
				icon = "(°,,°)"
			elseif icon == 10 then
				icon = "(•_•)"
			end
			if darkRecitalTargets[#darkRecitalTargets-1] == UnitName("player") then
				specWarnDarkRecital:Show(darkRecitalTargets[#darkRecitalTargets])
				specWarnDarkRecital:Play("gather")
				playerIsInPair = true
			elseif darkRecitalTargets[#darkRecitalTargets] == UnitName("player") then
				specWarnDarkRecital:Show(darkRecitalTargets[#darkRecitalTargets-1])
				specWarnDarkRecital:Play("gather")
				playerIsInPair = true
			end
			if playerIsInPair then--Only repeat yell on mythic and mythic
				self:Unschedule(darkRecitalYellRepeater)
				if type(icon) == "number" then icon = DBM_CORE_L.AUTO_YELL_CUSTOM_POSITION:format(icon, "") end
				self:Schedule(2, darkRecitalYellRepeater, self, icon, 0)
				yellDarkRecitalRepeater:Yell(icon)
			end
		end
	elseif (spellId == 332535 or spellId == 346709) and self:AntiSpam(30, spellId == 346709 and 7 or 8) then--Infused/Empowered
		self:Unschedule(phaseChange)
		phaseChange(self, 0)--true phase change, more accurate timers, but sometimes missing from combat log
	elseif spellId == 346694 then
		if self.Options.NPAuraOnShield then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 347350 then
		self.vb.feversActive = self.vb.feversActive + 1
		warnDancingFever:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			yellDancingFever:Countdown(spellId)
		end
		if self:AntiSpam(5, 6) then
			self.vb.feverCast = self.vb.feverCast + 1
			timerDancingFeverCD:Start(60, self.vb.feverCast+1)
		end
		FeverStacks[args.destName] = 3
		if self.Options.InfoFrame then
			if not DBM.InfoFrame:IsShown() then
				DBM.InfoFrame:SetHeader(args.spellName)
				DBM.InfoFrame:Show(20, "table", FeverStacks, 1)
			else
				DBM.InfoFrame:UpdateTable(FeverStacks)
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 330967 and args:IsPlayer() then
		if self.Options.NPAuraOnFixate then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	elseif spellId == 331636 or spellId == 331637 then
		if args:IsPlayer() then
			self:Unschedule(darkRecitalYellRepeater)
		end
	elseif spellId == 346694 then
		if self.Options.NPAuraOnShield then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 330959 and self:AntiSpam(10, 2) then
		warnDanceOver:Show()
		if self:IsFated() then
			self:AffixEvent(1, 2)--Restart Affix Bars
		end
		--Hack to remove the over timing of dance phases
--		local danceDuration = GetTime() - danceDurationFix--Remove after testing of pause/resume
--		local adjustment = 50-danceDuration--Remove after testing of pause/resume
		if not self.vb.nikDead then
			timerDutifulAttendantCD:Resume()--Alive and dead ability
			timerDualistsRiposteCD:Resume()
			if self.vb.phase >= 2 then--1 Dead
				timerDredgerServantsCD:Resume()
			end
			if self.vb.phase >= 3 then--1 Dead
				timerCastellansCadreCD:Resume()
			end
		else
			if self:IsMythic() then
				timerDutifulAttendantCD:Resume()
			end
		end
		--Baroness Frieda
		if not self.vb.friedaDead then
--			timerDreadboltVolleyCD:Resume()
			timerDrainEssenceCD:Resume()
			if self.vb.phase >= 2 then--1 Dead
				timerPridefulEruptionCD:Resume()
			end
			if self.vb.phase >= 3 then--2 Dead
				timerSoulSpikesCD:Resume()
			end
		else
--			if self:IsMythic() then
--				timerDreadboltVolleyCD:Resume()
--			end
		end
		--Lord Stavros
		if not self.vb.stavrosDead then
			timerDarkRecitalCD:Resume()
			timerEvasiveLungeCD:Resume()
			if self.vb.phase >= 2 then--1 Dead
				timerWaltzofBloodCD:Resume()
			end
			if self.vb.phase >= 3 then--1 Dead
				timerDancingFoolsCD:Resume()
			end
		else
			if self:IsMythic() then
				timerDarkRecitalCD:Resume()
			end
		end
		if self:IsMythic() then
			timerDancingFeverCD:Start(5.5, self.vb.feverCast+1)
		end
	elseif spellId == 347350 then
		self.vb.feversActive = self.vb.feversActive - 1
		if args:IsPlayer() then
			yellDancingFever:Cancel()
		end
		FeverStacks[args.destName] = nil
		if self.Options.InfoFrame then
			if self.vb.feversActive > 0 then
				DBM.InfoFrame:UpdateTable(FeverStacks)
			else
				DBM.InfoFrame:Hide()
			end
		end
	end
end

function mod:SPELL_AURA_REMOVED_DOSE(args)
	local spellId = args.spellId
	if spellId == 347350 then
		FeverStacks[args.destName] = args.amount or 1
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(FeverStacks)
		end
	end
end

--https://shadowlands.wowhead.com/npc=169925/begrudging-waiter
--https://shadowlands.wowhead.com/npc=168406/waltzing-venthyr
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 166971 then--Castellan Niklaus
		self.vb.nikDead = true
		timerDualistsRiposteCD:Stop()
		timerDutifulAttendantCD:Stop()
		timerDredgerServantsCD:Stop()
		--Less accurate phase change, but backup if the true phase change infusion/empowerment events are missing
		self:Unschedule(phaseChange)
		if self.vb.phase < 3 then
			self:Schedule(5, phaseChange, self, 2)
		end
	elseif cid == 166969 then--Baroness Frieda
		self.vb.friedaDead = true
		timerDrainEssenceCD:Stop()
--		timerDreadboltVolleyCD:Stop()
		timerPridefulEruptionCD:Stop()
		--Less accurate phase change, but backup if the true phase change infusion/empowerment events are missing
		self:Unschedule(phaseChange)
		if self.vb.phase < 3 then
			self:Schedule(5, phaseChange, self, 2)
		end
	elseif cid == 166970 then--Lord Stavros
		self.vb.stavrosDead = true
		timerEvasiveLungeCD:Stop()
		timerWaltzofBloodCD:Stop()
		timerDarkRecitalCD:Stop()
		timerDancingFoolsCD:Stop()
		--Less accurate phase change, but backup if the true phase change infusion/empowerment events are missing
		self:Unschedule(phaseChange)
		if self.vb.phase < 3 then
			self:Schedule(5, phaseChange, self, 2)
		end
	elseif cid == 168406 then--Waltzing Venthyr
		if self.Options.NPAuraOnUproar then
			DBM.Nameplate:Hide(true, args.destGUID, 346303)
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 346945 and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 346826 then--Dancing Fools
		if self.Options.SpecWarn330964switch then
			specWarnDancingFools:Show()
			specWarnDancingFools:Play("killmob")
		else
			warnDancingFools:Show()
		end
		local timer = allTimers[difficultyName][spellId][self.vb.phase]
		if timer then
			timerDancingFoolsCD:Start(timer)
		end
		if self.Options.SetIconOnDancingFools then
			self:RegisterShortTermEvents(
				"NAME_PLATE_UNIT_ADDED",
				"FORBIDDEN_NAME_PLATE_UNIT_ADDED"
			)
		end
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if msg:find("spell:337110") then
		if self.Options.SetIconOnImage  then
			self:ScanForMobs(172803, 2, 6, 1, nil, 10, "SetIconOnImage")--creatureID, iconSetMethod, mobIcon, maxIcon, scanInterval, scanningTime, optionName
		end
		local timer = allTimers[difficultyName][337110][self.vb.phase]
		if timer then
			timerDreadboltVolleyCD:Start(timer)
		end
	end
end

--This assumes the real one is only one with nameplate. Based on video it appears so
--But that doesn't mean other units don't have nameplates that blizzard just adjusted z axis on so it's off the screen.
function mod:NAME_PLATE_UNIT_ADDED(unit)
	if unit then
		local guid = UnitGUID(unit)
		if not guid then return end
		local cid = self:GetCIDFromGUID(guid)
		if cid == 176026 then
			if not GetRaidTargetIndex(unit) then
				self:SetIcon(unit, 8)
			end
			self:UnregisterShortTermEvents()
		end
	end
end
mod.FORBIDDEN_NAME_PLATE_UNIT_ADDED = mod.NAME_PLATE_UNIT_ADDED
