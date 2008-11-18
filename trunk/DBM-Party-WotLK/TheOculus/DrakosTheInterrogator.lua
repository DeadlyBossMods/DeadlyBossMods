local mod = DBM:NewMod("DrakosTheInterrogator", "DBM-Party-WotLK", 9)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(27654)
mod:SetZone()

mod:RegisterCombat("combat")

local warningPull	= mod:NewAnnounce("WarningPull", 3, 51336)

mod:RegisterEvents(
	"SPELL_CAST_START"
)

function mod:SPELL_CAST_START(args)
	if args.spellId == 51336 then
		warningPull:Show()
	end
end