local mod	= DBM:NewMod(1235, "DBM-Party-WoD", 4, 558)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(81297, 81305)
mod:SetEncounterID(1749)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 164426 164835",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local warnBurningArrows					= mod:NewSpellAnnounce(164635, 3)
local warnRecklessProvocation			= mod:NewTargetAnnounce(164426, 3)
local warnEnrage						= mod:NewSpellAnnounce(164835, 3, nil, mod:CanRemoveEnrage() or mod:IsTank())


local specWarnBurningArrows				= mod:NewSpecialWarningSpell(164635, nil, nil, nil, true)
local specWarnRecklessProvocation		= mod:NewSpecialWarningReflect(164426)
local specWarnEnrage					= mod:NewSpecialWarningDispel(164835, mod:CanRemoveEnrage())

local timerBurningArrowsCD				= mod:NewNextTimer(25, 164635)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 164426 then
		warnRecklessProvocation:Show(args.destName)
		specWarnRecklessProvocation:Show(args.destName)
	elseif args.spellId == 164835 and args:GetSrcCreatureID() == 81297 then
		warnEnrage:Show()
		specWarnEnrage:Show(args.destName)
	end
end

--Not detectable in phase 1. Seems only cleanly detectable in phase 2, in phase 1 boss has no "boss" unitid so cast hidden.
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 164635 then
		warnBurningArrows:Show()
		specWarnBurningArrows:Show()
		timerBurningArrowsCD:Start()
	end
end