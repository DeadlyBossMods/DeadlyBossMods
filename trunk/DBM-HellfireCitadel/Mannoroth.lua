local mod	= DBM:NewMod(1395, "DBM-HellfireCitadel", nil, 669)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(91349)--91305 Fel Iron Summoner
mod:SetEncounterID(1795)
mod:SetZone()
mod:SetUsedIcons(3, 2, 1)
mod:SetHotfixNoticeRev(13988)
mod.respawnTime = 30
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 181126 181132 181557 183376 181793 181792 181738 181799 182084 185830 181948 182040 182076 182077 186348 181099 181597 182006",
	"SPELL_CAST_SUCCESS 181190 181597 182006",
	"SPELL_AURA_APPLIED 181099 181275 181191 181597 182006",
	"SPELL_AURA_APPLIED_DOSE 181119",
	"SPELL_AURA_REMOVED 181099 181275 185147 182212 185175 181597 182006 181275",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_ABSORBED",
	"SPELL_SUMMON 181255 181180",
	"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
	"UNIT_DIED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--(ability.id = 181557 or ability.id = 181948 or ability.id = 181799 or ability.id = 182084 or ability.id = 186348) and type = "begincast" or (ability.id = 181597 or ability.id = 182006) and type = "cast" or (ability.id = 185147 or ability.id = 182212 or ability.id = 185175) and type = "removebuff"
--TODO, get timer for 2nd doom lord spawning, if some group decides to do portals in a bad order and not kill that portal summoner first
--TODO, get longer phase 4 log because log i have isn't long enough to see why felstorm has a longer cd in phase 4
--TODO, custom voice for shadowforce? It works almost identical to helm of command from lei shen. Did that have a voice usuable here?
--TODO, Mythic timers and whether or not they reset on phase changes
--Adds
----Doom Lords
local warnCurseoftheLegion			= mod:NewTargetAnnounce(181275, 3)--Spawn
local warnMarkofDoom				= mod:NewTargetAnnounce(181099, 4)
local warnDoomSpike					= mod:NewStackAnnounce(181119, 3, nil, "Tank")
----Fel Imp
local warnFelImplosion				= mod:NewCountAnnounce(181255, 3)--Spawn
----Dread Infernals
local warnInferno					= mod:NewCountAnnounce(181180, 3)--Spawn
local warnFelStreak					= mod:NewSpellAnnounce(181190, 3, nil, "Melee")--Change to target scan/personal/near warning if possible
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
local yellMarkOfDoom				= mod:NewPosYell(181099)--This need to know at apply, only player needs to know when it's fading
local specWarnShadowBoltVolley		= mod:NewSpecialWarningInterrupt(181126, "-Healer", nil, nil, 1, 2)
local specWarnDoomSpikeOther		= mod:NewSpecialWarningTaunt(181119, nil, nil, nil, 1, 2)
----Fel Imps
local specWarnFelBlast				= mod:NewSpecialWarningInterrupt(181132, false, nil, 2, 1, 2)--Can be spammy, but someone may want it
----Dread Infernals
local specWarnFelHellfire			= mod:NewSpecialWarningDodge(181191, "Melee", nil, nil, 4, 2)
----Gul'dan
local specWarnWrathofGuldan			= mod:NewSpecialWarningSpell(186348, nil, nil, nil, 2)
--Mannoroth
local specWarnGlaiveCombo			= mod:NewSpecialWarningSpell(181354, "Tank", nil, nil, 3, 2)--Active mitigation or die mechanic
local specWarnMassiveBlast			= mod:NewSpecialWarningSpell(181359, nil, nil, nil, 1, 2)
local specWarnMassiveBlastOther		= mod:NewSpecialWarningTaunt(181359, nil, nil, nil, 1, 2)
local specWarnFelHellStorm			= mod:NewSpecialWarningSpell(181557, nil, nil, nil, 2, 2)
local specWarnGaze					= mod:NewSpecialWarningYou(181597)
local yellGaze						= mod:NewPosYell(181597)
local specWarnFelSeeker				= mod:NewSpecialWarningDodge(181735, nil, nil, nil, 2, 2)
local specWarnShadowForce			= mod:NewSpecialWarningSpell(181799, nil, nil, nil, 3)

--Adds
mod:AddTimerLine(OTHER)
----Doom Lords
local timerCurseofLegionCD			= mod:NewAITimer(107, 181275, nil, nil, nil, 1)--Maybe see one day, in LFR or something when group is terrible or doesn't kill doom lord portal first
local timerMarkofDoomCD				= mod:NewCDTimer(31.5, 181099, nil, "-Tank", nil, 3)
local timerShadowBoltVolleyCD		= mod:NewCDTimer(12, 181126, nil, "-Healer", nil, 4)
----Fel Imps
local timerFelImplosionCD			= mod:NewNextCountTimer(46, 181255, nil, nil, nil, 1)
----Infernals
local timerInfernoCD				= mod:NewNextCountTimer(107, 181180, nil, nil, nil, 1)
----Gul'dan
local timerWrathofGuldanCD			= mod:NewAITimer(107, 186348, nil, nil, nil, 3)
--Mannoroth
mod:AddTimerLine(L.name)
local timerGlaiveComboCD			= mod:NewCDTimer(30, 181354, nil, "Tank", nil, 5)--30 seconds unless delayed by something else
local timerFelHellfireCD			= mod:NewCDTimer(35, 181557, nil, nil, nil, 2)--35, unless delayed by other things.
local timerGazeCD					= mod:NewCDTimer(47.1, 181597, nil, nil, nil, 3)--As usual, some variation do to other abilities
local timerFelSeekerCD				= mod:NewCDTimer(50, 181735, nil, nil, nil, 2)--Small sample size, confirm it's not shorter if not delayed by things.
local timerShadowForceCD			= mod:NewCDTimer(52.2, 181799, nil, nil, nil, 3)

--local berserkTimer					= mod:NewBerserkTimer(360)

local countdownGlaiveCombo			= mod:NewCountdown("Alt30", 181354, "Tank")
local countdownMarkOfDoom			= mod:NewCountdownFades("Alt15", 181099)
local countdownShadowForce			= mod:NewCountdown("AltTwo52", 181799)

local voicePhaseChange				= mod:NewVoice(nil, nil, DBM_CORE_AUTO_VOICE2_OPTION_TEXT)
local voiceGaze						= mod:NewVoice(181597, false) --gather share
local voiceMarkOfDoom				= mod:NewVoice(181099) --run out
local voiceFelHellfire				= mod:NewVoice(181191, "Melee") --runaway
local voiceShadowBoltVolley			= mod:NewVoice(181126, "-Healer")
local voiceFelBlast					= mod:NewVoice(181132, "-Healer")
local voiceFelSeeker				= mod:NewVoice(181132)--watchstep
local voiceGlaiveCombo				= mod:NewVoice(181354, "Tank")--Defensive
local voiceMassiveBlast				= mod:NewVoice(181359, "Tank")--changemt

mod:AddRangeFrameOption(20, 181099)
mod:AddHudMapOption("HudMapOnGaze", 181597)
mod:AddInfoFrameOption(181597)

mod.vb.DoomTargetCount = 0
mod.vb.portalsLeft = 3
mod.vb.phase = 1
mod.vb.impCount = 0
mod.vb.infernalCount = 0
mod.vb.ignoreAdds = false
local phase1ImpTimers = {15, 32.2, 24, 15, 10}--Spawn 33% faster each wave, but cannot confirm it goes lower than 10, if it does, next would be 6.6
local phase1ImpTimersN = {15, 32.2, 24, 24}--Normal doesn't go below 24? need larger sample size. Normal differently two 24s in a row and didn't drop to 15
local phase2ImpTimers = {24.5, 39, 39, 30.5, 30}--The same, for now
local phase2ImpTimersN = {24.5, 39, 39, 30.5, 30}--But normal may have a lower limit, like phase 1, so coded in two tables for now.
local phase1InfernalTimers = {18.4, 40, 30, 20, 20, 20}--Confirmed this far on heroic
local phase1InfernalTimersN = {18.4, 40, 30, 30}--Normal probably doesn't drop below 30?
local phase2InfernalTimers = {47.5, 44.8, 44.8, 35}--So far normal and heroic same, but if phase goes on longer probably different (with normal having a higher minimum)
local phase2InfernalTimersN = {47.5, 44.8, 44.8, 35}--So far normal and heroic same, but if phase goes on longer probably different (with normal having a higher minimum)
local phase3InfernalTimers = {28, 34.8, 35, 34.8, 34.8}--Again, the same now, but two tables FOR NOW until I can confirm whether or not they differ for REALLY long pulls
local phase3InfernalTimersN = {28, 34.8, 35, 34.8, 34.8}--^^

local gazeTargets = {}
local doomTargets = {}
local AddsSeen = {}
local playerName = UnitName("player")
local debuffFilter
local debuffName = GetSpellInfo(181099)
local UnitDebuff = UnitDebuff
do
	debuffFilter = function(uId)
		if UnitDebuff(uId, debuffName) then
			return true
		end
	end
end

local function updateRangeFrame(self)
	if not self.Options.RangeFrame then return end
	if self.vb.DoomTargetCount > 0 then
		if UnitDebuff("Player", debuffName) then
			DBM.RangeCheck:Show(20)
		else
			DBM.RangeCheck:Show(20, debuffFilter)
		end
	else
		DBM.RangeCheck:Hide()
	end
end

local lines = {}
local function sortInfoFrame(a, b) 
	local a = lines[a]
	local b = lines[b]
	if not tonumber(a) then a = -1 end
	if not tonumber(b) then b = -1 end
	if a < b then return true else return false end
end

local gaze1, gaze2 = GetSpellInfo(181597), GetSpellInfo(182006)
local function updateInfoFrame()
	table.wipe(lines)
	local total = 0
	for i = 1, #gazeTargets do
		local name = gazeTargets[i]
		local uId = DBM:GetRaidUnitId(name)
		if UnitDebuff(uId, gaze1) or UnitDebuff(uId, gaze2) then
			total = total + 1
			lines[name] = i
		end
	end
	if total == 0 then--None found, hide infoframe because all broke
		DBM.InfoFrame:Hide()
	end
	return lines
end

local function warnGazeTargts(self)
	table.sort(gazeTargets)
	warnGaze:Show(table.concat(gazeTargets, "<, >"))
	if self:IsLFR() then return end
	for i = 1, #gazeTargets do
		local name = gazeTargets[i]
		if name == playerName then
			yellGaze:Yell(i)
		end
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(gaze1)
		DBM.InfoFrame:Show(5, "function", updateInfoFrame, sortInfoFrame)
	end
end

local function breakDoom(self)
	table.sort(doomTargets)
	warnMarkofDoom:Show(table.concat(doomTargets, "<, >"))
	if self:IsLFR() then return end
	for i = 1, #doomTargets do
		local name = doomTargets[i]
		if name == playerName then
			yellMarkOfDoom:Yell(i)
		end
	end
end

function mod:OnCombatStart(delay)
	table.wipe(doomTargets)
	table.wipe(gazeTargets)
	table.wipe(AddsSeen)
	self.vb.ignoreAdds = false
	self.vb.impCount = 0
	self.vb.infernalCount = 0
	self.vb.phase = 1
	self.vb.portalsLeft = 3
	self.vb.DoomTargetCount = 0
	timerFelImplosionCD:Start(15-delay, 1)
	timerInfernoCD:Start(18.4-delay, 1)--Verify, seems 20 now
	timerCurseofLegionCD:Start(1)
	if self:IsMythic() then
		--Start fight on phase 2?
		--Do phase 2 or phase 1 infernal/imp timers get used on combat start?
		timerWrathofGuldanCD:Start(1)
		DBM:AddMsg("This mod will not work correctly on mythic. Not until someones makes their logs available for this. Or more idealy, captures logs with transcriptor so the phase change detection can be fixed.")
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.HudMapOnGaze then
		DBMHudMap:Disable()
	end
end 

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 181557 or spellId == 181948 then
		specWarnFelHellStorm:Show()
		timerFelHellfireCD:Start()
	elseif spellId == 181126 then
		timerShadowBoltVolleyCD:Start(args.sourceGUID)
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
		voiceMassiveBlast:Schedule(1, "changemt")
		local targetName, uId, bossuid = self:GetBossTarget(91349, true)
		local tanking, status = UnitDetailedThreatSituation("player", bossuid)
		if tanking or (status == 3) then--Player is current target
			specWarnMassiveBlast:Show()
		else
			specWarnMassiveBlastOther:Schedule(1, targetName)
		end
	elseif spellId == 181793 or spellId == 182077 then--Melee (10)
		warnFelseeker:Show(10)
	elseif spellId == 181792 or spellId == 182076 then--Ranged (20)
		warnFelseeker:Show(20)
	elseif spellId == 181738 or spellId == 182040 then--Ranged (35)
		warnFelseeker:Show(35)
	elseif spellId == 181799 or spellId == 182084 then
		timerShadowForceCD:Start()
		countdownShadowForce:Start(52.5)
		if self:IsTank() and self.vb.phase == 3 then return end--Doesn't target tanks in phase 3, ever.
		specWarnShadowForce:Show()
	elseif spellId == 186348 then
		specWarnWrathofGuldan:Show()
		timerWrathofGuldanCD:Start()
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
		if self.vb.phase == 1 then
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
			local timers2 = self:IsNormal() and phase2InfernalTimersN[nextCount] or phase2InfernalTimers[nextCount]
			if timers2 then
				timerInfernoCD:Start(timers2, nextCount)
			end
		else
			local timers3 = self:IsNormal() and phase3InfernalTimersN[nextCount] or phase3InfernalTimers[nextCount]
			if timers3 then
				timerInfernoCD:Start(timers3, nextCount)
			end
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 181190 and self:AntiSpam(2, 3) then
		warnFelStreak:Show()
	elseif spellId == 181597 or spellId == 182006 then
		timerGazeCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 181275 then
		timerCurseofLegionCD:Start()
		if args:IsPlayer() then
			specWarnCurseofLegion:Show()
			local _, _, _, _, _, _, expires = UnitDebuff("Player", args.spellName)
			local debuffTime = expires - GetTime()
			yellCurseofLegion:Schedule(debuffTime - 1, 1)
			yellCurseofLegion:Schedule(debuffTime - 2, 2)
			yellCurseofLegion:Schedule(debuffTime - 3, 3)
			yellCurseofLegion:Schedule(debuffTime - 2, 4)
			yellCurseofLegion:Schedule(debuffTime - 5, 5)
		else
			warnCurseoftheLegion:Show(args.destName)
		end
	elseif spellId == 181099 then
		timerMarkofDoomCD:Start(args.sourceGUID)
		doomTargets[#doomTargets+1] = args.destName
		self.vb.DoomTargetCount = self.vb.DoomTargetCount + 1
		self:Unschedule(breakDoom)
		self:Schedule(1.3, breakDoom, self)--3 targets, pretty slowly. I've seen at least 1.2, so make this 1.3, maybe more if needed
		if args:IsPlayer() then
			specWarnMarkOfDoom:Show()
			countdownMarkOfDoom:Start()
			voiceMarkOfDoom:Schedule(8.5, "runout")
		end
		updateRangeFrame(self)
	elseif spellId == 181191 and self:CheckInterruptFilter(args.sourceGUID, true) then--No sense in duplicating code, just use CheckInterruptFilter with arg to skip the filter setting check
		voiceFelHellfire:Play("runaway")
		specWarnFelHellfire:Show()--warn melee who are targetting infernal to run out if it's exploding
	elseif spellId == 181597 or spellId == 182006 then
		gazeTargets[#gazeTargets+1] = args.destName
		self:Unschedule(warnGazeTargts)
		self:Schedule(0.5, warnGazeTargts, self)--At least 0.5, maybe bigger needed if warning still splits
		voiceGaze:Cancel()
		if args:IsPlayer() then
			specWarnGaze:Show()
		else
			if not UnitDebuff("player", args.spellName) then
				voiceGaze:Schedule(0.3, "gathershare")
			end
		end
		if self.Options.HudMapOnGaze then
			DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 3, 8, 1, 1, 0, 0.5, nil, true, 1):Pulse(0.5, 0.5)
		end
	elseif spellId == 181119 then
		local amount = args.amount or 1
		if amount % 3 == 0 or amount > 6 then
			warnDoomSpike:Show(args.destName, amount)
			if not UnitDebuff("player", args.spellName) and not UnitIsDeadOrGhost("player") and self:AntiSpam(3, 6) then
				specWarnDoomSpikeOther:Show(args.destName)
			end
		end
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
	elseif spellId == 185147 or spellId == 182212 or spellId == 185175 then--Portals
		self.vb.portalsLeft = self.vb.portalsLeft - 1
		if spellId == 185147 then--Doom Lords Portal
			timerCurseofLegionCD:Cancel()
			--I'd add a cancel for the Doom Lords here, but since everyone killed this portal first
			--no one ever actually learned what the cooldown was, so no timer to cancel yet!
		elseif spellId == 182212 then--Infernals Portal
			timerInfernoCD:Cancel()
		elseif spellId == 185175 then--Imps Portal
			timerFelImplosionCD:Cancel()
		end
		if self.vb.portalsLeft == 0 and self:AntiSpam(10, 4) and self:IsInCombat() then
			self.vb.phase = 2
			self.vb.ignoreAdds = true
			--These should be active already from pull on mythic
			--Whether or not they update is unknown, better to start no timers until more info
			if not self:IsMythic() then
				timerFelHellfireCD:Start(28)
				timerGazeCD:Start(40)
				timerGlaiveComboCD:Start(42.5)
				countdownGlaiveCombo:Start(42.5)
				timerFelSeekerCD:Start(58)
			end
			warnPhase2:Show()
			voicePhaseChange:Play("ptwo")
		end
	elseif spellId == 181597 or spellId == 182006 then
		if self.Options.HudMapOnGaze then
			DBMHudMap:FreeEncounterMarkerByTarget(spellId, args.destName)
		end
	elseif spellId == 181275 then
		if args:IsPlayer() then
			yellCurseofLegion:Cancel()
		end
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
		timerShadowBoltVolleyCD:Cancel(args.destGUID)
	end
end

--Todo, verify mythic has no new emotes with guldan's name, if not, just check npc for "Gul'dan"
--This function isn't required by mod, i purposely put start timers on later trigger that doesn't need localizing.
--This just starts phase 3 and 4 earlier, if translation available.
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc)
	if msg:find(L.felSpire) and self:AntiSpam(10, 4) then
		self.vb.phase = self.vb.phase + 1
		if self.vb.phase == 3 then
			timerFelHellfireCD:Cancel()
			timerShadowForceCD:Cancel()
			countdownShadowForce:Cancel()
			timerGlaiveComboCD:Cancel()
			countdownGlaiveCombo:Cancel()
			timerGazeCD:Cancel()
			timerFelSeekerCD:Cancel()
			timerFelHellfireCD:Start(27.8)
			timerShadowForceCD:Start(32.6)
			countdownShadowForce:Start(32.6)
			--BOth gaze and combo seem 40, which you get first is random, and it'll delay other ability
			--however they are BOTH 40ish, don't let one log fool
			timerGazeCD:Start(44.5)
			timerGlaiveComboCD:Start(44.9)
			countdownGlaiveCombo:Start(44.9)
			self.vb.ignoreAdds = true
			timerFelSeekerCD:Start(68)
			warnPhase3:Show()
			voicePhaseChange:Play("pthree")
		elseif self.vb.phase == 4 then
			timerFelHellfireCD:Cancel()
			timerShadowForceCD:Cancel()
			countdownShadowForce:Cancel()
			timerGlaiveComboCD:Cancel()
			countdownGlaiveCombo:Cancel()
			timerGazeCD:Cancel()
			timerFelSeekerCD:Cancel()
			timerInfernoCD:Cancel()
			timerFelHellfireCD:Start(16.9)
			timerGlaiveComboCD:Start(27.8)
			countdownGlaiveCombo:Start(27.8)
			timerGazeCD:Start(35.6)
			timerShadowForceCD:Start(47.3)
			countdownShadowForce:Start(47.3)
			timerFelSeekerCD:Start(65.6)
			warnPhase4:Show()
			voicePhaseChange:Play("pfour")
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 181735 then
		specWarnFelSeeker:Show()
		timerFelSeekerCD:Start()
		voiceFelSeeker:Play("watchstep")
	elseif spellId == 181301 then--Summon Adds (phase 2 start)
		DBM:Debug("Summon adds 181301 fired", 2)
		self.vb.ignoreAdds = false
		self.vb.impCount = 0
		self.vb.infernalCount = 0
		timerFelImplosionCD:Cancel()
		timerInfernoCD:Cancel()
		timerFelImplosionCD:Start(24.5, 1)
		timerInfernoCD:Start(47.5, 1)
	elseif spellId == 182262 then--Summon Adds (phase 3 start)
		DBM:Debug("Summon adds 182262 fired", 2)
		self.vb.ignoreAdds = false
		self.vb.infernalCount = 0
		timerFelImplosionCD:Cancel()
		timerInfernoCD:Cancel()
		timerInfernoCD:Start(28, 1)
	elseif spellId == 181156 then--Exists on wowhead and added in 6.2, likely related to this fight but unknown purpose, probably mythic?
		DBM:Debug("Summon adds 181156 fired", 2)
	--Backup phase detection. a bit slower than CHAT_MSG_RAID_BOSS_EMOTE (5.5 seconds slower)
	elseif spellId == 182263 and self.vb.phase == 2 then--Phase 3
		self.vb.phase = 3
		self.vb.ignoreAdds = true
		timerFelHellfireCD:Cancel()
		timerShadowForceCD:Cancel()
		countdownShadowForce:Cancel()
		timerGlaiveComboCD:Cancel()
		countdownGlaiveCombo:Cancel()
		timerGazeCD:Cancel()
		timerFelSeekerCD:Cancel()
		timerFelHellfireCD:Start(22.3)
		timerShadowForceCD:Start(27.1)
		countdownShadowForce:Start(27.1)
		timerGazeCD:Start(39.0)
		timerGlaiveComboCD:Start(39.4)
		countdownGlaiveCombo:Start(39.4)
		timerFelSeekerCD:Start(62.5)
		if self:IsMythic() then
			--Assumed it may not reset like other abilities
			timerWrathofGuldanCD:Cancel()
			timerWrathofGuldanCD:Start(3)
		end
		warnPhase3:Show()
		voicePhaseChange:Play("pthree")
	elseif spellId == 185690 and self.vb.phase == 3 then--Phase 4
		self.vb.phase = 4
		timerFelHellfireCD:Cancel()
		timerShadowForceCD:Cancel()
		countdownShadowForce:Cancel()
		timerGlaiveComboCD:Cancel()
		countdownGlaiveCombo:Cancel()
		timerGazeCD:Cancel()
		timerFelSeekerCD:Cancel()
		timerInfernoCD:Cancel()
		timerFelHellfireCD:Start(11.4)
		timerGlaiveComboCD:Start(22.3)
		countdownGlaiveCombo:Start(22.3)
		timerGazeCD:Start(30.1)
		timerShadowForceCD:Start(41.8)
		countdownShadowForce:Start(45.8)
		timerFelSeekerCD:Start(60.1)
		if self:IsMythic() then
			--Assumed it may not reset like other abilities
			timerWrathofGuldanCD:Cancel()
			timerWrathofGuldanCD:Start(4)
		end
		warnPhase4:Show()
		voicePhaseChange:Play("pfour")
	elseif spellId == 181354 then--183377 or 185831 also usable with SPELL_CAST_START but i like this way more, cleaner.
		specWarnGlaiveCombo:Show()
		timerGlaiveComboCD:Start()
		countdownGlaiveCombo:Start()
		voiceGlaiveCombo:Play("defensive")
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 173192 and destGUID == UnitGUID("player") and self:AntiSpam(2, 5) then

	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE
--]]
