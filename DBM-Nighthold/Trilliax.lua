local mod	= DBM:NewMod(1731, "DBM-Nighthold", nil, 786)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(104327)
mod:SetEncounterID(1867)
mod:SetZone()
mod:SetUsedIcons(1)
--mod:SetHotfixNoticeRev(12324)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 206559 206557 206560 206788 206820 208924 207513 207502",
	"SPELL_CAST_SUCCESS 206641 201427",
	"SPELL_AURA_APPLIED 211615 208910 208915",
	"SPELL_AURA_REMOVED 208499 206560",
	"SPELL_PERIODIC_DAMAGE 206488",
	"SPELL_PERIODIC_MISSED 206488"
)

--TODO, do more videos with debug to determine if combat log order is valid for link partners
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
--Cleaner
local specWarnSterilize				= mod:NewSpecialWarningMoveAway(208499, nil, nil, nil, 1, 2)
local yellSterilize					= mod:NewYell(208499)
local specWarnCleansingRage			= mod:NewSpecialWarningSpell(206820, nil, nil, nil, 2, 2)
--Maniac
local specWarnSearingBonds			= mod:NewSpecialWarningYou(208915, nil, nil, nil, 1, 2)--Change to Moveto warning if possible to know your link
local specWarnAnnihilation			= mod:NewSpecialWarningDodge(201427, nil, nil, nil, 3, 6)--Hallion Style
--Caretaker
local specWarnTidyUp				= mod:NewSpecialWarningDodge(207513, nil, nil, nil, 2, 2)--Maybe switch to mob name instead of "tidy up"

local timerSpearCD					= mod:NewCDTimer(9, 206641, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerPhaseChange				= mod:NewNextTimer(45, 155005, nil, nil, nil, 6)
--Cleaner
mod:AddTimerLine(GetSpellInfo(206560))
local timerToxicSliceCD				= mod:NewCDTimer(18, 206788, nil, nil, nil, 3)
local timerSterilizeCD				= mod:NewNextTimer(3.5, 208499, nil, nil, nil, 3)
local timerCleansingRageCD			= mod:NewNextTimer(11, 206820, nil, nil, nil, 2)
--Maniac
mod:AddTimerLine(GetSpellInfo(206557))
local timerSearingBondsCD			= mod:NewCDTimer(5.7, 208924, nil, nil, nil, 3)--5.7-8
local timerAnnihilationCD			= mod:NewCDTimer(20.3, 201427, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)
--Caretaker
mod:AddTimerLine(GetSpellInfo(206559))
local timerTidyUpCD					= mod:NewNextTimer(10, 207513, nil, nil, nil, 1)
local timerSucculentFeastCD			= mod:NewNextTimer(4.5, 207502, nil, nil, nil, 3)

local countdownModes				= mod:NewCountdown(40, 206560)--All modes
local countdownAnnihilation			= mod:NewCountdown("Alt20", 201427)

local voiceArcaneSeepage			= mod:NewVoice(206488)--runaway
--Cleaner
local voiceSterilize				= mod:NewVoice(208499)--scatter (runout better?)
local voiceCleansingRage			= mod:NewVoice(206820)--aesoon
--Maniac
local voiceSearingBonds				= mod:NewVoice(208915)--linegather
local voiceAnnihilation				= mod:NewVoice(201427)--farfromline (stay away from lines) Good match for cutter laser?

--Caretaker
local voiceTidyUp					= mod:NewVoice(207513)--mobsoon/watchstep

mod:AddRangeFrameOption(12, 208506)
mod:AddHudMapOption("HudMapOnAnnihilation", 201427)
mod:AddInfoFrameOption(214573, false)

mod.vb.spearCooldown = 9
mod.vb.toxicSliceCooldown = 18

function mod:OnCombatStart(delay)
	self.vb.spearCooldown = 9
	self.vb.toxicSliceCooldown = 18
	timerSpearCD:Start(7-delay)
	timerToxicSliceCD:Start(11-delay)
	timerPhaseChange:Start(45)
	countdownModes:Start(45)
	--On combat start he starts in a custom cleaner mode (206570) that doesn't have sterilize or cleansing rage abilities but casts cake and spears more often
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
	if self.Options.HudMapOnAnnihilation then
		DBMHudMap:Disable()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 206560 then--Cleaner Mode (45 seconds)
		self.vb.spearCooldown = 20
		self.vb.toxicSliceCooldown = 22
		warnCleanerMode:Show()
		timerSpearCD:Stop()
		timerSterilizeCD:Start()
		timerCleansingRageCD:Start()
		timerToxicSliceCD:Start(14.5)
		timerSpearCD:Start(20)
		timerPhaseChange:Start(46)
		countdownModes:Start(46)
	elseif spellId == 206557 then--Maniac Mode (40 seconds)
		self.vb.spearCooldown = 7
		warnManiacMode:Show()
		timerSpearCD:Stop()
		timerSpearCD:Start(6)
		timerSearingBondsCD:Start(8)
		timerAnnihilationCD:Start()
		countdownAnnihilation:Start()
		timerPhaseChange:Start(41)
		countdownModes:Start(41)
	elseif spellId == 206559 then--Caretaker Mode (15 seconds)
		timerSpearCD:Stop()
		warnCaretakerMode:Show()
		timerSucculentFeastCD:Start()
		timerTidyUpCD:Start()
		timerPhaseChange:Start(16)
		countdownModes:Start(16)
	elseif spellId == 206788 then--Toxic Slice (Cleaner Mode)
		warnToxicSlice:Show()
		timerToxicSliceCD:Start(self.vb.toxicSliceCooldown)
	elseif spellId == 206820 then--Cleansing Rage (CLeaner Mode)
		specWarnCleansingRage:Show()
		voiceCleansingRage:Play("aesoon")
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
	if spellId == 206641 then--Arcane Spear
		timerSpearCD:Start(self.vb.spearCooldown)
--[[	elseif spellId == 201427 then--Probably wrong Annihilation (Maniac Mode)
		specWarnAnnihilation:Show()
		voiceAnnihilation:Play("farfromline")
		if self.Options.HudMapOnAnnihilation then
			--"<75.04 18:42:00> [CLEU] SPELL_CAST_SUCCESS#Player-970-00048598#Vivye##nil#201427#Annihilation#nil#nil", -- [4781]--sourcename or target name?
			DBMHudMap:RegisterStaticMarkerOnPartyMember(201427, "highlight", args.sourceName, 5, 4, 1, 0, 0, 0.5, nil, 1):Pulse(0.5, 0.5)
		end--]]
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
			specWarnSearingBonds:Show()
			voiceSearingBonds:Play("linegather")
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

