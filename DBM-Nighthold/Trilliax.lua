local mod	= DBM:NewMod(1731, "DBM-Nighthold", nil, 786)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(104327)
mod:SetEncounterID(1867)
mod:SetZone()
mod:SetUsedIcons(1)
mod:SetHotfixNoticeRev(15058)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 206788 208924 207513 207502",
	"SPELL_CAST_SUCCESS 206560 206557 206559 206641",
	"SPELL_AURA_APPLIED 211615 208910 208915 206641",
	"SPELL_AURA_REMOVED 208499 206560",
	"SPELL_PERIODIC_DAMAGE 206488",
	"SPELL_PERIODIC_MISSED 206488",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, do more videos with debug to determine if combat log order is valid for link partners
--[[
(ability.id = 207513 or ability.id = 206788 or ability.id = 207502) and type = "begincast" or
(ability.id = 206560 or ability.id = 206557 or ability.id = 206559 or ability.id = 206641 or ability.id = 207630) and type = "cast" or 
(ability.id = 211615 or ability.id = 208910) and type = "applydebuff"
--]]
--Cleaner
local warnCleanerMode				= mod:NewSpellAnnounce(206560, 2)
local warnToxicSlice				= mod:NewSpellAnnounce(206788, 2)
local warnSterilize					= mod:NewTargetAnnounce(208499, 3)
--Maniac
local warnManiacMode				= mod:NewSpellAnnounce(206557, 2)
--Caretaker
local warnCaretakerMode				= mod:NewSpellAnnounce(206559, 2)
local warnSucculentFeast			= mod:NewSpellAnnounce(207502, 1)

local specWarnArcaneSeepage			= mod:NewSpecialWarningMove(206488, nil, nil, nil, 1, 2)
local specWarnArcanoSlash			= mod:NewSpecialWarningTaunt(206641, nil, nil, nil, 1, 2)
--Cleaner
local specWarnSterilize				= mod:NewSpecialWarningMoveAway(208499, nil, nil, nil, 1, 2)
local yellSterilize					= mod:NewYell(208499)
local specWarnCleansingRage			= mod:NewSpecialWarningSpell(206820, nil, nil, nil, 2, 2)
--Maniac
local specWarnArcingBonds			= mod:NewSpecialWarningYou(208915, nil, nil, nil, 1, 2)--Change to Moveto warning if possible to know your link
local specWarnAnnihilation			= mod:NewSpecialWarningDodge(207630, nil, nil, nil, 3, 6)--Hallion Style
--Caretaker
local specWarnTidyUp				= mod:NewSpecialWarningDodge(207513, nil, nil, nil, 2, 2)--Maybe switch to mob name instead of "tidy up"

local timerArcaneSlashCD			= mod:NewCDTimer(9, 206641, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerPhaseChange				= mod:NewNextTimer(45, 155005, nil, nil, nil, 6)
--Cleaner
mod:AddTimerLine(GetSpellInfo(206560))
local timerToxicSliceCD				= mod:NewCDTimer(18, 206788, nil, nil, nil, 3)
--local timerSterilizeCD				= mod:NewNextTimer(3, 208499, nil, nil, nil, 3)
local timerCleansingRageCD			= mod:NewNextTimer(10, 206820, nil, nil, nil, 2)
--Maniac
mod:AddTimerLine(GetSpellInfo(206557))
local timerArcingBondsCD			= mod:NewCDTimer(5, 208924, nil, nil, nil, 3)--5.7-8
local timerAnnihilationCD			= mod:NewCDTimer(20.3, 207630, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)
--Caretaker
mod:AddTimerLine(GetSpellInfo(206559))
local timerTidyUpCD					= mod:NewNextTimer(10, 207513, nil, nil, nil, 1)
local timerSucculentFeastCD			= mod:NewNextTimer(4.5, 207502, nil, nil, nil, 3)

local countdownModes				= mod:NewCountdown(40, 206560)--All modes
local countdownAnnihilation			= mod:NewCountdown("Alt20", 207630)

local voiceArcaneSeepage			= mod:NewVoice(206488)--runaway
local voiceArcaneSlash				= mod:NewVoice(206641)--tauntboss
--Cleaner
local voiceSterilize				= mod:NewVoice(208499)--scatter (runout better?)
local voiceCleansingRage			= mod:NewVoice(206820)--aesoon
--Maniac
local voiceArcingBonds				= mod:NewVoice(208915)--linegather
local voiceAnnihilation				= mod:NewVoice(207630)--farfromline (stay away from lines) Good match for cutter laser?

--Caretaker
local voiceTidyUp					= mod:NewVoice(207513)--mobsoon/watchstep

mod:AddRangeFrameOption(12, 208506)
mod:AddInfoFrameOption(214573, false)

mod.vb.ArcaneSlashCooldown = 10.5--10.5 now?, Verify it can never be 9 anymore
mod.vb.toxicSliceCooldown = 26.5--Confirmed still true

function mod:OnCombatStart(delay)
	self.vb.ArcaneSlashCooldown = 10.5
	self.vb.toxicSliceCooldown = 26.5
	timerArcaneSlashCD:Start(7-delay)
	timerToxicSliceCD:Start(10.5-delay)
	timerPhaseChange:Start(45)--Maniac
	countdownModes:Start(45)
	--On combat start he starts in a custom cleaner mode (206570) that doesn't have sterilize or cleansing rage abilities but casts cake and ArcaneSlashs more often
	if self.Options.InfoFrame then
		local spellName = GetSpellInfo(214573)
		DBM.InfoFrame:SetHeader(spellName)
		DBM.InfoFrame:Show(10, "playerbaddebuff", spellName, true)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 206788 then--Toxic Slice (Cleaner Mode)
		warnToxicSlice:Show()
		timerToxicSliceCD:Start(self.vb.toxicSliceCooldown)
	elseif spellId == 207513 then--Tidy Up (Caretaker Mode)
		specWarnTidyUp:Show()
		voiceTidyUp:Play("mobsoon")
		voiceTidyUp:Schedule(1.5, "watchstep")
	elseif spellId == 207502 then--Succulent Feast (Caretaker Mode)
		warnSucculentFeast:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 206560 then--Cleaner Mode (45 seconds)
		self.vb.ArcaneSlashCooldown = 18
		self.vb.toxicSliceCooldown = 22--Still 22? 27 in mythic logs
		warnCleanerMode:Show()
		timerArcaneSlashCD:Stop()
		--timerSterilizeCD:Start()--Used 1-3 seconds later
		timerCleansingRageCD:Start()--10
		timerToxicSliceCD:Start(13)
		timerArcaneSlashCD:Start(19.5)
		timerPhaseChange:Start(45)--Maniac
		countdownModes:Start(45)
	elseif spellId == 206557 then--Maniac Mode (40 seconds)
		self.vb.ArcaneSlashCooldown = 7
		warnManiacMode:Show()
		timerToxicSliceCD:Stop()--Must be stopped here too since first cleaner mode has no buff removal
		timerArcaneSlashCD:Stop()
		timerArcingBondsCD:Start(5)--Updated Jan 24, make sure it's ok consistently
		timerArcaneSlashCD:Start(9)--Updated Jan 24, make sure it's ok consistently
		timerAnnihilationCD:Start()--20
		countdownAnnihilation:Start()--20
		timerPhaseChange:Start(40)--Caretaker
		countdownModes:Start(40)
	elseif spellId == 206559 then--Caretaker Mode (15 seconds)
		timerArcaneSlashCD:Stop()
		warnCaretakerMode:Show()
		timerSucculentFeastCD:Start()--4.5-5
		timerTidyUpCD:Start()--10-11
		timerPhaseChange:Start(13)--Cleaner
		countdownModes:Start(13)
	elseif spellId == 206641 then--Arcane ArcaneSlash
		timerArcaneSlashCD:Start(self.vb.ArcaneSlashCooldown)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 211615 then--Pre debuff
		warnSterilize:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnSterilize:Show()
			voiceSterilize:Play("scatter")
			yellSterilize:Yell()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(12)
			end
		end
	elseif spellId == 208910 or spellId == 208915 then--Searing Bonds (two IDs for paired off links)
		if args:IsPlayer() then
			specWarnArcingBonds:Show()
			voiceArcingBonds:Play("linegather")
		end
	elseif spellId == 206641 then
		if not args:IsPlayer() and not UnitDebuff("player", args.spellName) and not UnitIsDeadOrGhost("player") then
			specWarnArcanoSlash:Show(args.destName)
			voiceArcaneSlash:Play("tauntboss")
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 208499 then--Post debuff
		if args:IsPlayer() then
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
	elseif spellId == 206560 then--Cleaner Mode (45 seconds)
		timerToxicSliceCD:Stop()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 206488 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnArcaneSeepage:Show()
		voiceArcaneSeepage:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 207620 then--Annihilation pre cast, faster than combat log
		specWarnAnnihilation:Show()
		voiceAnnihilation:Play("farfromline")
	elseif spellId == 206834 then--Cleansing Rage
		specWarnCleansingRage:Show()
		voiceCleansingRage:Play("aesoon")
	end
end
