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
	"SPELL_CAST_START 297937 297934 298121 297972 298531 300478 299250 299178 300519 300490 297372 300807",
	"SPELL_CAST_SUCCESS 302208 298014 301078 299094 300492 300743 303980 302141 300334 303797 303799",
	"SPELL_AURA_APPLIED 302999 298569 297912 298014 298018 301078 300428 303825 303657 300492 300620 299094 303797 303799 300743 300866 300877 299249 299251 299254 299255 299252 299253 300502 302141 297937",
	"SPELL_AURA_APPLIED_DOSE 302999 298569 298014 300743",
	"SPELL_AURA_REMOVED 302999 298569 297912 301078 300428 303657 300502 297937 299249 299251 299254 299255 299252 299253",
	"SPELL_PERIODIC_DAMAGE 297898 303981",
	"SPELL_PERIODIC_MISSED 297898 303981",
	"UNIT_DIED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"
--	"UPDATE_UI_WIDGET"
)

--TODO, do something different with pressure surge later, announce remaining maybe
--TODO, figure out stacks for drained soul and arcane debuffs to know what's too high
--TODO, add drain ancient ward when right spell ID (of 7) is known, one for phase 1, one for phase 2 and one for phase 3?
--TODO, also fix phase 2 version of drain ward (https://ptr.wowhead.com/spell=303457/titanic-machinations)?
--TODO, finetune arcane burst timing based on size of room and movement penalties and fix spellID for start/success events
--TODO, detect various adds joining fight and timer/warn them in stage 2+
--TODO, phase 2.5 intermission detection (Intermission Two: Adoration)
--TODO, beckon might use https://ptr.wowhead.com/spell=303802/army-of-azshara instead
--TODO, check if multiple targets for static shock
--TODO, figure out siren creature IDs so they can be auto marked and warning for shield can include which marked mob got it
--TODO, stop shield timer when all adds dead.
--TODO, fine tune beckon spell Ids, when specific one that has jealousy is known for certain, add nearby warning
--TODO, figure out cast time for https://ptr.wowhead.com/spell=301518/massive-energy-spike (ie between overload cast start, and when all remaining energy is released)
--TODO, announce short ciruit?
--TODO, capture UPDATE_UI_WIDGET better with modified transcriptor to get the widget values I need
--[[
(ability.id = 297937 or ability.id = 297934 or ability.id = 298121 or ability.id = 297972 or ability.id = 298531 or ability.id = 300478 or ability.id = 299250 or ability.id = 299178 or ability.id = 300519 or ability.id = 303629 or ability.id = 300490 or ability.id = 297372 or ability.id = 300807) and type = "begincast"
 or (ability.id = 302208 or ability.id = 298014 or ability.id = 301078 or ability.id = 299094 or ability.id = 303657 or ability.id = 303629 or ability.id = 300492 or ability.id = 300743 or ability.id = 303980 or ability.id = 302141 or ability.id = 300334 or ability.id = 303797 or ability.id = 303799) and type = "cast"
 or type = "death" and (target.id = 153059 or target.id = 153060)
--]]
--Ancient Wards
local warnPhase							= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)
local warnPressureSurge					= mod:NewSpellAnnounce(302208, 2)
--Stage One: Cursed Lovers
local warnPainfulMemoriesOver			= mod:NewMoveToAnnounce(297937, 1)
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
local warnArcaneBurst					= mod:NewTargetAnnounce(303657, 3)
--Stage Three: Song of the Tides
local warnEnergizeWardofPower			= mod:NewSpellAnnounce(300490, 3)
local warnStaticShock					= mod:NewTargetAnnounce(300492, 2)
local warnCrystallineShield				= mod:NewTargetNoFilterAnnounce(300620, 2)
--Stage Four: My Palace Is a Prison
local warnVoidTouched					= mod:NewStackAnnounce(300743, 2, nil, "Tank")
local warnNetherPortal					= mod:NewSpellAnnounce(303980, 2)
local warnEssenceofAzeroth				= mod:NewTargetAnnounce(300866, 2)
local warnSystemShock					= mod:NewTargetAnnounce(300877, 3)

--Ancient Wards
local specWarnDrainedSoul				= mod:NewSpecialWarningStack(298569, nil, 6, nil, nil, 1, 6)
--Stage One: Cursed Lovers
local specWarnPainfulMemories			= mod:NewSpecialWarningMoveTo(297937, "Tank", nil, nil, 3, 2)
local specWarnLonging					= mod:NewSpecialWarningMoveTo(297934, false, nil, 2, 3, 2)
local specWarnGTFO						= mod:NewSpecialWarningGTFO(297898, nil, nil, nil, 1, 8)
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
local specWarnBeckon					= mod:NewSpecialWarningYou(299094, nil, nil, nil, 1, 8)
local yellBeckon						= mod:NewYell(299094)
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
--local specWarnArcaneBurstTaunt		= mod:NewSpecialWarningTaunt(303657, nil, nil, nil, 1, 2)
--Stage Three: Song of the Tides
local specWarnStaticShock				= mod:NewSpecialWarningMoveAway(300492, nil, nil, nil, 1, 8)
local yellStaticShock					= mod:NewYell(300492)
--Stage Four: My Palace Is a Prison
local specWarnInversion					= mod:NewSpecialWarningSpell(297372, nil, nil, nil, 2, 5)
local specWarnVoidtouched				= mod:NewSpecialWarningStack(300743, nil, 4, nil, nil, 1, 6)
local specWarnVoidtouchedTaunt			= mod:NewSpecialWarningTaunt(300743, nil, nil, nil, 1, 2)
local specWarnOverload					= mod:NewSpecialWarningCount(300807, nil, nil, nil, 2, 2)
local specWarnEssenceofAZeroth			= mod:NewSpecialWarningYou(300866, nil, nil, nil, 1, 2)
local specWarnSystemShock				= mod:NewSpecialWarningDefensive(300877, nil, nil, nil, 1, 2)

--Stage One: Cursed Lovers
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20250))
local timerPainfulMemoriesCD			= mod:NewNextTimer(60, 297937, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerLongingCD					= mod:NewNextTimer(60, 297934, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
----Aethanel
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20261))
local timerLightningOrbsCD				= mod:NewCDTimer(27.3, 298121, nil, nil, nil, 3)
local timerChainLightningCD				= mod:NewCDTimer(7.3, 297972, nil, false, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)--7-24, all over place, so off by default
local timerColdBlastCD					= mod:NewCDTimer(9.4, 298014, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
----Cyranus
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20266))
local timerChargedSpearCD				= mod:NewCDTimer(32.3, 301078, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)--32-40
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
--local timerTitanicMachinationsCD		= mod:NewAITimer(58.2, 303457, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerArcaneDetonationCD			= mod:NewCDTimer(80, 300519, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
local timerReversalofFortuneCD			= mod:NewCDTimer(80, 297371, nil, nil, nil, 5, nil, DBM_CORE_IMPORTANT_ICON)
local timerArcaneBurstCD				= mod:NewCDTimer(58.2, 303657, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON)
--Stage Three: Song of the Tides
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20340))
--local timerEnergizeWardofPowerCD		= mod:NewAITimer(58.2, 303657, nil, nil, nil, 5)
local timerStaticShockCD				= mod:NewAITimer(58.2, 300492, nil, nil, nil, 3)
local timerCrystallineShieldCD			= mod:NewAITimer(58.2, 300620, nil, nil, nil, 3, nil, DBM_CORE_DAMAGE_ICON..DBM_CORE_IMPORTANT_ICON)
--Stage Four: My Palace Is a Prison
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20361))
local timerInversionCD					= mod:NewAITimer(58.2, 297372, nil, nil, nil, 5, nil, DBM_CORE_IMPORTANT_ICON..DBM_CORE_HEROIC_ICON)
local timerVoidTouchedCD				= mod:NewAITimer(30.4, 300743, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)
local timerNetherPortalCD				= mod:NewAITimer(30.4, 303980, nil, nil, nil, 3)
local timerOverloadCD					= mod:NewAITimer(30.4, 300807, nil, nil, nil, 5, nil, DBM_CORE_IMPORTANT_ICON)

--local berserkTimer					= mod:NewBerserkTimer(600)

mod:AddNamePlateOption("NPAuraOnTorment", 297912)
mod:AddNamePlateOption("NPAuraOnInfuriated", 300428)
--mod:AddRangeFrameOption(6, 264382)
mod:AddInfoFrameOption(302999, true)
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
mod.vb.hulkCount = 0
mod.vb.painfulMemoriesActive = false
local arcaneVulnerabilityStacks = {}
local playerSoulDrained = false
local shieldName = DBM:GetSpellInfo(300620)
local seenAdds = {}
local castsPerGUID = {}
local playerDecreeCount = 0
local playerDecreeYell = 0--100s 2-Stack/1-Solo, 10s 2-Moving/1-Stay, 1s 2-Soak/1-NoSoak
local phase1AddTimers = {42.8, 59.6, 89.1, 44.8, 39.4}--Consistent pull to pull, only timer sequence that's actually a sequence. Azshara's shit is all just spell queue issues

local updateInfoFrame
do
	local floor, tsort = math.floor, table.sort
	local lines = {}
	local tempLines = {}
	local tempLinesSorted = {}
	local sortedLines = {}
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
		--TODO
		--Player Personal Checks
		if playerSoulDrained then
			local spellName2, _, currentStack2, _, _, expireTime2 = DBM:UnitDebuff("player", 298569)
			if spellName2 and currentStack2 and expireTime2 then--Personal Tailwinds count
				local remaining2 = expireTime2-GetTime()
				addLine(spellName2.." ("..currentStack2..")", math.floor(remaining2))
			end
		end
		addLine(" ", " ")--Insert a blank entry to split the two debuffs
		--Arcane Vulnerability Stacks (UGLY code)
		for i, v in pairs(arcaneVulnerabilityStacks) do
			tempLines[i] = v
			tempLinesSorted[#tempLinesSorted + 1] = tempLines
		end
		--Sort debuffs by highest then inject into regular table
		tsort(tempLinesSorted, sortFuncDesc)
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
	self.vb.maxDecree = 1
	self.vb.beckonCast = 0
	self.vb.arcaneBurstCount = 0
	self.vb.drainWardCount = 0
	self.vb.hulkCount = 0
	self.vb.painfulMemoriesActive = false
	playerDecreeYell = 0
	playerSoulDrained = false
	table.wipe(arcaneVulnerabilityStacks)
	table.wipe(seenAdds)
	table.wipe(castsPerGUID)
	timerPainfulMemoriesCD:Start(19.7)
	--Aethanel
	timerLightningOrbsCD:Start(24.4-delay)
	timerChainLightningCD:Start(15.3-delay)
	timerColdBlastCD:Start(14.9-delay)--SUCCESS
	--Cyranus
	timerChargedSpearCD:Start(27.5-delay)
	--Azshara
	timerDrainAncientWardCD:Start(37-delay, 1)
	timerHulkSpawnCD:Start(42-delay, 1)
	timerBeckonCD:Start(55-delay, 1)
	timerArcaneOrbsCD:Start(69.8-delay, 1)
	if self:IsMythic() then
		self.vb.maxDecree = 3
		timerDivideandConquerCD:Start(1-delay)
	elseif self:IsHeroic() then
		self.vb.maxDecree = 2
	else
		self.vb.maxDecree = 1
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM_CORE_INFOFRAME_POWER)
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
	DBM:AddMsg("This mod is very incomplete, do to incomplete testing on PTR, Only Stage 1, 1.5, and 2 have support. 2.5, 3, 4 are WIP")
end

function mod:OnTimerRecovery()
	if DBM:UnitDebuff("player", 298569) then
		playerSoulDrained = true
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 297937 then--Painful Memories
		specWarnPainfulMemories:Show(DBM_CORE_BREAK_LOS)
		specWarnPainfulMemories:Play("moveboss")
		timerLongingCD:Start()
	elseif spellId == 297934 then--Longing
		specWarnLonging:Show(DBM_CORE_RESTORE_LOS)
		specWarnLonging:Play("moveboss")
		timerPainfulMemoriesCD:Start()
	elseif spellId == 298121 then
		warnLightningOrbs:Show()
		timerLightningOrbsCD:Start()
	elseif spellId == 297972 then
		timerChainLightningCD:Start(nil, args.sourceGUID)
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
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
	elseif spellId == 299250 then
		playerDecreeCount = 0
		warnQueensDecree:Show()
		--timerQueensDecreeCD:Start()
	elseif spellId == 299178 and self.vb.phase < 2 then
		self.vb.phase = 2
		self.vb.arcaneBurstCount = 0
		self.vb.arcaneOrbCount = 0
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(2))
		warnPhase:Play("ptwo")
		timerQueensDecreeCD:Stop()
		timerArcaneOrbsCD:Stop()
		timerBeckonCD:Start(29, 1)--SUCCESS
		timerArcaneBurstCD:Start(60, 1)--SUCCESS
		timerArcaneDetonationCD:Start(75)--START
		--timerTitanicMachinationsCD:Start(2)
		if self:IsHard() then
			timerReversalofFortuneCD:Start(68.1)
			if self:IsMythic() then
				timerDivideandConquerCD:Start(2)
			end
		end
	elseif spellId == 300519 then
		specWarnArcaneDetonation:Show(DBM_CORE_BREAK_LOS)
		specWarnArcaneDetonation:Play("findshelter")
		timerArcaneDetonationCD:Start()
	elseif spellId == 300490 then
		warnEnergizeWardofPower:Show()
	elseif spellId == 297372 then
		specWarnInversion:Show()
		specWarnInversion:Play("telesoon")
		timerInversionCD:Start()
	elseif spellId == 300807 then
		specWarnOverload:Show()
		specWarnOverload:Play("specialsoon")
		timerOverloadCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 302208 then
		warnPressureSurge:Show()
	elseif spellId == 298014 then
		timerColdBlastCD:Start()
	elseif spellId == 301078 then
		timerChargedSpearCD:Start()
	elseif spellId == 299094 or spellId == 302141 or spellId == 303797 or spellId == 303799 then--299094 Phase 1, 302141 phase 2, 303797 phase 3, 303799 unknown (probably phase 4)
		self.vb.beckonCast = self.vb.beckonCast + 1
		if self.vb.phase == 1 then
			--Phase 1 pattern (imprecise as hell, it's spell queuing not true alternating, but there is enough consistency to do this somewhat)
			if self.vb.beckonCast % 2 == 0 then
				--"Beckon-299094-npc:152910 = pull:59.1, 73.2, 51.2", -- [5]
				timerBeckonCD:Start(50, self.vb.beckonCast+1)--Most of time 55, but can be lower
			else
				--"Beckon-299094-npc:152910 = pull:56.1, 71.3, 50.6, 63.7"
				timerBeckonCD:Start(self.vb.beckonCast == 1 and 70 or 60, self.vb.beckonCast+1)-- 2nd cast is always above 70, but 4th cast is more around 60, rest unknown so 60 assumed
			end
		else--Phase 2 (don't know about rest)
			--Phase 2 pattern (imprecise as hell, it's spell queuing not true alternating, but there is enough consistency to do this somewhat)
			if self.vb.beckonCast % 2 == 0 then
				timerBeckonCD:Start(55, self.vb.beckonCast+1)
			else
				timerBeckonCD:Start(85, self.vb.beckonCast+1)
			end
		end
	elseif spellId == 300492 then
		timerStaticShockCD:Start(nil, args.sourceGUID)
	elseif spellId == 300620 then
		timerCrystallineShieldCD:Start()
	elseif spellId == 300743 then
		timerVoidTouchedCD:Start()
	elseif spellId == 303980 then
		warnNetherPortal:Show()
		timerNetherPortalCD:Start()
	elseif spellId == 300334 then
		self.vb.drainWardCount = self.vb.drainWardCount + 1
		warnDrainAncientWard:Show(self.vb.drainWardCount)
		if self.vb.drainWardCount % 2 == 0 then
			timerDrainAncientWardCD:Start(49.9, self.vb.drainWardCount+1)
		else
			timerDrainAncientWardCD:Start(60, self.vb.drainWardCount+1)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 302999 then
		local amount = args.amount or 1
		arcaneVulnerabilityStacks[args.destName] = amount
		if args:IsPlayer() and (amount >= 12 and amount % 3 == 0) then--12, 15, 18, 21, etc
			specWarnArcaneVuln:Show(amount)
			specWarnArcaneVuln:Play("stackhigh")
		end
	elseif spellId == 298569 then
		local amount = args.amount or 1
		if not playerSoulDrained then
			playerSoulDrained = true
		end
		if args:IsPlayer() and amount >= 6 then--++
			specWarnDrainedSoul:Show(amount)
			specWarnDrainedSoul:Play("stackhigh")
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
			if self.vb.phase == 1 then
				specWarnChargedSpear:Show(DBM_CORE_ROOM_EDGE)
				specWarnChargedSpear:Play("runtoedge")
			else
				specWarnChargedSpear:Show(shieldName)
				specWarnChargedSpear:Play("behindmob")
			end
			yellChargedSpear:Yell()
			yellChargedSpearFades:Countdown(spellId)
		else
			warnChargedSpear:Show(args.destName)
		end
	elseif spellId == 299094 or spellId == 302141 or spellId == 303797 or spellId == 303799 then--303797 and 303799 unknown
		warnBeckon:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnBeckon:Show()
			specWarnBeckon:Play("targetyou")
			yellBeckon:Yell()
		elseif spellId ~= 299094 and self:CheckNearby(8, args.destName) and not DBM:UnitDebuff("player", spellId) then--Warn nearby, because it's jealousy version
			specWarnBeckonNear:Show(args.destName)
			specWarnBeckonNear:Play("runaway")
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
			local text = ""
			if spellId == 299249 then--Soak Orbs
				specWarnQueensDecree:ScheduleVoiceOverLap(0+playerDecreeCount, "helpsoak")
				text = text..", "..L.SoakOrb
				playerDecreeYell = playerDecreeYell + 2--100s 2-Stack/1-Solo, 10s 2-Moving/1-Stay, 1s 2-Soak/1-NoSoak
			elseif spellId == 299251 then--Dodge Orbs
				specWarnQueensDecree:ScheduleVoiceOverLap(0+playerDecreeCount, "watchorb")
				text = text..", "..L.AvoidOrb
				playerDecreeYell = playerDecreeYell + 1--100s 2-Stack/1-Solo, 10s 2-Moving/1-Stay, 1s 2-Soak/1-NoSoak
			elseif spellId == 299254 then--Group Up
				specWarnQueensDecree:ScheduleVoiceOverLap(0+playerDecreeCount, "gather")
				text = text..", "..L.GroupUp
				playerDecreeYell = playerDecreeYell + 200--100s 2-Stack/1-Solo, 10s 2-Moving/1-Stay, 1s 2-Soak/1-NoSoak
			elseif spellId == 299255 then--Don't Group Up
				specWarnQueensDecree:ScheduleVoiceOverLap(0+playerDecreeCount, "scatter")
				text = text..", "..L.Spread
				playerDecreeYell = playerDecreeYell + 100--100s 2-Stack/1-Solo, 10s 2-Moving/1-Stay, 1s 2-Soak/1-NoSoak
			elseif spellId == 299252 then--Keep Moving
				specWarnQueensDecree:ScheduleVoiceOverLap(0+playerDecreeCount, "keepmove")
				text = text..", "..L.Move
				playerDecreeYell = playerDecreeYell + 20--100s 2-Stack/1-Solo, 10s 2-Moving/1-Stay, 1s 2-Soak/1-NoSoak
			elseif spellId == 299253 then--Stop Moving
				specWarnQueensDecree:ScheduleVoiceOverLap(0+playerDecreeCount, "stopmove")
				text = text..", "..L.DontMove
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
--	elseif spellId == 300502 then--Arcane Mastery

	elseif spellId == 297937 then
		self.vb.painfulMemoriesActive = true
		warnPainfulMemoriesOver:Show(DBM_CORE_RESTORE_LOS)
		warnPainfulMemoriesOver:Play("moveboss")
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 302999 then
		arcaneVulnerabilityStacks[args.destName] = nil
	elseif spellId == 298569 then
		playerSoulDrained = false
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

	elseif spellId == 297937 then
		self.vb.painfulMemoriesActive = false
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
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if (spellId == 303981 or spellId == 297898) and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
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
		timerQueensDecreeCD:Start(4)
		timerNextPhase:Start(27.3)--To Ward of Power cast start
	end
	function mod:UNIT_DIED(args)
		local cid = self:GetCIDFromGUID(args.destGUID)
		if cid == 153059 then--Aethanel
			timerLightningOrbsCD:Stop()
			timerChainLightningCD:Stop()
			timerColdBlastCD:Stop()
			self.vb.stageOneBossesLeft = self.vb.stageOneBossesLeft - 1
			if self.vb.stageOneBossesLeft == 0 then
				startIntermissionOne(self)
			end
		elseif cid == 153060 then--Cryanus
			timerChargedSpearCD:Stop()
			self.vb.stageOneBossesLeft = self.vb.stageOneBossesLeft - 1
			if self.vb.stageOneBossesLeft == 0 then
				startIntermissionOne(self)
			end
		elseif cid == 155643 or cid == 153064 then--overzealous-hulk
			castsPerGUID[args.destGUID] = nil
			--timerGroundPoundCD:Stop(args.destGUID)
--		elseif cid == 154240 then--azsharas-devoted

--		elseif cid == 154565 then--Loyal Myrmidon

--		elseif cid == "unknowntidemistresssirenid" then
--			timerStaticShockCD:Stop(args.destGUID)
--			timerChainLightningCD:Stop(args.destGUID)
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
				self.vb.hulkCount = self.vb.hulkCount + 1
				local timer = phase1AddTimers[self.vb.hulkCount+1]
				if timer then
					timerHulkSpawnCD:Start(timer, self.vb.hulkCount+1)
				end
			end
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 298496 then--Rush Ancient Ward (phase 1 overzealous-hulk)
		--Not reliable do to being cast before INSTANCE_ENCOUNTER_ENGAGE_UNIT and Hulk actually gaining a boss unit ID
	elseif spellId == 299886 then--Rush Ward of Power (phase 2 adds)
		--Maybe usuable with antispam and syncing. No Boss unit IDs, only nameplate really
	elseif spellId == 297371 then--Reversal of Fortune
		specWarnReversalofFortune:Show()
		specWarnReversalofFortune:Play("telesoon")
		timerReversalofFortuneCD:Start()
	elseif spellId == 303629 then--Arcane Burst
		self.vb.arcaneBurstIcon = 1
		--60, 70.0, 55.3 (P2, unknown beyond that)
		self.vb.arcaneBurstCount = self.vb.arcaneBurstCount + 1
		if self.vb.arcaneBurstCount % 2 == 0 then
			timerArcaneBurstCD:Start(55, self.vb.arcaneBurstCount+1)
		else
			timerArcaneBurstCD:Start(70, self.vb.arcaneBurstCount+1)
		end
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
