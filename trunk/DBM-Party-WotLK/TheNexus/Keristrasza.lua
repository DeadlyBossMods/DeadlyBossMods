local mod = DBM:NewMod("Keristrasza", "DBM-Party-WotLK", 8)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(26723)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_REMOVED"
)

local warningChains		= mod:NewAnnounce("WarningChains", 4, 50997)
local warningNova		= mod:NewAnnounce("WarningNova", 3, 48179)
local warningEnrage		= mod:NewAnnounce("WarningEnrage", 3, 8599)
local timerChains		= mod:NewTimer(10, "TimerChains", 50997)
local timerChainsCD		= mod:NewTimer(25, "TimerChainsCD", 50997)
local timerNova			= mod:NewTimer(10, "TimerNova", 48179)
local timerNovaCD		= mod:NewTimer(25, "TimerNovaCD", 48179)

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 50997 then
		warningChains:Show(args.spellName, args.destName)
		timerChains:Start(args.spellName, args.destName)
		timerChainsCD:Start(args.spellName)
	elseif args.spellId == 8599 and args.souceGUID == 26723 then
		warningEnrage:Show(args.spellName)
	elseif args.spellId == 48179 then
		warningNova:Show(args.spellName)
		timerNova:Start(args.spellName)
		timerNovaCD:Start(args.spellName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 50997 then
		timerChains:Cancel()
	end
end