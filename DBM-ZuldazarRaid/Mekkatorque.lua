local mod	= DBM:NewMod(2334, "DBM-ZuldazarRaid", 3, 1176)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(144796)
mod:SetEncounterID(2276)
--mod:DisableESCombatDetection()
mod:SetZone()
--mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 2, 1)
mod:SetHotfixNoticeRev(18349)
--mod:SetMinSyncRevision(16950)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 282205 287952 287929 282153 288410 287751 287797 287757 286693 288041 288049 289537 287691 286597 289864 289870",
	"SPELL_CAST_SUCCESS 287757 286597 286152 286219 286215 286226 286192",
	"SPELL_AURA_APPLIED 287757 287167 284168 289023 286051 289699 286646 282406 286105 287114",
	"SPELL_AURA_APPLIED_DOSE 289699",
	"SPELL_AURA_REMOVED 287757 284168 286646 286105"
)

--[[
(ability.id = 282205 or ability.id = 287952 or ability.id = 287929 or ability.id = 282153 or ability.id = 288410 or ability.id = 287751 or ability.id = 287797 or ability.id = 286693 or ability.id = 288041 or ability.id = 288049 or ability.id = 289537 or ability.id = 287691) and type = "begincast"
 or (ability.id = 287757 or ability.id = 286597) and type = "cast"
--]]
--https://www.warcraftlogs.com/reports/3tgVRc1ZdApqw8yT#fight=13&view=events&pins=2%24Off%24%23244F4B%24expression%24(ability.id%20%3D%20282205%20or%20ability.id%20%3D%20287952%20or%20ability.id%20%3D%20287929%20or%20ability.id%20%3D%20282153%20or%20ability.id%20%3D%20288410%20or%20ability.id%20%3D%20287751%20or%20ability.id%20%3D%20287797%20or%20ability.id%20%3D%20286693%20or%20ability.id%20%3D%20288041%20or%20ability.id%20%3D%20288049%20or%20ability.id%20%3D%20289537%20or%20ability.id%20%3D%20287691)%20and%20type%20%3D%20%22begincast%22%20%20or%20(ability.id%20%3D%20287757%20or%20ability.id%20%3D%20286597)%20and%20type%20%3D%20%22cast%22
--https://www.warcraftlogs.com/reports/1WvLk2yzwK48CmHM#fight=last&view=events&pins=2%24Off%24%23244F4B%24expression%24(ability.id%20%3D%20282205%20or%20ability.id%20%3D%20287952%20or%20ability.id%20%3D%20287929%20or%20ability.id%20%3D%20282153%20or%20ability.id%20%3D%20288410%20or%20ability.id%20%3D%20287751%20or%20ability.id%20%3D%20287797%20or%20ability.id%20%3D%20286693%20or%20ability.id%20%3D%20288041%20or%20ability.id%20%3D%20288049%20or%20ability.id%20%3D%20289537%20or%20ability.id%20%3D%20287691)%20and%20type%20%3D%20%22begincast%22%20%20or%20(ability.id%20%3D%20287757%20or%20ability.id%20%3D%20286597)%20and%20type%20%3D%20%22cast%22&translate=true
--https://www.warcraftlogs.com/reports/GXfwVbyY4cDRd37K#fight=last&view=events&pins=2%24Off%24%23244F4B%24expression%24(ability.id%20%3D%20282205%20or%20ability.id%20%3D%20287952%20or%20ability.id%20%3D%20287929%20or%20ability.id%20%3D%20282153%20or%20ability.id%20%3D%20288410%20or%20ability.id%20%3D%20287751%20or%20ability.id%20%3D%20287797%20or%20ability.id%20%3D%20286693%20or%20ability.id%20%3D%20288041%20or%20ability.id%20%3D%20288049%20or%20ability.id%20%3D%20289537%20or%20ability.id%20%3D%20287691)%20and%20type%20%3D%20%22begincast%22%20%20or%20(ability.id%20%3D%20287757%20or%20ability.id%20%3D%20286597)%20and%20type%20%3D%20%22cast%22
--TODO, nameplate aura for tampering protocol, if it has actual debuff diration (wowhead does not)
--TODO, adjust electroshock stacks?
local warnPhase							= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)
--Ground Phase
local warnShrunk						= mod:NewTargetNoFilterAnnounce(284168, 1)
local warnMisTele						= mod:NewTargetNoFilterAnnounce(287114, 3)
local warnDeploySparkbot				= mod:NewCountAnnounce(288410, 2)
local warnGigavoltCharge				= mod:NewTargetAnnounce(286646, 3)
--Intermission: Evasive Maneuvers!

--Final Push
local warnHyperDrive					= mod:NewTargetNoFilterAnnounce(286051, 3)

--Ground Phase
local specWarnBusterCannon				= mod:NewSpecialWarningDodgeCount(282153, nil, nil, nil, 2, 2)
local specWarnBlastOff					= mod:NewSpecialWarningDodgeCount(282205, nil, nil, nil, 4, 2)
--local specWarnCrashDown					= mod:NewSpecialWarningDodge(287797, nil, nil, nil, 2, 2)
local specWarnElectroshockAmp			= mod:NewSpecialWarningCount(289699, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.stack:format(8, 289699), nil, 1, 2)
local specWarnElectroshockAmpOther		= mod:NewSpecialWarningTaunt(289699, nil, nil, nil, 1, 2)
local specWarnGigaVoltCharge			= mod:NewSpecialWarningYouPos(286646, nil, nil, nil, 1, 2)
local yellGigaVoltCharge				= mod:NewPosYell(286646)
local yellGigaVoltChargeFades			= mod:NewIconFadesYell(286646)
local specWarnGigaVoltChargeFading		= mod:NewSpecialWarningMoveTo(286646, nil, nil, nil, 3, 2)
local specWarnGigaVoltChargeTaunt		= mod:NewSpecialWarningTaunt(286646, nil, nil, nil, 1, 2)
local specWarnWormholeGenerator 		= mod:NewSpecialWarningCount(287952, nil, nil, nil, 2, 5)
local specWarnDiscombobulation			= mod:NewSpecialWarningDispel(287167, "Healer", nil, nil, 1, 2, 4)--Mythic
local specWarnDeploySparkBot			= mod:NewSpecialWarningSwitchCount(288410, false, nil, nil, 1, 2)
local specWarnShrunk					= mod:NewSpecialWarningYou(284168, nil, nil, nil, 1, 2)
local yellShrunk						= mod:NewShortYell(284168)--Shrunk will just say with white letters
local yellShrunkRepeater				= mod:NewYell(284168, UnitName("player"))
local yellTamperingRepeater				= mod:NewYell(286105, UnitName("player"), nil, nil, "YELL")
local specWarnShrunkTaunt				= mod:NewSpecialWarningTaunt(284168, nil, nil, nil, 1, 2)
local specWarnEnormous					= mod:NewSpecialWarningYou(289023, nil, nil, nil, 1, 2, 4)--Mythic
local yellEnormous						= mod:NewYell(289023)--Enormous will shout with red letters
local specWarnMisCalcTele				= mod:NewSpecialWarningYou(287114, nil, nil, nil, 1, 2, 4)--Mythic
local yellMisCalcTele					= mod:NewYell(287114)
local specWarnBlingstorm				= mod:NewSpecialWarningRun(289864, "Melee", nil, nil, 4, 2)
local specWarnGoldChainLightning		= mod:NewSpecialWarningInterrupt(289870, "HasInterrupt", nil, nil, 1, 2)
--Intermission: Evasive Maneuvers!
local specWarnExplodingSheep			= mod:NewSpecialWarningDodge(287929, nil, nil, nil, 2, 2)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 8)

--mod:AddTimerLine(DBM:EJ_GetSectionInfo(18527))
--Ground Phase
local timerBusterCannonCD				= mod:NewNextCountTimer(25, 282153, 88891, nil, nil, 3)--Shorttext "Cannon"
local timerBlastOffCD					= mod:NewNextCountTimer(55, 282205, nil, nil, nil, 2)
local timerCrashDownCD					= mod:NewCastTimer(4.5, 287797, nil, nil, nil, 3)
local timerGigaVoltChargeCD				= mod:NewNextCountTimer(14.1, 286646, nil, nil, nil, 3, nil, DBM_CORE_TANK_ICON, nil, 2, 4)
local timerWormholeGeneratorCD			= mod:NewNextCountTimer(55, 287952, 67833, nil, nil, 3, nil, DBM_CORE_HEROIC_ICON, nil, 3, 4)--Shorttext "Wormhole"
local timerDeploySparkBotCD				= mod:NewNextCountTimer(55, 288410, nil, nil, nil, 1)
local timerWorldEnlargerCD				= mod:NewNextCountTimer(90, 288049, nil, nil, nil, 3, nil, nil, nil, 1, 4)
--Intermission: Evasive Maneuvers!
local timerIntermission					= mod:NewPhaseTimer(64.8)
local timerExplodingSheepCD				= mod:NewNextCountTimer(55, 287929, 222529, nil, nil, 3)--Shorttext "Exploding Sheep"

--local berserkTimer					= mod:NewBerserkTimer(600)

mod:AddSetIconOption("SetIconGigaVolt", 286646, true, false, {1, 2, 3})
mod:AddSetIconOption("SetIconBot", 288410, true, true, {4, 5, 6, 7, 8})
mod:AddInfoFrameOption(286105, true)

mod.vb.phase = 1
--Count variables for every timer, because stupid sequence mod
mod.vb.botCount = 0
mod.vb.cannonCount = 0
mod.vb.blastOffcount = 0
mod.vb.ripperCount = 0
mod.vb.gigaCount = 0
mod.vb.gigaIcon = 1
mod.vb.botIcon = 4
mod.vb.shrinkCount = 0
mod.vb.sheepCount = 0
mod.vb.difficultyName = "None"
local shrunkTargets = {}
local playersInRobots = {}
local robotCount = 0
--Normal and heroic seem identical, at least so far, but blizz has been making tweeks to fight multiple times. Even this week they made additional timer alterations from last week on heroic
--As such, need to have duplicate tables across board so it's easy to update mod on wim if they adjust specific difficulties only.
--Mythic seems to have a TON of differencecs from heroic/normal
--Last Timer Update 02/04/2019
local sparkBotTimers = {
	--All difficulties seem identical (at this time) but left in indivdual tables since on a dime blizz might change it
	["lfr"] = {
		[1] = {5, 22, 27.5, 42.4, 22.5, 25, 42, 22.5, 22.5, 54.9, 22.5},
		[1.5] = {},
		[2] = {15.7, 39.9, 42.5, 47.5, 41.5, 45, 55, 47.5, 42.5},--P2 timers very diff from P1, unlike other abilities
	},
	["normal"] = {
		[1] = {5, 22, 27.5, 42.4, 22.5, 25, 42, 22.5, 22.5, 54.9, 22.5},
		[1.5] = {},
		[2] = {15.7, 39.9, 42.5, 47.5, 41.5, 45, 55, 47.5, 42.5},--P2 timers very diff from P1, unlike other abilities
	},
	["heroic"] = {
		[1] = {5, 22, 27.5, 42.5, 22.5, 25, 42, 22.5, 22.5, 54.9, 22.5},
		[1.5] = {19.8},--Actual difference on heroic/mythic
		[2] = {15.7, 39.9, 42.5, 47.5, 41.5, 45, 55, 47.5, 42.5},--P2 timers very diff from P1, unlike other abilities
	},
	["mythic"] = {
		[1] = {5, 22, 27.5, 42.5, 22.5, 25, 42, 22.5, 22.5, 54.9, 22.5},
		[1.5] = {19.8},--Actual difference on heroic/mythic
		[2] = {15.7, 39.9, 42.5, 47.5, 41.5, 45, 55, 47.5, 42.5},--P2 timers very diff from P1, unlike other abilities
	},
}
local busterCannonTimers = {
	["lfr"] = {
		[1] = {13, 32.9, 64.5, 40, 26.4, 65, 28, 30.5},
		[2] = {17.7, 28.9, 64.5, 40, 26.5, 65, 28, 30.5, 40, 26.5},
	},
	["normal"] = {
		[1] = {13, 32.9, 64.5, 40, 26.4, 65, 28, 30.5},
		[2] = {17.7, 28.9, 64.5, 40, 26.5, 65, 28, 30.5, 40, 26.5},
	},
	["heroic"] = {
		[1] = {13, 32.9, 64.5, 40, 26.4, 65, 28, 30.5},
		[2] = {17.7, 28.9, 64.5, 40, 26.5, 65, 28, 30.5, 40, 26.5},--(E 40, 26.5)
	},
	["mythic"] = {
		[1] = {13, 32.9, 33.4, 31, 40, 26.4, 65, 28, 30.5},--There is an ADDITIONAL cast on Mythic difficulty only at 1:19 (79sec into fight)
		[2] = {17.7, 29, 33.4, 31, 40, 26.5, 65, 28, 30.5, 40, 26.5},--(E 28, 30.5, 40, 26.5)(Also has additional cast not seen in mother modes
	},
}
local blastOffTimers = {
	["lfr"] = {
		[1] = {37.1, 31, 37.5, 34.1, 50.3, 75, 30.5},--Cast sooner on normal/LFR do to having no Wormhole Generator
		[2] = {41.7, 28.9, 35.5, 34, 50.4, 75, 30.5, 34, 50.4},
	},
	["normal"] = {
		[1] = {37.1, 31, 37.5, 34.1, 50.3, 75, 30.5},--Cast sooner on normal/LFR do to having no Wormhole Generator
		[2] = {41.7, 28.9, 35.5, 34, 50.4, 75, 30.5, 34, 50.4},
	},
	["heroic"] = {
		[1] = {41.1, 26.9, 37.5, 34.1, 50.4, 75.4, 30.5},--(E 30.5)Slightly Different between Heroic and Mythic
		[2] = {41.7, 28.9, 35.5, 34.3, 50.2, 75, 30.4, 34, 50.4},--(E 34, 50.4)
	},
	["mythic"] = {
		[1] = {41.5, 28.5, 35.5, 34.6, 49.9, 75.6, 30.5},--(E 30.5)Slightly Different between Heroic and Mythic do to the extra buster cannon on mythic affecting 2nd and 3rd casts
		[2] = {41.7, 29, 35.5, 34.1, 50.2, 75, 30.4, 34, 50.4},--(E 50.2, 75, 30.4, 34, 50.4)
	},
}
local wormholeTimers = {
	--Not used on normal/lfr
	["heroic"] = {
		[1] = {38, 98.7, 125.7},
		[1.5] = {46.8},
		[2] = {38.8, 98.6, 122.7},
	},
	["mythic"] = {
		[1] = {38, 98.7, 125.7},
		[1.5] = {50.3},--This cast is flipped with gigavolt charge on mythic
		[2] = {38.8, 98.6},
	},
}
local gigaVoltTimers = {
	["normal"] = {
		[1] = {21.5, 40, 40, 33, 41.9, 40},
		[1.5] = {16.9, 33.5},
		[2] = {22.2, 40, 40, 35, 39.9, 40, 47, 28, 35, 40},
	},
	["heroic"] = {
		[1] = {21.5, 40, 40, 33, 41.9, 40, 44.4},
		[1.5] = {16.9, 33.5},
		[2] = {22.2, 40, 40, 35, 39.9, 39.9, 47.5, 27.5, 35, 40},--(E 35, 40)
	},
	["mythic"] = {
		[1] = {21.5, 40, 40, 33, 82, 44.4, 30.4},--One cast is removed on Mythic Difficulty
		[1.5] = {16.9, 32},--Cast sooner on mythic do to swap with wormhole
		[2] = {22.2, 40, 40, 35, 40, 40, 47.5, 27.5, 35, 40},--(E 47.5, 27.5, 35, 40)One cast is NOT removed in P2 though
	},
}
local worldEnlargerTimers = {
	["lfr"] = {
		[1] = {75, 90, 90},
		[1.5] = {7.4, 31},
		[2] = {75.8, 90, 90, 100},
	},
	["normal"] = {
		[1] = {75, 90, 90},
		[1.5] = {7.4, 31},
		[2] = {75.8, 90, 90, 100},
	},
	["heroic"] = {
		[1] = {75, 90, 90},
		[1.5] = {7.4, 31},
		[2] = {75.8, 90, 90, 100},--(E 100)
	},
	["mythic"] = {
		[1] = {75, 90, 90},
		[1.5] = {7.4, 31},
		[2] = {75.8, 90, 90, 100},--(E 100)
	},
}
local explodingSheepTimers = {
	["lfr"] = {
		[1.5] = {12.5, 29.9, 12},
	},
	["normal"] = {
		[1.5] = {12.5, 29.9, 12},
	},
	["heroic"] = {
		[1.5] = {12.5, 29.9, 12},
		[2] = {28.3, 100, 82, 108},--Different on heroic than mythic
	},
	["mythic"] = {
		[1.5] = {12.5, 29.9, 12},
		[2] = {28.3, 92.4, 90},--Different on heroic than mythic
	},
}

local function shrunkYellRepeater(self)
	yellShrunkRepeater:Yell()
	self:Schedule(2, shrunkYellRepeater, self)
end

local function TamperingYellRepeater(self)
	yellTamperingRepeater:Yell()
	self:Schedule(2, TamperingYellRepeater, self)
end

local updateInfoFrame
do
	local shrunkName = DBM:GetSpellInfo(284168)
	local floor = math.floor
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
		--Players in Robots
		if robotCount > 0 then
			--Tampering First
			for uId in DBM:GetGroupMembers() do
				local unitName = DBM:GetUnitFullName(uId)
				if playersInRobots[unitName] then--Matched a unitID and playername to one of them
					local count = playersInRobots[unitName]--Check successful code entries
					local spellName, _, _, _, _, expireTime = DBM:UnitDebuff(uId, 286105)--Check remaining time on tampering
					if spellName and expireTime then
						local remaining = expireTime-GetTime()
						addLine(unitName, count.."/3 - "..floor(remaining))--Display playername, disarm code of 3, and remaining Tampering
					else
						addLine(unitName, count.."/3")
					end
				end
			end
		end
		--Shrunk Second
		if #shrunkTargets > 0 then
			addLine("---"..shrunkName.."---")
			local name, name2, name3, name4, name5, name6, name7, name8, name9, name10, name11, name12 = shrunkTargets[1], shrunkTargets[2], shrunkTargets[3], shrunkTargets[4], shrunkTargets[5], shrunkTargets[6], shrunkTargets[7], shrunkTargets[8], shrunkTargets[9], shrunkTargets[10], shrunkTargets[11], shrunkTargets[12]
			if name then
				if name2 then
					addLine(name, name2)
				else
					addLine(name)
				end
			end
			if name3 then
				if name4 then
					addLine(name3, name4)
				else
					addLine(name3)
				end
			end
			if name5 then
				if name6 then
					addLine(name5, name6)
				else
					addLine(name5)
				end
			end
			if name7 then
				if name8 then
					addLine(name7, name8)
				else
					addLine(name7)
				end
			end
			if name9 then
				if name10 then
					addLine(name9, name10)
				else
					addLine(name9)
				end
			end
			if name11 then
				if name12 then
					addLine(name11, name12)
				else
					addLine(name11)
				end
			end
		end
		return lines, sortedLines
	end
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.botCount = 0
	self.vb.cannonCount = 0
	self.vb.blastOffcount = 0
	self.vb.ripperCount = 0
	self.vb.gigaCount = 0
	self.vb.gigaIcon = 1
	self.vb.botIcon = 4
	self.vb.shrinkCount = 0
	table.wipe(playersInRobots)
	table.wipe(shrunkTargets)
	robotCount = 0
	--Same across board (at least for now, LFR not out yet)
	timerDeploySparkBotCD:Start(5-delay, 1)
	timerBusterCannonCD:Start(13-delay, 1)
	timerWorldEnlargerCD:Start(75-delay, 1)--Start
	if self:IsMythic() then
		self.vb.difficultyName = "mythic"
		timerGigaVoltChargeCD:Start(21.5-delay, 1)--Success
		timerWormholeGeneratorCD:Start(38-delay, 1)
		timerBlastOffCD:Start(41-delay, 1)
	else
		if self:IsHeroic() then
			self.vb.difficultyName = "heroic"
			timerGigaVoltChargeCD:Start(21.5-delay, 1)--Success
			timerWormholeGeneratorCD:Start(38-delay, 1)
			timerBlastOffCD:Start(41-delay, 1)
		elseif self:IsNormal() then
			self.vb.difficultyName = "normal"
			timerGigaVoltChargeCD:Start(21.5-delay, 1)--Success
			timerBlastOffCD:Start(37-delay, 1)
		else
			self.vb.difficultyName = "lfr"
			timerBlastOffCD:Start(37-delay, 1)
		end
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(286105))
		DBM.InfoFrame:Show(8, "function", updateInfoFrame, false, false)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 282205 then
		self.vb.blastOffcount = self.vb.blastOffcount + 1
		specWarnBlastOff:Show(self.vb.blastOffcount)
		specWarnBlastOff:Play("justrun")
		timerCrashDownCD:Start(4.5)
		local timer = blastOffTimers[self.vb.difficultyName][self.vb.phase][self.vb.blastOffcount+1]
		if timer then
			timerBlastOffCD:Start(timer, self.vb.blastOffcount+1)
		end
	elseif spellId == 287952 then
		self.vb.ripperCount = self.vb.ripperCount + 1
		specWarnWormholeGenerator:Show(self.vb.ripperCount)
		specWarnWormholeGenerator:Play("teleyou")
		local timer = wormholeTimers[self.vb.difficultyName][self.vb.phase][self.vb.ripperCount+1]
		if timer then
			timerWormholeGeneratorCD:Start(timer, self.vb.ripperCount+1)
		end
	elseif spellId == 287929 then
		self.vb.sheepCount = self.vb.sheepCount + 1
		specWarnExplodingSheep:Show()
		specWarnExplodingSheep:Play("watchstep")
		local timer = explodingSheepTimers[self.vb.difficultyName][self.vb.phase][self.vb.sheepCount+1]
		if timer then
			timerExplodingSheepCD:Start(timer, self.vb.sheepCount+1)
		end
	elseif spellId == 282153 then
		self.vb.cannonCount = self.vb.cannonCount + 1
		specWarnBusterCannon:Show(self.vb.cannonCount)
		specWarnBusterCannon:Play("shockwave")
		local timer = busterCannonTimers[self.vb.difficultyName][self.vb.phase][self.vb.cannonCount+1]
		if timer then
			timerBusterCannonCD:Start(timer, self.vb.cannonCount+1)
		end
	elseif spellId == 288410 or spellId == 287691 then
		self.vb.botCount = self.vb.botCount + 1
		if self.Options.SpecWarn288410switchcount then
			specWarnDeploySparkBot:Show(self.vb.botCount)
			specWarnDeploySparkBot:Play("targetchange")
		else
			warnDeploySparkbot:Show(self.vb.botCount)
		end
		local timer = sparkBotTimers[self.vb.difficultyName][self.vb.phase][self.vb.botCount+1]
		if timer then
			timerDeploySparkBotCD:Start(timer, self.vb.botCount+1)
		end
	elseif spellId == 287751 then--Evasive Maneuvers (intermission Start)
		self.vb.phase = 1.5
		--These happen in intermission too so intermission counters needed
		self.vb.botCount = 0
		self.vb.ripperCount = 0
		self.vb.gigaCount = 0
		self.vb.shrinkCount = 0
		self.vb.sheepCount = 0
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase))
		warnPhase:Play("phasechange")
		timerCrashDownCD:Stop()
		timerDeploySparkBotCD:Stop()
		timerBusterCannonCD:Stop()
		timerGigaVoltChargeCD:Stop()--Success
		timerBlastOffCD:Stop()
		timerWorldEnlargerCD:Stop()
		timerWormholeGeneratorCD:Stop()
		timerWorldEnlargerCD:Start(7.9, 1)
		timerExplodingSheepCD:Start(12.8, 1)
		if self:IsHard() then
			timerGigaVoltChargeCD:Start(16.9, 1)
			timerDeploySparkBotCD:Start(19.8, 1)
			if self:IsMythic() then
				timerWormholeGeneratorCD:Start(50.3, 1)
			else
				timerWormholeGeneratorCD:Start(46.8, 1)
			end
		else
			if self:IsNormal() then
				timerGigaVoltChargeCD:Start(16.9, 1)
			end
		end
		timerIntermission:Start(64.8)
	elseif spellId == 287797 then--Crash Down (intermission end)
		self.vb.phase = 2
		--Reset everything but sheep, for next ground phase
		self.vb.botCount = 0
		self.vb.cannonCount = 0
		self.vb.blastOffcount = 0
		self.vb.ripperCount = 0
		self.vb.gigaCount = 0
		self.vb.shrinkCount = 0
		self.vb.sheepCount = 0
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase))
		warnPhase:Play("phasechange")
		timerExplodingSheepCD:Stop()
		timerDeploySparkBotCD:Stop()
		timerGigaVoltChargeCD:Stop()
		timerWorldEnlargerCD:Stop()
		timerWormholeGeneratorCD:Stop()
		timerDeploySparkBotCD:Start(15.7, 1)
		timerBusterCannonCD:Start(17.7, 1)
		timerBlastOffCD:Start(41.7, 1)
		timerWorldEnlargerCD:Start(75.7, 1)--Start
		if self:IsHard() then
			timerExplodingSheepCD:Start(28.3, 1)
			timerWormholeGeneratorCD:Start(38.8, 1)
			timerGigaVoltChargeCD:Start(22.2, 1)--Success
		else
			if self:IsNormal() then
				timerGigaVoltChargeCD:Start(22.2, 1)--Success
			end
		end
	elseif spellId == 287757 or spellId == 286597 then
		self.vb.gigaIcon = 1
	elseif spellId == 286693 or spellId == 288041 or spellId == 288049 or spellId == 289537 then--288041 used in intermission first, 288049 second in intermission, 286693 outside intermission
		self.vb.shrinkCount = self.vb.shrinkCount + 1
		local timer = worldEnlargerTimers[self.vb.difficultyName][self.vb.phase][self.vb.shrinkCount+1]
		if timer then
			timerWorldEnlargerCD:Start(timer, self.vb.shrinkCount+1)
		end
	elseif spellId == 289864 then
		specWarnBlingstorm:Show()
		specWarnBlingstorm:Play("justrun")
	elseif spellId == 289870 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnGoldChainLightning:Show(args.sourceName)
		specWarnGoldChainLightning:Play("kickcast")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 287757 or spellId == 286597 then
		self.vb.gigaCount = self.vb.gigaCount + 1
		local timer = gigaVoltTimers[self.vb.difficultyName][self.vb.phase][self.vb.gigaCount+1]
		if timer then
			timerGigaVoltChargeCD:Start(timer, self.vb.gigaCount+1)
		end
	elseif spellId == 286152 or spellId == 286219 or spellId == 286215 or spellId == 286226 or spellId == 286192 then--Disarm Codes
		if playersInRobots[args.sourceName] then
			playersInRobots[args.sourceName] = playersInRobots[args.sourceName] + 1
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 287757 or spellId == 286646 then--283409?
		local icon = self.vb.gigaIcon
		warnGigavoltCharge:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnGigaVoltCharge:Show(self:IconNumToTexture(icon))
			specWarnGigaVoltCharge:Play("targetyou")
			specWarnGigaVoltChargeFading:Schedule(8.5, DBM_CORE_BREAK_LOS)
			specWarnGigaVoltChargeFading:ScheduleVoice(8.5, "mm"..icon)
			yellGigaVoltCharge:Yell(icon, icon, icon)
			yellGigaVoltChargeFades:Countdown(spellId, nil, icon)
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			if self:IsTanking(uId) then
				specWarnGigaVoltChargeTaunt:Show(args.destName)
				specWarnGigaVoltChargeTaunt:Play("tauntboss")
			end
		end
		if self.Options.SetIconGigaVolt then
			self:SetIcon(args.destName, icon)
		end
		self.vb.gigaIcon = self.vb.gigaIcon + 1
	elseif spellId == 287167 and self:CheckDispelFilter() then
		specWarnDiscombobulation:CombinedShow(0.3, args.destName)
		specWarnDiscombobulation:ScheduleVoice(0.3, "helpdispel")
	elseif spellId == 284168 then
		warnShrunk:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnShrunk:Show()
			specWarnShrunk:Play("targetyou")
			yellShrunk:Yell()
			if not self:IsLFR() then
				self:Unschedule(shrunkYellRepeater)
				self:Schedule(2, shrunkYellRepeater, self)
			end
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			if self:IsTanking(uId) then
				specWarnShrunkTaunt:Show(args.destName)
				specWarnShrunkTaunt:Play("tauntboss")
			end
		end
		if not tContains(shrunkTargets, args.destName) then
			table.insert(shrunkTargets, args.destName)
		end
	elseif spellId == 289023 then
		if args:IsPlayer() then
			specWarnEnormous:Show()
			specWarnEnormous:Play("watchstep")
			yellEnormous:Yell()
		end
	elseif spellId == 286051 then
		warnHyperDrive:Show(args.destName)
	elseif spellId == 289699 then
		local amount = args.amount or 1
		if amount >= 8 and self:AntiSpam(5, 4) then
			if self:IsTanking("player", "boss1", nil, true) then
				specWarnElectroshockAmp:Show(amount)
				specWarnElectroshockAmp:Play("changemt")
			elseif not DBM:UnitDebuff("player", 284168, 287757) then--Don't have shrunk or giga
				specWarnElectroshockAmpOther:Show(args.destName)
				specWarnElectroshockAmpOther:Play("tauntboss")
			end
		end
	elseif spellId == 282406 then--Spark Pulse#BUFF#nil
		if self.Options.SetIconBot then
			self:ScanForMobs(args.destGUID, 2, self.vb.botIcon, 1, 0.2, 10)
		end
		self.vb.botIcon = self.vb.botIcon + 1
		if self.vb.botIcon == 9 then self.vb.botIcon = 4 end--Icons 4-8
	elseif spellId == 286105 then--Tampering
		local type = strsplit("-", args.destGUID or "")
		if type and type ~= "Vehicle" then
			playersInRobots[args.destName] = 0
			robotCount = robotCount + 1
			if args:IsPlayer() then
				self:Unschedule(TamperingYellRepeater)
				self:Schedule(2, TamperingYellRepeater, self)
			end
		end
	elseif spellId == 287114 then
		warnMisTele:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnMisCalcTele:Show()
			specWarnMisCalcTele:Play("carefly")
			yellMisCalcTele:Yell()
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 287757 or spellId == 286646 then--283409?
		if args:IsPlayer() then
			specWarnGigaVoltChargeFading:Cancel()
			specWarnGigaVoltChargeFading:CancelVoice()
			yellGigaVoltChargeFades:Cancel()
		end
		if self.Options.SetIconGigaVolt then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 284168 then
		tDeleteItem(shrunkTargets, args.destName)
		if args:IsPlayer() then
			self:Unschedule(shrunkYellRepeater)
		end
	elseif spellId == 286105 then--Tampering
		local type = strsplit("-", args.destGUID or "")
		if type and type ~= "Vehicle" then
			playersInRobots[args.destName] = nil
			robotCount = robotCount - 1
			if args:IsPlayer() then
				self:Unschedule(TamperingYellRepeater)
			end
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]
