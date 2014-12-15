local mod	= DBM:NewMod(1235, "DBM-Party-WoD", 4, 558)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(81297, 81305)
mod:SetEncounterID(1749)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 164426 164835 164632",
	"SPELL_AURA_REMOVED 164426",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"UNIT_TARGETABLE_CHANGED"
)

local warnNokgar						= mod:NewSpellAnnounce("ej10433", 3, "Interface\\ICONS\\INV_Misc_Head_Orc_01.blp")
local warnBurningArrows					= mod:NewSpellAnnounce(164635, 3)
local warnRecklessProvocation			= mod:NewTargetAnnounce(164426, 3)
local warnEnrage						= mod:NewSpellAnnounce(164835, 3, nil, mod:CanRemoveEnrage() or mod:IsTank())

local specWarnBurningArrows				= mod:NewSpecialWarningSpell(164635, nil, nil, nil, true)
local specWarnBurningArrowsMove			= mod:NewSpecialWarningMove(164635)
local specWarnRecklessProvocation		= mod:NewSpecialWarningReflect(164426)
local specWarnRecklessProvocationEnd	= mod:NewSpecialWarningEnd(164426)
local specWarnEnrage					= mod:NewSpecialWarningDispel(164835, mod:CanRemoveEnrage())

local timerRecklessProvocation			= mod:NewBuffActiveTimer(5, 164426)
--local timerBurningArrowsCD				= mod:NewNextTimer(25, 164635)--25~42 variable (patterned?)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 164426 then
		warnRecklessProvocation:Show(args.destName)
		specWarnRecklessProvocation:Show(args.destName)
		timerRecklessProvocation:Start()
	elseif args.spellId == 164835 and args:GetSrcCreatureID() == 81297 then
		warnEnrage:Show()
		specWarnEnrage:Show(args.destName)
	elseif args.spellId == 164632 and args:IsPlayer() and self:AntiSpam(2) then
		specWarnBurningArrowsMove:Show()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 164426 then
		specWarnRecklessProvocationEnd:Show()
	end
end

--Not detectable in phase 1. Seems only cleanly detectable in phase 2, in phase 1 boss has no "boss" unitid so cast hidden.
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 164635 then
		warnBurningArrows:Show()
		specWarnBurningArrows:Show()
		--timerBurningArrowsCD:Start()
	end
end

function mod:UNIT_TARGETABLE_CHANGED()
	warnNokgar:Show()
	if DBM.BossHealth:IsShown() then
		DBM.BossHealth:AddBoss(81305)
	end
end
