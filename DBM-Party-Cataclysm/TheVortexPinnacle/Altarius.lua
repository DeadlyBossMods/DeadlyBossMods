local mod	= DBM:NewMod("Altarius", "DBM-Party-Cataclysm", 8)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(43873)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START"
)

local warnBreath	= mod:NewSpellAnnounce(88308, 3)

local timerBreath	= mod:NewCastTimer(2, 88308)
local timerBreathCD	= mod:NewCDTimer(12, 88308)

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(88308) then
		warnBreath:Start()
		timerBreath:Start()
		timerBreathCD:Start()
	end
end