local mod	= DBM:NewMod("JedogaShadowseeker", "DBM-Party-WotLK", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(29310)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"SPELL_CAST_START"
)

local warningThundershock	= mod:NewSpellAnnounce(56926, 3)
local warningCycloneStrike	= mod:NewSpellAnnounce(56855, 3)

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(56926, 60029) then
		warningThundershock:Show()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(56855, 60030) then
		warningCycloneStrike:Show()
	end
end