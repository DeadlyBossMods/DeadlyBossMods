local mod = DBM:NewMod("Zuramat", "DBM-Party-WotLK", 12)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(29314)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED"
)

local warningVoidShift			= mod:NewAnnounce("WarningVoidShift", 2, 59743)
local warningVoidShifted		= mod:NewAnnounce("WarningVoidShifted", 3, 59743)
local warningShroudOfDarkness	= mod:NewAnnounce("WarningShroudOfDarkness", 4, 59745)

local specWarnVoidShifted		= mod:NewSpecialWarning("SpecialWarningVoidShifted")
local specShroudOfDarkness		= mod:NewSpecialWarning("SpecialShroudofDarkness")

local timerVoidShift			= mod:NewTimer(5, "TimerVoidShift", 59743)
local timerVoidShifted			= mod:NewTimer(15, "TimerVoidShifted", 54343)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 59743 or args.spellId == 54361 then			-- Void Shift            59743 (HC)  54361 (nonHC)
		warningVoidShift:Show(args.spellName, args.destName)
		timerVoidShift:Start(args.spellName, args.destName)
	elseif args.spellId == 54343 then
		if args.destName == UnitName("player") then
			specWarnVoidShifted:Show()
		end
		timerVoidShifted:Start(args.spellName, args.destName)
	elseif args.spellId == 59745 or args.spellId == 54524 then		-- Shroud of Darkness    59745 (HC)   54524 (nonHC)
		warningShroudOfDarkness:Show(args.spellName)
		specShroudOfDarkness:Show()
	end
end
