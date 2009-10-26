local mod = DBM:NewMod("Tenebron", "DBM-ChamberOfAspects")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(30452)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
    "SPELL_CAST_SUCCESS"
)

local warnShadowFissure	= mod:NewSpellAnnounce(59127)
local timerShadowFissure = mod:NewCastTimer(5, 59128)
local isInCombatWithTenebron = false

function mod:OnCombatStart(delay)
    isInCombatWithTenebron = true
end

function mod:OnCombatEnd()
    isInCombatWithTenebron = false
end

function mod:SPELL_CAST_SUCCESS(args)
    if (isInCombatWithTenebron) then
        if (args.spellId == 57579 or args.spellId == 59127) then
            warnShadowFissure:Show()
            timerShadowFissure:Start
        end
    end
end