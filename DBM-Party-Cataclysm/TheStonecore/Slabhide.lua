local mod	= DBM:NewMod(111, "DBM-Party-Cataclysm", 7, 67)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(43214)
mod:SetModelID(36476)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnGroundphase		= mod:NewAnnounce("WarnGroundphase", 2, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local warnAirphase			= mod:NewAnnounce("WarnAirphase", 2, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local warnFissure			= mod:NewSpellAnnounce(80803, 3)
local warnCrystalStorm		= mod:NewSpellAnnounce(92265, 4)

local specWarnEruption 		= mod:NewSpecialWarningMove(80801)
local specWarnCrystalStorm 	= mod:NewSpecialWarning("specWarnCrystalStorm")

local timerFissureCD		= mod:NewCDTimer(6.2, 80803)
local timerCrystalStorm		= mod:NewBuffActiveTimer(8.5, 92265)
local timerAirphase			= mod:NewTimer(50, "TimerAirphase", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local timerGroundphase		= mod:NewTimer(10, "TimerGroundphase", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")

function mod:groundphase()
	warnGroundphase:Show()
--	timerFissureCD:Start()
	timerAirphase:Start()
	self:ScheduleMethod(50, "airphase")
end

function mod:airphase()
	timerFissureCD:Cancel()
	warnAirphase:Show()
	timerGroundphase:Start()
	self:ScheduleMethod(10, "groundphase")
end

function mod:OnCombatStart(delay)
	spamEruption = 0
--	timerFissureCD:Start(-delay)
	timerAirphase:Start(12.5-delay)
	self:ScheduleMethod(12.5-delay, "airphase")
end

function mod:SPELL_DAMAGE(sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId)
	if (spellId == 80800 or spellId == 80801 or spellId == 92657 or spellId == 92658) and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnEruption:Show()
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

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, spellName)
	if spellName == GetSpellInfo(80803) and self:AntiSpam() then--Lava Fissure
		warnFissure:Show()
		timerFissureCD:Start()
	end
end
