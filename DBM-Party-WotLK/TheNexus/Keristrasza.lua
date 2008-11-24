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
local warningEnrage		= mod:NewAnnounce("WarningEnrage", 3, 8599)

local timerChains		= mod:NewTimer(10, "TimerChains", 50997)

function mod:SPELL_CAST_SUCCESS(args)
	-- please check this! enrage shows up in other instances too, so I limited this to the boss itself (hopefull)
	if args.spellId == 50997 and args.sourceGUID == 26723 then
		warningChains:Show(tostring(args.destName))
		timerChains:Start(10, tostring(args.destName))
	elseif args.spellId == 8599 args.sourceGUID == 26723 then
		warningEnrage:Show()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 50997 then
		timerChains:Stop(tostring(args.destName))
	end
end
