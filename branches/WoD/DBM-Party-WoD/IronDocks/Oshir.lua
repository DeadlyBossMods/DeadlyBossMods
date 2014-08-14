local mod	= DBM:NewMod(1237, "DBM-Party-WoD", 4, 558)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(86232)
mod:SetEncounterID(1750)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 163054"
)

local warnRoar				= mod:NewSpellAnnounce(163054, 3)

local specWarnRoar			= mod:NewSpecialWarningSpell(163054, nil, nil, nil, true)

--local timerRoarCD			= mod:NewCDTimer(12, 163054)

function mod:OnCombatStart(delay)

end

--[[
function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 119476 then

	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 119476 then

	end
end--]]

function mod:SPELL_CAST_START(args)
	if args.spellId == 163054 then--he do not target anything. so can't use target scan.
		warnRoar:Show()
		specWarnRoar:Show()
	end
end
