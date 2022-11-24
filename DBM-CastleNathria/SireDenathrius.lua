local mod	= DBM:NewMod(2424, "DBM-CastleNathria", nil, 1190)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(167406)
mod:SetEncounterID(2407)
mod:SetUsedIcons(1, 2, 3, 4, 7, 8)
mod:SetHotfixNoticeRev(20210202000000)--2021, 02, 02
mod:SetMinSyncRevision(20201227000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 326707 326851 327227 328117 329181 333932 344776",
	"SPELL_CAST_SUCCESS 327796 329943 339196 330042 326005 332849 333980 332619 329181 333979",
	"SPELL_AURA_APPLIED 326699 327039 327796 327992 329906 332585 329951 332794 329181 344313 338738 181089",
	"SPELL_AURA_APPLIED_DOSE 326699 329906 332585",
	"SPELL_AURA_REMOVED 326699 327039 327796 328117 329951 332794 338738",
	"SPELL_AURA_REMOVED_DOSE 326699",
	"SPELL_PERIODIC_DAMAGE 327992",
	"SPELL_PERIODIC_MISSED 327992",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"
)

--TODO, any reason to track https://shadowlands.wowhead.com/spell=328839 ? gained each ravage cast
--TODO, https://shadowlands.wowhead.com/spell=336008/smoldering-ire need anything special?
--TODO, verify spellIds for two different blood prices, and make sure there isn't overlap/double triggering for any of them
--TODO, handling of https://www.wowhead.com/spell=341391/searing-censure 5 second loop timer
--TODO, likely doing not enough for tank stuff in terms of warnings, probably have to confur with some tanks on best approach
--[[
(ability.id = 326707 or ability.id = 326851 or ability.id = 327227 or ability.id = 328117 or ability.id = 329181 or ability.id = 333932) and type = "begincast"
 or (ability.id = 327796 or ability.id = 329943 or ability.id = 339196 or ability.id = 330042 or ability.id = 326005 or ability.id = 332849 or ability.id = 333980 or ability.id = 332619 or ability.id = 327039 or ability.id = 333979) and type = "cast"
 or (ability.id = 327039 or ability.id = 332794) and type = "applydebuff"
 or ability.id = 328117
 or (source.type = "NPC" and source.firstSeen = timestamp) or (target.type = "NPC" and target.firstSeen = timestamp)
--]]
--General
local warnPhase									= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)

mod:AddInfoFrameOption(nil, true)
--Stage One: Sinners Be Cleansed
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22016))
local warnBloodPrice							= mod:NewCountAnnounce(326851, 4)
local warnFeedingTime							= mod:NewTargetAnnounce(327039, 2)--On this difficulty you don't need to help soak it so don't really NEED to know who it's on
local warnNightHunter							= mod:NewTargetNoFilterAnnounce(327796, 4)--General announce, if target special warning not enabled

local specWarnCleansingPain						= mod:NewSpecialWarningCount(326707, nil, nil, nil, 2, 2)
local specWarnFeedingTime						= mod:NewSpecialWarningMoveAway(327039, nil, nil, nil, 1, 2)--Normal/LFR
local yellFeedingTime							= mod:NewYell(327039)--Normal/LFR
local yellFeedingTimeFades						= mod:NewFadesYell(327039)--Normal/LFR
local specWarnNightHunter						= mod:NewSpecialWarningYouPos(327796, nil, nil, nil, 1, 2, 3)--Heroic/Mythic
local yellNightHunter							= mod:NewShortPosYell(327796)--Heroic/Mythic (not red on purpose, you do NOT want to be anywhere near victim, you want to soak the line before victim)
local yellNightHunterFades						= mod:NewIconFadesYell(327796)--Heroic/Mythic (not red on purpose, you do NOT want to be anywhere near victim, you want to soak the line before victim)
local specWarnNightHunterTarget					= mod:NewSpecialWarningTarget(327796, false, nil, nil, 1, 2, 3)--Opt in, for people who are assigned to this soak
local specWarnCommandRavage						= mod:NewSpecialWarningCount(327227, nil, 327122, nil, 2, 2)
--local specWarnMindFlay						= mod:NewSpecialWarningInterrupt(310552, "HasInterrupt", nil, nil, 1, 2)
local specWarnGTFO								= mod:NewSpecialWarningGTFO(327992, nil, nil, nil, 1, 8)

local timerCleansingPainCD						= mod:NewNextCountTimer(16.6, 326707, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON, nil, 2, 3)
local timerBloodPriceCD							= mod:NewCDCountTimer(57.3, 326851, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerFeedingTimeCD						= mod:NewCDCountTimer(44.3, 327039, nil, nil, nil, 3)--Normal/LFR
local timerNightHunterCD						= mod:NewNextCountTimer(44.3, 327796, nil, nil, nil, 3, nil, DBM_COMMON_L.HEROIC_ICON)--Heroic/mythic
local timerCommandRavageCD						= mod:NewCDCountTimer(57.2, 327227, 327122, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON, nil, 1, 4)--ShortName "Ravage" (the actual cast)

mod:AddSetIconOption("SetIconOnNightHunter", 327796, true, false, {1, 2, 3})
--Intermission: March of the Penitent
local specWarnMarchofthePenitent				= mod:NewSpecialWarningSpell(328117, nil, nil, nil, 2, 2)

local timerNextPhase							= mod:NewPhaseTimer(16.5, 328117, nil, nil, nil, 6, nil, nil, nil, 1, 4)
--Stage Two: The Crimson Chorus
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22059))
----Crimson Cabalist
local warnCrimsonCabalists						= mod:NewSpellAnnounce("ej22131", 2, 329711)
local warnCrescendo								= mod:NewSpellAnnounce(336162, 3)

local specWarnCrescendo							= mod:NewSpecialWarningDodge(336162, false, nil, nil, 2, 2)

local timerCrimsonCabalistsCD					= mod:NewNextCountTimer(44.3, "ej22131", nil, nil, nil, 1, 329711)
----Horseman
local warnBalefulShadows						= mod:NewSpellAnnounce(344313, 3)

local specWarnVengefulWail						= mod:NewSpecialWarningInterruptCount(344776, "HasInterrupt", nil, nil, 1, 2, 4)

mod:AddSetIconOption("SetIconOnBalefulShadows", 344313, false, true, {7, 8})
----Remornia
local warnCarnage								= mod:NewStackAnnounce(329906, 2, nil, "Tank|Healer")
local warnImpale								= mod:NewTargetAnnounce(329951, 2)

local specWarnCarnage							= mod:NewSpecialWarningStack(329906, nil, 6, nil, nil, 1, 6)
local specWarnCarnageOther						= mod:NewSpecialWarningTaunt(329906, nil, nil, nil, 1, 6)
local specWarnImpale							= mod:NewSpecialWarningMoveAway(329951, nil, nil, nil, 1, 2)
local yellImpale								= mod:NewShortPosYell(329951)
local yellImpaleFades							= mod:NewIconFadesYell(329951)

local timerImpaleCD								= mod:NewNextCountTimer(44.3, 329951, nil, nil, nil, 3)

mod:AddSetIconOption("SetIconOnImpale", 329951, true, false, {1, 2, 3, 4})
----Sire Denathrius
local specWarnWrackingPain						= mod:NewSpecialWarningDefensive(329181, "Tank", nil, nil, 1, 2)--Change to defensive if it can't be dodged
local specWarnWrackingPainTaunt					= mod:NewSpecialWarningTaunt(329181, nil, nil, nil, 1, 2)
local specWarnHandofDestruction					= mod:NewSpecialWarningRun(333932, nil, nil, nil, 4, 2)
local specWarnCommandMassacre					= mod:NewSpecialWarningDodgeCount(330042, nil, 330137, nil, 2, 2)

local timerWrackingPainCD						= mod:NewCDCountTimer(16.6, 329181, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON, true)
local timerHandofDestructionCD					= mod:NewCDCountTimer(44.3, 333932, nil, nil, nil, 2)
local timerCommandMassacreCD					= mod:NewCDCountTimer(49.8, 330042, 330137, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)--Mythic 41-45, Heroic 47.4-51

--Stage Three: Indignation
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22195))
local warnScorn									= mod:NewStackAnnounce(332585, 2, nil, "Tank|Healer")
local warnFatalFinesse							= mod:NewTargetNoFilterAnnounce(332794, 2)

local specWarnScorn								= mod:NewSpecialWarningStack(332585, nil, 6, nil, nil, 1, 6)
local specWarnScorneOther						= mod:NewSpecialWarningTaunt(332585, nil, nil, nil, 1, 6)
local specWarnShatteringPain					= mod:NewSpecialWarningCount(332619, nil, nil, nil, 2, 5)
local specWarnFatalfFinesse						= mod:NewSpecialWarningMoveAway(332794, nil, nil, nil, 1, 2)
local yellFatalfFinesse							= mod:NewShortPosYell(332794)
local yellFatalfFinesseFades					= mod:NewIconFadesYell(332794)
local specWarnSinisterReflection				= mod:NewSpecialWarningCount(333979, nil, nil, nil, 2, 2, 4)--Both Massacre and Ravage at same time

local timerShatteringPainCD						= mod:NewCDCountTimer(23, 332619, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerFatalFitnesseCD						= mod:NewCDCountTimer(22, 332794, nil, nil, nil, 3)
local timerSinisterReflectionCD					= mod:NewCDCountTimer(60, 333979, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)--Used on mythic, Massacre and Ravage combined
local timerSinisterReflection					= mod:NewCastTimer(3, 333979, nil, nil, nil, 5, nil, DBM_COMMON_L.IMPORTANT_ICON)

--local berserkTimer							= mod:NewBerserkTimer(600)

mod:AddSetIconOption("SetIconOnFatalFinesse", 332794, true, false, {1, 2, 3})

mod.vb.priceCount = 0
mod.vb.painCount = 0
mod.vb.RavageCount = 0
mod.vb.MassacreCount = 0
mod.vb.ImpaleCount = 0
mod.vb.HandCount = 0
mod.vb.addCount = 0
mod.vb.DebuffCount = 0
mod.vb.DebuffIcon = 1
--mod.vb.addIcon = 8
mod.vb.painCasting = false
local expectedStacks = 6
local P3Transition = false
local SinStacks, stage2Adds, deadAdds = {}, {}, {}
local castsPerGUID = {}
local difficultyName = "normal"
local playerGUID = UnitGUID("player")
local selfInMirror = false
local allTimers = {
	["normal"] = {--Normal and LFR use same timers
		[1] = {
			--Feeding Time (Normal, LFR)
			[327039] = {15, 25, 35, 25, 35, 25},
			--Cleansing Pain (P1)
			[326707] = {5.8, 26.7, 32.8, 26.7, 32.7, 26.7},
		},
		[2] = {
			--Impale (Seems same as heroic)
			[329943] = {27.5, 25.9, 27, 23, 31.9, 18, 39, 35},
			--Hand of Destruction P2 (Seems same as heroic)
			[333932] = {47.6, 40.9, 40, 57, 19.7},
			--Adds P2 (Different from heroic)
			[181089] = {9.7, 84.5, 75},--75-79 for that last set?
		},
		[3] = {--Totally different from heroic
			--Hand of Destruction P3
			[333932] = {72.6, 76.4, 92.5},
			--Fatal Finesse P3
			[332794] = {17.4, 24, 24.9, 29, 22, 34, 22, 26, 32},
			--Adds P2 (There are none in phase 3 but sometimes message can trigger after p2 trigger, this stops nil error)
			[181089] = {},
		}
	},
	["heroic"] = {
		[1] = {
			--Night Hunter (Heroic)
			[327796] = {12.3, 24.9, 30, 28, 30, 28},--Heroic
			--Cleansing Pain (Heroic) (P1)
			[326707] = {5.8, 24.4, 32.8, 24.5, 32.7, 24.3},
		},
		[2] = {
			--Impale
			[329943] = {27.5, 25.9, 27, 23, 31.9, 18, 39, 35},
			--Hand of Destruction P2
			[333932] = {47.6, 40.9, 40, 57, 19.7},
			--Adds P2
			[181089] = {9.7, 85, 55},
		},
		[3] = {
			--Hand of Destruction P3
			[333932] = {27.6, 88, 31.7, 47.5},
			--Fatal Finesse P3
			[332794] = {17.4, 48, 6, 21, 27, 19, 26, 21, 40},
			--Adds P2 (There are none in phase 3 but sometimes message can trigger after p2 trigger, this stops nil error)
			[181089] = {},
		}
	},
	["mythic"] = {
		[1] = {
			--Night Hunter
			[327796] = {14, 24.9, 32.9, 24.8, 32.9, 24.9},
			--Cleansing Pain (P1)
			[326707] = {5.8, 24.4, 32.8, 24.5, 32.7, 24.3},
		},
		[2] = {
			--Impale
			[329943] = {49.5, 39.0, 36.0, 45},
			--Hand of Destruction P2
			[333932] = {44.2, 32.3, 39.7, 44.7, 44.8},
			--Adds P2
			[181089] = {9.6, 75, 54.9},
		},
		[3] = {
			--Fatal Finesse P3
			[332794] = {27, 21.9, 25, 25, 38.9, 33, 12, 12},
			--Shattering Pain Pain
			[332619] = {12.8, 25.4, 21.7, 24.2, 24.2, 25.4, 21.8, 23, 25.5},
			--Adds P2 (There are none in phase 3 but sometimes message can trigger after p2 trigger, this stops nil error)
			[181089] = {},
		}
	},
}

local updateInfoFrame
do
	local DBM = DBM
	local addName = DBM:EJ_GetSectionInfo(22131)
	local pairs, twipe, tsort, mfloor = pairs, table.wipe, table.sort, math.floor
	local UnitGUID, UnitName = UnitGUID, UnitName
	local UnitHealth, UnitHealthMax = UnitHealth, UnitHealthMax
	local lines = {}
	local sortedLines = {}
	local horsemanAdded = {}
	local function addLine(key, value)
		-- sort by insertion order
		lines[key] = value
		sortedLines[#sortedLines + 1] = key
	end
	updateInfoFrame = function()
		twipe(lines)
		twipe(sortedLines)
		twipe(horsemanAdded)
		for uId in DBM:GetGroupMembers() do
			if uId then
				local targetuId = uId.."target"
				local guid = UnitGUID(targetuId)
				if guid then
					local cid = mod:GetCIDFromGUID(guid)
					if (cid == 173163 or cid == 173162 or cid == 173164 or cid == 173161) and not deadAdds[guid] then--Horseman
						stage2Adds[guid] = mfloor(UnitHealth(targetuId) / UnitHealthMax(targetuId) * 100)
						local name = UnitName(targetuId)
						if not horsemanAdded[name] then
							addLine(name, stage2Adds[guid] .. '%')
							horsemanAdded[name] = true
						end
					end
					if cid == 169196 and not deadAdds[guid] then--Crimson Cabalis
						stage2Adds[guid] = mfloor(UnitHealth(targetuId) / UnitHealthMax(targetuId) * 100)
					end
				end
			end
		end
		local CableGuys = 0
		for _, health in pairs(stage2Adds) do
			CableGuys = CableGuys + 1
			addLine(addName .. " " .. CableGuys, health .. '%')
		end
		return lines, sortedLines
	end
end

function mod:OnCombatStart(delay)
	table.wipe(SinStacks)
	table.wipe(stage2Adds)
	table.wipe(deadAdds)
	table.wipe(castsPerGUID)
	self:SetStage(1)
	self.vb.priceCount = 0
	self.vb.painCount = 0
	self.vb.RavageCount = 0
	self.vb.MassacreCount = 0
	self.vb.ImpaleCount = 0
	self.vb.HandCount = 0
	self.vb.addCount = 0
	self.vb.DebuffCount = 0
	self.vb.DebuffIcon = 1
	self.vb.painCasting = false
	P3Transition = false
	selfInMirror = false
	--Same on all difficulties
	timerCleansingPainCD:Start(5.8-delay, 1)--5.8-6.3
	timerBloodPriceCD:Start(22.3-delay, 1)--22-24
	timerCommandRavageCD:Start(self:IsEasy() and 52.2 or 50.2-delay, 1)--50-51
	--Where timers diverge
	if self:IsMythic() then
		difficultyName = "mythic"
		expectedStacks = 6
		timerNightHunterCD:Start(14-delay, 1)--14+
	else
		if self:IsHeroic() then
			difficultyName = "heroic"
			expectedStacks = 5
			timerNightHunterCD:Start(12.1-delay, 1)--12+
		else
			difficultyName = "normal"
			expectedStacks = 4
			timerFeedingTimeCD:Start(15-delay, 1)
		end
	end
--	berserkTimer:Start(-delay)--Confirmed normal and heroic
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(326699))
		DBM.InfoFrame:Show(self:IsHard() and 30 or 10, "table", SinStacks, 1)--Show everyone on heroic+, filter down to 10 on normal/lfr
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:OnTimerRecovery()
	if self:IsMythic() then
		difficultyName = "mythic"
	elseif self:IsHeroic() then
		difficultyName = "heroic"
	else
		difficultyName = "normal"
	end
	if not DBM:UnitDebuff("player", 338738) and not UnitIsDeadOrGhost("player") then
		selfInMirror = true
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 326707 then--Sire Cleansing Pain
		self.vb.painCount = self.vb.painCount + 1
		specWarnCleansingPain:Show(self.vb.painCount)
		specWarnCleansingPain:Play("shockwave")
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.painCount+1)
		--Use scripted timer but if running out of script fall back to the 32/24 alternation
		timerCleansingPainCD:Start(timer or self.vb.painCount % 2 == 0 and 32.5 or 24.4, self.vb.painCount+1)
	elseif spellId == 326851 then
		self.vb.priceCount = self.vb.priceCount + 1
		warnBloodPrice:Show(self.vb.priceCount)
		timerBloodPriceCD:Start(self.vb.phase == 3 and 71.6 or self:IsEasy() and 59.5 or 57.3, self.vb.priceCount+1)
	elseif spellId == 327227 then
		self.vb.RavageCount = self.vb.RavageCount + 1
		specWarnCommandRavage:Show(self.vb.RavageCount)
		specWarnCommandRavage:Play("specialsoon")
		timerCommandRavageCD:Start(self:IsEasy() and 59.5 or 57.3, self.vb.RavageCount+1)
	elseif spellId == 328117 then--March of the Penitent (first intermission)
		self:SetStage(1.5)
		if self:IsFated() then
			self:AffixEvent(0)--Stop Affix Bars
		end
		specWarnMarchofthePenitent:Show()
		timerCleansingPainCD:Stop()
		timerBloodPriceCD:Stop()
		timerCommandRavageCD:Stop()
		timerNightHunterCD:Stop()
		timerFeedingTimeCD:Stop()
		timerNextPhase:Start(16.5)
	elseif spellId == 329181 then
		specWarnWrackingPain:Show()
		specWarnWrackingPain:Play("shockwave")
		--"Wracking Pain-329181-npc:167406 = pull:197.3, 19.5, 20.6, 19.5, 20.8, 19.5, 20.6, 19.4, 20.6", -- [10]
		--"Wracking Pain-329181-npc:167406 = pull:210.1, 18.3, 17.1, 18.3, 18.3, 21.4"
		if not self.vb.painCasting then
			self.vb.painCount = self.vb.painCount + 1
			timerWrackingPainCD:Start(self:IsMythic() and 17 or 19.4, self.vb.painCount+1)
			self.vb.painCasting = true--Work around a bug where boss stutter casts, but incurrs cd from begin of first cast
		end
	elseif spellId == 333932 and self:AntiSpam(10, 10) then
		self.vb.HandCount = self.vb.HandCount + 1
		specWarnHandofDestruction:Show()
		specWarnHandofDestruction:Play("justrun")
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.HandCount+1) or 41.2--Or part may not be accurate
		if timer then
			timerHandofDestructionCD:Start(timer, self.vb.HandCount+1)
		end
--		if self:IsFated() then--Disabled until further review with multiple affixes, also seems to only affect barrier so far
--			self:AffixEvent(2, self.vb.phase, 10)--Delay any affix by 5-10 seconds (was 5, now is 10?)
--		end
	elseif spellId == 344776 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
--			if self.Options.SetIconOnBalefulShadows and self.vb.addIcon > 3 then--Only use up to 5 icons
--				self:ScanForMobs(args.sourceGUID, 2, self.vb.addIcon, 1, nil, 12, "SetIconOnBalefulShadows")
--			end
--			self.vb.addIcon = self.vb.addIcon - 1
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then
			specWarnVengefulWail:Show(args.sourceName, count)
			if count < 6 then
				specWarnVengefulWail:Play("kick"..count.."r")
			else
				specWarnVengefulWail:Play("kickcast")
			end
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 327796 and self:AntiSpam(5, 1) then
		self.vb.DebuffIcon = 1
		self.vb.DebuffCount = self.vb.DebuffCount + 1
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.DebuffCount+1)
		if timer then
			timerNightHunterCD:Start(timer, self.vb.DebuffCount+1)
		end
	elseif spellId == 329943 then
		self.vb.DebuffIcon = 1
		self.vb.ImpaleCount = self.vb.ImpaleCount + 1
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.ImpaleCount+1)
		if timer then
			timerImpaleCD:Start(timer, self.vb.ImpaleCount+1)
		end
	elseif spellId == 339196 and self.vb.phase == 3 then
		self.vb.priceCount = self.vb.priceCount + 1
		warnBloodPrice:Show(self.vb.priceCount)
		timerBloodPriceCD:Start(nil, self.vb.priceCount+1)
	elseif spellId == 330042 then
		self.vb.MassacreCount = self.vb.MassacreCount + 1
		specWarnCommandMassacre:Show(self.vb.MassacreCount)
		specWarnCommandMassacre:Play("watchstep")--Perhaps farfromline?
		timerCommandMassacreCD:Start(self:IsMythic() and 41.4 or 47.4, self.vb.MassacreCount+1)--Mythic 41-45
	elseif spellId == 326005 then--Indignation
		self:SetStage(3)
		if self:IsFated() then
			self:AffixEvent(2, 3)--Restart Affix Bars
		end
		P3Transition = true
		self.vb.priceCount = 0
		self.vb.painCount = 0--reused for shattering pain
		self.vb.RavageCount = 0
		self.vb.MassacreCount = 0
		self.vb.DebuffCount = 0
		self.vb.HandCount = 0
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(3))
		warnPhase:Play("pthree")
		--Remornia
		timerImpaleCD:Stop()
		--Denathrius
		timerWrackingPainCD:Stop()
		timerHandofDestructionCD:Stop()
		timerCommandMassacreCD:Stop()
		timerCrimsonCabalistsCD:Stop()
		timerNextPhase:Stop()
		if self:IsMythic() then
			timerShatteringPainCD:Start(12.8, 1)--SUCCESS
			timerBloodPriceCD:Start(21.7, 1)
			timerFatalFitnesseCD:Start(27, 1)--SUCCESS/APPLIED
			timerSinisterReflectionCD:Start(70.5, 1)--Both ravage and masacre at same time
			if self.Options.InfoFrame then
				DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(326699))
				DBM.InfoFrame:Show(20, "table", SinStacks, 1)
			end
		else
			--All the same
			timerShatteringPainCD:Start(13.3, 1)--SUCCESS
			timerFatalFitnesseCD:Start(17.4, 1)--SUCCESS/APPLIED
			if self:IsEasy() then
				timerCommandMassacreCD:Start(49.7, 1)--Seems massacre always first Reflection
				timerHandofDestructionCD:Start(71.6, 1)
			else
				timerHandofDestructionCD:Start(27.6, 1)--27-29
				timerCommandRavageCD:Start(50, 1)--Seems ravage always first Reflection
			end
			if self.Options.InfoFrame then
				DBM.InfoFrame:Hide()--Nothing to show it for on non mythic
			end
		end
	elseif spellId == 332849 then--Reflection: Ravage
		self.vb.RavageCount = self.vb.RavageCount + 1
		specWarnCommandRavage:Show(self.vb.RavageCount)
		specWarnCommandRavage:Play("specialsoon")
		timerCommandMassacreCD:Start(40, self.vb.MassacreCount+1)
	elseif spellId == 333980 then
		self.vb.MassacreCount = self.vb.MassacreCount + 1
		specWarnCommandMassacre:Show(self.vb.MassacreCount)
		specWarnCommandMassacre:Play("watchstep")--Perhaps farfromline?
		timerCommandRavageCD:Start(40, self.vb.RavageCount+1)
	elseif spellId == 332619 then
		self.vb.painCount = self.vb.painCount + 1
		specWarnShatteringPain:Show(self.vb.painCount)
		if self:IsMythic() then
			local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.painCount+1) or 21.9--TODO< hardcore more timer data
			if timer then
				timerShatteringPainCD:Start(timer, self.vb.painCount+1)
			end
			if selfInMirror then
				specWarnShatteringPain:Play("teleyou")
			else
				specWarnShatteringPain:Play("carefly")
			end
		else
			timerShatteringPainCD:Start(23, self.vb.painCount+1)
			specWarnShatteringPain:Play("carefly")
		end
	elseif spellId == 329181 then
		self.vb.painCasting = false
	elseif spellId == 333979 and self:IsMythic() then--Mythic filter just in case
		self.vb.RavageCount = self.vb.RavageCount + 1
		specWarnSinisterReflection:Show(self.vb.RavageCount)
		specWarnSinisterReflection:Play("specialsoon")
		timerSinisterReflection:Start()
		timerSinisterReflectionCD:Start(60, self.vb.RavageCount+1)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 326699 then
		local amount = args.amount or expectedStacks
		SinStacks[args.destName] = amount
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(SinStacks, 0.2)
		end
	elseif spellId == 327039 then
		if args:IsPlayer() then
			specWarnFeedingTime:Show()
			specWarnFeedingTime:Play("runout")
			yellFeedingTime:Yell()
			yellFeedingTimeFades:Countdown(spellId)
		else
			warnFeedingTime:CombinedShow(0.3, args.destName)
		end
		if self:AntiSpam(5, 1) then--Cast event isn't in combat log, hava to use debuffs
			self.vb.DebuffCount = self.vb.DebuffCount + 1
			local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.DebuffCount+1)
			if timer then
				timerFeedingTimeCD:Start(timer, self.vb.DebuffCount+1)
			end
		end
	elseif spellId == 327796 then
		local icon = self.vb.DebuffIcon
		if self.Options.SetIconOnNightHunter then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			--Unschedule target warning if you've become one of victims
			specWarnNightHunterTarget:Cancel()
			specWarnNightHunterTarget:CancelVoice()
			--Now show your warnings
			specWarnNightHunter:Show(self:IconNumToTexture(icon))
			specWarnNightHunter:Play("mm"..icon)
			yellNightHunter:Yell(icon, icon)
			yellNightHunterFades:Countdown(spellId, nil, icon)
		elseif self.Options.SpecWarn327796target and not DBM:UnitDebuff("player", spellId) then
			--Don't show special warning if you're one of victims
			specWarnNightHunterTarget:CombinedShow(0.5, args.destName)
			specWarnNightHunterTarget:ScheduleVoice(0.5, "helpsoak")
		else
			warnNightHunter:CombinedShow(0.5, args.destName)
		end
		self.vb.DebuffIcon = self.vb.DebuffIcon + 1
	elseif spellId == 327992 and args:IsPlayer() and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("watchfeet")
	elseif spellId == 329906 then
		local amount = args.amount or 1
		if (amount % 3 == 0) then
			if amount >= 6 then
				if args:IsPlayer() then
					specWarnCarnage:Show(amount)
					specWarnCarnage:Play("stackhigh")
				else
					--Don't show taunt warning if you're 3 tanking and aren't near the boss (this means you are the add tank)
					--Show taunt warning if you ARE near boss, or if number of alive tanks is less than 3
					if (self:CheckNearby(8, args.destName) or self:GetNumAliveTanks() < 3) and not DBM:UnitDebuff("player", spellId) and not UnitIsDeadOrGhost("player") then--Can't taunt less you've dropped yours off, period.
						specWarnCarnageOther:Show(args.destName)
						specWarnCarnageOther:Play("tauntboss")
					else
						warnCarnage:Show(args.destName, amount)
					end
				end
			else
				warnCarnage:Show(args.destName, amount)
			end
		end
	elseif spellId == 332585 then
		local amount = args.amount or 1
		if (amount % 3 == 0) then
			if amount >= 6 then
				if args:IsPlayer() then
					specWarnScorn:Show(amount)
					specWarnScorn:Play("stackhigh")
				else
					--Don't show taunt warning if you're 3 tanking and aren't near the boss (this means you are the add tank)
					--Show taunt warning if you ARE near boss, or if number of alive tanks is less than 3
					if (self:CheckNearby(8, args.destName) or self:GetNumAliveTanks() < 3) and not DBM:UnitDebuff("player", spellId) and not UnitIsDeadOrGhost("player") then--Can't taunt less you've dropped yours off, period.
						specWarnScorneOther:Show(args.destName)
						specWarnScorneOther:Play("tauntboss")
					else
						warnScorn:Show(args.destName, amount)
					end
				end
			else
				warnScorn:Show(args.destName, amount)
			end
		end
	elseif spellId == 329951 then
		local icon = self.vb.DebuffIcon
		if self.Options.SetIconOnImpale then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnImpale:Show()
			specWarnImpale:Play("runout")
			yellImpale:Yell(icon, icon)
			yellImpaleFades:Countdown(spellId, nil, icon)
		end
		warnImpale:CombinedShow(0.3, args.destName)
		self.vb.DebuffIcon = self.vb.DebuffIcon + 1
	elseif spellId == 332794 then
		if self:AntiSpam(4, 4) then
			self.vb.DebuffIcon = 1
			self.vb.DebuffCount = self.vb.DebuffCount + 1
			local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.DebuffCount+1)
			if timer then
				timerFatalFitnesseCD:Start(timer, self.vb.DebuffCount+1)
			end
		end
		local icon = self.vb.DebuffIcon
		if self.Options.SetIconOnFatalFinesse then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnFatalfFinesse:Show()
			specWarnFatalfFinesse:Play("runout")
			yellFatalfFinesse:Yell(icon, icon)
			yellFatalfFinesseFades:Countdown(spellId, nil, icon)
		end
		warnFatalFinesse:CombinedShow(0.3, args.destName)
		self.vb.DebuffIcon = self.vb.DebuffIcon + 1
	elseif spellId == 329181 then
		if not args:IsPlayer() then
			specWarnWrackingPainTaunt:Show(args.destName)
			specWarnWrackingPainTaunt:Play("tauntboss")
		end
	elseif spellId == 344313 then
--		self.vb.addIcon = 8
		warnBalefulShadows:Show()
	elseif spellId == 338738 then--Infinity's Toll being applied (Players leaving mind)
		if args.sourceGUID == playerGUID then
			selfInMirror = false
		end
	elseif spellId == 181089 then--Encounter Event
		self.vb.addCount = self.vb.addCount + 1
		warnCrimsonCabalists:Show(self.vb.addCount)
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.addCount+1)
		if timer then
			timerCrimsonCabalistsCD:Start(timer, self.vb.addCount+1)
		end
		if self.Options.SetIconOnBalefulShadows then--Only use up to 5 icons
			self:ScanForMobs(175205, 0, 8, 2, nil, 25, "SetIconOnBalefulShadows")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 326699 then
		SinStacks[args.destName] = nil
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(SinStacks, 0.2)
		end
	elseif spellId == 327039 then
		if args:IsPlayer() then
			yellFeedingTimeFades:Cancel()
		end
	elseif spellId == 327796 then
		if args:IsPlayer() then
			yellNightHunterFades:Cancel()
		end
		if self.Options.SetIconOnNightHunter then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 328117 and self:IsInCombat() then--March of the Penitent
		self:SetStage(2)
		if self:IsFated() then
			self:AffixEvent(1, 2)--Start Affix Bars
		end
		self.vb.painCount = 0
		self.vb.DebuffCount = 0
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2))
		warnPhase:Play("ptwo")
		if self:IsMythic() then
			--Remornia
			timerImpaleCD:Start(49.5, 1)
			--Denathrius
			timerCrimsonCabalistsCD:Start(9.6, 1)--Actually the horseman, but same emote
			timerWrackingPainCD:Start(21.1, 1)
			timerHandofDestructionCD:Start(44.2, 1)
			timerCommandMassacreCD:Start(63.7, 1)
			timerNextPhase:Start(234.4)
		else
			--Remornia
			timerImpaleCD:Start(27.5, 1)
			--Denathrius
			timerCrimsonCabalistsCD:Start(9.7, 1)
			timerWrackingPainCD:Start(21.1, 1)
			timerHandofDestructionCD:Start(46.6, 1)
			timerCommandMassacreCD:Start(64.9, 1)
			timerNextPhase:Start(219.4)
		end
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(DBM_COMMON_L.ADDS)
			DBM.InfoFrame:Show(10, "function", updateInfoFrame, false, false)
			DBM.InfoFrame:SetColumns(1)
		end
	elseif spellId == 329951 then
		if args:IsPlayer() then
			yellImpaleFades:Cancel()
		end
		if self.Options.SetIconOnImpale then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 332794 then
		if args:IsPlayer() then
			yellFatalfFinesseFades:Cancel()
		end
		if self.Options.SetIconOnFatalFinesse then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 338738 then
		if args.destGUID == playerGUID and not UnitIsDeadOrGhost("player") then
			selfInMirror = true
		end
	end
end

function mod:SPELL_AURA_REMOVED_DOSE(args)
	local spellId = args.spellId
	if spellId == 326699 then
		SinStacks[args.destName] = args.amount or 1
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(SinStacks, 0.2)
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 169196 or cid == 173163 or cid == 173162 or cid == 173164 or cid == 173161 then--crimson-cabalist and all 4 horseman
		stage2Adds[args.destGUID] = nil
		deadAdds[args.destGUID] = true
		if self:IsHard() and self:AntiSpam(3, 3) then
			if self.Options.SpecWarn336162dodge then
				specWarnCrescendo:Show()
				specWarnCrescendo:Play("watchstep")
			else
				warnCrescendo:Show()
			end
		end
	elseif cid == 169855 then--Remornia
		timerImpaleCD:Stop()
	elseif cid == 175205 or cid == 175528 then--Baleful Shadow
		castsPerGUID[args.destGUID] = nil
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 327992 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	--1 second faster than SPELL_CAST_START
	if spellId == 330613 and self:AntiSpam(10, 10) then--Script Activating to cast Hand of Destruction
		if not P3Transition then--We can't let a cast that slips through during Indignation screw up counts/timers
			self.vb.HandCount = self.vb.HandCount + 1
			local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, 333932, self.vb.HandCount+1)
			if timer then
				timerHandofDestructionCD:Start(timer, self.vb.HandCount+1)
			end
			if self:IsFated() then
				self:AffixEvent(2, self.vb.phase, 5)--Delay any affix until Hand has finished casting.
			end
		end
		specWarnHandofDestruction:Show()
		specWarnHandofDestruction:Play("justrun")
	elseif spellId == 332749 and P3Transition then
		P3Transition = false
	end
end
