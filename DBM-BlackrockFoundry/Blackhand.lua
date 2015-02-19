local mod	= DBM:NewMod(959, "DBM-BlackrockFoundry", nil, 457)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(77325)--68168
mod:SetEncounterID(1704)
mod:SetZone()
mod:SetUsedIcons(2, 1)
mod:SetHotfixNoticeRev(12813)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 155992 159142 156928 158054",
	"SPELL_AURA_APPLIED 156096 157000 156667 156401 156653 159179",
	"SPELL_AURA_REMOVED 156096 157000 156667 159179",
	"SPELL_PERIODIC_DAMAGE 156401",
	"SPELL_ABSORBED 156401",
	"SPELL_ENERGIZE 104915",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--Phase 2
--TODO, get damage ID for fire on ground created by Mortar
--Stage One: The Blackrock Forge
local warnMarkedforDeath			= mod:NewTargetAnnounce(156096, 4)--If not in combat log, find a RAID_BOSS_WHISPER event.
--Stage Two: Storage Warehouse
local warnSiegemaker				= mod:NewSpellAnnounce("ej9571", 3, 156667)
local warnFixate					= mod:NewTargetAnnounce(156653, 4)
--Stage Three: Iron Crucible
local warnAttachSlagBombs			= mod:NewTargetAnnounce(157000, 4)

--Stage One: The Blackrock Forge
local specWarnDemolition			= mod:NewSpecialWarningSpell(156425, nil, nil, nil, 2, nil, 2)
local specWarnMarkedforDeath		= mod:NewSpecialWarningYou(156096, nil, nil, nil, 3, nil, 2)
local yellMarkedforDeath			= mod:NewYell(156096)
local specWarnThrowSlagBombs		= mod:NewSpecialWarningMove(156030, nil, nil, nil, nil, nil, 2)
local specWarnShatteringSmash		= mod:NewSpecialWarningCount(155992, "Melee", nil, nil, nil, nil, 2)
local specWarnMoltenSlag			= mod:NewSpecialWarningMove(156401)
--Stage Two: Storage Warehouse
local specWarnSiegemaker			= mod:NewSpecialWarningSpell("ej9571", false)--Kiter switch. off by default. 
local specWarnSiegemakerPlatingFades= mod:NewSpecialWarningFades("OptionVersion2", 156667, "Ranged")--Plating removed, NOW dps switch
local specWarnFixate				= mod:NewSpecialWarningRun(156653, nil, nil, nil, 4)
local yellFixate					= mod:NewYell(156653)
--Stage Three: Iron Crucible
local specWarnSlagEruption			= mod:NewSpecialWarningCount(156928, nil, nil, nil, 2)
local specWarnAttachSlagBombs		= mod:NewSpecialWarningYou(157000, nil, nil, nil, nil, nil, 2)--May change to sound 3, but I don't want it confused with the even more threatening marked for death, so for now will try 1
local specWarnAttachSlagBombsOther	= mod:NewSpecialWarningTaunt(157000, nil, nil, nil, nil, nil, 2)
local yellAttachSlagBombs			= mod:NewYell("OptionVersion2", 157000)
local specWarnMassiveShatteringSmash= mod:NewSpecialWarningCount("OptionVersion2", 158054, nil, nil, nil, 3, nil, 2)

--Stage One: The Blackrock Forge
mod:AddTimerLine(SCENARIO_STAGE:format(1))
local timerDemolitionCD				= mod:NewNextTimer(45, 156425)
local timerMarkedforDeathCD			= mod:NewNextTimer(15.5, 156096)
local timerThrowSlagBombsCD			= mod:NewCDTimer(25, 156030)--It's a next timer, but sometimes delayed by Shattering Smash
local timerShatteringSmashCD		= mod:NewCDCountTimer(45.5, 155992)--power based, can variate a little do to blizzard buggy power code.
local timerImpalingThrow			= mod:NewCastTimer(5, 156111)--How long marked target has to aim throw at Debris Pile or Siegemaker
--Stage Two: Storage Warehouse
mod:AddTimerLine(SCENARIO_STAGE:format(2))
local timerSiegemakerCD				= mod:NewNextTimer(50, "ej9571", nil, nil, nil, 156667)
--Stage Three: Iron Crucible
mod:AddTimerLine(SCENARIO_STAGE:format(3))
local timerSlagEruptionCD			= mod:NewCDCountTimer(32.5, 156928)
local timerAttachSlagBombsCD		= mod:NewCDTimer(26, 157000)--26-28. Do to increased cast time vs phase 1 and 2 slag bombs, timer is 1 second longer on CD
local timerSlagBomb					= mod:NewCastTimer(5, 157015)

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
local voiceAttachSlagBombs			= mod:NewVoice(157000) --target: runout;

mod:AddSetIconOption("SetIconOnMarked", 156096, true)
mod:AddRangeFrameOption("6/10")
mod:AddHudMapOption("HudMapOnMFD", 156096)

mod.vb.phase = 1
mod.vb.SlagEruption = 0
mod.vb.smashCount = 0
local UnitDebuff = UnitDebuff
local DBMHudMap = DBMHudMap

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.SlagEruption = 0
	self.vb.smashCount = 0
	timerThrowSlagBombsCD:Start(6-delay)
	countdownSlagBombs:Start(6-delay)
	timerDemolitionCD:Start(15-delay)
	timerShatteringSmashCD:Start(21-delay, 1)
	if self:IsTank() then--Ability only concerns tank in phase 1
		countdownShatteringSmash:Start(21-delay)
	end
	timerMarkedforDeathCD:Start(36-delay)
	countdownMarkedforDeath:Start(36-delay)
	if self.Options.HudMapOnMFD then
		DBMHudMap:Enable()
	end
end

function mod:OnCombatEnd()
--	self:UnregisterShortTermEvents()
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
			timerShatteringSmashCD:Start(nil, self.vb.smashCount+1)
			countdownShatteringSmash:Start()--Not phase 1, concerns everyone not just tank
			specWarnShatteringSmash:Show(self.vb.smashCount)--Warn all melee in phase 2
			voiceShatteringSmash:Play("carefly")
		end
	elseif spellId == 156928 then
		self.vb.SlagEruption = self.vb.SlagEruption + 1
		specWarnSlagEruption:Show(self.vb.SlagEruption)
		timerSlagEruptionCD:Start(nil, self.vb.SlagEruption+1)
	elseif spellId == 158054 then
		self.vb.smashCount = self.vb.smashCount + 1
		specWarnMassiveShatteringSmash:Show(self.vb.smashCount)
		timerShatteringSmashCD:Start(25, self.vb.smashCount+1)--Use this cd bar in phase 3 as well, because text for "Massive Shattering Smash" too long.
		countdownShatteringSmash:Start(25)
		voiceShatteringSmash:Play("carefly")
--		self:RegisterShortTermEvents(
--			"SPELL_DAMAGE",
--			"SPELL_MISSED"
--		)
	end
end

local debuff = GetSpellInfo(156096)
local function checkMarked()
	if not UnitDebuff("player", debuff) then
		voiceMarkedforDeath:Play("156096")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 156096 then
		warnMarkedforDeath:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnMarkedforDeath:Show()
			yellMarkedforDeath:Yell()
			voiceMarkedforDeath:Play("findshelter")
			countdownMarkedforDeathFades:Start()
		end
		if self:AntiSpam(2, 3) then
			local timer
			if self.vb.phase == 3 then
				timer = 20.5
			else
				timer = 15.5
			end
			timerImpalingThrow:Start()
			self:Schedule(0.5, checkMarked)
			timerMarkedforDeathCD:Start(timer)
			countdownMarkedforDeath:Start(timer)
			if DBM.Options.DebugMode then--Experimental smash timer adjusting for marked for death delays
				DBM:Debug("Running experimental timerShatteringSmashCD adjust because debugmode is enabled", 2)
				local elapsed, total = timerShatteringSmashCD:GetTime(self.vb.smashCount+1)
				local remaining = total - elapsed
				DBM:Debug("Smash Elapsed: "..elapsed.." Smash Total: "..total.." Smash Remaining: "..remaining.." MFD Timer: "..timer, 2)
				if (remaining > timer) and (remaining < timer+5) then--Marked for death will come off cd before timerShatteringSmashCD comes off cd and delay the cast
					local extend = (timer+5)-remaining
					DBM:Debug("Delay detected, updating smash timer now. Extend: "..extend)
					timerShatteringSmashCD:Update(elapsed, total+extend, self.vb.smashCount+1)
					countdownShatteringSmash:Cancel()
					countdownShatteringSmash:Start(remaining+extend)
				end
			end
		end
		if self.Options.SetIconOnMarked then
			self:SetSortedIcon(1, args.destName, 1, 2)
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
			yellAttachSlagBombs:Yell()
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
		if not self.Options.SpecWarnej9571spell then
			warnSiegemaker:Show()
		else
			specWarnSiegemaker:Show()
		end
		timerSiegemakerCD:Start()
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
		specWarnDemolition:Show()
		timerDemolitionCD:Start()
		voiceDemolition:Play("aesoon")
	elseif spellId == 161347 then--Phase 2 Trigger
		self.vb.phase = 2
		self.vb.smashCount = 0
		timerDemolitionCD:Cancel()
		countdownSlagBombs:Cancel()
		countdownSlagBombs:Start(11)
		timerThrowSlagBombsCD:Start(11)--11-12.5
		timerSiegemakerCD:Start(15)
		countdownShatteringSmash:Cancel()
		countdownShatteringSmash:Start(21)
		timerShatteringSmashCD:Start(21, 1)--21-23 variation. Boss power is set to 66/100 automatically by transitions
		timerMarkedforDeathCD:Start(25)
		countdownMarkedforDeath:Cancel()
		countdownMarkedforDeath:Start(25)
		voicePhaseChange:Play("ptwo")
		--Maybe not needed whole phase, only when balcony adds are up? A way to detect and improve?
		if self.Options.RangeFrame and not self:IsMelee() then
			DBM.RangeCheck:Show(6)
		end
	elseif spellId == 161348 then--Phase 3 Trigger
		self.vb.phase = 3
		self.vb.smashCount = 0
		timerSiegemakerCD:Cancel()
		timerThrowSlagBombsCD:Cancel()
		countdownSlagBombs:Cancel()
		timerAttachSlagBombsCD:Start(11)
		countdownSlagBombs:Start(11)
		countdownShatteringSmash:Cancel()
		countdownShatteringSmash:Start(26)
		timerShatteringSmashCD:Start(26, 1)--26-28 variation. Boss power is set to 33/100 automatically by transition (after short delay)
		timerMarkedforDeathCD:Start(27)
		countdownMarkedforDeath:Cancel()
		countdownMarkedforDeath:Start(27)
		timerSlagEruptionCD:Start(31.5)
		voicePhaseChange:Play("pthree")
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	end
end
