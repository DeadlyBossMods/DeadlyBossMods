local mod	= DBM:NewMod("MechagonTrash", "DBM-Party-BfA", 11)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
--	"SPELL_CAST_START",
--	"SPELL_AURA_APPLIED"
--	"SPELL_CAST_SUCCESS"
)

--local warnRiotShield				= mod:NewSpellAnnounce(258317, 4)

--local yellArrowBarrage				= mod:NewYell(200343)
--local specWarnLockdown				= mod:NewSpecialWarningDodge(259711, nil, nil, nil, 2, 2)
--local specWarnRiotShieldMove		= mod:NewSpecialWarningMove(258317, nil, nil, nil, 1, 2)
--local specWarnHeavilyArmed			= mod:NewSpecialWarningRun(259188, "Tank", nil, nil, 4, 2)
--local specWarnDebilitatingShout		= mod:NewSpecialWarningInterrupt(258128, "HasInterrupt", nil, nil, 1, 2)
--local specWarnWateryDome			= mod:NewSpecialWarningDispel(258153, "MagicDispeller", nil, nil, 1, 2)
--local specWarnTorchStrike			= mod:NewSpecialWarningDispel(265889, "Healer", nil, nil, 1, 2)
--local specWarnRiotShield			= mod:NewSpecialWarningReflect(258317, "CasterDps", nil, nil, 1, 2)

--[[
function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 259711 and self:IsValidWarning(args.sourceGUID) and self:AntiSpam(3, 6) then

	elseif spellId == 258153 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnHandcuff:Show(args.sourceName)
		specWarnHandcuff:Play("kickcast")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 258153 and not args:IsDestTypePlayer() and self:AntiSpam(5, 1) then

	spellId == 265889 and args:IsDestTypePlayer() and self:CheckDispelFilter() and self:AntiSpam(5, 2) then

	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 200343 then

	end
end
--]]
