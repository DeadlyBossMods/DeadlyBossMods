local mod = DBM:NewMod("SkadiTheRuthless", "DBM-Party-WotLK", 11)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(26693)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START"
)

local warningPoison		= mod:NewTargetAnnounce(59331, 2)
local warningWhirlwind	= mod:NewSpellAnnounce(59322, 3)
local timerPoison		= mod:NewTargetTimer(12, 59331)
local timerWhirlwindCD	= mod:NewCDTimer(30, 59322)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 59331 or args.spellId == 50255 then
		warningPoison:Show(args.spellName, args.destName)
		timerPoison:Start(args.spellName, args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 59331 or args.spellId == 50255 then
		timerPoison:Cancel(args.spellName, args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 59322 or args.spellId == 50228 then
		warningWhirlwind:Show(args.spellName)
		timerWhirlwindCD:Start(args.spellName)
	end
end