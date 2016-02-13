local mod	= DBM:NewMod(1486, "DBM-Party-Legion", 4, 721)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(95833)
mod:SetEncounterID(1806)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 200901 192048 192133 192132",
	"SPELL_AURA_REMOVED 192048 192133 192132",
	"SPELL_CAST_START 192158 192018",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--Notes: Saw no timer consistency since they are all over the place based on where boss is dragged.
--TODO: maybe figure out how dragging boss around affects timers. Might be worth the work for a 5 man boss though.
local warnExpelLight				= mod:NewTargetAnnounce(192048, 3)
local warnPhase2					= mod:NewPhaseAnnounce(2, 2)

local specWarnShieldOfLight			= mod:NewSpecialWarningDodge(192018, "Tank", nil, nil, 2)--Can't think of good voice to dodge a frontal cone, shockwave?
local specWarnSanctify				= mod:NewSpecialWarningDodge(192158, nil, nil, nil, 2, 5)
local specWarnEyeofStorm			= mod:NewSpecialWarningMoveTo(200901, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format(200901), nil, 2)
local specWarnExpelLight			= mod:NewSpecialWarningMoveAway(192048, nil, nil, nil, 2, 2)
local yellExpelLight				= mod:NewYell(192048)

--local timerSanctifyCD				= mod:NewCDTimer(20, 192158, nil, nil, nil, 2)
--local timerEyeofStormCD			= mod:NewCDTimer(20, 200901, nil, nil, nil, 2)

--local voiceEyeofStorm				= mod:NewVoice(200901)--"move center" generic or "move into eye"
local voiceSanctify					= mod:NewVoice(192158)--watchorb
local voiceExpelLight				= mod:NewVoice(192048)--runout
local voicePhaseChange				= mod:NewVoice(nil, nil, DBM_CORE_AUTO_VOICE2_OPTION_TEXT)

mod:AddRangeFrameOption(8, 153396)

local eyeShortName = GetSpellInfo(91320)--Inner Eye

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 200901 then
		specWarnEyeofStorm:Show(eyeShortName)
--		voiceEyeofStorm:Play("movecenter")
	elseif spellId == 192048 then
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
	elseif spellId == 192133 then--Mysthic Empowerment: Holy

	elseif spellId == 192132 then--Mysthic Empowerment: Thunder
		
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 192048 and args:IsPlayer() and self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	elseif spellId == 192133 then--Mysthic Empowerment: Holy

	elseif spellId == 192132 then--Mysthic Empowerment: Thunder
		
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 192158 then
		specWarnSanctify:Show()
		voiceSanctify:Play("watchorb")
	elseif spellId == 192018 then
		specWarnShieldOfLight:Show()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 192130 then
		warnPhase2:Show()
		voicePhaseChange:Play("ptwo")
	end
end
