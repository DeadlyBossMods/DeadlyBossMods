local mod	= DBM:NewMod(2343, "DBM-ZuldazarRaid", 3, 1176)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(146409)
mod:SetEncounterID(2281)
mod:SetZone()
mod:SetUsedIcons(1, 2, 3)
mod:SetHotfixNoticeRev(18363)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 35

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 287565 285177 285459 290036 288221 288345 288441 288719 289219 289940 290084 288619 288747 289488 289220 287626",
	"SPELL_CAST_SUCCESS 285725 287925 287626 289220 288374 288211",
	"SPELL_AURA_APPLIED 287993 287490 289387 287925 285253 288199 288219 288212 288374 288412 288434 289220 285254 288038 287322 288169 290053",
	"SPELL_AURA_APPLIED_DOSE 287993 285253",
	"SPELL_AURA_REMOVED 287993 287925 288199 288219 288212 288374 288038 290001 289387 287322 285254 290053",
	"SPELL_AURA_REMOVED_DOSE 287993",
	"SPELL_PERIODIC_DAMAGE 288297",
	"SPELL_PERIODIC_MISSED 288297",
	"UNIT_DIED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, detect set charge barrels, and add them to infoframe with time remaining?
--TODO, shattering lance script and warning/cast timer?
--TODO, Glacial Ray triggers a 9.7 ICD on all other timers. Timers can be improved by account for this in an UpdateAllTimers method and possibly other min ICDs of other casts
--[[
(ability.id = 290084 or ability.id = 287565 or ability.id = 285177 or ability.id = 285459 or ability.id = 290036 or ability.id = 288345 or ability.id = 288441 or ability.id = 288719 or ability.id = 289219 or ability.id = 288619 or ability.id = 288747 or ability.id = 289488) and type = "begincast"
 or (ability.id = 287925 or ability.id = 287626 or ability.id = 289220 or ability.id = 288374 or ability.id = 288211) and type = "cast"
 or (ability.id = 288199 or ability.id = 287322) and (type = "applybuff" or type = "removebuff")
 or type = "interrupt"
 or ability.id = 290001 and type = "removebuff"
 or ability.id = 288169 and type = "applydebuff"
--]]
--General
local warnPhase							= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)
local warnFrozenSolid					= mod:NewTargetNoFilterAnnounce(287490, 4)
local warnJainaIceBlocked				= mod:NewTargetNoFilterAnnounce(287322, 2)
--Stage One: Burning Seas
local warnCorsairSoon					= mod:NewSoonAnnounce("ej19690", 2, "2261243", nil, nil, nil, nil, 7)
local warnCorsair						= mod:NewTargetAnnounce("ej19690", 3, "2261243", nil, nil, nil, nil, 7)
local warnMarkedTarget					= mod:NewTargetAnnounce(288038, 2)
local warnSetCharge						= mod:NewSpellAnnounce(285725, 2)
local warnIceShard						= mod:NewStackAnnounce(285253, 2, nil, "Tank")
local warnTimeWarp						= mod:NewSpellAnnounce(287925, 3)
local warnFreezingBlast					= mod:NewSpellAnnounce(285177, 3)
local warnFrozenSiege					= mod:NewSpellAnnounce(289488, 2)
--Intermission 1
local warnHowlingWindsLeft				= mod:NewCountAnnounce(290053, 2)
--Stage Two: Frozen Wrath
local warnBurningExplosion				= mod:NewCastAnnounce(288221, 3)
local warnBroadside						= mod:NewTargetCountAnnounce(288212, 2, nil, nil, nil, nil, nil, nil, true)
local warnSiegebreaker					= mod:NewTargetCountAnnounce(288374, 3, nil, nil, nil, nil, nil, nil, true)
local warnGlacialRay					= mod:NewBaitAnnounce(288345, 3, nil, nil, nil, nil, 8)
--Intermission 2
local warnHeartofFrost					= mod:NewTargetAnnounce(289220, 2)
local warnFrostNova						= mod:NewCastAnnounce(289219, 3)
--local warnShatteringLance				= mod:NewCastAnnounce(288671, 4)
--Stage Three
local warnCrystalDust					= mod:NewCountAnnounce(289940, 3)

--General
local specWarnFreezingBlood				= mod:NewSpecialWarningMoveTo(289387, false, nil, 3, 1, 2)
local yellFreezingBlood					= mod:NewFadesYell(289387, L.Freezing, true, 2, "YELL")
local specWarnChillingStack				= mod:NewSpecialWarningStack(287993, nil, 12, nil, nil, 1, 6)
--Stage One: Burning Seas
local specWarnIceShard					= mod:NewSpecialWarningTaunt(285253, false, nil, nil, 1, 2)
local specWarnMarkedTarget				= mod:NewSpecialWarningRun(288038, nil, nil, nil, 4, 2)
local yellMarkedTarget					= mod:NewYell(288038, nil, false)
--local specWarnBombard					= mod:NewSpecialWarningDodge(285828, nil, nil, nil, 2, 2)
local specWarnAvalanche					= mod:NewSpecialWarningYouPos(285254, nil, nil, nil, 1, 2)
local yellAvalanche						= mod:NewPosYell(285254)
local specWarnAvalancheTaunt			= mod:NewSpecialWarningTaunt(287565, nil, nil, nil, 1, 2)
local specWarGraspofFrost				= mod:NewSpecialWarningDispel(287626, "Healer", nil, 3, 1, 2)
local specWarnFreezingBlast				= mod:NewSpecialWarningDodge(285177, "Tank", nil, nil, 2, 2)
local specWarnRingofIce					= mod:NewSpecialWarningRun(285459, nil, nil, nil, 4, 2)
--Stage Two: Frozen Wrath
local specWarnIceBlockTaunt				= mod:NewSpecialWarningTaunt(287490, nil, nil, nil, 3, 2)
local specWarnGTFO						= mod:NewSpecialWarningGTFO(288297, nil, nil, nil, 1, 8)
local specWarnBroadside					= mod:NewSpecialWarningMoveAwayCount(288212, nil, nil, nil, 1, 2)--NewSpecialWarningYouPos
local yellBroadside						= mod:NewPosYell(288212)
local yellBroadsideFades				= mod:NewIconFadesYell(288212)
local specWarnSiegebreaker				= mod:NewSpecialWarningMoveAwayCount(288374, nil, nil, nil, 3, 2)
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
local specWarnOrbofFrost				= mod:NewSpecialWarningCount(288619, nil, nil, nil, 2, 2)
local specWarnPrismaticImage			= mod:NewSpecialWarningSwitchCount(288747, nil, nil, 2, 1, 2)

--General
local timerPhaseTransition				= mod:NewPhaseTimer(55)
local timerHowlingWindsCD				= mod:NewCDCountTimer(80, 288169, nil, nil, nil, 6, nil, DBM_CORE_MYTHIC_ICON)--Mythic
local berserkTimer						= mod:NewBerserkTimer(900)
local timerIceBlockCD					= mod:NewTargetTimer(20, 287322, nil, nil, nil, 6)
--Stage One: Burning Seas
mod:AddTimerLine(DBM:EJ_GetSectionInfo(19557))
local timerCorsairCD					= mod:NewCDTimer(60.4, "ej19690", nil, nil, nil, 1, "2261243")
--local timerBombardCD					= mod:NewAITimer(55, 285828, nil, nil, nil, 3)
local timerAvalancheCD					= mod:NewCDTimer(60.7, 287565, nil, nil, 2, 5, nil, nil, true)
local timerGraspofFrostCD				= mod:NewCDTimer(17.3, 287626, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON, true)
local timerFreezingBlastCD				= mod:NewCDTimer(14, 285177, nil, "Tank", nil, 3, nil, nil, true)
local timerRingofIceCD					= mod:NewCDCountTimer(60.7, 285459, nil, nil, nil, 2, nil, DBM_CORE_IMPORTANT_ICON, true, 1, 4)
local timerFrozenSiegeCD				= mod:NewCDCountTimer(31.6, 289488, nil, nil, nil, 3, nil, nil, true)--Mythic
--Stage Two: Frozen Wrath
mod:AddTimerLine(DBM:EJ_GetSectionInfo(19565))
local timerBroadsideCD					= mod:NewCDCountTimer(31.3, 288212, nil, nil, nil, 3)
local timerSiegebreakerCD				= mod:NewCDCountTimer(59.9, 288374, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
--local timerHandofFrostCD				= mod:NewCDTimer(55, 288412, nil, nil, nil, 3)--Timer is only for first cast of phase, after that, can't tell cast from jump
local timerGlacialRayCD					= mod:NewCDCountTimer(49.8, 288345, nil, nil, nil, 3, nil, nil, true, 3, 3)--49.8-61.1 (can be delayed significantly by ice block
local timerIcefallCD					= mod:NewCDCountTimer(42.8, 288475, nil, nil, nil, 3, nil, DBM_CORE_HEROIC_ICON)
--local timerIcefall						= mod:NewCastTimer(55, 288475, nil, nil, nil, 3)
--Intermission 2
mod:AddTimerLine(DBM_CORE_INTERMISSION)
local timerHeartofFrostCD				= mod:NewCDTimer(6, 289220, nil, nil, nil, 3)
local timerWaterBoltVolleyCD			= mod:NewCDCountTimer(7.2, 290084, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
--Stage 3
mod:AddTimerLine(DBM:EJ_GetSectionInfo(19624))
local timerOrbofFrostCD					= mod:NewCDCountTimer(60, 288619, nil, nil, nil, 3, nil, DBM_CORE_HEROIC_ICON)
local timerPrismaticImageCD				= mod:NewCDCountTimer(41.3, 288747, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)
local timerCrystallineDustCD			= mod:NewCDCountTimer(14.1, 289940, nil, nil, 2, 5, nil, DBM_CORE_TANK_ICON, true)

mod:AddNamePlateOption("NPAuraOnMarkedTarget2", 288038, false)
mod:AddNamePlateOption("NPAuraOnTimeWarp", 287925)
mod:AddNamePlateOption("NPAuraOnRefractiveIce", 288219)
mod:AddNamePlateOption("NPAuraOnHowlingWinds2", 290053, false)
mod:AddSetIconOption("SetIconAvalanche", 287565, true, false, {1, 2, 3})
mod:AddSetIconOption("SetIconBroadside", 288212, true, false, {1, 2, 3})
mod:AddRangeFrameOption(10, 289379)
mod:AddInfoFrameOption(287993, true, 2)
mod:AddBoolOption("ShowOnlySummary2", true, "misc")
mod:AddBoolOption("SetWeather", true)
mod:AddMiscLine(DBM_CORE_OPTION_CATEGORY_DROPDOWNS)
mod:AddDropdownOption("InterruptBehavior", {"Three", "Four", "Five"}, "Three", "misc")

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
mod.vb.avalancheIcon = 0
mod.vb.waterboltVolleyCount = 0
mod.vb.howlingWindsCast = 0
mod.vb.frozenSiegeCount = 0
mod.vb.howlingRemaining = 0
mod.vb.interruptBehavior = "Three"
local ChillingTouchStacks = {}
local chillingCollector = {}
local graspActive = false
local castsPerGUID = {}
local rangeThreshold = 1
local fixStupid = {}
local CVAR1, CVAR2 = nil, nil

--/run DBM:GetModByName("2343"):TimerTestFunction(30)
--This will auto loop, just run it once and wait to see how keep timers behave.
--Grasp of frost and ring of ice will be two main ones to watch, they won't be "cast" again but every 30 seconds so a 15 and 20 second timer will be kept for 15 or 10 additional seconds.
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
--Just run to end loop and stop all timers
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

local function graspCollection(self, finish)
	if finish then
		graspActive = false
		if self:CheckDispelFilter() then
			specWarGraspofFrost:Show(table.concat(chillingCollector, "<, >"))
			specWarGraspofFrost:Play("helpdispel")
		end
	else
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
	self.vb.avalancheIcon = 0
	self.vb.howlingWindsCast = 0
	self.vb.frozenSiegeCount = 0
	self.vb.howlingRemaining = 0
	self.vb.interruptBehavior = self.Options.InterruptBehavior--Default it to whatever user has it set to, until group leader overrides it
	table.wipe(castsPerGUID)
	table.wipe(ChillingTouchStacks)
	table.wipe(chillingCollector)
	graspActive = false
	table.wipe(fixStupid)
	if self:IsMythic() then
		rangeThreshold = 1
		timerFrozenSiegeCD:Start(3.3-delay, 1)
		timerAvalancheCD:Start(13.4-delay)
		timerFreezingBlastCD:Start(8.6-delay)
		timerGraspofFrostCD:Start(23.5-delay)
		timerRingofIceCD:Start(60.7-delay, 1)
		timerHowlingWindsCD:Start(66.9, 1)
		berserkTimer:Start(720)
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(10, nil, nil, 1, true, nil, self.Options.ShowOnlySummary2)--Reverse checker, threshold 1 at start
		end
		self:RegisterShortTermEvents(
			"UNIT_POWER_FREQUENT player"
		)
	else
		timerAvalancheCD:Start(8.1-delay)
		timerFreezingBlastCD:Start(16.6-delay)
		timerGraspofFrostCD:Start(26.6-delay)
		timerRingofIceCD:Start(60.7-delay, 1)
		berserkTimer:Start(900)
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(287993))
		DBM.InfoFrame:Show(10, "table", ChillingTouchStacks, 1)
	end
	if self.Options.NPAuraOnMarkedTarget2 or self.Options.NPAuraOnTimeWarp or self.Options.NPAuraOnRefractiveIce or self.Options.NPAuraOnHowlingWinds2 then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
	--Group leader decides interrupt behavior
	if UnitIsGroupLeader("player") and not self:IsLFR() then
		if self.Options.InterruptBehavior == "Three" then
			self:SendSync("Three")
		elseif self.Options.InterruptBehavior == "Four" then
			self:SendSync("Four")
		elseif self.Options.InterruptBehavior == "Five" then
			self:SendSync("Five")
		end
	end
	if self.Options.SetWeather then
		CVAR1, CVAR2 = GetCVar("weatherDensity") or 2, GetCVar("RAIDweatherDensity") or 2--Non raid cvar is nil if 3 (default) and raid one is nil if 2 (default)
		SetCVar("weatherDensity", 0)
		SetCVar("RAIDweatherDensity", 0)
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
	if self.Options.NPAuraOnMarkedTarget2 or self.Options.NPAuraOnTimeWarp or self.Options.NPAuraOnRefractiveIce or self.Options.NPAuraOnHowlingWinds2 then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
	if CVAR1 or CVAR2 then
		SetCVar("weatherDensity", CVAR1)
		SetCVar("RAIDweatherDensity", CVAR2)
		CVAR1, CVAR2 = nil, nil
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 287565 then
		if self.vb.phase == 1 then
			self.vb.avalancheIcon = 0
			timerAvalancheCD:Start(self:IsMythic() and 45 or 60)
		else
			self.vb.avalancheIcon = 3
			timerAvalancheCD:Start(self:IsMythic() and 81.5 or 75)--75-90
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
	elseif spellId == 288221 and self:AntiSpam(3, 3) then
		warnBurningExplosion:Show()
	elseif spellId == 288345 and self:AntiSpam(4, 8) then
		self.vb.glacialRayCount = self.vb.glacialRayCount + 1
		specWarnGlacialRay:Show(self.vb.glacialRayCount)
		specWarnGlacialRay:Play("watchstep")
		local timer = self:IsMythic() and 40 or self.vb.phase == 2 and (self:IsLFR() and 60 or 49.8) or 60
		timerGlacialRayCD:Start(timer, self.vb.glacialRayCount+1)
		warnGlacialRay:Schedule(timer-5)
		warnGlacialRay:ScheduleVoice(timer-5, "bait")
	elseif spellId == 288441 and self:AntiSpam(6, 7) then
		self.vb.iceFallCount = self.vb.iceFallCount + 1
		specWarnIcefall:Show(self.vb.iceFallCount)
		specWarnIcefall:Play("watchstep")
		timerIcefallCD:Start(self:IsMythic() and 36.5 or self.vb.phase == 2 and (self:IsLFR() and 52.1 or 42.8) or 62, self.vb.iceFallCount+1)
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
		warnGlacialRay:Cancel()
		warnGlacialRay:CancelVoice()
		timerIcefallCD:Stop()
		--Infoframe closes during cut scenes, so we gotta make sure to recall this window
		if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() then
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
		if (self.vb.interruptBehavior == "Three" and castsPerGUID[args.sourceGUID] == 3) or (self.vb.interruptBehavior == "Four" and castsPerGUID[args.sourceGUID] == 4) or (self.vb.interruptBehavior == "Five" and castsPerGUID[args.sourceGUID] == 5) then
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
			else--Shouldn't happen, but fallback rules never hurt
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
		timerPrismaticImageCD:Start(self:IsLFR() and 51.1 or 41.3, self.vb.imageCount+1)
	elseif spellId == 289488 then--Frozen Siege
		self.vb.frozenSiegeCount = self.vb.frozenSiegeCount + 1
		warnFrozenSiege:Show(self.vb.frozenSiegeCount)
		timerFrozenSiegeCD:Start(nil, self.vb.frozenSiegeCount+1)
	elseif spellId == 289220 then
		self:ScheduleMethod(0.2, "BossTargetScanner", args.sourceGUID, "HeartofFrostTarget", 0.1, 8, true, nil, nil, nil, false)--Does this target tank? if not, change false to true
	elseif spellId == 287626 then
		table.wipe(chillingCollector)
		self:Unschedule(graspCollection)
		self:Schedule(1.9, graspCollection, self, false)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 285725 and self:AntiSpam(3, 5) then
		warnSetCharge:Show()
	elseif spellId == 287925 then
		warnTimeWarp:Show()
	elseif spellId == 287626 then
		if self:IsHard() then
			timerGraspofFrostCD:Start(17.3)
		end
		self:Schedule(0.1, graspCollection, self, true)
	elseif spellId == 289220 and args:GetSrcCreatureID() == 149144 then
		timerHeartofFrostCD:Start()
	elseif spellId == 288374 then
		self.vb.siegeCount = self.vb.siegeCount + 1
		timerSiegebreakerCD:Start(self:IsMythic() and 68.2 or self:IsLFR() and 70 or 59.9, self.vb.siegeCount+1)
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
				if amount >= 8 and not args:IsPlayer() and self.Options.SpecWarn285253taunt and not DBM:UnitDebuff("player", spellId) then
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
			if not tContains(chillingCollector, args.destName) then
				table.insert(chillingCollector, args.destName)
			end
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
			yellFreezingBlood:Countdown(spellId)
		end
	elseif spellId == 288038 then
		warnMarkedTarget:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			if self:AntiSpam(3, 2) then
				specWarnMarkedTarget:Show()
				specWarnMarkedTarget:Play("justrun")
				yellMarkedTarget:Yell()
			end
			if self.Options.NPAuraOnMarkedTarget2 then
				DBM.Nameplate:Show(true, args.sourceGUID, spellId, nil, 10)
			end
		end
	elseif spellId == 287925 then
		if self.Options.NPAuraOnTimeWarp then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId, nil, 40)
		end
	--elseif spellId == 287626 then
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
		--Infoframe closes during cut scenes, so we gotta make sure to recall this window
		if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() then
			DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(287993))
			DBM.InfoFrame:Show(5, "table", ChillingTouchStacks, 1)
		end
	elseif spellId == 288219 and not fixStupid[args.sourceGUID] then
		fixStupid[args.sourceGUID] = true
		if self.Options.NPAuraOnRefractiveIce then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId)
		end
	elseif spellId == 288212 then
		self.vb.broadsideIcon = self.vb.broadsideIcon + 1
		local icon = self.vb.broadsideIcon
		warnBroadside:CombinedShow(0.5, self.vb.broadsideCount, args.destName)
		if args:IsPlayer() then
			specWarnBroadside:Show(self.vb.broadsideCount)
			specWarnBroadside:Play("targetyou")
			yellBroadside:Yell(icon, icon, icon)
			yellBroadsideFades:Countdown(spellId, nil, icon)
		end
		if self.Options.SetIconBroadside then
			self:SetIcon(args.destName, icon)
		end
	elseif spellId == 288374 then
		if args:IsPlayer() then
			specWarnSiegebreaker:Show(self.vb.siegeCount)
			specWarnSiegebreaker:Play("runout")
			yellSiegebreaker:Yell()
			yellSiegebreakerFades:Countdown(spellId)
		else
			warnSiegebreaker:Show(self.vb.siegeCount, args.destName)
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
		self.vb.avalancheIcon = self.vb.avalancheIcon + 1
		local icon = self.vb.avalancheIcon
		if args:IsPlayer() then
			specWarnAvalanche:Show(self:IconNumToTexture(icon))
			specWarnAvalanche:Play("runout")
			yellAvalanche:Yell(icon, icon, icon)
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			if self:IsTanking(uId) then
				specWarnAvalancheTaunt:Show(args.destName)
				specWarnAvalancheTaunt:Play("tauntboss")
			end
		end
		if self.Options.SetIconAvalanche then
			self:SetIcon(args.destName, self.vb.avalancheIcon)
		end
	elseif spellId == 287322 then
		warnJainaIceBlocked:Show(args.destName)
		timerIceBlockCD:Start(args.destName)
	elseif spellId == 288169 and self:AntiSpam(10, 10) and self.vb.phase ~= 1.5 then--Howling Winds (Mythic)
		self.vb.howlingWindsCast = self.vb.howlingWindsCast + 1
		timerHowlingWindsCD:Start(80, self.vb.howlingWindsCast+1)
	elseif spellId == 290053 then--Howling Winds buff Images get
		self.vb.howlingRemaining = self.vb.howlingRemaining + 1
		if self.Options.NPAuraOnHowlingWinds2 then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId)
		end
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
		if self.Options.NPAuraOnMarkedTarget2 then
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
		warnGlacialRay:Schedule(1.6)
		warnGlacialRay:ScheduleVoice(1.6, "bait")
		timerAvalancheCD:Start(16.3)
		--timerHandofFrostCD:Start(21.5)--21.5-25.57
		timerIcefallCD:Start(30.2, 1)
		timerSiegebreakerCD:Start(40.3, 1)
		--Infoframe closes during cut scenes, so we gotta make sure to recall this window
		if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() then
			DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(287993))
			DBM.InfoFrame:Show(5, "table", ChillingTouchStacks, 1)
		end
		if self:IsMythic() and self:AntiSpam(10, 10) then--Antispam to ignore applied from howling winds right at end of 1.5
			timerHowlingWindsCD:Start(68.1, self.vb.howlingWindsCast+1)
		end
	elseif spellId == 288219 then
		if self.Options.NPAuraOnRefractiveIce then
			DBM.Nameplate:Hide(true, args.sourceGUID)--Passed without spellId/tecture to force remove all, in event there are multiple (shouldn't be but doesn't hurt)
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
		timerBroadsideCD:Start(self:IsEasy() and 14.6 or 19.7, 1)--SUCCESS, Comes 5 seconds earlier in LFR/Normal do to no orb of frost
		timerPrismaticImageCD:Start(self:IsEasy() and 12.4 or 22.4, 1)--Comes 10 seconds earlier in LFR/normal do to no orb of frost
		timerCrystallineDustCD:Start(25, 1)
		timerGlacialRayCD:Start(48.6, 1)
		warnGlacialRay:Schedule(43.6)
		warnGlacialRay:ScheduleVoice(43.6, "bait")
		timerSiegebreakerCD:Start(58.4, 1)--to CLEU event, emote 1 second faster, may change
		timerIcefallCD:Start(60.2, 1)
		if self:IsHard() then
			timerOrbofFrostCD:Start(11, 1)
		end
		--Infoframe closes during cut scenes, so we gotta make sure to recall this window
		if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() then
			DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(287993))
			DBM.InfoFrame:Show(5, "table", ChillingTouchStacks, 1)
		end
	elseif spellId == 289387 then
		if args:IsPlayer() then
			yellFreezingBlood:Cancel()
		end
	elseif spellId == 287322 then
		timerIceBlockCD:Stop(args.destName)
	elseif spellId == 285254 then
		if self.Options.SetIconAvalanche then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 290053 then--Howling Winds buff Images get
		self.vb.howlingRemaining = self.vb.howlingRemaining - 1
		warnHowlingWindsLeft:Show(self.vb.howlingRemaining)
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
	if cid == 149144 or cid == 149558 then--Jaina's Tide Elemental
		castsPerGUID[args.destGUID] = nil
		timerHeartofFrostCD:Stop()
		timerWaterBoltVolleyCD:Stop()
	elseif cid == 148965 then--Kul Tiran Marine
		if self.Options.NPAuraOnMarkedTarget2 then
			DBM.Nameplate:Hide(true, args.destGUID)
		end
	elseif cid == 149535 then--Icebound Image
		if self.Options.NPAuraOnHowlingWinds2 then
			DBM.Nameplate:Hide(true, args.destGUID)
		end
	elseif cid == 148631 then--Unexploded Ordinance
		if self.Options.NPAuraOnRefractiveIce then
			DBM.Nameplate:Hide(true, args.destGUID)
		end
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if msg:find(L.Port) then
		warnCorsair:Show(L.Port)
		warnCorsair:Play("killmob")
	elseif msg:find(L.Starboard) then
		warnCorsair:Show(L.Starboard)
		warnCorsair:Play("killmob")
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	--"<11.40 22:23:57> [UNIT_SPELLCAST_SUCCEEDED] Lady Jaina Proudmoore(Murdina) -Corsair Picker- [[boss1:Cast-3-3133-2070-28514-288013-002BCFC74D:288013]]", -- [110]
	--"<25.44 22:24:11> [CHAT_MSG_RAID_BOSS_EMOTE] A Kul Tiran Corsair approaches on the port side!#Kul Tiran Corsair###Apookie##0#0##0#2952#nil#0#false#false#false#false", -- [295]
	if spellId == 288013 then--Corsair Picker (fires 12-14 seconds before emote does)
		warnCorsairSoon:Show()
		warnCorsairSoon:Play("mobsoon")
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
		timerPhaseTransition:Start(12.5)
	end
end

function mod:UNIT_POWER_FREQUENT(uId, type)
	if type == "ALTERNATE" then
		local altPower = UnitPower(uId, 10)
		if rangeThreshold < 3 and altPower >= 75 then
			rangeThreshold = 3
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10, nil, nil, 5, true, nil, self.Options.ShowOnlySummary2)--Reverse checker, threshold 5
			end
			self:UnregisterShortTermEvents()
		elseif rangeThreshold < 2 and altPower >=50 then
			rangeThreshold = 2
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10, nil, nil, 3, true, nil, self.Options.ShowOnlySummary2)--Reverse checker, threshold 3
			end
		elseif rangeThreshold > 1 and altPower < 50 then
			rangeThreshold = 1
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10, nil, nil, 1, true, nil, self.Options.ShowOnlySummary2)--Reverse checker, threshold 1
			end
		end
	end
end

function mod:OnSync(msg)
	if self:IsLFR() then return end
	if msg == "Three" then
		self.vb.interruptBehavior = "Three"
	elseif msg == "Four" then
		self.vb.interruptBehavior = "Four"
	elseif msg == "Five" then
		self.vb.interruptBehavior = "Five"
	end
end
