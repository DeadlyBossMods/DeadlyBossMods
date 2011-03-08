local mod	= DBM:NewMod("Ozumat", "DBM-Party-Cataclysm", 9)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(40807)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_SUCCESS"
)

local warnPhase2		= mod:NewPhaseAnnounce(2)
local warnPhase3		= mod:NewPhaseAnnounce(3)
local warnBlightSpray	= mod:NewSpellAnnounce(83985, 2)

local timerBlightSpray	= mod:NewBuffActiveTimer(4, 83985)

local warnedPhase2
local warnedPhase3

function mod:OnCombatStart(delay)
	warnedPhase2 = false
	warnedPhase3 = false
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(83463) and not warnedPhase2 then
		warnPhase2:Show(2)
		warnedPhase2 = true
	elseif args:IsSpellID(76133) and not warnedPhase3 then
		warnPhase3:Show(3)
		warnedPhase3 = true
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(83985, 83986, 91511) then
		warnBlightSpray:Show()
		timerBlightSpray:Start()
	end
end