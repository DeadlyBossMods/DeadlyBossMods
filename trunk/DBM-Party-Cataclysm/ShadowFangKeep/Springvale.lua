local mod	= DBM:NewMod("Springvale", "DBM-Party-Cataclysm", 6)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(4278)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_SUCCES"
)

local warnDesecration		= mod:NewSpellAnnounce(93687, 3)
local warnMaleficStrike		= mod:NewSpellAnnounce(93685, 2)
local warnShield		= mod:NewSpellAnnounce(93693, 4)

local timerMaleficStrike	= mod:NewNextTimer(6, 93685)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(93693) then
		warnShield:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(93685) then
		warnMaleficStrike:Show()
		timerMaleficStrike:Start()
	elseif args:IsSpellID(93687) then
		warnDesecration:Show()
	end
end