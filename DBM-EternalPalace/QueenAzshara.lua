local mod	= DBM:NewMod(2361, "DBM-EternalPalace", nil, 1179)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(137119)
mod:SetEncounterID(2299)
mod:SetZone()
mod:SetUsedIcons(3, 2, 1)
--mod:SetHotfixNoticeRev(16950)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 297937 297934 298121 297972 298531 298787 300478 299250 299178 300519 297371 303629 300490 297372 300807",
	"SPELL_CAST_SUCCESS 302208 298014 298756 301078 299094 303657 303629 300492 300743 303980",
	"SPELL_AURA_APPLIED 302999 298569 297912 298014 298018 301078 300428 303825 303657 300492 300620 299094 303797 303799 300743 300866 300877 299249 299251 299254 299255 299252 299253",
	"SPELL_AURA_APPLIED_DOSE 302999 298569 298014 300743",
	"SPELL_AURA_REMOVED 302999 298569 297912 301078 300428 303657",
	"SPELL_PERIODIC_DAMAGE 297898 303981",
	"SPELL_PERIODIC_MISSED 297898 303981",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, do something different iwth pressure surge later, announce remaining maybe
--TODO, figure out stacks for drained soul and arcane debuffs to know what's too high
--TODO, fix cold blast if wrong
--TODO, add drain ancient ward when right spell ID (of 7) is known, one for phase 1, one for phase 2 and one for phase 3
--TODO, verify decree code
--TODO, also fix phase 2 version of drain ward (https://ptr.wowhead.com/spell=303457/titanic-machinations)
--TODO, finetune arcane burst timing based on size of room and movement penalties and fix spellID for start/success events
--TODO, detect various adds joining fight and timer/warn them
--TODO, phase 2.5 intermission detection (Intermission Two: Adoration)
--TODO, fix phase 1 charged spear (isn't a shield to run it to yet, run LOS instead? run to mob casting it?)
--TODO, beckon might use https://ptr.wowhead.com/spell=303802/army-of-azshara instead
--TODO, check if multiple targets for static shock
--TODO, figure out siren creature IDs so they can be auto marked and warning for shield can include which marked mob got it
--TODO, stop shield timer when all adds dead.
--TODO, fine tune beckon spell Ids, when specific one that has jealousy is known for certain, add nearby warning
--TODO, figure out cast time for https://ptr.wowhead.com/spell=301518/massive-energy-spike (ie between overload cast start, and when all remaining energy is released)
--TODO, announce short ciruit?
--Ancient Wards
local warnPhase							= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)
local warnPressureSurge					= mod:NewSpellAnnounce(302208, 2)
--Stage One: Cursed Lovers
----Aethanel
local warnLightningOrbs					= mod:NewSpellAnnounce(298121, 2)
local warnFrozen						= mod:NewTargetNoFilterAnnounce(298018, 4)
local warnColdBlast						= mod:NewStackAnnounce(298014, 2, nil, "Tank")
----Cyranus
local warnChargedSpear					= mod:NewTargetNoFilterAnnounce(301078, 4)
----Overzealous Hulk
local warnGroundPound					= mod:NewCountAnnounce(298531, 2)
----Azshara
--local warnDrainAncientWard				= mod:NewSpellAnnounce(300334, 2)
local warnBeckon						= mod:NewTargetNoFilterAnnounce(299094, 3)
local warnCrushingDepths				= mod:NewTargetNoFilterAnnounce(303825, 4)
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
local specWarnLonging					= mod:NewSpecialWarningMoveTo(297934, "Tank", nil, nil, 3, 2)
local specWarnGTFO						= mod:NewSpecialWarningGTFO(297898, nil, nil, nil, 1, 8)
----Aethanel
local specWarnLightningBolt				= mod:NewSpecialWarningInterrupt(297972, "HasInterrupt", nil, nil, 1, 2)
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
--mod:AddTimerLine(BOSS)
--local timerPainfulMemoriesCD			= mod:NewAITimer(58.2, 297937, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
--local timerLongingCD					= mod:NewAITimer(58.2, 297934, nil, "Tank, nil, 5, nil, DBM_CORE_TANK_ICON)
----Aethanel
local timerLightningOrbsCD				= mod:NewAITimer(30.4, 298121, nil, nil, nil, 3)
local timerLightningBoltCD				= mod:NewAITimer(30.4, 297972, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
local timerColdBlastCD					= mod:NewAITimer(58.2, 298014, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
----Cyranus
local timerSerratedEdgeCD				= mod:NewAITimer(58.2, 298756, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerChargedSpearCD				= mod:NewAITimer(30.4, 301078, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
----Overzealous Hulk
local timerGroundPoundCD				= mod:NewAITimer(30.4, 298531, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)
----Azshara
local timerArcaneOrbsCD					= mod:NewAITimer(30.4, 298787, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
--local timerDrainAncientWardCD			= mod:NewAITimer(30.4, 300334, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON..DBM_CORE_IMPORTANT_ICON)
local timerBeckonCD						= mod:NewAITimer(30.4, 299094, nil, nil, nil, 3)
local timerDivideandConquerCD			= mod:NewAITimer(30.4, 300478, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
--Intermission One: Queen's Decree
local timerQueensDecreeCD				= mod:NewAITimer(30.4, 299250, nil, nil, nil, 3, nil, DBM_CORE_IMPORTANT_ICON)
--Stage Two: Hearts Unleashed
--local timerTitanicMachinationsCD		= mod:NewAITimer(58.2, 303457, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerArcaneDetonationCD			= mod:NewAITimer(58.2, 300519, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
local timerReversalofFortuneCD			= mod:NewAITimer(58.2, 297371, nil, nil, nil, 5, nil, DBM_CORE_IMPORTANT_ICON)
local timerArcaneBurstCD				= mod:NewAITimer(58.2, 303657, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON)
--Stage Three: Song of the Tides
--local timerEnergizeWardofPowerCD		= mod:NewAITimer(58.2, 303657, nil, nil, nil, 5)
local timerStaticShockCD				= mod:NewAITimer(58.2, 300492, nil, nil, nil, 3)
local timerCrystallineShieldCD			= mod:NewAITimer(58.2, 300620, nil, nil, nil, 3, nil, DBM_CORE_DAMAGE_ICON..DBM_CORE_IMPORTANT_ICON)
--Stage Four: My Palace Is a Prison
local timerInversionCD					= mod:NewAITimer(58.2, 297372, nil, nil, nil, 5, nil, DBM_CORE_IMPORTANT_ICON..DBM_CORE_HEROIC_ICON)
local timerVoidTouchedCD				= mod:NewAITimer(30.4, 300743, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)
local timerNetherPortalCD				= mod:NewAITimer(30.4, 303980, nil, nil, nil, 3)
local timerOverloadCD					= mod:NewAITimer(30.4, 300807, nil, nil, nil, 5, nil, DBM_CORE_IMPORTANT_ICON)

--local berserkTimer					= mod:NewBerserkTimer(600)

--local countdownCudgelofGore			= mod:NewCountdown(58, 271296)
--local countdownSerratedEdge			= mod:NewCountdown("Alt60", 298756, "Tank", 3)

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
local arcaneVulnerabilityStacks = {}
local playerSoulDrained = false
local shieldName = DBM:GetSpellInfo(300620)
local castsPerGUID = {}
local playerDecreeCount = 0

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
		--Boss Powers first
		for i = 1, 5 do
			local uId = "boss"..i
			--Primary Power
			local currentPower, maxPower = UnitPower(uId), UnitPowerMax(uId)
			if maxPower and maxPower ~= 0 then
				local adjustedPower = currentPower / maxPower * 100
				if adjustedPower >= 1 and adjustedPower ~= 100 then--Filter 100 power, to basically eliminate cced Adds
					addLine(UnitName(uId), currentPower)
				end
			end
		end
		--Player Personal Checks
		if playerSoulDrained then
			local spellName2, _, currentStack2, _, _, expireTime2 = DBM:UnitDebuff("player", 298569)
			if spellName2 and currentStack2 and expireTime2 then--Personal Tailwinds count
				local remaining2 = expireTime2-GetTime()
				addLine(spellName2.." ("..currentStack2..")", math.floor(remaining2))
			end
		end
		if mod:IsMythic() then
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
		end
		return lines, sortedLines
	end
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.stageOneBossesLeft = 2
	self.vb.arcaneOrbCount = 0
	self.vb.maxDecree = 1
	playerSoulDrained = false
	table.wipe(arcaneVulnerabilityStacks)
	table.wipe(castsPerGUID)
	--Aethanel
	timerLightningOrbsCD:Start(1-delay)
	timerLightningBoltCD:Start(1-delay)
	timerColdBlastCD:Start(1-delay)
	--Cyranus
	timerSerratedEdgeCD:Start(1-delay)
	timerChargedSpearCD:Start(1-delay)
	--countdownSerratedEdge:Start()
	--Azshara
	timerArcaneOrbsCD:Start(1-delay)
	timerBeckonCD:Start(1-delay)
	--timerDrainAncientWardCD:Start(1-delay)
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
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.NPAuraOnTorment or self.Options.NPAuraOnInfuriated then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
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
		--timerLongingCD:Start()
	elseif spellId == 297934 then--Longing
		specWarnLonging:Show(DBM_CORE_RESTORE_LOS)
		specWarnLonging:Play("moveboss")
		--timerPainfulMemoriesCD:Start()
	elseif spellId == 298121 then
		warnLightningOrbs:Show()
		timerLightningOrbsCD:Start()
	elseif spellId == 297972 then
		timerLightningBoltCD:Start(nil, args.sourceGUID)
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnLightningBolt:Show(args.sourceName)
			specWarnLightningBolt:Play("kickcast")
		end
	elseif spellId == 298531 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		warnGroundPound:Show(count)
		timerGroundPoundCD:Start(nil, args.sourceGUID)
	elseif spellId == 298787 then
		self.vb.arcaneOrbCount = self.vb.arcaneOrbCount + 1
		specWarnArcaneOrbs:Show()
		specWarnArcaneOrbs:Play("helpsoak")
		timerArcaneOrbsCD:Start()
	elseif spellId == 300478 then
		specWarnDivideandConquer:Show()
		timerDivideandConquerCD:Start()
	elseif spellId == 299250 then
		playerDecreeCount = 0
		warnQueensDecree:Show()
		timerQueensDecreeCD:Start()
	elseif spellId == 299178 and self.vb.phase < 2 then
		self.vb.phase = 2
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(2))
		warnPhase:Play("ptwo")
		timerQueensDecreeCD:Stop()
		timerArcaneOrbsCD:Stop()
		timerBeckonCD:Start(2)
		timerArcaneOrbsCD:Start(2)
		--timerTitanicMachinationsCD:Start(2)
		timerArcaneDetonationCD:Start(2)
		timerQueensDecreeCD:Start(2)
		timerArcaneBurstCD:Start(2)
		if self:IsHard() then
			timerReversalofFortuneCD:Start(2)
			if self:IsMythic() then
				timerDivideandConquerCD:Start(2)
			end
		end
	elseif spellId == 300519 then
		specWarnArcaneDetonation:Show(DBM_CORE_BREAK_LOS)
		specWarnArcaneDetonation:Play("findshelter")
		timerArcaneDetonationCD:Start()
	elseif spellId == 297371 then
		specWarnReversalofFortune:Show()
		specWarnReversalofFortune:Play("telesoon")
		timerReversalofFortuneCD:Start()
	elseif spellId == 303629 then
		self.vb.arcaneBurstIcon = 1
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
	elseif spellId == 298756 then
		timerSerratedEdgeCD:Start()
		--countdownSerratedEdge:Start()
	elseif spellId == 301078 then
		timerChargedSpearCD:Start()
	elseif spellId == 299094 then
		timerBeckonCD:Start()
	elseif spellId == 303629 or spellId == 303657 then
		timerArcaneBurstCD:Start()
	elseif spellId == 300492 then
		timerStaticShockCD:Start(nil, args.sourceGUID)
	elseif spellId == 300620 then
		timerCrystallineShieldCD:Start()
	elseif spellId == 300743 then
		timerVoidTouchedCD:Start()
	elseif spellId == 303980 then
		warnNetherPortal:Show()
		timerNetherPortalCD:Start()
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
		if amount >= 3 then
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
				specWarnChargedSpear:Show("Dunno Yet")
				specWarnChargedSpear:Play("targetyou")
			else
				specWarnChargedSpear:Show(shieldName)
				specWarnChargedSpear:Play("behindmob")
			end
			yellChargedSpear:Yell()
			yellChargedSpearFades:Countdown(5)
		else
			warnChargedSpear:Show(args.destName)
		end
	elseif spellId == 299094 or spellId == 303797 or spellId == 303799 then
		if args:IsPlayer() then
			specWarnBeckon:Show()
			specWarnBeckon:Play("targetyou")
			yellBeckon:Yell()
		elseif spellId ~= 299094 and self:CheckNearby(8, args.destName) then--Warn nearby, because it's jealousy version
			specWarnBeckonNear:Show(args.destName)
			specWarnBeckonNear:Play("runaway")
		else
			warnBeckon:Show(args.destName)
		end
	elseif spellId == 303825 then
		warnCrushingDepths:Show(args.destName)
	--Suffer (soak Orb), Obey (don't soak orb), Stand Together (group up), Stand Alone (don't group up), March (keep moving), Stay (stop moving)
	elseif spellId == 299249 or spellId == 299251 or spellId == 299254 or spellId == 299255 or spellId == 299252 or spellId == 299253 then
		--Temp, remove if cast event works
		if args:IsPlayer() then
			if self:AntiSpam(10, 1) then
				playerDecreeCount = 0
			end
			local text = ""
			if spellId == 299249 then--Soak Orbs
				specWarnQueensDecree:ScheduleVoiceOverLap(0+specWarnQueensDecree, "helpsoak")
				text = text..", "..L.SoakOrb
			elseif spellId == 299251 then--Dodge Orbs
				specWarnQueensDecree:ScheduleVoiceOverLap(0+specWarnQueensDecree, "watchorb")
				text = text..", "..L.AvoidOrb
			elseif spellId == 299254 then--Group Up
				specWarnQueensDecree:ScheduleVoiceOverLap(0+specWarnQueensDecree, "gather")
				text = text..", "..L.GroupUp
			elseif spellId == 299255 then--Don't Group Up
				specWarnQueensDecree:ScheduleVoiceOverLap(0+specWarnQueensDecree, "scatter")
				text = text..", "..L.Spread
			elseif spellId == 299252 then--Keep Moving
				specWarnQueensDecree:ScheduleVoiceOverLap(0+specWarnQueensDecree, "keepmove")
				text = text..", "..L.Move
			elseif spellId == 299253 then--Stop Moving
				specWarnQueensDecree:ScheduleVoiceOverLap(0+specWarnQueensDecree, "stopmove")
				text = text..", "..L.DontMove
			end
			playerDecreeCount = playerDecreeCount + 1--Increased after voices, because of way voice scheduling is being done
			--Only show warning after we've collected all decrees we'regoing to get
			if self.vb.maxDecree == playerDecreeCount then
				specWarnQueensDecree:Show(text)
			end
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
			yellArcaneBurstFades:Countdown(10, nil, icon)
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
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if (spellId == 303981 or spellId == 297898) and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 153059 then--Aethanel
		timerLightningOrbsCD:Stop()
		timerLightningBoltCD:Stop()
		timerColdBlastCD:Stop()
		self.vb.stageOneBossesLeft = self.vb.stageOneBossesLeft - 1
		if self.vb.stageOneBossesLeft == 0 then
			self.vb.phase = 1.5
			warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(1.5))
			warnPhase:Play("phasechange")
			--timerPainfulMemoriesCD:Stop()
			--timerLongingCD:Stop()
			timerArcaneOrbsCD:Stop()
			timerBeckonCD:Stop()
			timerDivideandConquerCD:Stop()
			--timerDrainAncientWardCD:Stop()
			timerArcaneOrbsCD:Start(1.5)
			timerQueensDecreeCD:Start(1.5)
		end
	elseif cid == 153060 then--Cryanus
		timerSerratedEdgeCD:Stop()
		timerChargedSpearCD:Stop()
		--countdownSerratedEdge:Cancel()
		self.vb.stageOneBossesLeft = self.vb.stageOneBossesLeft - 1
		if self.vb.stageOneBossesLeft == 0 then
			self.vb.phase = 1.5
			warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(1.5))
			warnPhase:Play("phasechange")
			--timerPainfulMemoriesCD:Stop()
			--timerLongingCD:Stop()
			timerArcaneOrbsCD:Stop()
			timerBeckonCD:Stop()
			timerDivideandConquerCD:Stop()
			--timerDrainAncientWardCD:Stop()
			timerArcaneOrbsCD:Start(1.5)
			timerQueensDecreeCD:Start(1.5)
		end
	elseif cid == 155643 then--overzealous-hulk
		castsPerGUID[args.destGUID] = nil
		timerGroundPoundCD:Stop(args.destGUID)
--	elseif cid == 154240 then--azsharas-devoted

--	elseif cid == 154565 then--Loyal Myrmidon

--	elseif cid == "unknowntidemistresssirenid" then
--		timerStaticShockCD:Stop(args.destGUID)
--		timerLightningBoltCD:Stop(args.destGUID)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 303456 then--Drain Ancient Ward
		DBM:Debug("Drain Ancient Ward 303456 cast")
		--warnDrainAncientWard:Show()
		--timerDrainAncientWardCD:Start()
	end
end
