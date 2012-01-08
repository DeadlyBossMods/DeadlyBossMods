local mod	= DBM:NewMod("Shot", "DBM-WorldEvents", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local timerGame		= mod:NewBuffActiveTimer(60, 101871)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(101871) and args:IsPlayer() then
		timerGame:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(101871) and args:IsPlayer() then
		timerGame:Cancel()
	end
end
