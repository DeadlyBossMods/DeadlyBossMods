local mod	= DBM:NewMod(959, "DBM-BlackrockFoundry", nil, 457)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(68168)
mod:SetEncounterID(1704)
mod:SetZone()
mod:SetUsedIcons(1, 2)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 155992 159142 156928 158054",
	"SPELL_AURA_APPLIED 156096 157000 156667 156401 156653",
	"SPELL_AURA_REMOVED 156096 157000 156667",
	"SPELL_PERIODIC_DAMAGE 156401",
	"SPELL_PERIODIC_MISSED 156401",
	"SPELL_ENERGIZE 104915",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--Phase 2
--TODO, get damage ID for fire on ground created by Mortar
--Phase 3
--TODO, Verify everything works.
--Stage One: The Blackrock Forge
local warnMarkedforDeath			= mod:NewTargetAnnounce(156096, 4)--If not in combat log, find a RAID_BOSS_WHISPER event.
local warnShatteringSmash			= mod:NewSpellAnnounce(155992, 3)
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
local specWarnShatteringSmash		= mod:NewSpecialWarningSpell(155992, "Melee", nil, nil, nil, nil, 2)
local specWarnMoltenSlag			= mod:NewSpecialWarningMove(156401)
--Stage Two: Storage Warehouse
local specWarnSiegemaker			= mod:NewSpecialWarningSwitch("ej9571", "Dps", nil, nil, nil, nil, 2)
local specWarnFixate				= mod:NewSpecialWarningRun(156653, nil, nil, nil, 4)
local yellFixate					= mod:NewYell(156653)
--Stage Three: Iron Crucible
local specWarnSlagEruption			= mod:NewSpecialWarningCount(156928, nil, nil, nil, 2)
local specWarnAttachSlagBombs		= mod:NewSpecialWarningYou(157000, nil, nil, nil, nil, nil, 2)--May change to sound 3, but I don't want it confused with the even more threatening marked for death, so for now will try 1
local yellAttachSlagBombs			= mod:NewYell("OptionVersion2", 157000)
local specWarnMassiveShatteringSmash= mod:NewSpecialWarningSpell(158054, nil, nil, nil, 2)

--Stage One: The Blackrock Forge
mod:AddTimerLine(SCENARIO_STAGE:format(1))
local timerDemolitionCD				= mod:NewNextTimer(45, 156425)
local timerMarkedforDeathCD			= mod:NewNextTimer(15.5, 156096)
local timerThrowSlagBombsCD			= mod:NewCDTimer(25, 156030)--It's a next timer, but sometimes delayed by Shattering Smash
local timerShatteringSmashCD		= mod:NewCDTimer(45.5, 155992)--power based, can variate a little do to blizzard buggy power code.
local timerImpalingThrow			= mod:NewCastTimer(5, 156111)--How long marked target has to aim throw at Debris Pile or Siegemaker
--Stage Two: Storage Warehouse
mod:AddTimerLine(SCENARIO_STAGE:format(2))
local timerSiegemakerCD				= mod:NewNextTimer(50, "ej9571", nil, nil, nil, 156667)
--Stage Three: Iron Crucible
mod:AddTimerLine(SCENARIO_STAGE:format(3))
local timerSlagEruptionCD			= mod:NewCDCountTimer(32.5, 156928)
local timerAttachSlagBombsCD		= mod:NewCDTimer(26, 157000)--26-28. Do to increased cast time vs phase 1 and 2 slag bombs, timer is 1 second longer on CD
local timerSlagBomb					= mod:NewCastTimer(5, 157015)

local voicePhaseChange				= mod:NewVoice(nil, nil, DBM_CORE_AUTO_VOICE2_OPTION_TEXT)
local voiceSiegemaker				= mod:NewVoice("ej9571", "Dps") -- ej9571.ogg tank coming
local voiceShatteringSmash			= mod:NewVoice(155992, "Melee") --carefly
local voiceMarkedforDeath			= mod:NewVoice(156096) --target: findshelter; else: 156096.ogg marked for death
local voiceDemolition				= mod:NewVoice(156425) --AOE
local voiceThrowSlagBombs			= mod:NewVoice(156030) --bombsoon
local voiceAttachSlagBombs			= mod:NewVoice(157000) --target: runout;

mod:AddSetIconOption("SetIconOnMarked", 156096, true)
mod:AddRangeFrameOption("6/10")

mod.vb.phase = 1
mod.vb.SlagEruption = 0
local massiveDemolition = GetSpellInfo(156479)

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.SlagEruption = 0
	timerThrowSlagBombsCD:Start(6-delay)
	timerDemolitionCD:Start(15-delay)
	timerShatteringSmashCD:Start(21-delay)
	timerMarkedforDeathCD:Start(36-delay)
end

function mod:OnCombatEnd()
--	self:UnregisterShortTermEvents()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 155992 or spellId == 159142 then--Phase 1 and then phase 2 version. They don't really need two diff warnings, complicated anyways since auto generated with same spellname is wonky
		if self.Options.SpecWarn155992spell then
			specWarnShatteringSmash:Show()
		else
			warnShatteringSmash:Show()
		end
		if self.vb.phase == 1 then
			timerShatteringSmashCD:Start(30)
		else
			timerShatteringSmashCD:Start()
		end
		voiceShatteringSmash:Play("carefly")
	elseif spellId == 156928 then
		self.vb.SlagEruption = self.vb.SlagEruption + 1
		specWarnSlagEruption:Show(self.vb.SlagEruption)
		timerSlagEruptionCD:Start(nil, self.vb.SlagEruption+1)
	elseif spellId == 158054 then
		specWarnMassiveShatteringSmash:Show()
		timerShatteringSmashCD:Start(25)--Use this cd bar in phase 3 as well, because text for "Massive Shattering Smash" too long.
--		self:RegisterShortTermEvents(
--			"SPELL_DAMAGE",
--			"SPELL_MISSED"
--		)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 156096 then
		warnMarkedforDeath:CombinedShow(0.5, args.destName)
		if self.vb.phase == 3 then
			timerMarkedforDeathCD:Start(21.5)
		else
			timerMarkedforDeathCD:Start()
		end
		timerImpalingThrow:Start()
		if args:IsPlayer() then
			specWarnMarkedforDeath:Show()
			yellMarkedforDeath:Yell()
			voiceMarkedforDeath:Play("findshelter")
		else
			voiceMarkedforDeath:Play("156096")
		end
		if self.Options.SetIconOnMarked then
			self:SetSortedIcon(1, args.destName, 1, 2)
		end
	elseif spellId == 157000 then
		warnAttachSlagBombs:CombinedShow(0.5, args.destName)
		timerAttachSlagBombsCD:Start()
		if args:IsPlayer() then
			specWarnAttachSlagBombs:Show()
			yellAttachSlagBombs:Yell()
			timerSlagBomb:Start()
			voiceAttachSlagBombs:Play("runout")
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10)
			end
--		else--In beta, raid stacked for heals and only bombs ran out, scatter maybe misleading, but will leave here for review
--			voiceAttachSlagBombs:Play("scatter")
		end
	elseif spellId == 156667 then
		warnSiegemaker:Show()
		timerSiegemakerCD:Start()
		voiceSiegemaker:Play("ej9571")
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
		timerImpalingThrow:Cancel()
		if self.Options.SetIconOnMarked then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 157000 and args:IsPlayer() then
		timerSlagBomb:Cancel()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif spellId == 156667 then
		specWarnSiegemaker:Show()
	end
end

--[[
Just in case SPELL_ENERGIZE method doesn't work
do
	local targetsHit = 0
	local function updateSmash(self)
		DBM:Debug("updateSmash is running, 4 targets not hit?")
	end
	function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
		if spellId == 158054 then
			targetsHit = targetsHit + 1
			self:Unschedule(updateSmash)
			self:Schedule(3, updateSmash, self)
			if targetsHit >= 4 then
				self:UnregisterShortTermEvents()--Unregister events and do nothing else, we're done. hit enough targets
				self:Unschedule(updateSmash)
				targetsHit = 0
				DBM:Debug("updateSmash should be aborted. At least 4 targets hit.")
			end
		end
	end
	mod.SPELL_MISSED = mod.SPELL_DAMAGE
end--]]

function mod:SPELL_ENERGIZE(_, _, _, _, destGUID, _, _, _, spellId, _, _, amount)
	if spellId == 104915 and destGUID == UnitGUID("boss1") then
		DBM:Debug("SPELL_ENERGIZE fired on Blackhand, 4 targets not hit? Amount: "..amount)
		local bossPower = UnitPower("boss1")
		bossPower = bossPower / 4--4 energy per second, smash every 25 seconds there abouts.
		local remaining = 25-bossPower
		timerShatteringSmashCD:Start(remaining)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 156401 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnMoltenSlag:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 156031 or spellId == 156991 then--156031 phase 1, 156991 phase 2. 156998 is also usuable for phase 2 but 156991 fires first
		specWarnThrowSlagBombs:Show()
		timerThrowSlagBombsCD:Start()
		voiceThrowSlagBombs:Play("bombsoon")
	elseif spellId == 156425 then
		specWarnDemolition:Show()
		timerDemolitionCD:Start()
		voiceDemolition:Play("aesoon")
	elseif spellId == 161347 then--Phase 2 Trigger
		self.vb.phase = 2
		timerDemolitionCD:Cancel()
		timerThrowSlagBombsCD:Start(11)--11-12.5
		timerSiegemakerCD:Start(15)
		timerShatteringSmashCD:Start(21)--21-23 variation. Boss power is set to 66/100 automatically by transitions
		timerMarkedforDeathCD:Start(25)
		voicePhaseChange:Play("ptwo")
		--Maybe not needed whole phase, only when balcony adds are up? A way to detect and improve?
		if self.Options.RangeFrame and not self:IsMelee() then
			DBM.RangeCheck:Show(6)
		end
	elseif spellId == 161348 then--Phase 3 Trigger
		self.vb.phase = 3
		timerSiegemakerCD:Cancel()
		timerThrowSlagBombsCD:Cancel()
		timerAttachSlagBombsCD:Start(11)
		timerShatteringSmashCD:Start(26)--26-28 variation. Boss power is set to 33/100 automatically by transition (after short delay)
		timerMarkedforDeathCD:Start(27)
		timerSlagEruptionCD:Start(31.5)
		voicePhaseChange:Play("pthree")
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	end
end
