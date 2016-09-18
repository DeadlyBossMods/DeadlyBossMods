local mod	= DBM:NewMod(1796, "DBM-BrokenIsles", nil, 822)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(112350)
--mod:SetEncounterID(1880)
mod:SetReCombatTime(20)
mod:SetZone()
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 223689",
	"SPELL_AURA_APPLIED 223623 223614"
)

--TODO, Adjust warning types as needed based on needs.
--TODO, shield health frame for resonance probably. Some warnings and countdowns too for explotion at end.
local warnNightstableEnergy			= mod:NewSpellAnnounce(223689, 2)
local warnResonance					= mod:NewSpellAnnounce(223614, 3)

local specWarnNightshiftBolts		= mod:NewSpecialWarningDodge(223623, nil, nil, nil, 2, 2)

local timerNightstableEnergyCD		= mod:NewAITimer(16, 223689, nil, nil, nil, 1)
local timerNightshiftBoltsCD		= mod:NewAITimer(16, 223623, nil, nil, nil, 3)
local timerResonanceCD				= mod:NewAITimer(16, 223614, nil, nil, nil, 6)

local voiceNightshiftBolts			= mod:NewVoice(223623)--watchstep

--mod:AddReadyCheckOption(37460, false)

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then

	end
end

function mod:OnCombatEnd()
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 223689 then
		warnNightstableEnergy:Show()
		timerNightstableEnergyCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 223623 then
		specWarnNightshiftBolts:Show()
		voiceNightshiftBolts:Play("watchstep")
		timerNightshiftBoltsCD:Start()
	elseif spellId == 223614 then
		warnResonance:Show(args.destName)
		timerResonanceCD:Start()
	end
end
