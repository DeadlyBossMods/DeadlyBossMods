local mod	= DBM:NewMod(1214, "DBM-Party-WoD", 5, 556)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(81522)
mod:SetEncounterID(1746)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 164357",
	"SPELL_CAST_SUCCESS 164275 164294",
	"SPELL_PERIODIC_DAMAGE 169495",
	"SPELL_PERIODIC_MISSED 169495",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local warnParchedGrasp			= mod:NewSpellAnnounce(164357, 3, nil, mod:IsTank())
local warnBrittleBark			= mod:NewTargetAnnounce(164275, 2)
local warnUncheckedGrowth		= mod:NewTargetAnnounce(164294, 2, nil, false)--This is debuff after it reaches player, not before. Can't detect before :\

local specWarnLivingLeaves		= mod:NewSpecialWarningMove(169495)
local specWarnParchedGrasp		= mod:NewSpecialWarningSpell(164357, mod:IsTank())
local specWarnBrittleBark		= mod:NewSpecialWarningEnd(164275, false)--Added for sake of adding. Not important enough to be a default though.

local timerParchedGrasp			= mod:NewCDTimer(12, 164357)


function mod:OnCombatStart(delay)
	timerParchedGrasp:Start(7-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 164357 then
		warnParchedGrasp:Show()
		specWarnParchedGrasp:Show()
		timerParchedGrasp:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 164275 then
		warnBrittleBark:Show(args.destName)
		timerParchedGrasp:Cancel()
	elseif spellId == 164294 then
		warnUncheckedGrowth:Show(args.destName)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId)
	if spellId == 169495 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnLivingLeaves:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 164718 then--Cancel Brittle Bark
		specWarnBrittleBark:Show()
	end
end

