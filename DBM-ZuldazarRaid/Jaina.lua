local mod	= DBM:NewMod(2343, "DBM-ZuldazarRaid", 3, 1176)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(138967)--146409 or 146416 probably
mod:SetEncounterID(2281)
--mod:DisableESCombatDetection()
mod:SetZone()
--mod:SetBossHPInfoToHighest()
--mod:SetUsedIcons(1, 2, 8)
mod:SetHotfixNoticeRev(18175)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 35

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 287565 287626 285177 285459 290036 288221 288345 288441 288719 289219 289940 290084 288619 288747",
	"SPELL_CAST_SUCCESS 285725 287925 287626 285257 289220 288374 288211",
	"SPELL_AURA_APPLIED 287993 287490 289387 287925 285253 287626 288199 290053 288219 288212 288374 288412 288434 289220 285254 288038",
	"SPELL_AURA_APPLIED_DOSE 287993 285253",
	"SPELL_AURA_REMOVED 287993 287925 287626 288199 290053 288219 288212 288374 289220 288038 290001",
	"SPELL_AURA_REMOVED_DOSE 287993",
	"SPELL_PERIODIC_DAMAGE 288297",
	"SPELL_PERIODIC_MISSED 288297",
	"UNIT_DIED",
--	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, Gathering Blizzard improvements?
--TODO, add additional mythic only spells/timers
--TODO, detect set charge barrels, and add them to infoframe with time remaining
--TODO, separate cast hand of frost from spread hand of frost spellIds (currently not possible)
--TODO, enable hand of frost timer when can separate cast ID from spread ID and get boss cast event (currently not possible)
--TODO, improve elemental CDS to use GUID to handle the split mechanic on mythic.
--TODO, rework interrupt to use vectis interrupt per GUID code for mythic
--TODO, orb of frost targetting and improve voice/warning for it
--TODO, shattering lance script and warning/cast timer
--TODO, what spells do Prismatic Images copy, so it can be handled by timer code
--Todo, broadside icons?
--[[
(ability.id = 290084 or ability.id = 287565 or ability.id = 285177 or ability.id = 285459 or ability.id = 290036 or ability.id = 288345 or ability.id = 288441 or ability.id = 288719 or ability.id = 289219 or ability.id = 288619 or ability.id = 288747) and type = "begincast"
 or (ability.id = 287925 or ability.id = 287626 or ability.id = 289220 or ability.id = 288374 or ability.id = 288211) and type = "cast"
 or (ability.id = 288199 or ability.id = 290053) and type = "applybuff"
 or ability.id = 290001 and type = "removebuff"
--]]
--General
local warnPhase							= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)
local warnFrozenSolid					= mod:NewTargetNoFilterAnnounce(287490, 4)
--Stage One: Burning Seas
local warnCorsair						= mod:NewSpellAnnounce("ej19690", 2, "Interface\\ICONS\\Inv_tabard_kultiran", nil, nil, nil, nil, 7)
local warnMarkedTarget					= mod:NewTargetAnnounce(288038, 2)
local warnSetCharge						= mod:NewSpellAnnounce(285725, 2)
local warnIceShard						= mod:NewStackAnnounce(285253, 2, nil, "Tank")
local warnTimeWarp						= mod:NewSpellAnnounce(287925, 3)
local warnFreezingBlast					= mod:NewSpellAnnounce(285177, 3)
--Stage Two: Frozen Wrath
local warnBurningExplosion				= mod:NewCastAnnounce(288221, 3)
local warnBroadside						= mod:NewTargetNoFilterAnnounce(288212, 2)
local warnSiegebreaker					= mod:NewTargetNoFilterAnnounce(288374, 3)
--Intermission 2
local warnHeartofFrost					= mod:NewTargetAnnounce(289220, 2)
local warnFrostNova						= mod:NewCastAnnounce(289219, 3)
--local warnShatteringLance				= mod:NewCastAnnounce(288671, 4)
--Stage Three
local warnCrystalDust					= mod:NewSpellAnnounce(289940, 3)

--General
local specWarnFreezingBlood				= mod:NewSpecialWarningYou(289387, nil, nil, nil, 1, 2)
local specWarnChillingStack				= mod:NewSpecialWarningStack(287993, nil, 2, nil, nil, 1, 6)
--Stage One: Burning Seas
local specWarnMarkedTarget				= mod:NewSpecialWarningRun(288038, nil, nil, nil, 4, 2)
local yellMarkedTarget					= mod:NewYell(288038, nil, false)
--local specWarnBombard					= mod:NewSpecialWarningDodge(285828, nil, nil, nil, 2, 2)
local specWarnAvalanche					= mod:NewSpecialWarningYou(285254, nil, nil, nil, 1, 2)
local yellAvalanche						= mod:NewYell(285254)
local specWarnAvalancheTaunt			= mod:NewSpecialWarningTaunt(287565, nil, nil, nil, 1, 2)
local specWarGraspofFrost				= mod:NewSpecialWarningDispel(287626, false, nil, 2, 1, 2)--Cast more often now, so make this an opt in warning
local specWarnFreezingBlast				= mod:NewSpecialWarningDodge(285177, "Tank", nil, nil, 2, 2)
local specWarnRingofIce					= mod:NewSpecialWarningRun(285459, nil, nil, nil, 4, 2)
--Stage Two: Frozen Wrath
local specWarnGTFO						= mod:NewSpecialWarningGTFO(288297, nil, nil, nil, 1, 8)
local specWarnBroadside					= mod:NewSpecialWarningMoveAway(288212, nil, nil, nil, 1, 2)
local yellBroadside						= mod:NewYell(288212)
local yellBroadsideFades				= mod:NewShortFadesYell(288212)
local specWarnSiegebreaker				= mod:NewSpecialWarningMoveAway(288374, nil, nil, nil, 3, 2)
local yellSiegebreaker					= mod:NewYell(288374, nil, nil, nil, "YELL")
local yellSiegebreakerFades				= mod:NewShortFadesYell(288374, nil, nil, nil, "YELL")
local specWarnHandofFrost				= mod:NewSpecialWarningYou(288412, nil, nil, nil, 1, 2)
local yellHandofFrost					= mod:NewYell(288412)
local specWarnHandofFrostNear			= mod:NewSpecialWarningClose(288412, nil, nil, nil, 1, 2)
local specWarnGlacialRay				= mod:NewSpecialWarningDodge(288345, nil, nil, nil, 2, 2)
local specWarnIcefall					= mod:NewSpecialWarningDodge(288475, nil, nil, nil, 2, 2)
--Intermission 2
local specWarnTideElemental				= mod:NewSpecialWarningSwitch(285257, "-Healer", nil, nil, 1, 2)
local specWarnHeartofFrost				= mod:NewSpecialWarningMoveAway(289220, nil, nil, nil, 1, 2)
local yellHeartofFrost					= mod:NewYell(289220)
local specWarnWaterBoltVolley			= mod:NewSpecialWarningInterrupt(290084, "HasInterrupt", nil, nil, 1, 2)
--Stage Three:
local specWarnOrbofFrost				= mod:NewSpecialWarningDodge(288619, nil, nil, nil, 2, 2)
local specWarnPrismaticImage			= mod:NewSpecialWarningSwitchCount(288747, "Dps", nil, nil, 1, 2)

--mod:AddTimerLine(DBM:EJ_GetSectionInfo(18527))
--General
local timerPhaseTransition				= mod:NewPhaseTimer(55)
--Stage One: Burning Seas
local timerCorsairCD					= mod:NewCDTimer(60.4, "ej19690", nil, nil, nil, 1, "Interface\\ICONS\\Inv_tabard_kultiran")
--local timerBombardCD					= mod:NewAITimer(55, 285828, nil, nil, nil, 3)
local timerAvalancheCD					= mod:NewCDTimer(60.7, 287565, nil, nil, 2, 5)
local timerGraspofFrostCD				= mod:NewCDTimer(6, 287626, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON)
local timerFreezingBlastCD				= mod:NewCDTimer(10.1, 285177, nil, "Tank", nil, 3)
local timerRingofIceCD					= mod:NewCDTimer(60.7, 285459, nil, nil, nil, 2, nil, DBM_CORE_IMPORTANT_ICON)
--Stage Two: Frozen Wrath
local timerBroadsideCD					= mod:NewCDTimer(31.5, 288212, nil, nil, nil, 3)
local timerSiegebreakerCD				= mod:NewCDTimer(59.9, 288374, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
--local timerHandofFrostCD				= mod:NewCDTimer(55, 288412, nil, nil, nil, 3)--Timer is only for first cast of phase, after that, can't tell cast from jump
local timerGlacialRayCD					= mod:NewCDTimer(49.8, 288345, nil, nil, nil, 3)--49.8-61.1?
local timerIcefallCD					= mod:NewCDTimer(43.4, 288475, nil, nil, nil, 3, nil, DBM_CORE_HEROIC_ICON)
--local timerIcefall						= mod:NewCastTimer(55, 288475, nil, nil, nil, 3)
--Intermission 2
local timerHeartofFrostCD				= mod:NewAITimer(55, 289220, nil, nil, nil, 3)
local timerFrostNovaCD					= mod:NewAITimer(55, 289219, nil, nil, nil, 2)
local timerWaterBoltVolleyCD			= mod:NewAITimer(55, 290084, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
--Stage 3
local timerOrbofFrostCD					= mod:NewCDTimer(60, 288619, nil, nil, nil, 3, nil, DBM_CORE_HEROIC_ICON)
local timerPrismaticImageCD				= mod:NewCDCountTimer(41.3, 288747, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)
local timerCrystallineDustCD			= mod:NewCDTimer(14.1, 289940, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)

--local berserkTimer					= mod:NewBerserkTimer(600)

--Stage One: Burning Seas
--local countdownCollapsingWorld			= mod:NewCountdown(50, 243983, true, 3, 3)
--local countdownRupturingBlood				= mod:NewCountdown("Alt12", 244016, false, 2, 3)
--local countdownFelstormBarrage			= mod:NewCountdown("AltTwo32", 244000, nil, nil, 3)
--Stage Two: Frozen Wrath

--mod:AddSetIconOption("SetIconGift", 255594, true)
mod:AddRangeFrameOption(10, 289379)
mod:AddInfoFrameOption(287993, true, 2)
mod:AddNamePlateOption("NPAuraOnMarkedTarget", 288038)
mod:AddNamePlateOption("NPAuraOnTimeWarp", 287925)
mod:AddNamePlateOption("NPAuraOnRefractiveIce", 288219)
mod:AddSetIconOption("SetIconGraspofFrost2", 287626, false)

mod.vb.phase = 1
mod.vb.corsairCount = 0
mod.vb.GraspofFrostIcon = 1
mod.vb.imageCount = 0
local ChillingTouchStacks = {}

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
				if adjustedPower >= 1 then
					addLine(UnitName(uId), currentPower)
				end
			end
		end
		addLine(" ", " ")--Insert a blank entry to split the two debuffs
		--Chilling Touch Stacks
		--Sort debuffs by highest then inject into regular table
		if #ChillingTouchStacks > 0 then
			for uId in DBM:GetGroupMembers() do
				local unitName = DBM:GetUnitFullName(uId)
				local count = ChillingTouchStacks[unitName] or 0
				tempLines[unitName] = count
				tempLinesSorted[#tempLinesSorted + 1] = unitName
			end
			--Sort lingering according to options
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
	self.vb.corsairCount = 0
	self.vb.GraspofFrostIcon = 1
	self.vb.imageCount = 0
	table.wipe(ChillingTouchStacks)
	timerCorsairCD:Start(5.1-delay)
	timerAvalancheCD:Start(8.5-delay)
	timerFreezingBlastCD:Start(17.9-delay)
	timerGraspofFrostCD:Start(26.6-delay)
	timerRingofIceCD:Start(60.7-delay)
	if self.Options.RangeFrame and self:IsMythic() then
		DBM.RangeCheck:Show(10)
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM_CORE_INFOFRAME_POWER)
		DBM.InfoFrame:Show(8, "function", updateInfoFrame, false, false)
	end
	if self.Options.NPAuraOnMarkedTarget or self.Options.NPAuraOnTimeWarp or self.Options.NPAuraOnRefractiveIce then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.NPAuraOnMarkedTarget or self.Options.NPAuraOnTimeWarp or self.Options.NPAuraOnRefractiveIce then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 287565 then
		if self.vb.phase == 1 then
			timerAvalancheCD:Start(60)
		else
			timerAvalancheCD:Start(75)--75-90
		end
	elseif spellId == 287626 then
		self.vb.GraspofFrostIcon = 1
	elseif spellId == 285177 then
		if self.Options.SpecWarn285177dodge then
			specWarnFreezingBlast:Show()
			specWarnFreezingBlast:Play("shockwave")
		else
			warnFreezingBlast:Show()
		end
		timerFreezingBlastCD:Start()
	elseif spellId == 285459 or spellId == 290036 then
		specWarnRingofIce:Show()
		specWarnRingofIce:Play("justrun")
		timerRingofIceCD:Start()
	elseif spellId == 288221 and self:AntiSpam(3, 3) then
		warnBurningExplosion:Show()
	elseif spellId == 288345 and self:AntiSpam(4, 8) then
		specWarnGlacialRay:Show()
		specWarnGlacialRay:Play("watchstep")
		timerGlacialRayCD:Start()
	elseif spellId == 288441 and self:AntiSpam(6, 7) then
		specWarnIcefall:Show()
		specWarnIcefall:Play("watchstep")
		timerIcefallCD:Start()
		--timerIcefall:Start()
	elseif spellId == 288719 then--Flash Freeze
		self.vb.phase = 2.5
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(2.5))
		warnPhase:Play("phasechange")
		timerBroadsideCD:Stop()
		timerSiegebreakerCD:Stop()
		timerAvalancheCD:Stop()
		--timerHandofFrostCD:Stop()
		timerGlacialRayCD:Stop()
		timerIcefallCD:Stop()
	elseif spellId == 289219 then
		warnFrostNova:Show()
		timerFrostNovaCD:Start()
	elseif spellId == 289940 then
		warnCrystalDust:Show()
		timerCrystallineDustCD:Start()
	elseif spellId == 290084 then
		timerWaterBoltVolleyCD:Start()
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnWaterBoltVolley:Show(args.sourceName)
			specWarnWaterBoltVolley:Play("kickcast")
		end
	elseif spellId == 288619 then
		specWarnOrbofFrost:Show()
		specWarnOrbofFrost:Play("watchorb")
		timerOrbofFrostCD:Start()
	elseif spellId == 288747 then
		self.vb.imageCount = self.vb.imageCount + 1
		specWarnPrismaticImage:Show(self.vb.imageCount)
		specWarnPrismaticImage:Play("killmob")
		timerPrismaticImageCD:Start(nil, self.vb.imageCount+1)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 285725 and self:AntiSpam(3, 5) then
		warnSetCharge:Show()
	elseif spellId == 287925 then
		warnTimeWarp:Show()
	elseif spellId == 287626 then
		timerGraspofFrostCD:Start()
	elseif spellId == 285257 then
		specWarnTideElemental:Show()
		specWarnTideElemental:Play("bigmob")
		timerHeartofFrostCD:Start(2)
		timerFrostNovaCD:Start(2)
		if self:IsHard() then
			timerWaterBoltVolleyCD:Start(2)
		end
	elseif spellId == 289220 then
		timerHeartofFrostCD:Start()
	elseif spellId == 288374 then
		timerSiegebreakerCD:Start()
	elseif spellId == 288211 then
		timerBroadsideCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 285253 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount % 3 == 0 then
				warnIceShard:Show(args.destName, amount)
			end
		end
	elseif spellId == 287993 then
		local amount = args.amount or 1
		ChillingTouchStacks[args.destName] = amount
		if args:IsPlayer() and (amount == 12 or amount >= 15 and amount % 2 == 1) then--12, 15, 17, 19
			specWarnChillingStack:Show(amount)
			specWarnChillingStack:Play("stackhigh")
		end
	elseif spellId == 287490 then
		warnFrozenSolid:CombinedShow(0.5, args.destName)
	elseif spellId == 289387 then
		if args:IsPlayer() and self:AntiSpam(6, 1) then
			specWarnFreezingBlood:Show()
			specWarnFreezingBlood:Play("gathershare")
		end
	elseif spellId == 288038 then
		warnMarkedTarget:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			if self:AntiSpam(3, 2) then
				specWarnMarkedTarget:Show()
				specWarnMarkedTarget:Play("justrun")
				yellMarkedTarget:Yell()
			end
			if self.Options.NPAuraOnMarkedTarget then
				DBM.Nameplate:Show(true, args.sourceGUID, spellId, nil, 10)
			end
		end
	elseif spellId == 287925 then
		if self.Options.NPAuraOnTimeWarp then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId, nil, 40)
		end
	elseif spellId == 287626 then
		specWarGraspofFrost:CombinedShow(1, args.destName)
		specWarGraspofFrost:ScheduleVoice(1, "helpdispel")
		if self.Options.SetIconGraspofFrost2 then
			self:SetIcon(args.destName, self.vb.GraspofFrostIcon)
		end
		self.vb.GraspofFrostIcon = self.vb.GraspofFrostIcon + 1
	elseif (spellId == 288199 or spellId == 290053) and self.vb.phase == 1 then--Howling Winds (secondary 1.5 trigger)
		self.vb.phase = 1.5
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(1.5))
		warnPhase:Play("phasechange")
		timerPhaseTransition:Stop()--In case it's wrong
		timerCorsairCD:Stop()
		timerAvalancheCD:Stop()
		timerGraspofFrostCD:Stop()
		timerFreezingBlastCD:Stop()
		timerRingofIceCD:Stop()
	elseif spellId == 288219 then
		if self.Options.NPAuraOnRefractiveIce then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId)
		end
	elseif spellId == 288212 then
		warnBroadside:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnBroadside:Show()
			specWarnBroadside:Play("targetyou")
			yellBroadside:Yell()
			yellBroadsideFades:Countdown(6)
		end
	elseif spellId == 288374 then
		if args:IsPlayer() then
			specWarnSiegebreaker:Show()
			specWarnSiegebreaker:Play("runout")
			yellSiegebreaker:Yell()
			yellSiegebreakerFades:Countdown(8)
			if self.Options.RangeFrame and not self:IsMythic() then
				DBM.RangeCheck:Show(10)
			end
		else
			warnSiegebreaker:Show(args.destName)
		end
	elseif spellId == 288412 or spellId == 288434 then
		if args:IsPlayer() then
			specWarnHandofFrost:Show()
			specWarnHandofFrost:Play("targetyou")
			yellHandofFrost:Yell()
		elseif self:CheckNearby(12, args.destName) and not DBM:UnitDebuff("player", spellId) and self:AntiSpam(4, 6) then
			specWarnHandofFrostNear:Show(args.destName)
			specWarnHandofFrostNear:Play("watchstep")
		end
	elseif spellId == 289220 then
		if args:IsPlayer() then
			specWarnHeartofFrost:Show()
			specWarnHeartofFrost:Play("runout")
			yellHeartofFrost:Yell()
			if self.Options.RangeFrame and not self:IsMythic() then
				DBM.RangeCheck:Show(10)
			end
		else
			warnHeartofFrost:Show(args.destName)
		end
	elseif spellId == 285254 then
		if args:IsPlayer() then
			specWarnAvalanche:Show()
			specWarnAvalanche:Play("runout")
			yellAvalanche:Yell()
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			if self:IsTanking(uId) then
				specWarnAvalancheTaunt:Show(args.destName)
				specWarnAvalancheTaunt:Play("tauntboss")
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 287993 then
		ChillingTouchStacks[args.destName] = nil
	elseif spellId == 288038 then
		if self.Options.NPAuraOnMarkedTarget then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	elseif spellId == 287925 then
		if self.Options.NPAuraOnTimeWarp then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	elseif spellId == 287626 then
		if self.Options.SetIconGraspofFrost2 then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 288199 or spellId == 290053 then--Howling Winds
		self.vb.phase = 2
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(2))
		warnPhase:Play("ptwo")
		timerBroadsideCD:Start(2)--It actually is 2 seconds
		timerGlacialRayCD:Start(6.6)
		timerAvalancheCD:Start(16.3)
		--timerHandofFrostCD:Start(21.5)--21.5-25.57
		if not self:IsLFR() then
			timerIcefallCD:Start(30.8)
		end
		timerSiegebreakerCD:Start(40.3)
	elseif spellId == 288219 then
		if self.Options.NPAuraOnRefractiveIce then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	elseif spellId == 288212 then
		if args:IsPlayer() then
			yellBroadsideFades:Cancel()
		end
	elseif spellId == 288374 then
		if args:IsPlayer() then
			yellSiegebreakerFades:Cancel()
			if self.Options.RangeFrame and not self:IsMythic() then
				DBM.RangeCheck:Hide()
			end
		end
	elseif spellId == 289220 then
		if args:IsPlayer() then
			if self.Options.RangeFrame and not self:IsMythic() then
				DBM.RangeCheck:Hide()
			end
		end
	elseif spellId == 290001 then--Arcane Barrage
		self.vb.phase = 3
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(3))
		warnPhase:Play("pthree")
		timerBroadsideCD:Start(14.8)--SUCCESS
		timerCrystallineDustCD:Start(25)
		timerGlacialRayCD:Start(48.6)
		timerSiegebreakerCD:Start(58.4)--to CLEU event, emote 1 second faster, may change
		if not self:IsLFR() then
			timerPrismaticImageCD:Start(12.6, 1)
			timerIcefallCD:Start(60.5)
		end
		if self:IsHard() then
			timerOrbofFrostCD:Start(11)
		end
	end
end

function mod:SPELL_AURA_REMOVED_DOSE(args)
	local spellId = args.spellId
	if spellId == 287993 then
		ChillingTouchStacks[args.destName] = args.amount or 1
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 288297 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 146765 then--Tide Elemental (or one of these, 149144, 149501, 149558)
		timerHeartofFrostCD:Stop()
		timerFrostNovaCD:Stop()
		timerWaterBoltVolleyCD:Stop()
	--elseif cid == 149535 then--Icebound Image
	
	--elseif cid == 148965 then--Kul Tiran Marine

	--elseif cid == 147531 or cid == 147180 or cid == 146811 then
		--self.vb.corsairCount = self.vb.corsairCount - 1
		--if self.vb.corsairCount == 0 then
			--timerBombardCD:Stop()
		--end
	--elseif cid == 148631 then--Unexploded Ordinance
	
	end
end

--[[
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if msg:find("spell:285828") then
		specWarnBombard:Show()
		specWarnBombard:Play("watchstep")
		--timerBombardCD:Start()
	end
end
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 288013 then--Corsair Picker
		warnCorsair:Show()
		timerCorsairCD:Start()
	elseif spellId == 290681 then--Transition Visual 1
		self.vb.phase = 1.5
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(1.5))
		warnPhase:Play("phasechange")
		timerCorsairCD:Stop()
		timerAvalancheCD:Stop()
		timerGraspofFrostCD:Stop()
		timerFreezingBlastCD:Stop()
		timerRingofIceCD:Stop()
		timerPhaseTransition:Start(12.5)
	elseif spellId == 288405 or spellId == 288401 then--Ability Callout Corsair on the Port Side
		DBM:Debug("Corsair on the Port Side")
	elseif spellId == 288407 or spellId == 288406 then--Ability Callout Corsair on the Starboard Side
		DBM:Debug("Corsair on the Starboard Side")
	end
end
