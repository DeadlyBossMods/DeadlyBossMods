local mod = DBM:NewMod("Cyanigosa", "DBM-Party-WotLK", 12)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(31134)
mod:SetZone()

mod:RegisterCombat("combat")

local warningVacuum	= mod:NewAnnounce("WarningVacuum", 1, 58694)
local warningBlizzard	= mod:NewAnnounce("WarningBlizzard", 3, 58693)
local warningMana	= mod:NewAnnounce("WarningMana", 2, 59374)
local timerVacuumCD	= mod:NewTimer(35, "TimerVacuumCD", 58694)
local timerMana		= mod:NewTimer(8, "TimerMana", 59374)

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

function mod:OnCombatStart(delay)
	timerVacuumCD:Start(30 - delay, GetSpellInfo(58694))
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 58694 then
		warningVacuum:Show(args.spellName)
		timerVacuumCD:Cancel()
		timerVacuumCD:Start(args.spellName)
	elseif args.spellId == 58693 or args.spellId == 59369 then
		warningBlizzard:Show(args.spellName)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 59374 then
		warningMana:Show(args.spellName, args.destName)
		timerMana:Start(args.spellName, args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 59374 then
		timerMana:Cancel()
	end
end