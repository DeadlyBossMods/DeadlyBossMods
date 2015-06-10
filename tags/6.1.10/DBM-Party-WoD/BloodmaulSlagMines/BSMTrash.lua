local mod	= DBM:NewMod("BSMTrash", "DBM-Party-WoD", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_AURA_APPLIED 164597 151548 151697 151965 151558 151581",
	"SPELL_CAST_START 152298 151447 151545"
)

local specWarnCrush						= mod:NewSpecialWarningDodge(151447, "Tank")
local specWarnCinderSplash				= mod:NewSpecialWarningSpell(152298, nil, nil, nil, 2)
local specWarnRoar						= mod:NewSpecialWarningInterrupt(151545, "-Healer")--Maybe healer need warning too, if interrupt gets off, healer can't heal for 5 seconds
local specWarnLavaBurst					= mod:NewSpecialWarningInterrupt(151558, "-Healer")
local specWarnSuppressionField			= mod:NewSpecialWarningInterrupt(151581, "-Healer")--Maybe healer need warning too, if interrupt gets off, healer can't heal for 5 seconds
local specWarnStoneBulwark				= mod:NewSpecialWarningDispel(164597, "MagicDispeller")
local specWarnBloodRage					= mod:NewSpecialWarningDispel(151548, "MagicDispeller")
local specWarnSubjugate					= mod:NewSpecialWarningDispel(151697, "Healer")
local specWarnSlaversRage				= mod:NewSpecialWarningDispel(151965, "RemoveEnrage")

mod:RemoveOption("HealthFrame")

local UnitExists, UnitGUID, UnitAffectingCombat = UnitExists, UnitGUID, UnitAffectingCombat
local function validWarning(GUID)
	for uId in DBM:GetGroupMembers() do
		local target = uId.."target"
		if UnitExists(target) and UnitGUID(target) == GUID and UnitAffectingCombat(target) then return true end
	end
	return false
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled or self:IsDifficulty("normal5") then return end
	local spellId = args.spellId
	if spellId == 164597 and not args:IsDestTypePlayer() then
		specWarnStoneBulwark:Show(args.destName)
	elseif spellId == 151548 and not args:IsDestTypePlayer() and validWarning(args.sourceGUID) then--Antispam
		specWarnBloodRage:Show(args.destName)
	elseif spellId == 151697 then
		specWarnSubjugate:Show(args.destName)
	elseif spellId == 151965 then
		specWarnSlaversRage:Show(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled or self:IsDifficulty("normal5") then return end
	local spellId = args.spellId
	if spellId == 152298 then
		specWarnCinderSplash:Show()
	elseif spellId == 151447 then
		specWarnCrush:Show()
	elseif spellId == 151545 and validWarning(args.sourceGUID) then--Antispam
		specWarnRoar:Show(args.sourceName)
	elseif spellId == 151558 and validWarning(args.sourceGUID) then
		specWarnLavaBurst:Show(args.sourceName)
	elseif spellId == 151581 then
		specWarnSuppressionField:Show(args.sourceName)
	end
end
