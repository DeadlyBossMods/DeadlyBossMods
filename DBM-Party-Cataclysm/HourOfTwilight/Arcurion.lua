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

-- below timers are from 1 log I got (also the abilities only happened once only)
	-- 1st Tomb after 16 secs? (or HP based?)
	-- 1st Chains after 32 secs?
end

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