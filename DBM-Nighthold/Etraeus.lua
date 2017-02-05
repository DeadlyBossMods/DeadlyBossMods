local mod	= DBM:NewMod(1732, "DBM-Nighthold", nil, 786)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(103758)
mod:SetEncounterID(1863)
mod:SetZone()
--mod:SetUsedIcons(8, 7, 6, 3, 2, 1)
mod:SetHotfixNoticeRev(15752)
mod.respawnTime = 30--or 35 or 40

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 205408 206949 206517 207720 207439 216909",
	"SPELL_CAST_SUCCESS 206464 206464 206936 205649 207143 205984 214335 214167 221875",
	"SPELL_AURA_APPLIED 205429 216344 216345 205445 205984 214335 214167 206585 206936 205649 207143 206398",
	"SPELL_AURA_REMOVED 205429 216344 216345 205445 205984 214335 214167 206585 206936 205649 207143",
	"SPELL_SUMMON 207813",
	"SPELL_PERIODIC_DAMAGE 206398",
	"SPELL_PERIODIC_MISSED 206398",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"UNIT_AURA player"
)

--TODO, evalulate hud size for conjunction for range check/hud. 5 yards guessed.
--TODO, felburst stacks/swapping?
--TODO, does void nova even merit a special warning, or regular?
--TODO, void ejection gone?
--[[
(ability.id = 205408 or ability.id = 206949 or ability.id = 206517 or ability.id = 207720 or ability.id = 207439 or ability.id = 216909 or ability.id = 221875) and type = "begincast" or
(ability.id = 205984 or ability.id = 214335 or ability.id = 214167 or ability.id = 221875) and type = "cast" or
(ability.id = 206464 or ability.id = 206936 or ability.id = 205649 or ability.id = 207143) and type = "cast"
--]]
--Base abilities
local warnStarSignCrab				= mod:NewTargetAnnounce(205429, 2)--Yellow (looks orange but icon text is yellow)
local warnStarSignDragon			= mod:NewTargetAnnounce(216344, 2)--Blue
local warnStarSignHunter			= mod:NewTargetAnnounce(216345, 2)--Green
local warnStarSignWolf				= mod:NewTargetAnnounce(205445, 2)--Red
local warnGravitationalPull			= mod:NewTargetAnnounce(205984, 3, nil, "Tank")
--Stage One: The Dome of Observation
local warnCoronalEjection			= mod:NewTargetAnnounce(206464, 2)
--Stage Two: Absolute Zero
local warnIcyEjection				= mod:NewTargetAnnounce(206936, 2)
--Stage Three: A Shattered World
local warnFelEjection				= mod:NewTargetAnnounce(205649, 2)
local warnFelEjectionPuddle			= mod:NewCountAnnounce(205649, 2)
--Stage Four: Inevitable Fate
--local warnVoidEjection				= mod:NewTargetAnnounce(207143, 2)

local specWarnGravitationalPull		= mod:NewSpecialWarningYou(205984, nil, nil, nil, 3, 2)
local specWarnGravitationalPullOther= mod:NewSpecialWarningTaunt(205984, nil, nil, nil, 1, 2)
local yellGravitationalPull			= mod:NewFadesYell(205984)
--Stage One: The Dome of Observation
local specWarnCoronalEjection		= mod:NewSpecialWarningMoveAway(206464, nil, nil, nil, 1, 2)
--Stage Two: Absolute Zero
local specWarnIcyEjection			= mod:NewSpecialWarningMoveAway(206936, nil, nil, nil, 1, 2)
local yellIcyEjection				= mod:NewFadesYell(206936)
local specWarnFrigidNova			= mod:NewSpecialWarningSpell(206949, nil, nil, nil, 2, 2)--maybe change to MoveTo warning
--Stage Three: A Shattered World
local specWarnFelEjection			= mod:NewSpecialWarningMoveAway(205649, nil, nil, nil, 1, 2)
local yellFelEjection				= mod:NewYell(205649)
local yellFelEjectionFade			= mod:NewFadesYell(205649)
local specWarnFelNova				= mod:NewSpecialWarningRun(206517, nil, nil, nil, 4, 2)
local specWarnFelFlame				= mod:NewSpecialWarningMove(206398, nil, nil, nil, 1, 2)
--Stage Four: Inevitable Fate
local specWarnThing					= mod:NewSpecialWarningSwitch("ej13057", "Tank", nil, 2, 1, 2)
local specWarnWitnessVoid			= mod:NewSpecialWarningSpell(207720, nil, nil, nil, 1, 2)
local specWarnVoidEjection			= mod:NewSpecialWarningMoveAway(207143, nil, nil, nil, 1, 2)--Should this be a move away, does void burst do any damage?
local specWarnVoidNova				= mod:NewSpecialWarningSpell(207439, nil, nil, nil, 2, 2)
local specWarnWorldDevouringForce	= mod:NewSpecialWarningDodge(216909, nil, nil, nil, 3, 2)
--Mythic
local specWarnConjunction			= mod:NewSpecialWarningMoveAway(205408, nil, nil, nil, 3, 2)
local specWarnConjunctionSign		= mod:NewSpecialWarningYouPos(205408, nil, nil, nil, 1, 6)


--Base abilities
local timerGravPullCD				= mod:NewCDTimer(28, 205984, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)
--Stage One: The Dome of Observation
mod:AddTimerLine(SCENARIO_STAGE:format(1))
--local timerCoronalEjectionCD		= mod:NewCDTimer(16, 206464, nil, nil, nil, 3)--CD is not known, always push phase 2 before this is cast 2nd time
--Stage Two: Absolute Zero
mod:AddTimerLine(SCENARIO_STAGE:format(2))
local timerIcyEjectionCD			= mod:NewCDCountTimer(16, 206936, nil, nil, nil, 3)
local timerFrigidNovaCD				= mod:NewCDCountTimer(61.5, 206949, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)
--Stage Three: A Shattered World
mod:AddTimerLine(SCENARIO_STAGE:format(3))
local timerFelEjectionCD			= mod:NewCDCountTimer(16, 205649, nil, nil, nil, 3)
local timerFelNovaCD				= mod:NewCDCountTimer(25, 206517, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)
--Stage Four: Inevitable Fate
mod:AddTimerLine(SCENARIO_STAGE:format(4))
local timerWitnessVoid				= mod:NewCastTimer(4, 207720, nil, nil, nil, 2)
local timerWitnessVoidCD			= mod:NewCDTimer(13, 207720, nil, nil, nil, 2, nil, DBM_CORE_HEALER_ICON)
--local timerVoidEjectionCD			= mod:NewCDCountTimer(16, 207143, nil, nil, nil, 3)--Where did it go? wasn't on normal test and wasn't on heroic retest
local timerVoidNovaCD				= mod:NewCDCountTimer(74, 207439, nil, nil, nil, 2)--Only saw a single pull it was cast twice, so CD needs more verification
local timerWorldDevouringForceCD	= mod:NewCDCountTimer(42, 216909, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON..DBM_CORE_HEROIC_ICON)
local timerThingCD					= mod:NewCDTimer(63, "ej13057", 207813, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
mod:AddTimerLine(ENCOUNTER_JOURNAL_SECTION_FLAG12)
local timerConjunctionCD			= mod:NewCDCountTimer(16, 205408, nil, nil, nil, 3, nil, DBM_CORE_HEROIC_ICON)
local timerConjunction				= mod:NewBuffFadesTimer(10, 207720, nil, nil, nil, 5, nil, DBM_CORE_DEADLY_ICON)

--local berserkTimer					= mod:NewBerserkTimer(463)

--Base abilities
local countdownConjunction			= mod:NewCountdownFades("AltTwo10", 205408, nil, nil, 10)
local countdownGravPull				= mod:NewCountdownFades("Alt10", 205984)--Maybe change to everyone if it works like I think
--Stage One: The Dome of Observation
--Stage Two: Absolute Zero
--Stage Three: A Shattered World
--Stage Four: Inevitable Fate
local countWorldDevouringForce		= mod:NewCountdown(15, 216909)

--Base abilities
local voiceConjunction				= mod:NewVoice(205408)--scatter/find <type>
local voiceGravPull					= mod:NewVoice(205984)--targetyou/tauntboss
--Stage One: The Dome of Observation
local voiceCoronalEjection			= mod:NewVoice(206464)--runout
--Stage Two: Absolute Zero
local voiceIcyEjection				= mod:NewVoice(206936)--runout
local voiceFrigidNova				= mod:NewVoice(206949)--gathershare
--Stage Three: A Shattered World
local voiceFelEjection				= mod:NewVoice(205649)--runout/keepmove
local voiceFelnova					= mod:NewVoice(206517)--justrun
local voiceFelFlame					= mod:NewVoice(206398)--runaway
--Stage Four: Inevitable Fate
local voiceThing					= mod:NewVoice("ej13057", "-Healer")--bigmob
local voiceWitnessVoid				= mod:NewVoice(207720)--turnaway
local voiceVoidEjection				= mod:NewVoice(207143)--runout
local voiceVoidNova					= mod:NewVoice(207439)--aesoon
local voiceWorldDevouringForce		= mod:NewVoice(216909)--farfromline


mod:AddRangeFrameOption("5/8")
mod:AddHudMapOption("HudMapOnConjunction", 205408)
mod:AddNamePlateOption("NPAuraOnConjunction", 205408, false)
mod:AddBoolOption("ShowNeutralColor", false)
mod:AddInfoFrameOption(205408)--really needs a "various" option

mod.vb.StarSigns = 0
mod.vb.phase = 1
mod.vb.icyEjectionCount = 0
mod.vb.felEjectionCount = 0
mod.vb.frostNovaCount = 0
mod.vb.felNovaCount = 0
mod.vb.voidNovaCount = 0
mod.vb.grandConCount = 0
mod.vb.worldDestroyingCount = 0
mod.vb.isPhaseChanging = false
--mod.vb.voidEjectionCount = 0
--These timers are self corrective, which is annoying when all inclusive but better if scrubbing short timers
--For example Icy will always be 35.2, 64.5, 24.7 if you scrub the short timers or within 0.3. However including short timers and you get more variation.
--For time being, i'll be all inclusive, particuarlly with void since some of the shorter auto correcting ones are over 10 seconds.
--Example of self correction. Note 3rd pull, because of the 14 being late by 3 seconds, the 3 seconds corrected from the 20.
--"207143-Void Ejection" = "pull:338.3, 4.5, 14.2, 20.7, 1.6, 7.3, 26.5, 2.4",
--"207143-Void Ejection" = "pull:328.7, 5.7, 14.1, 20.7, 2.8, 6.1, 25.7, 4.9",
--"207143-Void Ejection" = "pull:326.8, 4.4, 17.5, 17.4, 4.6, 4.7, 26.3, 4.8",
--For all inclusive, i'll simply use lowest observed time for each count, which will give close approx cd timer but imprecise to be a "next" timer.
local icyEjectionTimers = {24.5, 34.4, 6.5, 4.8, 50.2, 1.2, 2.4, 25.6, 2.8}--43.3, 35.6, 8.1, 4.1, 52.2, 1.2, 2.4
local felEjectionTimers = {18.2, 3.6, 3.2, 2.4, 10.2, 4.4, 2.8, 32.8, 4.0, 1.6, 4.0, 4.5, 22.3, 6.9, 17.0, 1.6, 1.2, 2.0, 18.3, 0.4}--10 after 4, 32 after 7, 22 after 12, 17 after 14, 18 after 18
local mythicfelEjectionTimers = {17.4, 3.2, 2.8, 2.4, 9.3, 2.4, 3.2, 31.2, 2, 1.2, 13.4, 1.2, 1.7, 23, 8.5, 9.3, 2.5, 1.5, 24.3, 3.2}
local voidEjectionTimers = {24, 3.2, 14.1, 17.4, 0.8, 4.7, 25.7, 2.3}
--local felNovaTImers = {34.8, 31.3, 29.3}--Latest is 47.1, 45.0, 25.1. Currently unused. for now just doing 45 or 25
local worldDestroyingTimers = {22, 42, 57}
local ps1Grand = {15, 12.2}
local ps2Grand = {27, 44.9, 58.3}
local ps3Grand = {58.7, 43, 41.4}
local ps4Grand = {48, 61.7, 50}
local abZeroDebuff, chilledDebuff, gravPullDebuff = GetSpellInfo(206585), GetSpellInfo(206589), GetSpellInfo(205984)
local icyEjectionDebuff, coronalEjectionDebuff, voidEjectionDebuff = GetSpellInfo(206936), GetSpellInfo(206464), GetSpellInfo(207143)
local crabDebuff, dragonDebuff, hunterDebuff, wolfDebuff = GetSpellInfo(205429), GetSpellInfo(216344), GetSpellInfo(216345), GetSpellInfo(205445)
local crabs = {}
local dragons = {}
local hunters = {}
local wolves = {}
local UnitDebuff = UnitDebuff
local voidWarned = false
local chilledFilter, tankFilter
do
	chilledFilter = function(uId)
		if UnitDebuff(uId, chilledDebuff) then
			return true
		end
	end
	tankFilter = function(uId)
		if mod:IsTanking(uId, "boss1") then
			return true
		end
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
		local infoNeeded = false
		--Star Signs Helper
		--If player has debuff, find and show other players with same debuff as player
		if UnitDebuff("player", crabDebuff) then
			infoNeeded = true
			for i = 1, #crabs do
				local name = crabs[i]
				lines[name] = ""
			end
		elseif UnitDebuff("player", dragonDebuff) then
			infoNeeded = true
			for i = 1, #dragons do
				local name = dragons[i]
				lines[name] = ""
			end
		elseif UnitDebuff("player", hunterDebuff) then
			infoNeeded = true
			for i = 1, #hunters do
				local name = hunters[i]
				lines[name] = ""
			end
		elseif UnitDebuff("player", wolfDebuff) then
			infoNeeded = true
			for i = 1, #wolves do
				local name = wolves[i]
				lines[name] = ""
			end
		else--Player has no debuff, show overview frame with total debuff counts remaining
			local crabsigns, dragonsigns, huntersigns, wolfsigns = #crabs, #dragons, #hunters, #wolves
			--FIXME, figure out why colors are wrong
			if crabsigns > 0 then
				lines["|cff7d0aCD"..crabDebuff.."|r"] = crabsigns
				infoNeeded = true
			end
			if dragonsigns > 0 then
				lines["|c69ccf0CD"..dragonDebuff.."|r"] = dragonsigns
				infoNeeded = true
			end
			if huntersigns > 0 then
				lines["|cabd473CD"..hunterDebuff.."|r"] = huntersigns
				infoNeeded = true
			end
			if wolfsigns > 0 then
				lines["|cff0000CD"..wolfDebuff.."|r"] = wolfsigns
				infoNeeded = true
			end
		end
		if not infoNeeded then--Nothing left, hide infoframe
			DBM.InfoFrame:Hide()
		end
		return lines
	end
end

local function updateRangeFrame(self, force)
	if not self.Options.RangeFrame then return end
	if UnitDebuff("player", icyEjectionDebuff) or UnitDebuff("player", coronalEjectionDebuff) then
		DBM.RangeCheck:Show(8)
	elseif self.vb.phase == 2 and self:IsTank() then--Spread for iceburst
		DBM.RangeCheck:Show(6)
	elseif UnitDebuff("Player", gravPullDebuff) or UnitDebuff("player", voidEjectionDebuff) or force or self.vb.StarSigns > 0 then
		DBM.RangeCheck:Show(5)
	elseif UnitDebuff("player", abZeroDebuff) then
		DBM.RangeCheck:Show(8, chilledFilter)
	elseif self.vb.phase == 2 and self:IsMelee() then--Avoid tanks iceburst
		DBM.RangeCheck:Show(6, tankFilter)
	else
		DBM.RangeCheck:Hide()
	end
end

local function showConjunction(self)
	if UnitDebuff("player", crabDebuff) then
		warnStarSignCrab:Show(table.concat(crabs, "<, >"))
	end
	if UnitDebuff("player", dragonDebuff) then
		warnStarSignDragon:Show(table.concat(dragons, "<, >"))
	end
	if not UnitDebuff("player", hunterDebuff) then
		warnStarSignHunter:Show(table.concat(hunters, "<, >"))
	end
	if not UnitDebuff("player", wolfDebuff) then
		warnStarSignWolf:Show(table.concat(wolves, "<, >"))
	end
end

function mod:OnCombatStart(delay)
	voidWarned = false
	self.vb.StarSigns = 0
	self.vb.phase = 1
	self.vb.isPhaseChanging = false
	if self:IsMythic() then
		self.vb.grandConCount = 0
		self.vb.worldDestroyingCount = 0
--		timerCoronalEjectionCD:Start(12-delay)--Still could be health based
		timerConjunctionCD:Start(15-delay, 1)
		if self.Options.NPAuraOnConjunction then
			DBM:FireEvent("BossMod_EnableFriendlyNameplates")
		end
	else
--		timerCoronalEjectionCD:Start(12.9-delay)--Still could be health based
	end
	--berserkTimer:Start(-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.HudMapOnConjunction then
		DBMHudMap:Disable()
	end
	if self.Options.NPAuraOnConjunction and self:IsMythic() then
		DBM.Nameplate:Hide(nil, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 205408 then
		self.vb.grandConCount = self.vb.grandConCount + 1
		specWarnConjunction:Show()
		voiceConjunction:Play("scatter")
		local timers
		if self.vb.phase == 1 then
			timers = ps1Grand[self.vb.grandConCount+1]
		elseif self.vb.phase == 2 then
			timers = ps2Grand[self.vb.grandConCount+1]
		elseif self.vb.phase == 3 then
			timers = ps3Grand[self.vb.grandConCount+1]
		else
			timers = ps4Grand[self.vb.grandConCount+1]
		end
		if timers then
			timerConjunctionCD:Start(timers, self.vb.grandConCount+1)
		end
		updateRangeFrame(self, true)
		self:Schedule(5, showConjunction, self)
		table.wipe(crabs)
		table.wipe(dragons)
		table.wipe(hunters)
		table.wipe(wolves)
	elseif spellId == 206949 then
		self.vb.frostNovaCount = self.vb.frostNovaCount + 1
		specWarnFrigidNova:Show()
		voiceFrigidNova:Play("gathershare")
		timerFrigidNovaCD:Start(nil, self.vb.frostNovaCount+1)
	elseif spellId == 206517 then
		self.vb.felNovaCount = self.vb.felNovaCount + 1
		specWarnFelNova:Show()
		voiceFelnova:Play("justrun")
		if self.vb.felNovaCount < 3 then
			timerFelNovaCD:Start(44, self.vb.felNovaCount+1)
		else
			timerFelNovaCD:Start(nil, self.vb.felNovaCount+1)
		end
	elseif spellId == 207720 then
		specWarnWitnessVoid:Show()
		voiceWitnessVoid:Play("turnaway")
		timerWitnessVoid:Start(nil, args.sourceGUID)
		if self:IsMythic() then
			timerWitnessVoidCD:Start(13, args.sourceGUID)
		else
			timerWitnessVoidCD:Start(14.5, args.sourceGUID)
		end
	elseif spellId == 207439 then
		self.vb.voidNovaCount = self.vb.voidNovaCount + 1
		specWarnVoidNova:Show()
		voiceVoidNova:Play("aesoon")
		timerVoidNovaCD:Start(nil, self.vb.voidNovaCount+1)
	elseif spellId == 216909 then
		self.vb.worldDestroyingCount = self.vb.worldDestroyingCount + 1
		specWarnWorldDevouringForce:Show()
		voiceWorldDevouringForce:Play("farfromline")
		local timer = worldDestroyingTimers[self.vb.worldDestroyingCount+1]
		if timer then
			timerWorldDevouringForceCD:Start(timer, self.vb.worldDestroyingCount+1)
			countWorldDevouringForce:Start(timer)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 206464 then
		--timerCoronalEjectionCD:Start()
	elseif spellId == 206936 and not self.vb.isPhaseChanging then
		self.vb.icyEjectionCount = self.vb.icyEjectionCount + 1
		local timer = icyEjectionTimers[self.vb.icyEjectionCount+1]
		if timer and timer >= 4 then--No sense in starting timers for the sub 4 second casts
			timerIcyEjectionCD:Start(timer, self.vb.icyEjectionCount+1)
		end
	elseif spellId == 205649 and not self.vb.isPhaseChanging then
		self.vb.felEjectionCount = self.vb.felEjectionCount + 1
		--10 after 4, 32 after 7, 22 after 12, 17 after 14, 18 after 18
		--9.4 after 4, 31.2 after 7, 14 after 10 (Mythic)
		--The rest are like sub 5 second timers with variations to boot so not worth timers
		local timer = self:IsMythic() and mythicfelEjectionTimers[self.vb.felEjectionCount+1] or felEjectionTimers[self.vb.felEjectionCount+1]
		if timer and timer >= 4 then--No sense in starting timers for the sub 5 second casts
			timerFelEjectionCD:Start(timer, self.vb.felEjectionCount+1)
		end
	elseif spellId == 207143 and not self.vb.isPhaseChanging then
		DBM:Debug("Void Ejection is back", 2)
--[[		self.vb.voidEjectionCount = self.vb.voidEjectionCount + 1
		local timer = voidEjectionTimers[self.vb.voidEjectionCount+1]
		if timer and timer >= 4 then--No sense in starting timers for the sub 4 second casts
			timerVoidEjectionCD:Start(timer, self.vb.voidEjectionCount+1)
		end--]]
	elseif spellId == 205984 or spellId == 214335 or spellId == 214167 then--205984 Frost, 214167 Fel, 214335 Void
		if spellId == 214335 then
			timerGravPullCD:Start(65)
		else--29
			timerGravPullCD:Start()
		end
		if args:IsPlayer() then
			specWarnGravitationalPull:Show()
			voiceGravPull:Play("targetyou")
		elseif self:IsTank() then
			specWarnGravitationalPullOther:Show(args.destName)
			voiceGravPull:Play("tauntboss")
		else
			warnGravitationalPull:Show(args.destName)
		end
	elseif spellId == 221875 then
		self.vb.isPhaseChanging = false
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 207813 then
		specWarnThing:Show()
		voiceThing:Play("bigmob")
		timerWitnessVoidCD:Start(10, args.destGUID)
		timerThingCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 205429 or spellId == 216344 or spellId == 216345 or spellId == 205445 then--Star Signs
		self.vb.StarSigns = self.vb.StarSigns + 1
		if spellId == 205429 then--Crab
			crabs[#crabs + 1] = args.destName
			if self.Options.HudMapOnConjunction then--Yellow
				DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 3.5, 17, 1, 1, 0, 0.5, nil, false):Appear():SetLabel(args.destName)
			end
			if args:IsPlayer() then
				specWarnConjunctionSign:Show(args.spellName)
				voiceConjunction:Play("205408c")
				countdownConjunction:Start()
				timerConjunction:Start()
			end
		elseif spellId == 216344 then--Dragon
			dragons[#dragons + 1] = args.destName
			if self.Options.HudMapOnConjunction then--Blue
				DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 3.5, 17, 0.28, 0.48, 0.9, 0.5, nil, false):Appear():SetLabel(args.destName)
			end
			if args:IsPlayer() then
				specWarnConjunctionSign:Show(args.spellName)
				voiceConjunction:Play("205408d")
				countdownConjunction:Start()
				timerConjunction:Start()
			end
		elseif spellId == 216345 then--Hunter
			hunters[#hunters + 1] = args.destName
			if self.Options.HudMapOnConjunction then--Green
				DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 3.5, 17, 0, 1, 0, 0.5, nil, false):Appear():SetLabel(args.destName)
			end
			if args:IsPlayer() then
				specWarnConjunctionSign:Show(args.spellName)
				voiceConjunction:Play("205408h")
				countdownConjunction:Start()
				timerConjunction:Start()
			end
		elseif spellId == 205445 then--Wolf
			wolves[#wolves + 1] = args.destName
			if self.Options.HudMapOnConjunction then--Red
				DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 3.5, 17, 1, 0, 0, 0.5, nil, false):Appear():SetLabel(args.destName)
			end
			if args:IsPlayer() then
				specWarnConjunctionSign:Show(args.spellName)
				voiceConjunction:Play("205408w")
				countdownConjunction:Start()
				timerConjunction:Start()
			end
		end
		if self.vb.StarSigns == 1 then
			updateRangeFrame(self)
			if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() then
				DBM.InfoFrame:Show(15, "function", updateInfoFrame, sortInfoFrame, true)
			end
		end
		if self.Options.NPAuraOnConjunction then
			DBM.Nameplate:Show(args.destGUID, spellId, nil, 10)
		end
	elseif spellId == 206464 then
		warnCoronalEjection:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnCoronalEjection:Show()
			voiceCoronalEjection:Play("runout")
			updateRangeFrame(self)
		end
	elseif spellId == 205984 or spellId == 214335 or spellId == 214167 then
		if args:IsPlayer() then
			updateRangeFrame(self)
			local _, _, _, _, _, duration, expires, _, _ = UnitDebuff("player", args.spellName)
			if expires then
				local remaining = expires-GetTime()
				countdownGravPull:Start(remaining)
				yellGravitationalPull:Schedule(remaining-1, 1)
				yellGravitationalPull:Schedule(remaining-2, 2)
				yellGravitationalPull:Schedule(remaining-3, 3)
			end
		end
	elseif spellId == 206585 then
		updateRangeFrame(self)
	elseif spellId == 206936 then
		warnIcyEjection:CombinedShow(0.5, args.destName)--If only one, move this to else rule to filter from player
		if args:IsPlayer() then
			specWarnIcyEjection:Show()
			voiceIcyEjection:Play("runout")
			updateRangeFrame(self)
			yellIcyEjection:Schedule(9, 1)
			yellIcyEjection:Schedule(8, 2)
			yellIcyEjection:Schedule(7, 3)
		end
	elseif spellId == 205649 then
		warnFelEjection:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnFelEjection:Show()
			voiceFelEjection:Play("runout")
			voiceFelEjection:Schedule(1, "keepmove")
			yellFelEjection:Yell()
			yellFelEjectionFade:Schedule(7, 1)
			yellFelEjectionFade:Schedule(6, 2)
			yellFelEjectionFade:Schedule(5, 3)
			warnFelEjectionPuddle:Schedule(2, 3)
			warnFelEjectionPuddle:Schedule(4, 2)
			warnFelEjectionPuddle:Schedule(6, 1)
			warnFelEjectionPuddle:Schedule(8, 0)
		end
	elseif spellId == 207143 then
		--warnVoidEjection:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnVoidEjection:Show()
			voiceVoidEjection:Play("runout")
		end
	elseif spellId == 206398 and args:IsPlayer() and self:AntiSpam(2, 1) and not UnitDebuff("Player", gravPullDebuff) then
		specWarnFelFlame:Show()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 205429 or spellId == 216344 or spellId == 216345 or spellId == 205445 then--Star Signs
		self.vb.StarSigns = self.vb.StarSigns - 1
		if args:IsPlayer() then
			countdownConjunction:Cancel()
			timerConjunction:Stop()
		end
		if self.vb.StarSigns == 0 then
			updateRangeFrame(self)
			if self.Options.HudMapOnConjunction then
				--None left, clear all HUD circles
				DBMHudMap:FreeEncounterMarkers()
			end
		else
			if self.Options.HudMapOnConjunction and self.Options.ShowNeutralColor then
				--Change circle color to a 5th, white color for unaffected players
				DBMHudMap:FreeEncounterMarkerByTarget(spellId, args.destName)
				DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 4, 17, 1, 1, 1, 0.5, nil, true):Appear():SetLabel(args.destName)
			end
		end
		if spellId == 205429 then--Crab
			tDeleteItem(crabs, args.destName)
		elseif spellId == 216344 then--Dragon
			tDeleteItem(dragons, args.destName)
		elseif spellId == 216345 then--Hunter
			tDeleteItem(hunters, args.destName)
		elseif spellId == 205445 then--Wolf
			tDeleteItem(wolves, args.destName)
		end
		if self.Options.NPAuraOnConjunction then
			DBM.Nameplate:Hide(args.destGUID)
		end
	elseif spellId == 205984 or spellId == 214335 or spellId == 214167 then
		if args:IsPlayer() then
			updateRangeFrame(self)
			yellGravitationalPull:Cancel()
			countdownGravPull:Cancel()
		end
	elseif spellId == 206585 then
		updateRangeFrame(self)
	elseif spellId == 206464 and args:IsPlayer() then
		updateRangeFrame(self)
	elseif spellId == 206936 and args:IsPlayer() then
		yellIcyEjection:Cancel()
		updateRangeFrame(self)
	elseif spellId == 205649 and args:IsPlayer() then
		yellFelEjectionFade:Cancel()
		warnFelEjectionPuddle:Cancel()
		updateRangeFrame(self)
	elseif spellId == 207143 and args:IsPlayer() then
		updateRangeFrame(self)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 104880 then--Thing That Should Not Be
		timerWitnessVoidCD:Cancel(args.destGUID)
		timerWitnessVoid:Cancel(args.destGUID)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 206398 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) and not UnitDebuff("Player", gravPullDebuff) then
		specWarnFelFlame:Show()
		voiceFelFlame:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--Phases can also be done with Nether Traversal (221875) with same timing.
--However, this is more robust since unique spellids for each phase is better than same used for all 3
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 222130 then--Phase 2 Conversation
		self.vb.phase = 2
		self.vb.isPhaseChanging = true
		self.vb.frostNovaCount = 0
		self.vb.icyEjectionCount = 0
--		timerCoronalEjectionCD:Stop()
		timerConjunctionCD:Stop()
		timerGravPullCD:Start(30)
		if not self:IsEasy() then
			timerFrigidNovaCD:Start(49, 1)
		end
		if self:IsMythic() then
			self.vb.grandConCount = 0
			timerIcyEjectionCD:Start(15, 1)
			timerConjunctionCD:Start(27, 1)
		else
			timerIcyEjectionCD:Start(23.3, 1)
		end
	elseif spellId == 222133 then--Phase 3 Conversation
		self.vb.phase = 3
		self.vb.isPhaseChanging = true
		self.vb.felEjectionCount = 0
		self.vb.felNovaCount = 0
		timerIcyEjectionCD:Stop()
		timerFrigidNovaCD:Stop()
		timerGravPullCD:Stop()
		timerConjunctionCD:Stop()
		timerGravPullCD:Start(29)
		if self:IsMythic() then
			self.vb.grandConCount = 0
			timerFelEjectionCD:Start(17.5, 1)
			timerFelNovaCD:Start(52, 1)
			timerConjunctionCD:Start(58, 1)
		else
			timerFelEjectionCD:Start(18.2, 1)
			if not self:IsEasy() then
				timerFelNovaCD:Start(57.7, 1)
			end
		end
	elseif spellId == 222134 then--Phase 4 Conversation
		self.vb.phase = 4
		self.vb.isPhaseChanging = true
		self.vb.voidNovaCount = 0
		--self.vb.voidEjectionCount = 0
		timerFelEjectionCD:Stop()
		timerFelNovaCD:Stop()
		timerGravPullCD:Stop()
		timerConjunctionCD:Stop()
		timerGravPullCD:Start(19.6)
		timerThingCD:Start(31)
		if not self:IsEasy() then--Was never used on normal, probably not LFR either then
			--timerVoidEjectionCD:Start(24, 1)
			timerVoidNovaCD:Start(41, 1)
		end
		if self:IsMythic() then
			self.vb.grandConCount = 0
			self.vb.worldDestroyingCount = 0
			timerWorldDevouringForceCD:Start(22, 1)
			countWorldDevouringForce:Start(22)
			timerConjunctionCD:Start(46.5, 1)
		end
	end
end

do
	local debuffName = GetSpellInfo(207143)
	--Jumps didn't show in combat log during testing, only original casts. However, jumps need warnings too
	--Check at later time if jumps are in combat log
	function mod:UNIT_AURA(uId)
		local hasDebuff = UnitDebuff("player", debuffName)
		if hasDebuff and not voidWarned then
			voidWarned = true
			specWarnVoidEjection:Show()
			voiceVoidEjection:Play("runout")
			--yellScornedTouch:Yell()
			--if self.Options.RangeFrame then
			--	DBM.RangeCheck:Show(8)
			--end
		elseif not hasDebuff and voidWarned then
			voidWarned = false
			--if self.Options.RangeFrame then
			--	DBM.RangeCheck:Hide()
			--end
		end
	end
end
