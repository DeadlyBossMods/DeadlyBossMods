local mod	= DBM:NewMod("Glubtok", "DBM-Party-Cataclysm", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(47162)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_SUCCESS"
)

local warnFistsFlame		= mod:NewSpellAnnounce(87859, 3)
local warnFistsFrost		= mod:NewSpellAnnounce(87861, 3)
local warnArcanePower		= mod:NewSpellAnnounce(88009, 3)
local warnSpiritStrike		= mod:NewSpellAnnounce(59304, 3)

local timerFistsFlame		= mod:NewBuffActiveTimer(10, 87859)
local timerFistsFrost		= mod:NewBuffActiveTimer(10, 87861)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(87859) and args.destName == args.srcName then
		warnFistsFlame:Show()
		timerFistsFlame:Start()
	elseif args:IsSpellID(87861) and args.destName == args.srcName then
		warnFistsFrost:Show()
		timerFistsFrost:Start()
	elseif args:IsSpellID(88009) then
		warnArcanePower:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(59304) and mod:IsInCombat() then
		warnSpiritStrike:Show()
	end
end