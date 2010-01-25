local mod	= DBM:NewMod("Zuramat", "DBM-Party-WotLK", 12)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(29314)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED"
)

local warningVoidShift			= mod:NewTargetAnnounce(59743, 2)
local warningVoidShifted		= mod:NewTargetAnnounce(54343, 3)
local warningShroudOfDarkness	= mod:NewSpellAnnounce(59745, 4)

local specWarnVoidShifted		= mod:NewSpecialWarning("SpecialWarningVoidShifted")
local specShroudOfDarkness		= mod:NewSpecialWarning("SpecialShroudofDarkness")

local timerVoidShift			= mod:NewTargetTimer(5, 59743)
local timerVoidShifted			= mod:NewTargetTimer(15, 54343)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(59743, 54361) then			-- Void Shift            59743 (HC)  54361 (nonHC)
		warningVoidShift:Show(args.destName)
		timerVoidShift:Start(args.destName)
	elseif args:IsSpellID(54343) then
		if args:IsPlayer() then
			specWarnVoidShifted:Show()
		end
		timerVoidShifted:Start(args.destName)
	elseif args:IsSpellID(59745, 54524) then		-- Shroud of Darkness    59745 (HC)   54524 (nonHC)
		warningShroudOfDarkness:Show()
		specShroudOfDarkness:Show()
	end
end
