local mod	= DBM:NewMod(668, "DBM-Party-MoP", 2, 302)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(56637)
mod:SetEncounterID(1412)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_CAST_START"
)


local warnGroundPound		= mod:NewSpellAnnounce(106807, 3)
local warnBananas			= mod:NewStackAnnounce(106651, 2)

local specWarnGroundPound	= mod:NewSpecialWarningMove(106807, mod:IsTank())

local timerGroundPoundCD	= mod:NewCDTimer(10.5, 106807)

function mod:OnCombatStart(delay)
--	timerGroundPoundCD:Start(-delay)--No accurate start time yet, i think he does it on engage though instantly so may be irrelevent.
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 106651 then
		warnBananas:Show(args.destName, args.amount or 1)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

--[[
Pound timings, At first i thought 13 13 10 13 13 10, etc but it doesn't fit that later on.
I'd like more data to decide on if it has pattern
13.4
14.4
10.8
13.2
13.3
10.7
12.1
12
12.1
--]]
function mod:SPELL_CAST_START(args)
	if args.spellId == 106807 then
		warnGroundPound:Show()
		specWarnGroundPound:Show()
		timerGroundPoundCD:Start()
	end
end
