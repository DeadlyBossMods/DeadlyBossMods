local mod	= DBM:NewMod(2025, "DBM-AntorusBurningThrone", nil, 946)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(124445)
mod:SetEncounterID(2075)
mod:SetZone()
--mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(1, 2, 3, 4, 5, 6)
mod:SetHotfixNoticeRev(16960)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 249121 250701",
	"SPELL_CAST_SUCCESS 246753 254769 250048",
	"SPELL_AURA_APPLIED 250074 250555 249016 248332 250073 250693 250691 250140",
	"SPELL_AURA_APPLIED_DOSE 250140",
	"SPELL_AURA_REMOVED 250074 250555 249016 248332 250693 250691",
--	"SPELL_DAMAGE 248329",
--	"SPELL_MISSED 248329",
	"UNIT_DIED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5",
	"UNIT_SPELLCAST_CHANNEL_STOP boss1 boss2 boss3 boss4 boss5",
	"UNIT_SPELLCAST_STOP boss1 boss2 boss3 boss4 boss5"
)

--TODO, verify Meteor Storm in LFR
--[[
(ability.id = 249121 or ability.id = 250048) and type = "begincast"
 or (ability.id = 246753 or ability.id = 254769 or ability.id = 250048) and type = "cast"
 or (ability.id = 248332) and type = "applydebuff"
 or (ability.id = 250073) and type = "applybuff"
 or target.name = "Volant Kerapteron"
 or target.id = 124445 and ability.id = 250030
 
4 Life Force LFR Logs, and slower add spawn rates:
https://www.warcraftlogs.com/reports/bWwmdJ8gCkcP1BYF#fight=1&type=summary&view=events&pins=2%24Off%24%23244F4B%24expression%24(ability.id%20%3D%20249121%20or%20ability.id%20%3D%20250048)%20and%20type%20%3D%20%22begincast%22%20%20or%20(ability.id%20%3D%20246753%20or%20ability.id%20%3D%20254769)%20and%20type%20%3D%20%22cast%22%20%20or%20(ability.id%20%3D%20248332)%20and%20type%20%3D%20%22applydebuff%22%20%20or%20(ability.id%20%3D%20250073)%20and%20type%20%3D%20%22applybuff%22%20%20or%20target.name%20%3D%20%22Volant%20Kerapteron%22
https://www.warcraftlogs.com/reports/RcjbYJQHWNCt41Fm#fight=24&type=summary&pins=2%24Off%24%23244F4B%24expression%24(ability.id%20%3D%20249121%20or%20ability.id%20%3D%20250048)%20and%20type%20%3D%20%22begincast%22%20%20or%20(ability.id%20%3D%20246753%20or%20ability.id%20%3D%20254769)%20and%20type%20%3D%20%22cast%22%20%20or%20(ability.id%20%3D%20248332)%20and%20type%20%3D%20%22applydebuff%22%20%20or%20(ability.id%20%3D%20250073)%20and%20type%20%3D%20%22applybuff%22%20%20or%20target.name%20%3D%20%22Volant%20Kerapteron%22&view=events
3 Life Force LFR Logs, with faster add spawn rates:
https://www.warcraftlogs.com/reports/9xkDgRXYLtzb1Bnq#fight=2&type=summary&view=events&pins=2%24Off%24%23244F4B%24expression%24(ability.id%20%3D%20249121%20or%20ability.id%20%3D%20250048)%20and%20type%20%3D%20%22begincast%22%20%20or%20(ability.id%20%3D%20246753%20or%20ability.id%20%3D%20254769)%20and%20type%20%3D%20%22cast%22%20%20or%20(ability.id%20%3D%20248332)%20and%20type%20%3D%20%22applydebuff%22%20%20or%20(ability.id%20%3D%20250073)%20and%20type%20%3D%20%22applybuff%22%20%20or%20target.name%20%3D%20%22Volant%20Kerapteron%22
https://www.warcraftlogs.com/reports/V1dPgAZtFLwq2HDz#fight=8&type=summary&view=events&pins=2%24Off%24%23244F4B%24expression%24(ability.id%20%3D%20249121%20or%20ability.id%20%3D%20250048)%20and%20type%20%3D%20%22begincast%22%20%20or%20(ability.id%20%3D%20246753%20or%20ability.id%20%3D%20254769)%20and%20type%20%3D%20%22cast%22%20%20or%20(ability.id%20%3D%20248332)%20and%20type%20%3D%20%22applydebuff%22%20%20or%20(ability.id%20%3D%20250073)%20and%20type%20%3D%20%22applybuff%22%20%20or%20target.name%20%3D%20%22Volant%20Kerapteron%22
--]]
--The Paraxis
local warnRainofFel						= mod:NewTargetCountAnnounce(248332, 2)
local warnWarpIn						= mod:NewTargetAnnounce(246888, 3, nil, nil, nil, nil, nil, 2, true)
local warnLifeForce						= mod:NewCountAnnounce(250048, 1)

--The Paraxis
local specWarnSpearofDoom				= mod:NewSpecialWarningDodge(248789, nil, nil, nil, 2, 2)
--local yellSpearofDoom					= mod:NewYell(248789)
local specWarnRainofFel					= mod:NewSpecialWarningMoveAway(248332, nil, nil, 2, 1, 2)
local yellRainofFel						= mod:NewYell(248332)
local yellRainofFelFades				= mod:NewShortFadesYell(248332)
--Adds
local specWarnSwing						= mod:NewSpecialWarningDodge(250701, "MeleeDps", nil, nil, 1, 2)
--local yellBurstingDreadflame			= mod:NewPosYell(238430, DBM_CORE_AUTO_YELL_CUSTOM_POSITION)
--local specWarnMalignantAnguish		= mod:NewSpecialWarningInterrupt(236597, "HasInterrupt")
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)
--Mythic
local specWarnFinalDoom					= mod:NewSpecialWarningCount(249121, "-Tank", nil, nil, 1, 2)
local specWarnArcaneBuildup				= mod:NewSpecialWarningMoveAway(250693, nil, nil, nil, 1, 2)
local yellArcaneBuildup					= mod:NewYell(250693)
local yellArcaneBuildupFades			= mod:NewShortFadesYell(250693)
local specWarnBurningEmbers				= mod:NewSpecialWarningMoveAway(250691, nil, nil, nil, 1, 2)
local yellBurningEmbers					= mod:NewYell(250691)
local yellBurningEmbersFades			= mod:NewShortFadesYell(250691)
local specWarnFoulSteps					= mod:NewSpecialWarningStack(250140, nil, 12, nil, nil, 1, 6)--Fine tune

--The Paraxis
mod:AddTimerLine(GENERAL)
local timerSpearofDoomCD				= mod:NewCDCountTimer(55, 248789, nil, nil, nil, 3)--55-69
local timerRainofFelCD					= mod:NewCDCountTimer(61, 248332, nil, nil, nil, 3)
mod:AddTimerLine(DBM_ADDS)
local timerDestructorCD					= mod:NewTimer(90, "timerDestructor", 254769, nil, nil, 1, nil, DBM_CORE_TANK_ICON)
local timerObfuscatorCD					= mod:NewTimer(90, "timerObfuscator", 246753, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)
local timerPurifierCD					= mod:NewTimer(90, "timerPurifier", 250074, nil, nil, 1, nil, DBM_CORE_TANK_ICON)
local timerBatsCD						= mod:NewTimer(90, "timerBats", 242080, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)
--Mythic
mod:AddTimerLine(ENCOUNTER_JOURNAL_SECTION_FLAG12)
local timerFinalDoom					= mod:NewCastTimer(50, 249121, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)
local timerFinalDoomCD					= mod:NewCDCountTimer(90, 249121, nil, nil, nil, 4, nil, DBM_CORE_HEROIC_ICON)

--local berserkTimer					= mod:NewBerserkTimer(600)

--The Paraxis
--local countdownRainofFel				= mod:NewCountdown("Alt60", 248332)--Not accurate enough yet. not until timer correction is added to handle speed of raids dps affecting sequence
--Mythic
local countdownFinalDoom				= mod:NewCountdown("AltTwo90", 249121)

mod:AddSetIconOption("SetIconOnFeedbackTargeted2", 249016, false)
mod:AddInfoFrameOption(250030, true)
mod:AddNamePlateOption("NPAuraOnPurification", 250074)
mod:AddNamePlateOption("NPAuraOnFelShielding", 250555)
mod:AddRangeFrameOption("8/10")

mod.vb.rainOfFelCount = 0
mod.vb.lifeForceCast = 0
mod.vb.lifeRequired = 5
mod.vb.spearCast = 0
mod.vb.finalDoomCast = 0
mod.vb.destructors = 0
mod.vb.obfuscators = 0
mod.vb.purifiers = 0
--Timers combine multi sets,counts above do not combine cause for info frame
mod.vb.destructorCast = 0
mod.vb.obfuscatorCast = 0
mod.vb.purifierCast = 0
mod.vb.batCast = 0
mod.vb.targetedIcon = 1
local normalRainOfFelTimers = {}--PTR, recheck
local heroicRainOfFelTimers = {9.3, 43, 10, 43, 20, 19, 20, 29.2, 45, 25, 99}--Live, Dec 26
local mythicRainOfFelTimers = {6, 23.1, 24.1, 49.2, 25, 49.3, 15, 46.2, 24, 49.2, 24.1, 49.2, 50}--Live, Dec 14
--local mythicSpearofDoomTimers = {}
local heroicSpearofDoomTimers = {35, 59.2, 64.3, 40, 84.7, 34.1, 65.2}--Live, Nov 29
local finalDoomTimers = {59.3, 122.7, 99.5, 104.6, 99.6}--Live, Dec 5
local lfrDestructors = {21.5, 51.9, 50.3, 64.3, 107.2, 58.2, 44.1, 46.2, 44.2}--4 Life Force LFR Version
local lfrDestructors2 = {21.2, 43.8, 39.0, 51.1, 37.0, 53.0, 43.6, 45.2, 43.2}--3 Life force LFR version
local normalDestructors = {17, 46.2, 32, 52.4, 93.7, 40.9, 50.2, 55.4, 49.2}--Live, Dec 01. Old 17, 39.4, 28, 44.2, 92.4, 41.3, 50, 53.4, 48.1
local heroicDestructors = {15.7, 35.3, 40.6, 104.6, 134.7, 99.6}
local mythicDestructors = {27, 18, 87.4, 288.4, 20, 79}--Changed Dec 12th
local normalObfuscators = {193}--Live, Dec 01
local heroicObfuscators = {80.6, 148.5, 94.7, 99.9}
local mythicObfuscators = {46, 243, 43.8, 90.8}
local heroicPurifiers = {125, 66.1, 30.6}
local mythicPurifiers = {65.7, 82.6, 66.9, 145.7}
local heroicBats = {170, 125, 105, 105}--170, 295, 405, 510 (probably way off for 3rd and 4th because the heroic logs with long pulls are shit showa of terrible and unware dps that don't hit bats until they are in middle of path)
local mythicBats = {195, 79.9, 100, 100}--195, 275, 375, 475
local warnedAdds = {}
local addCountToLocationMythic = {
	["Dest"] = {DBM_CORE_MIDDLE, DBM_CORE_TOP, DBM_CORE_BOTTOM, DBM_CORE_MIDDLE, DBM_CORE_TOP, DBM_CORE_MIDDLE},
	["Obfu"] = {DBM_CORE_BOTTOM, DBM_CORE_MIDDLE, DBM_CORE_TOP, DBM_CORE_BOTTOM},
	["Pur"] = {DBM_CORE_MIDDLE, DBM_CORE_MIDDLE, DBM_CORE_BOTTOM, DBM_CORE_TOP}
}
local addCountToLocationHeroic = {
	["Dest"] = {DBM_CORE_MIDDLE, DBM_CORE_BOTTOM, DBM_CORE_TOP, DBM_CORE_BOTTOM, DBM_CORE_MIDDLE.."/"..DBM_CORE_TOP, DBM_CORE_MIDDLE.."/"..DBM_CORE_TOP},
	["Obfu"] = {DBM_CORE_TOP, DBM_CORE_MIDDLE, DBM_CORE_BOTTOM, DBM_CORE_BOTTOM},
	["Pur"] = {DBM_CORE_MIDDLE, DBM_CORE_BOTTOM, DBM_CORE_MIDDLE}
}
local addCountToLocationNormal = {
	["Dest"] = {DBM_CORE_MIDDLE, DBM_CORE_BOTTOM, DBM_CORE_MIDDLE, DBM_CORE_TOP, DBM_CORE_BOTTOM, DBM_CORE_TOP, DBM_CORE_MIDDLE, DBM_CORE_TOP, DBM_CORE_MIDDLE},
	["Obfu"] = {DBM_CORE_MIDDLE}
}
local addCountToLocationLFR = {
	["Dest"] = {DBM_CORE_MIDDLE, DBM_CORE_BOTTOM, DBM_CORE_TOP, DBM_CORE_MIDDLE, DBM_CORE_BOTTOM, DBM_CORE_TOP,DBM_CORE_BOTTOM, DBM_CORE_TOP, DBM_CORE_BOTTOM}
}

local lifeForceName = DBM:GetSpellInfo(250048)
local updateInfoFrame
do
	local lines = {}
	local sortedLines = {}
	local function addLine(key, value)
		-- sort by insertion order
		lines[key] = value
		sortedLines[#sortedLines + 1] = key
	end
	updateInfoFrame = function()
		table.wipe(lines)
		table.wipe(sortedLines)
		--Boss Powers first
		local cid = mod:GetUnitCreatureId("boss1") or 0
		if cid ~= 124445 then--Filter Paraxus
			local currentPower = UnitPower("boss1", 10) or 0
			local currentHealth = (UnitHealth("boss1")/UnitHealthMax("boss1") * 100) or 100
			addLine(L.EonarHealth, math.floor(currentHealth).."%")
			addLine(L.EonarPower, currentPower)
		end
		local cid2 = mod:GetUnitCreatureId("boss2") or 0
		if cid2 ~= 124445 then--Filter Paraxus
			local currentPower = UnitPower("boss2", 10) or 0
			local currentHealth = (UnitHealth("boss2")/UnitHealthMax("boss2") * 100) or 100
			addLine(L.EonarHealth, math.floor(currentHealth).."%")
			addLine(L.EonarPower, currentPower.."%")
		end
		addLine(lifeForceName, mod.vb.lifeForceCast.."/"..mod.vb.lifeRequired)
		if mod:IsLFR() then
			local nextLocation = addCountToLocationLFR["Dest"][mod.vb.destructorCast+1]
			if nextLocation then
				addLine(L.NextLoc, nextLocation)
			end
		end
		if mod.vb.obfuscators > 0 then
			addLine(L.Obfuscators, mod.vb.obfuscators)
		end
		if mod.vb.destructors > 0 then
			addLine(L.Destructors, mod.vb.destructors)
		end
		if mod.vb.purifiers > 0 then
			addLine(L.Purifiers, mod.vb.purifiers)
		end
		return lines, sortedLines
	end
end

--This is backup for fixing timers if destructors die before they ever cast high alert, such as massively overgearing encounter and able to burn it down in less than 10 seconds
local function checkForDeadDestructor(self, forceStart)
	self:Unschedule(checkForDeadDestructor)
	self.vb.destructorCast = self.vb.destructorCast + 1
	local timer = self:IsMythic() and mythicDestructors[self.vb.destructorCast+1] or self:IsHeroic() and heroicDestructors[self.vb.destructorCast+1] or self:IsNormal() and normalDestructors[self.vb.destructorCast+1] or self:IsLFR() and lfrDestructors2[self.vb.destructorCast+1]
	if forceStart then
		DBM:Debug("checkForDeadDestructor ran with forceStart arg for "..self.vb.destructorCast, 2)
		local text = self:IsHeroic() and addCountToLocationHeroic["Dest"][self.vb.destructorCast+1] or self:IsNormal() and addCountToLocationNormal["Dest"][self.vb.destructorCast+1] or self:IsMythic() and addCountToLocationMythic["Dest"][self.vb.destructorCast+1] or self:IsLFR() and addCountToLocationLFR["Dest"][self.vb.destructorCast+1] or self.vb.destructorCast+1
		timerDestructorCD:Start(forceStart, text)--Minus 10 for being 10 seconds after high alert, and minus 10 for wanting when it spawns not high alert cast
		self:Schedule(forceStart+20, checkForDeadDestructor, self)--10 seconds after high alert
	elseif timer then
		local text = self:IsHeroic() and addCountToLocationHeroic["Dest"][self.vb.destructorCast+1] or self:IsNormal() and addCountToLocationNormal["Dest"][self.vb.destructorCast+1] or self:IsMythic() and addCountToLocationMythic["Dest"][self.vb.destructorCast+1] or self:IsLFR() and addCountToLocationLFR["Dest"][self.vb.destructorCast+1] or self.vb.destructorCast+1
		timerDestructorCD:Start(timer-20, text)--Minus 10 for being 10 seconds after high alert, and minus 10 for wanting when it spawns not high alert cast
		self:Schedule(timer, checkForDeadDestructor, self)--10 seconds after high alert
	end
	DBM:Debug("checkForDeadDestructor ran, which means a destructor died before casting high alert, or DBM has a timer error near: "..self.vb.destructorCast, 2)
end

local function startBatsStuff(self)
	self.vb.batCast = self.vb.batCast + 1
	warnWarpIn:Show(L.Bats)
	warnWarpIn:Play("killmob")
	local timer = self:IsMythic() and mythicBats[self.vb.batCast+1] or self:IsHeroic() and heroicBats[self.vb.batCast+1]
	if timer then
		timerBatsCD:Start(timer, self.vb.batCast+1)
		self:Schedule(timer, startBatsStuff, self)
	end
end

function mod:OnCombatStart(delay)
	lifeForceName = DBM:GetSpellInfo(250048)
	self.vb.rainOfFelCount = 0
	self.vb.destructors = 0
	self.vb.obfuscators = 0
	self.vb.purifiers = 0
	self.vb.destructorCast = 0
	self.vb.obfuscatorCast = 0
	self.vb.purifierCast = 0
	self.vb.batCast = 0
	self.vb.lifeForceCast = 0
	self.vb.spearCast = 0
	self.vb.finalDoomCast = 0
	self.vb.targetedIcon = 1
	if not self:IsLFR() then
		self.vb.lifeRequired = 4
		if self:IsMythic() then
			timerRainofFelCD:Start(6-delay, 1)
			--countdownRainofFel:Start(6-delay)
			--timerSpearofDoomCD:Start(35-delay, 1)
			timerDestructorCD:Start(17, DBM_CORE_MIDDLE)
			self:Schedule(30, checkForDeadDestructor, self, 5)
			timerObfuscatorCD:Start(46, DBM_CORE_BOTTOM)
			timerPurifierCD:Start(65.7, DBM_CORE_MIDDLE)
			timerFinalDoomCD:Start(59.3-delay, 1)
			countdownFinalDoom:Start(59.3-delay)
			timerBatsCD:Start(195, 1)
			self:Schedule(195, startBatsStuff, self)
		elseif self:IsHeroic() then
			timerRainofFelCD:Start(9.3-delay, 1)
			--countdownRainofFel:Start(9.3-delay)
			timerDestructorCD:Start(7, DBM_CORE_MIDDLE)
			self:Schedule(27, checkForDeadDestructor, self)
			timerSpearofDoomCD:Start(34-delay, 1)
			timerObfuscatorCD:Start(80.6, DBM_CORE_TOP)
			timerPurifierCD:Start(125, DBM_CORE_MIDDLE)
			timerBatsCD:Start(170, 1)
			self:Schedule(170, startBatsStuff, self)
		else--Normal
			timerDestructorCD:Start(7, DBM_CORE_MIDDLE)
			self:Schedule(27, checkForDeadDestructor, self)
			timerObfuscatorCD:Start(174, 1)
			--timerRainofFelCD:Start(30-delay, 1)
			--countdownRainofFel:Start(30-delay)
		end
	else
		self.vb.lifeRequired = 3
		timerDestructorCD:Start(12, DBM_CORE_MIDDLE)
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Show(7, "function", updateInfoFrame, false, false)
	end
	if self.Options.NPAuraOnPurification or self.Options.NPAuraOnFelShielding then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	table.wipe(warnedAdds)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.NPAuraOnPurification or self.Options.NPAuraOnFelShielding then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 249121 then
		self.vb.finalDoomCast = self.vb.finalDoomCast + 1
		specWarnFinalDoom:Show(self.vb.finalDoomCast)
		specWarnFinalDoom:Play("specialsoon")
		timerFinalDoom:Start()
		local timer = finalDoomTimers[self.vb.finalDoomCast+1]
		if timer then
			timerFinalDoomCD:Start(timer, self.vb.finalDoomCast+1)
			countdownFinalDoom:Start(timer)
		end
	elseif spellId == 250701 and self:CheckInterruptFilter(args.sourceGUID, true) then
		specWarnSwing:Show()
		specWarnSwing:Play("watchstep")

	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 246753 and not warnedAdds[args.sourceGUID] then--Cloak
		warnedAdds[args.sourceGUID] = true
		self.vb.obfuscators = self.vb.obfuscators + 1
		if self:AntiSpam(5, args.sourceName) then
			warnWarpIn:Show(L.Obfuscators)
			warnWarpIn:Play("bigmob")
			self.vb.obfuscatorCast = self.vb.obfuscatorCast + 1
			local timer = self:IsMythic() and mythicObfuscators[self.vb.obfuscatorCast+1] or self:IsHeroic() and heroicObfuscators[self.vb.obfuscatorCast+1] or self:IsNormal() and normalObfuscators[self.vb.obfuscatorCast+1]
			if timer then
				local text = self:IsHeroic() and addCountToLocationHeroic["Obfu"][self.vb.obfuscatorCast+1] or self:IsNormal() and addCountToLocationNormal["Obfu"][self.vb.obfuscatorCast+1] or self:IsMythic() and addCountToLocationMythic["Obfu"][self.vb.obfuscatorCast+1] or self.vb.obfuscatorCast+1
				timerObfuscatorCD:Start(timer, text)
			end
		end
	elseif spellId == 254769 and args:GetSrcCreatureID() == 123760 and not warnedAdds[args.sourceGUID] then--High Alert
		warnedAdds[args.sourceGUID] = true
		self:Unschedule(checkForDeadDestructor)
		self.vb.destructors = self.vb.destructors + 1
		if self:AntiSpam(5, args.sourceName) then
			warnWarpIn:Show(L.Destructors)
			warnWarpIn:Play("bigmob")
			self.vb.destructorCast = self.vb.destructorCast + 1
			local timer = self:IsMythic() and mythicDestructors[self.vb.destructorCast+1] or self:IsHeroic() and heroicDestructors[self.vb.destructorCast+1] or self:IsNormal() and normalDestructors[self.vb.destructorCast+1] or self:IsLFR() and lfrDestructors2[self.vb.destructorCast+1]
			if timer then
				local text = self:IsHeroic() and addCountToLocationHeroic["Dest"][self.vb.destructorCast+1] or self:IsNormal() and addCountToLocationNormal["Dest"][self.vb.destructorCast+1] or self:IsMythic() and addCountToLocationMythic["Dest"][self.vb.destructorCast+1] or self:IsLFR() and addCountToLocationLFR["Dest"][self.vb.destructorCast+1] or self.vb.destructorCast+1
				if not self:IsLFR() then--This work around doesn't work in LFR because if dps is slow LFR massively slows down spawns to help out
					self:Schedule(timer+10, checkForDeadDestructor, self)
				else
					timerDestructorCD:Stop()--Because of way LFR works, we need to do timer cleanup if they come earlier than expected
				end
				timerDestructorCD:Start(timer-10, text)--High alert fires about 9 seconds after spawn so using it as a trigger has a -10 adjustment
			end
		end
	elseif spellId == 250048 then
		self.vb.lifeForceCast = self.vb.lifeForceCast + 1
		warnLifeForce:Show(self.vb.lifeForceCast)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 250073 and not warnedAdds[args.sourceGUID] then--Purification (buff on purifier)
		warnedAdds[args.sourceGUID] = true
		self.vb.purifiers = self.vb.purifiers + 1
		if self:AntiSpam(5, 2) then
			warnWarpIn:Show(L.Purifiers)
			warnWarpIn:Play("bigmob")
			self.vb.purifierCast = self.vb.purifierCast + 1
			local timer = self:IsMythic() and mythicPurifiers[self.vb.purifierCast+1] or self:IsHeroic() and heroicPurifiers[self.vb.purifierCast+1]
			if timer then
				local text = self:IsHeroic() and addCountToLocationHeroic["Pur"][self.vb.purifierCast+1] or self:IsNormal() and addCountToLocationNormal["Pur"][self.vb.purifierCast+1] or self:IsMythic() and addCountToLocationMythic["Pur"][self.vb.purifierCast+1] or self.vb.purifierCast+1
				timerPurifierCD:Start(timer, text)
			end
		end
	elseif spellId == 250074 then--Purification (buff on enemies near purifier)
		if self.Options.NPAuraOnPurification then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 250555 then--Fel Shielding
		if self.Options.NPAuraOnFelShielding then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 249016 then
		if self.Options.SetIconOnFeedbackTargeted2 then
			self:SetIcon(args.destName, self.vb.targetedIcon)
		end
		self.vb.targetedIcon = self.vb.targetedIcon + 1
	elseif spellId == 248332 then--Rain of Fel
		warnRainofFel:CombinedShow(1, self.vb.rainOfFelCount, args.destName)
		if self:AntiSpam(10, 4) then
			self.vb.rainOfFelCount = self.vb.rainOfFelCount + 1
			local timer = self:IsMythic() and mythicRainOfFelTimers[self.vb.rainOfFelCount+1] or self:IsHeroic() and heroicRainOfFelTimers[self.vb.rainOfFelCount+1] or self:IsNormal() and normalRainOfFelTimers[self.vb.rainOfFelCount+1]
			if timer then
				timerRainofFelCD:Start(timer, self.vb.rainOfFelCount+1)
				--countdownRainofFel:Start(timer)
			end
		end
		if args:IsPlayer() then
			specWarnRainofFel:Show()
			specWarnRainofFel:Play("scatter")
			yellRainofFel:Yell()
			yellRainofFelFades:Countdown(5)
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		end
	elseif spellId == 250693 then--Arcane Buildup
		if args:IsPlayer() then
			specWarnArcaneBuildup:Show()
			specWarnArcaneBuildup:Play("runout")
			yellArcaneBuildup:Yell()
			yellArcaneBuildupFades:Countdown(5, 4)
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10)
			end
		end
	elseif spellId == 250691 then --Burning Embers
		if args:IsPlayer() then
			specWarnBurningEmbers:Show()
			specWarnBurningEmbers:Play("runout")
			yellBurningEmbers:Yell()
			yellBurningEmbersFades:Countdown(5, 4)
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		end
	elseif spellId == 250140 then--Foul Steps
		if args:IsPlayer() then
			local amount = args.amount or 1
			if amount >= 12 and amount % 4 == 0 then
				specWarnFoulSteps:Show(amount)
				specWarnFoulSteps:Play("stackhigh")
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 250074 then--Purification
		if self.Options.NPAuraOnPurification then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 250555 then--Fel Shielding
		if self.Options.NPAuraOnFelShielding then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 249016 then
		if self.Options.SetIconOnFeedbackTargeted2 then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 248332 then--Rain of Fel
		if args:IsPlayer() then
			yellRainofFelFades:Cancel()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
	elseif spellId == 250693 then--Arcane Buildup
		if args:IsPlayer() then
			yellArcaneBuildupFades:Cancel()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
	elseif spellId == 250691 then --Burning Embers
		if args:IsPlayer() then
			yellBurningEmbersFades:Cancel()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 124207 and self.vb.obfuscators > 0 then--Fel-Charged Obfuscator
		self.vb.obfuscators = self.vb.obfuscators - 1
	elseif cid == 123760 then 
		if warnedAdds[args.destGUID] and self.vb.destructors > 0 then--Fel-Infused Destructor
			self.vb.destructors = self.vb.destructors - 1
		end
	elseif cid == 123726 and self.vb.purifiers > 0 then--Fel-Infused Purifier
		self.vb.purifiers = self.vb.purifiers - 1
	end
end

--[[
function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 248329 and self:AntiSpam(5, 4) then

	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE
--]]

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if msg:find("spell:248861") then
		self.vb.spearCast = self.vb.spearCast + 1
		specWarnSpearofDoom:Show()
		specWarnSpearofDoom:Play("watchstep")
		local timer = self:IsHeroic() and heroicSpearofDoomTimers[self.vb.spearCast+1]
		if timer then
			timerSpearofDoomCD:Start(timer, self.vb.spearCast+1)
		end
	end
end

function mod:UNIT_SPELLCAST_CHANNEL_STOP(uId, _, _, _, spellId)
	if spellId == 249121 then
		timerFinalDoom:Stop()
	end
end
mod.UNIT_SPELLCAST_STOP = mod.UNIT_SPELLCAST_CHANNEL_STOP
