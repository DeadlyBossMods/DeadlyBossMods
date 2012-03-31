local mod	= DBM:NewMod("Harlan", "DBM-Party-MoP", 8)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(58632)
--mod:SetModelID(40293)--Still need correct modelId, wowhead has no data on this guy yet

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_REMOVED"
)

--All data confirmed and accurate for normal mode scarlet halls. heroic data should be quite similar but with diff spellids, will wait for logs to assume anything there.
local warnDragonsReach			= mod:NewSpellAnnounce(111217, 2)
local warnCallReinforcements	= mod:NewSpellAnnounce(111755, 3)
local warnBladesofLight			= mod:NewCastAnnounce(111216, 4)

local specWarnBladesofLight		= mod:NewSpecialWarningSpell(111216, nil, nil, nil, true)

local timerDragonsReachCD		= mod:NewNextTimer(12, 111217)
local timerCallReinforcementsCD	= mod:NewNextTimer(60, 111755)
local timerBladesofLightCD		= mod:NewNextTimer(30, 111216)

function mod:OnCombatStart(delay)
	timerDragonsReachCD:Start(-delay)
	timerCallReinforcementsCD:Start(20-delay)
	timerBladesofLightCD:Start(40-delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(111217) then
		timerDragonsReachCD:Start()
	elseif args:IsSpellID(111755) then
		timerCallReinforcementsCD:Start()--Can possibly also start this at blades of light cast start since it's typically 29-30 seconds after that, but this may be slightly more accurate
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(111216) then
		timerDragonsReachCD:Cancel()
		warnBladesofLight:Show()
		specWarnBladesofLight:Show()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(111216) then
		timerDragonsReachCD:Start()
		timerBladesofLightCD:Start()
	end
end
