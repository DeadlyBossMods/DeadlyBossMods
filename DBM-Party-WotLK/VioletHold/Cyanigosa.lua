local mod = DBM:NewMod("Cyanigosa", "DBM-Party-WotLK", 12)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(31134)
mod:SetZone()

mod:RegisterCombat("combat")

local warningVacuum	= mod:NewAnnounce("WarningVacuum", 3, 58694)
local warningBlizzard	= mod:NewAnnounce("WarningBlizzard", 2, 58693)
local warningMana	= mod:NewAnnounce("WarningMana", 3, 59374)
local timerVacuum	= mod:NewTimer(30, "TimerVacuum", 58694)

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS"
)

function mod:OnCombatStart(delay)
	timerVacuum:Start()
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 58694 then
		warningVacuum:Show()
		timerVacuum:Stop()
		timerVacuum:Start()
	elseif args.spellId == 58693 or args.spellId == 59369 then
		warningBlizzard:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 59374 then
		warningMana:Show(tostring(args.destName))
	end
end