local mod	= DBM:NewMod("Asaad", "DBM-Party-Cataclysm", 8)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(45878)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START"
)

local warnStaticCling		= mod:NewSpellAnnounce(87618, 3)
local warnGroundingField	= mod:NewSpellAnnounce(86911, 4)

local timerGroundingField	= mod:NewCastTimer(10, 86911)
local timerGroundingFieldCD	= mod:NewCDTimer(45, 86911)

local specWarnStaticCling	= mod:NewSpecialWarning("SpecWarnStaticCling", false)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(86911) then
		warnGroundingField:Show()
		timerGroundingField:Start()
		timerGroundingFieldCD:Start()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(87618) then
		warnStaticCling:Show()
		specWarnStaticCling:Show()
	end
end
