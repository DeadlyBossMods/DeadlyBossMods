local mod	= DBM:NewMod(654, "DBM-Party-MoP", 8, 311)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(58632)
mod:SetModelID(40293)

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

local timerDragonsReachCD		= mod:NewCDTimer(7, 111217)--12 on normal, 7 on heroic, OR, 7 in both and it was buffed on normal since i've run it. For time being i'll make it 7 but change it from next to CD
local timerCallReinforcementsCD	= mod:NewNextTimer(60, 111755)--No longer shows in combat log in recent builds, probalby needs redoing with transcriptor :\
local timerBladesofLightCD		= mod:NewNextTimer(30, 111216)

function mod:OnCombatStart(delay)
	timerDragonsReachCD:Start(-delay)
	timerCallReinforcementsCD:Start(20-delay)--Assumed still valid, unknown now that it no longer shows in CLEU
	timerBladesofLightCD:Start(40-delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(111217) then
		timerDragonsReachCD:Start()
	elseif args:IsSpellID(111755) then
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(111216) then
		timerDragonsReachCD:Cancel()
		warnBladesofLight:Show()
		specWarnBladesofLight:Show()
		timerCallReinforcementsCD:Start(30)--Moved here since cast trigger is no longer working. This won't be as accurate but close enough.
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(111216) then
		timerBladesofLightCD:Start()
	end
end
