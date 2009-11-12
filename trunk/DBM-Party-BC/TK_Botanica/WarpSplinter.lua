local mod = DBM:NewMod("WarpSplinter", "DBM-Party-BC", 14)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1 $"):sub(12, -3))

mod:SetCreatureID(17977)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON"
)

local warnTreants    = mod:NewSpellAnnounce(34727)
local timerTreants   = mod:NewNextTimer(45, 34727)
local warnStomp      = mod:NewSpellAnnounce(34716)
local timerStomp     = mod:NewBuffActiveTimer(5, 34716)

function mod:OnCombatStart(delay)
    timerTreants:Start(15-delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(34716) then
		warnStomp:Show()
		timerStomp:Start()
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(34727) then
		warnTreants:Show()
		timerTreants:Start()
	end
end