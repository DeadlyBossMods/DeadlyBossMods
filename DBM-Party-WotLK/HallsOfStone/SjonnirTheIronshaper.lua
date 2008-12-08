local mod = DBM:NewMod("SjonnirTheIronshaper", "DBM-Party-WotLK", 7)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(27978)
mod:SetZone()

mod:RegisterCombat("combat")

local warningCharge	= mod:NewAnnounce("WarningCharge", 2, 50834)
local warningRing	= mod:NewAnnounce("WarningRing", 3, 50840)
local timerCharge	= mod:NewTimer(10, "TimerCharge", 50834)
local timerChargeCD	= mod:NewTimer(25, "TimerChargeCD", 50834)
local timerRingCD	= mod:NewTimer(25, "TimerRingCD", 50840)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED"
)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 59848 or args.spellId == 50840
	or args.spellId == 59861 or args.spellId == 51849 then
		warningRing:Show(args.spellName)
		timerRingCD:Start(args.spellName)
	elseif args.spellId == 50834 or args.spellId == 59846 then
		warningCharge:Show(args.spellName, args.destName)
		timerCharge:Start(args.spellName, args.destName)
		timerChargeCD:Start(args.spellName)
	end
end
