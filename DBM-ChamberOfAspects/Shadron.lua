local mod = DBM:NewMod("Shadron", "DBM-ChamberOfAspects")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(30451)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
    "SPELL_CAST_SUCCESS"
)

local warnShadowFissure	= mod:NewSpellAnnounce(59127)
local timerShadowFissure = mod:NewCastTimer(5, 59128)--Cast timer until Void Blast. it's what happens when shadow fissure explodes.
local isInCombatWithShadron = false

function mod:OnCombatStart(delay)
    isInCombatWithShadron = true
end

function mod:OnCombatEnd()
    isInCombatWithShadron = false
end

function mod:SPELL_CAST_SUCCESS(args)
    if (isInCombatWithShadron) then
        if (args.spellId == 57579 or args.spellId == 59127) then
            warnShadowFissure:Show()
            timerShadowFissure:Start()
        end
    end
end