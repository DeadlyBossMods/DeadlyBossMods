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

local warningSlash	= mod:NewSpellAnnounce(48873, 3)
local warningBite	= mod:NewTargetAnnounce(48920, 2)
local warningFear	= mod:NewSpellAnnounce(22686, 1)

local timerFearCD	= mod:NewCDTimer(15, 22686)  -- cooldown ??
local timerSlash	= mod:NewTargetTimer(10, 48873)
local timerSlashCD	= mod:NewCDTimer(18, 48873)

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 22686 and args.sourceGUID == 27483 then
		warningFear:Show(args.spellName)
		timerFear:Start(args.spellName)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 48920 then
		warningBite:Show(args.destName)
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