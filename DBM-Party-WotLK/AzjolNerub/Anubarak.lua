local mod = DBM:NewMod("Anubarak", "DBM-Party-WotLK", 2)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(29120)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"UNIT_HEALTH"
)

local warningBurrowSoon		= mod:NewAnnounce("WarningBurrowSoon", 3, 56504)
local warningBurrowNow		= mod:NewAnnounce("WarningBurrowNow", 3, 56504)
local warningEmerge		= mod:NewAnnounce("WarningEmerge", 3, 56504)

local timerEmerge		= mod:NewTimer(60, "Emerge", 56504)
local warnburrow

function mod:OnCombatStart()
	warnburrow = 0
end

function mod:UNIT_HEALTH(arg1)
	if UnitName(arg1) == L.name then
		local h = UnitHealth(arg1)
		if (h > 66 and h < 71) or (h > 33 and h < 38) or (h > 15 and h < 20) then
			if not warnburrow then
				warnburrow = 1
				warningBurrowSoon:Show()
			end
		else
			warnburrow = 0
		end
	end
end