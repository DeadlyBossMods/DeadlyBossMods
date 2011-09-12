local mod	= DBM:NewMod("Slabhide", "DBM-Party-Cataclysm", 7)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(43214)
mod:SetModelID(36476)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE",
	"SPELL_MISSED"
)

local warnCrystalStorm		= mod:NewSpellAnnounce(92265, 4)

local specWarnEruption 		= mod:NewSpecialWarningMove(92658)
local specWarnCrystalStorm 	= mod:NewSpecialWarning("specWarnCrystalStorm")
local warnGroundphase		= mod:NewAnnounce("WarnGroundphase", 2, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local warnAirphase			= mod:NewAnnounce("WarnAirphase", 2, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")

local timerCrystalStorm		= mod:NewBuffActiveTimer(8.5, 92265)
local timerAirphase			= mod:NewTimer(50, "TimerAirphase", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local timerGroundphase		= mod:NewTimer(10, "TimerGroundphase", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")

local spamEruption = 0

function mod:groundphase()
	warnGroundphase:Show()
	timerAirphase:Start()
	self:ScheduleMethod(50, "airphase")
end

function mod:airphase()
	warnAirphase:Show()
	timerGroundphase:Start()
	self:ScheduleMethod(10, "groundphase")
end

function mod:OnCombatStart(delay)
	spamEruption = 0
	timerAirphase:Start(12.5-delay)
	self:ScheduleMethod(12.5-delay, "airphase")
end

function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(80800, 80801, 92657, 92658) and args:IsPlayer() and GetTime() - spamEruption > 3 then
		specWarnEruption:Show()
		spamEruption = GetTime()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE--Because we still want people to move out of stuff before they eat up an entire PWS in it.

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