local mod	= DBM:NewMod("Gaur", "DBM-GarrisonInvasions")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(90943)
mod:SetZone()

mod:RegisterCombat("combat")
mod:SetMinCombatTime(15)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 180830 180868 180879",
	"SPELL_CAST_SUCCESS 180879"
)

local warnGoren					= mod:NewSpellAnnounce(180879, 2)

local specWarnEarthenSlam		= mod:NewSpecialWarningSpell(180868, nil, nil, nil, 2, 2)
local specWarnRunicSpike		= mod:NewSpecialWarningSpell(180830, "Melee", nil, nil, 2, 2)

local voiceEarthenSlam			= mod:NewVoice(180868) --carefly
local voiceRunicSpike			= mod:NewVoice(180830, "Melee") --watchstep

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 180830 then
		specWarnRunicSpike:Show()
		voiceRunicSpike:Play("watchstep")
	elseif spellId == 180868 then
		specWarnEarthenSlam:Show()
		voiceRunicSpike:Play("carefly")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 180879 then
		warnGoren:Show()
	end
end
