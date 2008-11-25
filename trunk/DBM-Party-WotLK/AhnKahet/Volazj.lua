local mod = DBM:NewMod("Volazj", "DBM-Party-WotLK", 1)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(29311)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED"
)

local warningInsanity	= mod:NewAnnounce("WarningInsanity", 3, 57496)
local warningShiver	= mod:NewAnnounce("WarningShiver", 3, 57949)

function mod:SPELL_CAST_START(args)
	if args.spellId == 57496 then
		warningInsanity:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 57949 or args.spellId == 59978 then
		warningShiver:Show(tostring(args.destName))
	end
end