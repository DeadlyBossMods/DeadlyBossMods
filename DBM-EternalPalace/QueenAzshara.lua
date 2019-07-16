local mod	= DBM:NewMod(2361, "DBM-EternalPalace", nil, 1179)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(152910)
mod:SetEncounterID(2299)
mod:SetZone()
mod:SetUsedIcons(3, 2, 1)
--mod:SetHotfixNoticeRev(16950)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 29--Respawn is near instant on ptr, boss requires clicking to engage, no body pulling anyways

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 297937 297934 298121 297972 298531 300478 299250 299178 300519 301431 299094 302141 303797 303799 300620",
	"SPELL_CAST_SUCCESS 302208 298014 301078 300743 300334 300768",
	"SPELL_AURA_APPLIED 302999 298569 297912 298014 298018 301078 300428 303825 303657 300492 300620 299094 303797 303799 300743 300866 300877 299249 299251 299254 299255 299252 299253 300502 302141 304267 300551",
	"SPELL_AURA_APPLIED_DOSE 302999 298569 298014 300743",
	"SPELL_AURA_REMOVED 302999 298569 297912 301078 300428 303657 300502 304267 299249 299251 299254 299255 299252 299253 300620",
	"SPELL_PERIODIC_DAMAGE 297907 303981",
	"SPELL_PERIODIC_MISSED 297907 303981",
	"UNIT_DIED",
	"RAID_BOSS_WHISPER",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"
--	"UPDATE_UI_WIDGET"
)

--TODO, do something different with pressure surge later, announce remaining maybe
--TODO, figure out stacks for drained soul and arcane debuffs to know what's too high
--TODO, finetune arcane burst timing based on size of room and movement penalties and fix spellID for start/success events
--TODO, detect various adds joining fight and timer/warn them in stage 2+
--TODO, beckon might use https://ptr.wowhead.com/spell=303802/army-of-azshara instead
--TODO, check if multiple targets for static shock
--TODO, figure out siren creature IDs so they can be auto marked and warning for shield can include which marked mob got it
--TODO, fine tune beckon spell Ids, when specific one that has jealousy is known for certain, add nearby warning
--TODO, figure out cast time for https://ptr.wowhead.com/spell=301518/massive-energy-spike (ie between overload cast start, and when all remaining energy is released)
--TODO, announce short ciruit?
--TODO, capture UPDATE_UI_WIDGET better with modified transcriptor to get the widget values I need
--[[
(ability.id = 297937 or ability.id = 297934 or ability.id = 298121 or ability.id = 297972 or ability.id = 298531 or ability.id = 300478 or ability.id = 299250 or ability.id = 299178 or ability.id = 300519 or ability.id = 303629 or ability.id = 297372 or ability.id = 301431) and type = "begincast"
 or (ability.id = 302208 or ability.id = 298014 or ability.id = 301078 or ability.id = 299094 or ability.id = 303657 or ability.id = 303629 or ability.id = 300492 or ability.id = 300743 or ability.id = 303980 or ability.id = 302141 or ability.id = 300334 or ability.id = 303797 or ability.id = 303799 or ability.id = 300768) and type = "cast"
 or type = "death" and (target.id = 153059 or target.id = 153060)
--]]
--Ancient Wards
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
--local warnEnergizeWardofPower			= mod:NewSpellAnnounce(300490, 3)
local warnStaticShock					= mod:NewTargetAnnounce(300492, 2)
local warnCrystallineShield				= mod:NewTargetNoFilterAnnounce(300620, 2)
--Stage Four: My Palace Is a Prison
local warnVoidTouched					= mod:NewStackAnnounce(300743, 2, nil, "Tank")
local warnNetherPortal					= mod:NewSpellAnnounce(303980, 2)
local warnEssenceofAzeroth				= mod:NewTargetAnnounce(300866, 2)
local warnOverload						= mod:NewCountAnnounce(301431, 2)
local warnSystemShock					= mod:NewTargetAnnounce(300877, 3)

--Ancient Wards
local specWarnDrainedSoul				= mod:NewSpecialWarningStack(298569, nil, 6, nil, nil, 1, 6)
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
local specWarnDivideandConquer			= mod:NewSpecialWarningDodge(300478, nil, nil, nil, 3, 2)--Mythic
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
local specWarnArcaneBurstFading			= mod:NewSpecialWarningMoveTo(303657, nil, nil, nil, 3, 2)
local specWarnAzsharasIndomitable		= mod:NewSpecialWarningSwitchCount("ej20410", "Dps", nil, nil, 1, 2)
--local specWarnArcaneBurstTaunt		= mod:NewSpecialWarningTaunt(303657, nil, nil, nil, 1, 2)
--Stage Three: Song of the Tides
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

--Stage One: Cursed Lovers
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20250))
local timerPainfulMemoriesCD			= mod:NewNextTimer(60, 297937, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerLongingCD					= mod:NewNextTimer(60, 297934, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
----Aethanel
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20261))
local timerLightningOrbsCD				= mod:NewCDTimer(16.1, 298121, nil, nil, nil, 3)
--local timerChainLightningCD				= mod:NewCDTimer(7.3, 297972, nil, false, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)--7-24, all over place, so off by default
local timerColdBlastCD					= mod:NewCDTimer(9.4, 298014, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
----Cyranus
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20266))
local timerChargedSpearCD				= mod:NewCDTimer(32.3, 301078, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)--32-40 in stage 1, 12.4-15 stage 3
----Overzealous Hulk
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20480))
local timerHulkSpawnCD					= mod:NewCDCountTimer(30.4, "ej20480", nil, nil, nil, 1, 298531, DBM_CORE_DAMAGE_ICON)
--local timerGroundPoundCD				= mod:NewAITimer(30.4, 298531, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)--All over the place, basically can't let any go off anyways
----Azshara
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20258))
local timerDrainAncientWardCD			= mod:NewCDCountTimer(50, 300334, nil, nil, nil, 5)
local timerArcaneOrbsCD					= mod:NewCDCountTimer(65, 298787, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
local timerBeckonCD						= mod:NewCDCountTimer(30.4, 299094, nil, nil, nil, 3)
local timerDivideandConquerCD			= mod:NewAITimer(30.4, 300478, nil, nil, nil, 3, nil, DBM_CORE_MYTHIC_ICON..DBM_CORE_DEADLY_ICON)
--Intermission One: Queen's Decree
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20335))
local timerQueensDecreeCD				= mod:NewCDTimer(30.4, 299250, nil, nil, nil, 3, nil, DBM_CORE_IMPORTANT_ICON)
local timerNextPhase					= mod:NewPhaseTimer(30.4)
--Stage Two: Hearts Unleashed
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20323))
local timerArcaneDetonationCD			= mod:NewCDCountTimer(80, 300519, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON, nil, 1, 5)
local timerReversalofFortuneCD			= mod:NewCDCountTimer(80, 297371, nil, nil, nil, 5, nil, DBM_CORE_IMPORTANT_ICON, nil, 2, 5)
local timerArcaneBurstCD				= mod:NewCDCountTimer(58.2, 303657, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON)
local timerAzsharasIndomitableCD		= mod:NewCDTimer(100, "ej20410", nil, nil, nil, 1, 298531, DBM_CORE_DAMAGE_ICON)
--Stage Three: Song of the Tides
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20340))
--local timerEnergizeWardofPowerCD		= mod:NewAITimer(58.2, 303657, nil, nil, nil, 5)
--local timerStaticShockCD				= mod:NewAITimer(58.2, 300492, nil, nil, nil, 3)
--local timerCrystallineShieldCD		= mod:NewCDTimer(17, 300620, nil, nil, nil, 3, nil, DBM_CORE_DAMAGE_ICON..DBM_CORE_IMPORTANT_ICON)
--Stage Four: My Palace Is a Prison
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20361))
local timerGreaterReversalCD			= mod:NewCDCountTimer(70, 297372, 297371, nil, nil, 5, nil, DBM_CORE_IMPORTANT_ICON..DBM_CORE_HEROIC_ICON, nil, 2, 5)
local timerVoidTouchedCD				= mod:NewCDTimer(6.9, 300743, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)
local timerNetherPortalCD				= mod:NewCDTimer(35, 303980, nil, nil, nil, 3)--35 unless delayed by spell queue
local timerOverloadCD					= mod:NewCDCountTimer(54.9, 301431, nil, nil, nil, 5, nil, DBM_CORE_IMPORTANT_ICON)
local timerPiercingGazeCD				= mod:NewCDTimer(65, 300768, nil, nil, nil, 3)

--local berserkTimer					= mod:NewBerserkTimer(600)

mod:AddNamePlateOption("NPAuraOnTorment", 297912)
mod:AddNamePlateOption("NPAuraOnInfuriated", 300428)
--mod:AddRangeFrameOption(6, 264382)
mod:AddInfoFrameOption(298569, true)
mod:AddBoolOption("SortDesc", false)
mod:AddBoolOption("ShowTimeNotStacks", false)
mod:AddSetIconOption("SetIconOnArcaneBurst", 303657, true, false, {1, 2, 3})

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
mod.vb.painfulMemoriesActive = false
local drainedSoulStacks = {}
local playerSoulDrained = false
local shieldName = DBM:GetSpellInfo(300620)
local seenAdds = {}
local castsPerGUID = {}
local playerDecreeCount = 0
local playerDecreeYell = 0--100s 2-Stack/1-Solo, 10s 2-Moving/1-Stay, 1s 2-Soak/1-NoSoak
local phase1HeroicAddTimers = {41.7, 59.6, 89.1, 44.8, 39.4}--First two live verified, rest is PTR data that needs to be verified
local phase1NormalAddTimers = {42.6, 84.7}
local mobShielded = {}

local updateInfoFrame
do
	local floor, tsort = math.floor, table.sort
	local lines = {}
	local tempLines = {}
	local tempLinesSorted = {}
	local sortedLines = {}
	--local function sortFuncDesc(a, b) return tempLines[a] > tempLines[b] end
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
		--Power levels pulled from widgets
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
	--playerDecreeYell = 0--100s 2-Stack/1-Solo, 10s 2-Moving/1-Stay, 1s 2-Soak/1-NoSoak
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
	self.vb.painfulMemoriesActive = false
	playerDecreeYell = 0
	playerSoulDrained = false
	table.wipe(drainedSoulStacks)
	table.wipe(seenAdds)
	table.wipe(castsPerGUID)
	table.wipe(mobShielded)
	timerPainfulMemoriesCD:Start(19.7)
	--Aethanel
	timerLightningOrbsCD:Start(24.4-delay)
	--timerChainLightningCD:Start(15.3-delay)
	timerColdBlastCD:Start(14.4-delay)--SUCCESS
	--Cyranus
	timerChargedSpearCD:Start(27.5-delay)
	--Azshara
	timerDrainAncientWardCD:Start(31.6-delay, 1)
	timerHulkSpawnCD:Start(42-delay, 1)
	timerBeckonCD:Start(54.8-delay, 1)--START
	timerArcaneOrbsCD:Start(69.8-delay, 1)
	if self:IsMythic() then
		self.vb.maxDecree = 3
		timerDivideandConquerCD:Start(1-delay)
	elseif self:IsHeroic() then
		self.vb.maxDecree = 2
	else
		self.vb.maxDecree = 1
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
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
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
		timerLongingCD:Start(self:IsHard() and 65 or 70)
	elseif spellId == 297934 and self:AntiSpam(5, 3) then--Longing
		specWarnLonging:Show(DBM_CORE_RESTORE_LOS)
		specWarnLonging:Play("moveboss")
		timerPainfulMemoriesCD:Start(self:IsHard() and 20 or 24.9)
	elseif spellId == 298121 then
		warnLightningOrbs:Show()
		timerLightningOrbsCD:Start()
	elseif spellId == 297972 then
		--timerChainLightningCD:Start(nil, args.sourceGUID)
		if self:CheckInterruptFilter(args.sourceGUID, false, true) and not mobShielded[args.sourceGUID] then
			specWarnChainLightning:Show(args.sourceName)
			specWarnChainLightning:Play("kickcast")
		end
	elseif spellId == 298531 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		warnGroundPound:Show(count)
		--timerGroundPoundCD:Start(nil, args.sourceGUID)
	elseif spellId == 300478 then
		specWarnDivideandConquer:Show()
		timerDivideandConquerCD:Start()
	elseif spellId == 299250 and self:AntiSpam(4, 5) then--In rare cases she stutter casts it, causing double warnings
		playerDecreeCount = 0
		warnQueensDecree:Show()
	elseif spellId == 299178 and self.vb.phase < 2 then
		self.vb.phase = 2
		self.vb.arcaneBurstCount = 0
		self.vb.arcaneOrbCount = 0
		self.vb.beckonCast = 0
		self.vb.bigAddCount = 0
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(2))
		warnPhase:Play("ptwo")
		timerQueensDecreeCD:Stop()
		timerArcaneOrbsCD:Stop()
		if self:IsHard() then
			timerBeckonCD:Start(25, 1)--START
			timerReversalofFortuneCD:Start(68.1, 1)
			timerAzsharasIndomitableCD:Start(107)--107-110
			if self:IsMythic() then
				timerDivideandConquerCD:Start(2)
			end
		else
			timerBeckonCD:Start(60, 1)--START
			timerAzsharasIndomitableCD:Start(98.1)--98.1-110?
		end
		timerArcaneBurstCD:Start(52.1, 1)--SUCCESS (same on heroic and normal)
		timerArcaneDetonationCD:Start(75, 1)--START (same on heroic and normal)
	elseif spellId == 300519 then
		self.vb.arcaneDetonation = self.vb.arcaneDetonation + 1
		specWarnArcaneDetonation:Show(DBM_CORE_BREAK_LOS)
		specWarnArcaneDetonation:Play("findshelter")
		timerArcaneDetonationCD:Start(self:IsHard() and 75 or 80, self.vb.arcaneDetonation+1)
--	elseif spellId == 300490 then
		--warnEnergizeWardofPower:Show()
	elseif spellId == 301431 then
		self.vb.overloadCount = self.vb.overloadCount + 1
		if self.Options.SpecWarn301431count then
			specWarnOverload:Show(self.vb.overloadCount)
			specWarnOverload:Play("specialsoon")
		else
			warnOverload:Show(self.vb.overloadCount)
		end
		timerOverloadCD:Start(self:IsHard() and 44.9 or 54.9, self.vb.overloadCount+1)
	elseif spellId == 299094 or spellId == 302141 or spellId == 303797 or spellId == 303799 then--299094 Phase 1, 302141 phase 2, 303797 phase 3, 303799 Phase 4
		self.vb.beckonCast = self.vb.beckonCast + 1
		if self.vb.phase == 1 then
			--Phase 1 pattern (imprecise as hell, it's spell queuing not true alternating, but there is enough consistency to do this somewhat)
			if self.vb.beckonCast % 2 == 0 then
				--"Beckon-299094-npc:152910 = pull:59.1, 73.2, 51.2", -- [5] HEROIC
				--"Beckon-299094-npc:152910 = pull:59.4, 90.1", -- [6] NORMAL
				timerBeckonCD:Start(50, self.vb.beckonCast+1)--Most of time 55, but can be lower
			else
				--"Beckon-299094-npc:152910 = pull:56.1, 71.3, 50.6, 63.7"
				if self:IsHard() then
					timerBeckonCD:Start(self.vb.beckonCast == 1 and 70 or 60, self.vb.beckonCast+1)-- 2nd cast is always above 70, but 4th cast is more around 60, rest unknown so 60 assumed
				else
					timerBeckonCD:Start(self.vb.beckonCast == 1 and 90 or 60, self.vb.beckonCast+1)
				end
			end
		elseif self.vb.phase == 2 then--Phase 2 (Needs more sample)
			--Phase 2 pattern (imprecise as hell, it's spell queuing not true alternating, but there is enough consistency to do this somewhat)
			if self.vb.beckonCast % 2 == 0 then
				timerBeckonCD:Start(55, self.vb.beckonCast+1)
			else
				timerBeckonCD:Start(85, self.vb.beckonCast+1)
			end
		elseif self.vb.phase == 3 then--Phase 3 (Unknown passed 2 casts, so needs work)
			timerBeckonCD:Start(self:IsHard() and 70 or 90, self.vb.beckonCast+1)
		else--Phase 4
			--Phase 4 pattern (imprecise as hell, it's spell queuing not true alternating, but there is enough consistency to do this somewhat)
			if self.vb.beckonCast % 2 == 0 then
				timerBeckonCD:Start(55, self.vb.beckonCast+1)
			else
				timerBeckonCD:Start(90, self.vb.beckonCast+1)
			end
		end
	--elseif spellId == 300620 then
		--timerCrystallineShieldCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 302208 then
		warnPressureSurge:Show()
	elseif spellId == 298014 then
		timerColdBlastCD:Start()
	elseif spellId == 301078 then
		timerChargedSpearCD:Start(self.vb.phase == 1 and 32 or 12.8, args.sourceGUID)
--	elseif spellId == 300492 then
		--timerStaticShockCD:Start(nil, args.sourceGUID)
	elseif spellId == 300743 then
		timerVoidTouchedCD:Start()
	elseif spellId == 300334 then
		self.vb.drainWardCount = self.vb.drainWardCount + 1
		warnDrainAncientWard:Show(self.vb.drainWardCount)
		--Timers still all over place, it might just be trigger/health based?
		if self.vb.drainWardCount % 2 == 0 then
			timerDrainAncientWardCD:Start(49.9, self.vb.drainWardCount+1)
		else
			timerDrainAncientWardCD:Start(60, self.vb.drainWardCount+1)
		end
	elseif spellId == 300768 then
		specWarnPiercingGaze:Show()
		specWarnPiercingGaze:Play("farfromline")
		timerPiercingGazeCD:Start(self:IsHard() and 40 or 65)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 302999 then
		local amount = args.amount or 1
		if args:IsPlayer() and (amount >= 12 and amount % 3 == 0) then--12, 15, 18, 21, etc
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
			if amount >= 6 then--++
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
		--Temp, remove if cast event works
		if args:IsPlayer() then
			if self:AntiSpam(10, 1) then
				playerDecreeCount = 0
				playerDecreeYell = 0
			end
			local text
			if spellId == 299249 then--Soak Orbs
				specWarnQueensDecree:ScheduleVoiceOverLap(0+playerDecreeCount, "helpsoak")
				text = playerDecreeCount == 0 and L.SoakOrb or text..", "..L.SoakOrb
				playerDecreeYell = playerDecreeYell + 2--100s 2-Stack/1-Solo, 10s 2-Moving/1-Stay, 1s 2-Soak/1-NoSoak
			elseif spellId == 299251 then--Dodge Orbs
				specWarnQueensDecree:ScheduleVoiceOverLap(0+playerDecreeCount, "watchorb")
				text = playerDecreeCount == 0 and L.AvoidOrb or text..", "..L.AvoidOrb
				playerDecreeYell = playerDecreeYell + 1--100s 2-Stack/1-Solo, 10s 2-Moving/1-Stay, 1s 2-Soak/1-NoSoak
			elseif spellId == 299254 then--Group Up
				specWarnQueensDecree:ScheduleVoiceOverLap(0+playerDecreeCount, "gather")
				text = playerDecreeCount == 0 and L.GroupUp or text..", "..L.GroupUp
				playerDecreeYell = playerDecreeYell + 200--100s 2-Stack/1-Solo, 10s 2-Moving/1-Stay, 1s 2-Soak/1-NoSoak
			elseif spellId == 299255 then--Don't Group Up
				specWarnQueensDecree:ScheduleVoiceOverLap(0+playerDecreeCount, "scatter")
				text = playerDecreeCount == 0 and L.Spread or text..", "..L.Spread
				playerDecreeYell = playerDecreeYell + 100--100s 2-Stack/1-Solo, 10s 2-Moving/1-Stay, 1s 2-Soak/1-NoSoak
			elseif spellId == 299252 then--Keep Moving
				specWarnQueensDecree:ScheduleVoiceOverLap(0+playerDecreeCount, "keepmove")
				text = playerDecreeCount == 0 and L.Move or text..", "..L.Move
				playerDecreeYell = playerDecreeYell + 20--100s 2-Stack/1-Solo, 10s 2-Moving/1-Stay, 1s 2-Soak/1-NoSoak
			elseif spellId == 299253 then--Stop Moving
				specWarnQueensDecree:ScheduleVoiceOverLap(0+playerDecreeCount, "stopmove")
				text = playerDecreeCount == 0 and L.DontMove or text..", "..L.DontMove
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
			specWarnArcaneBurstFading:Schedule(5, DBM_CORE_BREAK_LOS)
			specWarnArcaneBurstFading:ScheduleVoice(5, "mm"..icon)
			yellArcaneBurst:Yell(icon, icon, icon)
			yellArcaneBurstFades:Countdown(spellId, nil, icon)
		--else
			--local uId = DBM:GetRaidUnitId(args.destName)
			--if self:IsTanking(uId) then
			--	specWarnArcaneBurstTaunt:Show(args.destName)
			--	specWarnArcaneBurstTaunt:Play("tauntboss")
			--end
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
	--This will only work on heroic/mythic. Adds don't gain buff on normal, only azshara does
	elseif spellId == 300551 and not seenAdds[args.destGUID] then
		seenAdds[args.destGUID] = true
		local cid = self:GetCIDFromGUID(args.destGUID)
		if cid == 155354 then--Azshara's Indomitable
			self.vb.bigAddCount = self.vb.bigAddCount + 1
			specWarnAzsharasIndomitable:Show(self.vb.bigAddCount)
			specWarnAzsharasIndomitable:Play("bigmob")
		end
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
			specWarnArcaneBurstFading:Cancel()
			specWarnArcaneBurstFading:CancelVoice()
			yellArcaneBurstFades:Cancel()
		end
		if self.Options.SetIconOnArcaneBurst then
			self:SetIcon(args.destName, 0)
		end
--	elseif spellId == 300502 then--Arcane Mastery

	elseif spellId == 304267 and self:AntiSpam(3, 4) then
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

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if (spellId == 303981 or spellId == 297907) and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
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
		timerDrainAncientWardCD:Stop()
		timerQueensDecreeCD:Start(7.5)--SUCCESS
		timerNextPhase:Start(27.3)--To Ward of Power cast start
	end
	function mod:UNIT_DIED(args)
		local cid = self:GetCIDFromGUID(args.destGUID)
		if cid == 153059 then--Aethanel
			timerLightningOrbsCD:Stop()
			--timerChainLightningCD:Stop()
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
			--timerGroundPoundCD:Stop(args.destGUID)
		elseif cid == 153090 then--Lady Venomtongue#
			--timerStaticShockCD:Stop(args.destGUID)
			--timerChainLightningCD:Stop(args.destGUID)
		elseif cid == 153091 then--Serena Scarscale
			--timerStaticShockCD:Stop(args.destGUID)
			--timerChainLightningCD:Stop(args.destGUID)
--		elseif cid == 154240 then--azsharas-devoted

--		elseif cid == 155354 then--Azshara's Indomitable

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
		self.vb.arcaneOrbCount = self.vb.arcaneOrbCount + 1
		specWarnArcaneOrbs:Show(self.vb.arcaneOrbCount)
		specWarnArcaneOrbs:Play("watchorb")
		timerArcaneOrbsCD:Start(self.vb.arcaneOrbCount == 1 and 65 or 75, self.vb.arcaneOrbCount+1)
	--"<500.67 14:43:34> [CHAT_MSG_RAID_BOSS_EMOTE] |TInterface\\Icons\\SPELL_SHADOW_SHADESOFDARKNESS.BLP:20|tHer ritual complete, Queen Azshara gains the power of the Void!#Queen Azshara#####0#0##0#209#nil#0#false#false#false#false",
	elseif msg:find("SPELL_SHADOW_SHADESOFDARKNESS.BLP") then--Stage 4
		if self.vb.phase < 4 then--Won't run unless earlier stage 4 trigger failed
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

			--void touch and overload are used immediately, so no timers start here
			timerNetherPortalCD:Start(11.7)
			timerPiercingGazeCD:Start(31.7)
			if self:IsMythic() then--Just copied from heroic for now
				timerGreaterReversalCD:Start(36.6, 1)
				timerBeckonCD:Start(56.7, 1)--START
			elseif self:IsHeroic() then
				timerGreaterReversalCD:Start(36.6, 1)
				timerBeckonCD:Start(56.7, 1)--START
			else
				timerReversalofFortuneCD:Start(39.7, 1)
				timerBeckonCD:Start(61.7, 1)--START
			end
		end
		DBM:Debug("Current Stage 4 trigger. If azshara did NOT cast ANYTHING between last debug message and this one, faster trigger is reliable. If she did cast even a single spell between that event and this one, then this is true Stage 4 trigger and no changes are needed")
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
			if cid == 153064 then--overzealous-hulk spawn.
				self.vb.bigAddCount = self.vb.bigAddCount + 1
				specWarnHulk:Show(self.vb.bigAddCount)
				specWarnHulk:Play("bigmob")
				local timer = self:IsHard() and phase1HeroicAddTimers[self.vb.bigAddCount+1] or phase1NormalAddTimers[self.vb.bigAddCount+1]
				if timer then
					timerHulkSpawnCD:Start(timer, self.vb.bigAddCount+1)
				end
			elseif cid == 153090 or cid == 153091 then--Phase 3 Sirens becoming active
				--timerCrystallineShieldCD:Start(17.4)--17-20?
				--timerStaticShockCD:Start(97.9, GUID)
				if self.vb.phase < 3 then
					self.vb.phase = 3
					warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(3))
					warnPhase:Play("pthree")
				end
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
	warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(2.5))
	warnPhase:Play("phasechange")
	timerReversalofFortuneCD:Stop()
	timerBeckonCD:Stop()
	timerArcaneBurstCD:Stop()
	timerArcaneDetonationCD:Stop()
	timerDivideandConquerCD:Stop()
	timerAzsharasIndomitableCD:Stop()

	--Despite everything journal says, there really isn't a second intermission, P3 timers start here most accurately for azshara.
	--But I still delay P3 warning until siren's are attackable,
	if self:IsHard() then
		timerBeckonCD:Start(40.1, 1)
		timerGreaterReversalCD:Start(74.8, 1)
		timerArcaneDetonationCD:Start(75, 1)
		timerArcaneBurstCD:Start(87, 1)
	else
		timerBeckonCD:Start(64.6, 1)
		timerReversalofFortuneCD:Start(77.7, 1)
		timerArcaneDetonationCD:Start(94.7, 1)
		timerArcaneBurstCD:Start(116.7, 1)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 298496 then--Rush Ancient Ward (phase 1 overzealous-hulk)
		--Not reliable do to being cast before INSTANCE_ENCOUNTER_ENGAGE_UNIT and Hulk actually gaining a boss unit ID
--	elseif spellId == 299886 then--Rush Ward of Power (phase 2 adds)
		--Maybe usuable with antispam and syncing. No Boss unit IDs, only nameplate really
	elseif spellId == 297371 then--Reversal of Fortune
		self.vb.reversalCount = self.vb.reversalCount + 1
		specWarnReversalofFortune:Show()
		specWarnReversalofFortune:Play("telesoon")
		timerReversalofFortuneCD:Start(self.vb.phase == 2 and 80 or 70, self.vb.reversalCount+1)
	elseif spellId == 297372 then
		self.vb.reversalCount = self.vb.reversalCount + 1
		specWarnGreaterReversal:Show()
		specWarnGreaterReversal:Play("telesoon")
		timerGreaterReversalCD:Start(70, self.vb.reversalCount+1)
	elseif spellId == 303629 then--Arcane Burst
		self.vb.arcaneBurstIcon = 1
		--60, 70.0, 55.3 (P2)
		self.vb.arcaneBurstCount = self.vb.arcaneBurstCount + 1
		if self.vb.arcaneBurstCount % 2 == 0 then
			timerArcaneBurstCD:Start(55, self.vb.arcaneBurstCount+1)
		else
			timerArcaneBurstCD:Start(60, self.vb.arcaneBurstCount+1)--See if still 70 on heroic
		end
	elseif spellId == 302034 then--Adjure
		--"<338.85 14:18:47> [UNIT_SPELLCAST_SUCCEEDED] Queen Azshara(Murdocc) -Adjure- [[boss1:Cast-3-3883-2164-252-302034-001924DA87:302034]]", -- [6299]
		--"<343.15 14:18:51> [CHAT_MSG_MONSTER_YELL] Coax the power from these ancient wards! Rattle the chains that bind him!#Queen Azshara###Omegall##0#0##0#2192#nil#0#false#false#false#false", -- [6362]
		self:Schedule(4.3, startIntermissionTwo, self)--Needed, because timers don't cancel until yell
		timerQueensDecreeCD:Start(13.9)--SUCCESS (technically debuffs, is no start or success event here)
	elseif spellId == 303982 then--Nether Portal
		warnNetherPortal:Show()
		timerNetherPortalCD:Start()
	elseif spellId == 302860 then --Queen Azshara (possible faster P4 trigger, but may also break timers if it's too early)
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

		timerVoidTouchedCD:Start(12.9)
		timerOverloadCD:Start(14, 1)
		timerNetherPortalCD:Start(23.9)
		timerPiercingGazeCD:Start(43.9)
		if self:IsMythic() then--Just copied from heroic for now
			timerGreaterReversalCD:Start(48.8, 1)
			timerBeckonCD:Start(68.9, 1)--START
		elseif self:IsHeroic() then
			timerGreaterReversalCD:Start(48.8, 1)
			timerBeckonCD:Start(68.9, 1)--START
		else
			timerReversalofFortuneCD:Start(51.9, 1)
			timerBeckonCD:Start(73.9, 1)--START
		end
		DBM:Debug("Possible Earlier Stage 4 Trigger fired, see if Azshara casts anything between this cast and next debug message")
	end
end

--[[
function mod:UPDATE_UI_WIDGET(table)
	local id = table.widgetID
	if id ~= 1901 and id ~= 1904 and id ~= 2043 and id ~= 2043 then return end
	local widgetInfo = C_UIWidgetManager.GetIconAndTextWidgetVisualizationInfo(id)
	local text = widgetInfo.text
	if not text then return end
end
--]]
