local mod	= DBM:NewMod(1160, "DBM-Party-WoD", 6, 537)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(58632)
mod:SetEncounterID(1682)

mod:RegisterCombat("combat")
--[[
mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_REMOVED",
	"RAID_BOSS_EMOTE"
)

--All data confirmed and accurate for normal mode scarlet halls. heroic data should be quite similar but with diff spellids, will wait for logs to assume anything there.
local warnDragonsReach			= mod:NewSpellAnnounce(111217, 2)
local warnCallReinforcements	= mod:NewSpellAnnounce("ej5378", 3)--triggers only found in emote
local warnBladesofLight			= mod:NewCastAnnounce(111216, 4)

local specWarnBladesofLight		= mod:NewSpecialWarningSpell(111216, nil, nil, nil, true)

local timerDragonsReachCD		= mod:NewCDTimer(7, 111217)--12 on normal, 7 on heroic, OR, 7 in both and it was buffed on normal since i've run it. For time being i'll make it 7 but change it from next to CD
local timerCallReinforcementsCD	= mod:NewCDTimer(20, "ej5378")--adjusted in build 15799?
local timerBladesofLightCD		= mod:NewNextTimer(30, 111216)

function mod:OnCombatStart(delay)
	timerDragonsReachCD:Start(-delay)
	timerCallReinforcementsCD:Start(-delay)
	timerBladesofLightCD:Start(40-delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 111217 then
		warnDragonsReach:Show()
		timerDragonsReachCD:Start()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 111216 then
		warnBladesofLight:Show()
		specWarnBladesofLight:Show()
		timerDragonsReachCD:Cancel()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 111216 then
		timerBladesofLightCD:Start()
	end
end

function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.Call or msg:find(L.Call) then
		warnCallReinforcements:Show()
		timerCallReinforcementsCD:Start()
	end
end--]]
