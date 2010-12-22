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

local specWarnEruption 		= mod:NewSpecialWarningMove(92657)
local specWarnCrystalStorm 	= mod:NewSpecialWarning("specWarnCrystalStorm")

local timerCrystalStorm		= mod:NewBuffActiveTimer(8.5, 92265)

local spamEruption = 0
function mod:OnCombatStart(delay)
	spamEruption = 0
end
 
function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(80800, 92657) and args:IsPlayer() and GetTime() - spamEruption > 5 then
		specWarnEruption:Show()
		spamEruption = GetTime()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(92265) then
		warnCrystalStorm:Show()
		specWarnCrystalStorm:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(92265) then
		timerCrystalStorm:Start()
	end
end