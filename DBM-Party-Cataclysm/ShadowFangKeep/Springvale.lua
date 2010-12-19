local mod	= DBM:NewMod("Springvale", "DBM-Party-Cataclysm", 6)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(4278)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_SUCCES",
	"SPELL_DAMAGE"
)

local warnDesecration		= mod:NewSpellAnnounce(93687, 3)
local warnMaleficStrike		= mod:NewSpellAnnounce(93685, 2)
local warnShield			= mod:NewSpellAnnounce(93736, 4)
local warnWordShame			= mod:NewTargetAnnounce(93852, 3)

local specWarnDesecration	= mod:NewSpecialWarningMove(94370)

local timerMaleficStrike	= mod:NewNextTimer(6, 93685)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(93736) then
		warnShield:Show()
	elseif args:IsSpellID(93852) then
		warnWordShame:Show(args.destName)
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

do 
	local lastdesecration = 0
	function mod:SPELL_DAMAGE(args)
		if args:IsSpellID(94370) and args:IsPlayer() and GetTime() - lastdesecration > 4 then		-- Desecration
			specWarnDesecration:Show()
			lastdesecration = GetTime()
		end
	end
end