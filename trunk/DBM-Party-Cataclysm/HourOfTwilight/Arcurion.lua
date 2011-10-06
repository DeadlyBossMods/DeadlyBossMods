local mod	= DBM:NewMod("Arcurion", "DBM-Party-Cataclysm", 14)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(54590)
mod:SetModelID(35978)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS",
	"UNIT_HEALTH"
)

local warnIcyTomb	= mod:NewTargetAnnounce(103252, 4)
local warnChainsFrost	= mod:NewSpellAnnounce(102582, 2)
local prewarnPhase2	= mod:NewPrePhaseAnnounce(2, 3)

local warnedP2 = false
function mod:OnCombatStart(delay)
	warnedP2 = false

-- below timers are from 2 logs
	-- 1st Tomb after [30 or 16] secs	
	-- 1st Chains after [19 or 32] secs
end

--[[ 2nd log timers:
13:40:35.514 (engage)
13:40:54:777 (chains 1)
13:41:05.617 (tomb 1)
13:41:18.855 (chains 2)
13:41:35.706 (chains 3)
13:41:48.972 (tomb 2)
--]]

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(103252) then
		warnIcyTomb:Show(args.destName)
	elseif args:IsSpellID(102582) then
		warnChainsFrost:Show()
	end
end

function mod:UNIT_HEALTH(uId)
	if self:GetUnitCreatureId(uId) == 54590 then
		local h = UnitHealth(uId) / UnitHealthMax(uId) * 100
		if h > 50 and warnedP2 then
			warnedP2 = false
		elseif not warnedP2 and h > 33 and h < 37 then
			warnedP2 = true
			prewarnPhase2:Show()
		end
	end
end