local mod	= DBM:NewMod("Moorabi", "DBM-Party-WotLK", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(29305)
--mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"UNIT_HEALTH"
)

local warningTransform	= mod:NewSpellAnnounce(55098, 3)
local timerTransform	= mod:NewCDTimer(10, 55098)--experimental

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(55098) then
		warningTransform:Show()
		if self:GetUnitCreatureId(uId) == 29305 and UnitHealth(uId) / UnitHealthMax(uId) >= 0.50 then
			timerTransform:Start()--cast every 10 seconds above 50% health
		elseif self:GetUnitCreatureId(uId) == 29305 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.49 then
			timerTransform:Start(5)--cast every 5 seconds below 50% health
		end
	end
end