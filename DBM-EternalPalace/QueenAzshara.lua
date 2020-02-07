local mod	= DBM:NewMod(2361, "DBM-EternalPalace", nil, 1179)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(152910)
mod:SetEncounterID(2299)
mod:SetZone()
mod:SetUsedIcons(4, 3, 2, 1)
mod:SetHotfixNoticeRev(20191118000000)--2019, 11, 18
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 29--Respawn is near instant on ptr, boss requires clicking to engage, no body pulling anyways

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 297937 297934 298121 297972 298531 300478 299250 299178 300519 301431 299094 302141 303797 303799 300480 307331 307332",
	"SPELL_CAST_SUCCESS 302208 298014 301078 300743 300334 300768 181089 297371 297372 303986",
	"SPELL_AURA_APPLIED 302999 298569 297912 298014 298018 301078 300428 303825 303657 300492 300620 299094 303797 303799 300743 300866 300877 299249 299251 299254 299255 299252 299253 302141 304267",
	"SPELL_AURA_APPLIED_DOSE 302999 298569 298014 300743",
	"SPELL_AURA_REMOVED 302999 298569 297912 301078 300428 303657 304267 299249 299251 299254 299255 299252 299253 300620",
	"SPELL_PERIODIC_DAMAGE 297907 303981",
	"SPELL_PERIODIC_MISSED 297907 303981",
	"UNIT_DIED",
	"RAID_BOSS_WHISPER",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"
--	"UPDATE_UI_WIDGET"
)

--TODO, check if multiple targets for static shock
--TODO, add siren creature IDs so they can be auto marked and warning for shield can include which marked mob got it
--TODO, announce short ciruit?
--[[
(ability.id = 297937 or ability.id = 297934 or ability.id = 298121 or ability.id = 297972 or ability.id = 298531 or ability.id = 300478 or ability.id = 299250 or ability.id = 299178 or ability.id = 300519 or ability.id = 303629 or ability.id = 297372 or ability.id = 301431 or ability.id = 300480 or ability.id = 307331 or ability.id = 307332 or ability.id = 299094 or ability.id = 302141 or ability.id = 303797 or ability.id = 303799) and type = "begincast"
 or (ability.id = 302208 or ability.id = 298014 or ability.id = 301078 or ability.id = 303657 or ability.id = 303629 or ability.id = 300492 or ability.id = 300743 or ability.id = 303980 or ability.id = 300334 or ability.id = 300768 or ability.id = 181089 or ability.id = 297371 or ability.id = 297372 or ability.id = 303986) and type = "cast"
 or type = "death" and (target.id = 153059 or target.id = 153060)
 or ability.id = 300551 and type = "applybuff"
 or (ability.id = 303657) and type = "applydebuff"
--]]
--Ancient Wards (20)
local warnPhase							= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)
local warnPressureSurge					= mod:NewSpellAnnounce(302208, 2)
--Stage One: Cursed Lovers
local warnPainfulMemoriesOver			= mod:NewMoveToAnnounce(297937, 1, nil, "Tank", 2)
----Aethanel
local warnLightningOrbs					= mod:NewSpellAnnounce(298121, 2)
local warnFrozen						= mod:NewTargetNoFilterAnnounce(298018, 4)
local warnColdBlast						= mod:NewStackAnnounce(298014, 2, nil, "Tank")
----Cyranus
local warnChargedSpear					= mod:NewTargetNoFilterAnnounce(301078, 4)
----Overzealous Hulk
local warnGroundPound					= mod:NewCountAnnounce(298531, 2)
----Azshara
local warnDrainAncientWard				= mod:NewSpellAnnounce(300334, 2)
local warnBeckon						= mod:NewTargetNoFilterAnnounce(299094, 3)
local warnCrushingDepths				= mod:NewTargetNoFilterAnnounce(303825, 4, nil, false, 2)
--Intermission One: Queen's Decree
local warnQueensDecree					= mod:NewCastAnnounce(299250, 3)
--Stage Two: Hearts Unleashed
local warnArcaneBurst					= mod:NewTargetNoFilterAnnounce(303657, 3, nil, "Healer", 2)
--Stage Three: Song of the Tides
local warnStaticShock					= mod:NewTargetAnnounce(300492, 2)
local warnCrystallineShield				= mod:NewTargetNoFilterAnnounce(300620, 2)
--Stage Four: My Palace Is a Prison
local warnVoidTouched					= mod:NewStackAnnounce(300743, 2, nil, "Tank")
local warnNetherPortal					= mod:NewCountAnnounce(303980, 2)
local warnEssenceofAzeroth				= mod:NewTargetAnnounce(300866, 2)
local warnOverload						= mod:NewCountAnnounce(301431, 2)
local warnSystemShock					= mod:NewTargetAnnounce(300877, 3)

--Ancient Wards (34)
local specWarnDrainedSoul				= mod:NewSpecialWarningStack(298569, nil, 5, nil, nil, 1, 6)
--Stage One: Cursed Lovers
local specWarnPainfulMemories			= mod:NewSpecialWarningMoveTo(297937, "Tank", nil, nil, 3, 2)
local specWarnLonging					= mod:NewSpecialWarningMoveTo(297934, false, nil, 2, 3, 2)
local specWarnGTFO						= mod:NewSpecialWarningGTFO(297898, nil, nil, nil, 1, 8)
local specWarnHulk						= mod:NewSpecialWarningSwitchCount("ej20480", "Dps", nil, nil, 1, 2)
----Aethanel
local specWarnChainLightning			= mod:NewSpecialWarningInterrupt(297972, "HasInterrupt", nil, nil, 1, 2)
local specWarnColdBlast					= mod:NewSpecialWarningStack(298014, nil, 3, nil, nil, 1, 6)
local specWarnColdBlastTaunt			= mod:NewSpecialWarningTaunt(298014, nil, nil, nil, 1, 2)
----Cyranus
local specWarnChargedSpear				= mod:NewSpecialWarningMoveTo(301078, nil, nil, nil, 3, 8)
local yellChargedSpear					= mod:NewYell(301078)
local yellChargedSpearFades				= mod:NewShortFadesYell(301078)
----Azshara
local specWarnArcaneOrbs				= mod:NewSpecialWarningCount(298787, nil, nil, nil, 2, 2)
local specWarnBeckon					= mod:NewSpecialWarningRun(299094, nil, nil, nil, 4, 8)
local yellBeckon						= mod:NewYell(299094)--Yell goes off when player loses control of self, not pre warning player gets
local specWarnBeckonNear				= mod:NewSpecialWarningClose(303799, nil, nil, nil, 1, 8)
local specWarnDivideandConquer			= mod:NewSpecialWarningDodge(300478, nil, nil, nil, 3, 2, 4)--Mythic
--Intermission One: Queen's Decree
local specWarnQueensDecree				= mod:NewSpecialWarningYouCount(299250, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.you:format(299250), nil, 3, 2)
local yellQueensDecree					= mod:NewYell(299250, "%s", false, nil, "YELL")
--Stage Two: Hearts Unleashed
local specWarnArcaneVuln				= mod:NewSpecialWarningStack(302999, nil, 12, nil, nil, 1, 6)
local specWarnArcaneDetonation			= mod:NewSpecialWarningMoveTo(300519, nil, nil, nil, 3, 8)
local specWarnReversalofFortune			= mod:NewSpecialWarningSpell(297371, nil, nil, nil, 2, 5)
local specWarnArcaneBurst				= mod:NewSpecialWarningYouPos(303657, nil, nil, nil, 1, 2)
local yellArcaneBurst					= mod:NewPosYell(303657)
local yellArcaneBurstFades				= mod:NewIconFadesYell(303657)
local specWarnAzsharasDevoted			= mod:NewSpecialWarningSwitch("ej20353", "Dps", nil, nil, 1, 2)
local specWarnAzsharasIndomitable		= mod:NewSpecialWarningSwitchCount("ej20410", "Dps", nil, nil, 1, 2)
--Stage Three: Song of the Tides
local specWarnLoyalMyrmidon				= mod:NewSpecialWarningSwitchCount("ej20355", "Tank", nil, nil, 1, 2)
local specWarnStaticShock				= mod:NewSpecialWarningMoveAway(300492, nil, nil, nil, 1, 8)
local yellStaticShock					= mod:NewYell(300492)
--Stage Four: My Palace Is a Prison
local specWarnGreaterReversal			= mod:NewSpecialWarningSpell(297372, nil, nil, nil, 2, 5)
local specWarnVoidtouched				= mod:NewSpecialWarningStack(300743, nil, 4, nil, nil, 1, 6)
local specWarnVoidtouchedTaunt			= mod:NewSpecialWarningTaunt(300743, nil, nil, nil, 1, 2)
local specWarnPiercingGaze				= mod:NewSpecialWarningDodge(300768, nil, nil, nil, 2, 2)
local specWarnOverload					= mod:NewSpecialWarningCount(301431, false, nil, 2, 2, 2)
local specWarnEssenceofAZeroth			= mod:NewSpecialWarningYou(300866, nil, nil, nil, 1, 2)
local specWarnSystemShock				= mod:NewSpecialWarningDefensive(300877, nil, nil, nil, 1, 2)

--Stage One: Cursed Lovers (21)
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20250))
local timerCombatStart					= mod:NewCombatTimer(4)
local timerPainfulMemoriesCD			= mod:NewNextTimer(60, 297937, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerLongingCD					= mod:NewNextTimer(60, 297934, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
----Aethanel
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20261))
local timerLightningOrbsCD				= mod:NewCDTimer(16.1, 298121, nil, nil, nil, 3)
local timerColdBlastCD					= mod:NewCDTimer(9.4, 298014, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
----Cyranus
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20266))
local timerChargedSpearCD				= mod:NewCDTimer(32.3, 301078, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)--32-40 in stage 1, 12.4-15 stage 3
----Overzealous Hulk
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20480))
local timerHulkSpawnCD					= mod:NewCDCountTimer(30.4, "ej20480", nil, nil, nil, 1, 298531, DBM_CORE_DAMAGE_ICON)
----Azshara
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20258))
local timerArcaneOrbsCD					= mod:NewCDCountTimer(65, 298787, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
local timerBeckonCD						= mod:NewCDCountTimer(30.4, 299094, nil, nil, nil, 3)
local timerDivideandConquerCD			= mod:NewCDTimer(65, 300478, nil, nil, nil, 3, nil, DBM_CORE_MYTHIC_ICON..DBM_CORE_DEADLY_ICON)
--Intermission One: Queen's Decree
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20335))
local timerNextPhase					= mod:NewPhaseTimer(30.4)
--Stage Two: Hearts Unleashed
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20323))
local timerArcaneDetonationCD			= mod:NewCDCountTimer(80, 300519, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON, nil, 1, 5)
local timerReversalofFortuneCD			= mod:NewCDCountTimer(80, 297371, nil, nil, nil, 5, nil, DBM_CORE_IMPORTANT_ICON, nil, 2, 5)
local timerArcaneBurstCD				= mod:NewCDCountTimer(58.2, 303657, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON)
local timerAzsharasDevotedCD			= mod:NewCDTimer(95, "ej20353", nil, nil, nil, 1, 298531, DBM_CORE_DAMAGE_ICON)
local timerAzsharasIndomitableCD		= mod:NewCDTimer(100, "ej20410", nil, nil, nil, 1, 298531, DBM_CORE_DAMAGE_ICON)
--Stage Three: Song of the Tides
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20340))
local timerLoyalMyrmidonCD				= mod:NewCDCountTimer(95, "ej20355", nil, nil, nil, 1, 301078, DBM_CORE_DAMAGE_ICON)
local timerStageThreeBerserk			= mod:NewTimer(180, "timerStageThreeBerserk", 28131)
--Stage Four: My Palace Is a Prison
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20361))
local timerGreaterReversalCD			= mod:NewCDCountTimer(70, 297372, 297371, nil, nil, 5, nil, DBM_CORE_IMPORTANT_ICON..DBM_CORE_HEROIC_ICON, nil, 2, 5)
local timerVoidTouchedCD				= mod:NewCDTimer(6.9, 300743, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)
local timerNetherPortalCD				= mod:NewCDCountTimer(35, 303980, nil, nil, nil, 3)--35 unless delayed by spell queue
local timerOverloadCD					= mod:NewCDCountTimer(54.9, 301431, nil, nil, nil, 5, nil, DBM_CORE_IMPORTANT_ICON)
local timerMassiveEnergySpike			= mod:NewCastTimer(42, 301518, nil, nil, nil, 5, nil, DBM_CORE_DEADLY_ICON)
local timerPiercingGazeCD				= mod:NewCDCountTimer(65, 300768, nil, nil, nil, 3)

local berserkTimer						= mod:NewBerserkTimer(600)

mod:AddNamePlateOption("NPAuraOnTorment", 297912)
mod:AddNamePlateOption("NPAuraOnInfuriated", 300428)
mod:AddInfoFrameOption(298569, true)
mod:AddBoolOption("SortDesc", false)
mod:AddBoolOption("ShowTimeNotStacks", false)
mod:AddSetIconOption("SetIconOnArcaneBurst", 303657, true, false, {1, 2, 3, 4})

mod.vb.phase = 1
mod.vb.stageOneBossesLeft = 2
mod.vb.arcaneOrbCount = 0
mod.vb.maxDecree = 1
mod.vb.arcaneBurstIcon = 1
mod.vb.overloadCount = 0
mod.vb.beckonCast = 0
mod.vb.arcaneBurstCount = 0
mod.vb.drainWardCount = 0
mod.vb.bigAddCount = 0
mod.vb.reversalCount = 0
mod.vb.arcaneDetonation = 0
mod.vb.overloadCount = 0
mod.vb.netherCount = 0
mod.vb.piercingCount = 0
mod.vb.controlledBurst = 0
mod.vb.painfulMemoriesActive = false
mod.vb.myrmidonCount = 0
local drainedSoulStacks = {}
local playerSoulDrained = false
local shieldName = DBM:GetSpellInfo(300620)
local seenAdds = {}
local castsPerGUID = {}
local text = ""
local playerDecreeCount = 0
local playerDecreeYell = 0--100s 2-Stack/1-Solo, 10s 2-Moving/1-Stay, 1s 2-Soak/1-NoSoak
--Extend add timers to be by phase as well so P2 adds can be in it as well, if ever see more than one in a single difficulty, ever
local HulkTimers = {
	["Normal"] = {42.6, 84.7},--Normal & LFR
	["Heroic"] = {41, 59.6, 89.1, 44.8, 39.4},
	["Mythic"] = {35, 65},
}
local phase4LFROverloadTimers = {14, 69.8, 75, 65, 65, 60}
local phase4LFRPiercingTimers = {0, 65, 65, 65, 60, 20}
local phase4LFRBeckonTimers = {0, 90, 100, 80}--LFR and Normal (so far, greater data might find divergence)

local phase4NormalPiercingTimers = {0, 65, 65, 65, 55, 20}--Not same as LFR, one is different
local phase4NormalPortalTimers = {35, 34.9, 87.5, 32.4}

local phase4HeroicOverloadTimers = {14, 44.9, 44.9, 45, 40, 40, 40}
local phase4HeroicBeckonTimers = {68.1, 71.6, 84.9, 69.9}
local phase4HeroicPiercingTimers = {43.9, 45, 40, 40, 35, 35, 35}
local phase4HeroicPortalTimers = {23.9, 40, 35, 40, 40, 35}

local phase4MythicPiercingTimers = {51.7, 56.2, 49.9, 49.98}
local phase4MythicPortalTimers = {26.7, 50.2, 43.3, 56.2}
local mobShielded = {}

local updateInfoFrame
do
	local floor, tsort = math.floor, table.sort
	local lines = {}
	local tempLines = {}
	local tempLinesSorted = {}
	local sortedLines = {}
	local function sortFuncAsc(a, b) return tempLines[a] < tempLines[b] end
	local function sortFuncDesc(a, b) return tempLines[a] > tempLines[b] end
	local function addLine(key, value)
		-- sort by insertion order
		lines[key] = value
		sortedLines[#sortedLines + 1] = key
	end
	updateInfoFrame = function()
		table.wipe(lines)
		table.wipe(tempLines)
		table.wipe(tempLinesSorted)
		table.wipe(sortedLines)
		--Power levels pulled from widgets?
		----TODO
		--Player Personal Checks
		if playerSoulDrained then
			local spellName, _, currentStack, _, _, expireTime = DBM:UnitDebuff("player", 298569)
			if spellName and currentStack and expireTime then
				local remaining = expireTime-GetTime()
				addLine(spellName.." ("..currentStack..")", math.floor(remaining))
			end
		end
		--Add rest of drained soul
		if mod.Options.ShowTimeNotStacks then
			--Higher Performance check that scans all debuff remaining times
			for uId in DBM:GetGroupMembers() do
				if not (UnitGroupRolesAssigned(uId) == "TANK" or GetPartyAssignment("MAINTANK", uId, 1) or UnitIsDeadOrGhost(uId)) then--Exclude tanks and dead
					local unitName = DBM:GetUnitFullName(uId)
					local spellName2, _, _, _, _, expireTime2 = DBM:UnitDebuff(uId, 298569)
					if spellName2 and expireTime2 then
						local remaining2 = expireTime2-GetTime()
						tempLines[unitName] = math.floor(remaining2)
						tempLinesSorted[#tempLinesSorted + 1] = unitName
					else
						tempLines[unitName] = 0
						tempLinesSorted[#tempLinesSorted + 1] = unitName
					end
				end
			end
		else
			--More performance friendly check that just returns all player stacks (the default option)
			for uId in DBM:GetGroupMembers() do
				if not (UnitGroupRolesAssigned(uId) == "TANK" or GetPartyAssignment("MAINTANK", uId, 1) or UnitIsDeadOrGhost(uId)) then--Exclude tanks and dead
					local unitName = DBM:GetUnitFullName(uId)
					tempLines[unitName] = drainedSoulStacks[unitName] or 0
					tempLinesSorted[#tempLinesSorted + 1] = unitName
				end
			end
		end
		--Sort debuffs, then inject into regular table
		if mod.Options.SortDesc then
			tsort(tempLinesSorted, sortFuncDesc)
		else
			tsort(tempLinesSorted, sortFuncAsc)
		end
		for _, name in ipairs(tempLinesSorted) do
			addLine(name, tempLines[name])
		end
		return lines, sortedLines
	end
end

local function decreeYellRepeater(self)
	if playerDecreeYell == 0 then return end--All debuffs gone
	if playerDecreeYell >= 200 then--Stack decree active
		if playerDecreeYell >= 220 then--Moving/Stack
			if playerDecreeYell == 222 then--Moving/Stack/Soak
				yellQueensDecree:Yell(L.HelpSoakMove)--"HELP SOAK MOVE"
			else--Moving/Stack/NoSoak or just Moving/Stack
				yellQueensDecree:Yell(L.HelpMove)--"HELP MOVE"
			end
		elseif playerDecreeYell >= 210 then--Staying/Stack
			if playerDecreeYell == 212 then--Staying/Stack/Soak
				yellQueensDecree:Yell(L.HelpSoakStay)--"HELP SOAK STAY"
			else--Staying/Stack/NoSoak or Staying/Stack
				yellQueensDecree:Yell(L.HelpStay)--"HELP STAY"
			end
		elseif playerDecreeYell == 202 then--Soak/Stack
			yellQueensDecree:Yell(L.HelpSoak)--"HELP SOAK"
		end
	elseif playerDecreeYell >= 100 then--Solo decree Active
		if playerDecreeYell == 102 then--Solo/Soak
			yellQueensDecree:Say(L.SoloSoak)--"SOLO SOAK"
		else--Solo/NoSoak, Solo/NoSoak/Moving, Solo/NoSoak/Staying, Just Solo
			yellQueensDecree:Say(L.Solo)--"SOLO"
		end
	end
	self:Schedule(2, decreeYellRepeater, self)
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.stageOneBossesLeft = 2
	self.vb.arcaneOrbCount = 0
	self.vb.beckonCast = 0
	self.vb.arcaneBurstCount = 0
	self.vb.drainWardCount = 0
	self.vb.bigAddCount = 0
	self.vb.reversalCount = 0
	self.vb.arcaneDetonation = 0
	self.vb.overloadCount = 0
	self.vb.netherCount = 0
	self.vb.piercingCount = 0
	self.vb.painfulMemoriesActive = false
	playerDecreeYell = 0
	playerSoulDrained = false
	table.wipe(drainedSoulStacks)
	table.wipe(seenAdds)
	table.wipe(castsPerGUID)
	table.wipe(mobShielded)
	timerCombatStart:Start(4-delay)
	--Both of them
	timerPainfulMemoriesCD:Start(19.6)
	--Aethanel
	timerColdBlastCD:Start(14.3-delay)--SUCCESS
	timerLightningOrbsCD:Start(23-delay)--23-26
	berserkTimer:Start(843-delay)
	if self:IsMythic() then
		self.vb.maxDecree = 3
		--Cyranus
		timerChargedSpearCD:Start(23.6-delay)--23.6-26
		--Azshara
		timerHulkSpawnCD:Start(35-delay, 1)
		timerDivideandConquerCD:Start(39.9-delay)
		timerBeckonCD:Start(50-delay, 1)--START
		timerArcaneOrbsCD:Start(64.8-delay, 1)
	elseif self:IsHeroic() then
		self.vb.maxDecree = 2
		--Cyranus
		timerChargedSpearCD:Start(27.5-delay)--27-29
		--Azshara
		timerHulkSpawnCD:Start(41-delay, 1)
		timerBeckonCD:Start(54.6-delay, 1)--START
		timerArcaneOrbsCD:Start(69.8-delay, 1)
	else
		self.vb.maxDecree = 1
		--Cyranus
		timerChargedSpearCD:Start(27.5-delay)--27-29
		--Azshara
		timerHulkSpawnCD:Start(41-delay, 1)
		timerBeckonCD:Start(54.6-delay, 1)--START
		timerArcaneOrbsCD:Start(69.8-delay, 1)
	end
	for uId in DBM:GetGroupMembers() do
		local unitName = DBM:GetUnitFullName(uId)
		drainedSoulStacks[unitName] = 0
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(OVERVIEW)
		DBM.InfoFrame:Show(8, "function", updateInfoFrame, false, false)
	end
	if self.Options.NPAuraOnTorment or self.Options.NPAuraOnInfuriated then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.NPAuraOnTorment or self.Options.NPAuraOnInfuriated then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:OnTimerRecovery()
	for uId in DBM:GetGroupMembers() do
		local _, _, currentStack = DBM:UnitDebuff(uId, 298569)
		local unitName = DBM:GetUnitFullName(uId)
		drainedSoulStacks[unitName] = currentStack or 0
		if UnitIsUnit(uId, "player") and currentStack then
			playerSoulDrained = true
		end
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(OVERVIEW)
			DBM.InfoFrame:Show(8, "function", updateInfoFrame, false, false)
		end
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 297937 and self:AntiSpam(3, 3) then--Painful Memories
		specWarnPainfulMemories:Show(DBM_CORE_BREAK_LOS)
		specWarnPainfulMemories:Play("moveboss")
		timerLongingCD:Start(self:IsMythic() and 60 or self:IsHeroic() and 65 or 70)
	elseif spellId == 297934 and self:AntiSpam(5, 3) then--Longing
		specWarnLonging:Show(DBM_CORE_RESTORE_LOS)
		specWarnLonging:Play("moveboss")
		timerPainfulMemoriesCD:Start(self:IsHard() and 20 or 24.9)
	elseif spellId == 298121 then
		warnLightningOrbs:Show()
		timerLightningOrbsCD:Start()
	elseif spellId == 297972 then
		if self:CheckInterruptFilter(args.sourceGUID, false, true) and not mobShielded[args.sourceGUID] then
			specWarnChainLightning:Show(args.sourceName)
			specWarnChainLightning:Play("kickcast")
		end
	elseif spellId == 298531 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		warnGroundPound:Show(castsPerGUID[args.sourceGUID])
	elseif (spellId == 300478 or spellId == 300480 or spellId == 307331 or spellId == 307332) and self:AntiSpam(10, 4) then
		specWarnDivideandConquer:Show()
		timerDivideandConquerCD:Start(self.vb.phase == 4 and 87.5 or self.vb.phase == 3 and 59.8 or 65)
	elseif spellId == 299250 and self:AntiSpam(4, 5) then--In rare cases she stutter casts it, causing double warnings
		warnQueensDecree:Show()
	elseif spellId == 299178 and self.vb.phase < 2 then--Ward of Power
		self.vb.phase = 2
		self.vb.arcaneBurstCount = 0
		self.vb.arcaneOrbCount = 0
		self.vb.beckonCast = 0
		self.vb.bigAddCount = 0
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(2))
		warnPhase:Play("ptwo")
		if self:IsHard() then
			timerBeckonCD:Start(25, 1)--START
			timerAzsharasDevotedCD:Start(35)
			timerReversalofFortuneCD:Start(68.1, 1)
			timerAzsharasIndomitableCD:Start(self:IsMythic() and 115 or 105)--Confirmed they left heroic at 105
			if self:IsMythic() then
				timerDivideandConquerCD:Start(45.4)
			end
		else
			timerAzsharasDevotedCD:Start(35)
			timerBeckonCD:Start(self:IsLFR() and 55 or 60, 1)--START
			timerAzsharasIndomitableCD:Start(95.1)
		end
		timerArcaneBurstCD:Start(52.1, 1)--SUCCESS (same on heroic and normal and mythic)
		timerArcaneDetonationCD:Start(self:IsMythic() and 80.1 or 75, 1)--START (same on heroic/normal/lfr but different on mythic)
	elseif spellId == 300519 then
		self.vb.arcaneDetonation = self.vb.arcaneDetonation + 1
		specWarnArcaneDetonation:Show(DBM_CORE_BREAK_LOS)
		specWarnArcaneDetonation:Play("findshelter")
		timerArcaneDetonationCD:Start(self:IsMythic() and 69.9 or self:IsHeroic() and 75 or 80, self.vb.arcaneDetonation+1)
	elseif spellId == 301431 then
		self.vb.controlledBurst = 0
		self.vb.overloadCount = self.vb.overloadCount + 1
		if self.Options.SpecWarn301431count then
			specWarnOverload:Show(self.vb.overloadCount)
			specWarnOverload:Play("specialsoon")
		else
			warnOverload:Show(self.vb.overloadCount)
		end
		local timer = self:IsLFR() and phase4LFROverloadTimers[self.vb.overloadCount+1] or self:IsHeroic() and phase4HeroicOverloadTimers[self.vb.overloadCount+1] or self:IsNormal() and 54.9 or self:IsMythic() and 56
		if timer then
			timerOverloadCD:Start(timer, self.vb.overloadCount+1)--Mythic same as normal, heroic only one that's shorter (so far, LFR unknown)
		end
		if self:IsMythic() then
			timerMassiveEnergySpike:Start()
		end
	elseif spellId == 299094 or spellId == 302141 or spellId == 303797 or spellId == 303799 then--299094 Phase 1, 302141 phase 2, 303797 phase 3, 303799 Phase 4
		self.vb.beckonCast = self.vb.beckonCast + 1
		if self.vb.phase == 1 then
			--Phase 1 pattern (imprecise as hell, it's spell queuing not true alternating, but there is enough consistency to do this somewhat)
			--"Beckon-299094-npc:152910 = pull:59.1, 73.2, 51.2", -- [5] HEROIC
			--"Beckon-299094-npc:152910 = pull:56.1, 71.3, 50.6, 63.7" MORE HEROIC
			--"Beckon-299094-npc:152910 = pull:59.4, 90.1", -- [6] NORMAL
			--50, 45, 50 MYTHIC
			if self.vb.beckonCast % 2 == 0 then
				timerBeckonCD:Start(50, self.vb.beckonCast+1)--Most of time 55, but can be lower
			else
				timerBeckonCD:Start(self.vb.beckonCast == 1 and (self:IsMythic() and 45 or self:IsHeroic() and 70 or 90) or 60, self.vb.beckonCast+1)-- 2nd cast is always above 70, but 4th cast is more around 60, rest unknown so 60 assumed
			end
		elseif self.vb.phase == 2 then--Phase 2 (Needs more sample)
			--Phase 2 pattern (imprecise as hell, it's spell queuing not true alternating, but there is enough consistency to do this somewhat)
			if self.vb.beckonCast % 2 == 0 then
				timerBeckonCD:Start(55, self.vb.beckonCast+1)
			else
				timerBeckonCD:Start(self:IsMythic() and 80 or 85, self.vb.beckonCast+1)
			end
		elseif self.vb.phase == 3 then--Phase 3 (Unknown passed 2 casts, so needs work)
			timerBeckonCD:Start(self:IsMythic() and 35 or self:IsHeroic() and 70 or 90, self.vb.beckonCast+1)
		else--Phase 4
			--Phase 4 pattern (imprecise as hell, it's spell queuing not true alternating, but there is enough consistency to do this somewhat)
			local timer = self:IsEasy() and phase4LFRBeckonTimers[self.vb.beckonCast+1] or self:IsHeroic() and phase4HeroicBeckonTimers[self.vb.beckonCast+1] or self:IsMythic() and 97.4
			if timer then
				timerBeckonCD:Start(timer, self.vb.beckonCast+1)
			end
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 302208 and self:AntiSpam(4, 6) then
		warnPressureSurge:Show()
	elseif spellId == 298014 then
		timerColdBlastCD:Start()
	elseif spellId == 301078 then
		timerChargedSpearCD:Start(self:IsMythic() and (self.vb.phase == 1 and 16.1 or 15) or self.vb.phase == 1 and 32 or 12.8, args.sourceGUID)
	elseif spellId == 300743 then
		timerVoidTouchedCD:Start()
	elseif spellId == 300334 then
		self.vb.drainWardCount = self.vb.drainWardCount + 1
		warnDrainAncientWard:Show(self.vb.drainWardCount)
	elseif spellId == 300768 then
		self.vb.piercingCount = self.vb.piercingCount + 1
		specWarnPiercingGaze:Show(self.vb.piercingCount)
		specWarnPiercingGaze:Play("farfromline")
		local timer = self:IsMythic() and phase4MythicPiercingTimers[self.vb.piercingCount+1] or self:IsLFR() and phase4LFRPiercingTimers[self.vb.piercingCount+1] or self:IsHeroic() and phase4HeroicPiercingTimers[self.vb.piercingCount+1] or self:IsNormal() and phase4NormalPiercingTimers[self.vb.piercingCount+1]
		if timer then
			timerPiercingGazeCD:Start(timer, self.vb.piercingCount+1)
		end
	elseif spellId == 181089 then--Encounter Event
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if cid == 153064 then--overzealous-hulk spawn.
			self.vb.bigAddCount = self.vb.bigAddCount + 1
			specWarnHulk:Show(self.vb.bigAddCount)
			specWarnHulk:Play("bigmob")
			local timer = self:IsMythic() and HulkTimers["Mythic"][self.vb.bigAddCount+1] or self:IsHeroic() and HulkTimers["Heroic"][self.vb.bigAddCount+1] or HulkTimers["Normal"][self.vb.bigAddCount+1]
			if timer and self.vb.phase == 1 then
				timerHulkSpawnCD:Start(timer, self.vb.bigAddCount+1)
			end
		elseif cid == 155354 then--Azshara's Indomitable
			self.vb.bigAddCount = self.vb.bigAddCount + 1
			specWarnAzsharasIndomitable:Show(self.vb.bigAddCount)
			specWarnAzsharasIndomitable:Play("bigmob")
		elseif cid == 154240 and self:AntiSpam(10, 10) then--Azshara's Devoted
			specWarnAzsharasDevoted:Show()
			specWarnAzsharasDevoted:Play("killmob")
			timerAzsharasDevotedCD:Start(95)
		elseif cid == 154565 then--Loyal Myrmidon
			self.vb.myrmidonCount = self.vb.myrmidonCount + 1
			specWarnLoyalMyrmidon:Show()
			specWarnLoyalMyrmidon:Play("bigmob")
			if self.vb.myrmidonCount == 1 then
				timerLoyalMyrmidonCD:Start(self:IsMythic() and 59.9 or self:IsHeroic() and 94.7 or 90, 2)
			elseif self.vb.myrmidonCount == 2 then
				timerLoyalMyrmidonCD:Start(self:IsMythic() and 49.9 or self:IsHeroic() and 94.7 or 90, 3)
			end
		end
	elseif spellId == 297371 then
		self.vb.reversalCount = self.vb.reversalCount + 1
		specWarnReversalofFortune:Show()
		specWarnReversalofFortune:Play("telesoon")
		--Mythic and heroic see this in P2, and it's 80, normal sees this in P3 and 4, and it's 70 there.
		timerReversalofFortuneCD:Start(self.vb.phase == 2 and 80 or 70, self.vb.reversalCount+1)
	elseif spellId == 297372 then
		self.vb.reversalCount = self.vb.reversalCount + 1
		specWarnGreaterReversal:Show()
		specWarnGreaterReversal:Play("telesoon")
		timerGreaterReversalCD:Start(self:IsMythic() and (self.vb.phase == 4 and 81.2 or 90) or 70, self.vb.reversalCount+1)
	elseif spellId == 303986 and self:AntiSpam(5, 11) then
		self.vb.netherCount = self.vb.netherCount + 1
		warnNetherPortal:Show(self.vb.netherCount)
		if self:IsHard() then
			local timer = self:IsMythic() and phase4MythicPortalTimers[self.vb.netherCount+1] or self:IsHeroic() and phase4HeroicPortalTimers[self.vb.netherCount+1] or 35
			timerNetherPortalCD:Start(timer, self.vb.netherCount+1)
		else
			local timer = phase4NormalPortalTimers[self.vb.netherCount+1] or 32
			timerNetherPortalCD:Start(timer, self.vb.netherCount+1)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 302999 then
		local amount = args.amount or 1
		if args:IsPlayer() and (amount >= 18 and amount % 3 == 0) then--18, 21, etc
			specWarnArcaneVuln:Show(amount)
			specWarnArcaneVuln:Play("stackhigh")
		end
	elseif spellId == 298569 then
		local amount = args.amount or 1
		drainedSoulStacks[args.destName] = amount
		if args:IsPlayer() then
			if not playerSoulDrained then
				playerSoulDrained = true
			end
			if amount >= 5 then
				specWarnDrainedSoul:Show(amount)
				specWarnDrainedSoul:Play("stackhigh")
			end
		end
	elseif spellId == 297912 then
		if self.Options.NPAuraOnTorment then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId)
		end
	elseif spellId == 300428 then
		if self.Options.NPAuraOnInfuriated then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId)
		end
	elseif spellId == 298014 then
		local amount = args.amount or 1
		if not self.vb.painfulMemoriesActive and amount >= 3 then--If painful memories is active, there will be no swaps, fallback to no special warnings just stacks
			if args:IsPlayer() then
				specWarnColdBlast:Show(amount)
				specWarnColdBlast:Play("stackhigh")
			else
				if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", spellId) then--Can't taunt less you've dropped yours off, period.
					specWarnColdBlastTaunt:Show(args.destName)
					specWarnColdBlastTaunt:Play("tauntboss")
				else
					warnColdBlast:Show(args.destName, amount)
				end
			end
		else
			warnColdBlast:Show(args.destName, amount)
		end
	elseif spellId == 300743 then
		local amount = args.amount or 1
		if amount >= 4 then
			if args:IsPlayer() then
				specWarnVoidtouched:Show(amount)
				specWarnVoidtouched:Play("stackhigh")
			else
				if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", spellId) then--Can't taunt less you've dropped yours off, period.
					specWarnVoidtouchedTaunt:Show(args.destName)
					specWarnVoidtouchedTaunt:Play("tauntboss")
				else
					warnVoidTouched:Show(args.destName, amount)
				end
			end
		else
			warnVoidTouched:Show(args.destName, amount)
		end
	elseif spellId == 298018 then
		warnFrozen:Show(args.destName)
	elseif spellId == 301078 then
		if args:IsPlayer() then
			if #mobShielded > 0 then
				specWarnChargedSpear:Show(shieldName)
				specWarnChargedSpear:Play("behindmob")
			else
				specWarnChargedSpear:Show(DBM_CORE_ROOM_EDGE)
				specWarnChargedSpear:Play("runtoedge")
			end
			yellChargedSpear:Yell()
			yellChargedSpearFades:Countdown(spellId)
		else
			warnChargedSpear:CombinedShow(0.5, args.destName)--if two adds are up, they actually go out at same time and we want to combine them
		end
	elseif spellId == 299094 or spellId == 302141 or spellId == 303797 or spellId == 303799 then--303797 and 303799 unknown
		if args:IsPlayer() then
			yellBeckon:Yell()
		elseif self:IsHard() and (spellId == 303797 or spellId == 303799) and self:CheckNearby(8, args.destName) and not DBM:UnitDebuff("player", spellId) then--Warn nearby, because it's jealousy version
			specWarnBeckonNear:CombinedShow(0.5, args.destName)
			specWarnBeckonNear:ScheduleVoice(0.5, "runaway")
		end
	elseif spellId == 303825 then
		warnCrushingDepths:CombinedShow(1, args.destName)
	--Suffer (soak Orb), Obey (don't soak orb), Stand Together (group up), Stand Alone (don't group up), March (keep moving), Stay (stop moving)
	elseif spellId == 299249 or spellId == 299251 or spellId == 299254 or spellId == 299255 or spellId == 299252 or spellId == 299253 then
		if args:IsPlayer() then
			if self:AntiSpam(10, 1) then
				text = ""
				playerDecreeCount = 0
				playerDecreeYell = 0
			end
			if spellId == 299249 then--Soak Orbs
				specWarnQueensDecree:ScheduleVoiceOverLap(0+playerDecreeCount, "helpsoak")
				if text == "" then
					text = L.SoakOrb
				else
					text = text..", "..L.SoakOrb
				end
				playerDecreeYell = playerDecreeYell + 2--100s 2-Stack/1-Solo, 10s 2-Moving/1-Stay, 1s 2-Soak/1-NoSoak
			elseif spellId == 299251 then--Dodge Orbs
				specWarnQueensDecree:ScheduleVoiceOverLap(0+playerDecreeCount, "watchorb")
				if text == "" then
					text = L.AvoidOrb
				else
					text = text..", "..L.AvoidOrb
				end
				playerDecreeYell = playerDecreeYell + 1--100s 2-Stack/1-Solo, 10s 2-Moving/1-Stay, 1s 2-Soak/1-NoSoak
			elseif spellId == 299254 then--Group Up
				specWarnQueensDecree:ScheduleVoiceOverLap(0+playerDecreeCount, "gather")
				if text == "" then
					text = L.GroupUp
				else
					text = text..", "..L.GroupUp
				end
				playerDecreeYell = playerDecreeYell + 200--100s 2-Stack/1-Solo, 10s 2-Moving/1-Stay, 1s 2-Soak/1-NoSoak
			elseif spellId == 299255 then--Don't Group Up
				specWarnQueensDecree:ScheduleVoiceOverLap(0+playerDecreeCount, "scatter")
				if text == "" then
					text = L.Spread
				else
					text = text..", "..L.Spread
				end
				playerDecreeYell = playerDecreeYell + 100--100s 2-Stack/1-Solo, 10s 2-Moving/1-Stay, 1s 2-Soak/1-NoSoak
			elseif spellId == 299252 then--Keep Moving
				specWarnQueensDecree:ScheduleVoiceOverLap(0+playerDecreeCount, "keepmove")
				if text == "" then
					text = L.Move
				else
					text = text..", "..L.Move
				end
				playerDecreeYell = playerDecreeYell + 20--100s 2-Stack/1-Solo, 10s 2-Moving/1-Stay, 1s 2-Soak/1-NoSoak
			elseif spellId == 299253 then--Stop Moving
				specWarnQueensDecree:ScheduleVoiceOverLap(0+playerDecreeCount, "stopmove")
				if text == "" then
					text = L.DontMove
				else
					text = text..", "..L.DontMove
				end
				playerDecreeYell = playerDecreeYell + 10--100s 2-Stack/1-Solo, 10s 2-Moving/1-Stay, 1s 2-Soak/1-NoSoak
			end
			playerDecreeCount = playerDecreeCount + 1--Increased after voices, because of way voice scheduling is being done
			--Only show warning after we've collected all decrees we'regoing to get
			--Sometimes you get less than max amount though so must still schedule
			specWarnQueensDecree:Cancel()
			if self.vb.maxDecree == playerDecreeCount then
				specWarnQueensDecree:Show(text)
			else
				specWarnQueensDecree:Schedule(0.5, text)
			end
			self:Unschedule(decreeYellRepeater)
			self:Schedule(1, decreeYellRepeater, self)
		end
	elseif spellId == 303657 then
		local icon = self.vb.arcaneBurstIcon
		warnArcaneBurst:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnArcaneBurst:Show(self:IconNumToTexture(icon))
			specWarnArcaneBurst:Play("targetyou")
			yellArcaneBurst:Yell(icon, icon, icon)
			yellArcaneBurstFades:Countdown(spellId, nil, icon)
		end
		if self.Options.SetIconOnArcaneBurst then
			self:SetIcon(args.destName, icon)
		end
		self.vb.arcaneBurstIcon = self.vb.arcaneBurstIcon + 1
	elseif spellId == 300492 then
		if args:IsPlayer() then
			specWarnStaticShock:Show()
			specWarnStaticShock:Play("runout")
			yellStaticShock:Yell()
		else
			warnStaticShock:Show(args.destName)
		end
	elseif spellId == 300620 then
		if not mobShielded[args.destGUID] then
			mobShielded[args.destGUID] = true
		end
		warnCrystallineShield:Show(args.destName)
	elseif spellId == 300866 then
		if args:IsPlayer() then
			specWarnEssenceofAZeroth:Show()
			specWarnEssenceofAZeroth:Play("targetyou")
		else
			warnEssenceofAzeroth:Show(args.destName)
		end
	elseif spellId == 300877 then
		if args:IsPlayer() then
			specWarnSystemShock:Show()
			specWarnSystemShock:Play("defensive")
		else
			warnSystemShock:Show(args.destName)
		end
	elseif spellId == 304267 then
		self.vb.painfulMemoriesActive = true
	--Gaining Ward of Power Buff from Blue ward when entering fight
	--This will only work on heroic/mythic. Adds don't gain buff on normal/LFR, only azshara does
	--[[elseif spellId == 300551 and not seenAdds[args.destGUID] then
		seenAdds[args.destGUID] = true
		local cid = self:GetCIDFromGUID(args.destGUID)
		if cid == 155354 then--Azshara's Indomitable
			self.vb.bigAddCount = self.vb.bigAddCount + 1
			specWarnAzsharasIndomitable:Show(self.vb.bigAddCount)
			specWarnAzsharasIndomitable:Play("bigmob")
		elseif cid == 154240 and self:AntiSpam(10, 10) then--Azshara's Devoted
			specWarnAzsharasDevoted:Show()
			specWarnAzsharasDevoted:Play("killmob")
			timerAzsharasDevotedCD:Start(95)
		elseif cid == 154565 then--Loyal Myrmidon
			specWarnLoyalMyrmidon:Show()
			specWarnLoyalMyrmidon:Play("bigmob")
			timerLoyalMyrmidonCD:Start(self:IsMythic() and 57.5 or 94.7)
		end--]]
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 302999 then--Arcane vuln
		--Do stuff?
	elseif spellId == 298569 then
		drainedSoulStacks[args.destName] = 0
		if args:IsPlayer() then
			playerSoulDrained = false
		end
	elseif spellId == 297912 then
		if self.Options.NPAuraOnTorment then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	elseif spellId == 300428 then
		if self.Options.NPAuraOnInfuriated then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	elseif spellId == 301078 then
		if args:IsPlayer() then
			yellChargedSpearFades:Cancel()
		end
	elseif spellId == 303657 then
		if args:IsPlayer() then
			yellArcaneBurstFades:Cancel()
		end
		if self.Options.SetIconOnArcaneBurst then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 304267 and self:AntiSpam(3, 7) then
		self.vb.painfulMemoriesActive = false
		warnPainfulMemoriesOver:Show(DBM_CORE_RESTORE_LOS)
		warnPainfulMemoriesOver:Play("moveboss")
	elseif spellId == 299249 or spellId == 299251 or spellId == 299254 or spellId == 299255 or spellId == 299252 or spellId == 299253 then
		if args:IsPlayer() then
			if spellId == 299249 then--Soak Orbs
				playerDecreeYell = playerDecreeYell - 2--100s 2-Stack/1-Solo, 10s 2-Moving/1-Stay, 1s 2-Soak/1-NoSoak
			elseif spellId == 299251 then--Dodge Orbs
				playerDecreeYell = playerDecreeYell - 1--100s 2-Stack/1-Solo, 10s 2-Moving/1-Stay, 1s 2-Soak/1-NoSoak
			elseif spellId == 299254 then--Group Up
				playerDecreeYell = playerDecreeYell - 200--100s 2-Stack/1-Solo, 10s 2-Moving/1-Stay, 1s 2-Soak/1-NoSoak
			elseif spellId == 299255 then--Don't Group Up
				playerDecreeYell = playerDecreeYell - 100--100s 2-Stack/1-Solo, 10s 2-Moving/1-Stay, 1s 2-Soak/1-NoSoak
			elseif spellId == 299252 then--Keep Moving
				playerDecreeYell = playerDecreeYell - 20--100s 2-Stack/1-Solo, 10s 2-Moving/1-Stay, 1s 2-Soak/1-NoSoak
			elseif spellId == 299253 then--Stop Moving
				playerDecreeYell = playerDecreeYell - 10--100s 2-Stack/1-Solo, 10s 2-Moving/1-Stay, 1s 2-Soak/1-NoSoak
			end
		end
	elseif spellId == 300620 then
		mobShielded[args.destGUID] = nil
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 301425 and self:AntiSpam(2, 2) then
		self.vb.controlledBurst = self.vb.controlledBurst + 1
		if (self.vb.overloadCount == 1 and self.vb.controlledBurst == 3) or self.vb.controlledBurst == 4 then
			timerMassiveEnergySpike:Stop()
		end
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if (spellId == 303981 or spellId == 297907) and destGUID == UnitGUID("player") and self:AntiSpam(2, 8) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

do
	--Unit even faster, however, UNIT_DIED is more reliable for WCL analysis. Besides the 2 sec difference doesn't matter much here
	--"<144.22 23:55:33> [UNIT_SPELLCAST_SUCCEEDED] Aethanel(??) -Bow to the Queen- [[boss1:Cast-3-2083-2164-3398-299963-000C686854:299963]]", -- [4155]
	--"<146.16 23:55:35> [CLEU] UNIT_DIED##nil#Creature-0-2083-2164-3398-153059-000068674A#Aethanel#-1#false#nil#nil", -- [4209]
	local function startIntermissionOne(self)
		self.vb.phase = 1.5
		self.vb.arcaneOrbCount = 0
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(1.5))
		warnPhase:Play("phasechange")
		timerPainfulMemoriesCD:Stop()
		timerLongingCD:Stop()
		timerArcaneOrbsCD:Stop()
		timerBeckonCD:Stop()
		timerDivideandConquerCD:Stop()
		timerHulkSpawnCD:Stop()
		timerNextPhase:Start(27.3)--To Ward of Power cast start
	end
	function mod:UNIT_DIED(args)
		local cid = self:GetCIDFromGUID(args.destGUID)
		if cid == 153059 then--Aethanel
			timerLightningOrbsCD:Stop()
			timerColdBlastCD:Stop()
			self.vb.stageOneBossesLeft = self.vb.stageOneBossesLeft - 1
			if self.vb.stageOneBossesLeft == 0 then
				startIntermissionOne(self)
			end
		elseif cid == 153060 then--Cryanus
			timerChargedSpearCD:Stop(args.destGUID)
			self.vb.stageOneBossesLeft = self.vb.stageOneBossesLeft - 1
			if self.vb.stageOneBossesLeft == 0 then
				startIntermissionOne(self)
			end
		elseif cid == 155643 or cid == 153064 then--overzealous-hulk
			castsPerGUID[args.destGUID] = nil
		elseif cid == 154565 then--Loyal Myrmidon
			timerChargedSpearCD:Stop(args.destGUID)
		end
	end
end

--2.5 seconds faster than APPLIED/SUCCESS, giving you a little time to move out of melee before stun
function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("299094") then
		specWarnBeckon:Show()
		specWarnBeckon:Play("justrun")
	end
end

function mod:OnTranscriptorSync(msg, targetName)
	if msg:find("299094") and targetName then
		targetName = Ambiguate(targetName, "none")
		if self:AntiSpam(4, targetName) then
			warnBeckon:CombinedShow(0.5, targetName)
		end
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if msg:find("spell:298787") then--Arcane Orbs
		--Arcane Orbs-298787-npc:Queen Azshara = pull:70.5, 65.0, 75.0
		--Arcane Orbs-298787-npc:Queen Azshara = pull:69.8, 65.0, 74.8, 75.1", -- [1]
		--65.1, 60.1
		self.vb.arcaneOrbCount = self.vb.arcaneOrbCount + 1
		specWarnArcaneOrbs:Show(self.vb.arcaneOrbCount)
		specWarnArcaneOrbs:Play("watchorb")
		timerArcaneOrbsCD:Start(self:IsMythic() and 59.9 or (self.vb.arcaneOrbCount == 1 and 65 or 74.8), self.vb.arcaneOrbCount+1)
	elseif msg:find("spell:300522") and self:AntiSpam(10, 4) then--Divide and Conquer
		specWarnDivideandConquer:Show()
		timerDivideandConquerCD:Start(self.vb.phase == 4 and 87.5 or self.vb.phase == 3 and 59.8 or 65)
	end
end

--"<42.26 22:35:16> [CHAT_MSG_MONSTER_EMOTE] %s rushes toward an Ancient Ward!#Overzealous Hulk###Ward##0#0##0#327#nil#0#false#false#false#false", -- [437]
--"<42.30 22:35:16> [UNIT_SPELLCAST_SUCCEEDED] Overzealous Hulk(??) -Rush Ancient Ward- [[nameplate2:Cast-3-2012-2164-133-298496-00220D3F7F:298496]]", -- [440]
--"<42.30 22:35:16> [INSTANCE_ENCOUNTER_ENGAGE_UNIT]
--Emote requires localizing, Unit even requires nameplates because it fires BEFORE add gains a boss unit ID, only reliable spawn trigger is IEEU
function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	for i = 1, 5 do
		local unitID = "boss"..i
		local GUID = UnitGUID(unitID)
		if GUID and not seenAdds[GUID] then
			seenAdds[GUID] = true
			local cid = self:GetCIDFromGUID(GUID)
			if cid == 153090 or cid == 153091 then--Phase 3 Sirens becoming active
				--timerStaticShockCD:Start(97.9, GUID)
				if self.vb.phase < 3 then
					self.vb.phase = 3
					warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(3))
					warnPhase:Play("pthree")
					if self:IsMythic() then
						timerStageThreeBerserk:Start(174.2)
					end
				end
			--[[elseif cid == 153064 then--overzealous-hulk spawn.
				self.vb.bigAddCount = self.vb.bigAddCount + 1
				specWarnHulk:Show(self.vb.bigAddCount)
				specWarnHulk:Play("bigmob")
				local timer = self:IsMythic() and HulkTimers["Mythic"][self.vb.bigAddCount+1] or self:IsHeroic() and HulkTimers["Heroic"][self.vb.bigAddCount+1] or HulkTimers["Normal"][self.vb.bigAddCount+1]
				if timer and self.vb.phase == 1 then
					timerHulkSpawnCD:Start(timer, self.vb.bigAddCount+1)
				end--]]
			end
		end
	end
end

local function startIntermissionTwo(self)
	self.vb.phase = 2.5
	self.vb.reversalCount = 0
	self.vb.arcaneBurstCount = 0
	self.vb.arcaneDetonation = 0
	self.vb.beckonCast = 0
	self.vb.myrmidonCount = 0
	warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(2.5))
	warnPhase:Play("phasechange")
	timerReversalofFortuneCD:Stop()
	timerBeckonCD:Stop()
	timerArcaneBurstCD:Stop()
	timerArcaneDetonationCD:Stop()
	timerDivideandConquerCD:Stop()
	timerAzsharasDevotedCD:Stop()
	timerAzsharasIndomitableCD:Stop()
	timerNextPhase:Start(29.9)--Time til P3 trigger, which is adds firing IEEU and becoming attackable and first myrmidon coming out as well
	if self:IsMythic() then
		timerBeckonCD:Start(44.7, 1)
		timerGreaterReversalCD:Start(74.7, 1)--Same on heroic/mythic
		timerArcaneDetonationCD:Start(54.7, 1)
		timerArcaneBurstCD:Start(66.7, 1)
		timerDivideandConquerCD:Start(39.9)
	elseif self:IsHeroic() then
		timerBeckonCD:Start(40, 1)
		timerGreaterReversalCD:Start(74.7, 1)--Same on heroic/mythic
		timerArcaneDetonationCD:Start(75, 1)
		timerArcaneBurstCD:Start(86.7, 1)
	else
		timerBeckonCD:Start(64.6, 1)
		timerReversalofFortuneCD:Start(77.7, 1)
		timerArcaneDetonationCD:Start(94.7, 1)
		timerArcaneBurstCD:Start(116.7, 1)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 303629 then--Arcane Burst
		self.vb.arcaneBurstIcon = 1
		--60, 70.0, 55.3 (P2)
		self.vb.arcaneBurstCount = self.vb.arcaneBurstCount + 1
		if self:IsMythic() then
			timerArcaneBurstCD:Start(45, self.vb.arcaneBurstCount+1)
		else
			if self.vb.arcaneBurstCount % 2 == 0 then
				timerArcaneBurstCD:Start(55, self.vb.arcaneBurstCount+1)
			else
				timerArcaneBurstCD:Start(self:IsLFR() and 80 or 60, self.vb.arcaneBurstCount+1)--See if still 70 on heroic
			end
		end
	elseif spellId == 302034 then--Adjure
		--"<338.85 14:18:47> [UNIT_SPELLCAST_SUCCEEDED] Queen Azshara(Murdocc) -Adjure- [[boss1:Cast-3-3883-2164-252-302034-001924DA87:302034]]", -- [6299]
		--"<343.15 14:18:51> [CHAT_MSG_MONSTER_YELL] Coax the power from these ancient wards! Rattle the chains that bind him!#Queen Azshara###Omegall##0#0##0#2192#nil#0#false#false#false#false", -- [6362]
		self:Schedule(4.3, startIntermissionTwo, self)--Needed, because timers don't cancel until yell
	elseif spellId == 302860 then --Queen Azshara (P4 trigger)
		self.vb.phase = 4
		self.vb.reversalCount = 0
		self.vb.arcaneBurstCount = 0
		self.vb.arcaneDetonation = 0
		self.vb.beckonCast = 0
		timerBeckonCD:Stop()
		timerReversalofFortuneCD:Stop()
		timerGreaterReversalCD:Stop()
		timerArcaneDetonationCD:Stop()
		timerArcaneBurstCD:Stop()
		timerDivideandConquerCD:Stop()
		timerLoyalMyrmidonCD:Stop()

		if not self:IsLFR() then
			timerVoidTouchedCD:Start(12.9)
		end
		timerOverloadCD:Start(14, 1)
		if self:IsMythic() then
			timerStageThreeBerserk:Stop()
			timerNetherPortalCD:Start(26.7, 1)
			timerDivideandConquerCD:Start(39)
			timerPiercingGazeCD:Start(51.5, 1)
			timerGreaterReversalCD:Start(64, 1)
			timerBeckonCD:Start(72.8, 1)--START
			--Register burst damage events for the massive energy spike tracking timer
			self:RegisterShortTermEvents(
				"SPELL_DAMAGE 301425",
				"SPELL_MISSED 301425"
			)
		elseif self:IsHeroic() then
			timerNetherPortalCD:Start(23.9, 1)
			timerPiercingGazeCD:Start(43.9, 1)
			timerGreaterReversalCD:Start(48.8, 1)
			timerBeckonCD:Start(68.9, 1)--START
		else
			timerNetherPortalCD:Start(23.9, 1)
			timerPiercingGazeCD:Start(43.9, 1)
			timerReversalofFortuneCD:Start(51.9, 1)
			timerBeckonCD:Start(73.9, 1)--START
		end
	end
end
