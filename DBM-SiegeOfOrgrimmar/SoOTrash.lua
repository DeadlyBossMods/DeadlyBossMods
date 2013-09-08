local mod	= DBM:NewMod("SoOTrash", "DBM-SiegeOfOrgrimmar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	--"SPELL_CAST_START",
	--"UNIT_SPELLCAST_SUCCEEDED",
	"SPELL_AURA_APPLIED"
)

local warnLockedOn			= mod:NewTargetAnnounce(143828, 3)

local specWarnLockedOn		= mod:NewSpecialWarningRun(143828)

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")
--mod:AddBoolOption("RangeFrame")

function mod:SPELL_AURA_APPLIED(args)
	if not mod.Options.Enabled then return end
	if args.spellId == 143828 then
		warnLockedOn:Show()
		if args:IsPlayer() then
			specWarnLockedOn:Show()
		end
	end
end
--[[
function mod:SPELL_CAST_START(args)
	if not mod.Options.Enabled then return end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if not mod.Options.Enabled then return end
end
--]]