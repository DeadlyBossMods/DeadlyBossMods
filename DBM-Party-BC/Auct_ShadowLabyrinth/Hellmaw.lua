local mod = DBM:NewMod("Hellmaw", "DBM-Party-BC", 10)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1 $"):sub(12, -3))

mod:SetCreatureID(18731)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS"
)

local warnFear      = mod:NewSpellAnnounce(33547)
local timerFear     = mod:NewNextTimer(25, 33547)

local enrageTimer	= mod:NewEnrageTimer(180)

function mod:OnCombatStart(delay)
	if mod:IsDifficulty("heroic5") then
        enrageTimer:Start(-delay)
    end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 33547 then
		warnFear:Show()
		timerFear:Start()
	end
end