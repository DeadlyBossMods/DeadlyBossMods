local mod	= DBM:NewMod("Garr", "DBM-Party-Cataclysm", 12)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(50056)
mod:SetModelID(37307)
mod:SetZone(606, 683)--Hyjal (both versions of it)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START"
)

local warnMassiveEruption		= mod:NewCastAnnounce(93508, 4)--An attack that one shots anyone not in a twilight zone.

local specWarnMassiveEruption	= mod:NewSpecialWarningSpell(93508, mod:IsMelee())

local timerMassiveEruptionCD	= mod:NewNextTimer(30, 93508)

local soundMassiveEruption		= mod:NewSound(93508, nil, mod:IsMelee())

function mod:OnCombatStart(delay)
	timerMassiveEruptionCD:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(93508) then--Possibly use 93507 (Magma Shackles) instead if it's always cast before eruption, for an earlier warning?
		warnMassiveEruption:Show()
		specWarnMassiveEruption:Show()
		soundMassiveEruption:Play()
		timerMassiveEruptionCD:Start()
	end
end
