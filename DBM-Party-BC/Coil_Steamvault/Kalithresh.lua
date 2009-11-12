local mod	= DBM:NewMod("Kalithresh", "DBM-Party-BC", 6)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1 $"):sub(12, -3))
mod:SetCreatureID(17798)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED"
)

local WarnChannel   = mod:NewAnnounce("WarnChannel")
local WarnReflect   = mod:NewSpellAnnounce(31534)
local timerReflect  = mod:NewBuffActiveTimer(8, 31534)

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(31543) then
		WarnChannel:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(31534) then
		WarnReflect:Show(args.destName)
		timerReflect:Start(args.destName)
	end
end