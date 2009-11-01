local mod = DBM:NewMod("Hadronox", "DBM-Party-WotLK", 2)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(28921)
mod:SetZone()

mod:RegisterCombat("combat")

local warningCloud	= mod:NewSpellAnnounce(53400, 3)
local warningLeech	= mod:NewSpellAnnounce(53030, 1)

mod:RegisterEvents(
	"SPELL_CAST_START"
)

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(53030, 59417) then
		warningLeech:Show()
	elseif args:IsSpellID(53400, 59419) then
		warningCloud:Show()
	end
end