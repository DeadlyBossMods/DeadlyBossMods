local mod	= DBM:NewMod("Cannon", "DBM-WorldEvents", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetZone()

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"UNIT_AURA"
)

local timerMagicWings				= mod:NewBuffFadesTimer(8.5, 102116)

local MagicWingsCountdown			= mod:NewCountdownFades(7.5, 102116)

local markWings = false

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

local function wingsRemoved()
	markWings = false
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 102120 and args:IsPlayer() then
		MagicWingsCountdown:Cancel()
		timerMagicWings:Cancel()
	end
end

function mod:UNIT_AURA(uId)
	if uId ~= "player" then return end
	if UnitBuff("player", GetSpellInfo(102116)) and not markWings then
		MagicWingsCountdown:Start(7.5)--Might need to reduce it by 1 or use UnitDebuff duration arg.
		timerMagicWings:Start()
		markWings = true
		self:Schedule(8.5, wingsRemoved)
	end
end