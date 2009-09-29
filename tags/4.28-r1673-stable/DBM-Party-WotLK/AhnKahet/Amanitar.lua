local mod = DBM:NewMod("Amanitar", "DBM-Party-WotLK", 1)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 248 $"):sub(12, -3))
mod:SetCreatureID(30258)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START"
)

local warningMini	= mod:NewAnnounce("WarningMini", 3, 57055)
local timerMiniCD	= mod:NewTimer(30, "TimerMiniCD", 57055)

function mod:SPELL_CAST_START(args)
	if args.spellId == 57055 then
		warningMini:Show(args.spellName)
		timerMiniCD:Start(args.spellName)
	end
end