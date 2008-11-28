local mod = DBM:NewMod("KingDred", "DBM-Party-WotLK", 4)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(27483)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED"
)

local warningSlash	= mod:NewAnnounce("WarningSlash", 3, 48873)
local warningBite	= mod:NewAnnounce("WarningBite", 2, 48920)
local warningFear	= mod:NewAnnounce("WarningFear", 1, 22686)

local timerFear		= mod:NewTimer(20, "TimerFear", 22686)  -- cooldown ??
local timerSlash	= mod:NewTimer(10, "TimerSlash", 48873)

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 22686 then
		warningFear:Show()
		timerFear:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 48920 then	-- Grievous Bite
		warningBite:Show(tostring(args.destName))
	elseif args.spellId == 48873 then	-- Manglisg Slash
		warningSlash:Show("Mangling")
		timerSlash:Start(10, "Mangling", tostring(args.destName))
	elseif args.spellId == 48878 then
		warningSlash:Show("Piercing")
		timerSlash:Start(15, "Piercing", tostring(args.destName))
	end
end