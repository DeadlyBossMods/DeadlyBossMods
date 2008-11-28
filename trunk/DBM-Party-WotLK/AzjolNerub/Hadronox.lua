local mod = DBM:NewMod("Hadronox", "DBM-Party-WotLK", 2)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(28921)
mod:SetZone()

mod:RegisterCombat("combat")

local warningCloud	= mod:NewAnnounce("WarningCloud", 3, 53400)
local warningLeech	= mod:NewAnnounce("WarningLeech", 1, 53030)

mod:RegisterEvents(
	"SPELL_CAST_START"
)

function mod:SPELL_CAST_START(args)
	if args.spellId == 53030 
	or args.spellId == 59417 then
		warningLeech:Show()
	elseif args.spellId == 53400 
	or args.spellId == 59419 then
		warningCloud:Show()
	end
end