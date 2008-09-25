local mod = DBM:NewMod("MaidenOfGrief", "DBM-Party-WotLK", 7)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 106 $"):sub(12, -3))
mod:SetCreatureID(27975)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED"
)

local warningWoe	= mod:NewAnnounce("WarningWoe", 3, 50761)
local warningSorrow	= mod:NewAnnounce("WarningSorrow", 3, 50760)
local warningStorm	= mod:NewAnnounce("WarningStorm", 3, 50752)

local timerWoe		= mod:NewTimer(10, "TimerWoe", 50761)
local timerSorrow	= mod:NewTimer(10, "TimerSorrow", 50760)

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 50760 then
		timerSorrow:Start()
		warningSorrow:Show()
	elseif args.spellId == 50752 then
		warningStorm:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 50761 then
		warningWoe:Show(args.destName)
		timerWoe:Start(args.destName)
		mod:SetIcon(args.destName, 8, 10)
	end
end