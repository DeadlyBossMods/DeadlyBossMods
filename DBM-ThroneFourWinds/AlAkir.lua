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
	if args:IsSpellID(87770) then
		warnWindBurst:Show()
		timerWindBurst:Start()
		timerWindBurstCD:Start()
	end
end