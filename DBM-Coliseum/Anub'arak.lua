local mod = DBM:NewMod("Anub'arak_Coliseum", "DBM-Coliseum")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1236 $"):sub(12, -3))
mod:SetCreatureID(34660)  

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED"
)

local warnPursue	= mod:NewAnnounce("WarnPursue", 3)
local warnBurrow	= mod:NewAnnounce("WarnBurrow", 2)

local timerPursue	= mod:NewTargetTimer(30, 67574)
local timerBurrowCD	= mod:NewCDTimer(90, 67322)

local specWarnPursue	= mod:NewSpecialWarning("SpecWarnPursue")

function mod:OnCombatStart(delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 67574 then		-- Pursue
		if args.destName == UnitName("player") then
			specWarnPursue:Show()
		end
		warnPursue:Show(args.destName)
		timerPursue:Start()
	end
end