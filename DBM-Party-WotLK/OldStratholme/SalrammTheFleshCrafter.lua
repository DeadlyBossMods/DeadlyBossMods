local mod = DBM:NewMod("SalrammTheFleshcrafter", "DBM-Party-WotLK", 3)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(26530)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_SUMMON"
)

local warningCurse	= mod:NewAnnounce("WarningCurse", 1, 58845)
local warningSteal	= mod:NewAnnounce("WarningSteal", 2, 52709)
local warningGhoul	= mod:NewAnnounce("WarningGhoul", 3, 52451)
local timerGhoulCD	= mod:NewTimer(20, "TimerGhoulCD", 52451)
local timerCurse	= mod:NewTimer(30, "TimerCurse", 58845)

function mod:SPELL_SUMMON(args)
	if args.spellId == 52451 then
		warningGhoul:Show(args.spellName)
		timerGhoulCD:Start(args.spellName)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 58845 then
		warningCurse:Show(args.spellName, args.destName)
		timerCurse:Start(args.spellName, args.destName)
	elseif args.spellId == 52709 then
		wagningSteal:Show(args.spellName, args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 58845 then
		timerCurse:Cancel()
	end
end