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

local timerFearCD	= mod:NewTimer(15, "TimerFearCD", 22686)  -- cooldown ??
local timerSlash	= mod:NewTimer(10, "TimerSlash", 48873)
local timerSlashCD	= mod:NewTimer(18, "TimerSlashCD", 48873)

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 22686 and args.sourceGUID == 27483 then
		warningFear:Show(args.spellName)
		timerFear:Start(args.spellName)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 48920 then
		warningBite:Show(args.spellName, args.destName)
	elseif args.spellId == 48873 then
		warningSlash:Show(args.spellName)
		timerSlash:Start(15, args.spellName, args.destName)
		timerSlashCD:Start(args.spellName)
	elseif args.spellId == 48878 then
		warningSlash:Show(args.spellName)
		timerSlash:Start(10, args.spellName, args.destName)
		timerSlashCD:Start(args.spellName)
	end
end