local mod = DBM:NewMod("Taldaram", "DBM-Party-WotLK", 1)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(29308)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warningEmbrace	= mod:NewTargetAnnounce(55959, 2)
local warningFlame		= mod:NewSpellAnnounce(55931, 3)

local timerEmbrace		= mod:NewTargetTimer(20, 55959)
local timerFlameCD		= mod:NewCDTimer(17, 55959)


function mod:SPELL_CAST_START(args)
	if args.spellId	== 55931 then
		warningFlame:Show()
		timerFlameCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 55959 or args.spellId == 59513 then
		warningEmbrace:Show(args.destName)
		timerEmbrace:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 55959 or args.spellId == 59513 then
		timerEmbrace:Cancel()
	end
end