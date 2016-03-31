local mod	= DBM:NewMod(1395, "DBM-HellfireCitadel", nil, 669)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(91349)--91305 Fel Iron Summoner
mod:SetEncounterID(1795)
mod:SetZone()
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 2, 1)
mod:SetHotfixNoticeRev(14801)
mod:SetMinSyncRevision(14732)
mod.respawnTime = 30
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 181126 181132 181557 183376 181793 181792 181738 181799 182084 185830 181948 182040 182076 182077 181099 181597 182006",
	"SPELL_CAST_SUCCESS 181190 181597 182006 181275",
	"SPELL_AURA_APPLIED 181099 181275 181191 181597 182006 186362",
	"SPELL_AURA_APPLIED_DOSE 181119",
	"SPELL_AURA_REMOVED 181099 181275 185147 182212 185175 181597 182006 181275 186362 181119",
	"SPELL_DAMAGE 181192 190070",
	"SPELL_MISSED 181192 190070",
	"SPELL_SUMMON 181255 181180",
	"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
	"UNIT_DIED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--(ability.id = 181557 or ability.id = 181948 or ability.id = 181799 or ability.id = 182084 or ability.id = 186348 or ability.id = 181793 or ability.id = 183377 or ability.id = 185831 or ability.id = 182077) and type = "begincast" or (ability.id = 181597 or ability.id = 182006) and type = "cast" or (ability.id = 185147 or ability.id = 182212 or ability.id = 185175) and type = "removebuff" or (ability.id = 186362 or ability.id = 181275) and type = "applydebuff"
--(ability.id = 181255 or ability.id = 181180) and type = "summon" or (ability.id = 186362 or ability.id = 181275) and type = "applydebuff"
--TODO, get timer for 2nd doom lord spawning on non mythic, if some group decides to do portals in a bad order and not kill that portal summoner first
--TODO, custom voice for shadowforce? It works almost identical to helm of command from lei shen. Did that have a voice usuable here?
--Adds
----Doom Lords
local warnCurseoftheLegion			= mod:NewTargetCountAnnounce(181275, 3)--Spawn
local warnMarkofDoom				= mod:NewTargetAnnounce(181099, 4)
local warnDoomSpike					= mod:NewStackAnnounce(181119, 3, nil, false, 2)
----Fel Imp
local warnFelImplosion				= mod:NewCountAnnounce(181255, 3)--Spawn
----Dread Infernals
local warnInferno					= mod:NewCountAnnounce(181180, 3)--Spawn
local warnFelStreak					= mod:NewSpellAnnounce(181190, 3, nil, "Melee")--Change to target scan/personal/near warning if possible
--Gul'dan
local warnWrathofGuldan				= mod:NewTargetAnnounce(186362, 4)
--Mannoroth
local warnPhase2					= mod:NewPhaseAnnounce(2)
local warnPhase3					= mod:NewPhaseAnnounce(3)
local warnPhase4					= mod:NewPhaseAnnounce(4)
local warnGaze						= mod:NewTargetAnnounce(181597, 3)
local warnFelseeker					= mod:NewCountAnnounce(181735, 3)

--Adds
----Doom Lords
local specWarnCurseofLegion			= mod:NewSpecialWarningYou(181275)
local yellCurseofLegion				= mod:NewFadesYell(181275)--Don't need to know when it's applied, only when it's fading does it do aoe/add spawn
local specWarnMarkOfDoom			= mod:NewSpecialWarningYou(181099, nil, nil, nil, 1, 2)
local yellMarkOfDoom				= mod:NewPosYell(181099, 31348)-- This need to know at apply, only player needs to know when it's fading
local specWarnShadowBoltVolley		= mod:NewSpecialWarningInterrupt(181126, "HasInterrupt", nil, 2, 1, 2)
local specWarnDoomSpikeOther		= mod:NewSpecialWarningTaunt(181119, false, nil, 2, 1, 2)--Optional, most guilds 3 tank and don't swap for this so off by default
----Fel Imps
local specWarnFelBlast				= mod:NewSpecialWarningInterrupt(181132, false, nil, 2, 1, 2)--Can be spammy, but someone may want it
----Dread Infernals
local specWarnFelHellfire			= mod:NewSpecialWarningDodge(181191, nil, nil, 3, 1, 2)
----Gul'dan
local specWarnWrathofGuldan			= mod:NewSpecialWarningYou(186362, nil, nil, nil, 1, 5)
local yellWrathofGuldan				= mod:NewPosYell(186362, 169826)
local specWarnFelPillar				= mod:NewSpecialWarningDodge(190070, nil, nil, 3, 1, 2)
--Mannoroth
local specWarnGlaiveCombo			= mod:NewSpecialWarningSpell(181354, "Tank", nil, nil, 3, 2)--Active mitigation or die mechanic
local specWarnMassiveBlast			= mod:NewSpecialWarningSpell(181359, nil, nil, nil, 1, 2)
local specWarnMassiveBlastOther		= mod:NewSpecialWarningTaunt(181359, nil, nil, nil, 1, 2)
local specWarnFelHellStorm			= mod:NewSpecialWarningSpell(181557, nil, nil, nil, 2, 2)
local specWarnGaze					= mod:NewSpecialWarningYou(181597)
local yellGaze						= mod:NewPosYell(181597, 134029)
local specWarnFelSeeker				= mod:NewSpecialWarningDodge(181735, nil, nil, nil, 2, 2)
local specWarnShadowForce			= mod:NewSpecialWarningSpell(181799, nil, nil, nil, 3)

--Adds
mod:AddTimerLine(OTHER)
----Doom Lords
local timerCurseofLegionCD			= mod:NewNextCountTimer(64.8, 181275, nil, nil, nil, 1, nil, DBM_CORE_HEROIC_ICON)--Maybe see one day, in LFR or something when group is terrible or doesn't kill doom lord portal first
local timerMarkofDoomCD				= mod:NewCDTimer(31.5, 181099, nil, "-Tank", nil, 3)
--local timerShadowBoltVolleyCD		= mod:NewCDTimer(12, 181126, nil, "-Healer", nil, 4)
----Fel Imps
local timerFelImplosionCD			= mod:NewNextCountTimer(46, 181255, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)
----Infernals
local timerInfernoCD				= mod:NewNextCountTimer(107, 181180, nil, nil, nil, 1)
----Gul'dan
local timerWrathofGuldanCD			= mod:NewNextTimer(107, 186348, 169826, nil, nil, 3, nil, DBM_CORE_HEROIC_ICON)
--Mannoroth
mod:AddTimerLine(L.name)
local timerGlaiveComboCD			= mod:NewCDTimer(30, 181354, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--30 seconds unless delayed by something else
local timerFelHellfireCD			= mod:NewCDTimer(35, 181557, nil, nil, nil, 2)--35, unless delayed by other things.
local timerGazeCD					= mod:NewCDTimer(47.1, 181597, 134029, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)--As usual, some variation do to other abilities
local timerFelSeekerCD				= mod:NewCDTimer(49.5, 181735, nil, nil, nil, 2)--Small sample size, confirm it's not shorter if not delayed by things.
local timerShadowForceCD			= mod:NewCDTimer(52.2, 181799, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)

--local berserkTimer					= mod:NewBerserkTimer(360)

local countdownGlaiveCombo			= mod:NewCountdown("Alt30", 181354, "Tank")
local countdownMarkOfDoom			= mod:NewCountdownFades("AltTwo15", 181099)
local countdownShadowForce			= mod:NewCountdown(52, 181799)

local voicePhaseChange				= mod:NewVoice(nil, nil, DBM_CORE_AUTO_VOICE2_OPTION_TEXT)
local voiceGaze						= mod:NewVoice(181597, false) --gather share
local voiceMarkOfDoom				= mod:NewVoice(181099) --run out/mm
local voiceFelHellfire				= mod:NewVoice(181191, nil, nil, 2) --runaway
local voiceShadowBoltVolley			= mod:NewVoice(181126, "HasInterrupt")
local voiceFelBlast					= mod:NewVoice(181132, false)
local voiceFelSeeker				= mod:NewVoice(181735)--watchstep
local voiceFelHellstorm				= mod:NewVoice(181557)--watchstep
local voiceGlaiveCombo				= mod:NewVoice(181354, "Tank")--defensive
local voiceMassiveBlast				= mod:NewVoice(181359, "Tank")--tauntboss
local voiceFelPillar				= mod:NewVoice(190070)--runaway
local voiceWrath					= mod:NewVoice(186348)--mm

mod:AddRangeFrameOption(20, 181099)
mod:AddSetIconOption("SetIconOnGaze", 181597, false)
mod:AddSetIconOption("SetIconOnDoom2", 181099, true)
mod:AddSetIconOption("SetIconOnWrath", 186348, false)
mod:AddBoolOption("CustomAssignWrath", false)
mod:AddHudMapOption("HudMapOnGaze2", 181597, false)
mod:AddInfoFrameOption(181597)

mod.vb.DoomTargetCount = 0
mod.vb.portalsLeft = 3
mod.vb.phase = 1
mod.vb.impCount = 0
mod.vb.infernalCount = 0
mod.vb.doomlordCount = 0
mod.vb.wrathIcon = 8
mod.vb.ignoreAdds = false
local phase1ImpTimers = {15, 32.2, 24, 15, 10}--Spawn 33% faster each wave, but cannot confirm it goes lower than 10, if it does, next would be 6.6
local phase1ImpTimersN = {15, 32.2, 24, 24}--Normal doesn't go below 24? need larger sample size. Normal differently two 24s in a row and didn't drop to 15
local phase2ImpTimers = {24.5, 39, 39, 30.5, 30}--The same, for now
local phase2ImpTimersN = {24.5, 39, 39, 30.5, 30}--But normal may have a lower limit, like phase 1, so coded in two tables for now.
local phase1InfernalTimers = {18.4, 40, 30, 20, 20, 20}--Confirmed this far on heroic
local phase1InfernalTimersN = {18.4, 40, 30, 30}--Normal probably doesn't drop below 30?
local phase2InfernalTimers = {47.5, 44.8, 44.8, 35}--So far normal and heroic same, but if phase goes on longer probably different (with normal having a higher minimum)
local phase2InfernalTimersN = {47.5, 44.8, 44.8, 35}--So far normal and heroic same, but if phase goes on longer probably different (with normal having a higher minimum)
--local phase3InfernalTimers = {28, 34.8, 35, 34.8, 34.8}--Again, the same now, but two tables FOR NOW until I can confirm whether or not they differ for REALLY long pulls
--local phase3InfernalTimersN = {28, 34.8, 35, 34.8, 34.8}--^^

local gazeTargets = {}
local doomTargets = {}
local guldanTargets = {}
local doomSpikeTargets = {}
local AddsSeen = {}
local playerName = UnitName("player")
local doomName = GetSpellInfo(181099)
local guldanName = GetSpellInfo(186362)
local doomSpikeName = GetSpellInfo(181119)
local gaze1, gaze2 = GetSpellInfo(181597), GetSpellInfo(182006)
local UnitDebuff = UnitDebuff
local doomFilter, guldanFilter, doomSpikeFilter
do
	doomFilter = function(uId)
		if UnitDebuff(uId, doomName) then
			return true
		end
	end
	guldanFilter = function(uId)
		if UnitDebuff(uId, guldanName) then
			return true
		end
	end
	doomSpikeFilter = function(uId)
		if UnitDebuff(uId, guldanName) then
			return true
		end
	end
end

local function updateRangeFrame(self)
	if not self.Options.RangeFrame then return end
	if self:IsTank() and #doomSpikeTargets > 0 then
		if UnitDebuff("Player", doomSpikeName) then
			DBM.RangeCheck:Show(30)
		else
			DBM.RangeCheck:Show(30, doomSpikeFilter)
		end
	elseif self.vb.DoomTargetCount > 0 then
		if UnitDebuff("Player", doomName) then
			DBM.RangeCheck:Show(20)
		else
			DBM.RangeCheck:Show(20, doomFilter)
		end
	elseif #guldanTargets > 0 then
		if UnitDebuff("Player", guldanName) then
			DBM.RangeCheck:Show(15)
		else
			DBM.RangeCheck:Show(15, guldanFilter)
		end
	elseif not self:IsTank() and #doomSpikeTargets > 0 then
		local showDoomSpike = false
		for i = 1, #doomSpikeTargets do
			local name = doomSpikeTargets[i]
			if name and self:CheckNearby(31, name) then
				showDoomSpike = true
				break
			end
		end
		if showDoomSpike then
			--Only show doom spike if you have no debuffs
			DBM.RangeCheck:Show(30, doomSpikeFilter)
		end
	else
		DBM.RangeCheck:Hide()
	end
end

local updateInfoFrame, sortInfoFrame
do
	local lines = {}
	sortInfoFrame = function(a, b)
		local a = lines[a]
		local b = lines[b]
		if not tonumber(a) then a = -1 end
		if not tonumber(b) then b = -1 end
		if a < b then return true else return false end
	end
	updateInfoFrame = function()
		table.wipe(lines)
		local total = 0
		local total2 = 0
		for i = 1, #gazeTargets do
			local name = gazeTargets[i]
			local uId = DBM:GetRaidUnitId(name)
			if not uId then break end
			if UnitDebuff(uId, gaze1) or UnitDebuff(uId, gaze2) then
				total = total + 1
				lines["|cFF9932CD"..name.."|r"] = i
			end
		end
		--Mythic, show guldan targets and number of charges left
		for i = 1, #guldanTargets do
			local name = guldanTargets[i]
			local uId = DBM:GetRaidUnitId(name)
			if not uId then break end
			local _, _, _, currentStack = UnitDebuff(uId, guldanName)
			if currentStack then
				total2 = total2 + 1
				lines[name] = currentStack
			end
		end
		if total == 0 and total2 == 0 then--None found, hide infoframe because all broke
			DBM.InfoFrame:Hide()
		end
		return lines
	end
end

local function warnGazeTargts(self)
	table.sort(gazeTargets)
	warnGaze:Show(table.concat(gazeTargets, "<, >"))
	if self:IsLFR() then return end
	for i = 1, #gazeTargets do
		local name = gazeTargets[i]
		if name == playerName then
			yellGaze:Yell(i, i, i)
		end
		if self.Options.SetIconOnGaze then
			self:SetIcon(name, i)
		end
	end
	if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() then
		DBM.InfoFrame:SetHeader(gaze1)
		DBM.InfoFrame:Show(8, "function", updateInfoFrame, sortInfoFrame, true)
	end
end

local function breakDoom(self)
	warnMarkofDoom:Show(table.concat(doomTargets, "<, >"))
end

local function setWrathIcons(self)
	local ranged1, ranged2, melee1, melee2, healer = nil, nil, nil, nil, nil
	local playerIcon = nil
	for i = 1, #guldanTargets do
		local name = guldanTargets[i]
		local uId = DBM:GetRaidUnitId(name)
		if not uId then return end--Prevent errors if person leaves group
		if self:IsMeleeDps(uId) then--Melee
			if melee1 then
				melee2 = name
				if name == playerName then
					playerIcon = 6
				end
			else
				melee1 = name
				if name == playerName then
					playerIcon = 7
				end
			end
			DBM:Debug("Melee wrath found: "..name, 2)
		elseif self:IsHealer(uId) then--Healer
			healer = name
			DBM:Debug("Healer wrath found: "..name, 2)
			if name == playerName then
				playerIcon = 8
			end
		else--Ranged
			if ranged1 then
				ranged2 = name
				if name == playerName then
					playerIcon = 4
				end
			else
				ranged1 = name
				if name == playerName then
					playerIcon = 5
				end
			end
			DBM:Debug("Ranged wrath found: "..name, 2)
		end
	end
	if ranged1 and ranged2 and melee1 and melee2 and healer then
		DBM:Debug("All wrath found!", 2)
		if self.Options.SetIconOnWrath then
			self:SetIcon(healer, 8)
			self:SetIcon(melee1, 7)
			self:SetIcon(melee2, 6)
			self:SetIcon(ranged1, 5)
			self:SetIcon(ranged2, 4)
		end
		if playerIcon then
			yellWrathofGuldan:Yell(playerIcon, playerIcon, playerIcon)
			voiceWrath:Play("mm"..playerIcon)
		end
	end
end

function mod:OnCombatStart(delay)
	table.wipe(doomTargets)
	table.wipe(gazeTargets)
	table.wipe(AddsSeen)
	table.wipe(guldanTargets)
	table.wipe(doomSpikeTargets)
	self.vb.ignoreAdds = false
	self.vb.impCount = 0
	self.vb.infernalCount = 0
	self.vb.doomlordCount = 0
	self.vb.phase = 1
	self.vb.portalsLeft = 3
	self.vb.DoomTargetCount = 0
	if self:IsMythic() then
		self.vb.wrathIcon = 8
		if UnitIsGroupLeader("player") and self.Options.CustomAssignWrath then
			self:SendSync("WrathByRole")
		end
	else
		timerCurseofLegionCD:Start(5.2, 1)
		timerFelImplosionCD:Start(13.5-delay, 1)
		timerInfernoCD:Start(18.4-delay, 1)--Verify, seems 20 now
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.HudMapOnGaze2 then
		DBMHudMap:Disable()
	end
end 

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 181557 or spellId == 181948 then
		specWarnFelHellStorm:Show()
		voiceFelHellstorm:Play("watchstep")
		timerFelHellfireCD:Start()
	elseif spellId == 181126 then
--		timerShadowBoltVolleyCD:Start(args.sourceGUID)
		if self:CheckInterruptFilter(args.sourceGUID) then
			specWarnShadowBoltVolley:Show(args.sourceName)
			voiceShadowBoltVolley:Play("kickcast")
		end
	elseif spellId == 181132 then
		if self:CheckInterruptFilter(args.sourceGUID, true) then
			specWarnFelBlast:Show(args.sourceName)
			voiceFelBlast:Play("kickcast")
		end
	elseif spellId == 183376 or spellId == 185830 then
		local targetName, uId, bossuid = self:GetBossTarget(91349, true)
		local tanking, status = UnitDetailedThreatSituation("player", bossuid)
		if tanking or (status == 3) then--Player is current target
			specWarnMassiveBlast:Show()
		else
			if self:GetNumAliveTanks() >= 3 and not self:CheckNearby(21, targetName) then return end--You are not near current tank, you're probably 3rd tank on Doom Guards that never taunts massive blast
			specWarnMassiveBlastOther:Schedule(1, targetName)
			voiceMassiveBlast:Schedule(1, "tauntboss")
		end
	elseif spellId == 181793 or spellId == 182077 then--Melee (10)
		warnFelseeker:Show(10)
	elseif spellId == 181792 or spellId == 182076 then--Ranged (20)
		warnFelseeker:Show(20)
	elseif spellId == 181738 or spellId == 182040 then--Ranged (30)
		warnFelseeker:Show(30)
	elseif spellId == 181799 or spellId == 182084 then
		timerShadowForceCD:Start()
		countdownShadowForce:Start(52.5)
		if self:IsTank() and self.vb.phase == 3 then return end--Doesn't target tanks in phase 3, ever.
		specWarnShadowForce:Show()
	elseif spellId == 181099 then
		table.wipe(doomTargets)
	elseif spellId == 181597 or spellId == 182006 then
		table.wipe(gazeTargets)
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 181255 and self:AntiSpam(4, 1) then--Imps
		self.vb.impCount = self.vb.impCount + 1
		warnFelImplosion:Show(self.vb.impCount)
		if self.vb.ignoreAdds then return end--Ignore late sets of adds that spawn after phase transition but before summon adds script runs that updates timers for new phase
		local nextCount = self.vb.impCount + 1
		if self:IsMythic() then
			timerFelImplosionCD:Start(49, nextCount)
		elseif self.vb.phase == 1 then
			local timers1 = self:IsNormal() and phase1ImpTimersN[nextCount] or phase1ImpTimers[nextCount]
			if timers1 then
				timerFelImplosionCD:Start(timers1, nextCount)
			end
		else
			local timers2 = self:IsNormal() and phase2ImpTimersN[nextCount] or phase2ImpTimers[nextCount]
			if timers2 then
				timerFelImplosionCD:Start(timers2, nextCount)
			end
		end
	elseif spellId == 181180 and self:AntiSpam(4, 2) then--Infernals
		self.vb.infernalCount = self.vb.infernalCount + 1
		warnInferno:Show(self.vb.infernalCount)
		if self.vb.ignoreAdds then return end--Ignore late sets of adds that spawn after phase transition but before summon adds script runs that updates timers for new phase
		local nextCount = self.vb.infernalCount + 1
		if self.vb.phase == 1 then
			local timers1 = self:IsNormal() and phase1InfernalTimersN[nextCount] or phase1InfernalTimers[nextCount]
			if timers1 then
				timerInfernoCD:Start(timers1, nextCount)
			end
		elseif self.vb.phase == 2 then
			local timers2 = self:IsMythic() and 54.8 or self:IsNormal() and phase2InfernalTimersN[nextCount] or phase2InfernalTimers[nextCount]
			if timers2 then
				timerInfernoCD:Start(timers2, nextCount)
			end
		else
--			local timers3 = self:IsNormal() and phase3InfernalTimersN[nextCount] or phase3InfernalTimers[nextCount]
--			if timers3 then
				timerInfernoCD:Start(34.8, nextCount)
--			end
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 181190 and self:AntiSpam(2, 3) then
		warnFelStreak:Show()
	elseif spellId == 181597 or spellId == 182006 then
		timerGazeCD:Start()
	elseif spellId == 181275 then
		self.vb.doomlordCount = self.vb.doomlordCount + 1
		timerCurseofLegionCD:Start(nil, self.vb.doomlordCount+1)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 181275 then
		if args:IsPlayer() then
			specWarnCurseofLegion:Show()
			local _, _, _, _, _, _, expires = UnitDebuff("Player", args.spellName)
			local debuffTime = expires - GetTime()
			yellCurseofLegion:Schedule(debuffTime - 1, 1)
			yellCurseofLegion:Schedule(debuffTime - 2, 2)
			yellCurseofLegion:Schedule(debuffTime - 3, 3)
			yellCurseofLegion:Schedule(debuffTime - 4, 4)
			yellCurseofLegion:Schedule(debuffTime - 5, 5)
		else
			warnCurseoftheLegion:Show(self.vb.doomlordCount, args.destName)
		end
	elseif spellId == 181099 then
		timerMarkofDoomCD:Start(args.sourceGUID)
		local name = args.destName
		if not tContains(doomTargets, name) then
			doomTargets[#doomTargets+1] = name
		end
		local count = #doomTargets
		self.vb.DoomTargetCount = self.vb.DoomTargetCount + 1
		self:Unschedule(breakDoom)
		if count == 3 then
			breakDoom(self)
		else
			self:Schedule(2, breakDoom, self)--3 targets, pretty slowly. I've seen at least 1.2, so make this 1.3, maybe more if needed
		end
		if args:IsPlayer() then
			specWarnMarkOfDoom:Show(self:IconNumToString(count))
			countdownMarkOfDoom:Start()
			if self:IsMythic() then
				voiceMarkOfDoom:Play("mm"..count)
			else
				voiceMarkOfDoom:Play("runout")
			end
			yellMarkOfDoom:Yell(count, count, count)
		end
		if self.Options.SetIconOnDoom2 then
			self:SetIcon(name, count)
		end
		updateRangeFrame(self)
	elseif spellId == 181191 and self:CheckInterruptFilter(args.sourceGUID, true) and self:IsMelee() and self:AntiSpam(2, 5) then--No sense in duplicating code, just use CheckInterruptFilter with arg to skip the filter setting check
		voiceFelHellfire:Play("runaway")
		specWarnFelHellfire:Show()--warn melee who are targetting infernal to run out if it's exploding
	elseif spellId == 181597 or spellId == 182006 then
		if not tContains(gazeTargets, args.destName) then
			gazeTargets[#gazeTargets+1] = args.destName
		end
		self:Unschedule(warnGazeTargts)
		if #gazeTargets == 3 then
			warnGazeTargts(self)
		else
			self:Schedule(1, warnGazeTargts, self)--At least 0.5, maybe bigger needed if warning still splits
		end
		voiceGaze:Cancel()
		if args:IsPlayer() then
			specWarnGaze:Show()
		else
			if not UnitDebuff("player", args.spellName) then
				voiceGaze:Schedule(0.3, "gathershare")
			end
		end
		if self.Options.HudMapOnGaze2 then
			DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 8, 8, nil, nil, nil, 0.5, nil, true):Appear():SetLabel(args.destName)
		end
	elseif spellId == 181119 then
		local amount = args.amount or 1
		if amount % 3 == 0 or amount > 6 then
			warnDoomSpike:Show(args.destName, amount)
			if not UnitDebuff("player", args.spellName) and not UnitIsDeadOrGhost("player") and self:AntiSpam(3, 6) then
				specWarnDoomSpikeOther:Show(args.destName)
			end
		end
		if self:IsMythic() then
			if not tContains(doomSpikeTargets, args.destName) then
				table.insert(doomSpikeTargets, args.destName)
			end
			updateRangeFrame(self)
		end
	elseif spellId == 186362 then--Only cast once per phase transition (twice whole fight)
		if not tContains(guldanTargets, args.destName) then
			table.insert(guldanTargets, args.destName)
		end
		warnWrathofGuldan:CombinedShow(0.3, args.destName)
		local icon = self.vb.wrathIcon
		if not icon then
			self:Unschedule(setWrathIcons)
			if #guldanTargets == 5 then
				setWrathIcons(self)
			else
				self:Schedule(1, setWrathIcons, self)
			end
		else
			if self.Options.SetIconOnWrath then
				self:SetIcon(args.destName, icon)
			end
		end
		if args:IsPlayer() then
			specWarnWrathofGuldan:Show()
			if icon then
				yellWrathofGuldan:Yell(icon, icon, icon)
				voiceWrath:Play("mm"..icon)
			end
		end
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(args.spellName)--Always set header to wrath if wrath is present
			if not DBM.InfoFrame:IsShown() then
				DBM.InfoFrame:Show(8, "function", updateInfoFrame, sortInfoFrame, true)
			end
		end
		if self.vb.wrathIcon then
			self.vb.wrathIcon = self.vb.wrathIcon - 1--Update icon even if icon option off, for sync accuracy
		end
		updateRangeFrame(self)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
 
function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 181099 then
		self.vb.DoomTargetCount = self.vb.DoomTargetCount - 1
		if args:IsPlayer() then
			countdownMarkOfDoom:Cancel()
		end
		updateRangeFrame(self)
		if self.Options.SetIconOnDoom2 and not self:IsLFR() then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 185147 or spellId == 182212 or spellId == 185175 then--Portals
		self.vb.portalsLeft = self.vb.portalsLeft - 1
		if spellId == 185147 and not self:IsMythic() then--Doom Lords Portal
			timerCurseofLegionCD:Stop()
			--I'd add a cancel for the Doom Lords here, but since everyone killed this portal first
			--no one ever actually learned what the cooldown was, so no timer to cancel yet!
		elseif spellId == 182212 and not self:IsMythic() then--Infernals Portal
			timerInfernoCD:Stop()
		elseif spellId == 185175 and not self:IsMythic() then--Imps Portal
			timerFelImplosionCD:Stop()
		end
		if self.vb.portalsLeft == 0 and self:AntiSpam(10, 4) and self:IsInCombat() then
			self.vb.phase = 2
			warnPhase2:Show()
			voicePhaseChange:Play("ptwo")
			if not self:IsMythic() then
				self.vb.ignoreAdds = true
				--These should be active already from pull on mythic
				--Whether or not they update is unknown, better to start no timers until more info
				timerFelHellfireCD:Start(28)
				timerGazeCD:Start(40)
				timerGlaiveComboCD:Start(42.5)
				countdownGlaiveCombo:Start(42.5)
				timerFelSeekerCD:Start(58)
			end
		end
	elseif spellId == 181597 or spellId == 182006 then
		if self.Options.HudMapOnGaze2 then
			DBMHudMap:FreeEncounterMarkerByTarget(spellId, args.destName)
		end
		if self.Options.SetIconOnGaze and not self:IsLFR() then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 181275 then
		if args:IsPlayer() then
			yellCurseofLegion:Cancel()
		end
	elseif spellId == 186362 then--Only cast once per phase transition (twice whole fight)
		tDeleteItem(guldanTargets, args.destName)
		updateRangeFrame(self)
		if self.Options.SetIconOnWrath then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 181119 and self:IsMythic() then
		tDeleteItem(doomSpikeTargets, args.destName)
		updateRangeFrame(self)
	end
end

--Switch to SPELL_SUMMON events if they exist with their associated summon spells. Has to be an event that has GUID, for the timers
function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	for i = 1, 5 do
		local unitGUID = UnitGUID("boss"..i)
		if unitGUID and not AddsSeen[unitGUID] then
			AddsSeen[unitGUID] = true
			local cid = self:GetCIDFromGUID(unitGUID)
			if cid == 91241 then--Doom Lord
				--timerShadowBoltVolleyCD:Start(nil, unitGUID)
				timerMarkofDoomCD:Start(11, unitGUID)
			end
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 91241 then--Doom Lord
		timerMarkofDoomCD:Cancel(args.destGUID)
--		timerShadowBoltVolleyCD:Cancel(args.destGUID)
	end
end

--This function isn't required by mod, i purposely put start timers on later trigger that doesn't need localizing.
--This just starts phase 3 and 4 earlier, if translation available.
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc)
	if msg:find(L.felSpire) and self:AntiSpam(10, 4) then
		self.vb.phase = self.vb.phase + 1
		if self.vb.phase == 3 then
			self.vb.ignoreAdds = true
			timerFelHellfireCD:Stop()
			timerShadowForceCD:Stop()
			countdownShadowForce:Cancel()
			timerGlaiveComboCD:Stop()
			countdownGlaiveCombo:Cancel()
			timerGazeCD:Stop()
			timerFelSeekerCD:Stop()
			timerFelHellfireCD:Start(27.8)
			timerShadowForceCD:Start(32.6)
			countdownShadowForce:Start(32.6)
			--BOth gaze and combo seem 44, which you get first is random, and it'll delay other ability
			--however they are BOTH 44ish, don't let one log fool
			timerGazeCD:Start(44.5)
			timerGlaiveComboCD:Start(44.9)
			countdownGlaiveCombo:Start(44.9)
			timerFelSeekerCD:Start(68)
			warnPhase3:Show()
			voicePhaseChange:Play("pthree")
			if self:IsMythic() then
				if self.vb.wrathIcon then
					self.vb.wrathIcon = 8
				end
				timerWrathofGuldanCD:Start(10)
			end
			--Detect when adds timers will reset (by 181301) before they come off cd, and cancel them early
			if timerFelImplosionCD:GetRemaining(self.vb.impCount+1) > 10 then
				timerFelImplosionCD:Stop()
			end
			if timerInfernoCD:GetRemaining(self.vb.infernalCount+1) > 10 then
				timerInfernoCD:Stop()
			end
			if timerCurseofLegionCD:GetRemaining(self.vb.doomlordCount+1) > 10 then
				timerCurseofLegionCD:Stop()
			end
		elseif self.vb.phase == 4 then
			self.vb.ignoreAdds = true
			timerFelHellfireCD:Stop()
			timerShadowForceCD:Stop()
			countdownShadowForce:Cancel()
			timerGlaiveComboCD:Stop()
			countdownGlaiveCombo:Cancel()
			timerGazeCD:Stop()
			timerFelSeekerCD:Stop()
			if timerInfernoCD:GetRemaining(self.vb.infernalCount+1) > 9 then
				timerInfernoCD:Stop()
			end
			timerFelHellfireCD:Start(16.9)
			timerGlaiveComboCD:Start(27.8)
			countdownGlaiveCombo:Start(27.8)
			timerGazeCD:Start(35.6)
			timerShadowForceCD:Start(47.3)
			countdownShadowForce:Start(47.3)
			timerFelSeekerCD:Start(65.6)
			warnPhase4:Show()
			voicePhaseChange:Play("pfour")
			if self:IsMythic() then
				if timerFelImplosionCD:GetRemaining(self.vb.impCount+1) > 9 then
					timerFelImplosionCD:Stop()
				end
				if timerCurseofLegionCD:GetRemaining(self.vb.doomlordCount+1) > 9 then
					timerCurseofLegionCD:Stop()
				end
				if self.vb.wrathIcon then
					self.vb.wrathIcon = 8
				end
				timerWrathofGuldanCD:Start(16.7)
			end
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 181735 then--0.1 seconds faster than combat log event for 10 yard cast.
		specWarnFelSeeker:Show()
		timerFelSeekerCD:Start()
		voiceFelSeeker:Play("watchstep")
	elseif spellId == 181301 then--Summon Adds (phase 2 start/Mythic Phase 3)
		DBM:Debug("Summon adds 181301 fired", 2)
		self.vb.ignoreAdds = false
		self.vb.impCount = 0
		timerFelImplosionCD:Stop()
		timerInfernoCD:Stop()
		timerFelImplosionCD:Start(22, 1)--Seems same for all difficulties on this one
		if not self:IsMythic() then
			self.vb.infernalCount = 0
			timerInfernoCD:Start(47.5, 1)
		else
			self.vb.doomlordCount = 0
			timerCurseofLegionCD:Stop()
			timerCurseofLegionCD:Start(45, 1)
		end
	elseif spellId == 182262 then--Summon Adds (phase 3 start/Mythic Phase 4)
		DBM:Debug("Summon adds 182262 fired", 2)
		self.vb.ignoreAdds = false
		timerFelImplosionCD:Stop()
		if not self:IsMythic() then
			self.vb.infernalCount = 0
			timerInfernoCD:Stop()
			timerInfernoCD:Start(28, 1)
			--timerFelImplosionCD:Start(22, 1)--Seems incorret
		else
			self.vb.impCount = 0
			timerCurseofLegionCD:Stop()--Done for rest of fight
			timerFelImplosionCD:Start(7, 1)
		end
	elseif spellId == 181156 then--Summon Adds, Phase 2 mythic (about 18 seconds into fight)
		--Starting mythic timers here is far more accurate. Starting on engage can be as much as 5 seconds off
		--since summon adds (when mannorth starts actually gaining energy) can variate from encounter_start
		DBM:Debug("Summon adds 181156 fired", 2)
		timerCurseofLegionCD:Start(5, 1)
		timerFelHellfireCD:Start(10.5)
		timerGlaiveComboCD:Start(25.2)
		countdownGlaiveCombo:Start(25.2)
		timerFelImplosionCD:Start(27.4, 1)
		timerFelSeekerCD:Start(40.2)
		timerGazeCD:Start(50.7)--50.8-53
		timerInfernoCD:Start(53, 1)
	--Backup phase detection. a bit slower than CHAT_MSG_RAID_BOSS_EMOTE (5.5 seconds slower)
	elseif spellId == 182263 and self.vb.phase == 2 then--Phase 3
		self.vb.phase = 3
		self.vb.ignoreAdds = true
		timerFelHellfireCD:Stop()
		timerShadowForceCD:Stop()
		countdownShadowForce:Cancel()
		timerGlaiveComboCD:Stop()
		countdownGlaiveCombo:Cancel()
		timerGazeCD:Stop()
		timerFelSeekerCD:Stop()
		timerFelHellfireCD:Start(22.3)
		timerShadowForceCD:Start(27.1)
		countdownShadowForce:Start(27.1)
		timerGazeCD:Start(39.0)
		timerGlaiveComboCD:Start(39.4)
		countdownGlaiveCombo:Start(39.4)
		timerFelSeekerCD:Start(62.5)
		warnPhase3:Show()
		voicePhaseChange:Play("pthree")
		if self:IsMythic() then
			if self.vb.wrathIcon then
				self.vb.wrathIcon = 8
			end
			timerWrathofGuldanCD:Start(4.8)
		end
		--Detect when adds timers will reset (by 181301) before they come off cd, and cancel them early
		if timerFelImplosionCD:GetRemaining(self.vb.impCount+1) > 4.8 then
			timerFelImplosionCD:Stop()
		end
		if timerInfernoCD:GetRemaining(self.vb.infernalCount+1) > 4.8 then
			timerInfernoCD:Stop()
		end
		if timerCurseofLegionCD:GetRemaining(self.vb.doomlordCount+1) > 4.8 then
			timerCurseofLegionCD:Stop()
		end
	elseif spellId == 185690 and self.vb.phase == 3 then--Phase 4
		self.vb.phase = 4
		self.vb.ignoreAdds = true
		timerFelHellfireCD:Stop()
		timerShadowForceCD:Stop()
		countdownShadowForce:Cancel()
		timerGlaiveComboCD:Stop()
		countdownGlaiveCombo:Cancel()
		timerGazeCD:Stop()
		timerFelSeekerCD:Stop()
		if timerInfernoCD:GetRemaining(self.vb.infernalCount+1) > 3.8 then
			timerInfernoCD:Stop()
		end
		timerFelHellfireCD:Start(11.4)
		timerGlaiveComboCD:Start(22.3)
		countdownGlaiveCombo:Start(22.3)
		timerGazeCD:Start(30.1)
		timerShadowForceCD:Start(41.8)
		countdownShadowForce:Start(45.8)
		timerFelSeekerCD:Start(60.1)
		warnPhase4:Show()
		voicePhaseChange:Play("pfour")
		if self:IsMythic() then
			if timerFelImplosionCD:GetRemaining(self.vb.impCount+1) > 3.8 then
				timerFelImplosionCD:Stop()
			end
			if timerCurseofLegionCD:GetRemaining(self.vb.doomlordCount+1) > 3.8 then
				timerCurseofLegionCD:Stop()
			end
			if self.vb.wrathIcon then
				self.vb.wrathIcon = 8
			end
			timerWrathofGuldanCD:Start(11.2)
		end
	elseif spellId == 181354 then--183377 or 185831 also usable with SPELL_CAST_START but i like this way more, cleaner than Antispamming the other spellids
		specWarnGlaiveCombo:Show()
		timerGlaiveComboCD:Start()
		countdownGlaiveCombo:Start()
		voiceGlaiveCombo:Play("defensive")
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 181192 and destGUID == UnitGUID("player") and self:AntiSpam(2, 5) then
		specWarnFelHellfire:Show()
		voiceFelHellfire:Play("runaway")
	elseif spellId == 190070 and destGUID == UnitGUID("player") and self:AntiSpam(1.5, 7) then
		specWarnFelPillar:Show()
		voiceFelPillar:Play("runaway")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:OnSync(msg)
	if msg == "WrathByRole" then
		self.vb.wrathIcon = false
	end
end
