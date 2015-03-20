local mod	= DBM:NewMod(959, "DBM-BlackrockFoundry", nil, 457)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(77325)--68168
mod:SetEncounterID(1704)
mod:SetZone()
mod:SetUsedIcons(3, 2, 1)
mod:SetHotfixNoticeRev(12813)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 155992 159142 156928 158054 163008",
	"SPELL_AURA_APPLIED 156096 157000 156667 156401 156653 159179",
	"SPELL_AURA_REMOVED 156096 157000 156667 159179",
	"SPELL_CAST_SUCCESS 162579",
	"SPELL_PERIODIC_DAMAGE 156401",
	"SPELL_ABSORBED 156401",
	"SPELL_ENERGIZE 104915",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, get damage ID for fire on ground created by Mortar
local warnPhase						= mod:NewPhaseChangeAnnounce()
--Stage One: The Blackrock Forge
local warnMarkedforDeath			= mod:NewTargetCountAnnounce(156096, 4)--If not in combat log, find a RAID_BOSS_WHISPER event.
--Stage Two: Storage Warehouse
local warnSiegemaker				= mod:NewCountAnnounce("ej9571", 3, 156667)
local warnFixate					= mod:NewTargetAnnounce(156653, 4)
--Stage Three: Iron Crucible
local warnAttachSlagBombs			= mod:NewTargetAnnounce(157000, 4)

--Stage One: The Blackrock Forge
local specWarnDemolition			= mod:NewSpecialWarningCount(156425, nil, nil, nil, 2, nil, 2)
local specWarnMassiveDemolition		= mod:NewSpecialWarningCount(156479, false, nil, nil, 2)
local specWarnMarkedforDeath		= mod:NewSpecialWarningYou(156096, nil, nil, nil, 3, nil, 2)
local specWarnMFDPosition			= mod:NewSpecialWarning("specWarnMFDPosition", nil, false, nil, 1, nil, 4)--Mythic Position Assignment. No option, connected to specWarnMarkedforDeath
local specWarnMarkedforDeathOther	= mod:NewSpecialWarningTargetCount(156096, false)
local yellMarkedforDeath			= mod:NewYell(156096)
local specWarnThrowSlagBombs		= mod:NewSpecialWarningSpell(156030, nil, nil, nil, 2, nil, 2)--This spell is not gtfo.
local specWarnShatteringSmash		= mod:NewSpecialWarningCount(155992, "Melee", nil, nil, nil, nil, 2)
local specWarnMoltenSlag			= mod:NewSpecialWarningMove(156401)
--Stage Two: Storage Warehouse
local specWarnSiegemaker			= mod:NewSpecialWarningCount("ej9571", false)--Kiter switch. off by default. 
local specWarnSiegemakerPlatingFades= mod:NewSpecialWarningFades("OptionVersion2", 156667, "Ranged")--Plating removed, NOW dps switch
local specWarnFixate				= mod:NewSpecialWarningRun(156653, nil, nil, nil, 4)
local yellFixate					= mod:NewYell(156653)
local specWarnMassiveExplosion		= mod:NewSpecialWarningSpell(163008, nil, nil, nil, 2, nil, 2)--Mythic
--Stage Three: Iron Crucible
local specWarnSlagEruption			= mod:NewSpecialWarningCount(156928, nil, nil, nil, 2)
local specWarnAttachSlagBombs		= mod:NewSpecialWarningYou(157000, nil, nil, nil, nil, nil, 2)--May change to sound 3, but I don't want it confused with the even more threatening marked for death, so for now will try 1
local specWarnAttachSlagBombsOther	= mod:NewSpecialWarningTaunt(157000, nil, nil, nil, nil, nil, 2)
local specWarnSlagPosition			= mod:NewSpecialWarning("specWarnSlagPosition", nil, false, nil, 1)
local yellAttachSlagBombs			= mod:NewYell("OptionVersion2", 157000)
local specWarnMassiveShatteringSmash= mod:NewSpecialWarningCount("OptionVersion2", 158054, nil, nil, nil, 3, nil, 2)
local specWarnFallingDebris			= mod:NewSpecialWarningCount(162585, nil, nil, nil, 2)--Mythic (like Meteor)

--Stage One: The Blackrock Forge
mod:AddTimerLine(SCENARIO_STAGE:format(1))
local timerDemolitionCD				= mod:NewNextCountTimer(45, 156425)
local timerMassiveDemolitionCD		= mod:NewNextCountTimer(6, 156479)
local timerMarkedforDeathCD			= mod:NewNextCountTimer(15.5, 156096)
local timerThrowSlagBombsCD			= mod:NewCDTimer(24.5, 156030)--It's a next timer, but sometimes delayed by Shattering Smash
local timerShatteringSmashCD		= mod:NewCDCountTimer(45, 155992)--power based, can variate a little do to blizzard buggy power code.
local timerImpalingThrow			= mod:NewCastTimer(5, 156111)--How long marked target has to aim throw at Debris Pile or Siegemaker
--Stage Two: Storage Warehouse
mod:AddTimerLine(SCENARIO_STAGE:format(2))
local timerSiegemakerCD				= mod:NewNextCountTimer(50, "ej9571", nil, nil, nil, 156667)
local timerMassiveExplosion			= mod:NewCastTimer(5, 163008)
--Stage Three: Iron Crucible
mod:AddTimerLine(SCENARIO_STAGE:format(3))
local timerSlagEruptionCD			= mod:NewCDCountTimer(32.5, 156928)
local timerAttachSlagBombsCD		= mod:NewCDTimer(25.5, 157000)--26-28. Do to increased cast time vs phase 1 and 2 slag bombs, timer is 1 second longer on CD
local timerSlagBomb					= mod:NewCastTimer(5, 157015)
local timerFallingDebris			= mod:NewCastTimer(6, 162585)--Mythic
local timerFallingDebrisCD			= mod:NewNextCountTimer(40, 162585)--Mythic

local countdownShatteringSmash		= mod:NewCountdown(45.5, 155992)
local countdownSlagBombs			= mod:NewCountdown("Alt25", 156030, "Melee")
local countdownMarkedforDeath		= mod:NewCountdown("AltTwo25", 156096, "-Tank")
local countdownMarkedforDeathFades	= mod:NewCountdownFades("AltTwo5", 156096)--Same voice should be fine, never will overlap, and both for same spell, so people will understand

local voicePhaseChange				= mod:NewVoice(nil, nil, DBM_CORE_AUTO_VOICE2_OPTION_TEXT)
local voiceSiegemaker				= mod:NewVoice("OptionVersion2", "ej9571", "Ranged") -- ej9571.ogg tank coming
local voiceShatteringSmash			= mod:NewVoice(155992, "Melee") --carefly
local voiceMarkedforDeath			= mod:NewVoice(156096) --target: findshelter; else: 156096.ogg marked for death
local voiceDemolition				= mod:NewVoice(156425) --AOE
local voiceThrowSlagBombs			= mod:NewVoice(156030) --bombsoon
local voiceMassiveExplosion			= mod:NewVoice(163008) --AOE
local voiceAttachSlagBombs			= mod:NewVoice(157000) --target: runout;

mod:AddSetIconOption("SetIconOnMarked", 156096, true)
mod:AddRangeFrameOption("6/10")
mod:AddHudMapOption("HudMapOnMFD", 156096)

mod.vb.phase = 1
mod.vb.demolitionCount = 0
mod.vb.SlagEruption = 0
mod.vb.smashCount = 0
mod.vb.markCount = 0
mod.vb.markCount2 = 0
mod.vb.siegemaker = 0
mod.vb.deprisCount = 0
local smashTank = nil
local UnitDebuff, UnitName = UnitDebuff, UnitName
local markTargets = {}
local DBMHudMap = DBMHudMap
local tankFilter
do
	tankFilter = function(uId)
		if UnitName(uId) == smashTank then
			return true
		end
	end
end

local function massiveOver(self)
	smashTank = nil
	if not UnitDebuff("player", GetSpellInfo(157000)) and not UnitDebuff("player", GetSpellInfo(159179)) then
		DBM.RangeCheck:Hide()
	end
end

local function warnMarked(self, countFormat)
	local text = table.concat(markTargets, "<, >")
	if self.Options.SpecWarn156096targetcount then
		specWarnMarkedforDeathOther:Show(countFormat, text)
	else
		warnMarkedforDeath:Show(countFormat, text)
	end
	table.wipe(markTargets)
end

function mod:OnCombatStart(delay)
	table.wipe(markTargets)
	self.vb.phase = 1
	self.vb.demolitionCount = 0
	self.vb.SlagEruption = 0
	self.vb.smashCount = 0
	self.vb.markCount = 0
	timerThrowSlagBombsCD:Start(5.5-delay)
	countdownSlagBombs:Start(5.5-delay)
	timerDemolitionCD:Start(15-delay, 1)
	timerShatteringSmashCD:Start(21-delay, 1)
	if self:IsTank() then--Ability only concerns tank in phase 1
		countdownShatteringSmash:Start(21-delay)
	end
	timerMarkedforDeathCD:Start(36-delay, 1)
	countdownMarkedforDeath:Start(36-delay)
	if self:IsMythic() then
		yellMarkedforDeath	= mod:NewYell(156096, L.customMFDSay)
		yellAttachSlagBombs	= mod:NewYell("OptionVersion2", 157000, L.customSlagSay)
	else--In case do mythic first, heroic after, reset to non custom on pull
		yellMarkedforDeath	= mod:NewYell(156096)
		yellAttachSlagBombs	= mod:NewYell("OptionVersion2", 157000)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.HudMapOnMFD then
		DBMHudMap:Disable()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 155992 or spellId == 159142 then--Phase 1 and then phase 2 version.
		self.vb.smashCount = self.vb.smashCount + 1
		if self.vb.phase == 1 then
			timerShatteringSmashCD:Start(30, self.vb.smashCount+1)
			if self:IsTank() then--only warnk tank in phase 1
				specWarnShatteringSmash:Show(self.vb.smashCount)
				countdownShatteringSmash:Start(30)
				voiceShatteringSmash:Play("carefly")
			end
		else
			if self:IsMythic() then
				timerShatteringSmashCD:Start(31.5, self.vb.smashCount+1)
				countdownShatteringSmash:Start(31.5)
			else
				timerShatteringSmashCD:Start(nil, self.vb.smashCount+1)
				countdownShatteringSmash:Start()--Not phase 1, concerns everyone not just tank
			end
			specWarnShatteringSmash:Show(self.vb.smashCount)--Warn all melee in phase 2
			voiceShatteringSmash:Play("carefly")
		end
	elseif spellId == 156928 and self:AntiSpam(3, 5) then
		self.vb.SlagEruption = self.vb.SlagEruption + 1
		specWarnSlagEruption:Show(self.vb.SlagEruption)
		timerSlagEruptionCD:Start(nil, self.vb.SlagEruption+1)
	elseif spellId == 158054 then
		smashTank = UnitName("boss1target")
		self.vb.smashCount = self.vb.smashCount + 1
		specWarnMassiveShatteringSmash:Show(self.vb.smashCount)
		timerShatteringSmashCD:Start(24.5, self.vb.smashCount+1)--Use this cd bar in phase 3 as well, because text for "Massive Shattering Smash" too long.
		countdownShatteringSmash:Start(24.5)
		voiceShatteringSmash:Play("carefly")
		if self.Options.RangeFrame and smashTank then
			--Open regular range frame if you are the smash tank, even if you are a bomb, because now you don't have a choice.
			if smashTank == UnitName("player") then
				DBM.RangeCheck:Show(6)
			--Don't open radar for massive smash if you are one of bomb targets
			elseif not UnitDebuff("player", GetSpellInfo(157000)) and not UnitDebuff("player", GetSpellInfo(159179)) then
				DBM.RangeCheck:Show(6, tankFilter)
			end
			self:Schedule(4, massiveOver, self)
		end
	--"<175.87 23:28:43> [CLEU] SPELL_CAST_START#Vehicle-0-3127-1205-1151-80660-0000732F74#自爆攻城戰車##nil#163008#巨大的爆炸#nil#nil", -- [13865]
	--"<182.00 23:28:49> [CLEU] UNIT_DIED##nil#Vehicle-0-3127-1205-1151-80660-0000732F74#自爆攻城戰車#-1#false#nil#nil", -- [14611]
	elseif spellId == 163008 then
		specWarnMassiveExplosion:Show()
		timerMassiveExplosion:Start()
		voiceMassiveExplosion:Play("aesoon")
	end
end

local mfdDebuff = GetSpellInfo(156096)
local playerName = UnitName("player")
local function checkMarked(self)
	if not UnitDebuff("player", mfdDebuff) then
		voiceMarkedforDeath:Play("156096")
	end
	--Sort by raidid since combat log order may diff person to person
	--Order changed from left middle right to left right middle to match BW to prevent conflict in dual mod raids.
	--This feature was suggested and started before that mod appeared, but since it exists, focus is on ensuring they work well together
	if self:IsMythic() then
		local mfdFound = 0
		local numGroupMembers = DBM:GetNumGroupMembers()
		if numGroupMembers < 3 then return end--Future proofing solo raid. can't assign 3 positions if less than 3 people
		for i = 1, numGroupMembers do
			if UnitDebuff("raid"..i, mfdDebuff) then
				mfdFound = mfdFound + 1
				if UnitName("raid"..i) == playerName then
					if mfdFound == 1 then
						if self.Options.SpecWarn156096you then
							specWarnMFDPosition:Show(L.left)
						end
						yellMarkedforDeath:Yell(L.left, playerName)
						voiceMarkedforDeath:Schedule(0.7, "left")--Schedule another 0.7, for total of 1.2 second after "find shelder"
					elseif mfdFound == 2 then
						if self.Options.SpecWarn156096you then
							specWarnMFDPosition:Show(L.right)
						end
						yellMarkedforDeath:Yell(L.right, playerName)
						voiceMarkedforDeath:Schedule(0.7, "right")--Schedule another 0.7, for total of 1.2 second after "find shelder"
					elseif mfdFound == 3 then
						if self.Options.SpecWarn156096you then
							specWarnMFDPosition:Show(L.middle)
						end
						yellMarkedforDeath:Yell(L.middle, playerName)
						voiceMarkedforDeath:Schedule(0.7, "center")--Schedule another 0.7, for total of 1.2 second after "find shelder"
					end
				end
				if mfdFound == 3 then break end
			end
		end
	end
end

local slagDebuff = GetSpellInfo(156096)
local function checkSlag(self)
	local slagFound = 0
	local numGroupMembers = DBM:GetNumGroupMembers()
	if numGroupMembers < 3 then return end--Future proofing solo raid. can't assign 3 positions if less than 3 people
	--Was originally going to also do this as 3 positions, but changed to match BW for compatability, for users who want to run DBM in BW dominant raids.
	--this however does not have the 1 melee 1 ranged check BW helper does, but that's because that code doesn't even work and there is no clean way to do it without mid fight inspecting.
	--I bet that gets scrapped anyways. If he does fix his though I'll add it here.
	for i = 1, numGroupMembers do
		if UnitDebuff("raid"..i, slagDebuff) then--Tank excluded on purpose to match BW helper
			slagFound = slagFound + 1
			if UnitName("raid"..i) == playerName then
				if slagFound == 1 then
					if self.Options.SpecWarn157000you then
						specWarnSlagPosition:Show(BACK)
						yellMarkedforDeath:Yell(BACK, playerName)
					end
				elseif slagFound == 2 then
					if self.Options.SpecWarn157000you then
						specWarnSlagPosition:Show(L.middle)
						yellMarkedforDeath:Yell(L.middle, playerName)
					end
				end
			end
			if slagFound == 2 then break end
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 162579 then
		self.vb.deprisCount = self.vb.deprisCount + 1
		specWarnFallingDebris:Show(self.vb.deprisCount)
		timerFallingDebris:Start()
		timerFallingDebrisCD:Start(nil, self.vb.deprisCount+1)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 156096 then
		if self:AntiSpam(2, 3) then
			self.vb.markCount = self.vb.markCount + 1
			if self.vb.phase == 2 then
				self.vb.markCount2 = self.vb.markCount2 + 1
			end
			local timer
			if self.vb.phase == 3 then
				timer = 20.5
			else
				timer = 15.5
			end
			timerImpalingThrow:Start()
			self:Schedule(0.5, checkMarked, self)
			timerMarkedforDeathCD:Start(timer, self.vb.markCount+1)
			countdownMarkedforDeath:Start(timer)
			DBM:Debug("Running experimental timerShatteringSmashCD adjust because debugmode is enabled", 2)
			local elapsed, total = timerShatteringSmashCD:GetTime(self.vb.smashCount+1)
			local remaining = total - elapsed
			DBM:Debug("Smash Elapsed: "..elapsed.." Smash Total: "..total.." Smash Remaining: "..remaining.." MFD Timer: "..timer, 2)
			if (remaining > timer) and (remaining < timer+6) then--Marked for death will come off cd before timerShatteringSmashCD comes off cd and delay the cast
				local extend = (timer+6)-remaining
				DBM:Debug("Delay detected, updating smash timer now. Extend: "..extend)
				timerShatteringSmashCD:Update(elapsed, total+extend, self.vb.smashCount+1)
				countdownShatteringSmash:Cancel()
				countdownShatteringSmash:Start(remaining+extend)
			end
			if self.vb.phase == 2 then
				if self.vb.markCount2 < 3 then
					self.vb.markCount2 = self.vb.markCount2 + 1
				else
					self.vb.markCount2 = 1
				end
			end
		end
		local countFormat = self.vb.markCount
		if self.vb.phase == 2 then
			countFormat = self.vb.markCount.."-"..self.vb.markCount2
		end
		markTargets[#markTargets + 1] = args.destName
		self:Unschedule(warnMarked)
		self:Schedule(0.5, warnMarked, self, countFormat)
		if args:IsPlayer() then
			specWarnMarkedforDeath:Show()
			voiceMarkedforDeath:Play("findshelter")
			countdownMarkedforDeathFades:Start()
			if not self:IsMythic() then
				yellMarkedforDeath:Yell()
			end
		end
		if self.Options.SetIconOnMarked then
			if self:IsMythic() then
				self:SetSortedIcon(1, args.destName, 1, 3)
			else
				self:SetSortedIcon(1, args.destName, 1, 2)
			end
		end
		if self.Options.HudMapOnMFD then
			DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 5, 5, 1, 1, 0, 0.5, nil, true):Pulse(0.5, 0.5)
		end
	elseif spellId == 157000 or spellId == 159179 then--Combine tank version with non tank version
		warnAttachSlagBombs:CombinedShow(0.5, args.destName)
		if self:AntiSpam(2, 4) then
			timerAttachSlagBombsCD:Start()
			countdownSlagBombs:Start(26)
		end
		if args:IsPlayer() then
			specWarnAttachSlagBombs:Show()
			if self:IsTank() or not self:IsMythic() then
				yellAttachSlagBombs:Yell()
			else
				self:Schedule(0.5, checkSlag, self)
			end
			timerSlagBomb:Start()
			voiceAttachSlagBombs:Play("runout")
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10)
			end
		end
		--Tank stuff
		if spellId == 159179 then--tank version
			if not args:IsPlayer() then
				specWarnAttachSlagBombsOther:Show(args.destName)
			end
			voiceAttachSlagBombs:Play("changemt")
		end
	elseif spellId == 156667 then
		self.vb.markCount2 = 0
		self.vb.siegemaker = self.vb.siegemaker + 1
		if not self.Options.SpecWarnej9571spell then
			warnSiegemaker:Show(self.vb.siegemaker)
		else
			specWarnSiegemaker:Show(self.vb.siegemaker)
		end
		timerSiegemakerCD:Start(nil, self.vb.siegemaker+1)
	elseif spellId == 156401 and args:IsPlayer() and self:AntiSpam(2, 1) then
		specWarnMoltenSlag:Show()
	elseif spellId == 156653 then
		if args:IsPlayer() then
			specWarnFixate:Show()
			yellFixate:Yell()
		else
			warnFixate:Show(args.destName)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 156096 then
		if self.Options.HudMapOnMFD then
			DBMHudMap:FreeEncounterMarkerByTarget(spellId, args.destName)
		end
		timerImpalingThrow:Cancel()
		if self.Options.SetIconOnMarked then
			self:SetIcon(args.destName, 0)
		end
	elseif (spellId == 157000 or spellId == 159179) and args:IsPlayer() then
		timerSlagBomb:Cancel()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif spellId == 156667 then
		specWarnSiegemakerPlatingFades:Show()
		voiceSiegemaker:Play("ej9571")
	end
end

function mod:SPELL_ENERGIZE(_, _, _, _, destGUID, _, _, _, spellId, _, _, amount)
	if spellId == 104915 and destGUID == UnitGUID("boss1") then
		--TODO, even more complex marked for death checks here to factor that into energy updating.
		DBM:Debug("SPELL_ENERGIZE fired on Blackhand, 4 targets not hit? Amount: "..amount)
		local bossPower = UnitPower("boss1")
		bossPower = bossPower / 4--4 energy per second, smash every 25 seconds there abouts.
		local remaining = 25-bossPower
		countdownShatteringSmash:Cancel()
		countdownShatteringSmash:Start(remaining)
		timerShatteringSmashCD:Start(remaining, self.vb.smashCount+1)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 156401 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnMoltenSlag:Show()
	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if (spellId == 156031 or spellId == 156998) and self:AntiSpam(2, 2) then--156031 phase 1, 156991 phase 2. 156998 is also usuable for phase 2 but 156991
		specWarnThrowSlagBombs:Show()
		timerThrowSlagBombsCD:Start()
		countdownSlagBombs:Start()
		voiceThrowSlagBombs:Play("bombsoon")
	elseif spellId == 156425 then
		self.vb.demolitionCount = self.vb.demolitionCount + 1
		specWarnDemolition:Show(self.vb.demolitionCount)
		if self:IsMythic() then
			self.vb.deprisCount = 0
			timerDemolitionCD:Start(30.5, self.vb.demolitionCount + 1)
		else
			timerDemolitionCD:Start(nil, self.vb.demolitionCount + 1)
		end
		timerMassiveDemolitionCD:Start(nil, 1)
		if self:IsMythic() then
			timerMassiveDemolitionCD:Schedule(6, 3, 2)
			specWarnMassiveDemolition:Schedule(6, 1)
			timerMassiveDemolitionCD:Schedule(9, 3, 3)
			specWarnMassiveDemolition:Schedule(9, 2)
			timerMassiveDemolitionCD:Schedule(12, 3, 4)
			specWarnMassiveDemolition:Schedule(12, 3)
			specWarnMassiveDemolition:Schedule(15, 4)
		else
			timerMassiveDemolitionCD:Schedule(6, 5, 2)
			specWarnMassiveDemolition:Schedule(6, 1)
			timerMassiveDemolitionCD:Schedule(11, 5, 3)
			specWarnMassiveDemolition:Schedule(11, 2)
			specWarnMassiveDemolition:Schedule(16, 3)
		end
		voiceDemolition:Play("aesoon")
	elseif spellId == 161347 then--Phase 2 Trigger
		self.vb.phase = 2
		self.vb.smashCount = 0
		self.vb.siegemaker = 0
		self.vb.markCount = 0
		self.vb.markCount2 = 0
		timerDemolitionCD:Cancel()
		timerMassiveDemolitionCD:Cancel()
		timerMassiveDemolitionCD:Unschedule()
		specWarnMassiveDemolition:Cancel()
		countdownSlagBombs:Cancel()
		countdownSlagBombs:Start(11)
		timerThrowSlagBombsCD:Cancel()
		timerThrowSlagBombsCD:Start(11)--11-12.5
		timerSiegemakerCD:Start(15, 1)
		countdownShatteringSmash:Cancel()
		timerShatteringSmashCD:Cancel()
		if self:IsMythic() then--Boss gain power faster on mythic phase 2
			countdownShatteringSmash:Start(18)
			timerShatteringSmashCD:Start(18, 1)--18 seen in 10 pulls worth of data.
		else
			countdownShatteringSmash:Start(21)
			timerShatteringSmashCD:Start(21, 1)--21-23 variation. Boss power is set to 66/100 automatically by transitions
		end
		timerMarkedforDeathCD:Cancel()
		timerMarkedforDeathCD:Start(25.5, 1)
		countdownMarkedforDeath:Cancel()
		countdownMarkedforDeath:Start(25)
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.phase:format(2))
		voicePhaseChange:Play("ptwo")
		--Maybe not needed whole phase, only when balcony adds are up? A way to detect and improve?
		if self.Options.RangeFrame and not self:IsMelee() then
			DBM.RangeCheck:Show(6)
		end
	elseif spellId == 161348 then--Phase 3 Trigger
		self.vb.phase = 3
		self.vb.smashCount = 0
		self.vb.markCount = 0
		timerSiegemakerCD:Cancel()
		timerThrowSlagBombsCD:Cancel()
		countdownSlagBombs:Cancel()
		if self:IsMythic() then
			timerFallingDebrisCD:Start(10, 1)
		end
		timerAttachSlagBombsCD:Start(11)
		countdownSlagBombs:Start(11)
		countdownShatteringSmash:Cancel()
		countdownShatteringSmash:Start(26)
		timerShatteringSmashCD:Cancel()
		timerShatteringSmashCD:Start(26, 1)--26-28 variation. Boss power is set to 33/100 automatically by transition (after short delay)
		timerMarkedforDeathCD:Cancel()
		timerMarkedforDeathCD:Start(17, 1)
		countdownMarkedforDeath:Cancel()
		countdownMarkedforDeath:Start(17)
		timerSlagEruptionCD:Start(31.5, 1)
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.phase:format(3))
		voicePhaseChange:Play("pthree")
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	end
end
