local mod	= DBM:NewMod("TazaveshTrash", "DBM-Party-Shadowlands", 9)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(47785)

mod.isTrashMod = true

mod:RegisterEvents(
--	"SPELL_CAST_START",
--	"SPELL_AURA_APPLIED",
--	"SPELL_AURA_APPLIED_DOSE",
--	"SPELL_AURA_REMOVED"
)

--local warnClingingDarkness					= mod:NewTargetNoFilterAnnounce(323347, 3, nil, "Healer|RemoveMagic")

--General
--local specWarnGTFO						= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)
--local specWarnNecroticBolt				= mod:NewSpecialWarningInterrupt(320462, "HasInterrupt", nil, nil, 1, 2)
--local specWarnSharedAgony					= mod:NewSpecialWarningMoveAway(327401, nil, nil, nil, 1, 11)
--local yellSharedAgony						= mod:NewYell(327401)
--local specWarnDarkShroud					= mod:NewSpecialWarningDispel(335141, "MagicDispeller", nil, nil, 1, 2)
--local specWarnGoresplatterDispel			= mod:NewSpecialWarningDispel(338353, "RemoveDisease", nil, nil, 1, 2)

--Antispam IDs for this mod: 1 run away, 2 dodge, 3 dispel, 4 incoming damage, 5 you/role, 6 misc

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 324293 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
--		specWarnRaspingScream:Show(args.sourceName)
--		specWarnRaspingScream:Play("kickcast")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 327401 then

	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
