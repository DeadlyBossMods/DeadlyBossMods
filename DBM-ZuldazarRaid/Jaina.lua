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
	"SPELL_CAST_START 287565 285177 285459 290036 288221 288345 288441 288719 289219 289940 290084 288619 288747 289488 289220 287626",
	"SPELL_CAST_SUCCESS 285725 287925 287626 289220 288374 288211",
	"SPELL_AURA_APPLIED 287993 287490 289387 287925 285253 287626 288199 288219 288212 288374 288412 288434 289220 285254 288038 287322 288169",
	"SPELL_AURA_APPLIED_DOSE 287993 285253",
	"SPELL_AURA_REMOVED 287993 287925 288199 288219 288212 288374 288038 290001",
	"SPELL_AURA_REMOVED_DOSE 287993",
	"SPELL_PERIODIC_DAMAGE 288297",
	"SPELL_PERIODIC_MISSED 288297",
	"UNIT_DIED",
--	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, Gathering Blizzard verification?
--TODO, add additional mythic only spells/timers for P2 and beyond
--TODO, detect set charge barrels, and add them to infoframe with time remaining?
--TODO, rework interrupt to use vectis interrupt per GUID code for mythic
--TODO, orb of frost targetting and improve voice/warning for it?
--TODO, shattering lance script and warning/cast timer
--TODO, figure out P2 and P3 winds (and 2.5?) current code simply blocks it from running outside P1
--[[
(ability.id = 290084 or ability.id = 287565 or ability.id = 285177 or ability.id = 285459 or ability.id = 290036 or ability.id = 288345 or ability.id = 288441 or ability.id = 288719 or ability.id = 289219 or ability.id = 288619 or ability.id = 288747 or ability.id = 289488) and type = "begincast"
 or (ability.id = 287925 or ability.id = 287626 or ability.id = 289220 or ability.id = 288374 or ability.id = 288211) and type = "cast"
 or (ability.id = 288199 or ability.id = 287322) and (type = "applybuff" or type = "removebuff")
 or ability.id = 290001 and type = "removebuff"
 or ability.id = 288169 and type = "applydebuff"
--]]
--General
local warnPhase							= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)
local warnFrozenSolid					= mod:NewTargetNoFilterAnnounce(287490, 4)
local warnJainaIceBlocked				= mod:NewTargetNoFilterAnnounce(287322, 2)
--Stage One: Burning Seas
local warnCorsair						= mod:NewSoonAnnounce("ej19690", 2, "Interface\\ICONS\\Inv_tabard_kultiran", nil, nil, nil, nil, 7)
local warnMarkedTarget					= mod:NewTargetAnnounce(288038, 2)
local warnSetCharge						= mod:NewSpellAnnounce(285725, 2)
local warnIceShard						= mod:NewStackAnnounce(285253, 2, nil, "Tank")
local warnTimeWarp						= mod:NewSpellAnnounce(287925, 3)
local warnFreezingBlast					= mod:NewSpellAnnounce(285177, 3)
local warnFrozenSiege					= mod:NewSpellAnnounce(289488, 2)
--Stage Two: Frozen Wrath
local warnBurningExplosion				= mod:NewCastAnnounce(288221, 3)
local warnBroadside						= mod:NewTargetNoFilterAnnounce(288212, 2)
local warnSiegebreaker					= mod:NewTargetNoFilterAnnounce(288374, 3)
--Intermission 2
local warnHeartofFrost					= mod:NewTargetAnnounce(289220, 2)
local warnFrostNova						= mod:NewCastAnnounce(289219, 3)
--local warnShatteringLance				= mod:NewCastAnnounce(288671, 4)
--Stage Three
local warnCrystalDust					= mod:NewCountAnnounce(289940, 3)

--General
local specWarnFreezingBlood				= mod:NewSpecialWarningMoveTo(289387, nil, nil, 2, 3, 2)
local specWarnChillingStack				= mod:NewSpecialWarningStack(287993, nil, 2, nil, nil, 1, 6)
--Stage One: Burning Seas
local specWarnIceShard					= mod:NewSpecialWarningTaunt(285253, false, nil, nil, 1, 2)
local specWarnMarkedTarget				= mod:NewSpecialWarningRun(288038, nil, nil, nil, 4, 2)
local yellMarkedTarget					= mod:NewYell(288038, nil, false)
--local specWarnBombard					= mod:NewSpecialWarningDodge(285828, nil, nil, nil, 2, 2)
local specWarnAvalanche					= mod:NewSpecialWarningYou(285254, nil, nil, nil, 1, 2)
local yellAvalanche						= mod:NewYell(285254)
local specWarnAvalancheTaunt			= mod:NewSpecialWarningTaunt(287565, nil, nil, nil, 1, 2)
local specWarGraspofFrost				= mod:NewSpecialWarningDispel(287626, "Healer", nil, 3, 1, 2)
local specWarnFreezingBlast				= mod:NewSpecialWarningDodge(285177, "Tank", nil, nil, 2, 2)
local specWarnRingofIce					= mod:NewSpecialWarningRun(285459, nil, nil, nil, 4, 2)
--Stage Two: Frozen Wrath
local specWarnIceBlockTaunt				= mod:NewSpecialWarningTaunt(287490, nil, nil, nil, 3, 2)
local specWarnGTFO						= mod:NewSpecialWarningGTFO(288297, nil, nil, nil, 1, 8)
local specWarnBroadside					= mod:NewSpecialWarningMoveAway(288212, nil, nil, nil, 1, 2)--NewSpecialWarningYouPos
local yellBroadside						= mod:NewPosYell(288212)
local yellBroadsideFades				= mod:NewIconFadesYell(288212)
local specWarnSiegebreaker				= mod:NewSpecialWarningMoveAway(288374, nil, nil, nil, 3, 2)
local yellSiegebreaker					= mod:NewYell(288374, nil, nil, nil, "YELL")
local yellSiegebreakerFades				= mod:NewShortFadesYell(288374, nil, nil, nil, "YELL")
local specWarnHandofFrost				= mod:NewSpecialWarningYou(288412, nil, nil, nil, 1, 2)
local yellHandofFrost					= mod:NewYell(288412)
local specWarnHandofFrostNear			= mod:NewSpecialWarningClose(288412, nil, nil, nil, 1, 2)
local specWarnGlacialRay				= mod:NewSpecialWarningDodgeCount(288345, nil, nil, nil, 2, 2)
local specWarnIcefall					= mod:NewSpecialWarningDodgeCount(288475, nil, nil, nil, 2, 2)
--Intermission 2
local specWarnHeartofFrost				= mod:NewSpecialWarningMoveAway(289220, nil, nil, nil, 1, 2)
local yellHeartofFrost					= mod:NewYell(289220)
local specWarnWaterBoltVolley			= mod:NewSpecialWarningInterruptCount(290084, "HasInterrupt", nil, nil, 1, 2)
--Stage Three:
local specWarnOrbofFrost				= mod:NewSpecialWarningDodgeCount(288619, nil, nil, nil, 2, 2)
local specWarnPrismaticImage			= mod:NewSpecialWarningSwitchCount(288747, "Dps", nil, nil, 1, 2)

--mod:AddTimerLine(DBM:EJ_GetSectionInfo(18527))
--General
local timerPhaseTransition				= mod:NewPhaseTimer(55)
--Stage One: Burning Seas
mod:AddTimerLine(SCENARIO_STAGE:format(1))
local timerCorsairCD					= mod:NewCDTimer(60.4, "ej19690", nil, nil, nil, 1, "Interface\\ICONS\\Inv_tabard_kultiran")
--local timerBombardCD					= mod:NewAITimer(55, 285828, nil, nil, nil, 3)
local timerAvalancheCD					= mod:NewCDTimer(60.7, 287565, nil, nil, 2, 5, nil, nil, true)
local timerGraspofFrostCD				= mod:NewCDTimer(17.3, 287626, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON, true)
local timerFreezingBlastCD				= mod:NewCDTimer(14, 285177, nil, "Tank", nil, 3, nil, nil, true)
local timerRingofIceCD					= mod:NewCDCountTimer(60.7, 285459, nil, nil, nil, 2, nil, DBM_CORE_IMPORTANT_ICON, true)
local timerHowlingWindsCD				= mod:NewCDCountTimer(80, 288169, nil, nil, nil, 6)--Mythic
local timerFrozenSiegeCD				= mod:NewCDCountTimer(31.6, 289488, nil, nil, nil, 3)--Mythic
--Stage Two: Frozen Wrath
mod:AddTimerLine(SCENARIO_STAGE:format(2))
local timerBroadsideCD					= mod:NewCDCountTimer(31.3, 288212, nil, nil, nil, 3)
local timerSiegebreakerCD				= mod:NewCDCountTimer(59.9, 288374, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
--local timerHandofFrostCD				= mod:NewCDTimer(55, 288412, nil, nil, nil, 3)--Timer is only for first cast of phase, after that, can't tell cast from jump
local timerGlacialRayCD					= mod:NewCDCountTimer(49.8, 288345, nil, nil, nil, 3)--49.8-61.1?
local timerIcefallCD					= mod:NewCDCountTimer(42.8, 288475, nil, nil, nil, 3, nil, DBM_CORE_HEROIC_ICON)
--local timerIcefall						= mod:NewCastTimer(55, 288475, nil, nil, nil, 3)
--Intermission 2
mod:AddTimerLine(DBM_CORE_INTERMISSION)
local timerHeartofFrostCD				= mod:NewCDTimer(8.5, 289220, nil, nil, nil, 3)
local timerWaterBoltVolleyCD			= mod:NewCDCountTimer(7.2, 290084, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
--Stage 3
mod:AddTimerLine(SCENARIO_STAGE:format(3))
local timerOrbofFrostCD					= mod:NewCDCountTimer(60, 288619, nil, nil, nil, 3, nil, DBM_CORE_HEROIC_ICON)
local timerPrismaticImageCD				= mod:NewCDCountTimer(41.3, 288747, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)
local timerCrystallineDustCD			= mod:NewCDCountTimer(14.1, 289940, nil, nil, 2, 5, nil, DBM_CORE_TANK_ICON)

local berserkTimer						= mod:NewBerserkTimer(900)

--Stage One: Burning Seas
local countdownRingofIce				= mod:NewCountdown(60, 285459, true)
--local countdownRupturingBlood				= mod:NewCountdown("Alt12", 244016, false, 2, 3)
--local countdownFelstormBarrage			= mod:NewCountdown("AltTwo32", 244000, nil, nil, 3)
--Stage Two: Frozen Wrath

mod:AddNamePlateOption("NPAuraOnMarkedTarget", 288038)
mod:AddNamePlateOption("NPAuraOnTimeWarp", 287925)
mod:AddNamePlateOption("NPAuraOnRefractiveIce", 288219)
mod:AddSetIconOption("SetIconBroadside", 288212, true)
mod:AddRangeFrameOption(10, 289379)
mod:AddInfoFrameOption(287993, true, 2)
mod:AddBoolOption("ShowOnlySummary", false, "misc")

mod.vb.phase = 1
mod.vb.corsairCount = 0
mod.vb.imageCount = 0
mod.vb.ringofFrostCount = 0
mod.vb.iceFallCount = 0
mod.vb.dustCount = 0
mod.vb.orbCount = 0
mod.vb.broadsideCount = 0
mod.vb.siegeCount = 0
mod.vb.glacialRayCount = 0
mod.vb.broadsideIcon = 0
mod.vb.waterboltVolleyCount = 0
mod.vb.howlingWindsCast = 0
mod.vb.frozenSiegeCount = 0
local ChillingTouchStacks = {}
local chillingCollector = {}
local graspActive = false
local castsPerGUID = {}
local rangeThreshold = 1

--[[
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
--]]

--/run DBM:GetModByName("2343"):TimerTestFunction(30)
function mod:TimerTestFunction(time)
	timerFrozenSiegeCD:Start(3.3, 1)
	timerAvalancheCD:Start(13.4)
	timerFreezingBlastCD:Start(8.6)
	timerGraspofFrostCD:Start(15.5)
	timerRingofIceCD:Stop()
	timerRingofIceCD:Start(20, 1)
	timerHowlingWindsCD:Start(25, 1)
	self:ScheduleMethod(time, "TimerTestFunction", time)
end

--/run DBM:GetModByName("2343"):TimerTestFunctionEnd()
function mod:TimerTestFunctionEnd()
	timerFrozenSiegeCD:Stop()
	timerAvalancheCD:Stop()
	timerFreezingBlastCD:Stop()
	timerGraspofFrostCD:Stop()
	timerRingofIceCD:Stop()
	timerHowlingWindsCD:Stop()
	self:UnscheduleMethod("TimerTestFunction")
end

function mod:HeartofFrostTarget(targetname, uId)
	if not targetname then return end
	if self:AntiSpam(4, targetname) then
		if targetname == UnitName("player") then
			specWarnHeartofFrost:Show()
			specWarnHeartofFrost:Play("runout")
			yellHeartofFrost:Yell()
		else
			warnHeartofFrost:Show(targetname)
		end
	end
end

local function graspCollection(finish)
	if finish then
		graspActive = false
		specWarGraspofFrost:Show(table.concat(chillingCollector, "<, >"))
		specWarGraspofFrost:Play("helpdispel")
	else
		table.wipe(chillingCollector)
		graspActive = true
	end
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.corsairCount = 0
	self.vb.imageCount = 0
	self.vb.ringofFrostCount = 0
	self.vb.iceFallCount = 0
	self.vb.dustCount = 0
	self.vb.orbCount = 0
	self.vb.broadsideCount = 0
	self.vb.siegeCount = 0
	self.vb.glacialRayCount = 0
	self.vb.broadsideIcon = 0
	self.vb.howlingWindsCast = 0
	self.vb.frozenSiegeCount = 0
	table.wipe(castsPerGUID)
	table.wipe(ChillingTouchStacks)
	table.wipe(chillingCollector)
	graspActive = false
	if self:IsMythic() then
		rangeThreshold = 1
		timerFrozenSiegeCD:Start(3.3-delay, 1)
		--timerCorsairCD:Start(5.1-delay)--Unknown
		timerAvalancheCD:Start(13.4-delay)
		timerFreezingBlastCD:Start(8.6-delay)
		timerGraspofFrostCD:Start(23.5-delay)
		timerRingofIceCD:Start(60.7-delay, 1)
		countdownRingofIce:Start(60.7)
		timerHowlingWindsCD:Start(67, 1)
		berserkTimer:Start(720)
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(10, nil, nil, 1, true, nil, self.Options.ShowOnlySummary)--Reverse checker, threshold 1 at start
		end
		self:RegisterShortTermEvents(
			"UNIT_POWER_FREQUENT player"
		)
	else
		--timerCorsairCD:Start(5.1-delay)
		timerAvalancheCD:Start(8.5-delay)
		timerFreezingBlastCD:Start(17.9-delay)
		timerGraspofFrostCD:Start(26.6-delay)
		timerRingofIceCD:Start(60.7-delay, 1)
		countdownRingofIce:Start(60.7)
		berserkTimer:Start(900)
	end
	if self.Options.InfoFrame then
		--DBM.InfoFrame:SetHeader(DBM_CORE_INFOFRAME_POWER)
		--DBM.InfoFrame:Show(8, "function", updateInfoFrame, false, false)
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(287993))
		DBM.InfoFrame:Show(10, "table", ChillingTouchStacks, 1)
	end
	if self.Options.NPAuraOnMarkedTarget or self.Options.NPAuraOnTimeWarp or self.Options.NPAuraOnRefractiveIce then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
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
			if self:IsMythic() then
				timerAvalancheCD:Start(45)
			else
				timerAvalancheCD:Start(60)
			end
		else
			timerAvalancheCD:Start(75)--75-90
		end
	elseif spellId == 285177 then
		if self.Options.SpecWarn285177dodge then
			specWarnFreezingBlast:Show()
			specWarnFreezingBlast:Play("shockwave")
		else
			warnFreezingBlast:Show()
		end
		if self:IsMythic() then
			timerFreezingBlastCD:Start(14.5)
		else
			timerFreezingBlastCD:Start(10.1)
		end
	elseif spellId == 285459 or spellId == 290036 then
		self.vb.ringofFrostCount = self.vb.ringofFrostCount + 1
		specWarnRingofIce:Show(self.vb.ringofFrostCount)
		specWarnRingofIce:Play("justrun")
		timerRingofIceCD:Stop()
		timerRingofIceCD:Start(nil, self.vb.ringofFrostCount+1)
		countdownRingofIce:Start(60.7)
	elseif spellId == 288221 and self:AntiSpam(3, 3) then
		warnBurningExplosion:Show()
	elseif spellId == 288345 and self:AntiSpam(4, 8) then
		self.vb.glacialRayCount = self.vb.glacialRayCount + 1
		specWarnGlacialRay:Show(self.vb.glacialRayCount)
		specWarnGlacialRay:Play("watchstep")
		timerGlacialRayCD:Start(nil, self.vb.glacialRayCount+1)
	elseif spellId == 288441 and self:AntiSpam(6, 7) then
		self.vb.iceFallCount = self.vb.iceFallCount + 1
		specWarnIcefall:Show(self.vb.iceFallCount)
		specWarnIcefall:Play("watchstep")
		timerIcefallCD:Start(nil, self.vb.iceFallCount+1)
		--timerIcefall:Start()
	elseif spellId == 288719 then--Flash Freeze
		self.vb.phase = 2.5
		self.vb.waterboltVolleyCount = 0
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(2.5))
		warnPhase:Play("phasechange")
		timerBroadsideCD:Stop()
		timerSiegebreakerCD:Stop()
		timerAvalancheCD:Stop()
		--timerHandofFrostCD:Stop()
		timerGlacialRayCD:Stop()
		timerIcefallCD:Stop()
		--Blizzard closes tooltip windows during cut scenes, so we gotta make sure to recall this window
		if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() then
			--DBM.InfoFrame:SetHeader(DBM_CORE_INFOFRAME_POWER)
			--DBM.InfoFrame:Show(8, "function", updateInfoFrame, false, false)
			DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(287993))
			DBM.InfoFrame:Show(5, "table", ChillingTouchStacks, 1)
		end
	elseif spellId == 289219 then
		warnFrostNova:Show()
	elseif spellId == 289940 then
		self.vb.dustCount = self.vb.dustCount + 1
		warnCrystalDust:Show(self.vb.dustCount)
		timerCrystallineDustCD:Start(nil, self.vb.dustCount)
	elseif spellId == 290084 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if args:GetSrcCreatureID() == 149144 then
			timerWaterBoltVolleyCD:Start(nil, count+1)
		end
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnWaterBoltVolley:Show(args.sourceName, count)
			if count == 1 then
				specWarnWaterBoltVolley:Play("kick1r")
			elseif count == 2 then
				specWarnWaterBoltVolley:Play("kick2r")
			elseif count == 3 then
				specWarnWaterBoltVolley:Play("kick3r")
			elseif count == 4 then
				specWarnWaterBoltVolley:Play("kick4r")
			elseif count == 5 then
				specWarnWaterBoltVolley:Play("kick5r")
			else
				specWarnWaterBoltVolley:Play("kickcast")
			end
		end
	elseif spellId == 288619 then
		self.vb.orbCount = self.vb.orbCount + 1
		specWarnOrbofFrost:Show(self.vb.orbCount)
		specWarnOrbofFrost:Play("watchorb")
		timerOrbofFrostCD:Start(nil, self.vb.orbCount+1)
	elseif spellId == 288747 then
		self.vb.imageCount = self.vb.imageCount + 1
		specWarnPrismaticImage:Show(self.vb.imageCount)
		specWarnPrismaticImage:Play("killmob")
		timerPrismaticImageCD:Start(nil, self.vb.imageCount+1)
	elseif spellId == 289488 then--Frozen Siege
		self.vb.frozenSiegeCount = self.vb.frozenSiegeCount + 1
		warnFrozenSiege:Show(self.vb.frozenSiegeCount)
		timerFrozenSiegeCD:Start(nil, self.vb.frozenSiegeCount+1)
	elseif spellId == 289220 then
		self:ScheduleMethod(0.2, "BossTargetScanner", args.sourceGUID, "HeartofFrostTarget", 0.1, 8, true, nil, nil, nil, false)--Does this target tank? if not, change false to true
	elseif spellId == 287626 then
		self:Schedule(1.9, graspCollection, self)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 285725 and self:AntiSpam(3, 5) then
		warnSetCharge:Show()
	elseif spellId == 287925 then
		warnTimeWarp:Show()
	elseif spellId == 287626 then
		timerGraspofFrostCD:Start(17.3)
		graspCollection(true)
	elseif spellId == 289220 and args:GetSrcCreatureID() == 149144 then
		timerHeartofFrostCD:Start()
	elseif spellId == 288374 then
		self.vb.siegeCount = self.vb.siegeCount + 1
		timerSiegebreakerCD:Start(nil, self.vb.siegeCount+1)
	elseif spellId == 288211 then
		self.vb.broadsideIcon = 0
		self.vb.broadsideCount = self.vb.broadsideCount + 1
		timerBroadsideCD:Start(nil, self.vb.broadsideCount+1)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 285253 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount % 3 == 0 then
				if amount >= 8 and not args:IsPlayer() and self.Options.SpecWarn285253taunt and not DBM:UnitDebuff("player", 285253) then
					specWarnIceShard:Show(args.destName)
				else
					warnIceShard:Show(args.destName, amount)
				end
			end
		end
	elseif spellId == 287993 then
		local amount = args.amount or 1
		ChillingTouchStacks[args.destName] = amount
		if args:IsPlayer() and (amount == 12 or amount >= 15 and amount % 2 == 1) then--12, 15, 17, 19
			specWarnChillingStack:Show(amount)
			specWarnChillingStack:Play("stackhigh")
		end
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(ChillingTouchStacks)
		end
		if graspActive then
			chillingCollector[#chillingCollector + 1] = args.destName
		end
	elseif spellId == 287490 then
		warnFrozenSolid:CombinedShow(0.5, args.destName)
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) and not args:IsPlayer() then
			specWarnIceBlockTaunt:Show(args.destName)
			specWarnIceBlockTaunt:Play("tauntboss")
		end
	elseif spellId == 289387 then
		if args:IsPlayer() then
			specWarnFreezingBlood:Show(DBM_ALLY)
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
		--specWarGraspofFrost:CombinedShow(1, args.destName)
		--specWarGraspofFrost:ScheduleVoice(1, "helpdispel")
	elseif spellId == 288199 then--Howling Winds (secondary 1.5 trigger)
		if self.vb.phase == 1 then
			self.vb.phase = 1.5
			warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(1.5))
			warnPhase:Play("phasechange")
		end
		--Redundant timer cancels in case she slipped anything last second at first 1.5 trigger (happens)
		timerPhaseTransition:Stop()--In case it's wrong
		timerCorsairCD:Stop()
		timerAvalancheCD:Stop()
		timerGraspofFrostCD:Stop()
		timerFreezingBlastCD:Stop()
		timerRingofIceCD:Stop()
		timerHowlingWindsCD:Stop()
		timerFrozenSiegeCD:Stop()
		countdownRingofIce:Cancel()
		--Blizzard closes tooltip windows during cut scenes, so we gotta make sure to recall this window
		if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() then
			--DBM.InfoFrame:SetHeader(DBM_CORE_INFOFRAME_POWER)
			--DBM.InfoFrame:Show(8, "function", updateInfoFrame, false, false)
			DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(287993))
			DBM.InfoFrame:Show(5, "table", ChillingTouchStacks, 1)
		end
	elseif spellId == 288219 then
		if self.Options.NPAuraOnRefractiveIce then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId)
		end
	elseif spellId == 288212 then
		self.vb.broadsideIcon = self.vb.broadsideIcon + 1
		local icon = self.vb.broadsideIcon
		warnBroadside:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnBroadside:Show(self:IconNumToTexture(icon))
			specWarnBroadside:Play("targetyou")
			yellBroadside:Yell(icon, icon, icon)
			yellBroadsideFades:Countdown(6, nil, icon)
		end
		if self.Options.SetIconBroadside then
			self:SetIcon(args.destName, icon)
		end
	elseif spellId == 288374 then
		if args:IsPlayer() then
			specWarnSiegebreaker:Show()
			specWarnSiegebreaker:Play("runout")
			yellSiegebreaker:Yell()
			yellSiegebreakerFades:Countdown(8)
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
	elseif spellId == 289220 and self:AntiSpam(4, args.destName) then
		if args:IsPlayer() then
			specWarnHeartofFrost:Show()
			specWarnHeartofFrost:Play("runout")
			yellHeartofFrost:Yell()
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
	elseif spellId == 287322 then
		warnJainaIceBlocked:Show(args.destName)
	elseif spellId == 288169 and self:AntiSpam(10, 10) and self.vb.phase ~= 1.5 then--Howling Winds (Mythic)
		self.vb.howlingWindsCast = self.vb.howlingWindsCast + 1
		timerHowlingWindsCD:Start(80, self.vb.howlingWindsCast+1)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 287993 then
		ChillingTouchStacks[args.destName] = nil
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(ChillingTouchStacks)
		end
	elseif spellId == 288038 then
		if self.Options.NPAuraOnMarkedTarget then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	elseif spellId == 287925 then
		if self.Options.NPAuraOnTimeWarp then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	elseif spellId == 288199 and self.vb.phase < 2 and self:IsInCombat()  then--Howling Winds
		self.vb.phase = 2
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(2))
		warnPhase:Play("ptwo")
		timerBroadsideCD:Start(3.2, 1)--SUCCESS
		timerGlacialRayCD:Start(6.6, 1)
		timerAvalancheCD:Start(16.3)
		--timerHandofFrostCD:Start(21.5)--21.5-25.57
		if not self:IsLFR() then
			timerIcefallCD:Start(30.2, 1)
		end
		timerSiegebreakerCD:Start(40.3, 1)
		--Blizzard closes tooltip windows during cut scenes, so we gotta make sure to recall this window
		if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() then
			--DBM.InfoFrame:SetHeader(DBM_CORE_INFOFRAME_POWER)
			--DBM.InfoFrame:Show(8, "function", updateInfoFrame, false, false)
			DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(287993))
			DBM.InfoFrame:Show(5, "table", ChillingTouchStacks, 1)
		end
	elseif spellId == 288219 then
		if self.Options.NPAuraOnRefractiveIce then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	elseif spellId == 288212 then
		if args:IsPlayer() then
			yellBroadsideFades:Cancel()
		end
		if self.Options.SetIconBroadside then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 288374 then
		if args:IsPlayer() then
			yellSiegebreakerFades:Cancel()
		end
	elseif spellId == 290001 and self:IsInCombat() then--Arcane Barrage
		self.vb.phase = 3
		self.vb.iceFallCount = 0
		self.vb.broadsideCount = 0
		self.vb.siegeCount = 0
		self.vb.glacialRayCount = 0
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(3))
		warnPhase:Play("pthree")
		timerBroadsideCD:Start(14.8, 1)--SUCCESS
		timerCrystallineDustCD:Start(25, 1)
		timerGlacialRayCD:Start(48.6, 1)
		timerSiegebreakerCD:Start(58.4, 1)--to CLEU event, emote 1 second faster, may change
		if not self:IsLFR() then
			timerPrismaticImageCD:Start(12.6, 1)
			timerIcefallCD:Start(60.5, 1)
		end
		if self:IsHard() then
			timerOrbofFrostCD:Start(11, 1)
		end
		--Blizzard closes tooltip windows during cut scenes, so we gotta make sure to recall this window
		if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() then
			--DBM.InfoFrame:SetHeader(DBM_CORE_INFOFRAME_POWER)
			--DBM.InfoFrame:Show(8, "function", updateInfoFrame, false, false)
			DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(287993))
			DBM.InfoFrame:Show(5, "table", ChillingTouchStacks, 1)
		end
	end
end

function mod:SPELL_AURA_REMOVED_DOSE(args)
	local spellId = args.spellId
	if spellId == 287993 then
		ChillingTouchStacks[args.destName] = args.amount or 1
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(ChillingTouchStacks)
		end
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
	if cid == 149144 then--Jaina's Tide Elemental
		castsPerGUID[args.destGUID] = nil
		timerHeartofFrostCD:Stop()
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
	--"<11.40 22:23:57> [UNIT_SPELLCAST_SUCCEEDED] Lady Jaina Proudmoore(Murdina) -Corsair Picker- [[boss1:Cast-3-3133-2070-28514-288013-002BCFC74D:288013]]", -- [110]
	--"<25.44 22:24:11> [CHAT_MSG_RAID_BOSS_EMOTE] A Kul Tiran Corsair approaches on the port side!#Kul Tiran Corsair###Apookie##0#0##0#2952#nil#0#false#false#false#false", -- [295]
	if spellId == 288013 then--Corsair Picker (fires 12-14 seconds before emote does)
		warnCorsair:Show()
		warnCorsair:Play("mobsoon")
		timerCorsairCD:Start(12.3)
	elseif spellId == 290681 then--Transition Visual 1
		self.vb.phase = 1.5
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(1.5))
		warnPhase:Play("phasechange")
		timerCorsairCD:Stop()
		timerAvalancheCD:Stop()
		timerGraspofFrostCD:Stop()
		timerFreezingBlastCD:Stop()
		timerRingofIceCD:Stop()
		timerHowlingWindsCD:Stop()
		timerFrozenSiegeCD:Stop()
		countdownRingofIce:Cancel()
		timerPhaseTransition:Start(12.5)
	end
end

function mod:UNIT_POWER_FREQUENT(uId, type)
	if type == "ALTERNATE" then--Assumed, but has to be, since her main power is her special attacks (ie ring of ice)
		local altPower = UnitPower(uId, 10)
		if rangeThreshold < 3 and altPower >= 75 then
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10, nil, nil, 5, true, nil, self.Options.ShowOnlySummary)--Reverse checker, threshold 5
			end
			self:UnregisterShortTermEvents()
		elseif rangeThreshold < 2 and altPower >=50 then
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10, nil, nil, 3, true, nil, self.Options.ShowOnlySummary)--Reverse checker, threshold 3
			end
		end
	end
end
