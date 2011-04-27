local mod	= DBM:NewMod("EarthragerPtah", "DBM-Party-Cataclysm", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(39428, 99999)--Combat log shows him as dying when he borrows, wtf?
mod:SetZone()

mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.Kill)

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS"
)

local warnFlameBolt	= mod:NewSpellAnnounce(77370, 2)

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(77370) then
		warnFlameBolt:Show()
	end
end