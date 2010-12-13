local mod	= DBM:NewMod("AlAkir", "DBM-ThroneFourWinds", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(46753)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START"
)

local warnWindBurst		= mod:NewSpellAnnounce(87770, 3)

local timerWindBurst		= mod:NewCastTimer(5, 87770)
local timerWindBurstCD		= mod:NewCDTimer(25, 87770)		-- need more logs for confirmation

function mod:OnCombatStart(delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(87770, 93261, 93262, 93263) then
		warnWindBurst:Show()
		if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
			timerWindBurst:Start(4)--4 second cd on heroic according to wowhead.
		else
			timerWindBurst:Start()
		end
		timerWindBurstCD:Start()
	end
end