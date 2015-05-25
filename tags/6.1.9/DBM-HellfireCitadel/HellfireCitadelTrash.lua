local mod	= DBM:NewMod("HellfireCitadelTrash", "DBM-HellfireCitadel")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()
mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED"
)
--[[
local warnLivingBlaze				= mod:NewTargetAnnounce(175583, 3, nil, false)

local specWarnOverheadSmash			= mod:NewSpecialWarningTaunt(175765)
local yellLivingBlaze				= mod:NewYell(175583)

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")


function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 156446 then
		
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 175583 then

		if args:IsPlayer() then

			if not self:IsLFR() then

			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 159750 then
		
	end
end--]]