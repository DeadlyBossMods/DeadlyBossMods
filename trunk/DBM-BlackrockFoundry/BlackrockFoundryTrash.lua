local mod	= DBM:NewMod("BlackrockFoundryTrash", "DBM-BlackrockFoundry")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 11326 $"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 156446"
)

local specWarnBlastWave				= mod:NewSpecialWarningMoveTo(156446, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format(156446))

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

local volcanicBomb = GetSpellInfo(156413)

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 156446 then
		specWarnBlastWave:Show(volcanicBomb)
	end
end
