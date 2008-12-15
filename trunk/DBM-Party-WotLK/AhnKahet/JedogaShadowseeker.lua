local mod = DBM:NewMod("JedogaShadowseeker", "DBM-Party-WotLK", 1)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(29310)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"SPELL_CAST_START"
)

local warningThundershock	= mod:NewAnnounce("WarningThundershock", 3, 56926)
local warningCycloneStrike	= mod:NewAnnounce("WarningCycloneStrike", 3, 56885)

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 56926 or args.spellId == 60029 then
		warningThundershock:Show(args.spellName)
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 56885 or args.spellId == 60030 then
		warningCycloneStrike:Show(args.spellName)
	end
end