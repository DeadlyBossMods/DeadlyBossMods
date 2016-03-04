local mod	= DBM:NewMod(1731, "DBM-Suramar", nil, 786)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(104327)
mod:SetEncounterID(1867)
mod:SetZone()
mod:SetUsedIcons(1)
--mod:SetHotfixNoticeRev(12324)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 206559 206557 206560 206788 208506 206820 208924 207513 207502",
	"SPELL_CAST_SUCCESS 206641 206482",
	"SPELL_AURA_APPLIED 208499 208915 207630",
	"SPELL_AURA_REMOVED 208499 206560 206557 206559 208915",
	"SPELL_PERIODIC_DAMAGE 206488",
	"SPELL_PERIODIC_MISSED 206488",
	"CHAT_MSG_MONSTER_YELL"
)

--TODO, target scanning for Arcane Seepage?
--TODO, see if the 3 modes affect spear cd at all
--TODO, see if seepage is in fact dps based or just CD based with poor wording
--TODO, target scanning for all the food throws
--TODO, Maniac mode code for more rapid spear attacks
--TODO, Mana rupture need warnings?
--TODO, add voice for annihilation when I have a clue how it works
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
local specWarnSearingBonds			= mod:NewSpecialWarningYou(208915, nil, nil, nil, 1, 2)--Change to Moveto warning if possible to know your links
local specWarnAnnihilation			= mod:NewSpecialWarningDodge(208915, nil, nil, nil, 3, 2)--How does it work? Garrosh Style?
--Caretaker
local specWarnTidyUp				= mod:NewSpecialWarningSwitch(206820, "Tank", nil, nil, 2, 2)--Maybe switch to mob name instead of "tidy up"

local timerSpearCD					= mod:NewAITimer(16, 206641, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
--Cleaner
local timerToxicSliceCD				= mod:NewAITimer(16, 206788, nil, nil, nil, 3)
local timerSterilizeCD				= mod:NewAITimer(16, 208499, nil, nil, nil, 3)
--Maniac
local timerSearingBondsCD			= mod:NewAITimer(16, 208924, nil, nil, nil, 3)
--Caretaker
local timerTidyUpCD					= mod:NewAITimer(16, 206820, nil, nil, nil, 1)--Everyone?
local timerSucculentFeastCD			= mod:NewAITimer(16, 207502, nil, nil, nil, 3)

--local countdownMagicFire			= mod:NewCountdownFades(11.5, 162185)

local voiceArcaneSeepage			= mod:NewVoice(206488)--runaway
--Cleaner
local voiceSterilize				= mod:NewVoice(208499)--scatter
local voiceCleansingRage			= mod:NewVoice(206820)--aesoon
--Maniac
local voiceSearingBonds				= mod:NewVoice(208915)--linegather (or gathershare)
--Caretaker
local voiceTidyUp					= mod:NewVoice(208915, "Tank")--mobsoon

mod:AddRangeFrameOption(12, 208506)
--mod:AddSetIconOption("SetIconOnMC", 163472, false)
--mod:AddHudMapOption("HudMapOnMC", 163472)

mod.vb.maniacActive = false

function mod:OnCombatStart(delay)
	self.vb.maniacActive = false
	--Probably not started here
--	timerSpearCD:Start(1-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
--	if self.Options.FelArrow then
--		DBM.Arrow:Hide()
--	end
--	if self.Options.HudMapOnMC then
--		DBMHudMap:Disable()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 206560 then--Cleaner Mode (45 seconds)
		warnCleanerMode:Show()
		timerSpearCD:Cancel()
		timerSpearCD:Start(1)
		timerToxicSliceCD:Start(1)
		timerSterilizeCD:Start(1)
	elseif spellId == 206557 then--Maniac Mode (40 seconds)
		warnManiacMode:Show()
		self.vb.maniacActive = true
		timerSpearCD:Cancel()
		timerSpearCD:Start(2)
		timerSearingBondsCD:Start(1)
	elseif spellId == 206559 then--Caretaker Mode (15 seconds)
		warnCaretakerMode:Show()
		timerSpearCD:Cancel()
		timerSpearCD:Start(3)
		timerTidyUpCD:Start(1)
		timerSucculentFeastCD:Start(1)
	elseif spellId == 206788 then--Toxic Slice (Cleaner Mode)
		warnToxicSlice:Show()
		timerToxicSliceCD:Start()
	elseif spellId == 208506 then--Sterilize (Cleaner Mode)
		timerSterilizeCD:Start()
	elseif spellId == 206820 then--Cleansing Rage (CLeaner Mode)
		specWarnCleansingRage:Show()
		voiceCleansingRage:Play("aesoon")
	elseif spellId == 208924 then--Searing Bonds (Maniac Mode)
		timerSearingBondsCD:Start()
	elseif spellId == 207513 then--Tidy Up (Caretaker Mode)
		specWarnTidyUp:Show()
		voiceTidyUp:Play("mobsoon")
		timerTidyUpCD:Start()
	elseif spellId == 207502 then--Succulent Feast (Caretaker Mode)
		warnSucculentFeast:Show()
		timerSucculentFeastCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 206641 then--Arcane Spear
		if self.vb.manicActive then--(increasing the frequency of Arcane Spear)
			--timerSpearCD:Start()
		else
			timerSpearCD:Start()
		end
	elseif spellId == 206482 then--Arcane Seepage
		--YARN
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 208499 then
		warnSterilize:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnSterilize:Show()
			voiceSterilize:Play("scatter")
			yellSterilize:Yell()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(12)
			end
		end
	elseif spellId == 208915 then--Searing Bonds 1
		if args:IsPlayer() then
			specWarnSearingBonds:Show()
			voiceSearingBonds:Play("linegather")
		end
--	elseif spellId == 208910 then--Searing Bonds 2 (in case 1 doesn't work)
--		if args:IsPlayer() then
--			specWarnSearingBonds:Show()
--			voiceSearingBonds:Play("linegather")
--		end	
	elseif spellId == 207630 then--Probably wrong Annihilation (Maniac Mode)
		specWarnAnnihilation:Show()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 208499 then
		if args:IsPlayer() then
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
	elseif spellId == 206560 then--Cleaner Mode (45 seconds)
		timerToxicSliceCD:Cancel()
		timerSterilizeCD:Cancel()
	elseif spellId == 206557 then--Maniac Mode (40 seconds) (increasing the frequency of Arcane Spear)
		self.vb.maniacActive = false
		timerSearingBondsCD:Cancel()
		--Code to update spear timer probably
	elseif spellId == 206559 then--Caretaker Mode (15 seconds)
		timerTidyUpCD:Cancel()
		timerSucculentFeastCD:Cancel()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 206488 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnArcaneSeepage:Show()
		voiceArcaneSeepage:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:CHAT_MSG_MONSTER_YELL(msg, _, _, _, target)
	if msg:find(L.supressionTarget1) then
--		self:SendSync("ChargeTo", target)
	end
end

function mod:OnSync(msg, targetname)
	if not self:IsInCombat() then return end
	if msg == "ChargeTo" then
		
	end
end
--]]
