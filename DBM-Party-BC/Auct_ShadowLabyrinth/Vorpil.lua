local mod = DBM:NewMod("Vorpil", "DBM-Party-BC", 10)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1 $"):sub(12, -3))

mod:SetCreatureID(18732)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS"
)

local warnTeleport         = mod:NewSpellAnnounce(33563)
local timerTeleport        = mod:NewNextTimer(37, 33563)

function mod:OnCombatStart(delay)
    timerTeleport:Start(40-delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 33563 then
		warnTeleport:Show()
		timerTeleport:Start()
	end
end