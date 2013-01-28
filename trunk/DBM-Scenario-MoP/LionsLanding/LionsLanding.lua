local mod	= DBM:NewMod("LionsLanding", "DBM-Scenario-MoP")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7871 $"):sub(12, -3))
mod:SetZone()

mod:RegisterCombat("scenario", 911)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START"
)

local warnDivineStorm		= mod:NewSpellAnnounce(135404, 4, nil, mod:IsMelee())
local warnDivineLight		= mod:NewSpellAnnounce(135403, 4)

local specWarnDivineLight	= mod:NewSpecWarnInterrupt(135403)

mod:RemoveOption("HealthFrame")

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(135403) then
		warnDivineLight:Show()
		specWarnDivineLight:Show()
	elseif args:IsSpellID(135404) then
		warnDivineStorm:Show()
	end
end
