local mod	= DBM:NewMod(1732, "DBM-Nighthold", nil, 786)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(103758)
mod:SetEncounterID(1863)
mod:SetZone()
--mod:SetUsedIcons(8, 7, 6, 3, 2, 1)
--mod:SetHotfixNoticeRev(12324)
mod.respawnTime = 30--or 35 or 40

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 205408 206949 206517 207720 207439 216909",
	"SPELL_CAST_SUCCESS 206464 206464 206936 205649 207143 205984 214335 214167",
	"SPELL_AURA_APPLIED 205429 216344 216345 205445 205984 214335 214167 206585 206936 205649 207143 206398",
	"SPELL_AURA_REMOVED 205429 216344 216345 205445 205984 214335 214167 206585 206936 207143",
	"SPELL_SUMMON 207813",
	"SPELL_PERIODIC_DAMAGE 206398",
	"SPELL_PERIODIC_MISSED 206398",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, evalulate hud size for conjunction for range check/hud. 5 yards guessed.
--TODO, felburst stacks/swapping?
--TODO, does void nova even merit a special warning, or regular?
--TODO, void ejection gone?
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
--Stage Four: Inevitable Fate
local warnVoidEjection				= mod:NewTargetAnnounce(207143, 2)

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
local timerGravPullCD				= mod:NewCDTimer(29, 205984, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)
--Stage One: The Dome of Observation
mod:AddTimerLine(SCENARIO_STAGE:format(1))
local timerCoronalEjectionCD		= mod:NewCDTimer(16, 206464, nil, nil, nil, 3)--CD is not known, always push phase 2 before this is cast 2nd time
--Stage Two: Absolute Zero
mod:AddTimerLine(SCENARIO_STAGE:format(2))
local timerIcyEjectionCD			= mod:NewCDCountTimer(16, 206936, nil, nil, nil, 3)
local timerFrigidNovaCD				= mod:NewCDTimer(61.5, 206949, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)
--Stage Three: A Shattered World
mod:AddTimerLine(SCENARIO_STAGE:format(3))
local timerFelEjectionCD			= mod:NewCDCountTimer(16, 205649, nil, nil, nil, 3)
local timerFelNovaCD				= mod:NewCDCountTimer(25, 206517, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)--47.1, 45.0, 25.1
--Stage Four: Inevitable Fate
mod:AddTimerLine(SCENARIO_STAGE:format(4))
local timerWitnessVoidCD			= mod:NewCDTimer(14.2, 207720, nil, nil, nil, 2, nil, DBM_CORE_HEALER_ICON)
local timerVoidEjectionCD			= mod:NewCDCountTimer(16, 207143, nil, nil, nil, 3)--Where did it go? wasn't on normal test and wasn't on heroic retest
local timerVoidNovaCD				= mod:NewCDTimer(74, 207439, nil, nil, nil, 2)--Only saw a single pull it was cast twice, so CD needs more verification
local timerWorldDevouringForceCD	= mod:NewCDTimer(16, 216909, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON..DBM_CORE_HEROIC_ICON)
local timerThingCD					= mod:NewCDTimer(63, "ej13057", 207813, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
mod:AddTimerLine(ENCOUNTER_JOURNAL_SECTION_FLAG12)
local timerConjunctionCD			= mod:NewCDTimer(16, 205408, nil, nil, nil, 3, nil, DBM_CORE_HEROIC_ICON)

local berserkTimer					= mod:NewBerserkTimer(463)

--Base abilities
local countdownConjunction			= mod:NewCountdownFades("AltTwo15", 205408)
local countdownGravPull				= mod:NewCountdownFades("Alt10", 205984)--Maybe change to everyone if it works like I think
--Stage One: The Dome of Observation
--Stage Two: Absolute Zero
--Stage Three: A Shattered World
--Stage Four: Inevitable Fate

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
local voiceThing					= mod:NewVoice("ej13057", "-Healer")--killmob
local voiceWitnessVoid				= mod:NewVoice(207720)--turnaway
local voiceVoidEjection				= mod:NewVoice(207143)--runout
local voiceVoidNova					= mod:NewVoice(207439)--aesoon
local voiceWorldDevouringForce		= mod:NewVoice(216909)--farfromline


mod:AddRangeFrameOption("5/8")
mod:AddHudMapOption("HudMapOnConjunction", 205408)
mod:AddBoolOption("ShowNeutralColor", false)
mod:AddInfoFrameOption(205408)--really needs a "various" option

mod.vb.StarSigns = 0
mod.vb.phase = 1
mod.vb.icyEjectionCount = 0
mod.vb.felEjectionCount = 0
mod.vb.felNovaCount = 0
mod.vb.voidEjectionCount = 0
--These timers are self corrective, which is annoying when all inclusive but better if scrubbing short timers
--For example Icy will always be 35.2, 64.5, 24.7 if you scrub the short timers or within 0.3. However including short timers and you get more variation.
--For time being, i'll be all inclusive, particuarlly with void since some of the shorter auto correcting ones are over 10 seconds.
--Example of self correction. Note 3rd pull, because of the 14 being late by 3 seconds, the 3 seconds corrected from the 20.
--"207143-Void Ejection" = "pull:338.3, 4.5, 14.2, 20.7, 1.6, 7.3, 26.5, 2.4",
--"207143-Void Ejection" = "pull:328.7, 5.7, 14.1, 20.7, 2.8, 6.1, 25.7, 4.9",
--"207143-Void Ejection" = "pull:326.8, 4.4, 17.5, 17.4, 4.6, 4.7, 26.3, 4.8",
--For all inclusive, i'll simply use lowest observed time for each count, which will give close approx cd timer but imprecise to be a "next" timer.
local icyEjectionTimers = {24.5, 34.4, 6.5, 5.3, 50.7, 1.2, 2.4}--43.3, 35.6, 8.1, 4.1, 52.2, 1.2, 2.4
local felEjectionTimers = {22.5, 3.6, 3.2, 2.4, 10.2, 4.4, 2.8, 32.8, 4.0, 1.6, 4.0, 4.5, 22.3, 6.9, 17.0, 1.6, 1.2, 2.0, 18.3, 0.4}--10 after 4, 32 after 7, 22 after 12, 17 after 14, 18 after 18
local voidEjectionTimers = {24, 3.2, 14.1, 17.4, 0.8, 4.7, 25.7, 2.3}
--local felNovaTImers = {34.8, 31.3, 29.3}--Latest is 47.1, 45.0, 25.1. Currently unused. for now just doing 45 or 25
local abZeroTargets = {}
local abZeroDebuff, chilledDebuff, gravPullDebuff = GetSpellInfo(206585), GetSpellInfo(206589), GetSpellInfo(205984)
local icyEjectionDebuff, coronalEjectionDebuff, voidEjectionDebuff = GetSpellInfo(206936), GetSpellInfo(206464), GetSpellInfo(207143)
local crabDebuff, dragonDebuff, hunterDebuff, wolfDebuff = GetSpellInfo(205429), GetSpellInfo(216344), GetSpellInfo(216345), GetSpellInfo(205445)
local UnitDebuff = UnitDebuff
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
--	local playerName = UnitName("player")
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
		local total1, total2 = 0, 0
		local crabs, dragons, hunters, wolves = 0, 0, 0, 0
		--Star Signs Helper
		for i = 1, DBM:GetNumRealGroupMembers() do
			local unitID = 'raid'..i
			if UnitDebuff(unitID, crabDebuff) then
				crabs = crabs + 1
				total1 = total1 + 1
			end
			if UnitDebuff(unitID, dragonDebuff) then
				dragons = dragons + 1
				total1 = total1 + 1
			end
			if UnitDebuff(unitID, hunterDebuff) then
				hunters = hunters + 1
				total1 = total1 + 1
			end
			if UnitDebuff(unitID, wolfDebuff) then
				wolves = wolves + 1
				total1 = total1 + 1
			end
		end
		if total1 > 0 then
			--FIXME, figure out why colors are wrong
			lines["|cff7d0aCD"..crabDebuff.."|r"] = crabs
			lines["|c69ccf0CD"..dragonDebuff.."|r"] = dragons
			lines["|cabd473CD"..hunterDebuff.."|r"] = hunters
			lines["|cff0000CD"..wolfDebuff.."|r"] = wolves
		end
		--Absolute Zero Helper
		for i = 1, #abZeroTargets do
			local name = abZeroTargets[i]
			local uId = DBM:GetRaidUnitId(name)
			if not uId then break end
			local _, _, _, currentStack = UnitDebuff(uId, abZeroDebuff)
			if currentStack then
				total2 = total2 + 1
				lines[name] = currentStack
			end
		end
		if total2 > 0 then
			--Displays whether or not player has chilled. if YES in red or NO in green
			--Ths is displayed under the absolute zero name/stacks so they know there are still stacks to soak and if able.
			lines[chilledDebuff] = UnitDebuff("player", chilledDebuff) and "|cFF1A1ACD"..YES.."|r" or "|c69CCF0CD"..NO.."|r"
		end
		if total1 == 0 and total2 == 0 then--Nothing left, hide infoframe
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

local function cancelNotMine(self)
	--Idea behind this is you should only see all targets same sign as you
	if not UnitDebuff("player", crabDebuff) then
		warnStarSignCrab:Cancel()
	end
	if not UnitDebuff("player", dragonDebuff) then
		warnStarSignDragon:Cancel()
	end
	if not UnitDebuff("player", hunterDebuff) then
		warnStarSignHunter:Cancel()
	end
	if not UnitDebuff("player", wolfDebuff) then
		warnStarSignWolf:Cancel()
	end
end

function mod:OnCombatStart(delay)
	table.wipe(abZeroTargets)
	self.vb.StarSigns = 0
	self.vb.phase = 1
	if self:IsMythic() then
		timerCoronalEjectionCD:Start(12-delay)--Still could be health based
		timerConjunctionCD:Start(15-delay)
	else
		timerCoronalEjectionCD:Start(12.9-delay)--Still could be health based
	end
	berserkTimer:Start(-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.HudMapOnConjunction then
		DBMHudMap:Disable()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 205408 then
		specWarnConjunction:Show()
		voiceConjunction:Play("scatter")
		--timerConjunctionCD:Start()
		updateRangeFrame(self, true)
		DBM:AddMsg("HUD ranges for this are still approximatinos until further testing.")
		self:Schedule(5, cancelNotMine, self)
	elseif spellId == 206949 then
		specWarnFrigidNova:Show()
		voiceFrigidNova:Play("gathershare")
		timerFrigidNovaCD:Start()
	elseif spellId == 206517 then
		self.vb.felNovaCount = self.vb.felNovaCount + 1
		specWarnFelNova:Show()
		voiceFelnova:Play("justrun")
		if self.vb.felNovaCount < 3 then
			timerFelNovaCD:Start(45, self.vb.felNovaCount+1)
		else
			timerFelNovaCD:Start(nil, self.vb.felNovaCount+1)
		end
	elseif spellId == 207720 then
		specWarnWitnessVoid:Show()
		voiceWitnessVoid:Play("turnaway")
		if self:IsEasy() then
			timerWitnessVoidCD:Start(14.5, args.sourceGUID)
		else
			timerWitnessVoidCD:Start(nil, args.sourceGUID)
		end
	elseif spellId == 207439 then
		specWarnVoidNova:Show()
		voiceVoidNova:Play("aesoon")
		timerVoidNovaCD:Start()
	elseif spellId == 216909 then
		specWarnWorldDevouringForce:Show()
		voiceWorldDevouringForce:Play("farfromline")
		timerWorldDevouringForceCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 206464 then
		--timerCoronalEjectionCD:Start()
	elseif spellId == 206936 then
		self.vb.icyEjectionCount = self.vb.icyEjectionCount + 1
		local timer = icyEjectionTimers[self.vb.icyEjectionCount+1]
		if timer and timer >= 4 then--No sense in starting timers for the sub 4 second casts
			timerIcyEjectionCD:Start(timer, self.vb.icyEjectionCount+1)
		end
	elseif spellId == 205649 and not self:IsMythic() then--Disabled on mythic, shits basically spammed there and doesn't match timers table.
		self.vb.felEjectionCount = self.vb.felEjectionCount + 1
		--10 after 4, 32 after 7, 22 after 12, 17 after 14, 18 after 18
		--The rest are like sub 5 second timers with variations to boot so not worth timers
		if self.vb.felEjectionCount == 4 then
			timerFelEjectionCD:Start(10, self.vb.felEjectionCount+1)
		elseif self.vb.felEjectionCount == 7 then
			timerFelEjectionCD:Start(32, self.vb.felEjectionCount+1)
		elseif self.vb.felEjectionCount == 12 then
			timerFelEjectionCD:Start(22, self.vb.felEjectionCount+1)
		elseif self.vb.felEjectionCount == 14 then
			timerFelEjectionCD:Start(17, self.vb.felEjectionCount+1)
		elseif self.vb.felEjectionCount == 18 then
			timerFelEjectionCD:Start(18, self.vb.felEjectionCount+1)
		end
	elseif spellId == 207143 then
		self.vb.voidEjectionCount = self.vb.voidEjectionCount + 1
		local timer = voidEjectionTimers[self.vb.voidEjectionCount+1]
		if timer and timer >= 4 then--No sense in starting timers for the sub 4 second casts
			timerVoidEjectionCD:Start(timer, self.vb.voidEjectionCount+1)
		end
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
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 207813 then
		specWarnThing:Show()
		voiceThing:Play("killmob")
		timerWitnessVoidCD:Start(10, args.destGUID)
		timerThingCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 205429 or spellId == 216344 or spellId == 216345 or spellId == 205445 then--Star Signs
		self.vb.StarSigns = self.vb.StarSigns + 1
		if spellId == 205429 then--Crab
			warnStarSignCrab:CombinedShow(2, args.destName)
			if self.Options.HudMapOnConjunction then--Yellow
				DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 3.5, 17, 1, 1, 0, 0.5, nil, false):Appear():SetLabel(args.destName)
			end
			if args:IsPlayer() then
				specWarnConjunctionSign:Show(args.spellName)
				voiceConjunction:Play("205408c")
				countdownConjunction:Start()
			end
		elseif spellId == 216344 then--Dragon
			warnStarSignDragon:CombinedShow(2, args.destName)
			if self.Options.HudMapOnConjunction then--Blue
				DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 3.5, 17, 0.28, 0.48, 0.9, 0.5, nil, false):Appear():SetLabel(args.destName)
			end
			if args:IsPlayer() then
				specWarnConjunctionSign:Show(args.spellName)
				voiceConjunction:Play("205408d")
				countdownConjunction:Start()
			end
		elseif spellId == 216345 then--Hunter
			warnStarSignHunter:CombinedShow(2, args.destName)
			if self.Options.HudMapOnConjunction then--Green
				DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 3.5, 17, 0, 1, 0, 0.5, nil, false):Appear():SetLabel(args.destName)
			end
			if args:IsPlayer() then
				specWarnConjunctionSign:Show(args.spellName)
				voiceConjunction:Play("205408h")
				countdownConjunction:Start()
			end
		elseif spellId == 205445 then--Wolf
			warnStarSignWolf:CombinedShow(2, args.destName)
			if self.Options.HudMapOnConjunction then--Red
				DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 3.5, 17, 1, 0, 0, 0.5, nil, false):Appear():SetLabel(args.destName)
			end
			if args:IsPlayer() then
				specWarnConjunctionSign:Show(args.spellName)
				voiceConjunction:Play("205408w")
				countdownConjunction:Start()
			end
		end
		if self.vb.StarSigns == 1 then
			updateRangeFrame(self)
			if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() then
				DBM.InfoFrame:Show(15, "function", updateInfoFrame, sortInfoFrame, true)
			end
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
		if not tContains(abZeroTargets, args.destName) then
			table.insert(abZeroTargets, args.destName)
		end
		if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() then
			DBM.InfoFrame:Show(15, "function", updateInfoFrame, sortInfoFrame, true)
		end
		updateRangeFrame(self)
		if args:IsPlayer() then
			updateRangeFrame(self)
		end
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
		end
	elseif spellId == 207143 then
		warnVoidEjection:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnVoidEjection:Show()
			voiceVoidEjection:Play("runout")
		end
	elseif spellId == 206398 and not self:IsTank() and self:AntiSpam(2, 1) then
		specWarnFelFlame:Show()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 205429 or spellId == 216344 or spellId == 216345 or spellId == 205445 then--Star Signs
		self.vb.StarSigns = self.vb.StarSigns - 1
		if args:IsPlayer() then
			countdownConjunction:Cancel()
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
	elseif spellId == 205984 or spellId == 214335 or spellId == 214167 then
		if args:IsPlayer() then
			updateRangeFrame(self)
			yellGravitationalPull:Cancel()
			countdownGravPull:Cancel()
		end
	elseif spellId == 206585 then
		tDeleteItem(abZeroTargets, args.destName)
		if args:IsPlayer() then
			updateRangeFrame(self)
		end
	elseif spellId == 206464 then
		if args:IsPlayer() then
			updateRangeFrame(self)
		end
	elseif spellId == 206936 then
		if args:IsPlayer() then
			yellIcyEjection:Cancel()
			updateRangeFrame(self)
		end
	elseif spellId == 207143 then
		if args:IsPlayer() then
			updateRangeFrame(self)
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 104880 then--Thing That Should Not Be
		timerWitnessVoidCD:Cancel(args.destGUID)
	end
end

--Phases can also be done with Nether Traversal (221875) with same timing.
--However, this is more robust since unique spellids for each phase is better than same used for all 3
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 222130 then--Phase 2 Conversation
		self.vb.phase = 2
		self.vb.icyEjectionCount = 0
		timerCoronalEjectionCD:Stop()
		timerConjunctionCD:Stop()
		timerIcyEjectionCD:Start(23.3, 1)
		timerGravPullCD:Start(30)
		if not self:IsEasy() then
			timerFrigidNovaCD:Start(49)
		end
		if self:IsMythic() then
			timerConjunctionCD:Start(48)
		end
	elseif spellId == 222133 then--Phase 3 Conversation
		self.vb.phase = 3
		self.vb.felEjectionCount = 0
		self.vb.felNovaCount = 0
		timerIcyEjectionCD:Stop()
		timerFrigidNovaCD:Stop()
		timerGravPullCD:Stop()
		timerConjunctionCD:Stop()
		timerFelEjectionCD:Start(18.2, 1)
		timerGravPullCD:Start(29)
		if not self:IsEasy() then
			timerFelNovaCD:Start(57.7, 1)
		end
		if self:IsMythic() then
			timerConjunctionCD:Start(48)
		end
	elseif spellId == 222134 then--Phase 4 Conversation
		self.vb.phase = 4
		self.vb.voidEjectionCount = 0
		timerFelEjectionCD:Stop()
		timerFelNovaCD:Stop()
		timerGravPullCD:Stop()
		timerConjunctionCD:Stop()
		timerGravPullCD:Start(19.6)
		timerThingCD:Start(31)
		if not self:IsEasy() then--Was never used on normal, probably not LFR either then
			--timerVoidEjectionCD:Start(24, 1)
			timerVoidNovaCD:Start(41)
		end
		if self:IsMythic() then
			timerWorldDevouringForceCD:Start(22)
			timerConjunctionCD:Start(48)
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 206398 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnFelFlame:Show()
		voiceFelFlame:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
