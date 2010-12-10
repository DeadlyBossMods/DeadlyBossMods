local mod	= DBM:NewMod("Slabhide", "DBM-Party-Cataclysm", 7)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(43214)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS"
)

local warnCrystalStorm		= mod:NewSpellAnnounce(92265, 4)

local timerCrystalStorm		= mod:NewDurationTimer(8.5, 92265)

function mod:OnCombatStart(delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(92265) then
		warnCrystalStorm:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(92265) then
		timerCrystalStorm:Start()
	end
end