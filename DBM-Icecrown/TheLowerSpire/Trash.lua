local mod	= DBM:NewMod("LowerSpireTrash", "DBM-Icecrown", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1799 $"):sub(12, -3))

mod:RegisterEvents(
	"SPELL_CAST_START"
)

local warnDisruptingShout		= mod:NewSpellAnnounce(71022, 2)
local specWarnDisruptingShout	= mod:NewSpecialWarning("SpecWarnDisruptingShout")
local timerDisruptingShout		= mod:NewCastTimer(3, 71022)

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(71022) then
		warnDisruptingShout:Show()
		specWarnDisruptingShout:Show()
		timerDisruptingShout:Start()
	end
end



