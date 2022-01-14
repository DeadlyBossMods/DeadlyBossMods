local mod	= DBM:NewMod(2460, "DBM-Sepulcher", nil, 1195)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(181548, 181551, 181546, 181549)
mod:SetEncounterID(2544)
mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
mod:SetHotfixNoticeRev(20220111000000)
mod:SetMinSyncRevision(20220111000000)
--mod.respawnTime = 29
mod.NoSortAnnounce = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 360295 360636 365272 361066 360845 364241 361304 361568 365126 366062 361300",
	"SPELL_CAST_SUCCESS 361745 361278",
	"SPELL_SUMMON 361566 360333",
	"SPELL_AURA_APPLIED 360687 365269 361067 362352 361608 361689 364839 366234 361745 366159",
	"SPELL_AURA_APPLIED_DOSE 361608",
	"SPELL_AURA_REMOVED 360687 361067 361278 361608 361745",
	"SPELL_AURA_REMOVED_DOSE 361608 361689 366159",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4"
)

--TODO, warn on pinning volley emote instead (pre warning instead of warning when channel starts)
--TODO, warn on Wild Stampede emote instead?
--TODO, Find Phase 3 cd of necrotic ritual (between casts)
--TODO, maybe add https://ptr.wowhead.com/spell=362270/anima-shelter tracking to infoframe? seems like might already be crowded though just monitoring sin stacks and deathtouch
--TODO, tanks wap for Wracking Pain? Feels like tank should just eat it vs putting 2 bosses on one tank for only 25%
--[[
(ability.id = 360295 or ability.id = 360636 or ability.id = 365272 or ability.id = 361066 or ability.id = 361304 or ability.id = 361568 or ability.id = 365126 or ability.id = 361300 or ability.id = 366062) and type = "begincast"
 or (ability.id = 361278 or ability.id = 361745 or ability.id = 361789) and type = "cast" or ability.id = 360838
 or (ability.id = 366234) and (type = "applybuff" or type = "applydebuff")
 or (ability.id = 360845 or ability.id = 361044) and type = "begincast"
--]]
local ProtoWar, ProtoDuty, ProtoRenewl, ProtoAbsolution = DBM:EJ_GetSectionInfo(24125), DBM:EJ_GetSectionInfo(24130), DBM:EJ_GetSectionInfo(24135), DBM:EJ_GetSectionInfo(24139)
--General
local warnCompleteRecon							= mod:NewCastAnnounce(366062, 4)
--Stage One: War and Duty
----Prototype of War
mod:AddOptionLine(ProtoWar, "announce")
local warnRunecarversDeathtouch					= mod:NewTargetNoFilterAnnounce(360687, 3)
----Prototype of Duty
mod:AddOptionLine(ProtoDuty, "announce")
local warnAscensionsCall						= mod:NewCountAnnounce(361066, 2)
local warnBastionsWard							= mod:NewCastAnnounce(360845, 1)
local warnPinned								= mod:NewTargetNoFilterAnnounce(362352, 4)
--Stage Two: Sin and Seed
----Prototype of Absolution
local warnNightHunter							= mod:NewTargetNoFilterAnnounce(361745, 3)

--Stage One: War and Duty
----Prototype of War
mod:AddOptionLine(ProtoWar, "specialannounce")
mod:AddOptionLine(ProtoWar, "yell")
local specWarnNecroticRitual					= mod:NewSpecialWarningSwitchCount(360295, "-Healer", nil, nil, 1, 2)
local specWarnDeathtouch						= mod:NewSpecialWarningMoveAway(360687, nil, nil, nil, 1, 2)
local yellDeathtouch							= mod:NewShortPosYell(360687)
----Prototype of Duty
mod:AddOptionLine(ProtoDuty, "specialannounce")
mod:AddOptionLine(ProtoDuty, "yell")
local specWarnHumblingStrikes					= mod:NewSpecialWarningDefensive(365272, nil, nil, nil, 1, 2)
local specWarnHumblingStrikesTaunt				= mod:NewSpecialWarningTaunt(365269, nil, nil, nil, 1, 2)
local specWarnPinningVolley						= mod:NewSpecialWarningDodgeCount(361278, nil, nil, nil, 2, 2)--Is it dodgeable?
local yellPinned								= mod:NewShortYell(362352)
--Stage Two: Sin and Seed
----Prototype of Renewal
mod:AddOptionLine(ProtoRenewl, "specialannounce")
--mod:AddOptionLine(ProtoRenewl, "yell")
local specWarnAnimabolt							= mod:NewSpecialWarningInterrupt(362383, false, nil, nil, 1, 2)--Kinda spammed, opt in, not opt out
local specWarnWildStampede						= mod:NewSpecialWarningDodgeCount(361304, nil, nil, nil, 2, 2)
local specWarnAnimastorm						= mod:NewSpecialWarningMoveTo(362132, nil, nil, nil, 2, 2)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)
----Prototype of Absolution
mod:AddOptionLine(ProtoAbsolution, "specialannounce")
--mod:AddOptionLine(ProtoRenewl, "yell")
local specWarnSinfulProjection					= mod:NewSpecialWarningMoveAway(364839, nil, nil, nil, 2, 2)--Sound 2 because everyone gets it
local specWarnWrackingPain						= mod:NewSpecialWarningCount(365126, nil, nil, nil, 1, 2)--Change to moveto?
local specWarnHandofDestruction					= mod:NewSpecialWarningRun(361789, nil, nil, nil, 4, 2)
local specWarnNightHunter						= mod:NewSpecialWarningYou(361745, nil, nil, nil, 1, 2, 4)--Nont moveto, because it's kind of RLs perogative to prioritize seeds or ritualists if both up, don't want to make that call
local yellNightHunter							= mod:NewShortPosYell(361745)
local yellNightHunterFades						= mod:NewIconFadesYell(361745)

--mod:AddTimerLine(BOSS)

local timerCompleteRecon						= mod:NewCastTimer(20, 366062, nil, nil, nil, 5, nil, DBM_COMMON_L.DAMAGE_ICON)
--Stage One: War and Duty
----Prototype of War
mod:AddTimerLine(ProtoWar)
local timerNecroticRitualCD						= mod:NewCDCountTimer(71.4, 360295, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerRunecarversDeathtouchCD				= mod:NewCDCountTimer(57.1, 360687, nil, nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)
----Prototype of Duty
mod:AddTimerLine(ProtoDuty)
local timerHumblingStrikesCD					= mod:NewCDCountTimer(35.7, 365272, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerAscensionsCallCD						= mod:NewCDCountTimer(57.1, 365272, nil, nil, nil, 1)
local timerPinningVolleyCD						= mod:NewCDCountTimer(64.1, 361278, nil, nil, nil, 3)
--Stage Two: Sin and Seed
----Prototype of Renewal
mod:AddTimerLine(ProtoRenewl)
local timerWildStampedeCD						= mod:NewCDCountTimer(28.8, 361304, nil, nil, nil, 3)
local timerWitheringSeedCD						= mod:NewCDCountTimer(96.2, 361568, nil, "Healer", nil, 5, nil, DBM_COMMON_L.HEALER_ICON)
local timerAnimastormCD							= mod:NewCDCountTimer(28.8, 366234, nil, nil, nil, 2)
----Prototype of Absolution
mod:AddTimerLine(ProtoAbsolution)
local timerWrackingPainCD						= mod:NewCDCountTimer(44, 365126, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerHandofDestructionCD					= mod:NewCDCountTimer(56.2, 361789, nil, nil, nil, 2)--Also timer for sinful projections, the two mechanics are intertwined
local timerNightHunterCD						= mod:NewAITimer(57.1, 361745, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)

--local berserkTimer							= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption("8")
mod:AddInfoFrameOption(360687, true)
mod:AddNamePlateOption("NPAuraOnImprintedSafeguards", 366159, true)--Hostile only, can't anchor to friendly nameplates in raid (seeds)
mod:AddIconLine(ProtoWar)
mod:AddSetIconOption("SetIconOnDeathtouch", 360687, false, false, {9, 10, 11, 12}, true)--Technically only 2 debuffs go out, but we allow for even a bad group to have two sets of them out. Off by default do to conflict with seeds
mod:AddSetIconOption("SetIconOnRitualist", 360333, true, true, {5, 6, 7, 8})
mod:AddIconLine(ProtoRenewl)
mod:AddSetIconOption("SetIconOnSeed", 361566, true, true, {1, 2, 3, 4})
mod:AddNamePlateOption("NPAuraOnWrackingPain", 361689, true)
mod:AddIconLine(ProtoAbsolution)
mod:AddSetIconOption("SetIconOnNightHunter", 361745, false, false, {1, 2, 3, 4})--Conflicts with seeds, off by default

local deathtouchTargets = {}
local wardTargets = {}
local SinStacks = {}
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
mod.vb.hunterIcon = 1
mod.vb.ritualistIcon = 8

local difficultyName = "None"
local allTimers = {
	["lfr"] = {--LFR data as of 1-7-22
		[1] = {
			--Necrotic Ritual
			[360295] = {11.8, 76.9},
			--Runecarver's Deathtouch
			[360636] = {50.8, 61.5},
			--Humbling Strikes
			[365272] = {12.3, 38.5, 38.4, 38.5},
			--Ascension's Call
			[361066] = {46.2, 61.5},
			--Pinning Volley
			[361278] = {67.9, 69.2},
			--Night Hunter (Mythic Only)
			[361745] = {},
		},
		[2] = {
			--Wild Stampede
			[361304] = {14.7, 50.0, 33.3, 33.3},
			--Withering Seeds
			[361568] = {26.0, 128.3, 68.4},
			--Animastorm
			[366234] = {52.6, 90.0},
			--Wracking Pain
			[365126] = {36.0, 58.4, 60.0},
			--Hand of Destruction
			[361791] = {107.7, 75.0},
			--Night Hunter (Mythic Only)
			[361745] = {},
		},
		[3] = {
			--Necrotic Ritual
			[360295] = {52.6},
			--Runecarver's Deathtouch
			[360636] = {106.3},
			--Humbling Strikes
			[365272] = {33.9, 40.0},
			--Ascension's Call
			[361066] = {97.8, 100.0},
			--Pinning Volley
			[361278] = {56.7, 105.7},
			--Wild Stampede
			[361304] = {35.8, 46.7, 47.0, 47.8},
			--Withering Seeds
			[361568] = {15.2, 73.3, 74.0, 57.4},
			--Animastorm
			[366234] = {24.5, 94.0, 92.7},
			--Wracking Pain
			[365126] = {33.9, 40.0, 40.0, 40.0, 40.0, 42.7},
			--Hand of Destruction
			[361791] = {84.5, 100.0},
			--Night Hunter (Mythic Only)
			[361745] = {},
		},
	},
	["normal"] = {
		[1] = {

		},
		[2] = {

		},
		[3] = {

		},
	},
	["heroic"] = {
		[1] = {

		},
		[2] = {

		},
		[3] = {

		},
	},
	["mythic"] = {
		[1] = {

		},
		[2] = {

		},
		[3] = {

		},
	},
}

local updateInfoFrame
do
	local tsort, twipe = table.sort, table.wipe
	local lines, sortedLines = {}, {}
	local tempLines, tempLinesSorted = {}, {}
	local function sortFuncDesc(a, b) return tempLines[a] > tempLines[b] end
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
		--Second, Sin stacks
		local hasSin = false
		for uId in DBM:GetGroupMembers() do
			local unitName = DBM:GetUnitFullName(uId)
			local count = SinStacks[unitName]
			if count then
				if not hasSin then
					hasSin = true
					addLine(L.Sin, L.Stacks)--Set header for this section
				end
				tempLines[unitName] = count
				tempLinesSorted[#tempLinesSorted + 1] = unitName
			end
		end
		--Sort Sin debuffs by highest then inject into regular table
		if hasSin then
			tsort(tempLinesSorted, sortFuncDesc)
			for _, name in ipairs(tempLinesSorted) do
				addLine(name, tempLines[name])
			end
		end
		return lines, sortedLines
	end
end

function mod:OnCombatStart(delay)
	table.wipe(deathtouchTargets)
	table.wipe(wardTargets)
	table.wipe(SinStacks)
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
	self.vb.hunterIcon = 1
	self.vb.ritualistIcon = 8
	self:SetStage(1)
	--Necro
	timerNecroticRitualCD:Start(11.5-delay)
	timerRunecarversDeathtouchCD:Start(50-delay)--47.2
	--Kyrian
	timerHumblingStrikesCD:Start(10-delay)
	timerAscensionsCallCD:Start(42.9-delay)--Time til USCS anyways
	timerPinningVolleyCD:Start(63-delay)
	if self:IsMythic() then
--		difficultyName = "mythic"
		timerNightHunterCD:Start(1-delay)
--	elseif self:IsHeroic() then
--		difficultyName = "heroic"--Temp setting all diff to heroic until confirmed timers differ
--	elseif self:IsNormal() then
--		difficultyName = "normal"
--	else
--		difficultyName = "lfr"
	end
	difficultyName = "lfr"--TEMP, will be removed if all the same, or moved if all different
	if self:IsMythic() then
		timerNightHunterCD:Start(1-delay)
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(OVERVIEW)
		DBM.InfoFrame:Show(26, "function", updateInfoFrame, false, true, true)--26 to show up to 4 debuffs and 20 sin stacks plus 2 headers
	end
	if self.Options.NPAuraOnWrackingPain or self.Options.NPAuraOnImprintedSafeguards then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
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
--	if self:IsMythic() then
--		difficultyName = "mythic"
--	elseif self:IsHeroic() then
--		difficultyName = "heroic"--Temp setting all diff to heroic until confirmed timers differ
--	elseif self:IsNormal() then
--		difficultyName = "normal"
--	else
--		difficultyName = "lfr"
--	end
	difficultyName = "lfr"--TEMP, will be removed if all the same, or moved if all different
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 360295 then
		self.vb.ritualCount = self.vb.ritualCount + 1
		self.vb.ritualistIcon = 8
		specWarnNecroticRitual:Show(self.vb.ritualCount)
		specWarnNecroticRitual:Play("killmob")
		local timer = allTimers[difficultyName][self.vb.phase][spellId][self.vb.ritualCount+1]
		if timer then
			timerNecroticRitualCD:Start(timer, self.vb.ritualCount+1)
		end
	elseif spellId == 360636 then
		self.vb.deathtouchCount = self.vb.deathtouchCount + 1
		local timer = allTimers[difficultyName][self.vb.phase][spellId][self.vb.deathtouchCount+1]
		if timer then
			timerRunecarversDeathtouchCD:Start(timer, self.vb.deathtouchCount+1)
		end
	elseif spellId == 365272 then
		self.vb.humblingCount = self.vb.humblingCount + 1
		if self:IsTanking("player", nil, nil, nil, args.sourseGUID) then--GUID scan since this can probbably be any of boss 1-4
			specWarnHumblingStrikes:Show()
			specWarnHumblingStrikes:Play("defensive")
		end
		local timer = allTimers[difficultyName][self.vb.phase][spellId][self.vb.humblingCount+1]
		if timer then
			timerHumblingStrikesCD:Start(timer, self.vb.humblingCount+1)
		end
	elseif spellId == 361066 then
		DBM:AddMsg("Ascensions call added back to combat log, notify DBM authors")
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
		local timer = allTimers[difficultyName][self.vb.phase][spellId][self.vb.stampedeCount+1]
		if timer then
			timerWildStampedeCD:Start(timer, self.vb.stampedeCount+1)
		end
	elseif spellId == 361568 then
		self.vb.seedCount = self.vb.seedCount + 1
		self.vb.seedIcon = 1
		local timer = allTimers[difficultyName][self.vb.phase][spellId][self.vb.seedCount+1]
		if timer then
			timerWitheringSeedCD:Start(timer, self.vb.seedCount+1)
		end
	elseif spellId == 365126 then
		self.vb.painCount = self.vb.painCount + 1
		if self:IsTanking("player", nil, nil, nil, args.sourseGUID) then--GUID scan since this can probbably be any of boss 1-4
			specWarnWrackingPain:Show(self.vb.painCount)
			specWarnWrackingPain:Play("shockwave")
		end
		local timer = allTimers[difficultyName][self.vb.phase][spellId][self.vb.painCount+1]
		if timer then
			timerWrackingPainCD:Start(timer, self.vb.painCount+1)
		end
	elseif spellId == 366062 then
		warnCompleteRecon:Show()
		timerCompleteRecon:Start()
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
			--Prototype of Absolution (Venthyr)
			timerWrackingPainCD:Start(36)
			timerHandofDestructionCD:Start(107.7, 1)
			--prototype-of-renewal (Night Fae)
			timerWildStampedeCD:Start(14.6)
			timerWitheringSeedCD:Start(26)
			timerAnimastormCD:Start(52.6)
			if self:IsMythic() then
				timerNightHunterCD:Stop()--In case it's not properly cleared by clearalldebuffs
				timerNightHunterCD:Start(2)
			end
		else--Stage 3
			--Prototype of Absolution (Venthyr)
			timerWrackingPainCD:Start(33.9)
			timerHandofDestructionCD:Start(84.5, 1)
			--prototype-of-duty (Kyrian)
			timerHumblingStrikesCD:Start(33.9)
			timerPinningVolleyCD:Start(56.7)
			timerAscensionsCallCD:Start(97.8)
			--prototype-of-renewal (Night Fae)
			timerWitheringSeedCD:Start(15.2)
			timerAnimastormCD:Start(24.5)
			timerWildStampedeCD:Start(35.8)
			--prototype-of-war (Necro)
			timerNecroticRitualCD:Start(52.6)
			timerRunecarversDeathtouchCD:Start(106.3)
			if self:IsMythic() then
				timerNightHunterCD:Stop()--In case it's not properly cleared by clearalldebuffs
				timerNightHunterCD:Start(3)
			end
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 361745 then
		self.vb.nightCount = self.vb.nightCount + 1
		self.vb.hunterIcon = 1
		timerNightHunterCD:Start()--TEMP WHILE IT'S AI TIMER
--		local timer = allTimers[difficultyName][self.vb.phase][spellId][self.vb.nightCount+1]
--		if timer then
--			timerNightHunterCD:Start(timer, self.vb.nightCount+1)
--		end
	elseif spellId == 361278 then
		self.vb.volleyCount = self.vb.volleyCount + 1
		specWarnPinningVolley:Show(self.vb.volleyCount)
		specWarnPinningVolley:Play("watchstep")
		local timer = allTimers[difficultyName][self.vb.phase][spellId][self.vb.volleyCount+1]
		if timer then
			timerPinningVolleyCD:Start(timer, self.vb.volleyCount+1)
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
		self.vb.ritualistIcon = self.vb.ritualistIcon - 1--Descending from 8
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
	elseif spellId == 361608 then
		local amount = args.amount or 1
		SinStacks[args.destName] = amount
		if DBM.InfoFrame:IsShown() then
			DBM.InfoFrame:Update(0.4)--400ms batching to batch initial application and safe a lot of cpu
		end
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
		local timer = allTimers[difficultyName][self.vb.phase][spellId][self.vb.animaCount+1]
		if timer then
			timerAnimastormCD:Start(timer, self.vb.animaCount+1)
		end
	elseif spellId == 361745 then
		local icon = self.vb.hunterIcon
		if self.Options.SetIconOnNightHunter then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnNightHunter:Show()
			specWarnNightHunter:Play("targetyou")
			yellNightHunter:Yell(icon, icon)
			yellNightHunterFades:Countdown(spellId, 7, icon)
		end
		warnNightHunter:CombinedShow(0.3, args.destName)
		self.vb.hunterIcon = self.vb.hunterIcon + 1
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
	elseif spellId == 361608 then
		SinStacks[args.destName] = nil
		if self.Options.InfoFrame then
			DBM.InfoFrame:Update()
		end
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

function mod:SPELL_AURA_REMOVED_DOSE(args)
	local spellId = args.spellId
	if spellId == 361608 then
		SinStacks[args.destName] = args.amount or 1
		if self.Options.InfoFrame then
			DBM.InfoFrame:Update()
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
--	elseif cid == 182045 then--Necrotic Ritual Skeletons

	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 340324 and destGUID == UnitGUID("player") and not playerDebuff and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

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
	elseif spellId == 361066 then--Ascension's Call
		self.vb.callCount = self.vb.callCount + 1
		warnAscensionsCall:Show(self.vb.callCount)
		local timer = allTimers[difficultyName][self.vb.phase][spellId][self.vb.callCount+1]
		if timer then
			timerAscensionsCallCD:Start(timer, self.vb.callCount+1)
		end
	elseif spellId == 361791 and self:AntiSpam(10, 10) then--Script Activating to cast Hand of Destruction (2 sec faster than SUCCESS 361789)
		self.vb.handCount = self.vb.handCount + 1
		specWarnHandofDestruction:Show()
		specWarnHandofDestruction:Play("justrun")
		local timer = allTimers[difficultyName][self.vb.phase][spellId][self.vb.handCount+1]
		if timer then
			timerHandofDestructionCD:Start(timer, self.vb.handCount+1)
		end
	end
end
