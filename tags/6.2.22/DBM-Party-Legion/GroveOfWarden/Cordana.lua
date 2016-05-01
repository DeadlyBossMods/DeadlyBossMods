local mod	= DBM:NewMod(1470, "DBM-Party-Legion", 10, 707)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(95888)
mod:SetEncounterID(1818)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_REMOVED 192750",
	"SPELL_CAST_START 213576 213583 197251",
	"SPELL_AURA_APPLIED 205004",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, new voice "bring light to shadows"
--TODO, new voice "bring light to mob"
local warnDeepeningShadows			= mod:NewSpellAnnounce(213583, 4)
local warnVengeance					= mod:NewSpellAnnounce(205004, 4)

local specWarnKick					= mod:NewSpecialWarningSpell(197251, "Tank", nil, nil, 3, 2)
local specWarnDeepeningShadows		= mod:NewSpecialWarningMoveTo(213583, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format(213583), nil, 3, 6)
local specWarnHiddenStarted			= mod:NewSpecialWarningSpell(192750, nil, nil, nil, 2)
local specWarnHiddenOver			= mod:NewSpecialWarningEnd(192750)
local specWarnVengeance				= mod:NewSpecialWarningMoveTo(205004, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format(205004), nil, 3, 6)

local timerKickCD					= mod:NewCDTimer(15, 197251, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--15-42
local timerDeepeningShadowsCD		= mod:NewCDTimer(31.5, 213576, nil, nil, nil, 3)
local timerVengeanceCD				= mod:NewCDTimer(35, 205004, nil, nil, nil, 1)--35-40

local voiceKick						= mod:NewVoice(197251, "Tank")--carefly
local voiceDeepeningShadows			= mod:NewVoice(213576)--"213576"--New Voice
local voiceVengeance				= mod:NewVoice(205004)--"205004"--New Voice

function mod:OnCombatStart(delay)
	timerKickCD:Start(8.3-delay)
	timerDeepeningShadowsCD:Start(10.9-delay)
end

--Probably not reliable anymore but will review when I pull boss again
function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 205004 then
		if ExtraActionBarFrame:IsShown() then--Has light
			specWarnVengeance:Show(args.spellName)
			voiceVengeance:Play(205004)
		else
			warnVengeance:Show()
		end
		timerVengeanceCD:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 192750 then
		specWarnHiddenOver:Show()
		timerVengeanceCD:Start(14)
		timerDeepeningShadowsCD:Start(14.5)
		timerKickCD:Start(15.5)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 213576 or spellId == 213583 then
		if ExtraActionBarFrame:IsShown() then--Has light
			specWarnDeepeningShadows:Show(args.spellName)
			voiceDeepeningShadows:Play("213576")
		else
			warnDeepeningShadows:Show()
		end
		timerDeepeningShadowsCD:Start()
	elseif spellId == 197251 then
		specWarnKick:Show()
		voiceKick:Play("carefly")
		timerKickCD:Start()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local _, _, _, _, spellId = strsplit("-", spellGUID)
	if spellId == 203416 then--Shadowstep. Faster than 192750 applied
		timerDeepeningShadowsCD:Stop()
		timerKickCD:Stop()
		specWarnHiddenStarted:Show()
	end
end
