local mod	= DBM:NewMod("SjonnirTheIronshaper", "DBM-Party-WotLK", 7)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(27978)
mod:SetZone()

mod:RegisterCombat("combat")

local warningCharge		= mod:NewTargetAnnounce(50834, 2)
local warningRing		= mod:NewSpellAnnounce(50840, 3)
local timerCharge		= mod:NewTargetTimer(10, 50834)
local timerChargeCD		= mod:NewCDTimer(25, 50834)
local timerRingCD		= mod:NewCDTimer(25, 50840)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED"
)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(59848, 50840, 59861, 51849) then
		warningRing:Show()
		timerRingCD:Start()
	elseif args:IsSpellID(50834, 59846) then
		warningCharge:Show(args.destName)
		timerCharge:Start(args.destName)
		timerChargeCD:Start()
	end
end
