local mod	= DBM:NewMod(2460, "DBM-Sepulcher", nil, 1195)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(181548, 181551, 181546, 181549)
mod:SetEncounterID(2544)
mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
mod:SetHotfixNoticeRev(20220322000000)
mod:SetMinSyncRevision(20220114000000)
--mod.respawnTime = 29
--mod.NoSortAnnounce = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 360295 360636 365272 361066 360845 364241 361304 361568 365126 366062 361300 361789",
	"SPELL_CAST_SUCCESS 361745 361278",
	"SPELL_SUMMON 361566 360333",
	"SPELL_AURA_APPLIED 360687 365269 361067 362352 361689 364839 366234 361745 366159",
	"SPELL_AURA_REMOVED 360687 361067 361278 361745",
	"SPELL_AURA_REMOVED_DOSE 361689 366159",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4"
)

--TODO, warn on pinning volley emote instead (pre warning instead of warning when channel starts)
--TODO, warn on Wild Stampede emote instead?
--TODO, Find Phase 3 cd of necrotic ritual (between casts) and P2 time between wracking pain casts on mythic and tons of others
--TODO, maybe add https://ptr.wowhead.com/spell=362270/anima-shelter tracking to infoframe? seems like might already be crowded though just monitoring sin stacks and deathtouch
--TODO, tanks wap for Wracking Pain? Feels like tank should just eat it vs putting 2 bosses on one tank for only 25%
--TODO, recheck normal mode timers on live for P3 necro dude
--TODO, recheck mythic timers on live
--[[
(ability.id = 360295 or ability.id = 360636 or ability.id = 365272 or ability.id = 361066 or ability.id = 361304 or ability.id = 361568 or ability.id = 365126 or ability.id = 361300 or ability.id = 366062  or ability.id = 361789) and type = "begincast"
 or (ability.id = 361278 or ability.id = 361745) and type = "cast" or ability.id = 360838
 or (ability.id = 366234) and (type = "applybuff" or type = "applydebuff")
 or (ability.id = 360845 or ability.id = 361044) and type = "begincast"
--]]
--General
local warnCompleteRecon							= mod:NewCastAnnounce(366062, 4)

local timerCompleteRecon						= mod:NewCastTimer(20, 366062, nil, nil, nil, 5, nil, DBM_COMMON_L.DAMAGE_ICON)

mod:AddRangeFrameOption("8")
mod:AddNamePlateOption("NPAuraOnImprintedSafeguards", 366159, true)--Hostile only, can't anchor to friendly nameplates in raid (seeds)

----Prototype of War
mod:AddTimerLine(DBM:EJ_GetSectionInfo(24125))
local warnRunecarversDeathtouch					= mod:NewTargetNoFilterAnnounce(360687, 3)

local specWarnNecroticRitual					= mod:NewSpecialWarningSwitchCount(360295, "-Healer", nil, nil, 1, 2)
local specWarnDeathtouch						= mod:NewSpecialWarningMoveAway(360687, nil, nil, nil, 1, 2)
local yellDeathtouch							= mod:NewShortPosYell(360687)

local timerNecroticRitualCD						= mod:NewCDCountTimer(71.4, 360295, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerRunecarversDeathtouchCD				= mod:NewCDCountTimer(57.1, 360687, nil, nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)

mod:AddInfoFrameOption(360687, "Healer")
mod:AddSetIconOption("SetIconOnDeathtouch", 360687, false, false, {1, 2, 3, 4}, true)--Technically only 2 debuffs go out, but we allow for even a bad group to have two sets of them out. Off by default do to conflict with seeds
mod:AddSetIconOption("SetIconOnRitualist", 360295, true, true, {1, 2, 3, 4, 5, 6, 7, 8})--Conflict arg not passed because by default it won't, user has to introduce conflict via dropdown (and that has a warning)
mod:AddMiscLine(DBM_CORE_L.OPTION_CATEGORY_DROPDOWNS)
mod:AddDropdownOption("RitualistIconSetting", {"SetOne", "SetTwo"}, "SetOne", "misc")

----Prototype of Duty
mod:AddTimerLine(DBM:EJ_GetSectionInfo(24130))
local warnAscensionsCall						= mod:NewCountAnnounce(361066, 2)
local warnBastionsWard							= mod:NewCastAnnounce(360845, 1)
local warnPinned								= mod:NewTargetNoFilterAnnounce(362352, 4)

local specWarnHumblingStrikes					= mod:NewSpecialWarningDefensive(365272, nil, 31907, nil, 1, 2)
local specWarnHumblingStrikesTaunt				= mod:NewSpecialWarningTaunt(365272, nil, 31907, nil, 1, 2)
local specWarnPinningVolley						= mod:NewSpecialWarningDodgeCount(361278, nil, nil, nil, 2, 2)--Is it dodgeable?
local yellPinned								= mod:NewShortYell(362352)

local timerHumblingStrikesCD					= mod:NewCDCountTimer(35.7, 365272, 31907, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)--shortname "strike"
local timerAscensionsCallCD						= mod:NewCDCountTimer(57.1, 361066, nil, nil, nil, 1)
local timerPinningVolleyCD						= mod:NewCDCountTimer(64.1, 361278, nil, nil, nil, 3)

mod:GroupSpells(361278, 362352)--Pinning Volley and Pinned
----Prototype of Renewal
mod:AddTimerLine(DBM:EJ_GetSectionInfo(24135))
local specWarnAnimabolt							= mod:NewSpecialWarningInterrupt(362383, false, nil, nil, 1, 2)--Kinda spammed, opt in, not opt out
local specWarnWildStampede						= mod:NewSpecialWarningDodgeCount(361304, nil, nil, nil, 2, 2)
local specWarnAnimastorm						= mod:NewSpecialWarningMoveTo(362132, nil, nil, nil, 2, 2)

local timerWildStampedeCD						= mod:NewCDCountTimer(28.8, 361304, nil, nil, nil, 3)
local timerWitheringSeedCD						= mod:NewCDCountTimer(96.2, 361568, nil, "Healer", nil, 5, nil, DBM_COMMON_L.HEALER_ICON)
local timerAnimastormCD							= mod:NewCDCountTimer(28.8, 362132, nil, nil, nil, 2)

mod:AddSetIconOption("SetIconOnSeed", 361568, true, true, {1, 2, 3, 4}, nil, true)
----Prototype of Absolution
mod:AddTimerLine(DBM:EJ_GetSectionInfo(24139))
local warnNightHunter							= mod:NewTargetNoFilterAnnounce(361745, 3)

local specWarnSinfulProjection					= mod:NewSpecialWarningMoveAway(364839, nil, nil, nil, 2, 2)--Sound 2 because everyone gets it
local specWarnWrackingPain						= mod:NewSpecialWarningCount(365126, nil, nil, nil, 1, 2)--Change to moveto?
local specWarnHandofDestruction					= mod:NewSpecialWarningRun(361789, nil, nil, nil, 4, 2)
local specWarnNightHunter						= mod:NewSpecialWarningYou(361745, nil, nil, nil, 1, 2, 4)--Nont moveto, because it's kind of RLs perogative to prioritize seeds or ritualists if both up, don't want to make that call
local yellNightHunter							= mod:NewShortPosYell(361745)
local yellNightHunterFades						= mod:NewIconFadesYell(361745)

local timerWrackingPainCD						= mod:NewCDCountTimer(44, 365126, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerHandofDestructionCD					= mod:NewCDCountTimer(56.2, 361789, nil, nil, nil, 2)--Also timer for sinful projections, the two mechanics are intertwined
local timerNightHunterCD						= mod:NewAITimer(57.1, 361745, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)

mod:AddNamePlateOption("NPAuraOnWrackingPain", 365126, true)
mod:AddSetIconOption("SetIconOnNightHunter", 361745, false, 2, {1, 2, 3, 4}, true)

local deathtouchTargets = {}
local wardTargets = {}
mod.vb.ritualCount = 0
mod.vb.deathtouchCount = 0
mod.vb.humblingCount = 0
mod.vb.callCount = 0
mod.vb.volleyCount = 0
mod.vb.stampedeCount = 0
mod.vb.seedCount = 0
mod.vb.animaCount = 0
mod.vb.painCount = 0
mod.vb.handCount = 0
mod.vb.nightCount = 0
mod.vb.seedIcon = 1
mod.vb.ritualistIconMethod = 1
mod.vb.ritualistIcon = 8

local difficultyName = mod:IsMythic() and "mythic" or mod:IsHeroic() and "heroic" or mod:IsNormal() and "normmal" or "lfr"
local allTimers = {
	["lfr"] = {--LFR data as of 1-7-22
		[1] = {
			--Necrotic Ritual
			[360295] = {10, 78.9},--2 confirmed
			--Runecarver's Deathtouch
			[360636] = {},--Unknown, whenever first cast is, it's much later than it was in PTR, so all timers scrubbed
			--Humbling Strikes
			[365272] = {10, 38.2, 38.2, 38.2},--2 confirmed, 2 old
			--Ascension's Call
			[361066] = {},--0 confirmed, 2 old ones (46.2, 61.5) removed. not in combat log to confirm easily
			--Pinning Volley
			[361278] = {66.5, 69.2},--1 confirmed, 1 old
		},
		[2] = {--Note, not all are verified, old ones that look like they didn't change, were left from PTR testing
			--Wild Stampede
			[361304] = {14.6, 49.7, 33.3, 33.3},--3 confirmed, 4th old
			--Withering Seeds
			[361568] = {25.8, 128.3, 68.4},--1 confirmed, others old
			--Animastorm
			[366234] = {52.4, 90},--1 confirmed, others old
			--Wracking Pain
			[365126] = {35.8, 58, 60},--2 confirmed, 1 old
			--Hand of Destruction
			[361791] = {107.7, 75},--1 confirmed, 1 old
		},
		[3] = {
			--Necrotic Ritual
			[360295] = {67.2},--1 confirmed
			--Runecarver's Deathtouch
			[360636] = {},--Just not known anymore, it wasn't cast at all in LFR even within a 3 min P3 pull. maybe just yeeted?
			--Humbling Strikes
			[365272] = {43.5, 53.2},--2 confirmed
			--Ascension's Call
			[361066] = {},--97.8, 100.0 Can't in good concious keep these old ones active until confirmed or replaced
			--Pinning Volley
			[361278] = {71.2, 132.1},--1 confirmed, 1 mathed out
			--Wild Stampede
			[361304] = {45.5, 62.8, 62.8, 62.8},--2 confirmed, 2 are extension based on the pattern
			--Withering Seeds
			[361568] = {19.4, 98.9, 98.9, 76.3},--2 confirmed, 2 mathed out
			--Animastorm
			[366234] = {31.1, 124.1, 120.5},--2 confirmed, 1 mathed out
			--Wracking Pain
			[365126] = {43.5, 53.2, 53.2, 53.2},--3 confirmed, 4th added because it's probably repeating
			--Hand of Destruction
			[361791] = {110, 130},--1 confirmed, 1 mathed out
		},
	},
	["normal"] = {
		[1] = {
			--Necrotic Ritual
			[360295] = {10.6, 71.4, 73.3},
			--Runecarver's Deathtouch
			[360636] = {47.1, 55.6, 73.3},
			--Humbling Strikes
			[365272] = {10.6, 35.7, 35.7, 35.6, 35.7},
			--Ascension's Call
			[361066] = {42.8, 57.1},
			--Pinning Volley
			[361278] = {62.7, 64.4},
		},
		[2] = {
			--Wild Stampede
			[361304] = {69, 55.2},
			--Withering Seeds
			[361568] = {32.9},
			--Animastorm
			[366234] = {},--Wasn't cast?
			--Wracking Pain
			[365126] = {41.4, 49.7, 49.7},
			--Hand of Destruction
			[361791] = {104.1},
		},
		[3] = {
			--Necrotic Ritual
			[360295] = {},--Wasn't cast?
			--Runecarver's Deathtouch
			[360636] = {},--Wasn't cast?
			--Humbling Strikes
			[365272] = {41.1, 50},
			--Ascension's Call
			[361066] = {},--Wasn't cast?
			--Pinning Volley
			[361278] = {56.7},
			--Wild Stampede
			[361304] = {26.5, 74.9, 74.3},
			--Withering Seeds
			[361568] = {17.8, 74.1, 76.5},
			--Animastorm
			[366234] = {52.4},
			--Wracking Pain
			[365126] = {41.2, 49.8, 49.8},
			--Hand of Destruction
			[361791] = {105, 74.6},
		},
	},
	["heroic"] = {
		[1] = {
			--Necrotic Ritual
			[360295] = {10.0, 71.5},
			--Runecarver's Deathtouch
			[360636] = {47.7, 57.0},
			--Humbling Strikes
			[365272] = {10.0, 35.7, 35.5, 35.5},
			--Ascension's Call
			[361066] = {42.6, 56.8},
			--Pinning Volley
			[361278] = {63.4},
		},
		[2] = {
			--Wild Stampede
			[361304] = {10.7, 37.3, 25.0, 25.0},
			--Withering Seeds
			[361568] = {18.7, 97.6},
			--Animastorm
			[366234] = {38.5, 67.5},
			--Wracking Pain
			[365126] = {69.7, 45.0, 42.5},
			--Hand of Destruction
			[361791] = {79.7, 56.2},
		},
		[3] = {
			--Necrotic Ritual
			[360295] = {134.0},
			--Runecarver's Deathtouch
			[360636] = {129.0},
			--Humbling Strikes
			[365272] = {41.0, 49.8, 49.8},
			--Ascension's Call
			[361066] = {120.7},
			--Pinning Volley
			[361278] = {56.9, 82.7},
			--Wild Stampede
			[361304] = {26.4, 74.7},
			--Withering Seeds
			[361568] = {18.3, 74.2},
			--Animastorm
			[366234] = {51.0},
			--Wracking Pain
			[365126] = {41.0, 49.8, 49.8},
			--Hand of Destruction
			[361791] = {104.1},
		},
	},
	["mythic"] = {
		[1] = {
			--Necrotic Ritual
			[360295] = {12.5, 59.9},
			--Runecarver's Deathtouch
			[360636] = {41.8, 49.9},
			--Humbling Strikes
			[365272] = {10.6, 31.2, 31.2, 31.2},
			--Ascension's Call
			[361066] = {37.6, 50},
			--Pinning Volley
			[361278] = {56.4, 55.8},
			--Night Hunter (Mythic Only)
			[361745] = {11.9, 61.2},
		},
		[2] = {
			--Wild Stampede
			[361304] = {54.8, 28.4, 28.4},
			--Withering Seeds
			[361568] = {21.5, 109.3, 46.7},
			--Animastorm
			[366234] = {44.2, 76.6},
			--Wracking Pain
			[365126] = {55.6, 51.1, 52.5},
			--Hand of Destruction
			[361791] = {91.1, 63.8},
			--Night Hunter (Mythic Only)
			[361745] = {23, 109.3, 46.2},
		},
		[3] = {
			--Necrotic Ritual
			[360295] = {17.8},
			--Runecarver's Deathtouch
			[360636] = {129},
			--Humbling Strikes
			[365272] = {41, 29.8, 29.8, 29.8, 29.8, 29.8},
			--Ascension's Call
			[361066] = {20.6},
			--Pinning Volley
			[361278] = {55.9, 82.5},
			--Wild Stampede
			[361304] = {26.4, 33.2, 33.7},--Sometimes 2nd one is skipped
			--Withering Seeds
			[361568] = {17.8, 77.8, 71.5},
			--Animastorm
			[366234] = {50.9},
			--Wracking Pain
			[365126] = {41, 29.8, 29.8, 29.8, 29.8, 29.8},
			--Hand of Destruction
			[361791] = {110, 68.4},
			--Night Hunter (Mythic Only)
			[361745] = {21.1, 75.7, 73.7},
		},
	},
}

local updateInfoFrame
do
	local twipe = table.wipe
	local lines, sortedLines = {}, {}
	local function addLine(key, value)
		-- sort by insertion order
		lines[key] = value
		sortedLines[#sortedLines + 1] = key
	end
	updateInfoFrame = function()
		twipe(lines)
		twipe(sortedLines)
		--First, Runecarvers Deathtouch mechanics
		local firstdebuff = false
		for i = 1, 4 do
			if deathtouchTargets[i] then
				if not firstdebuff then
					firstdebuff = true
					addLine(L.Deathtouch, L.Dispel)--Set header for this section
				end
				local name = deathtouchTargets[i]
				if wardTargets[name] then
					addLine(name, "|cFF088A08"..YES.."|r")--Show green for safe dispel
				else
					addLine(name, "|cFFFF0000"..NO.."|r")--Show red for bad dispel
				end
			end
		end
		return lines, sortedLines
	end
end

function mod:OnCombatStart(delay)
	table.wipe(deathtouchTargets)
	table.wipe(wardTargets)
	self.vb.ritualCount = 0
	self.vb.deathtouchCount = 0
	self.vb.humblingCount = 0
	self.vb.callCount = 0
	self.vb.volleyCount = 0
	self.vb.stampedeCount = 0
	self.vb.seedCount = 0
	self.vb.animaCount = 0
	self.vb.painCount = 0
	self.vb.handCount = 0
	self.vb.nightCount = 0
	self.vb.seedIcon = 1
	self.vb.ritualistIconMethod = 1
	self:SetStage(1)
	--Necro
	timerNecroticRitualCD:Start(10-delay, 1)--10-14 on various difficulties (may move this)
	--Kyrian
	timerHumblingStrikesCD:Start(10-delay, 1)--10-11.4 on various difficulties (may move this)
	if self:IsMythic() then
		difficultyName = "mythic"
		--Necro
		timerRunecarversDeathtouchCD:Start(41.5-delay, 1)
		--Kyrian
		timerAscensionsCallCD:Start(37.6-delay, 1)
		timerPinningVolleyCD:Start(55.7-delay, 1)
		--Venthyr
		timerNightHunterCD:Start(11.5-delay, 1)
	elseif self:IsHeroic() then
		difficultyName = "heroic"
		--Necro
		timerRunecarversDeathtouchCD:Start(47.7-delay, 1)--47.2
		--Kyrian
		timerAscensionsCallCD:Start(42.6-delay, 1)--Time til USCS anyways
		timerPinningVolleyCD:Start(63.4-delay, 1)
	elseif self:IsNormal() then
		difficultyName = "normal"
		--Necro
		timerRunecarversDeathtouchCD:Start(47.1-delay, 1)--Sooner than LFR
		--Kyrian
		timerAscensionsCallCD:Start(42.8-delay, 1)--Time til USCS anyways/Same as LFR?
		timerPinningVolleyCD:Start(62.7-delay, 1)--Same as LFR?
	else
		difficultyName = "lfr"
		--Necro
--		timerRunecarversDeathtouchCD:Start(50-delay, 1)--No longer known, due to much higher CD now
		--Kyrian
--		timerAscensionsCallCD:Start(42.9-delay, 1)--No longer known, because can't verify it on WCL
		timerPinningVolleyCD:Start(62.7-delay, 1)
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(OVERVIEW)
		DBM.InfoFrame:Show(26, "function", updateInfoFrame, false, true, true)--26 to show up to 4 debuffs and 20 sin stacks plus 2 headers
	end
	if self.Options.NPAuraOnWrackingPain or self.Options.NPAuraOnImprintedSafeguards then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
	if not self:IsLFR() then
		if self.Options.RitualistIconSetting == "SetOne" then
			self.vb.ritualistIconMethod = 1--Icons 5-8
			if UnitIsGroupLeader("player") then self:SendSync("SetOne") end
		elseif self.Options.RitualistIconSetting == "SetTwo" then
			self.vb.ritualistIconMethod = 2--Icons 1-4
			if UnitIsGroupLeader("player") then self:SendSync("SetTwo") end
		end
	end
end

function mod:NightHunterReturn(uId, icon)
	if UnitIsUnit("player", uId) then
		yellNightHunter:Yell(icon, icon)
		yellNightHunterFades:Countdown(361745, 7, icon)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.NPAuraOnWrackingPain then
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
	if spellId == 360295 then
		self.vb.ritualCount = self.vb.ritualCount + 1
		self.vb.ritualistIcon = self.vb.ritualistIconMethod == 2 and 4 or 8
		specWarnNecroticRitual:Show(self.vb.ritualCount)
		specWarnNecroticRitual:Play("killmob")
		if self.vb.phase then
			local timer = allTimers[difficultyName][self.vb.phase] and allTimers[difficultyName][self.vb.phase][spellId][self.vb.ritualCount+1]
			if timer then
				timerNecroticRitualCD:Start(timer, self.vb.ritualCount+1)
			end
		end
	elseif spellId == 360636 then
		self.vb.deathtouchCount = self.vb.deathtouchCount + 1
		if self.vb.phase then
			local timer = allTimers[difficultyName][self.vb.phase] and allTimers[difficultyName][self.vb.phase][spellId][self.vb.deathtouchCount+1]
			if timer then
				timerRunecarversDeathtouchCD:Start(timer, self.vb.deathtouchCount+1)
			end
		end
	elseif spellId == 365272 then
		self.vb.humblingCount = self.vb.humblingCount + 1
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then--GUID scan since this can probbably be any of boss 1-4
			specWarnHumblingStrikes:Show()
			specWarnHumblingStrikes:Play("defensive")
		end
		if self.vb.phase then
			local timer = allTimers[difficultyName][self.vb.phase] and allTimers[difficultyName][self.vb.phase][spellId][self.vb.humblingCount+1]
			if timer then
				timerHumblingStrikesCD:Start(timer, self.vb.humblingCount+1)
			end
		end
	elseif spellId == 361066 then
		self.vb.callCount = self.vb.callCount + 1
		warnAscensionsCall:Show(self.vb.callCount)
		if self.vb.phase then
			local timer = allTimers[difficultyName][self.vb.phase] and allTimers[difficultyName][self.vb.phase][spellId][self.vb.callCount+1]
			if timer then
				timerAscensionsCallCD:Start(timer, self.vb.callCount+1)
			end
		end
	elseif spellId == 360845 then
		warnBastionsWard:Show()
	elseif spellId == 364241 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnAnimabolt:Show(args.sourceName)
		specWarnAnimabolt:Play("kickcast")
	--"<249.69 23:34:19> [DBM_Debug] CHAT_MSG_RAID_BOSS_EMOTE fired: Prototype of Renewal's Wild Stampede(361304)#2", -- [20927]
	--"<251.50 23:34:21> [CLEU] SPELL_CAST_START#Creature-0-4170-2481-3524-183421-0001BBBDD7#Wild Stampede##nil#361304#Wild Stampede#nil#nil", -- [21128]
	elseif spellId == 361304 then
		self.vb.stampedeCount = self.vb.stampedeCount + 1
		specWarnWildStampede:Show(self.vb.stampedeCount)
		specWarnWildStampede:Play("watchstep")
		if self.vb.phase then
			local timer = allTimers[difficultyName][self.vb.phase] and allTimers[difficultyName][self.vb.phase][spellId][self.vb.stampedeCount+1]
			if timer then
				timerWildStampedeCD:Start(timer, self.vb.stampedeCount+1)
			end
		end
	elseif spellId == 361568 then
		self.vb.seedCount = self.vb.seedCount + 1
		self.vb.seedIcon = 1
		if self.vb.phase then
			local timer = allTimers[difficultyName][self.vb.phase] and allTimers[difficultyName][self.vb.phase][spellId][self.vb.seedCount+1]
			if timer then
				timerWitheringSeedCD:Start(timer, self.vb.seedCount+1)
			end
		end
	elseif spellId == 365126 then
		self.vb.painCount = self.vb.painCount + 1
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then--GUID scan since this can probbably be any of boss 1-4
			specWarnWrackingPain:Show(self.vb.painCount)
			specWarnWrackingPain:Play("shockwave")
		end
		if self.vb.phase then
			local timer = allTimers[difficultyName][self.vb.phase] and allTimers[difficultyName][self.vb.phase][spellId][self.vb.painCount+1]
			if timer then
				timerWrackingPainCD:Start(timer, self.vb.painCount+1)
			end
		end
	elseif spellId == 366062 then
		warnCompleteRecon:Show()
		timerCompleteRecon:Start()
	elseif spellId == 361789 and self:AntiSpam(10, 3) then--Backup in case USCS event is removed/broken
		self.vb.handCount = self.vb.handCount + 1
		specWarnHandofDestruction:Show()
		specWarnHandofDestruction:Play("justrun")
		if self.vb.phase then
			local timer = allTimers[difficultyName][self.vb.phase] and allTimers[difficultyName][self.vb.phase][361791][self.vb.handCount+1]
			if timer then
				timerHandofDestructionCD:Start(timer-2, self.vb.handCount+1)
			end
		end
	elseif spellId == 361300 and self:AntiSpam(4, 1) then--Reconstruction
		self:SetStage(0)
		self.vb.ritualCount = 0
		self.vb.deathtouchCount = 0
		self.vb.humblingCount = 0
		self.vb.callCount = 0
		self.vb.volleyCount = 0
		self.vb.stampedeCount = 0
		self.vb.seedCount = 0
		self.vb.animaCount = 0
		self.vb.painCount = 0
		self.vb.handCount = 0
		self.vb.nightCount = 0
		--Timers stoped in clearalldebuffs cast, here we only start them because that way we can use WCLs to maintain/update them
		if self.vb.phase == 2 then
			if self:IsMythic() then
				--Prototype of Absolution (Venthyr)
				timerWrackingPainCD:Start(55.6, 1)
				timerHandofDestructionCD:Start(91.1, 1)
				--prototype-of-renewal (Night Fae)
				timerWitheringSeedCD:Start(21.5, 1)
				timerAnimastormCD:Start(44.2, 1)
				timerWildStampedeCD:Start(54.8, 1)

				timerNightHunterCD:Stop()--In case it's not properly cleared by clearalldebuffs
				timerNightHunterCD:Start(23)
			elseif self:IsHeroic() then
				--Prototype of Absolution (Venthyr)
				timerWrackingPainCD:Start(69.7, 1)
				timerHandofDestructionCD:Start(79.7, 1)
				--prototype-of-renewal (Night Fae)
				timerWildStampedeCD:Start(10.7, 1)
				timerWitheringSeedCD:Start(18.7, 1)
				timerAnimastormCD:Start(38.5, 1)
			elseif self:IsNormal() then
				--Prototype of Absolution (Venthyr)
				timerWrackingPainCD:Start(41.4, 1)
				timerHandofDestructionCD:Start(104.1, 1)--May need adjusting by 1 sec to match USCS
				--prototype-of-renewal (Night Fae)
				timerWitheringSeedCD:Start(32.9, 1)
				--timerAnimastormCD:Start(52.6, 1)
				timerWildStampedeCD:Start(69, 1)
			else--LFR
				--Prototype of Absolution (Venthyr)
				timerWrackingPainCD:Start(35.8, 1)
				timerHandofDestructionCD:Start(107.7, 1)
				--prototype-of-renewal (Night Fae)
				timerWildStampedeCD:Start(14.6, 1)
				timerWitheringSeedCD:Start(25.8, 1)
				timerAnimastormCD:Start(52.4, 1)
			end
		else--Stage 3
			if self:IsMythic() then
				--Prototype of Absolution (Venthyr)
				timerWrackingPainCD:Start(41, 1)
				timerHandofDestructionCD:Start(110, 1)
				--prototype-of-duty (Kyrian)
				timerAscensionsCallCD:Start(20.6, 1)
				timerHumblingStrikesCD:Start(41, 1)
				timerPinningVolleyCD:Start(55.9, 1)
				--prototype-of-renewal (Night Fae)
				timerWitheringSeedCD:Start(17.8, 1)
				timerWildStampedeCD:Start(26.4, 1)
				timerAnimastormCD:Start(50.9, 1)
				--prototype-of-war (Necro)
				timerNecroticRitualCD:Start(17.8, 1)
				timerRunecarversDeathtouchCD:Start(129, 1)

				timerNightHunterCD:Stop()--In case it's not properly cleared by clearalldebuffs
				timerNightHunterCD:Start(21.1, 1)
			elseif self:IsHeroic() then
				--Prototype of Absolution (Venthyr)
				timerWrackingPainCD:Start(41, 1)
				timerHandofDestructionCD:Start(104.1, 1)
				--prototype-of-duty (Kyrian)
				timerHumblingStrikesCD:Start(41, 1)
				timerPinningVolleyCD:Start(56.9, 1)
				timerAscensionsCallCD:Start(120.7, 1)
				--prototype-of-renewal (Night Fae)
				timerWitheringSeedCD:Start(18.3, 1)
				timerWildStampedeCD:Start(26.4, 1)
				timerAnimastormCD:Start(51, 1)
				--prototype-of-war (Necro)
				timerNecroticRitualCD:Start(134, 1)
				timerRunecarversDeathtouchCD:Start(129, 1)
			elseif self:IsNormal() then
				--Prototype of Absolution (Venthyr)
				timerWrackingPainCD:Start(41.2, 1)
				timerHandofDestructionCD:Start(105, 1)
				--prototype-of-duty (Kyrian)
				timerHumblingStrikesCD:Start(41.1, 1)
				timerPinningVolleyCD:Start(56.7, 1)
				--timerAscensionsCallCD:Start(97.8, 1)--Not in combat log and no P3 transcriptor
				--prototype-of-renewal (Night Fae)
				timerWitheringSeedCD:Start(17.8, 1)
				timerWildStampedeCD:Start(26.5, 1)
				timerAnimastormCD:Start(52.4, 1)
				--prototype-of-war (Necro)
				--timerNecroticRitualCD:Start(52.6, 1)--Wasn't cast?
				--timerRunecarversDeathtouchCD:Start(106.3, 1)--Wasn't cast?
			else--LFR
				--Prototype of Absolution (Venthyr)
				timerWrackingPainCD:Start(43.5, 1)
				timerHandofDestructionCD:Start(110, 1)
				--prototype-of-duty (Kyrian)
				timerHumblingStrikesCD:Start(43.5, 1)
				timerPinningVolleyCD:Start(71.2, 1)
--				timerAscensionsCallCD:Start(97.8, 1)--Unknown
				--prototype-of-renewal (Night Fae)
				timerWitheringSeedCD:Start(19.4, 1)
				timerAnimastormCD:Start(31.1, 1)
				timerWildStampedeCD:Start(45.5, 1)
				--prototype-of-war (Necro)
				timerNecroticRitualCD:Start(67.2, 1)
--				timerRunecarversDeathtouchCD:Start(135, 1)--Maybe doesn't exist, or is cast SUPER late now
			end
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 361745 and self:AntiSpam(5, 2) then
		self.vb.nightCount = self.vb.nightCount + 1
		if self.vb.phase then
			local timer = allTimers[difficultyName][self.vb.phase] and allTimers[difficultyName][self.vb.phase][spellId][self.vb.nightCount+1]
			if timer then
				timerNightHunterCD:Start(timer, self.vb.nightCount+1)
			end
		end
	elseif spellId == 361278 then
		self.vb.volleyCount = self.vb.volleyCount + 1
		specWarnPinningVolley:Show(self.vb.volleyCount)
		specWarnPinningVolley:Play("watchstep")
		if self.vb.phase then
			local timer = allTimers[difficultyName][self.vb.phase] and allTimers[difficultyName][self.vb.phase][spellId][self.vb.volleyCount+1]
			if timer then
				timerPinningVolleyCD:Start(timer, self.vb.volleyCount+1)
			end
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(8)
		end
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 361566 then--Withering Seeds
		if self.Options.SetIconOnSeed then
			self:ScanForMobs(args.destGUID, 2, self.vb.seedIcon, 1, nil, 12, "SetIconOnSeed", true)
		end
		self.vb.seedIcon = self.vb.seedIcon + 1--ascending from 1
	elseif spellId == 360333 then--Necrotic Ritualist
		if self.Options.SetIconOnRitualist then
			self:ScanForMobs(args.destGUID, 2, self.vb.ritualistIcon, 1, nil, 12, "SetIconOnRitualist", true)
		end
		self.vb.ritualistIcon = self.vb.ritualistIcon - 1--Descending from 12, 8, or 4
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 360687 then
		local icon = 0
		local uId = DBM:GetRaidUnitId(args.destName)
		for i = 1, 4 do--Only up to 4 icons
			if not deathtouchTargets[i] then--Not yet assigned!
				icon = i
				deathtouchTargets[i] = args.destName--Assign player name for infoframe even if they already have icon
				local currentIcon = GetRaidTargetIndex(uId) or 9--We want to set "no icon" as max index for below logic
				if currentIcon > i then--Automatically set lowest icon index on target, meaning star favored over circle, circle favored over triangle, etc.
					if self.Options.SetIconOnDeathtouch then--Now do icon stuff, if enabled
						self:SetIcon(args.destName, i)
					end
				end
				break
			end
		end
		if args:IsPlayer() then
			specWarnDeathtouch:Show(self:IconNumToTexture(icon))
			specWarnDeathtouch:Play("targetyou")
			if icon > 0 and icon < 9 then
				yellDeathtouch:Yell(icon, icon)
			end
		end
		warnRunecarversDeathtouch:CombinedShow(0.3, args.destName)
		if DBM.InfoFrame:IsShown() then
			DBM.InfoFrame:Update()
		end
	elseif spellId == 365269 and not args:IsPlayer() then
		specWarnHumblingStrikesTaunt:Show(args.destName)
		specWarnHumblingStrikesTaunt:Play("tauntboss")
	elseif spellId == 361067 then
		wardTargets[args.destName] = true
	elseif spellId == 362352 then
		if args:IsPlayer() then
			yellPinned:Yell()
		end
		warnPinned:CombinedShow(0.5, args.destName)
	elseif spellId == 361689 and args:IsDestTypeHostile() then
		if self.Options.NPAuraOnWrackingPain then
			DBM.Nameplate:Show(true, args.destGUID, spellId, nil, 35)
		end
	elseif spellId == 366159 and args:IsDestTypeHostile() then
		if self.Options.NPAuraOnImprintedSafeguards then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 364839 and args:IsPlayer() then
		specWarnSinfulProjection:Show()
		specWarnSinfulProjection:Play("scatter")
	elseif spellId == 366234 then
		self.vb.animaCount = self.vb.animaCount + 1
		specWarnAnimastorm:Show(DBM_COMMON_L.SHELTER)
		specWarnAnimastorm:Play("findshelter")
		if self.vb.phase then
			local timer = allTimers[difficultyName][self.vb.phase] and allTimers[difficultyName][self.vb.phase][spellId][self.vb.animaCount+1]
			if timer then
				timerAnimastormCD:Start(timer, self.vb.animaCount+1)
			end
		end
	elseif spellId == 361745 then
		if self.Options.SetIconOnNightHunter then
			self:SetSortedIcon("meleeroster", 0.5, args.destName, 1, 4, false, "NightHunterReturn")
		end
		if args:IsPlayer() then
			specWarnNightHunter:Show()
			specWarnNightHunter:Play("targetyou")
			--Icon stuff delayed slightly in the icon sort callback
		end
		warnNightHunter:CombinedShow(0.3, args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 360687 then
		for i = 1, 4 do
			if deathtouchTargets[i] and deathtouchTargets[i] == args.destName then--Found assignment matching this units name
				deathtouchTargets[i] = nil--remove assignment
			end
		end
		if self.Options.SetIconOnDeathtouch then
			self:SetIcon(args.destName, 0)
		end
		if DBM.InfoFrame:IsShown() then
			DBM.InfoFrame:Update()
		end
	elseif spellId == 361067 then
		wardTargets[args.destName] = nil
	elseif spellId == 361278 and self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	elseif spellId == 361689 and args:IsDestTypeHostile() then
		if self.Options.NPAuraOnWrackingPain then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 366159 and args:IsDestTypeHostile() then
		if self.Options.NPAuraOnImprintedSafeguards then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 361745 then
		if self.Options.SetIconOnNightHunter then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellNightHunterFades:Cancel()
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 181548 then--Prototype of Absolution (Venthyr)
		timerWrackingPainCD:Stop()
		timerHandofDestructionCD:Stop()
	elseif cid == 181551 then--prototype-of-duty (Kyrian)
		timerHumblingStrikesCD:Stop()
		timerAscensionsCallCD:Stop()
		timerPinningVolleyCD:Stop()
	elseif cid == 181546 then--prototype-of-renewal (Night Fae)
		timerWildStampedeCD:Stop()
		timerWitheringSeedCD:Stop()
		timerAnimastormCD:Stop()
	elseif cid == 181549 then--prototype-of-war (Necro)
		timerNecroticRitualCD:Stop()
		timerRunecarversDeathtouchCD:Stop()
	end
end

--https://ptr.wowhead.com/spell=365422/ephemeral-exhaust
--https://ptr.wowhead.com/npc=182822 (WitheringSeed)
--https://ptr.wowhead.com/npc=182664 (Wild Stampede)
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 34098 then--ClearAllDebuffs (Boss Leaving)
		local cid = self:GetUnitCreatureId(uId)
		if cid == 181548 then--Prototype of Absolution (Venthyr)
			timerWrackingPainCD:Stop()
			timerHandofDestructionCD:Stop()
			timerNightHunterCD:Stop()
		elseif cid == 181551 then--prototype-of-duty (Kyrian)
			timerHumblingStrikesCD:Stop()
			timerAscensionsCallCD:Stop()
			timerPinningVolleyCD:Stop()
		elseif cid == 181546 then--prototype-of-renewal (Night Fae)
			timerWildStampedeCD:Stop()
			timerWitheringSeedCD:Stop()
			timerAnimastormCD:Stop()
		elseif cid == 181549 then--prototype-of-war (Necro)
			timerNecroticRitualCD:Stop()
			timerRunecarversDeathtouchCD:Stop()
		end
	elseif spellId == 361791 and self:AntiSpam(10, 3) then--Script Activating to cast Hand of Destruction (2 sec faster than SUCCESS 361789)
		self.vb.handCount = self.vb.handCount + 1
		specWarnHandofDestruction:Show()
		specWarnHandofDestruction:Play("justrun")
		if self.vb.phase then
			local timer = allTimers[difficultyName][self.vb.phase] and allTimers[difficultyName][self.vb.phase][spellId][self.vb.handCount+1]
			if timer then
				timerHandofDestructionCD:Start(timer, self.vb.handCount+1)
			end
		end
	end
end

do
	--Delayed function just to make absolute sure RL sync overrides user settings after OnCombatStart functions run
	local function UpdateRLPreference(self, msg)
		if msg == "SetOne" then
			self.vb.ritualistIconMethod = 1
		elseif msg == "SetTwo" then
			self.vb.ritualistIconMethod = 2
		end
	end
	function mod:OnSync(msg)
		if self:IsLFR() then return end--Just in case some shit lord sends syncs in LFR or something, we don't want to trigger DBMConfigMsg
		self:Schedule(3, UpdateRLPreference, self, msg)
	end
end
