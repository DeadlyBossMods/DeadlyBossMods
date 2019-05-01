local mod	= DBM:NewMod("CrucibleofStormsTrash", "DBM-CrucibleofStorms")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(47785)
mod:SetZone()
mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 293957"
)

local specWarnMaddeningGaze				= mod:NewSpecialWarningDodge(293957, nil, nil, nil, 2, 2)

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 293957 then
		specWarnMaddeningGaze:Show()
		specWarnMaddeningGaze:Play("shockwave")
	end
end
