local mod	= DBM:NewMod(1486, "DBM-Party-Legion", 4, 721)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(95833)
mod:SetEncounterID(1806)
mod:SetZone()

mod:RegisterCombat("combat")
mod:SetWipeTime(120)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 192048 192133 192132",
	"SPELL_AURA_REMOVED 192048",
	"SPELL_CAST_START 192158 192018 192307 200901 192288",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--Notes: Saw no timer consistency since they are all over the place based on where boss is dragged.
--TODO: maybe figure out how dragging boss around affects timers. Might be worth the work for a 5 man boss though.
--["192044-Expel Light"] = "pull:79.7, 26.6, 30.3, 24.3, 30.3",
--Maybe add a searing light interrupt helper if it matters enough on mythic+
local warnExpelLight				= mod:NewTargetAnnounce(192048, 3)
local warnPhase2					= mod:NewPhaseAnnounce(2, 2)

local specWarnShieldOfLight			= mod:NewSpecialWarningDefensive(192018, "Tank", nil, nil, 3, 2)--Journal lies, this is NOT dodgable
local specWarnSanctify				= mod:NewSpecialWarningDodge(192158, nil, nil, nil, 2, 5)
local specWarnEyeofStorm			= mod:NewSpecialWarningMoveTo(200901, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format(200901), nil, 2, 2)
local specWarnExpelLight			= mod:NewSpecialWarningMoveAway(192048, nil, nil, nil, 2, 2)
local yellExpelLight				= mod:NewYell(192048)
local specWarnSearingLight			= mod:NewSpecialWarningInterrupt(192288, "HasInterrupt", nil, nil, 1, 2)

local timerShieldOfLightCD			= mod:NewCDTimer(28, 192018, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--28-34
local timerSpecialCD				= mod:NewNextTimer(30, 200736, nil, nil, nil, 2, 200901, DBM_CORE_DEADLY_ICON)--Shared timer by eye of storm and Sanctify
--local timerExpelLightCD			= mod:NewCDTimer(24, 192048, nil, nil, nil, 3)--More review 24-30

local countdownSpecial				= mod:NewCountdown(30, 200736)
local countdownShieldOfLight		= mod:NewCountdown("Alt28", 192018, "Tank")

local voiceEyeofStorm				= mod:NewVoice(200901)--findshelter
local voiceShieldOfLight			= mod:NewVoice(192018, "Tank")--defensive
local voiceSanctify					= mod:NewVoice(192158)--watchorb
local voiceExpelLight				= mod:NewVoice(192048)--runout
local voiceSearingLight				= mod:NewVoice(192288, "HasInterrupt")--kickcast
local voicePhaseChange				= mod:NewVoice(nil, nil, DBM_CORE_AUTO_VOICE2_OPTION_TEXT)

mod:AddRangeFrameOption(8, 192048)

local eyeShortName = GetSpellInfo(91320)--Inner Eye
mod.vb.phase = 1

function mod:OnCombatStart(delay)
	self.vb.phase = 1
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 192048 then
		if args:IsPlayer() then
			specWarnExpelLight:Show()
			voiceExpelLight:Play("runout")
			yellExpelLight:Yell()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		else
			warnExpelLight:Show(args.destName)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 192048 and args:IsPlayer() and self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 192158 or spellId == 192307 then
		specWarnSanctify:Show()
		voiceSanctify:Play("watchorb")
		if spellId == 192307 then
			timerSpecialCD:Start()
			countdownSpecial:Cancel()
			countdownSpecial:Start()
		end
	elseif spellId == 192018 then
		specWarnShieldOfLight:Show()
		voiceShieldOfLight:Play("defensive")
		timerShieldOfLightCD:Start()
		countdownShieldOfLight:Start()
	elseif spellId == 200901 then
		specWarnEyeofStorm:Show(eyeShortName)
		voiceEyeofStorm:Play("findshelter")
		if self.vb.phase == 2 then
			timerSpecialCD:Start()
			countdownSpecial:Cancel()
			countdownSpecial:Start()
		end
	elseif spellId == 192288 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnSearingLight:Show(args.sourceName)
		voiceSearingLight:Play("kickcast")
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 192130 then
		self.vb.phase = 2
		warnPhase2:Show()
		voicePhaseChange:Play("ptwo")
		timerSpecialCD:Start(8.5)
		countdownSpecial:Start(8.5)
		timerShieldOfLightCD:Start(24)
		countdownShieldOfLight:Start(24)
	end
end
